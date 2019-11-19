Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3167DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0147A21823
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/H55hP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0147A21823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7k4-0004W5-2c
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX7ih-0002y4-SK
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX7if-0006O9-On
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:55:19 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX7if-0006Ny-F5
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:55:17 -0500
Received: by mail-ot1-x344.google.com with SMTP id r24so18652061otk.12
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 09:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KBCbvwUyyEHorx64ktyEHnRish8S63TuqIFZzqEjtXg=;
 b=Y/H55hP8Oq5Y1eSJKlpOxikPPQyqR04IQ5kcqKah6LxWNCnUWhcCF6QsTJ815gCxD/
 /3+hiKUu24kUsmELjyc5WzZmdpiSgk5OPSMbhvqsUiN16NYFQYhvAcPRRHQC1CCaOLtA
 lCvHqGMN796uXIwUMps3y7rNxq6/ute6JVysrP6CY1hSqA5yrLewsm6g9A5QKkldyD/k
 MhWbR2FlBJ0u6tifVUrJwAmcvfHUtB40PyNBzlsS3im8iHJKmpWHxXxH6B+BUxmHIoAi
 qQfTp69vZxVFroQH+5AYSqKWJl9WBthzvw5KD6VRz/CUzlSgG/3CYtNOQp3qdDFikWSe
 l8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KBCbvwUyyEHorx64ktyEHnRish8S63TuqIFZzqEjtXg=;
 b=mw20yc2UwH1d/bMkXngropcf8AyOitxDjgs9L8tSGoHU/zfG/xQg7j3OCalX9/l/DW
 lVO7wNVtZlfbeSN0SRvlt6XwgzCnLiC1HTMzYuGTySBKC7y5Bg6Ay/cUw7zCtJAt4l5z
 a7D39jcAJ499tC557YT+CUml0gT5FitPTGttvJxqbCe+g/0VUKGloSvEV5Iy90FqGBTS
 TJ7DiOmcsxfLQTa5o3saH+l8zvcRZ3FiyT4W79H+vQlys+fjdnmtSU10EYUGzZI9z3cz
 6h/pTkJhGiNGM4yRLlizcwdLwM2XaYa2hJD/9ceB0C5o8xPOdD6MCS4lVkhKs23bYrK8
 8uqg==
X-Gm-Message-State: APjAAAWrFV2wkSsiQrPzR8cKJosV1VSMcw50MZkFPe+2wyMHf/FRNPeE
 T3xsyY1eZP26+l2BauV+wE9imGN46eiV/4yiZzKq1A==
X-Google-Smtp-Source: APXvYqwfdGUekoQxvgxFUiY7W/b7/XhihzapEOclBzP9/Sky/ZAIsSlazI3IbVYTSzsktOA4wfEiu/2WjAob+gTCxD4=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr4404569oto.97.1574186116366; 
 Tue, 19 Nov 2019 09:55:16 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA88YR0mU2N=-immpWVFCnnU6fJsorZYHSyerfMO72iZaA@mail.gmail.com>
 <CAFEAcA9vHZc=s+2f7-a88DsLPph=PE2noz+ai+q5tM+KGabkSg@mail.gmail.com>
 <CAFEAcA_cAaJ7Q=FNf8dZJuGAjjuCANW2QkMFFjfSLaSAFBN6Vw@mail.gmail.com>
 <f4cfc080-2084-0da5-e3ad-2f65aaed41d5@redhat.com>
In-Reply-To: <f4cfc080-2084-0da5-e3ad-2f65aaed41d5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 17:55:05 +0000
Message-ID: <CAFEAcA-aq-0_QuHyiqpjWMKcxSaadyyfgcvg5bKPUChpSbGmvA@mail.gmail.com>
Subject: Re: test-aio-multithread assertion
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Mon, 14 Oct 2019 at 11:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/10/19 12:26, Peter Maydell wrote:
> > On Thu, 5 Sep 2019 at 14:17, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> Here's a different intermittent assertion on Netbsd from test-aio-multithread:
> >>
> >> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> >> tests/test-aio-multithread -m=quick
> >> -k --tap < /dev/null | ./scripts/tap-driver.pl
> >> --test-name="test-aio-multithread"
> >> PASS 1 test-aio-multithread /aio/multi/lifecycle
> >> PASS 2 test-aio-multithread /aio/multi/schedule
> >> assertion "QSLIST_EMPTY(&ctx->scheduled_coroutines)" failed: file
> >> "util/async.c", line 279, function "
> >> aio_ctx_finalize"
> >> ERROR - too few tests run (expected 5, got 2)
> >
> > Just saw this QSLIST_EMPTY(&ctx->scheduled_coroutines) assertion
> > from FreeBSD as well, so it's still around as a definite
> > intermittent.
>
> This could be similar to what Stefan fixed in commit 2362a28ea1, only in
> the test infrastructure.

