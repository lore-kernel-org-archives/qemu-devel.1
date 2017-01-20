Received: from eggs.gnu.org ([2001:4830:134:3::10]:43370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUTYG-0006Ca-9P
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUTYF-0000Bh-G8
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:24:00 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 20 Jan 2017 15:23:01 +0800
Message-Id: <20170120072310.8009-8-famz@redhat.com>
In-Reply-To: <20170120072310.8009-1-famz@redhat.com>
References: <20170120072310.8009-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 07/16] iotests: 030: Read-only open image
 for getting map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, eblake@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/030 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 54db54a..fe0c73f 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -114,7 +114,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # The image map is empty before the operation
-        empty_map = qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img)
+        empty_map = qemu_io('-f', iotests.imgfmt, '-c', 'map', '-r', test_img)
 
         # This is a no-op: no data should ever be copied from the base image
         result = self.vm.qmp('block-stream', device='drive0', base=mid_img)
@@ -125,7 +125,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img),
+        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', '-r', test_img),
                          empty_map, 'image file map changed after a no-op')
 
     def test_stream_partial(self):
-- 
2.9.3
