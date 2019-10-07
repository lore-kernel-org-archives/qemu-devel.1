Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8CCC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEBB21479
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEBB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHUHw-00066w-Rw
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dann.frazier@canonical.com>) id 1iHUFd-0004QA-I7
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dann.frazier@canonical.com>) id 1iHUFa-00088L-OA
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:44:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dann.frazier@canonical.com>)
 id 1iHUFa-00087N-GF
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:44:38 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <dann.frazier@canonical.com>) id 1iHUFX-0004WK-Cn
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:44:35 +0000
Received: by mail-io1-f69.google.com with SMTP id f9so27100973ioh.6
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 07:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Qz0cNZx7tN0+PqIxSXAiFM8scEeNgD2Q1wMag7r7P6o=;
 b=cv9iUR1RG4SPDbH7u/RbkYlqUWNzBlIqkBfg1Dr/ZJnuCqGHQ5pYULp9+qNy/VNGQi
 cPNazbX8/pHdHE5EWIln/fHOKnUt6fBUwCgyUMfjU95WUBdaILhWpnY5UmkEBhA4Ayfy
 yANnaGXK8o+brboVNT2dyGb/K8v8jICD/HuBJcWfIQAwbj5aj2sjvuv2xrJ+gSWjwDFG
 dSVtCATLIJJ7LCNwQLwKhubqjI+WclTBrb74fczNhBI4R5TKRwQypTCICRSbFJTVDj2W
 BV73uOYoAJHyIV3ZkT+VG7aK0Xesn71A2xC5RV/Pf8VSCLEAwDg3kCsSGZpyj090reLE
 V7lA==
X-Gm-Message-State: APjAAAXq9Anjrxx4w5PgcjsvmVjmyvzzRsj5zWd7U5Fo2B3ScHjNvbTW
 dPm+m6DBgc48xWrCxx+DKzCy9f/gOwQhidvukCx/kIsAX/P++nzvU9fJ6bKQBwREehUVgLpGQrJ
 6cI5y+neWxW5/zGFQFHhUFazYAs+9Bno4
X-Received: by 2002:a5d:8911:: with SMTP id b17mr12261780ion.287.1570459474311; 
 Mon, 07 Oct 2019 07:44:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzRIt9HFuwleVAM3KbcYDYO/E8XE1RpWo5xqluX8wIUYyIBhH0ebeLqLcP0cGjibsg3+F2LQw==
X-Received: by 2002:a5d:8911:: with SMTP id b17mr12261752ion.287.1570459473926; 
 Mon, 07 Oct 2019 07:44:33 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net.
 [71.56.235.36])
 by smtp.gmail.com with ESMTPSA id 197sm6125516ioc.78.2019.10.07.07.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 07:44:33 -0700 (PDT)
Date: Mon, 7 Oct 2019 08:44:32 -0600
From: dann frazier <dann.frazier@canonical.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
Message-ID: <20191007144432.GA29958@xps13.dannf>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 lizhengui <lizhengui@huawei.com>, Jan Glauber <jglauber@marvell.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1805256 <1805256@bugs.launchpad.net>,
 QEMU Developers - ARM <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 01:06:20PM +0200, Paolo Bonzini wrote:
> On 02/10/19 11:23, Jan Glauber wrote:
> > I've looked into this on ThunderX2. The arm64 code generated for the
> > atomic_[add|sub] accesses of ctx->notify_me doesn't contain any
> > memory barriers. It is just plain ldaxr/stlxr.
> > 
> > From my understanding this is not sufficient for SMP sync.
> > 
> > If I read this comment correct:
> > 
> >     void aio_notify(AioContext *ctx)
> >     {
> >         /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
> >          * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
> >          */
> >         smp_mb();
> >         if (ctx->notify_me) {
> > 
> > it points out that the smp_mb() should be paired. But as
> > I said the used atomics don't generate any barriers at all.
> 
> Based on the rest of the thread, this patch should also fix the bug:
> 
> diff --git a/util/async.c b/util/async.c
> index 47dcbfa..721ea53 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -249,7 +249,7 @@ aio_ctx_check(GSource *source)
>      aio_notify_accept(ctx);
>  
>      for (bh = ctx->first_bh; bh; bh = bh->next) {
> -        if (bh->scheduled) {
> +        if (atomic_mb_read(&bh->scheduled)) {
>              return true;
>          }
>      }
> 
> 
> And also the memory barrier in aio_notify can actually be replaced
> with a SEQ_CST load:
> 
> diff --git a/util/async.c b/util/async.c
> index 47dcbfa..721ea53 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -349,11 +349,11 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
>  
>  void aio_notify(AioContext *ctx)
>  {
> -    /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
> -     * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
> +    /* Using atomic_mb_read ensures that e.g. bh->scheduled is written before
> +     * ctx->notify_me is read.  Pairs with atomic_or in aio_ctx_prepare or
> +     * atomic_add in aio_poll.
>       */
> -    smp_mb();
> -    if (ctx->notify_me) {
> +    if (atomic_mb_read(&ctx->notify_me)) {
>          event_notifier_set(&ctx->notifier);
>          atomic_mb_set(&ctx->notified, true);
>      }
> 
> 
> Would you be able to test these (one by one possibly)?

Paolo,
  I tried them both separately and together on a Hi1620 system, each
time it hung in the first iteration. Here's a backtrace of a run with
both patches applied:

(gdb) thread apply all bt

Thread 3 (Thread 0xffff8154b820 (LWP 63900)):
#0  0x0000ffff8b9402cc in __GI___sigtimedwait (set=<optimized out>, set@entry=0xaaaaf1e08070, 
    info=info@entry=0xffff8154ad98, timeout=timeout@entry=0x0) at ../sysdeps/unix/sysv/linux/sigtimedwait.c:42
#1  0x0000ffff8ba77fac in __sigwait (set=set@entry=0xaaaaf1e08070, sig=sig@entry=0xffff8154ae74)
    at ../sysdeps/unix/sysv/linux/sigwait.c:28
#2  0x0000aaaab7dc1610 in sigwait_compat (opaque=0xaaaaf1e08070) at util/compatfd.c:35
#3  0x0000aaaab7dc3e80 in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:519
#4  0x0000ffff8ba6d088 in start_thread (arg=0xffffceefbf4f) at pthread_create.c:463
#5  0x0000ffff8b9dd4ec in thread_start () at ../sysdeps/unix/sysv/linux/aarch64/clone.S:78

Thread 2 (Thread 0xffff81d4c820 (LWP 63899)):
#0  syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
#1  0x0000aaaab7dc4cd8 in qemu_futex_wait (val=<optimized out>, f=<optimized out>)
    at /home/ubuntu/qemu/include/qemu/futex.h:29
#2  qemu_event_wait (ev=ev@entry=0xaaaab7e48708 <rcu_call_ready_event>) at util/qemu-thread-posix.c:459
#3  0x0000aaaab7ddf44c in call_rcu_thread (opaque=<optimized out>) at util/rcu.c:260
#4  0x0000aaaab7dc3e80 in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:519
#5  0x0000ffff8ba6d088 in start_thread (arg=0xffffceefc05f) at pthread_create.c:463
#6  0x0000ffff8b9dd4ec in thread_start () at ../sysdeps/unix/sysv/linux/aarch64/clone.S:78

Thread 1 (Thread 0xffff81e83010 (LWP 63898)):
#0  0x0000ffff8b9d4154 in __GI_ppoll (fds=0xaaaaf1e0dbc0, nfds=187650205809964, timeout=<optimized out>, 
    timeout@entry=0x0, sigmask=0xffffceefbef0) at ../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x0000aaaab7dbedb0 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>)
    at /usr/include/aarch64-linux-gnu/bits/poll2.h:77
#2  qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=-1) at util/qemu-timer.c:340
#3  0x0000aaaab7dbfd2c in os_host_main_loop_wait (timeout=-1) at util/main-loop.c:236
#4  main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:517
#5  0x0000aaaab7ce86e8 in convert_do_copy (s=0xffffceefc068) at qemu-img.c:2028
#6  img_convert (argc=<optimized out>, argv=<optimized out>) at qemu-img.c:2520
#7  0x0000aaaab7ce1e54 in main (argc=8, argv=<optimized out>) at qemu-img.c:5097

> > I've tried to verify me theory with this patch and didn't run into the
> > issue for ~500 iterations (usually I would trigger the issue ~20 iterations).
> 
> Sorry for asking the obvious---500 iterations of what?

$ for i in $(seq 1 500); do echo "==$i=="; ./qemu/qemu-img convert -p -f qcow2 -O qcow2 bionic-server-cloudimg-arm64.img out.img; done
==1==
    (37.19/100%)

  -dann

