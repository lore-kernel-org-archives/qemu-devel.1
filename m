Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95F121D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RrZC/2kD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95F121D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7r6-00018y-QI
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 13:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX7pB-0008QR-Md
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX7p5-0008A6-TZ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:02:01 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX7p5-00089q-NG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:01:55 -0500
Received: by mail-oi1-x241.google.com with SMTP id n16so19818539oig.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 10:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7fpTCSW0POtGslsylHIPNUk5yyae8P/6m7xp3b8IL4Y=;
 b=RrZC/2kDlDjKZHanWOTHO/5dTk0AKKjAUf20MzCK5z6NKFNW/iWv4EVEbxQ2Yzn+/5
 ZEUkExgCY4GmiY6zztuwMOYkqpy3a/KOIHH2pUtBw7B5TU5IutmADk592Aqb1CKN6wQU
 TgfAg4QFSjOkdEtk8NdSZ9f0T6GrN6cgNiGi7Dr8f+bAPMMg2KNAQ3jduCvSOf0srzgl
 g86WMJbFGaPgSYa4VMgBbtUdhMVlDFCxv8SlEHHRAiuvZ/lX3YX9Bpvfj5NP526drhXl
 S8eN0TB3BbdCuaLaAaUYQURfcKxIn6VD94akK7QmbbL3srIB5s6zJtWgJ5BdnPL+fAeA
 tDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7fpTCSW0POtGslsylHIPNUk5yyae8P/6m7xp3b8IL4Y=;
 b=BY/nuvNitPg098N3i3KQrEyQiA8JjCib0NuYnuDmUubbONIWIyNpSVEADNMdQbGbRT
 xdZwXjMev0VivVDYUeP/xVMCRMoYIuc4HBFc1DtVgTjlCSQVYb498mqQ2jSpOQT/R2Q3
 pzVX7IRjyDBdAETZXnc3b2b4h/WxitpQ2vvc+DUXqjf5uUuRceTQJrZk8JCxcrYjEk4J
 1Uo7zhOT5PY5P8mBWonv2xTlqSQqwYUDGsuNsxAbFIlOHTkvgbscR/a3mbA6mHYpWy51
 nup+CeZkEiJfe1qo0s35vVM2WVscI290GV5O58GPiaI69YdsGJYex2xMFeWRzmGjexZJ
 HIgQ==
X-Gm-Message-State: APjAAAUiQsomCInm0LdRG7SFqraEOkhn9wTV/XiJHJBKt5q/Iie44Zw8
 sbuGEcYLwneCbktlFZ+yNy3L4LWSDD6KHG0VTMyhmQ==
X-Google-Smtp-Source: APXvYqwNwzcLVS8tlygjd5kBItEMw+MJQw4CxtsggO5cmtxAK+dS3lW6YeWBf/FDSLOo+QVH/itP1q4beZoaX/z5Ko8=
X-Received: by 2002:aca:451:: with SMTP id 78mr5376138oie.170.1574186514698;
 Tue, 19 Nov 2019 10:01:54 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA88YR0mU2N=-immpWVFCnnU6fJsorZYHSyerfMO72iZaA@mail.gmail.com>
 <CAFEAcA9vHZc=s+2f7-a88DsLPph=PE2noz+ai+q5tM+KGabkSg@mail.gmail.com>
 <CAFEAcA_cAaJ7Q=FNf8dZJuGAjjuCANW2QkMFFjfSLaSAFBN6Vw@mail.gmail.com>
 <f4cfc080-2084-0da5-e3ad-2f65aaed41d5@redhat.com>
 <CAFEAcA-aq-0_QuHyiqpjWMKcxSaadyyfgcvg5bKPUChpSbGmvA@mail.gmail.com>
In-Reply-To: <CAFEAcA-aq-0_QuHyiqpjWMKcxSaadyyfgcvg5bKPUChpSbGmvA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 18:01:43 +0000
Message-ID: <CAFEAcA8V-vbfoEcreX=-8W+ZX1mcvOo_VspAh4Ea9+iUOjcDwQ@mail.gmail.com>
Subject: Re: test-aio-multithread assertion
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 at 17:55, Peter Maydell <peter.maydell@linaro.org> wrote:
> Here's a gdb backtrace from as assertion failure under NetBSD
> when running ./tests/test-aio-multithread -p /aio/multi/mutex/contended
> (which is pretty replicable for me); does it look like the same
> thing as the commit 2362a28ea1 issue? (Apologies for all the
> "optimized out" stuff in the backtraces; I'll try to rerun with
> a --enable-debug build.)

...that was easier than I thought it might be. Here's the
--enable-debug version:

