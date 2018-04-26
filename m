Received: from eggs.gnu.org ([2001:4830:134:3::10]:43099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd7-0003EA-Pe
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd5-0000fJ-Mw
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:21 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:47 +0300
Message-Id: <20180426161958.2872-7-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 06/17] iotest 055: skip unsupported backup
 target formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 tests/qemu-iotests/055 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 3437c11507..3a47aaa886 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -490,11 +490,15 @@ class TestDriveCompression(iotests.QMPTestCase):
 
     def test_complete_compress_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
+            if not iotests.supports_format(format['type']):
+                continue
             self.do_test_compress_complete('drive-backup', format, False,
                                            target=blockdev_target_img, mode='existing')
 
     def test_complete_compress_blockdev_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
+            if not iotests.supports_format(format['type']):
+                continue
             self.do_test_compress_complete('blockdev-backup', format, True,
                                            target='drive1')
 
@@ -514,11 +518,15 @@ class TestDriveCompression(iotests.QMPTestCase):
 
     def test_compress_cancel_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
+            if not iotests.supports_format(format['type']):
+                continue
             self.do_test_compress_cancel('drive-backup', format, False,
                                          target=blockdev_target_img, mode='existing')
 
     def test_compress_cancel_blockdev_backup(self):
        for format in TestDriveCompression.fmt_supports_compression:
+            if not iotests.supports_format(format['type']):
+                continue
             self.do_test_compress_cancel('blockdev-backup', format, True,
                                          target='drive1')
 
@@ -554,11 +562,15 @@ class TestDriveCompression(iotests.QMPTestCase):
 
     def test_compress_pause_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
+            if not iotests.supports_format(format['type']):
+                continue
             self.do_test_compress_pause('drive-backup', format, False,
                                         target=blockdev_target_img, mode='existing')
 
     def test_compress_pause_blockdev_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
+            if not iotests.supports_format(format['type']):
+                continue
             self.do_test_compress_pause('blockdev-backup', format, True,
                                         target='drive1')
 
-- 
2.14.3
