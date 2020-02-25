Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDA3C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 02:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993D924653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 02:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="C3CGJGda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993D924653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6QLb-0003tW-Ms
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 21:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1j6QL1-0003SF-U5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 21:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1j6QL0-0004AL-Cm
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 21:52:47 -0500
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:35897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1j6QL0-00049u-6t
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 21:52:46 -0500
Received: by mail-yw1-xc42.google.com with SMTP id n184so6415513ywc.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 18:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IYzvqP7ygaHee3dmJBcMx/vXai2Do3cQlVKcWvnL7tU=;
 b=C3CGJGdaCFAKOMFocpM9SQRjVAq+G6MgHGNliQPMNOageHL0TzwIfNQpKeb+6+A1zx
 Cr7cBwK+TWGVywN3pg2qCkS2MfBBqFPamxKxlkemloFA9z/s3/FAo/OA32W9e6qKpRS6
 3sA48PEbUjFiWKfoncWQngGa1e62QJbkiKLaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IYzvqP7ygaHee3dmJBcMx/vXai2Do3cQlVKcWvnL7tU=;
 b=Ud5zE/7Oul/xCS02ioD+CdsA8+0PDvtcOxUjhL54wqjy6/fgaGYnckNXlynJxPI92q
 rQ8TFHH2P25Xjotzn8N4Rk3g3kWSUNwNLSI8MZET/vb8axl/cdGfIUsCoLhA8BjA8ATc
 8dzHowkyFNyZPkS4XbyhO4p91hTCEbpJcGNCqYSZ1ZFa2VsjH5pxqsZh1c8KNVnPE9dK
 Bjx5K1Fj29/kV0PYoO3qRy4zt7sxSnE/hPTeBe5bLJvpNzfHqSEGd3oJJE7AB8AnQp1s
 GMEgPbjXFssi6KGzZPU+swuLEkF93ykb5GE+g8RBRyP3Fqi6fyoPnqb7Gsv+TQrKwguj
 HnxA==
X-Gm-Message-State: APjAAAVolsUsXYQ4A3ZML31qJG/PeauZpI581cfuY8rayEuz5SQIS+Qy
 cQK6roTU0pHZ7JwgfpWYTk4mqxznqURdFozopP7YZg==
X-Google-Smtp-Source: APXvYqxyohAiRECn2nTznC31t5839XeA0Tn79SyeRkI8a4yp/1qrAVlvjqrh4o6m73wGE3QLraJAldPjcdwsgNNUwqM=
X-Received: by 2002:a25:685:: with SMTP id 127mr30560568ybg.517.1582599165152; 
 Mon, 24 Feb 2020 18:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
 <20200224065414.36524-5-zhang.zhanghailiang@huawei.com>
In-Reply-To: <20200224065414.36524-5-zhang.zhanghailiang@huawei.com>
From: Daniel Cho <danielcho@qnap.com>
Date: Tue, 25 Feb 2020 10:52:31 +0800
Message-ID: <CA+XQNE4+JnTxdROOpWo6ZjxL7k0R_5bAtUT=oOsurMM6Y9e61g@mail.gmail.com>
Subject: Re: [PATCH V2 4/8] COLO: Optimize memory back-up process
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Hailiang,

With version 2, the code in migration/ram.c

+            if (migration_incoming_colo_enabled()) {
+                if (migration_incoming_in_colo_state()) {
+                    /* In COLO stage, put all pages into cache temporarily=
 */
+                    host =3D colo_cache_from_block_offset(block, addr);
+                } else {
+                   /*
+                    * In migration stage but before COLO stage,
+                    * Put all pages into both cache and SVM's memory.
+                    */
+                    host_bak =3D colo_cache_from_block_offset(block, addr)=
;
+                }
             }
             if (!host) {
                 error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
                 ret =3D -EINVAL;
                 break;
             }