Thread 7 (LWP 2):
#0  0x000078b302099c0a in ___lwp_park60 () from /usr/lib/libc.so.12
#1  0x000078b302409ee3 in pthread_cond_timedwait () from
/usr/lib/libpthread.so.1
#2  0x0000000000519388 in qemu_futex_wait (ev=0x7d26e0
<rcu_call_ready_event>, val=4294967295)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-thread-posix.c:364
#3  0x000000000051959d in qemu_event_wait (ev=0x7d26e0 <rcu_call_ready_event>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-thread-posix.c:459
#4  0x00000000005305db in call_rcu_thread (opaque=0x0)
    at /home/qemu/qemu-test.0WfUNX/src/util/rcu.c:260
#5  0x000000000051969f in qemu_thread_start (args=0x78b305722c00)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-thread-posix.c:519
#6  0x000078b30240b8b5 in ?? () from /usr/lib/libpthread.so.1
#7  0x000078b302081e20 in ?? () from /usr/lib/libc.so.12
#8  0x00010102464c457f in ?? ()
#9  0x0000000000000000 in ?? ()

Thread 6 (LWP 3):
#0  0x000078b30203e02a in write () from /usr/lib/libc.so.12
#1  0x000078b302407561 in write () from /usr/lib/libpthread.so.1
#2  0x0000000000516e26 in event_notifier_set (e=0x78b304701284)
    at /home/qemu/qemu-test.0WfUNX/src/util/event_notifier-posix.c:100
#3  0x0000000000511ccb in aio_notify (ctx=0x78b304701180)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:350
#4  0x000000000051183d in qemu_bh_schedule (bh=0x78b304717050)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:167
#5  0x0000000000512100 in aio_co_schedule (ctx=0x78b304701180,
co=0x78b303701280)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:473
#6  0x0000000000512180 in aio_co_enter (ctx=0x78b304701180, co=0x78b303701280)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:494
#7  0x000000000051214f in aio_co_wake (co=0x78b303701280)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:488
#8  0x0000000000531b3e in qemu_co_mutex_wake (mutex=0x7d1700
<comutex>, co=0x78b303701280)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:198
#9  0x0000000000531eb2 in qemu_co_mutex_unlock (mutex=0x7d1700 <comutex>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:301
#10 0x000000000040b8b5 in test_multi_co_mutex_entry (opaque=0x0)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:208
#11 0x0000000000532bc1 in coroutine_trampoline (i0=57676000, i1=30899)
    at /home/qemu/qemu-test.0WfUNX/src/util/coroutine-ucontext.c:115
#12 0x000078b30205dba0 in ?? () from /usr/lib/libc.so.12
#13 0x00010102464c457f in ?? ()
#14 0x0000000000000000 in ?? ()

Thread 5 (LWP 5):
#0  0x000078b30203e02a in write () from /usr/lib/libc.so.12
#1  0x000078b302407561 in write () from /usr/lib/libpthread.so.1
#2  0x0000000000516e26 in event_notifier_set (e=0x78b305316284)
    at /home/qemu/qemu-test.0WfUNX/src/util/event_notifier-posix.c:100
#3  0x0000000000511ccb in aio_notify (ctx=0x78b305316180)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:350
#4  0x000000000051183d in qemu_bh_schedule (bh=0x78b305301080)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:167
#5  0x0000000000512100 in aio_co_schedule (ctx=0x78b305316180,
co=0x78b303701350)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:473
#6  0x0000000000512180 in aio_co_enter (ctx=0x78b305316180, co=0x78b303701350)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:494
#7  0x000000000051214f in aio_co_wake (co=0x78b303701350)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:488
#8  0x0000000000531b3e in qemu_co_mutex_wake (mutex=0x7d1700
<comutex>, co=0x78b303701350)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:198
#9  0x0000000000531eb2 in qemu_co_mutex_unlock (mutex=0x7d1700 <comutex>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:301
#10 0x000000000040b8b5 in test_multi_co_mutex_entry (opaque=0x0)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:208
#11 0x0000000000532bc1 in coroutine_trampoline (i0=57676416, i1=30899)
    at /home/qemu/qemu-test.0WfUNX/src/util/coroutine-ucontext.c:115

#12 0x000078b30205dba0 in ?? () from /usr/lib/libc.so.12
#13 0x00010102464c457f in ?? ()
#14 0x0000000000000000 in ?? ()

Thread 4 (LWP 6):
#0  0x000078b30203e28a in poll () from /usr/lib/libc.so.12
#1  0x000078b3024072d0 in poll () from /usr/lib/libpthread.so.1
#2  0x0000000000513bf9 in qemu_poll_ns (fds=0x78b3053050c0, nfds=1, timeout=-1)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-timer.c:351
#3  0x000000000051665a in aio_poll (ctx=0x78b305316180, blocking=true)
    at /home/qemu/qemu-test.0WfUNX/src/util/aio-posix.c:669
