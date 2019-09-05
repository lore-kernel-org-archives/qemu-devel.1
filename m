Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9660CC43140
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A710206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETwcu8CZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A710206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5u2w-0007bE-KO
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5u1i-0006fW-Mk
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5u1f-0001Oc-Oy
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:50:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5u1f-0001MF-9x
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:50:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id y19so3398703wrd.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 08:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1+7BX+lj0yPgDgyMhd1nzZ42vSig4hScQBc6dMMCb3k=;
 b=ETwcu8CZkGuwa0RIVF/O86rtt0yKnxqi7twgCFrcV5IqRM1e+v5Nr7rSEVqOSuwB93
 o0oDt9wc0JxLWVlRTVnEDMmrhhsTOr4OGlmGGn5Z6421aIk5hrSbOO7DD17BogL2MkBn
 N+/ARtT6iGpvpAw9jpHloIl8p82sdeR4lt2IAp/V0Fqq6Z6u9y79238fFdh1M54kWl3+
 cMdtxEqRZZFQzV0x4s7Rg+nj6NvetGFKwxaEqAVpzOlYuYmkGFWiMUVgU44uXCEJoLYd
 ZHC84//sFeW7IEtY5qLHWd1oKrWLDNzH6gqe1cHlYXebCxNwt31kWvK8W+v8l5n7gPRi
 zrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1+7BX+lj0yPgDgyMhd1nzZ42vSig4hScQBc6dMMCb3k=;
 b=fbmykRgwEcpubLOS8lmhBMnS2GvVXz6uzSCb6GB9aZMfJWeHPkfmqvMD1FLoKjt/l0
 pcLUeyfgZpXxar1LGaPGt1kHqsinBeAb0jVGXD5pQk0l1bRAIgsf2lVLVIBWP7+cu6hI
 s43qi9k36W3wBwMJQi+STkhY7pXufsrAH2lbZa2wz405gROUg+bUpd6YTunoopxV51ZS
 sB/JIGPlDzM9RNRxMHQ74OuZl69JcgblHVaMbmzOzyBrnr7KdveVkvT3xwFiemjr/IaF
 C7/0FnT7ERgeGzzs9ugVYjKZpduWV1o4kLeSLvCc/cxZMmX3vRFgIbL0LlLrlnqry6wO
 Z/Ww==
X-Gm-Message-State: APjAAAVx46vI3d6+PKo2Ji29D0jIbzGLAnqnIja2ZZFoIFrtRXwJSCwg
 THr4B6jFrBk8VTkYeuO2c+Cx3A==
X-Google-Smtp-Source: APXvYqyLl5R+iXk5ZDJKy1pDJcCP2G2Orep7UjtgO1JBy7s0UX+2HQy/AZ8u8H184xvj9mVw2vHEkA==
X-Received: by 2002:adf:ee4a:: with SMTP id w10mr3243415wro.138.1567698621935; 
 Thu, 05 Sep 2019 08:50:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x17sm5576618wrd.85.2019.09.05.08.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 08:50:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 843611FF87;
 Thu,  5 Sep 2019 16:50:20 +0100 (BST)
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <20190820210720.18976-18-richard.henderson@linaro.org>
 <877e6m937n.fsf@linaro.org>
 <CABoDooPis6VR-3zw6EcCerwmTfZ_c2gqbCtVDSnpB30q-Oh01A@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
In-reply-to: <CABoDooPis6VR-3zw6EcCerwmTfZ_c2gqbCtVDSnpB30q-Oh01A@mail.gmail.com>
Date: Thu, 05 Sep 2019 16:50:20 +0100
Message-ID: <874l1q91z7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 17/17] target/arm: Rely on
 hflags correct in cpu_get_tb_cpu_state
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Desnogues <laurent.desnogues@gmail.com> writes:

