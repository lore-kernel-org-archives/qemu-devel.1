Received: from eggs.gnu.org ([2001:4830:134:3::10]:55413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot6-0006s4-EG
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot5-0006dv-Mk
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Apr 2018 18:33:56 +0200
Message-Id: <20180403163400.6307-6-kwolf@redhat.com>
In-Reply-To: <20180403163400.6307-1-kwolf@redhat.com>
References: <20180403163400.6307-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] iotests: fix 208 for luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Support luks images creatins like in 205

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/208 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 4e82b96c82..18f59ada94 100755
--- a/tests/qemu-iotests/208
+++ b/tests/qemu-iotests/208
@@ -28,7 +28,7 @@ with iotests.FilePath('disk.img') as disk_img_path, \
      iotests.VM() as vm:
 
     img_size = '10M'
-    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, disk_img_path, img_size)
+    iotests.qemu_img_create('-f', iotests.imgfmt, disk_img_path, img_size)
 
     iotests.log('Launching VM...')
     (vm.add_drive(disk_img_path, 'node-name=drive0-node', interface='none')
-- 
2.13.6
