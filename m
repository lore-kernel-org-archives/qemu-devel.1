Received: from eggs.gnu.org ([2001:4830:134:3::10]:49730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Z-00042i-Pm
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Y-0004AL-7A
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:45 +0200
Message-Id: <20180629140959.6690-16-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 15/29] qemu-iotests: Update 026.out.nocache
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Commit abf754fe406 updated 026.out, but forgot to also update
026.out.nocache.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
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
