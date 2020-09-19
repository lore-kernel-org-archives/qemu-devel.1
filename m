Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4929BC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F8920874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F8920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJi47-00033J-T2
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhs0-0006Zx-E7; Sat, 19 Sep 2020 14:46:00 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrw-0001St-Rt; Sat, 19 Sep 2020 14:46:00 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCXhr-1kAfR02sHz-009h6x; Sat, 19 Sep 2020 20:45:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/17] migration/: fix some comment spelling errors
Date: Sat, 19 Sep 2020 20:44:44 +0200
Message-Id: <20200919184451.2129349-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nn2mBXx8oZiaSj79ijuEvTQoywxApOhaT/yDwxJdeE7ptfW2nnp
 X7pbpvKfeSonaOgczdjBr/kpHEaUWYOrv7k3O8XBRPhgm4Mash1KVlM7NkXLKfioYias6ap
 7nwjLXyRVsDxNJh8DkKD5IDa07noRjCGvSmxFHEYx+eHBJf77F731BiWnf9hqeJ3pj/bADp
 Ggkp5HeLth8cyI9VRS2xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M980zZuf4Lc=:qLED36jWxTlAgV2vFQVhR5
 9kt234b2Dhmxe/lc6lJZ9t5ovCWYoO40YxZWk3nWynKN01L8i+yaehnJECrzmgoDMJVGX7IM0
 13PUb6d8RfdtDCCzYdGI3UjHdyfU4hCz3LXmHVai+3Bso9+FXawy3AGvu6l5jkvsRWA2rZgO8
 Zey5O4iZQ4Lp87NQtHnFL9FZOZ+DQEwN7uuQLZXy+PWA9XW5eJz164m0AlmR5+QQgE09Z6eqT
 5JnPuaEtAaC2w6uzl5soYf9IRW/uGXf7ee4EfVxZLY09XUL83HfD5IvKw8T9LnT5yZZlOwh9Z
 GYqk1Al7Sqspyj5E9SxsHx8oiYT6omkHsukKdmhq2nyXMs5dEPdwpJ4fzlZmTyeKnGViE+/84
 CGYKJ0bQho56WqIALGaQ6GiLLkEeEZ6petj9bXolc0lMBPsiBuo1XE1PVcTnryUbKo+5rOCPf
 EWgSU2F/d34NstmP8Wrv+f27ypITHP3YDDYr6qoDOavrNlHDfAB53cXjZTqHN2ynpTbp0Zp8t
 pwfFwpgoNlHyd5c5jMwXdQ//havIxgA5a4aENaQdOOJjtkQU9hwhm0zscW/jolc6PMD6BaGTP
 tzkemOcl2+e/77OTqQFR/t2Td/szBREFWpzmOfotuP7MJNbXrkwAZLO70Fyr1vhpAP0GjFaRJ
 r1PYTFQAXVQEvvLoCj+t9qnkshYI4t1SqC/FhupeJMgEV2lYyQTx9gpOLvf864ioZffIwL/uf
 iE3IlOvsp/73fXZ/ERGCVH3GQTqhhE0QX+TbCHpz7fXneHVtNNlScMkyQLmFOkfoSVkDNRfPF
 zzBi4tHcmL6QMzqTquQFU/sg8QjLKIPUeBeNNwbnItiAHmLH0dngF0YrSXXz3gLqL+bq9/U
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 zhaolichang <zhaolichang@huawei.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhaolichang <zhaolichang@huawei.com>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the migration folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200917075029.313-3-zhaolichang@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
index e9ca0b47744b..b717edc8e2f6 100644
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
index ea7d1e9d4e7b..80788d46b555 100644
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
index d0441202aae9..ac84a61797f3 100644
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
index 1bb22f2b6cba..baf094ba3a0d 100644
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
index 9941feb63aa7..6d2b3cf124e8 100644
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
index 76d4fee5d511..c5f36aeae53b 100644
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
index 1dc563ec3f1b..8f43d69b066d 100644
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
index 304d98ff7825..ee21e981ba2c 100644
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
2.26.2


