Received: from eggs.gnu.org ([2001:4830:134:3::10]:56846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vGV-0007MR-Q7
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 10:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vGT-0007ZT-2h
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 10:44:27 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Mar 2018 17:44:12 +0300
Message-Id: <1522421052-8657-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for 2.12] iotests: fix 208 for luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com

Support luks images creatins like in 205

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/208 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 4e82b96..18f59ad 100755
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
2.7.4
