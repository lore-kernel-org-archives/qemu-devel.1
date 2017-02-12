Received: from eggs.gnu.org ([2001:4830:134:3::10]:48219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccjGI-0007W4-Nc
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccjGH-0000gW-Hy
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:47:34 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:47:24 +0100
Message-Id: <20170212014724.10618-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Swap request limit definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Defining BDRV_REQUEST_MAX_SECTORS based on BDRV_REQUEST_MAX_BYTES is
simpler than the other way around.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 4e81f2069b..101ef33f6b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -114,9 +114,8 @@ typedef struct HDGeometry {
 #define BDRV_SECTOR_SIZE   (1ULL << BDRV_SECTOR_BITS)
 #define BDRV_SECTOR_MASK   ~(BDRV_SECTOR_SIZE - 1)
 
-#define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, \
-                                     INT_MAX >> BDRV_SECTOR_BITS)
-#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS)
+#define BDRV_REQUEST_MAX_BYTES      MIN(SIZE_MAX, INT_MAX)
+#define BDRV_REQUEST_MAX_SECTORS    (BDRV_REQUEST_MAX_BYTES >> BDRV_SECTOR_BITS)
 
 /*
  * Allocation status flags
-- 
2.11.0
