Received: from eggs.gnu.org ([2001:4830:134:3::10]:46918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db574-0001XN-Kn
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db573-0007mF-To
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:15:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Jul 2017 15:14:51 +0200
Message-Id: <20170728131452.15316-7-kwolf@redhat.com>
In-Reply-To: <20170728131452.15316-1-kwolf@redhat.com>
References: <20170728131452.15316-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 6/7] qemu-iotests/063: Fix leaked image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

qemu-iotests 063 left t.raw.raw1 behind in the scratch directory because
it used the wrong suffix. Make sure to clean it up after completing the
test.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/063 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index 352e78c778..e4f6ea9385 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -31,7 +31,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_test_img
-	rm -f "$TEST_IMG.orig" "$TEST_IMG.raw" "$TEST_IMG.raw2"
+	rm -f "$TEST_IMG.orig" "$TEST_IMG.raw1" "$TEST_IMG.raw2"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -91,8 +91,6 @@ if $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG.orig" "$TEST_IMG" >/dev
     exit 1
 fi
 
-rm -f "$TEST_IMG.orig" "$TEST_IMG.raw" "$TEST_IMG.raw2"
-
 echo "*** done"
 rm -f $seq.full
 status=0
-- 
2.13.3
