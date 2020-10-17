Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731EDC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86BB20720
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86BB20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTifZ-0003F3-Sb
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kTieQ-0002mW-9X
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 05:37:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43886 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kTieN-0007uQ-JJ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 05:37:21 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A64B74DD55C0DEC84F5E;
 Sat, 17 Oct 2020 17:37:01 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 17:36:54 +0800
From: Bihong Yu <yubihong@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v1] migration: using trace_ to replace DPRINTF
Date: Sat, 17 Oct 2020 17:35:47 +0800
Message-ID: <1602927347-15669-1-git-send-email-yubihong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=yubihong@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 05:37:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.chen@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, david.edmondson@oracle.com, wanghao232@huawei.com,
 zhengchuan@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Bihong Yu <yubihong@huawei.com>
---
 migration/block.c      | 36 ++++++++++++++++++------------------
 migration/page_cache.c | 13 +++----------
 migration/trace-events | 13 +++++++++++++
 3 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 273392b..1c3e261 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -26,6 +26,7 @@
 #include "qemu-file.h"
 #include "migration/vmstate.h"
 #include "sysemu/block-backend.h"
+#include "trace.h"
 
 #define BLK_MIG_BLOCK_SIZE           (1 << 20)
 #define BDRV_SECTORS_PER_DIRTY_CHUNK (BLK_MIG_BLOCK_SIZE >> BDRV_SECTOR_BITS)
@@ -434,10 +435,9 @@ static int init_blk_migration(QEMUFile *f)
         block_mig_state.total_sector_sum += sectors;
 
         if (bmds->shared_base) {
-            DPRINTF("Start migration for %s with shared base image\n",
-                    bdrv_get_device_name(bs));
+            trace_init_blk_migration_shared(bdrv_get_device_name(bs));
         } else {
-            DPRINTF("Start full migration for %s\n", bdrv_get_device_name(bs));
+            trace_init_blk_migration_full(bdrv_get_device_name(bs));
         }
 
         QSIMPLEQ_INSERT_TAIL(&block_mig_state.bmds_list, bmds, entry);
@@ -592,7 +592,7 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
     return (bmds->cur_dirty >= bmds->total_sectors);
 
 error:
-    DPRINTF("Error reading sector %" PRId64 "\n", sector);
+    trace_mig_save_device_dirty(sector);
     g_free(blk->buf);
     g_free(blk);
     return ret;
@@ -628,9 +628,9 @@ static int flush_blks(QEMUFile *f)
     BlkMigBlock *blk;
     int ret = 0;
 
-    DPRINTF("%s Enter submitted %d read_done %d transferred %d\n",
-            __func__, block_mig_state.submitted, block_mig_state.read_done,
-            block_mig_state.transferred);
+    trace_flush_blks("Enter", block_mig_state.submitted,
+                     block_mig_state.read_done,
+                     block_mig_state.transferred);
 
     blk_mig_lock();
     while ((blk = QSIMPLEQ_FIRST(&block_mig_state.blk_list)) != NULL) {
@@ -656,9 +656,9 @@ static int flush_blks(QEMUFile *f)
     }
     blk_mig_unlock();
 
-    DPRINTF("%s Exit submitted %d read_done %d transferred %d\n", __func__,
-            block_mig_state.submitted, block_mig_state.read_done,
-            block_mig_state.transferred);
+    trace_flush_blks("Exit", block_mig_state.submitted,
+                     block_mig_state.read_done,
+                     block_mig_state.transferred);
     return ret;
 }
 
