Received: from eggs.gnu.org ([2001:4830:134:3::10]:54806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRo-0000Q0-BH
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRn-0005aQ-Lj
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:47:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:30 +0200
Message-Id: <20170801144632.3831-14-kwolf@redhat.com>
In-Reply-To: <20170801144632.3831-1-kwolf@redhat.com>
References: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/15] qemu-iotests/063: Fix leaked image
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

qemu-iotests 063 left t.raw.raw1 behind in the scratch directory because
it used the wrong suffix. Make sure to clean it up after completing the
test.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
