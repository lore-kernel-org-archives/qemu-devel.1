Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CF0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7B4208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D04z8nph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7B4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1bLi-00064d-LP
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 16:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k1bL6-0005fF-4A
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 16:09:12 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k1bL4-0001Jq-3Z
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 16:09:11 -0400
Received: by mail-lj1-x241.google.com with SMTP id t23so10127386ljc.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lIG1tIlaUBS/l4/dJOBTuvoof2bEKI29gXcU8hVsBZY=;
 b=D04z8nphSFILnpHH/O+JAIqLPOkuk6QUrYi6ZEJ8ua6Zrmw7EFVVR9QNb8gyhTKTzU
 Rml8+beUWjZBwFZwBeGjcLikkF/hZiFwY3Lu32FPvv+OXGEZtGDkYxp00NNMa8PqMZO0
 eaNvnxamBm/zVBmtuo8wWouzTwIlwyvDuqfM1ZcRgbBiHCvUwgNhu5oy3xfpcUBzqiiR
 8AaeHc9jQnAbr+7pjzyrymS9GJHZDRrT6B+CMhaxX6wR8EUm1bgz8E4wf9R61KPR7p+Z
 ppFRSXtO3x4F5JXd0un161bttRWLJV7U9226CMI6YrqrmvofTtnDYAPHBcGfgKvQb1wA
 p0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lIG1tIlaUBS/l4/dJOBTuvoof2bEKI29gXcU8hVsBZY=;
 b=qOlmB7zrHY2hz545/fIx6NC6HpDVc9JWIHcRFynx+6VWJT2pU1wttW6vsBv+LGuwVy
 VXP+2P2BEnZQ24ojuC+oreDE9z+LuaAIzpQzM2TJbao8SZ3WvTzm7r389ee8pKhUceAz
 I7jWsaiz+4uneoCk/1gBjTn14M6LGBzOTYd5hu9jfYwWqN9VdIYYpPZPdoBrcYILACby
 br3WZCngvSDPfnOy+DZhTXCMRjBbflaGpDya43ETD2RNYzDfHZSVNZPpdpCpWTZSSmcq
 p9ObwUALq48CGIvapai95b5E5Lh8JXSkC6IZcfZylF5h1ESpUIklMYUqRiV5Hjr40bfq
 tJxg==
X-Gm-Message-State: AOAM531xJEcifB8NkrF+gzjZStqRjS3o+h5C9Na4cKZ5HAFNpxb8hV2O
 yDQeTLPkA+XW171xtNqsZQrqJqi9qt2veANV7ifz2g==
X-Google-Smtp-Source: ABdhPJyG18rQvLK5VSJe0UtpS1YBAi/T3GPoKKxgNcIpdNaKWOvUC5RNWHhm3oXgVMIdnn1BBRM4YEQcBQhbsSzKroc=
X-Received: by 2002:a2e:b5b7:: with SMTP id f23mr2323467ljn.380.1596226147631; 
 Fri, 31 Jul 2020 13:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200731125127.30866-1-robert.foley@linaro.org>
 <20200731125127.30866-3-robert.foley@linaro.org>
 <67497c73-d2b9-941e-471d-de0ccd61bb7f@redhat.com>
In-Reply-To: <67497c73-d2b9-941e-471d-de0ccd61bb7f@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 31 Jul 2020 16:09:26 -0400
Message-ID: <CAEyhzFuPNsC3xVPG9bFEbfUPq6MW26STdr-OtKzGsfKykK2FuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] accel/tcg: interrupt/exception handling uses
 bql_interrupt flag
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Puhov <peter.puhov@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 Jul 2020 at 14:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 31/07/20 14:51, Robert Foley wrote:
> > This change removes the implied BQL from the cpu_handle_interrupt,
> > and cpu_handle_exception paths. We can now select per-arch if
> > the BQL is needed or not by using the bql_interrupt flag.
> > By default, the core code holds the BQL.
> > One benefit of this change is that it leaves it up to the arch
> > to make the change to remove BQL when it makes sense.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
>
> No, please just modify all implementation to do lock/unlock.  It's a
> simpler patch than this on.

Sure, we will update the patch based on this.

To clarify, the suggestion here is to remove the bql_interrupt flag
that we added and change all the per-arch interrupt callback code to
do the lock/unlock of the BQL?  So for example change
x86_cpu_exec_interrupt, and arm_cpu_exec_interrupt, etc to lock/unlock BQL?

