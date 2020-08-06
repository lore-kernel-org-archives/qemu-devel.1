Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBD9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3349D20855
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etewQPmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3349D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mWv-0005po-AM
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3lgR-0002Yg-4G
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:36:11 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3lgO-0000MD-SO
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:36:10 -0400
Received: by mail-lj1-x242.google.com with SMTP id v12so22758879ljc.10
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W15Ha0hCF51frGCm+qcYUA5I0hXEkQ7+NuQTIlEy4s4=;
 b=etewQPmU+A47D5AJVSnCbTn8RWDkjfggx+SAxtqCNnMhIFG0F6xyJubyxJbf/XRw4x
 CKGAEe9jaSp6Sn6/VGq3FOwfR2VyJ/lQavFXt0KpkqdgPf17cKTLawapS6dzDsimTd5f
 UmTjTHl4aDSXqc4lGHzyvSfQvcVUpu1zbUtPOindJR3BivxZAjDVEFggWLLtsy6f+GmN
 YGX90yqI7EGUm9gSmOoZszALmtqJziVnYSn88NW64VRx5WX/Py6/vIhascMLP1EIEorQ
 espYVi+97sfQiuVGXe5H75pNpYWZv9eDtBb/Q6yD0XFofskhmnAhR3IAXqATG1AI5zt9
 /GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W15Ha0hCF51frGCm+qcYUA5I0hXEkQ7+NuQTIlEy4s4=;
 b=nfCf51ir90ua8QrHltCYVmgyfd6t7y9S2mtHH9Imz6Q4ISusDSbCz6ADhdlGDTD3Yd
 yb5icldONTDJKRxQeu4Lk+CqVdwL37K64X5FqMfJUjQGc2GZ6+QsUZhPIKI55+asE2cd
 Mb/VI97l2XPwaj3Fp0Ne13BGhZjrCRwjLi3pAI5Rana1ZMKRjB5iaxCdoEw5shnRTvKH
 Vu9L5v00fU6E+lxGNDMasogm8ddqXf1eRa5OKIaVx2snyfzLo+r1MiaAAgXmLvMMhTra
 Bul4aRErbx38uFAQJhjO09jDGh1LnrpyAimmduCpr2RTgIv6khkWcJxQrU6qze9c/r6W
 4UKA==
X-Gm-Message-State: AOAM533zaKAOz4NJviAh6460hXrxC65zRhVlqfk3aWvZEHf9hjV/hqOS
 c1CmZXqCZe3JZH6wHRSMDi1iX0v2ZNB8SjgVNwVEpQ==
X-Google-Smtp-Source: ABdhPJyCJJQ2NRGGMz7mLJ1nFKdhmV/RKs5LwxxOG7JdBVE5v9DdCI6YDSz7/14WJ3BLhmH3GRcZHeXKoCEmJ6Dl+vI=
X-Received: by 2002:a2e:b8cb:: with SMTP id s11mr4831216ljp.110.1596742563870; 
 Thu, 06 Aug 2020 12:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-5-robert.foley@linaro.org>
 <CAK4993h0ieEuV3wimiy1HRjcS1nYkHAQ-qYmiEyEp6=2aBCr0g@mail.gmail.com>
In-Reply-To: <CAK4993h0ieEuV3wimiy1HRjcS1nYkHAQ-qYmiEyEp6=2aBCr0g@mail.gmail.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 6 Aug 2020 15:36:24 -0400
Message-ID: <CAEyhzFu21_afW2HycrcSacJdrLQ1kwmhPs1uuZDTxNQcJP6dxg@mail.gmail.com>
Subject: Re: [PATCH v1 04/21] target/avr: add BQL to do_interrupt and
 cpu_exec_interrupt
