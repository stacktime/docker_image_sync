imagePrefix=$1

# 读取文件
imageAndTagList=$(cat images.txt)
# 循环处理
for imageAndTag in $imageAndTagList ; do
  echo "the image need to sync is : [$imageAndTag]"
  # docker pull
  docker pull "$imageAndTag"
	# 获取完整的镜像名
	imageAndTagFormatName=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep "$imageAndTag")
	echo "Full image name is: [$imageAndTagFormatName]"
	# 删掉最后一个/及其左边的字符串 eg: docker.io/dominate/idea-license-server:1.5 -> idea-license-server:1.5
	imageTag=${imageAndTagFormatName##*/}
	echo "imageTag is: [$imageTag]"
  # docker tag
  docker tag "$imageAndTag" "$imagePrefix/$imageTag"
  # docker pull
  docker push "$imagePrefix/$imageTag"
done