Thanks,
-Rob


>
> Paolo
>
> > ---
> >  accel/tcg/cpu-exec.c | 34 ++++++++++++++++++++++++++--------
> >  1 file changed, 26 insertions(+), 8 deletions(-)
> >
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 80d0e649b2..cde27ee0bf 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -517,9 +517,13 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
> >  #else
> >          if (replay_exception()) {
> >              CPUClass *cc = CPU_GET_CLASS(cpu);
> > -            qemu_mutex_lock_iothread();
> > +            if (cc->bql_interrupt) {
> > +                qemu_mutex_lock_iothread();
> > +            }
> >              cc->do_interrupt(cpu);
> > -            qemu_mutex_unlock_iothread();
> > +            if (cc->bql_interrupt) {
> > +                qemu_mutex_unlock_iothread();
> > +            }
> >              cpu->exception_index = -1;
> >
> >              if (unlikely(cpu->singlestep_enabled)) {
> > @@ -558,7 +562,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >      if (unlikely(cpu_interrupt_request(cpu))) {
> >          int interrupt_request;
> >
> > -        qemu_mutex_lock_iothread();
> > +        cpu_mutex_lock(cpu);
> >          interrupt_request = cpu_interrupt_request(cpu);
> >          if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
> >              /* Mask out external interrupts for this step. */
> > @@ -567,7 +571,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >          if (interrupt_request & CPU_INTERRUPT_DEBUG) {
> >              cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
> >              cpu->exception_index = EXCP_DEBUG;
> > -            qemu_mutex_unlock_iothread();
> > +            cpu_mutex_unlock(cpu);
> >              return true;
> >          }
> >          if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
> > @@ -577,13 +581,15 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >              cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
> >              cpu_halted_set(cpu, 1);
> >              cpu->exception_index = EXCP_HLT;
> > -            qemu_mutex_unlock_iothread();
> > +            cpu_mutex_unlock(cpu);
> >              return true;
> >          }
> >  #if defined(TARGET_I386)
> >          else if (interrupt_request & CPU_INTERRUPT_INIT) {
> >              X86CPU *x86_cpu = X86_CPU(cpu);
> >              CPUArchState *env = &x86_cpu->env;
> > +            cpu_mutex_unlock(cpu);
> > +            qemu_mutex_lock_iothread();
> >              replay_interrupt();
> >              cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
> >              do_cpu_init(x86_cpu);
> > @@ -595,7 +601,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >          else if (interrupt_request & CPU_INTERRUPT_RESET) {
> >              replay_interrupt();
> >              cpu_reset(cpu);
> > -            qemu_mutex_unlock_iothread();
> > +            cpu_mutex_unlock(cpu);
> >              return true;
> >          }
> >  #endif
> > @@ -604,7 +610,15 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >             True when it is, and we should restart on a new TB,
> >             and via longjmp via cpu_loop_exit.  */
> >          else {
> > +            cpu_mutex_unlock(cpu);
> > +            if (cc->bql_interrupt) {
> > +                qemu_mutex_lock_iothread();
> > +            }
> >              if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
> > +                if (cc->bql_interrupt) {
> > +                    qemu_mutex_unlock_iothread();
> > +                }
> > +                cpu_mutex_lock(cpu);
> >                  replay_interrupt();
> >                  /*
> >                   * After processing the interrupt, ensure an EXCP_DEBUG is
> > @@ -614,6 +628,11 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >                  cpu->exception_index =
> >                      (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
> >                  *last_tb = NULL;
> > +            } else {
> > +                if (cc->bql_interrupt) {
> > +                    qemu_mutex_unlock_iothread();
> > +                }
> > +                cpu_mutex_lock(cpu);
> >              }
> >              /* The target hook may have updated the 'cpu->interrupt_request';
> >               * reload the 'interrupt_request' value */
> > @@ -627,7 +646,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >          }
> >
> >          /* If we exit via cpu_loop_exit/longjmp it is reset in cpu_exec */
> > -        qemu_mutex_unlock_iothread();
> > +        cpu_mutex_unlock(cpu);
> >      }
> >
> >      /* Finally, check if we need to exit to the main loop.  */
> > @@ -691,7 +710,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
> >      }
> >  #endif
> >  }
> > -
> >  /* main execution loop */
> >
> >  int cpu_exec(CPUState *cpu)
> >
>

