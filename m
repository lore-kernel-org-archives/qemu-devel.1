Received: from eggs.gnu.org ([2001:4830:134:3::10]:51714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5vLS-0002RZ-Df
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5vLR-0006Fy-HE
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:38:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Apr 2018 17:37:45 +0200
Message-Id: <20180410153748.22505-5-kwolf@redhat.com>
In-Reply-To: <20180410153748.22505-1-kwolf@redhat.com>
References: <20180410153748.22505-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] iotests: blacklist bochs and cloop for 205
 and 208
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

Blacklist these formats, as they don't support image creation, as they
say:
    > ./qemu-img create -f bochs x 1m
    qemu-img: x: Format driver 'bochs' does not support image creation

    > ./qemu-img create -f cloop x 1m
    qemu-img: x: Format driver 'cloop' does not support image creation

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/205 | 2 +-
 tests/qemu-iotests/208 | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index e7b2eae51d..31b2f5707a 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -153,4 +153,4 @@ class TestNbdServerRemove(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main()
+    iotests.main(supported_fmts=['generic'])
diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 18f59ada94..1e202388dc 100755
--- a/tests/qemu-iotests/208
+++ b/tests/qemu-iotests/208
@@ -22,6 +22,8 @@
 
 import iotests
 
+iotests.verify_image_format(supported_fmts=['generic'])
+
 with iotests.FilePath('disk.img') as disk_img_path, \
      iotests.FilePath('disk-snapshot.img') as disk_snapshot_img_path, \
      iotests.FilePath('nbd.sock') as nbd_sock_path, \
-- 
2.13.6
