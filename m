Received: from eggs.gnu.org ([2001:4830:134:3::10]:59940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMa-00043U-FV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMZ-0006Tm-GO
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:23:01 +0100
Message-Id: <1487006583-24350-40-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 39/41] tests: Remove FIXME comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Not requesting any permissions is actually correct for these test cases
because no actual I/O or other operation covered by the permission
system is performed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-blockjob.c | 2 +-
 tests/test-throttle.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 1afe17b..740e740 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -54,7 +54,7 @@ static BlockJob *do_test_id(BlockBackend *blk, const char *id,
  * BlockDriverState inserted. */
 static BlockBackend *create_blk(const char *name)
 {
-    /* FIXME Use real permissions */
+    /* No I/O is performed on this device */
     BlockBackend *blk = blk_new(0, BLK_PERM_ALL);
     BlockDriverState *bs;
 
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 5846433..bd7c501 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -593,7 +593,7 @@ static void test_groups(void)
     BlockBackend *blk1, *blk2, *blk3;
     BlockBackendPublic *blkp1, *blkp2, *blkp3;
 
-    /* FIXME Use real permissions */
+    /* No actual I/O is performed on these devices */
     blk1 = blk_new(0, BLK_PERM_ALL);
     blk2 = blk_new(0, BLK_PERM_ALL);
     blk3 = blk_new(0, BLK_PERM_ALL);
-- 
1.8.3.1
