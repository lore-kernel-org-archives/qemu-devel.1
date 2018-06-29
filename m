Received: from eggs.gnu.org ([2001:4830:134:3::10]:55142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fZ0J8-0005BL-7K
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fZ0J7-0000lP-Ec
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:47:54 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 29 Jun 2018 23:47:38 +0300
Message-ID: <1530305259-19184-2-git-send-email-ari@tuxera.com>
In-Reply-To: <1530305259-19184-1-git-send-email-ari@tuxera.com>
References: <1530305259-19184-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 1/2] block: Move two block permission
 constants to the relevant enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This allows using the two constants outside of block.c, which will
happen in a subsequent patch.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 block.c               | 6 ------
 include/block/block.h | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 1b8147c..4bdedd1 100644
--- a/block.c
+++ b/block.c
@@ -1948,12 +1948,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
     return 0;
 }
 
-#define DEFAULT_PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
-                                 | BLK_PERM_WRITE \
-                                 | BLK_PERM_WRITE_UNCHANGED \
-                                 | BLK_PERM_RESIZE)
-#define DEFAULT_PERM_UNCHANGED (BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH)
-
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildRole *role,
                                BlockReopenQueue *reopen_queue,
diff --git a/include/block/block.h b/include/block/block.h
index b1d6fdb..03efd47 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -225,6 +225,13 @@ enum {
     BLK_PERM_GRAPH_MOD          = 0x10,
 
     BLK_PERM_ALL                = 0x1f,
+
+    DEFAULT_PERM_PASSTHROUGH    = BLK_PERM_CONSISTENT_READ
+                                 | BLK_PERM_WRITE
+                                 | BLK_PERM_WRITE_UNCHANGED
+                                 | BLK_PERM_RESIZE,
+
+    DEFAULT_PERM_UNCHANGED      = BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH,
 };
 
 char *bdrv_perm_names(uint64_t perm);
-- 
2.7.4
