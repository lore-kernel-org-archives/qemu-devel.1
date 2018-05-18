Received: from eggs.gnu.org ([2001:4830:134:3::10]:47605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJgKo-0001XH-R2
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJgKn-0003WU-Rg
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:26:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 16:26:03 +0200
Message-Id: <20180518142605.19846-2-kwolf@redhat.com>
In-Reply-To: <20180518142605.19846-1-kwolf@redhat.com>
References: <20180518142605.19846-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] qemu-iotests: Fix paths for NFS
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
