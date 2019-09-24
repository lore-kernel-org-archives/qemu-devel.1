Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A87C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B2E2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B2E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrX0-0003Wl-8X
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dann.frazier@canonical.com>) id 1iCrNF-0002jL-PU
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dann.frazier@canonical.com>) id 1iCrNE-0001hA-11
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:25:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52719)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dann.frazier@canonical.com>)
 id 1iCrND-0001em-NR
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:25:23 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <dann.frazier@canonical.com>) id 1iCrNA-0001Su-0F
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:25:20 +0000
Received: by mail-io1-f72.google.com with SMTP id w8so4974435iol.20
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+ayamWpTrHWPZCsI6div5JRAFtqTW96w8LUiO9oH6j8=;
 b=pllkvpS0Zp3UL/cdTf+U57muN7VO/Obk3q7zee/WLhgHYyeNwpgkwESzrBL70SoqlM
 JalLbKPJXHARn01wUoeSAGPn7uSWksUOOU5y236iqyrkeU9CJzpPjdOkTQNlPNH7vw3a
 jF36m0Yb7f7cG9MJVDNaHJqnmRtZNEnRkMLIN9AfnPA0HfVOmtKaJFj1APRZBrp2I7zk
 8G31cTwaPxWcErgtMjS2EFZ5+g1p4k8YT2Hp2edIu2EfmpVfUigHtZeKjps/FX8zETZ2
 PUHwsuZeX4Yl38h7NHhg0y2QbJffvq20J3oSftSyKWeeLqAv/sFr/WoV5zoDp3jvU88J
 APvA==
X-Gm-Message-State: APjAAAVHGxinvUKt9adBDD1P18T6rF+Z6cm4nq6n4VExupfrX8+NjRNi
 yUzvb+Tv/JocGHFUf1xc2lpgJh8nY710oLeL47oGwOOV+Bd1ItqltVB11HnqRsmt0wLdXkR0VAY
 GaHVOVlY9dAxEvfIxYBppNv6yjqxdyu8N
X-Received: by 2002:a02:7f49:: with SMTP id r70mr768907jac.85.1569356718940;
 Tue, 24 Sep 2019 13:25:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEWaNzsLck67Usv3hQveXhhQSoQFnBeKVJvnTQ3MYHAp1NdlBfp4SKfgwW3upxG7Fly0aM6Q==
X-Received: by 2002:a02:7f49:: with SMTP id r70mr768858jac.85.1569356718531;
 Tue, 24 Sep 2019 13:25:18 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net.
 [71.56.235.36])
 by smtp.gmail.com with ESMTPSA id m67sm4944026iof.21.2019.09.24.13.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 13:25:18 -0700 (PDT)
Date: Tue, 24 Sep 2019 14:25:17 -0600
From: dann frazier <dann.frazier@canonical.com>
To: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
Message-ID: <20190924202517.GA21422@xps13.dannf>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
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
Cc: lizhengui <lizhengui@huawei.com>, Jan Glauber <jglauber@marvell.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1805256 <1805256@bugs.launchpad.net>,
 QEMU Developers - ARM <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 04:09:25PM -0300, Rafael David Tinoco wrote:
> > Zhengui's theory that notify_me doesn't work properly on ARM is more
> > promising, but he couldn't provide a clear explanation of why he thought
> > notify_me is involved.  In particular, I would have expected notify_me to
> > be wrong if the qemu_poll_ns call came from aio_ctx_dispatch, for example:
> > 
> > 
> >     glib_pollfds_fill
> >       g_main_context_prepare
> >         aio_ctx_prepare
> >           atomic_or(&ctx->notify_me, 1)
> >     qemu_poll_ns
> >     glib_pollfds_poll
> >       g_main_context_check
> >         aio_ctx_check
> >           atomic_and(&ctx->notify_me, ~1)
> >       g_main_context_dispatch
> >         aio_ctx_dispatch
> >           /* do something for event */
> >             qemu_poll_ns 
> > 
> 
> Paolo,
> 
> I tried confining execution in a single NUMA domain (cpu & mem) and
> still faced the issue, then, I added a mutex "ctx->notify_me_lcktest"
> into context to protect "ctx->notify_me", like showed bellow, and it
> seems to have either fixed or mitigated it.
> 
> I was able to cause the hung once every 3 or 4 runs. I have already ran
> qemu-img convert more than 30 times now and couldn't reproduce it again.
> 
> Next step is to play with the barriers and check why existing ones
> aren't enough for ordering access to ctx->notify_me ... or should I
> try/do something else in your opinion ?
> 
> This arch/machine (Huawei D06):
> 
> $ lscpu
> Architecture:        aarch64
> Byte Order:          Little Endian
> CPU(s):              96
> On-line CPU(s) list: 0-95
> Thread(s) per core:  1
> Core(s) per socket:  48
> Socket(s):           2
> NUMA node(s):        4
> Vendor ID:           0x48
> Model:               0
> Stepping:            0x0
> CPU max MHz:         2000.0000
> CPU min MHz:         200.0000
> BogoMIPS:            200.00
> L1d cache:           64K
> L1i cache:           64K
> L2 cache:            512K
> L3 cache:            32768K
> NUMA node0 CPU(s):   0-23
> NUMA node1 CPU(s):   24-47
> NUMA node2 CPU(s):   48-71
> NUMA node3 CPU(s):   72-95
> Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> cpuid asimdrdm dcpop

