Received: from eggs.gnu.org ([2001:4830:134:3::10]:34090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYZ1T-0005KN-SH
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYZ1S-0006nb-VX
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:39:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 28 Jun 2018 17:39:35 +0200
Message-Id: <20180628153937.26097-2-kwolf@redhat.com>
In-Reply-To: <20180628153937.26097-1-kwolf@redhat.com>
References: <20180628153937.26097-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu-iotests: Update 026.out.nocache
 reference output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

Commit abf754fe406 updated 026.out, but forgot to also update
026.out.nocache.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/026.out.nocache | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index ea2e166a4e..650ccd8b01 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -541,7 +541,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-11 leaked clusters were found on the image.
+10 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -569,7 +569,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-11 leaked clusters were found on the image.
+10 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -597,7 +597,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-11 leaked clusters were found on the image.
+10 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
-- 
2.13.6
