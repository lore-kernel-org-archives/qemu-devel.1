Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34482C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2A52182B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idL0eq9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2A52182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqBHO-0008QE-63
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 03:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36739)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hqBHB-00081e-AS
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hqBH9-00064T-8x
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:01:25 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hqBH8-000619-VF
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:01:23 -0400
Received: by mail-io1-xd43.google.com with SMTP id k20so87298892ios.10
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 00:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ph2dBO2IfKyWX2pM9b7E7M0HLp8TOKSDhq+6mp3G81c=;
 b=idL0eq9xs2vd6/V90fVxCrD0QVz2d4gY6orlXvnTzy/yA4xn3fBNaUQzzse1Ds52+x
 Nt6PGfyl3I6AHZS1SL5FzwUEjOHWkm1s4C1SS5VsRNhLhN+amsXDavnmJ8/LBXXS8jNo
 Ce71bu+S2bnf11iyyWCTnj68UaA7z61Kt+WQJzf6WAj4KEKHS5yd4pufJJ0wLCT0Yngn
 5yiSUMVbsnYrTT6yNzMKuqX6Ly/vyQD+CZak+O5PWp+9i/eKqbugmieKmMHKxR30b7Z7
 YxDYkEvdnK2FgHVxPBZCODgq8iyi8kAm7YaUippo2Cq/R6vl9vPPYh7vcMu5TtKbzou5
 20Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ph2dBO2IfKyWX2pM9b7E7M0HLp8TOKSDhq+6mp3G81c=;
 b=bYLDexRkvYzlAR210A0hm5xbkO74AOELfrKP2xnsSHB6JGnmd9RBhJveSvImW8CatD
 hamfCXUlsDnNvmgcjBVNaXwLzpuKOXuRr4EuAzhUrONrLl0pmZDD1VEXFjao4jQuapbg
 WI6xSecHOiAcv6nUAHShWDzfI6kjLhBsuktMGAenYNgWrJRCRwqBdsllPR48Sp18DCzT
 ns4UrafKfEf9CzU/zJ2x9NjQ3dyVW497UgtP/p7Fv8PPIOeisZ6Xk2P3+mgcfQDEaF1t
 O2S33xlUDBp0uCXfBzosBpAZmqiDMeewg+PAyyzx6Uqm4DIPQf4V8DyfhrPEdswGeaG8
 586Q==
X-Gm-Message-State: APjAAAUTC+0NRpwzn/OUFPvpimCAGjBpMCxpCYWPoo0wmMaZrCSbgCYb
 QwPS9rtdak0dmEJ+QRkOnt4NVzNUaQ7IBYrrgzwrKcAj
X-Google-Smtp-Source: APXvYqx+5vHiIfy7ssZW7il59N0VR4XauIguAulNquNzG+o4KXLWuANM9Ll/+bZazt7EE2/W7rNJCKBMrjPCXC5kviM=
X-Received: by 2002:a02:8816:: with SMTP id r22mr10175428jai.60.1563951678831; 
 Wed, 24 Jul 2019 00:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
 <1561468699-9819-4-git-send-email-ivanren@tencent.com>
In-Reply-To: <1561468699-9819-4-git-send-email-ivanren@tencent.com>
From: Ivan Ren <renyime@gmail.com>
Date: Wed, 24 Jul 2019 15:01:07 +0800
Message-ID: <CA+6E1=k9-AeqqwBdWVwZmzY-2V+FYV7eH0mcBuW3RyP=LW=PQQ@mail.gmail.com>
To: quintela@redhat.com, dgilbert@redhat.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 3/3] migration: fix migrate_cancel multifd
 migration leads destination hung forever
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping for review

problem still exist in qemu-4.1.0-rc2

Threads:  24 total,   0 running,  24 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,
 0.0 st
KiB Mem : 39434172+total, 36798950+free,  2948836 used, 23403388 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 38926476+avail Mem

   PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
