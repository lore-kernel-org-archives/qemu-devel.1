Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4104AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0452620776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i93tMEtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0452620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbIT-0002Ew-6K
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdbHa-0001kq-Lv
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:14:22 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdbHZ-0002jA-A8
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:14:22 -0400
Received: by mail-lj1-x242.google.com with SMTP id q2so24923740ljm.10
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E+XMLlWa2GKIgemfr2YQ4Di+1zf8OSoofAjdVOCTmpg=;
 b=i93tMEtjjrd0IzWq1ZiAYguj42u+EWAFzLOV4g0gGHMZgIujhIzCmIcX80Z3JI6tlP
 /vjxSSbNGYxcRKXvI4zRAYUbjRjPOLFZfQamAMPUawm5b9L8b+oWBjCLig5iC5rd+X/b
 w9XhVlwAAlmC8npyHV1uUXObEtQY6s5OJEqN454ZGKrN57MNvhOMhHa8QZjj0+tJb6rh
 ObgV2LXCOmPFVb03lkHArox1zuxBVhzMsKCzdMRqllqxlaR/f7e74/tWLGzwXpr/2PaH
 9K86iA1rCpXxopLFEOMdpN0egvtqwa9p2gS21vCLSnGiyIo6N7girWIHznZGvDeNTDcb
 PHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E+XMLlWa2GKIgemfr2YQ4Di+1zf8OSoofAjdVOCTmpg=;
 b=ClP5TUyQQL4O3p5aIBcYSsT08XafjpLnifH9fxJEVTTPfKjj70JIjz5oWCqVXUqQoV
 B7RC9Hr4Mp1VJJx2yYNfIqONhztDRYsyRwS9U0TEhsQuqFz+Hmau151VU+QTwJXBr9QJ
 Wxh+cUsH8vgwjRLWE0OwiS0TJAqzy1qHCryaGF+MxgawYcPcqTME2Z1Qu0iLNZiEsHa3
 vkRT3Q7S8xE0pCMmrIyGfakyezPWor8JaKOy6lEr6FzYBGEWiX+p3LQeO8UbJjVD7w6f
 PJRcoheotjv5RUi9JskOgWyuKwXzFGcqw40p0i4sLoc8VJ+u+XNu+/Y6t2XHZLZ3Jd7o
 qZZg==
X-Gm-Message-State: AOAM533sCKlbemTrTDn5/ziycOEfr2Zly/mPsEh8k8MLBzgc5hCM4yK9
 aPSI5gOpOhRaMqdqdbZKVkltKij4DMgnDEoNHfLp7A==
X-Google-Smtp-Source: ABdhPJwmBzxH3CwB+KlzDQRwjv6PvjoHfxc/R0ivY7mzoFnpRVNFcd7uKmSYm689dFji/I8IgPXptw8EyKDuHW2pheM=
X-Received: by 2002:a2e:8811:: with SMTP id x17mr832598ljh.140.1590506059444; 
 Tue, 26 May 2020 08:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-14-robert.foley@linaro.org>
 <20200523200631.GE382220@sff>
In-Reply-To: <20200523200631.GE382220@sff>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 26 May 2020 11:14:14 -0400
Message-ID: <CAEyhzFt2a7TSnymqUYFh0L=7S95dUvcEnuxf+Dc-VadOpcM8xw@mail.gmail.com>
Subject: Re: [PATCH 13/19] accel/tcg: Fixed tsan warnings.
To: "Emilio G. Cota" <cota@braap.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 23 May 2020 at 16:06, Emilio G. Cota <cota@braap.org> wrote:
>
> On Fri, May 22, 2020 at 12:07:49 -0400, Robert Foley wrote:
> > For example:
> > WARNING: ThreadSanitizer: data race (pid=35425)
> >   Write of size 4 at 0x7bbc000000ac by main thread (mutexes: write M875):
> >     #0 cpu_reset_interrupt hw/core/cpu.c:107:28 (qemu-system-aarch64+0x843790)
> >     #1 arm_cpu_set_irq target/arm/cpu.c (qemu-system-aarch64+0x616265)
> >     #2 qemu_set_irq hw/core/irq.c:44:5 (qemu-system-aarch64+0x8462ca)
> >   Previous atomic read of size 4 at 0x7bbc000000ac by thread T6:
> >     #0 __tsan_atomic32_load <null> (qemu-system-aarch64+0x394c1c)
> >     #1 cpu_handle_interrupt accel/tcg/cpu-exec.c:534:9 (qemu-system-aarch64+0x4b7e79)
> >     #2 cpu_exec accel/tcg/cpu-exec.c:720:17 (qemu-system-aarch64+0x4b7e79)
> > or
> > WARNING: ThreadSanitizer: data race (pid=25425)
> >   Read of size 8 at 0x7f8ad8e138d0 by thread T10:
> >     #0 tb_lookup_cmp accel/tcg/cpu-exec.c:307:13 (qemu-system-aarch64+0x4ac4d2)
> >     #1 qht_do_lookup util/qht.c:502:34 (qemu-system-aarch64+0xd05264)
> >   Previous write of size 8 at 0x7f8ad8e138d0 by thread T15 (mutexes: write M728311726235541804):
> >     #0 tb_link_page accel/tcg/translate-all.c:1625:26 (qemu-system-aarch64+0x4b0bf2)
> >     #1 tb_gen_code accel/tcg/translate-all.c:1865:19 (qemu-system-aarch64+0x4b0bf2)
> >     #2 tb_find accel/tcg/cpu-exec.c:407:14 (qemu-system-aarch64+0x4ad77c)
>
> I see you're working through the warnings in this file, but I think it would
> be better to forget about files and focus on the data itself.
> Therefore this patch should be split in two: (1) cpu-<interrupt_request
> and (2) gen_code_buf. (1) requires a lot of changes with a proper audit;
> the per-cpu-lock series has a possible solution for that, so I will
> ignore those hunks and just comment on (2) below.

