Received: from eggs.gnu.org ([2001:4830:134:3::10]:40462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJM9I-0006ly-P0
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJM9H-0006yC-Q6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:53:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 17 May 2018 18:52:51 +0200
Message-Id: <20180517165253.19958-2-kwolf@redhat.com>
In-Reply-To: <20180517165253.19958-1-kwolf@redhat.com>
References: <20180517165253.19958-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu-iotests: Fix paths for NFS
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

Test cases were trying to use nfs:// URLs as local filenames, which made
every test fail for NFS. With TEST_IMG and TEST_IMG_FILE set like for
the other protocols, NFS tests can pass again.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/common.rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 9a65a11026..cb5fa14e7f 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -147,8 +147,8 @@ else
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         TEST_IMG="ssh://127.0.0.1$TEST_IMG_FILE"
     elif [ "$IMGPROTO" = "nfs" ]; then
-        TEST_DIR="nfs://127.0.0.1/$TEST_DIR"
-        TEST_IMG=$TEST_DIR/t.$IMGFMT
+        TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
+        TEST_IMG="nfs://127.0.0.1$TEST_IMG_FILE"
     elif [ "$IMGPROTO" = "vxhs" ]; then
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         TEST_IMG="vxhs://127.0.0.1:9999/t.$IMGFMT"
-- 
2.13.6
