Received: from eggs.gnu.org ([209.51.188.92]:51248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1hFvSQ-0006UT-VG
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1hFvSO-0005Xm-Bq
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:51:09 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:6492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wang.yi59@zte.com.cn>)
	id 1hFvSM-0005Qf-Fi
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:51:08 -0400
From: Yi Wang <wang.yi59@zte.com.cn>
Date: Mon, 15 Apr 2019 14:51:29 +0800
Message-Id: <1555311089-18610-1-git-send-email-wang.yi59@zte.com.cn>
Subject: [Qemu-devel] [PATCH] migration: update comments of migration bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org, Yi Wang <wang.yi59@zte.com.cn>

Since the ram bitmap and the unsent bitmap are split by RAMBlock
in commit 6b6712e, it's better to update the comments about them.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 migration/ram.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1ca9ba7..24ab23d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1630,8 +1630,6 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
 /**
  * migration_bitmap_find_dirty: find the next dirty page from start
  *
- * Called with rcu_read_lock() to protect migration_bitmap
- *
  * Returns the byte offset within memory region of the start of a dirty page
  *
  * @rs: current RAM state
@@ -2681,7 +2679,7 @@ static void ram_save_cleanup(void *opaque)
     RAMBlock *block;
 
     /* caller have hold iothread lock or is in a bh, so there is
-     * no writing race against this migration_bitmap
+     * no writing race against the migration bitmap
      */
     memory_global_dirty_log_stop();
 
-- 
1.8.3.1