We will be dropping the changes in this file which overlap with
the per-cpu-locks patch.
>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> >  accel/tcg/tcg-all.c       | 4 ++--
> >  accel/tcg/tcg-runtime.c   | 7 ++++++-
> >  accel/tcg/translate-all.c | 6 +++++-
> >  hw/core/cpu.c             | 2 +-
> >  4 files changed, 14 insertions(+), 5 deletions(-)
> >
> (snip)
> > diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> > index 446465a09a..bd0cd77450 100644
> > --- a/accel/tcg/tcg-runtime.c
> > +++ b/accel/tcg/tcg-runtime.c
> > @@ -31,6 +31,7 @@
> >  #include "disas/disas.h"
> >  #include "exec/log.h"
> >  #include "tcg/tcg.h"
> > +#include "qemu/tsan.h"
> >
> >  /* 32-bit helpers */
> >
> > @@ -151,6 +152,7 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
> >      TranslationBlock *tb;
> >      target_ulong cs_base, pc;
> >      uint32_t flags;
> > +    void *tc_ptr;
> >
> >      tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, curr_cflags());
> >      if (tb == NULL) {
> > @@ -161,7 +163,10 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
> >                             TARGET_FMT_lx "/" TARGET_FMT_lx "/%#x] %s\n",
> >                             cpu->cpu_index, tb->tc.ptr, cs_base, pc, flags,
> >                             lookup_symbol(pc));
> > -    return tb->tc.ptr;
> > +    TSAN_ANNOTATE_IGNORE_READS_BEGIN();
> > +    tc_ptr = tb->tc.ptr;
> > +    TSAN_ANNOTATE_IGNORE_READS_END();
> > +    return tc_ptr;
>
> I'm not sure these are needed. At least after applying all other patches
> in this series, I don't get a warning here.

I think we will also be dropping the ANNOTATE calls here as we re-focus
the patch series.

Thanks & Regards,
-Rob

>
> >  }
> >
> >  void HELPER(exit_atomic)(CPUArchState *env)
> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> > index 3fb71a1503..6c0e61994c 100644
> > --- a/accel/tcg/translate-all.c
> > +++ b/accel/tcg/translate-all.c
> > @@ -58,6 +58,7 @@
> >  #include "exec/log.h"
> >  #include "sysemu/cpus.h"
> >  #include "sysemu/tcg.h"
> > +#include "qemu/tsan.h"
> >
> >  /* #define DEBUG_TB_INVALIDATE */
> >  /* #define DEBUG_TB_FLUSH */
> > @@ -1704,6 +1705,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
> >          max_insns = 1;
> >      }
> >
> > +    TSAN_ANNOTATE_IGNORE_WRITES_BEGIN();
>
> Same here, I don't get a warning in this hunk if I remove these,
> except for:
> ---
> WARNING: ThreadSanitizer: data race (pid=445867)
>   Atomic read of size 1 at 0x7f906e050158 by thread T7:
>     #0 __tsan_mutex_post_lock <null> (qemu-system-aarch64+0x481721)
>     #1 qemu_spin_lock /home/cota/src/qemu/include/qemu/thread.h:244:5 (qemu-system-aarch64+0x5578e9)
>     #2 tb_add_jump /home/cota/src/qemu/accel/tcg/cpu-exec.c:363:5 (qemu-system-aarch64+0x5578e9)
>     #3 tb_find /home/cota/src/qemu/accel/tcg/cpu-exec.c:423:9 (qemu-system-aarch64+0x5578e9)
>
>   Previous write of size 1 at 0x7f906e050158 by thread T8:
>     #0 __tsan_mutex_create <null> (qemu-system-aarch64+0x481589)
>     #1 qemu_spin_init /home/cota/src/qemu/include/qemu/thread.h:221:5 (qemu-system-aarch64+0x559a71)
>     #2 tb_gen_code /home/cota/src/qemu/accel/tcg/translate-all.c:1875:5 (qemu-system-aarch64+0x559a71)
>
>   Thread T7 'CPU 0/TCG' (tid=445875, running) created by main thread at:
>     #0 pthread_create <null> (qemu-system-aarch64+0x43915b)
>     #1 qemu_thread_create /home/cota/src/qemu/util/qemu-thread-posix.c:558:11 (qemu-system-aarch64+0xaf91ff)
>
>   Thread T8 'CPU 1/TCG' (tid=445876, running) created by main thread at:
>     #0 pthread_create <null> (qemu-system-aarch64+0x43915b)
>     #1 qemu_thread_create /home/cota/src/qemu/util/qemu-thread-posix.c:558:11 (qemu-system-aarch64+0xaf91ff)
>
> SUMMARY: ThreadSanitizer: data race (/home/cota/src/qemu/build/aarch64-softmmu/qemu-system-aarch64+0x481721) in __tsan_mutex_post_lock
> ---
>
> Seems like tsan is confusing itself here.
>
> Thanks,
>                 E.