286108 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:01.19
qemu-system-x86
286109 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00
qemu-system-x86
286113 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 IO
mon_iothread
286114 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
0/KVM
286115 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
1/KVM
286116 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
2/KVM
286117 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
3/KVM
286118 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
4/KVM
286119 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
5/KVM
286120 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
6/KVM
286121 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
7/KVM
286122 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
8/KVM
286123 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
9/KVM
286124 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
10/KVM
286125 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
11/KVM
286126 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
12/KVM
286127 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
13/KVM
286128 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
14/KVM
286129 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00 CPU
15/KVM
286131 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.00
vnc_worker
286132 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.01
multifdrecv_0
286133 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.01
multifdrecv_1
286134 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.01
multifdrecv_2
286136 root      20   0  0.127t 110596  12684 S  0.0  0.0   0:00.01
multifdrecv_3

Thread 2 (Thread 0x7f9d075fe700 (LWP 286136)):
#0  0x00007fbd67123a0b in do_futex_wait.constprop.1 () from
/lib64/libpthread.so.0
#1  0x00007fbd67123a9f in __new_sem_wait_slow.constprop.0 () from
/lib64/libpthread.so.0
#2  0x00007fbd67123b3b in sem_wait@@GLIBC_2.2.5 () from
/lib64/libpthread.so.0
#3  0x00005582236e2514 in qemu_sem_wait (sem=sem@entry=0x558226364dc8) at
util/qemu-thread-posix.c:319
#4  0x00005582232efb67 in multifd_recv_thread
(opaque=opaque@entry=0x558226364d30)
at /qemu-4.1.0-rc2/migration/ram.c:1356
#5  0x00005582236e1b26 in qemu_thread_start (args=<optimized out>) at
util/qemu-thread-posix.c:502
#6  0x00007fbd6711de25 in start_thread () from /lib64/libpthread.so.0
#7  0x00007fbd66e4a35d in clone () from /lib64/libc.so.6

Thread 1 (Thread 0x7fbd6c7a4cc0 (LWP 286108)):
#0  0x00007fbd6711ef57 in pthread_join () from /lib64/libpthread.so.0
#1  0x00005582236e28ff in qemu_thread_join (thread=thread@entry=0x558226364b00)
at util/qemu-thread-posix.c:570
#2  0x00005582232f36b4 in multifd_load_cleanup (errp=errp@entry=0x7fbd341fff58)
at /qemu-4.1.0-rc2/migration/ram.c:1259
#3  0x00005582235765a9 in process_incoming_migration_co (opaque=<optimized
out>) at migration/migration.c:510
#4  0x00005582236f4c0a in coroutine_trampoline (i0=<optimized out>,
i1=<optimized out>) at util/coroutine-ucontext.c:115
#5  0x00007fbd66d98d40 in ?? () from /lib64/libc.so.6
#6  0x00007ffec0bf24d0 in ?? ()
#7  0x0000000000000000 in ?? ()

On Tue, Jun 25, 2019 at 9:18 PM Ivan Ren <renyime@gmail.com> wrote:

> When migrate_cancel a multifd migration, if run sequence like this:
>
>         [source]                              [destination]
>
> multifd_send_sync_main[finish]
>                                     multifd_recv_thread wait &p->sem_sync
> shutdown to_dst_file
>                                     detect error from_src_file
> send  RAM_SAVE_FLAG_EOS[fail]       [no chance to run
> multifd_recv_sync_main]
>                                     multifd_load_cleanup
>                                     join multifd receive thread forever
>
> will lead destination qemu hung at following stack:
>
> pthread_join
> qemu_thread_join
> multifd_load_cleanup
> process_incoming_migration_co
> coroutine_trampoline
>
> Signed-off-by: Ivan Ren <ivanren@tencent.com>
> ---
>  migration/ram.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index e4eb9c441f..504c8ccb03 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1291,6 +1291,11 @@ int multifd_load_cleanup(Error **errp)
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>
>          if (p->running) {
> +            /*
> +             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle
> code,
> +             * however try to wakeup it without harm in cleanup phase.
> +             */
> +            qemu_sem_post(&p->sem_sync);
>              qemu_thread_join(&p->thread);
>          }
>          object_unref(OBJECT(p->c));
> --
> 2.17.2 (Apple Git-113)
>
>