Note that I'm also seeing this on a ThunderX2 (same calltrace):

$ lscpu
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              224
On-line CPU(s) list: 0-223
Thread(s) per core:  4
Core(s) per socket:  28
Socket(s):           2
NUMA node(s):        2
Vendor ID:           Cavium
Model:               1
Model name:          ThunderX2 99xx
Stepping:            0x1
BogoMIPS:            400.00
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            32768K
NUMA node0 CPU(s):   0-111
NUMA node1 CPU(s):   112-223
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics cpuid asimdrdm

  -dann

> ----
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 0ca25dfec6..0724086d91 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -84,6 +84,7 @@ struct AioContext {
>       * dispatch phase, hence a simple counter is enough for them.
>       */
>      uint32_t notify_me;
> +    QemuMutex notify_me_lcktest;
> 
>      /* A lock to protect between QEMUBH and AioHandler adders and deleter,
>       * and to ensure that no callbacks are removed while we're walking and
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 51c41ed3c9..031d6e2997 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -529,7 +529,9 @@ static bool run_poll_handlers(AioContext *ctx,
> int64_t max_ns, int64_t *timeout)
>      bool progress;
>      int64_t start_time, elapsed_time;
> 
> +    qemu_mutex_lock(&ctx->notify_me_lcktest);
>      assert(ctx->notify_me);
> +    qemu_mutex_unlock(&ctx->notify_me_lcktest);
>      assert(qemu_lockcnt_count(&ctx->list_lock) > 0);
> 
>      trace_run_poll_handlers_begin(ctx, max_ns, *timeout);
> @@ -601,8 +603,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
>       * so disable the optimization now.
>       */
>      if (blocking) {
> +        qemu_mutex_lock(&ctx->notify_me_lcktest);
>          assert(in_aio_context_home_thread(ctx));
>          atomic_add(&ctx->notify_me, 2);
> +        qemu_mutex_unlock(&ctx->notify_me_lcktest);
>      }
> 
>      qemu_lockcnt_inc(&ctx->list_lock);
> @@ -647,8 +651,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
>      }
> 
>      if (blocking) {
> +        qemu_mutex_lock(&ctx->notify_me_lcktest);
>          atomic_sub(&ctx->notify_me, 2);
>          aio_notify_accept(ctx);
> +        qemu_mutex_unlock(&ctx->notify_me_lcktest);
>      }
> 
>      /* Adjust polling time */
> diff --git a/util/async.c b/util/async.c
> index c10642a385..140e1e86f5 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -221,7 +221,9 @@ aio_ctx_prepare(GSource *source, gint    *timeout)
>  {
>      AioContext *ctx = (AioContext *) source;
> 
> +    qemu_mutex_lock(&ctx->notify_me_lcktest);
>      atomic_or(&ctx->notify_me, 1);
> +    qemu_mutex_unlock(&ctx->notify_me_lcktest);
> 
>      /* We assume there is no timeout already supplied */
>      *timeout = qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));
> @@ -239,8 +241,10 @@ aio_ctx_check(GSource *source)
>      AioContext *ctx = (AioContext *) source;
>      QEMUBH *bh;
> 
> +    qemu_mutex_lock(&ctx->notify_me_lcktest);
>      atomic_and(&ctx->notify_me, ~1);
>      aio_notify_accept(ctx);
> +    qemu_mutex_unlock(&ctx->notify_me_lcktest);
> 
>      for (bh = ctx->first_bh; bh; bh = bh->next) {
>          if (bh->scheduled) {
> @@ -346,11 +350,13 @@ void aio_notify(AioContext *ctx)
>      /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
>       * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
>       */
> -    smp_mb();
> +    //smp_mb();
> +    qemu_mutex_lock(&ctx->notify_me_lcktest);
>      if (ctx->notify_me) {
>          event_notifier_set(&ctx->notifier);
>          atomic_mb_set(&ctx->notified, true);
>      }
> +    qemu_mutex_unlock(&ctx->notify_me_lcktest);
>  }
> 
>  void aio_notify_accept(AioContext *ctx)
> @@ -424,6 +430,8 @@ AioContext *aio_context_new(Error **errp)
>      ctx->co_schedule_bh = aio_bh_new(ctx, co_schedule_bh_cb, ctx);
>      QSLIST_INIT(&ctx->scheduled_coroutines);
> 
> +    qemu_rec_mutex_init(&ctx->notify_me_lcktest);
> +
>      aio_set_event_notifier(ctx, &ctx->notifier,
>                             false,
>                             (EventNotifierHandler *)
> 

