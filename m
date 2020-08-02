Return-Path: <SRS0=xk1j=BM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C88CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 16:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9DC205CB
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 16:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRP5VO4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9DC205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2GZI-0007H7-7z
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 12:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2GYG-0006M2-Fu
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 12:09:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2GYE-0002yi-Aq
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 12:09:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so32002221wrs.11
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2020 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FzbclzbjqqOf2Mj83Uzg7D0Z7y2eTM8dkXfHYgIrtmQ=;
 b=cRP5VO4FY4dmE8rJRZAt/W1FEidERR7HHOdQYGhA1JAymMZQW+qCFBuU4VlOYoDl5m
 +miUiYGxQivJanoU0KSUrHhCn7udEalWgEQE5W/po974Dq1MQgfTkrqxQjNWhVyH+Syy
 uwEDKVnfdvZaswjqXohFMAmNlrqSxX9OgN29xh5Uwt4FWtrO93AIJkxTz8cEfnkPtbQf
 QmlQAxR2e0aiQU+XuVps7sKyLjCFxr7NA+DGbpxOAZ46StDZaxGBAemR8Md7+g/HJHJR
 0MFtTujJx3mZr/Xo0QD6tQAX4RcN0J2PfY4P5+ne2Xwe5yBBKvwr32NDDMQfRuhOdokz
 kr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FzbclzbjqqOf2Mj83Uzg7D0Z7y2eTM8dkXfHYgIrtmQ=;
 b=ZeeBKUYRwX2TsniiIhwodWOFED3TF/nOxE6pu8EnvRFT7CcV2Tc78bQYxqbBEkXbVQ
 I8J9GH50cdzYzGZpB5ZkX3ayIf8+PeMy3HBr0aRWQQm9p/l2BRTUmHi3FzJangGrpRXv
 tecuLtrbw2aa7ENke39puQarCV5Fp7k+l2UZEbkgcv4DBW7CWLdpfp+fgzYBwTI70KO4
 6POqxfk0a+efSs+WO7tMbHg98ot53pjlvytPj2BVpO4oxODyurlrGkawew9spVLif6PW
 Gi2gowDvVeonddBlVesHrDCBRqkb6wWbgqsjVEfHGc3yMTRIqjWLuemA7bzAyhkSuAI/
 SuxA==
X-Gm-Message-State: AOAM533GlRvYpDI/azve1ZkXW4mM+gvIeEgWKjjd2c6s0RPgRILL7mSU
 zDodSkfH2HxcVjvHpc9W4m+6Sw==
X-Google-Smtp-Source: ABdhPJyaQbvrikCOddhGGnOXzyWwUlSp2vBaqlVPrrdj4MqywBClXqDk/Q4c6r4BUvzsHxUSzv1xHw==
X-Received: by 2002:adf:ab0d:: with SMTP id q13mr10933075wrc.134.1596384568534; 
 Sun, 02 Aug 2020 09:09:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k13sm2235990wmj.14.2020.08.02.09.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 09:09:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5F37F1FF7E;
 Sun,  2 Aug 2020 17:09:26 +0100 (BST)
References: <20200731125127.30866-1-robert.foley@linaro.org>
 <20200731125127.30866-3-robert.foley@linaro.org>
 <67497c73-d2b9-941e-471d-de0ccd61bb7f@redhat.com>
 <CAEyhzFuPNsC3xVPG9bFEbfUPq6MW26STdr-OtKzGsfKykK2FuA@mail.gmail.com>
 <CABgObfbHMsn7yR9GiYGUmrHr6o2LZT+xdw+915R6zNi29reRzQ@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] accel/tcg: interrupt/exception handling uses
 bql_interrupt flag
In-reply-to: <CABgObfbHMsn7yR9GiYGUmrHr6o2LZT+xdw+915R6zNi29reRzQ@mail.gmail.com>
Date: Sun, 02 Aug 2020 17:09:26 +0100
Message-ID: <87ft95yqq1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Peter Puhov <peter.puhov@linaro.org>, Richard Henderson <rth@twiddle.net>,
 "Emilio G. Cota" <cota@braap.org>, Robert Foley <robert.foley@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Yes, that is correct. It's more work but also more maintainable.

