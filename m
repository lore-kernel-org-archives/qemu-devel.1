Received: from eggs.gnu.org ([2001:4830:134:3::10]:37036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCtTL-0002S4-KE
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 15:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCtTK-0003r7-S1
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 15:30:47 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Nov 2017 21:30:22 +0100
Message-Id: <20171109203025.27493-3-mreitz@redhat.com>
In-Reply-To: <20171109203025.27493-1-mreitz@redhat.com>
References: <20171109203025.27493-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] iotests: Add missing 'blkdebug::' in 040
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

040 tries to invoke pause_drive() on a drive that does not use blkdebug.
Good idea, but let's use blkdebug to make it actually work.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/040 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index c284d08796..90b5b4f2ad 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -289,7 +289,7 @@ class TestSetSpeed(ImageCommitTestCase):
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 0 512', test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', mid_img)
-        self.vm = iotests.VM().add_drive(test_img)
+        self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
         self.vm.launch()
 
     def tearDown(self):
-- 
2.13.6
