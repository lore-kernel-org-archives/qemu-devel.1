Received: from eggs.gnu.org ([2001:4830:134:3::10]:46821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db571-0001TH-F8
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db570-0007hq-HX
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:15:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Jul 2017 15:14:48 +0200
Message-Id: <20170728131452.15316-4-kwolf@redhat.com>
In-Reply-To: <20170728131452.15316-1-kwolf@redhat.com>
References: <20170728131452.15316-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 3/7] qemu-iotests/141: Fix image
 cleanup
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

qemu-iotests 141 attempted to use brace expansion to remove all images
with a single command. However, for this to work, the braces shouldn't
be quoted.

With this fix, the tests correctly cleans up its scratch images.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/141 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 40a3405968..2f9d7b9bc2 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -31,7 +31,7 @@ _cleanup()
 {
     _cleanup_qemu
     _cleanup_test_img
-    rm -f "$TEST_DIR/{b,m,o}.$IMGFMT"
+    rm -f "$TEST_DIR"/{b,m,o}.$IMGFMT
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-- 
2.13.3