I originally suggested keeping the locking choice up in the main loop
because I suspect most guests will stick to BQL IRQs until they find it
is a bottle neck.

cpu_handle_interrupt/exception have never been my favourite functions
but perhaps there is a way to re-factor and clean them up to keep this
in core code?

I do worry that hiding BQL activity in the guest code makes it harder to
reason about what locks are currently held when reading the code.

>
> Thanks,
>
> Paolo
>
> Il ven 31 lug 2020, 22:09 Robert Foley <robert.foley@linaro.org> ha scrit=
to:
>
>> On Fri, 31 Jul 2020 at 14:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> >
>> > On 31/07/20 14:51, Robert Foley wrote:
>> > > This change removes the implied BQL from the cpu_handle_interrupt,
>> > > and cpu_handle_exception paths. We can now select per-arch if
>> > > the BQL is needed or not by using the bql_interrupt flag.
>> > > By default, the core code holds the BQL.
>> > > One benefit of this change is that it leaves it up to the arch
>> > > to make the change to remove BQL when it makes sense.
>> > >
>> > > Signed-off-by: Robert Foley <robert.foley@linaro.org>
>> >
>> > No, please just modify all implementation to do lock/unlock.  It's a
>> > simpler patch than this on.
>>
>> Sure, we will update the patch based on this.
>>
>> To clarify, the suggestion here is to remove the bql_interrupt flag
>> that we added and change all the per-arch interrupt callback code to
>> do the lock/unlock of the BQL?  So for example change
>> x86_cpu_exec_interrupt, and arm_cpu_exec_interrupt, etc to lock/unlock B=
QL?
>>
>> Thanks,
>> -Rob
>>
>>
>> >
>> > Paolo
>> >
>> > > ---
>> > >  accel/tcg/cpu-exec.c | 34 ++++++++++++++++++++++++++--------
>> > >  1 file changed, 26 insertions(+), 8 deletions(-)
>> > >
>> > > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> > > index 80d0e649b2..cde27ee0bf 100644
>> > > --- a/accel/tcg/cpu-exec.c
>> > > +++ b/accel/tcg/cpu-exec.c
>> > > @@ -517,9 +517,13 @@ static inline bool cpu_handle_exception(CPUState
>> *cpu, int *ret)
>> > >  #else
>> > >          if (replay_exception()) {
>> > >              CPUClass *cc =3D CPU_GET_CLASS(cpu);
>> > > -            qemu_mutex_lock_iothread();
>> > > +            if (cc->bql_interrupt) {
>> > > +                qemu_mutex_lock_iothread();
>> > > +            }
>> > >              cc->do_interrupt(cpu);
>> > > -            qemu_mutex_unlock_iothread();
>> > > +            if (cc->bql_interrupt) {
>> > > +                qemu_mutex_unlock_iothread();
>> > > +            }
>> > >              cpu->exception_index =3D -1;
>> > >
>> > >              if (unlikely(cpu->singlestep_enabled)) {
>> > > @@ -558,7 +562,7 @@ static inline bool cpu_handle_interrupt(CPUState
>> *cpu,
>> > >      if (unlikely(cpu_interrupt_request(cpu))) {
>> > >          int interrupt_request;
>> > >
>> > > -        qemu_mutex_lock_iothread();
>> > > +        cpu_mutex_lock(cpu);
>> > >          interrupt_request =3D cpu_interrupt_request(cpu);
>> > >          if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
>> > >              /* Mask out external interrupts for this step. */
>> > > @@ -567,7 +571,7 @@ static inline bool cpu_handle_interrupt(CPUState
>> *cpu,
>> > >          if (interrupt_request & CPU_INTERRUPT_DEBUG) {
>> > >              cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
>> > >              cpu->exception_index =3D EXCP_DEBUG;
>> > > -            qemu_mutex_unlock_iothread();
>> > > +            cpu_mutex_unlock(cpu);
>> > >              return true;
>> > >          }
>> > >          if (replay_mode =3D=3D REPLAY_MODE_PLAY &&
>> !replay_has_interrupt()) {
>> > > @@ -577,13 +581,15 @@ static inline bool cpu_handle_interrupt(CPUSta=
te
>> *cpu,
>> > >              cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
>> > >              cpu_halted_set(cpu, 1);
>> > >              cpu->exception_index =3D EXCP_HLT;
>> > > -            qemu_mutex_unlock_iothread();
>> > > +            cpu_mutex_unlock(cpu);
>> > >              return true;
>> > >          }
>> > >  #if defined(TARGET_I386)
>> > >          else if (interrupt_request & CPU_INTERRUPT_INIT) {
>> > >              X86CPU *x86_cpu =3D X86_CPU(cpu);
>> > >              CPUArchState *env =3D &x86_cpu->env;
>> > > +            cpu_mutex_unlock(cpu);
>> > > +            qemu_mutex_lock_iothread();
>> > >              replay_interrupt();
>> > >              cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
>> > >              do_cpu_init(x86_cpu);
>> > > @@ -595,7 +601,7 @@ static inline bool cpu_handle_interrupt(CPUState
>> *cpu,
>> > >          else if (interrupt_request & CPU_INTERRUPT_RESET) {
>> > >              replay_interrupt();
>> > >              cpu_reset(cpu);
>> > > -            qemu_mutex_unlock_iothread();
>> > > +            cpu_mutex_unlock(cpu);
>> > >              return true;
>> > >          }
>> > >  #endif
>> > > @@ -604,7 +610,15 @@ static inline bool cpu_handle_interrupt(CPUState
>> *cpu,
>> > >             True when it is, and we should restart on a new TB,
>> > >             and via longjmp via cpu_loop_exit.  */
>> > >          else {
>> > > +            cpu_mutex_unlock(cpu);
>> > > +            if (cc->bql_interrupt) {
>> > > +                qemu_mutex_lock_iothread();
>> > > +            }
>> > >              if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
>> > > +                if (cc->bql_interrupt) {
>> > > +                    qemu_mutex_unlock_iothread();
>> > > +                }
>> > > +                cpu_mutex_lock(cpu);
>> > >                  replay_interrupt();
>> > >                  /*
>> > >                   * After processing the interrupt, ensure an
>> EXCP_DEBUG is
>> > > @@ -614,6 +628,11 @@ static inline bool cpu_handle_interrupt(CPUState
>> *cpu,
>> > >                  cpu->exception_index =3D
>> > >                      (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
>> > >                  *last_tb =3D NULL;
>> > > +            } else {
>> > > +                if (cc->bql_interrupt) {
>> > > +                    qemu_mutex_unlock_iothread();
>> > > +                }
>> > > +                cpu_mutex_lock(cpu);
>> > >              }
>> > >              /* The target hook may have updated the
>> 'cpu->interrupt_request';
>> > >               * reload the 'interrupt_request' value */
>> > > @@ -627,7 +646,7 @@ static inline bool cpu_handle_interrupt(CPUState
>> *cpu,
>> > >          }
>> > >
>> > >          /* If we exit via cpu_loop_exit/longjmp it is reset in
>> cpu_exec */
>> > > -        qemu_mutex_unlock_iothread();
>> > > +        cpu_mutex_unlock(cpu);
>> > >      }
>> > >
>> > >      /* Finally, check if we need to exit to the main loop.  */
>> > > @@ -691,7 +710,6 @@ static inline void cpu_loop_exec_tb(CPUState *cp=
u,
>> TranslationBlock *tb,
>> > >      }
>> > >  #endif
>> > >  }
>> > > -
>> > >  /* main execution loop */
>> > >
>> > >  int cpu_exec(CPUState *cpu)
>> > >
>> >
>>
>>


--=20
Alex Benn=C3=A9e

