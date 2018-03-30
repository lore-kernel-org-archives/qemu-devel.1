Received: from eggs.gnu.org ([2001:4830:134:3::10]:41029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vlt-0005Up-MP
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vlr-0006RS-C8
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:16:53 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Mar 2018 18:16:36 +0300
Message-Id: <1522422996-14235-4-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
References: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] iotests: blacklist bochs and cloop for 205
 and 208
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Blacklist these formats, as they don't support image creation, as they
say:
    > ./qemu-img create -f bochs x 1m
    qemu-img: x: Format driver 'bochs' does not support image creation

    > ./qemu-img create -f cloop x 1m
    qemu-img: x: Format driver 'cloop' does not support image creation

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/205 | 2 +-
 tests/qemu-iotests/208 | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index e7b2eae..c41b929 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -153,4 +153,4 @@ class TestNbdServerRemove(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main()
+    iotests.main(unsupported_fmts=['bochs', 'cloop'])
diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 18f59ad..3bbfc9d 100755
--- a/tests/qemu-iotests/208
+++ b/tests/qemu-iotests/208
@@ -22,6 +22,8 @@
 
 import iotests
 
+iotests.verify_image_format(unsupported_fmts=['bochs', 'cloop'])
+
 with iotests.FilePath('disk.img') as disk_img_path, \
      iotests.FilePath('disk-snapshot.img') as disk_snapshot_img_path, \
      iotests.FilePath('nbd.sock') as nbd_sock_path, \
-- 
2.7.4
