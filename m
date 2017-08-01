Received: from eggs.gnu.org ([2001:4830:134:3::10]:54779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRm-0000NA-6a
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRl-0005Yj-HN
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:27 +0200
Message-Id: <20170801144632.3831-11-kwolf@redhat.com>
In-Reply-To: <20170801144632.3831-1-kwolf@redhat.com>
References: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/15] qemu-iotests/141: Fix image cleanup
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

qemu-iotests 141 attempted to use brace expansion to remove all images
with a single command. However, for this to work, the braces shouldn't
be quoted.

With this fix, the tests correctly cleans up its scratch images.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