Here's a gdb backtrace from as assertion failure under NetBSD
when running ./tests/test-aio-multithread -p /aio/multi/mutex/contended
(which is pretty replicable for me); does it look like the same
thing as the commit 2362a28ea1 issue? (Apologies for all the
"optimized out" stuff in the backtraces; I'll try to rerun with
a --enable-debug build.)

Thread 7 (LWP 2):
#0  0x00007e4b44499c0a in ___lwp_park60 () from /usr/lib/libc.so.12
#1  0x00007e4b44809ee3 in pthread_cond_timedwait () from
/usr/lib/libpthread.so.1
#2  0x00000000004c0862 in qemu_futex_wait (val=4294967295, ev=0x760c00
<rcu_call_ready_event>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-thread-posix.c:364
#3  qemu_event_wait (ev=ev@entry=0x760c00 <rcu_call_ready_event>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-thread-posix.c:459
#4  0x00000000004ce825 in call_rcu_thread (opaque=opaque@entry=0x0)
    at /home/qemu/qemu-test.0WfUNX/src/util/rcu.c:260
#5  0x00000000004bfd17 in qemu_thread_start (args=0x7e4b47b22c00)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-thread-posix.c:519
#6  0x00007e4b4480b8b5 in ?? () from /usr/lib/libpthread.so.1
#7  0x00007e4b44481e20 in ?? () from /usr/lib/libc.so.12
#8  0x00010102464c457f in ?? ()
#9  0x0000000000000000 in ?? ()

Thread 6 (LWP 3):
#0  0x00007e4b4443e02a in write () from /usr/lib/libc.so.12
#1  0x00007e4b44807561 in write () from /usr/lib/libpthread.so.1
#2  0x00000000004beae0 in event_notifier_set (e=e@entry=0x7e4b46f01214)
    at /home/qemu/qemu-test.0WfUNX/src/util/event_notifier-posix.c:100
#3  0x00000000004bb66c in aio_notify (ctx=0x7e4b46f01120)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:350
#4  0x00000000004bb936 in aio_co_schedule (ctx=0x7e4b46f01120,
co=0x7e4b46b01280)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:473
#5  0x00000000004cf226 in qemu_co_mutex_wake (mutex=0x75fc00
<comutex>, co=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:198
#6  qemu_co_mutex_unlock (mutex=mutex@entry=0x75fc00 <comutex>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:301
#7  0x000000000040b33b in test_multi_co_mutex_entry (opaque=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:208
#8  0x00000000004cff6b in coroutine_trampoline (i0=<optimized out>,
i1=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/util/coroutine-ucontext.c:115
#9  0x00007e4b4445dba0 in ?? () from /usr/lib/libc.so.12
#10 0x00010102464c457f in ?? ()
#11 0x0000000000000000 in ?? ()

Thread 5 (LWP 4):
#0  0x000000000040b34a in test_multi_co_mutex_entry (opaque=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:205
#1  0x00000000004cff6b in coroutine_trampoline (i0=<optimized out>,
i1=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/util/coroutine-ucontext.c:115
#2  0x00007e4b4445dba0 in ?? () from /usr/lib/libc.so.12
#3  0x00010102464c457f in ?? ()
#4  0x0000000000000000 in ?? ()

Thread 4 (LWP 5):
#0  0x00007e4b4443e02a in write () from /usr/lib/libc.so.12
#1  0x00007e4b44807561 in write () from /usr/lib/libpthread.so.1
#2  0x00000000004beae0 in event_notifier_set (e=e@entry=0x7e4b47701384)
    at /home/qemu/qemu-test.0WfUNX/src/util/event_notifier-posix.c:100
