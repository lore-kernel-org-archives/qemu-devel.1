Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470B8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 22:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F790207C4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 22:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9N0Srmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F790207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyjWe-0005Og-9V
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 18:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyjVL-0004hV-Kg
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 18:15:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyjVH-0007sC-I1
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 18:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595542549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVvnxWS13xfsq6FWFaNQTONY6YgV1CliCUU1aUkAFfk=;
 b=e9N0SrmqEz4K8uyGfEkbuUdAigEOPgNj2zlMZ0f3Ya+ClG6Mb6YWan1LuwEjarsjY7Vn1S
 YGBE7CqJGbtKfpRtUh5eAbnAnOIvfy8SLg4GyAtQefv4nv+xGq9+FF2jp5lW4hqPszMA+8
 BAKlgcKDc3buUu3ifLRmwVLWCi+jtQo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-sL0C_nDRPEOkpRnidQie9A-1; Thu, 23 Jul 2020 18:15:47 -0400
X-MC-Unique: sL0C_nDRPEOkpRnidQie9A-1
Received: by mail-qt1-f198.google.com with SMTP id k9so4673669qth.17
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 15:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cVvnxWS13xfsq6FWFaNQTONY6YgV1CliCUU1aUkAFfk=;
 b=ePNnC2d8DHEICeUqIX0Pon1FS1Wghqlge9zz9w1QC+c4mU8+KuVh/GAq+rFEr/ejuN
 9mo8DaF6TjcPLqF0MbPK1vH8g4cA2D0yTgcMM0TAXJjC/xYqLJFOqHgC5wf6pMVM1Ymo
 G0XJuQYLQtZ4klBz9/UeNBaz4xcjx6dtjbFh+Yorn64/+TTB20CiiCGy4dUhGBPXNibH
 vhUG4537jROp3ogyEgE3ffiWCqhf5szMg/40Y0Wgb8RUX1VjdDV+EWYhJqFf4o9XM9kx
 uqKXDWLDqyjCN3M2+2stgAY/ps/N25m2Ia0S6s93U4ZOLGpcf4zYxknRgONLH4dlOljV
 Kshg==
X-Gm-Message-State: AOAM533kWQ9SKhCgDDt5Van60twCamjlpkfWi90uSXWh/DsiSKsKRb7P
 /OzXmsdcugisDL1Uk15HEVdj2yE83B4mO/Yj4+tZQHOP3gR7Jnqk9Qf7xIAagAWIOtKrxcZNzU5
 geZ/ZkIVzmw81+VA=
X-Received: by 2002:aed:21da:: with SMTP id m26mr6614386qtc.197.1595542547260; 
 Thu, 23 Jul 2020 15:15:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0GaeZ8p3ju510VsQV6mPO6pmvz1YDHimZFr8jjTLoftFRY13F/yiriUvcfWLgwCvP1TcmwA==
X-Received: by 2002:aed:21da:: with SMTP id m26mr6614351qtc.197.1595542546922; 
 Thu, 23 Jul 2020 15:15:46 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id u21sm3963472qkk.1.2020.07.23.15.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 15:15:46 -0700 (PDT)