#4  0x00000000004ddf5c in iothread_run (opaque=0x78b30530b270)
    at /home/qemu/qemu-test.0WfUNX/src/tests/iothread.c:51
#5  0x000000000051969f in qemu_thread_start (args=0x78b305303080)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-thread-posix.c:519
#6  0x000078b30240b8b5 in ?? () from /usr/lib/libpthread.so.1
#7  0x000078b302081e20 in ?? () from /usr/lib/libc.so.12
#8  0x0000000000000000 in ?? ()

Thread 3 (LWP 7):
#0  0x000078b30203e28a in poll () from /usr/lib/libc.so.12
#1  0x000078b3024072d0 in poll () from /usr/lib/libpthread.so.1
#2  0x0000000000513bf9 in qemu_poll_ns (fds=0x78b303f22080, nfds=1, timeout=-1)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-timer.c:351
#3  0x000000000051665a in aio_poll (ctx=0x78b303f01180, blocking=true)
    at /home/qemu/qemu-test.0WfUNX/src/util/aio-posix.c:669
#4  0x00000000004ddf5c in iothread_run (opaque=0x78b30530b300)
    at /home/qemu/qemu-test.0WfUNX/src/tests/iothread.c:51
#5  0x000000000051969f in qemu_thread_start (args=0x78b305303080)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-thread-posix.c:519
#6  0x000078b30240b8b5 in ?? () from /usr/lib/libpthread.so.1
#7  0x000078b302081e20 in ?? () from /usr/lib/libc.so.12
#8  0x0000000000000000 in ?? ()

Thread 2 (LWP 4):
#0  0x000078b3020fe7ea in _lwp_kill () from /usr/lib/libc.so.12
#1  0x000078b3020fe092 in abort () from /usr/lib/libc.so.12
#2  0x000078b30209fd57 in __assert13 () from /usr/lib/libc.so.12
#3  0x0000000000511ae8 in aio_ctx_finalize (source=0x78b305316180)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:279
#4  0x000078b304045596 in g_source_unref_internal () from
/usr/pkg/lib/libglib-2.0.so.0
#5  0x0000000000512247 in aio_context_unref (ctx=0x78b305316180)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:516
#6  0x000000000051210c in aio_co_schedule (ctx=0x78b305316180,
co=0x78b303701350)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:475
#7  0x0000000000512180 in aio_co_enter (ctx=0x78b305316180, co=0x78b303701350)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:494
#8  0x000000000051214f in aio_co_wake (co=0x78b303701350)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:488
#9  0x0000000000531b3e in qemu_co_mutex_wake (mutex=0x7d1700
<comutex>, co=0x78b303701350)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:198
#10 0x0000000000531eb2 in qemu_co_mutex_unlock (mutex=0x7d1700 <comutex>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:301
#11 0x000000000040b8b5 in test_multi_co_mutex_entry (opaque=0x0)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:208
#12 0x0000000000532bc1 in coroutine_trampoline (i0=57676208, i1=30899)
    at /home/qemu/qemu-test.0WfUNX/src/util/coroutine-ucontext.c:115
#13 0x000078b30205dba0 in ?? () from /usr/lib/libc.so.12
#14 0x00010102464c457f in ?? ()
#15 0x0000000000000000 in ?? ()

Thread 1 (LWP 1):
#0  0x000078b30203e2ea in _sys___nanosleep50 () from /usr/lib/libc.so.12
#1  0x000078b302407287 in __nanosleep50 () from /usr/lib/libpthread.so.1
#2  0x000078b30406e511 in g_usleep () from /usr/pkg/lib/libglib-2.0.so.0
#3  0x000000000040b9ba in test_multi_co_mutex (threads=5, seconds=1)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:237
#4  0x000000000040ba75 in test_multi_co_mutex_1 ()
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:255
#5  0x000078b30406bd15 in g_test_run_suite_internal () from
/usr/pkg/lib/libglib-2.0.so.0
#6  0x000078b30406bc3e in g_test_run_suite_internal () from
/usr/pkg/lib/libglib-2.0.so.0
#7  0x000078b30406bc3e in g_test_run_suite_internal () from
/usr/pkg/lib/libglib-2.0.so.0
#8  0x000078b30406bc3e in g_test_run_suite_internal () from
/usr/pkg/lib/libglib-2.0.so.0
#9  0x000078b30406c1a0 in g_test_run_suite () from /usr/pkg/lib/libglib-2.0.so.0
#10 0x000078b30406c1e8 in g_test_run () from /usr/pkg/lib/libglib-2.0.so.0
#11 0x000000000040bdc3 in main (argc=1, argv=0x7f7fffc34528)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:459

thanks
-- PMM

