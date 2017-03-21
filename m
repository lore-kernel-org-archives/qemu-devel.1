Received: from eggs.gnu.org ([2001:4830:134:3::10]:39355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAIC-0001OR-5m
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAIB-0000KX-DK
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:04 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:20 +0800
Message-Id: <20170321031635.22123-2-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 01/16] block: Define
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c               | 2 ++
 include/block/block.h | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 6e906ec..ae9327b 100644
--- a/block.c
+++ b/block.c
@@ -1547,6 +1547,8 @@ static char *bdrv_perm_names(uint64_t perm)
         { BLK_PERM_WRITE_UNCHANGED, "write unchanged" },
         { BLK_PERM_RESIZE,          "resize" },
         { BLK_PERM_GRAPH_MOD,       "change children" },
+        { BLK_PERM_AIO_CONTEXT_CHANGE,
+                                    "aio context change" },
         { 0, NULL }
     };
 
diff --git a/include/block/block.h b/include/block/block.h
index 5149260..989bdcc 100644
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