Date: Thu, 23 Jul 2020 18:15:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 3/4] migration: add background snapshot
Message-ID: <20200723221544.GC831087@xz-x1>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722081133.29926-4-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200722081133.29926-4-dplotnikov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, den@openvz.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 11:11:32AM +0300, Denis Plotnikov wrote:
> +static void *background_snapshot_thread(void *opaque)
> +{
> +    MigrationState *m = opaque;
> +    QIOChannelBuffer *bioc;
> +    QEMUFile *fb;
> +    int res = 0;
> +
> +    rcu_register_thread();
> +
> +    qemu_file_set_rate_limit(m->to_dst_file, INT64_MAX);
> +
> +    qemu_mutex_lock_iothread();
> +    vm_stop(RUN_STATE_PAUSED);
> +
> +    qemu_savevm_state_header(m->to_dst_file);
> +    qemu_mutex_unlock_iothread();
> +    qemu_savevm_state_setup(m->to_dst_file);

Is it intended to skip bql for the setup phase?  IIUC the main thread could
start the vm before we take the lock again below if we released it...

> +    qemu_mutex_lock_iothread();
> +
> +    migrate_set_state(&m->state, MIGRATION_STATUS_SETUP,
> +                      MIGRATION_STATUS_ACTIVE);
> +
> +    /*
> +     * We want to save the vm state for the moment when the snapshot saving was
> +     * called but also we want to write RAM content with vm running. The RAM
> +     * content should appear first in the vmstate.
> +     * So, we first, save non-ram part of the vmstate to the temporary, buffer,
> +     * then write ram part of the vmstate to the migration stream with vCPUs
> +     * running and, finally, write the non-ram part of the vmstate from the
> +     * buffer to the migration stream.
> +     */
> +    bioc = qio_channel_buffer_new(4096);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vmstate-buffer");
> +    fb = qemu_fopen_channel_output(QIO_CHANNEL(bioc));
> +    object_unref(OBJECT(bioc));
> +
> +    if (ram_write_tracking_start()) {
> +        goto failed_resume;
> +    }
> +
> +    if (global_state_store()) {
> +        goto failed_resume;
> +    }

Is this needed?  We should be always in stopped state here, right?

> +
> +    cpu_synchronize_all_states();
> +
> +    if (qemu_savevm_state_complete_precopy_non_iterable(fb, false, false)) {
> +        goto failed_resume;
> +    }
> +
> +    vm_start();
> +    qemu_mutex_unlock_iothread();
> +
> +    while (!res) {
> +        res = qemu_savevm_state_iterate(m->to_dst_file, false);
> +
> +        if (res < 0 || qemu_file_get_error(m->to_dst_file)) {
> +            goto failed;
> +        }
> +    }
> +
> +    /*
> +     * By this moment we have RAM content saved into the migration stream.
> +     * The next step is to flush the non-ram content (vm devices state)
> +     * right after the ram content. The device state was stored in
> +     * the temporary buffer prior to the ram saving.
> +     */
> +    qemu_put_buffer(m->to_dst_file, bioc->data, bioc->usage);
> +    qemu_fflush(m->to_dst_file);
> +
> +    if (qemu_file_get_error(m->to_dst_file)) {
> +        goto failed;
> +    }
> +
> +    migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
> +                                 MIGRATION_STATUS_COMPLETED);
> +    goto exit;
> +
> +failed_resume:
> +    vm_start();
> +    qemu_mutex_unlock_iothread();
> +failed:
> +    migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
> +                      MIGRATION_STATUS_FAILED);
> +exit:
> +    ram_write_tracking_stop();
> +    qemu_fclose(fb);
> +    qemu_mutex_lock_iothread();
> +    qemu_savevm_state_cleanup();
> +    qemu_mutex_unlock_iothread();
> +    rcu_unregister_thread();
> +    return NULL;
> +}
> +
>  void migrate_fd_connect(MigrationState *s, Error *error_in)
>  {
>      Error *local_err = NULL;
> @@ -3599,8 +3694,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>          migrate_fd_cleanup(s);
>          return;
>      }
> -    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
> -                       QEMU_THREAD_JOINABLE);
> +    if (migrate_background_snapshot()) {
> +        qemu_thread_create(&s->thread, "bg_snapshot",

Maybe the name "live_snapshot" suites more (since the other one is
"live_migration")?

> +                           background_snapshot_thread, s,
> +                           QEMU_THREAD_JOINABLE);
> +    } else {
> +        qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
> +                           QEMU_THREAD_JOINABLE);
> +    }
>      s->migration_thread_running = true;
>  }
>  

[...]

> @@ -1151,9 +1188,11 @@ static int save_normal_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
>      ram_counters.transferred += save_page_header(rs, rs->f, block,
>                                                   offset | RAM_SAVE_FLAG_PAGE);
>      if (async) {
> -        qemu_put_buffer_async(rs->f, buf, TARGET_PAGE_SIZE,
> -                              migrate_release_ram() &
> -                              migration_in_postcopy());
> +        bool may_free = migrate_background_snapshot() ||
> +                        (migrate_release_ram() &&
> +                         migration_in_postcopy());

Does background snapshot need to free the memory?  /me confused..

> +
> +        qemu_put_buffer_async(rs->f, buf, TARGET_PAGE_SIZE, may_free);
>      } else {
>          qemu_put_buffer(rs->f, buf, TARGET_PAGE_SIZE);
>      }

[...]

> +void ram_block_list_create(void)
> +{
> +    RAMBlock *block = NULL;
> +    RamBlockList *block_list = ram_bgs_block_list_get();
> +
> +    qemu_mutex_lock_ramlist();
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        memory_region_ref(block->mr);
> +        QLIST_INSERT_HEAD(block_list, block, bgs_next);
> +    }
> +    qemu_mutex_unlock_ramlist();

This kind of duplicate with ram_list.blocks itself...

> +}
> +
> +static int page_fault_fd;
> +static int thread_quit_fd;
> +static QemuThread page_fault_thread;
> +
> +static int mem_change_wp(void *addr, uint64_t length, bool protect)
> +{
> +    struct uffdio_writeprotect wp = { 0 };
> +
> +    assert(page_fault_fd);
> +
> +    if (protect) {
> +        struct uffdio_register reg = { 0 };
> +
> +        reg.mode = UFFDIO_REGISTER_MODE_WP;
> +        reg.range.start = (uint64_t) addr;
> +        reg.range.len = length;
> +
> +        if (ioctl(page_fault_fd, UFFDIO_REGISTER, &reg)) {
> +            error_report("Can't register memeory at %p len: %"PRIu64
> +                         " for page fault interception", addr, length);
> +            return -1;
> +        }

IMHO it's better to move the register out of mem_change_wp().  mem_change_wp()
should be in page granularity, while we should be clear in the code that the
registeration is happening per-ramblock.

Btw, is UFFDIO_UNREGISTER missing in the whole process?

> +
> +        wp.mode = UFFDIO_WRITEPROTECT_MODE_WP;
> +    }

[...]

> @@ -2338,6 +2881,11 @@ static void ram_list_init_bitmaps(void)
>              bitmap_set(block->bmap, 0, pages);
>              block->clear_bmap_shift = shift;
>              block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
> +
> +            if (migrate_background_snapshot()) {
> +                block->touched_map = bitmap_new(pages);
> +                block->copied_map = bitmap_new(pages);
> +            }

We should be able to avoid allocating bmap & clear_bmap for snapshots.  Or we
can also directly reuse the two bitmaps?

-- 
Peter Xu


