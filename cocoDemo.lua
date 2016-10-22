-- Demo for the CocoApi (see CocoApi.lua)
coco = require 'coco'
image = require 'image'

-- initialize COCO api (please specify dataType/annType below)
annTypes = { 'instances', 'captions', 'person_keypoints' }
dataType, annType = 'val2014', annTypes[1]; -- specify dataType/annType
-- '../annotations/'..annType..'_'..dataType..'.json'
annFile = '/home/liuxinyao/dataset/coco/2014/annotations/instances_val2014.json'
cocoApi=coco.CocoApi(annFile)

-- get all image ids, select one at random
imgIds = cocoApi:getImgIds()
imgId = imgIds[torch.random(imgIds:numel())]

-- load image
--'../images/'..dataType..'/'
img = cocoApi:loadImgs(imgId)[1]
I = image.load('/home/liuxinyao/dataset/coco/2014/images/'..dataType..'/'..img.file_name,3)

-- load and display instance annotations
annIds = cocoApi:getAnnIds({imgId=imgId})
anns = cocoApi:loadAnns(annIds)
J = cocoApi:showAnns(I,anns)
image.save('RES_'..img.file_name,J:double())
