Received: from eggs.gnu.org ([2001:4830:134:3::10]:54732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRk-0000Kl-E7
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRg-0005Tv-5C
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:25 +0200
Message-Id: <20170801144632.3831-9-kwolf@redhat.com>
In-Reply-To: <20170801144632.3831-1-kwolf@redhat.com>
References: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/15] qemu-iotests/041: Fix leaked scratch
 images
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

qemu-iotests 041 left quorum_snapshot.img and target.img behind in the
scratch directory. Make sure to clean up after completing the tests.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/041 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 4cda540735..a860a31e9a 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -418,6 +418,7 @@ new_state = "1"
     def tearDown(self):
         self.vm.shutdown()
         os.remove(test_img)
+        os.remove(target_img)
         os.remove(backing_img)
         os.remove(self.blkdebug_file)
 
@@ -568,6 +569,7 @@ new_state = "1"
     def tearDown(self):
         self.vm.shutdown()
         os.remove(test_img)
+        os.remove(target_img)
         os.remove(backing_img)
         os.remove(self.blkdebug_file)
 
@@ -821,7 +823,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        for i in self.IMAGES + [ quorum_repair_img ]:
+        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file ]:
             # Do a try/except because the test may have deleted some images
             try:
                 os.remove(i)
-- 
2.13.3
