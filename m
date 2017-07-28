Received: from eggs.gnu.org ([2001:4830:134:3::10]:46779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db570-0001SJ-IR
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db56z-0007gn-MA
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:15:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Jul 2017 15:14:47 +0200
Message-Id: <20170728131452.15316-3-kwolf@redhat.com>
In-Reply-To: <20170728131452.15316-1-kwolf@redhat.com>
References: <20170728131452.15316-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 2/7] qemu-iotests: Remove
 blkdebug.conf after tests
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

qemu-iotests 074 and 179 left a blkdebug.conf behind the scratch
directory. Make sure to clean up after completing the tests.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