host =3D colo_cache_from_block_offset(block, addr);
host_bak =3D colo_cache_from_block_offset(block, addr);
Does it cause the "if(!host)" will go break if the condition goes
"host_bak =3D colo_cache_from_block_offset(block, addr);" ?

Best regards,
Daniel Cho

zhanghailiang <zhang.zhanghailiang@huawei.com> =E6=96=BC 2020=E5=B9=B42=E6=
=9C=8824=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:55=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> This patch will reduce the downtime of VM for the initial process,
> Privously, we copied all these memory in preparing stage of COLO
> while we need to stop VM, which is a time-consuming process.
> Here we optimize it by a trick, back-up every page while in migration
> process while COLO is enabled, though it affects the speed of the
> migration, but it obviously reduce the downtime of back-up all SVM'S
> memory in COLO preparing stage.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>  migration/colo.c |  3 +++
>  migration/ram.c  | 68 +++++++++++++++++++++++++++++++++++-------------
>  migration/ram.h  |  1 +
>  3 files changed, 54 insertions(+), 18 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index 93c5a452fb..44942c4e23 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -26,6 +26,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/rcu.h"
>  #include "migration/failover.h"
> +#include "migration/ram.h"
>  #ifdef CONFIG_REPLICATION
>  #include "replication.h"
>  #endif
> @@ -845,6 +846,8 @@ void *colo_process_incoming_thread(void *opaque)
>       */
>      qemu_file_set_blocking(mis->from_src_file, true);
>
> +    colo_incoming_start_dirty_log();
> +
>      bioc =3D qio_channel_buffer_new(COLO_BUFFER_BASE_SIZE);
>      fb =3D qemu_fopen_channel_input(QIO_CHANNEL(bioc));
>      object_unref(OBJECT(bioc));
> diff --git a/migration/ram.c b/migration/ram.c
> index ed23ed1c7c..ebf9e6ba51 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2277,6 +2277,7 @@ static void ram_list_init_bitmaps(void)
>               * dirty_memory[DIRTY_MEMORY_MIGRATION] don't include the wh=
ole
>               * guest memory.
>               */
> +
>              block->bmap =3D bitmap_new(pages);
>              bitmap_set(block->bmap, 0, pages);
>              block->clear_bmap_shift =3D shift;
> @@ -2986,7 +2987,6 @@ int colo_init_ram_cache(void)
>                  }
>                  return -errno;
>              }
> -            memcpy(block->colo_cache, block->host, block->used_length);
>          }
>      }
>
> @@ -3000,19 +3000,36 @@ int colo_init_ram_cache(void)
>
>          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>              unsigned long pages =3D block->max_length >> TARGET_PAGE_BIT=
S;
> -
>              block->bmap =3D bitmap_new(pages);
> -            bitmap_set(block->bmap, 0, pages);
>          }
>      }
> -    ram_state =3D g_new0(RAMState, 1);
> -    ram_state->migration_dirty_pages =3D 0;
> -    qemu_mutex_init(&ram_state->bitmap_mutex);
> -    memory_global_dirty_log_start();
>
> +    ram_state_init(&ram_state);
>      return 0;
>  }
>
> +/* TODO: duplicated with ram_init_bitmaps */
> +void colo_incoming_start_dirty_log(void)
> +{
> +    RAMBlock *block =3D NULL;
> +    /* For memory_global_dirty_log_start below. */
> +    qemu_mutex_lock_iothread();
> +    qemu_mutex_lock_ramlist();
> +
> +    memory_global_dirty_log_sync();
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +            ramblock_sync_dirty_bitmap(ram_state, block);
> +            /* Discard this dirty bitmap record */
> +            bitmap_zero(block->bmap, block->max_length >> TARGET_PAGE_BI=
TS);
> +        }
> +        memory_global_dirty_log_start();
> +    }
> +    ram_state->migration_dirty_pages =3D 0;
> +    qemu_mutex_unlock_ramlist();
> +    qemu_mutex_unlock_iothread();
> +}
> +
>  /* It is need to hold the global lock to call this helper */
>  void colo_release_ram_cache(void)
>  {
> @@ -3032,9 +3049,7 @@ void colo_release_ram_cache(void)
>              }
>          }
>      }
> -    qemu_mutex_destroy(&ram_state->bitmap_mutex);
> -    g_free(ram_state);
> -    ram_state =3D NULL;
> +    ram_state_cleanup(&ram_state);
>  }
>
>  /**
> @@ -3302,7 +3317,6 @@ static void colo_flush_ram_cache(void)
>              ramblock_sync_dirty_bitmap(ram_state, block);
>          }
>      }
> -
>      trace_colo_flush_ram_cache_begin(ram_state->migration_dirty_pages);
>      WITH_RCU_READ_LOCK_GUARD() {
>          block =3D QLIST_FIRST_RCU(&ram_list.blocks);
> @@ -3348,7 +3362,7 @@ static int ram_load_precopy(QEMUFile *f)
>
>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr, total_ram_bytes;
> -        void *host =3D NULL;
> +        void *host =3D NULL, *host_bak =3D NULL;
>          uint8_t ch;
>
>          /*
> @@ -3379,20 +3393,35 @@ static int ram_load_precopy(QEMUFile *f)
>                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)=
) {
>              RAMBlock *block =3D ram_block_from_stream(f, flags);
>
> +            host =3D host_from_ram_block_offset(block, addr);
>              /*
> -             * After going into COLO, we should load the Page into colo_=
cache.
> +             * After going into COLO stage, we should not load the page
> +             * into SVM's memory diretly, we put them into colo_cache fi=
rstly.
> +             * NOTE: We need to keep a copy of SVM's ram in colo_cache.
> +             * Privously, we copied all these memory in preparing stage =
of COLO
> +             * while we need to stop VM, which is a time-consuming proce=
ss.
> +             * Here we optimize it by a trick, back-up every page while =
in
> +             * migration process while COLO is enabled, though it affect=
s the
> +             * speed of the migration, but it obviously reduce the downt=
ime of
> +             * back-up all SVM'S memory in COLO preparing stage.
>               */
> -            if (migration_incoming_in_colo_state()) {
> -                host =3D colo_cache_from_block_offset(block, addr);
> -            } else {
> -                host =3D host_from_ram_block_offset(block, addr);
> +            if (migration_incoming_colo_enabled()) {
> +                if (migration_incoming_in_colo_state()) {
> +                    /* In COLO stage, put all pages into cache temporari=
ly */
> +                    host =3D colo_cache_from_block_offset(block, addr);
> +                } else {
> +                   /*
> +                    * In migration stage but before COLO stage,
> +                    * Put all pages into both cache and SVM's memory.
> +                    */
> +                    host_bak =3D colo_cache_from_block_offset(block, add=
r);
> +                }
>              }
>              if (!host) {
>                  error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
>                  ret =3D -EINVAL;
>                  break;
>              }
> -
>              if (!migration_incoming_in_colo_state()) {
>                  ramblock_recv_bitmap_set(block, host);
>              }
> @@ -3506,6 +3535,9 @@ static int ram_load_precopy(QEMUFile *f)
>          if (!ret) {
>              ret =3D qemu_file_get_error(f);
>          }
> +        if (!ret && host_bak) {
> +            memcpy(host_bak, host, TARGET_PAGE_SIZE);
> +        }
>      }
>
>      ret |=3D wait_for_decompress_done();
> diff --git a/migration/ram.h b/migration/ram.h
> index a553d40751..5ceaff7cb4 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -66,5 +66,6 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock=
 *rb);
>  /* ram cache */
>  int colo_init_ram_cache(void);
>  void colo_release_ram_cache(void);
> +void colo_incoming_start_dirty_log(void);
>
>  #endif
> --
> 2.21.0
>
>

