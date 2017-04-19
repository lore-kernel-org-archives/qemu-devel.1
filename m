Received: from eggs.gnu.org ([2001:4830:134:3::10]:52167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0m9k-0003mv-Ap
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0m9j-000599-HC
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:12 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 19 Apr 2017 17:43:41 +0800
Message-Id: <20170419094356.19826-2-famz@redhat.com>
In-Reply-To: <20170419094356.19826-1-famz@redhat.com>
References: <20170419094356.19826-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/16] block: Define
 BLK_PERM_AIO_CONTEXT_CHANGE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c               | 2 ++
 include/block/block.h | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 1fbbb8d..5a3affb 100644
--- a/block.c
+++ b/block.c
@@ -1562,6 +1562,8 @@ static char *bdrv_perm_names(uint64_t perm)
         { BLK_PERM_WRITE_UNCHANGED, "write unchanged" },
         { BLK_PERM_RESIZE,          "resize" },
         { BLK_PERM_GRAPH_MOD,       "change children" },
+        { BLK_PERM_AIO_CONTEXT_CHANGE,
+                                    "aio context change" },
         { 0, NULL }
     };
 
diff --git a/include/block/block.h b/include/block/block.h
index 5ddc0cf..3c409a3 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -221,7 +221,12 @@ enum {
      */
     BLK_PERM_GRAPH_MOD          = 0x10,
 
-    BLK_PERM_ALL                = 0x1f,
+    /**
+     * This permission is required to change the AioContext of this node.
+     */
+    BLK_PERM_AIO_CONTEXT_CHANGE = 0x20,
+
+    BLK_PERM_ALL                = 0x3f,
 };
 
 /* disk I/O throttling */
-- 
2.9.3