@@ -727,8 +727,8 @@ static int block_save_setup(QEMUFile *f, void *opaque)
 {
     int ret;
 
-    DPRINTF("Enter save live setup submitted %d transferred %d\n",
-            block_mig_state.submitted, block_mig_state.transferred);
+    trace_block_save("setup", block_mig_state.submitted,
+                     block_mig_state.transferred);
 
     qemu_mutex_lock_iothread();
     ret = init_blk_migration(f);
@@ -759,8 +759,8 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
     int64_t last_ftell = qemu_ftell(f);
     int64_t delta_ftell;
 
-    DPRINTF("Enter save live iterate submitted %d transferred %d\n",
-            block_mig_state.submitted, block_mig_state.transferred);
+    trace_block_save("iterate", block_mig_state.submitted,
+                     block_mig_state.transferred);
 
     ret = flush_blks(f);
     if (ret) {
@@ -825,8 +825,8 @@ static int block_save_complete(QEMUFile *f, void *opaque)
 {
     int ret;
 
-    DPRINTF("Enter save live complete submitted %d transferred %d\n",
-            block_mig_state.submitted, block_mig_state.transferred);
+    trace_block_save("complete", block_mig_state.submitted,
+                     block_mig_state.transferred);
 
     ret = flush_blks(f);
     if (ret) {
@@ -851,7 +851,7 @@ static int block_save_complete(QEMUFile *f, void *opaque)
     /* report completion */
     qemu_put_be64(f, (100 << BDRV_SECTOR_BITS) | BLK_MIG_FLAG_PROGRESS);
 
-    DPRINTF("Block migration completed\n");
+    trace_block_save_complete();
 
     qemu_put_be64(f, BLK_MIG_FLAG_EOS);
 
@@ -884,7 +884,7 @@ static void block_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
         pending = max_size + BLK_MIG_BLOCK_SIZE;
     }
 
-    DPRINTF("Enter save live pending  %" PRIu64 "\n", pending);
+    trace_block_save_pending(pending);
     /* We don't do postcopy */
     *res_precopy_only += pending;
 }
diff --git a/migration/page_cache.c b/migration/page_cache.c
index 775582f..d554efa 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -18,14 +18,7 @@
 #include "qapi/error.h"
 #include "qemu/host-utils.h"
 #include "page_cache.h"
-
-#ifdef DEBUG_CACHE
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stdout, "cache: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#include "trace.h"
 
 /* the page in cache will not be replaced in two cycles */
 #define CACHED_PAGE_LIFETIME 2
@@ -75,7 +68,7 @@ PageCache *cache_init(int64_t new_size, size_t page_size, Error **errp)
     cache->num_items = 0;
     cache->max_num_items = num_pages;
 
-    DPRINTF("Setting cache buckets to %" PRId64 "\n", cache->max_num_items);
+    trace_cache_init(cache->max_num_items);
 
     /* We prefer not to abort if there is no memory */
     cache->page_cache = g_try_malloc((cache->max_num_items) *
@@ -169,7 +162,7 @@ int cache_insert(PageCache *cache, uint64_t addr, const uint8_t *pdata,
     if (!it->it_data) {
         it->it_data = g_try_malloc(cache->page_size);
         if (!it->it_data) {
-            DPRINTF("Error allocating page\n");
+            trace_cache_insert();
             return -1;
         }
         cache->num_items++;
diff --git a/migration/trace-events b/migration/trace-events
index 338f38b..772bb81 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -325,3 +325,16 @@ get_ramblock_vfn_hash(const char *idstr, uint64_t vfn, uint32_t crc) "ramblock n
 calc_page_dirty_rate(const char *idstr, uint32_t new_crc, uint32_t old_crc) "ramblock name: %s, new crc: %" PRIu32 ", old crc: %" PRIu32
 skip_sample_ramblock(const char *idstr, uint64_t ramblock_size) "ramblock name: %s, ramblock size: %" PRIu64
 find_page_matched(const char *idstr) "ramblock %s addr or size changed"
+
+# block.c
+init_blk_migration_shared(const char *blk_device_name) "Start migration for %s with shared base image"
+init_blk_migration_full(const char *blk_device_name) "Start full migration for %s"
+mig_save_device_dirty(int64_t sector) "Error reading sector %" PRId64
+flush_blks(const char *action, int submitted, int read_done, int transferred) "%s submitted %d read_done %d transferred %d"
+block_save(const char *mig_stage, int submitted, int transferred) "Enter save live %s submitted %d transferred %d"
+block_save_complete(void) "Block migration completed"
+block_save_pending(uint64_t pending) "Enter save live pending  %" PRIu64
+
+# page_cache.c
+cache_init(int64_t max_num_items) "Setting cache buckets to %" PRId64
+cache_insert(void) "Error allocating page"
-- 
1.8.3.1