To: Michael Rolnik <mrolnik@gmail.com>
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Peter Puhov <peter.puhov@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 14:37, Michael Rolnik <mrolnik@gmail.com> wrote:
>
> Hi Robert.
>
> I am sorry but how can I apply it? following this what I get
>
> error: patch failed: accel/tcg/cpu-exec.c:558
> error: accel/tcg/cpu-exec.c: patch does not apply
> error: patch failed: target/arm/helper.c:9808
> error: target/arm/helper.c: patch does not apply
> error: patch failed: target/ppc/excp_helper.c:1056
> error: target/ppc/excp_helper.c: patch does not apply
> error: patch failed: target/sh4/helper.c:62
> error: target/sh4/helper.c: patch does not apply
> error: patch failed: target/unicore32/softmmu.c:118
> error: target/unicore32/softmmu.c: patch does not apply
>

Hi Michael,
This patch is based on the per-cpu locks patch series:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05314.html

Our current WIP tree for this interrupts patch is here:
https://github.com/rf972/qemu/commits/int_core_v1.4

Also, just so you know, based on the initial feedback we are going
to substantially change this series.

Another version will be sent out in a few days.

Thanks & Regards,
-Rob
>
>
> On Wed, Aug 5, 2020 at 9:17 PM Robert Foley <robert.foley@linaro.org> wrote:
>>
>> This is part of a series of changes to remove the implied BQL
>> from the common code of cpu_handle_interrupt and
>> cpu_handle_exception.  As part of removing the implied BQL
>> from the common code, we are pushing the BQL holding
>> down into the per-arch implementation functions of
>> do_interrupt and cpu_exec_interrupt.
>>
>> The purpose of this set of changes is to set the groundwork
>> so that an arch could move towards removing
>> the BQL from the cpu_handle_interrupt/exception paths.
>>
>> This approach was suggested by Paolo Bonzini.
>> For reference, here are two key posts in the discussion, explaining
>> the reasoning/benefits of this approach.
>> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
>> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html
>>
>> Signed-off-by: Robert Foley <robert.foley@linaro.org>
>> ---
>>  target/avr/helper.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/avr/helper.c b/target/avr/helper.c
>> index d96d14372b..f0d625c195 100644
>> --- a/target/avr/helper.c
>> +++ b/target/avr/helper.c
>> @@ -30,6 +30,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>>      CPUClass *cc = CPU_GET_CLASS(cs);
>>      AVRCPU *cpu = AVR_CPU(cs);
>>      CPUAVRState *env = &cpu->env;
>> +    qemu_mutex_lock_iothread();
>>
>>      if (interrupt_request & CPU_INTERRUPT_RESET) {
>>          if (cpu_interrupts_enabled(env)) {
>> @@ -53,6 +54,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>>              ret = true;
>>          }
>>      }
>> +    qemu_mutex_unlock_iothread();
>>      return ret;
>>  }
>>
>> @@ -61,10 +63,15 @@ void avr_cpu_do_interrupt(CPUState *cs)
>>      AVRCPU *cpu = AVR_CPU(cs);
>>      CPUAVRState *env = &cpu->env;
>>
>> -    uint32_t ret = env->pc_w;
>> +    uint32_t ret;
>>      int vector = 0;
>>      int size = avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2 : 1;
>>      int base = 0;
>> +    bool bql = !qemu_mutex_iothread_locked();
>> +    if (bql) {
>> +        qemu_mutex_lock_iothread();
>> +    }
>> +    ret = env->pc_w;
>>
>>      if (cs->exception_index == EXCP_RESET) {
>>          vector = 0;
>> @@ -87,6 +94,9 @@ void avr_cpu_do_interrupt(CPUState *cs)
>>      env->sregI = 0; /* clear Global Interrupt Flag */
>>
>>      cs->exception_index = -1;
>> +    if (bql) {
>> +        qemu_mutex_unlock_iothread();
>> +    }
>>  }
>>
>>  int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
>> --
>> 2.17.1
>>
>
>
> --
> Best Regards,
> Michael Rolnik

