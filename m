Received: from eggs.gnu.org ([2001:4830:134:3::10]:54753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRl-0000Lg-5n
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRk-0005XU-Jw
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:57 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:26 +0200
Message-Id: <20170801144632.3831-10-kwolf@redhat.com>
In-Reply-To: <20170801144632.3831-1-kwolf@redhat.com>
References: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/15] qemu-iotests: Remove blkdebug.conf after
 tests
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

qemu-iotests 074 and 179 left a blkdebug.conf behind in the scratch
directory. Make sure to clean up after completing the tests.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/074 | 1 +
 tests/qemu-iotests/179 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
index aba126cb69..b17866bd34 100755
--- a/tests/qemu-iotests/074
+++ b/tests/qemu-iotests/074
@@ -32,6 +32,7 @@ _cleanup()
     echo "Cleanup"
     _cleanup_test_img
     rm "${TEST_IMG2}"
+    rm -f "$TEST_DIR/blkdebug.conf"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 7bc8db8fe0..115944a753 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -30,6 +30,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_test_img
+    rm -f "$TEST_DIR/blkdebug.conf"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-- 
2.13.3