> On Thu, Sep 5, 2019 at 5:24 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>> > This is the payoff.
>> >
>> > From perf record -g data of ubuntu 18 boot and shutdown:
>> >
>> > BEFORE:
>> >
>> > -   23.02%     2.82%  qemu-system-aar  [.] helper_lookup_tb_ptr
>> >    - 20.22% helper_lookup_tb_ptr
>> >       + 10.05% tb_htable_lookup
>> >       - 9.13% cpu_get_tb_cpu_state
>> >            3.20% aa64_va_parameters_both
>> >            0.55% fp_exception_el
>> >
>> > -   11.66%     4.74%  qemu-system-aar  [.] cpu_get_tb_cpu_state
>> >    - 6.96% cpu_get_tb_cpu_state
>> >         3.63% aa64_va_parameters_both
>> >         0.60% fp_exception_el
>> >         0.53% sve_exception_el
>> >
>> > AFTER:
>> >
>> > -   16.40%     3.40%  qemu-system-aar  [.] helper_lookup_tb_ptr
>> >    - 13.03% helper_lookup_tb_ptr
>> >       + 11.19% tb_htable_lookup
>> >         0.55% cpu_get_tb_cpu_state
>> >
>> >      0.98%     0.71%  qemu-system-aar  [.] cpu_get_tb_cpu_state
>> >
>> >      0.87%     0.24%  qemu-system-aar  [.] rebuild_hflags_a64
>> >
>> > Before, helper_lookup_tb_ptr is the second hottest function in the
>> > application, consuming almost a quarter of the runtime.  Within the
>> > entire execution, cpu_get_tb_cpu_state consumes about 12%.
>> >
>> > After, helper_lookup_tb_ptr has dropped to the fourth hottest function,
>> > with consumption dropping to a sixth of the runtime.  Within the
>> > entire execution, cpu_get_tb_cpu_state has dropped below 1%, and the
>> > supporting function to rebuild hflags also consumes about 1%.
>> >
>> > Assertions are retained for --enable-debug-tcg.
>> >
>> > Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> Hmm something must have been missed for M-profile because:
>>
>>   make run-tcg-tests-arm-softmmu V=3D1
>>
>> Leads to:
>>
>>   timeout 15  /home/alex/lsrc/qemu.git/builds/all.debug/arm-softmmu/qemu=
-system-arm -monitor none -display none -chardev file,path=3Dtest-armv6m-un=
def.out,id=3Doutput -semihosting -M microbit -kernel test-armv6m-undef
>>   qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -=
1)
>>
>>   R00=3D00000000 R01=3D00000000 R02=3D00000000 R03=3D00000000
>>   R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D00000000
>>   R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
>>   R12=3D00000000 R13=3D20003fe0 R14=3Dfffffff9 R15=3D000000c0
>>   XPSR=3D41000003 -Z-- T handler
>>   FPSCR: 00000000
>>   timeout: the monitored command dumped core
>>
>> But annoyingly not shown up by the debug-tcg verification. The commit
>> before works fine.
>
> There's a typo in the patch:  that should not be CONFIG_TCG_DEBUG but
> CONFIG_DEBUG_TCG.  With this you should see the assert fire.

Indeed:

  cpu_get_tb_cpu_state: cache 110000c0 <> 312000c0

I wish there was an assert form that would handily print out the
difference between the two values. I wonder if glib has one...

>
> I let Richard know that there's an issue with the handling of CPSR E
> flag (BE_DATA in hflags).  I don't know if that applies to your test.
>
> Thanks,
>
> Laurent
>
>> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> > ---
>> > v2: Retain asserts for future debugging.
>> > ---
>> >  target/arm/helper.c | 9 ++++++---
>> >  1 file changed, 6 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/target/arm/helper.c b/target/arm/helper.c
>> > index d1bf71a260..5e4f996882 100644
>> > --- a/target/arm/helper.c
>> > +++ b/target/arm/helper.c
>> > @@ -11211,12 +11211,15 @@ void HELPER(rebuild_hflags_a64)(CPUARMState =
*env, int el)
>> >  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>> >                            target_ulong *cs_base, uint32_t *pflags)
>> >  {
>> > -    uint32_t flags, pstate_for_ss;
>> > +    uint32_t flags =3D env->hflags;
>> > +    uint32_t pstate_for_ss;
>> >
>> >      *cs_base =3D 0;
>> > -    flags =3D rebuild_hflags_internal(env);
>> > +#ifdef CONFIG_TCG_DEBUG
>> > +    assert(flags =3D=3D rebuild_hflags_internal(env));
>> > +#endif
>> >
>> > -    if (is_a64(env)) {
>> > +    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
>> >          *pc =3D env->pc;
>> >          if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
>> >              flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype=
);
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e

