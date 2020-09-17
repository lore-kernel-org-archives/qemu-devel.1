Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FDEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CFF221E3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CFF221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIyoW-0001NW-MM
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIym2-00077L-Gj; Thu, 17 Sep 2020 14:36:50 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIym0-00021C-6i; Thu, 17 Sep 2020 14:36:50 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N94qX-1kWMk42IeF-01688A; Thu, 17 Sep 2020 20:36:39 +0200
Subject: Re: [PATCH V3 02/10] migration/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200917075029.313-1-zhaolichang@huawei.com>
 <20200917075029.313-3-zhaolichang@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a58f7ee3-fa5a-4d6b-9ffd-ce8593346e55@vivier.eu>
Date: Thu, 17 Sep 2020 20:36:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917075029.313-3-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KsWWGnd5ClI2iMGoQOEN5ljQYe+5VcSYf5F3a2Nd4PtmjilN713
 HKybU7lF0bhEEhidASF1zi3z+J1VO8dE1HWehrer/GPoTLX9Q4HD42005KXg/gQbEV9KvFm
 eLkPN/oR/kQ+Y+v+iynhGpIJ9Bs1vlLNuSf96mpNGP8Jh5rkr+GsT/LJgA497SU1Tpjz7M1
 8a2MUoKrhAYVkt2q6KvqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PodL5SWBooU=:cVG1uSwhqoCqkG0ShNIZzY
 R9ZfzbVI0RLBsnWRX8CZBhVk6uZxDDyZDDhozxdpp9dFrFIZ2Z5D/4eE1BVAtzkSRELLUFerM
 Jsv6otiVCMOOMWy2dW6nD1G+z/OAuH3XTV+tGKEVjgaPniQIPk4JDTJjLx84J4TfcMyJq+DSR
 uhQl0wwQSxavl6bTrv8rt33tyXJ8J0FeHV1tWN8UN75jkNWBVHtatRMz26FDjPa92qPV+Z1Cw
 jZNyEDt1cxPqrLBkey1wYvy6nK7t0gqksZ+q8pX+/hTo77DHgpX6NGEdMYy/l7Ua2bK8UTJNZ
 E+7qyyDFB8qi/6abJ+xwlLQyeXtQBdW+7gO1kxKNZxnKQei4l26bQpIb1mjh+SQtK081zrEiF
 Q5RF9X21yYBS2Pyce3MQNcwBXcE/erpGSR3bS5Ax5fY36Ia8JnEX1ZtpjS0a2b4didNcVE2YF
 oVh3eSsTeG6rgfNJbOdwoVWEwDuACA51kJG6+eRAHDpZZmeakda8co8GMfJX0Yj3SmMnSTdQZ
 bdwGRDCtEjXCPaGjhqp75jm2eXKunmaAe+5IBgft7cl0WEHDPZ3i4VgSqi0sZ9MSo/978KX4b
 MkleRYikv4qNg71t+vvwW1y4YhO9xEZLBWJNnkUARtr2J+tKmxiSjQRzKre1o32M1CYf4dJt/
 akcdViRUtsNg8lGjK1ZHRCF9SuJbVhlLriRR8SO3K8jZmMq6qi/rzWo5rdxM18X9APCoR5tWV
 D3eASSOkSbRWxsdjoWRBswekMICUU6q4vB/62BnGMyK7/bET8xOeD475l9ad7RN1Oqm/qCRUA
 a+gNhcsHCUeNYS5Lu/7LqFZeMvzpbGkEZnuEzwW+TXrVoq1R4PCBf1w2DlNLb6fTNYtch+c
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 14:36:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/09/2020 à 09:50, zhaolichang a écrit :
> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the migration folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  migration/colo-failover.c |  2 +-
>  migration/colo.c          |  2 +-
>  migration/multifd.c       |  4 ++--
>  migration/postcopy-ram.c  |  4 ++--
>  migration/postcopy-ram.h  |  2 +-
>  migration/ram.c           | 10 +++++-----
>  migration/rdma.c          |  8 ++++----
>  migration/savevm.c        |  4 ++--
>  8 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/colo-failover.c b/migration/colo-failover.c
> index e9ca0b4774..b717edc8e2 100644
> --- a/migration/colo-failover.c
> +++ b/migration/colo-failover.c
> @@ -46,7 +46,7 @@ void failover_request_active(Error **errp)
>  {
>     if (failover_set_state(FAILOVER_STATUS_NONE,
>          FAILOVER_STATUS_REQUIRE) != FAILOVER_STATUS_NONE) {
> -        error_setg(errp, "COLO failover is already actived");
> +        error_setg(errp, "COLO failover is already activated");
>          return;
>      }
>      failover_bh = qemu_bh_new(colo_failover_bh, NULL);
> diff --git a/migration/colo.c b/migration/colo.c
> index ea7d1e9d4e..80788d46b5 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -632,7 +632,7 @@ out:
>      /*
>       * It is safe to unregister notifier after failover finished.
>       * Besides, colo_delay_timer and colo_checkpoint_sem can't be
> -     * released befor unregister notifier, or there will be use-after-free
> +     * released before unregister notifier, or there will be use-after-free
>       * error.
>       */
>      colo_compare_unregister_notifier(&packets_compare_notifier);
> diff --git a/migration/multifd.c b/migration/multifd.c
> index d0441202aa..ac84a61797 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -731,7 +731,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>          qemu_sem_post(&p->sem_sync);
>          /*
>           * Although multifd_send_thread is not created, but main migration
> -         * thread neet to judge whether it is running, so we need to mark
> +         * thread needs to judge whether it is running, so we need to mark
>           * its status.
>           */
>          p->quit = true;
> @@ -1042,7 +1042,7 @@ bool multifd_recv_all_channels_created(void)
>  
>  /*
>   * Try to receive all multifd channels to get ready for the migration.
> - * - Return true and do not set @errp when correctly receving all channels;
> + * - Return true and do not set @errp when correctly receiving all channels;
>   * - Return false and do not set @errp when correctly receiving the current one;
>   * - Return false and set @errp when failing to receive the current channel.
>   */
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 1bb22f2b6c..baf094ba3a 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -237,7 +237,7 @@ release_ufd:
>   * request_ufd_features: this function should be called only once on a newly
>   * opened ufd, subsequent calls will lead to error.
>   *
> - * Returns: true on succes
> + * Returns: true on success
>   *
>   * @ufd: fd obtained from userfaultfd syscall
>   * @features: bit mask see UFFD_API_FEATURES
> @@ -807,7 +807,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
>  
>      low_time_offset = get_low_time_offset(dc);
>      /* lookup cpu, to clear it,
> -     * that algorithm looks straighforward, but it's not
> +     * that algorithm looks straightforward, but it's not
>       * optimal, more optimal algorithm is keeping tree or hash
>       * where key is address value is a list of  */
>      for (i = 0; i < smp_cpus; i++) {
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index 9941feb63a..6d2b3cf124 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -161,7 +161,7 @@ struct PostCopyFD {
>   */
>  void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
>  void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
> -/* Call each of the shared 'waker's registerd telling them of
> +/* Call each of the shared 'waker's registered telling them of
>   * availability of a block.
>   */
>  int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset);
> diff --git a/migration/ram.c b/migration/ram.c
> index 76d4fee5d5..c5f36aeae5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -256,7 +256,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
>      /*
>       * Always use little endian when sending the bitmap. This is
>       * required that when source and destination VMs are not using the
> -     * same endianess. (Note: big endian won't work.)
> +     * same endianness. (Note: big endian won't work.)
>       */
>      bitmap_to_le(le_bitmap, block->receivedmap, nbits);
>  
> @@ -275,7 +275,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
>      qemu_put_buffer(file, (const uint8_t *)le_bitmap, size);
>      /*
>       * Mark as an end, in case the middle part is screwed up due to
> -     * some "misterious" reason.
> +     * some "mysterious" reason.
>       */
>      qemu_put_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);
>      qemu_fflush(file);
> @@ -718,7 +718,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>      /*
>       * Reaching here means the page has hit the xbzrle cache, no matter what
>       * encoding result it is (normal encoding, overflow or skipping the page),
> -     * count the page as encoded. This is used to caculate the encoding rate.
> +     * count the page as encoded. This is used to calculate the encoding rate.
>       *
>       * Example: 2 pages (8KB) being encoded, first page encoding generates 2KB,
>       * 2nd page turns out to be skipped (i.e. no new bytes written to the
> @@ -3705,7 +3705,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
>  
>      /*
>       * Note: see comments in ramblock_recv_bitmap_send() on why we
> -     * need the endianess convertion, and the paddings.
> +     * need the endianness conversion, and the paddings.
>       */
>      local_size = ROUND_UP(local_size, 8);
>  
> @@ -3743,7 +3743,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
>      }
>  
>      /*
> -     * Endianess convertion. We are during postcopy (though paused).
> +     * Endianness conversion. We are during postcopy (though paused).
>       * The dirty bitmap won't change. We can directly modify it.
>       */
>      bitmap_from_le(block->bmap, le_bitmap, nbits);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 1dc563ec3f..8f43d69b06 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1511,7 +1511,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
>      } else {
>          /* This is the source side, we're in a separate thread
>           * or destination prior to migration_fd_process_incoming()
> -         * after postcopy, the destination also in a seprate thread.
> +         * after postcopy, the destination also in a separate thread.
>           * we can't yield; so we have to poll the fd.
>           * But we need to be able to handle 'cancel' or an error
>           * without hanging forever.
> @@ -2268,7 +2268,7 @@ static inline int qemu_rdma_buffer_mergable(RDMAContext *rdma,
>   *    chunk, then start a new chunk and flush() the old chunk.
>   * 3. To keep the hardware busy, we also group chunks into batches
>   *    and only require that a batch gets acknowledged in the completion
> - *    qeueue instead of each individual chunk.
> + *    queue instead of each individual chunk.
>   */
>  static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
>                             uint64_t block_offset, uint64_t offset,
> @@ -3150,7 +3150,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
>      if (size > 0) {
>          /*
>           * Add this page to the current 'chunk'. If the chunk
> -         * is full, or the page doen't belong to the current chunk,
> +         * is full, or the page doesn't belong to the current chunk,
>           * an actual RDMA write will occur and a new chunk will be formed.
>           */
>          ret = qemu_rdma_write(f, rdma, block_offset, offset, size);
> @@ -4103,7 +4103,7 @@ void rdma_start_outgoing_migration(void *opaque,
>          goto err;
>      }
>  
> -    /* RDMA postcopy need a seprate queue pair for return path */
> +    /* RDMA postcopy need a separate queue pair for return path */
>      if (migrate_postcopy()) {
>          rdma_return_path = qemu_rdma_data_init(host_port, errp);
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 304d98ff78..ee21e981ba 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2795,7 +2795,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
>  
>      if (!has_live) {
>          /* live default to true so old version of Xen tool stack can have a
> -         * successfull live migration */
> +         * successful live migration */
>          live = true;
>      }
>  
> @@ -2818,7 +2818,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
>           * "xen-save-devices-state" and in case of migration failure, libxl
>           * would call "cont".
>           * So call bdrv_inactivate_all (release locks) here to let the other
> -         * side of the migration take controle of the images.
> +         * side of the migration take control of the images.
>           */
>          if (live && !saved_vm_running) {
>              ret = bdrv_inactivate_all();
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