#3  0x00000000004bb66c in aio_notify (ctx=0x7e4b47701290)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:350
#4  0x00000000004bb936 in aio_co_schedule (ctx=0x7e4b47701290,
co=0x7e4b46b01420)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:473
#5  0x00000000004cf226 in qemu_co_mutex_wake (mutex=0x75fc00
<comutex>, co=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:198
#6  qemu_co_mutex_unlock (mutex=mutex@entry=0x75fc00 <comutex>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:301
#7  0x000000000040b33b in test_multi_co_mutex_entry (opaque=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:208
#8  0x00000000004cff6b in coroutine_trampoline (i0=<optimized out>,
i1=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/util/coroutine-ucontext.c:115
#9  0x00007e4b4445dba0 in ?? () from /usr/lib/libc.so.12
#10 0x00010102464c457f in ?? ()
#11 0x0000000000000000 in ?? ()

Thread 3 (LWP 7):
#0  0x00000000004cf200 in qemu_co_mutex_unlock
(mutex=mutex@entry=0x75fc00 <comutex>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:291
#1  0x000000000040b33b in test_multi_co_mutex_entry (opaque=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:208
#2  0x00000000004cff6b in coroutine_trampoline (i0=<optimized out>,
i1=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/util/coroutine-ucontext.c:115
#3  0x00007e4b4445dba0 in ?? () from /usr/lib/libc.so.12
#4  0x00010102464c457f in ?? ()
#5  0x0000000000000000 in ?? ()

Thread 2 (LWP 6):
#0  0x00007e4b444fe7ea in _lwp_kill () from /usr/lib/libc.so.12
#1  0x00007e4b444fe092 in abort () from /usr/lib/libc.so.12
#2  0x00007e4b4449fd57 in __assert13 () from /usr/lib/libc.so.12
#3  0x00000000004bb3e0 in aio_ctx_finalize (source=0x7e4b47701290)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:279
#4  0x00007e4b46445596 in g_source_unref_internal () from
/usr/pkg/lib/libglib-2.0.so.0
#5  0x00000000004bb93e in aio_context_unref (ctx=0x7e4b47701290)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:516
#6  aio_co_schedule (ctx=0x7e4b47701290, co=0x7e4b46b01420)
    at /home/qemu/qemu-test.0WfUNX/src/util/async.c:475
#7  0x00000000004cf226 in qemu_co_mutex_wake (mutex=0x75fc00
<comutex>, co=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:198
#8  qemu_co_mutex_unlock (mutex=mutex@entry=0x75fc00 <comutex>)
    at /home/qemu/qemu-test.0WfUNX/src/util/qemu-coroutine-lock.c:301
#9  0x000000000040b33b in test_multi_co_mutex_entry (opaque=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:208
#10 0x00000000004cff6b in coroutine_trampoline (i0=<optimized out>,
i1=<optimized out>)
    at /home/qemu/qemu-test.0WfUNX/src/util/coroutine-ucontext.c:115
#11 0x00007e4b4445dba0 in ?? () from /usr/lib/libc.so.12
#12 0x00010102464c457f in ?? ()
#13 0x0000000000000000 in ?? ()

Thread 1 (LWP 1):
#0  0x00007e4b4443e2ea in _sys___nanosleep50 () from /usr/lib/libc.so.12
#1  0x00007e4b44807287 in __nanosleep50 () from /usr/lib/libpthread.so.1
#2  0x00007e4b4646e511 in g_usleep () from /usr/pkg/lib/libglib-2.0.so.0
#3  0x000000000040b72e in test_multi_co_mutex (threads=<optimized
out>, seconds=1)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:237
#4  0x00007e4b4646bd15 in g_test_run_suite_internal () from
/usr/pkg/lib/libglib-2.0.so.0
#5  0x00007e4b4646bc3e in g_test_run_suite_internal () from
/usr/pkg/lib/libglib-2.0.so.0
#6  0x00007e4b4646bc3e in g_test_run_suite_internal () from
/usr/pkg/lib/libglib-2.0.so.0
#7  0x00007e4b4646bc3e in g_test_run_suite_internal () from
/usr/pkg/lib/libglib-2.0.so.0
#8  0x00007e4b4646c1a0 in g_test_run_suite () from /usr/pkg/lib/libglib-2.0.so.0
#9  0x00007e4b4646c1e8 in g_test_run () from /usr/pkg/lib/libglib-2.0.so.0
#10 0x00000000004dbcdc in main (argc=1, argv=0x7f7fffd572f8)
    at /home/qemu/qemu-test.0WfUNX/src/tests/test-aio-multithread.c:459

thanks
-- PMM

