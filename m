Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF68C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 04:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B973D2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 04:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B973D2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIl6m-00038E-Gf
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 00:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIl0p-0002Sc-Ug; Wed, 16 Sep 2020 23:55:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4751 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIl0m-0008LG-PX; Wed, 16 Sep 2020 23:55:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id CD599413AE70151E21C7;
 Thu, 17 Sep 2020 11:55:05 +0800 (CST)
Received: from localhost (10.174.187.87) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 11:54:55 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH V2 02/10] migration/: fix some comment spelling errors
Date: Thu, 17 Sep 2020 11:54:05 +0800
Message-ID: <20200917035413.701-3-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200917035413.701-1-zhaolichang@huawei.com>
References: <20200917035413.701-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.87]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 23:21:09
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
Cc: Peter
 Maydell <peter.maydell@linaro.org>, zhaolichang <zhaolichang@huawei.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the migration folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 migration/colo-failover.c |  2 +-
 migration/colo.c          |  2 +-
 migration/multifd.c       |  4 ++--
 migration/postcopy-ram.c  |  4 ++--
 migration/postcopy-ram.h  |  2 +-
 migration/ram.c           | 10 +++++-----
 migration/rdma.c          |  8 ++++----
 migration/savevm.c        |  4 ++--
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index e9ca0b4774..b717edc8e2 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -46,7 +46,7 @@ void failover_request_active(Error **errp)
 {
    if (failover_set_state(FAILOVER_STATUS_NONE,
         FAILOVER_STATUS_REQUIRE) != FAILOVER_STATUS_NONE) {
-        error_setg(errp, "COLO failover is already actived");
+        error_setg(errp, "COLO failover is already activated");
         return;
     }
     failover_bh = qemu_bh_new(colo_failover_bh, NULL);
diff --git a/migration/colo.c b/migration/colo.c
index ea7d1e9d4e..80788d46b5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -632,7 +632,7 @@ out:
     /*
      * It is safe to unregister notifier after failover finished.
      * Besides, colo_delay_timer and colo_checkpoint_sem can't be
-     * released befor unregister notifier, or there will be use-after-free
+     * released before unregister notifier, or there will be use-after-free
      * error.
      */
     colo_compare_unregister_notifier(&packets_compare_notifier);
diff --git a/migration/multifd.c b/migration/multifd.c
index d0441202aa..ac84a61797 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -731,7 +731,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         qemu_sem_post(&p->sem_sync);
         /*
          * Although multifd_send_thread is not created, but main migration
-         * thread neet to judge whether it is running, so we need to mark
+         * thread needs to judge whether it is running, so we need to mark
          * its status.
          */
         p->quit = true;
@@ -1042,7 +1042,7 @@ bool multifd_recv_all_channels_created(void)
 
 /*
  * Try to receive all multifd channels to get ready for the migration.
- * - Return true and do not set @errp when correctly receving all channels;
+ * - Return true and do not set @errp when correctly receiving all channels;
  * - Return false and do not set @errp when correctly receiving the current one;
  * - Return false and set @errp when failing to receive the current channel.
  */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 1bb22f2b6c..baf094ba3a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -237,7 +237,7 @@ release_ufd:
  * request_ufd_features: this function should be called only once on a newly
  * opened ufd, subsequent calls will lead to error.
  *
- * Returns: true on succes
+ * Returns: true on success
  *
  * @ufd: fd obtained from userfaultfd syscall
  * @features: bit mask see UFFD_API_FEATURES
@@ -807,7 +807,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
 
     low_time_offset = get_low_time_offset(dc);
     /* lookup cpu, to clear it,
-     * that algorithm looks straighforward, but it's not
+     * that algorithm looks straightforward, but it's not
      * optimal, more optimal algorithm is keeping tree or hash
      * where key is address value is a list of  */
     for (i = 0; i < smp_cpus; i++) {
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 9941feb63a..6d2b3cf124 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -161,7 +161,7 @@ struct PostCopyFD {
  */
 void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
 void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
-/* Call each of the shared 'waker's registerd telling them of
+/* Call each of the shared 'waker's registered telling them of
  * availability of a block.
  */
 int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset);
diff --git a/migration/ram.c b/migration/ram.c
index 76d4fee5d5..c5f36aeae5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -256,7 +256,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
     /*
      * Always use little endian when sending the bitmap. This is
      * required that when source and destination VMs are not using the
-     * same endianess. (Note: big endian won't work.)
+     * same endianness. (Note: big endian won't work.)
      */
     bitmap_to_le(le_bitmap, block->receivedmap, nbits);
 
@@ -275,7 +275,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
     qemu_put_buffer(file, (const uint8_t *)le_bitmap, size);
     /*
      * Mark as an end, in case the middle part is screwed up due to
-     * some "misterious" reason.
+     * some "mysterious" reason.
      */
     qemu_put_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);
     qemu_fflush(file);
@@ -718,7 +718,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     /*
      * Reaching here means the page has hit the xbzrle cache, no matter what
      * encoding result it is (normal encoding, overflow or skipping the page),
-     * count the page as encoded. This is used to caculate the encoding rate.
+     * count the page as encoded. This is used to calculate the encoding rate.
      *
      * Example: 2 pages (8KB) being encoded, first page encoding generates 2KB,
      * 2nd page turns out to be skipped (i.e. no new bytes written to the
@@ -3705,7 +3705,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
     /*
      * Note: see comments in ramblock_recv_bitmap_send() on why we
-     * need the endianess convertion, and the paddings.
+     * need the endianness conversion, and the paddings.
      */
     local_size = ROUND_UP(local_size, 8);
 
@@ -3743,7 +3743,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
     }
 
     /*
-     * Endianess convertion. We are during postcopy (though paused).
+     * Endianness conversion. We are during postcopy (though paused).
      * The dirty bitmap won't change. We can directly modify it.
      */
     bitmap_from_le(block->bmap, le_bitmap, nbits);
