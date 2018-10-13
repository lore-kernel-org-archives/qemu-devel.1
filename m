Received: from eggs.gnu.org ([2001:4830:134:3::10]:49130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBFfA-0002ph-9l
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 04:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBFf9-0002PT-9D
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 04:52:44 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 13 Oct 2018 01:52:31 -0700
Message-Id: <20181013085231.55608-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] block: change some function return type to bool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 block/block-backend.c          | 8 ++++----
 include/sysemu/block-backend.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index dc0cd57724..2a8f3b55f8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1708,7 +1708,7 @@ void blk_error_action(BlockBackend *blk, BlockErrorAction action,
     }
 }
 
-int blk_is_read_only(BlockBackend *blk)
+bool blk_is_read_only(BlockBackend *blk)
 {
     BlockDriverState *bs = blk_bs(blk);
 
@@ -1719,18 +1719,18 @@ int blk_is_read_only(BlockBackend *blk)
     }
 }
 
-int blk_is_sg(BlockBackend *blk)
+bool blk_is_sg(BlockBackend *blk)
 {
     BlockDriverState *bs = blk_bs(blk);
 
     if (!bs) {
-        return 0;
+        return false;
     }
 
     return bdrv_is_sg(bs);
 }
 
-int blk_enable_write_cache(BlockBackend *blk)
+bool blk_enable_write_cache(BlockBackend *blk)
 {
     return blk->enable_write_cache;
 }
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 830d873f24..c96bcdee14 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -166,9 +166,9 @@ BlockErrorAction blk_get_error_action(BlockBackend *blk, bool is_read,
                                       int error);
 void blk_error_action(BlockBackend *blk, BlockErrorAction action,
                       bool is_read, int error);
-int blk_is_read_only(BlockBackend *blk);
-int blk_is_sg(BlockBackend *blk);
-int blk_enable_write_cache(BlockBackend *blk);
+bool blk_is_read_only(BlockBackend *blk);
+bool blk_is_sg(BlockBackend *blk);
+bool blk_enable_write_cache(BlockBackend *blk);
 void blk_set_enable_write_cache(BlockBackend *blk, bool wce);
 void blk_invalidate_cache(BlockBackend *blk, Error **errp);
 bool blk_is_inserted(BlockBackend *blk);
-- 
2.17.1
