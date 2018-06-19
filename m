Received: from eggs.gnu.org ([2001:4830:134:3::10]:56037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvO-0004gS-04
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvI-0005dy-6j
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:58 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Tue, 19 Jun 2018 16:43:33 +0300
Message-ID: <1529415820-7750-2-git-send-email-ari@tuxera.com>
In-Reply-To: <1529415820-7750-1-git-send-email-ari@tuxera.com>
References: <1529415820-7750-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 1/8] block: Move two block permission
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
index afe30ca..20d54fe 100644
--- a/block.c
+++ b/block.c
@@ -1926,12 +1926,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
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
index e677080..6466ce0 100644
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