diff --git a/migration/rdma.c b/migration/rdma.c
index 1dc563ec3f..8f43d69b06 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1511,7 +1511,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
     } else {
         /* This is the source side, we're in a separate thread
          * or destination prior to migration_fd_process_incoming()
-         * after postcopy, the destination also in a seprate thread.
+         * after postcopy, the destination also in a separate thread.
          * we can't yield; so we have to poll the fd.
          * But we need to be able to handle 'cancel' or an error
          * without hanging forever.
@@ -2268,7 +2268,7 @@ static inline int qemu_rdma_buffer_mergable(RDMAContext *rdma,
  *    chunk, then start a new chunk and flush() the old chunk.
  * 3. To keep the hardware busy, we also group chunks into batches
  *    and only require that a batch gets acknowledged in the completion
- *    qeueue instead of each individual chunk.
+ *    queue instead of each individual chunk.
  */
 static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
                            uint64_t block_offset, uint64_t offset,
@@ -3150,7 +3150,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
     if (size > 0) {
         /*
          * Add this page to the current 'chunk'. If the chunk
-         * is full, or the page doen't belong to the current chunk,
+         * is full, or the page doesn't belong to the current chunk,
          * an actual RDMA write will occur and a new chunk will be formed.
          */
         ret = qemu_rdma_write(f, rdma, block_offset, offset, size);
@@ -4103,7 +4103,7 @@ void rdma_start_outgoing_migration(void *opaque,
         goto err;
     }
 
-    /* RDMA postcopy need a seprate queue pair for return path */
+    /* RDMA postcopy need a separate queue pair for return path */
     if (migrate_postcopy()) {
         rdma_return_path = qemu_rdma_data_init(host_port, errp);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 304d98ff78..ee21e981ba 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2795,7 +2795,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
 
     if (!has_live) {
         /* live default to true so old version of Xen tool stack can have a
-         * successfull live migration */
+         * successful live migration */
         live = true;
     }
 
@@ -2818,7 +2818,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
          * "xen-save-devices-state" and in case of migration failure, libxl
          * would call "cont".
          * So call bdrv_inactivate_all (release locks) here to let the other
-         * side of the migration take controle of the images.
+         * side of the migration take control of the images.
          */
         if (live && !saved_vm_running) {
             ret = bdrv_inactivate_all();
-- 
2.26.2.windows.1


