Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06882C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B523B206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW4BbUiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B523B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic1jN-0000LX-MO
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 01:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic1g3-0006Hb-Hv
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic1g1-0004Rc-NS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:28:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic1g1-0004Pz-ER
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575354529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLeZuQyuw6YFC6IRcxm7UBIoDleRGaPdn0CSqP4+MiA=;
 b=bW4BbUiOEHATuFhDspXgB7M2H+llBOGKqXUcWHeNrolieURkCyqBAxoKSwx0OowbfBe9SA
 8qUDSFPTvRpq1QJXzbl1kx9oSPMEuJm+0m9zYP4YEJRC5neZaWSBYnfAkUYhxZhFoJNAln
 3WCr4iD0yCh1av5jPaFpFS1FCmqosvI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-LK5rc4k5OsmTP6Vt-DgmhA-1; Tue, 03 Dec 2019 01:28:45 -0500
Received: by mail-wm1-f71.google.com with SMTP id n4so565338wmd.7
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 22:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T3dhrIBmP0xWTlSaoVMBR24w4bEu8bEkWt2mubgkXGE=;
 b=CNkm6mnrfikitk3i5SvXAihC1owTpKrkosdEReXwA8prfIGnIq+b/7XWBqTcvD3ROt
 8qBkdy92OI9QeGqQhO8RZE0PwPwgJcvJAg++vkcLlHfYrtIS9jia88pidpX6CUqO0wYP
 Qhp9c+30VeuzdqJ8Ey+R/ntGD4oApt0/jYPW9M7pSDum+lprBn9Njo/Q4vB+cpqdTxCn
 zjGrHlkx3w/JXDkHDxyqHIwWeLf2kx0Pd6Zixn/b+jHIExa3x8HHryPMbl2QnbPxpvK6
 IQL1IUlLdxzMHOvQ9Bvg+zxdDUeKRXPSe2bnF1neh3xhgc8l5AveLUbbP/roWLH+fKVN
 QgkA==
X-Gm-Message-State: APjAAAUmF0M5/OPW28x/ORWuPSjTMNR3Jr9qxO4wOXp0xL+c7qJLQ42R
 l8ke5oxEoWG3Bnr9wCmnpcz3Vz7Ib+UK+kiBYRJ03x5Jrdhcdegqydo1GoQgTQnrl/7M88qDWAS
 QgVpoITYqRQTS4Fs=
X-Received: by 2002:a5d:6349:: with SMTP id b9mr3298848wrw.346.1575354524384; 
 Mon, 02 Dec 2019 22:28:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ0xUEyDuYakRtmxgVKuThVyg0uPrrCHE1y7Ra8aUv3fwEcVjLpu2Pt3cWHJfXYZYuwWLfwQ==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr3298817wrw.346.1575354523978; 
 Mon, 02 Dec 2019 22:28:43 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c2sm2211271wrp.46.2019.12.02.22.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 22:28:43 -0800 (PST)
Subject: Re: [PATCH v4 37/40] target/arm: Move arm_excp_unmasked to cpu.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-38-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b6d1566d-f547-a822-9ca5-ab4e2c45ef7b@redhat.com>
Date: Tue, 3 Dec 2019 07:28:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203022937.1474-38-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: LK5rc4k5OsmTP6Vt-DgmhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 3:29 AM, Richard Henderson wrote:
> This inline function has one user in cpu.c, and need not be exposed
> otherwise.  Code movement only, with fixups for checkpatch.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   target/arm/cpu.h | 111 -------------------------------------------
>   target/arm/cpu.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 119 insertions(+), 111 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8e5aaaf415..22935e4433 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2673,117 +2673,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm=
_sync);
>   #define ARM_CPUID_TI915T      0x54029152
>   #define ARM_CPUID_TI925T      0x54029252
>  =20
> -static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx=
,
> -                                     unsigned int target_el)
> -{
> -    CPUARMState *env =3D cs->env_ptr;
> -    unsigned int cur_el =3D arm_current_el(env);
> -    bool secure =3D arm_is_secure(env);
> -    bool pstate_unmasked;
> -    int8_t unmasked =3D 0;
> -    uint64_t hcr_el2;
> -
> -    /* Don't take exceptions if they target a lower EL.
> -     * This check should catch any exceptions that would not be taken bu=
t left
> -     * pending.
> -     */
> -    if (cur_el > target_el) {
> -        return false;
> -    }
> -
> -    hcr_el2 =3D arm_hcr_el2_eff(env);
> -
> -    switch (excp_idx) {
> -    case EXCP_FIQ:
> -        pstate_unmasked =3D !(env->daif & PSTATE_F);
> -        break;
> -
> -    case EXCP_IRQ:
> -        pstate_unmasked =3D !(env->daif & PSTATE_I);
> -        break;
> -
> -    case EXCP_VFIQ:
> -        if (secure || !(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
> -            /* VFIQs are only taken when hypervized and non-secure.  */
> -            return false;
> -        }
> -        return !(env->daif & PSTATE_F);
> -    case EXCP_VIRQ:
> -        if (secure || !(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
> -            /* VIRQs are only taken when hypervized and non-secure.  */
> -            return false;
> -        }
> -        return !(env->daif & PSTATE_I);
> -    default:
> -        g_assert_not_reached();
> -    }
> -
> -    /* Use the target EL, current execution state and SCR/HCR settings t=
o
> -     * determine whether the corresponding CPSR bit is used to mask the
> -     * interrupt.
> -     */
> -    if ((target_el > cur_el) && (target_el !=3D 1)) {
> -        /* Exceptions targeting a higher EL may not be maskable */
> -        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> -            /* 64-bit masking rules are simple: exceptions to EL3
> -             * can't be masked, and exceptions to EL2 can only be
> -             * masked from Secure state. The HCR and SCR settings
> -             * don't affect the masking logic, only the interrupt routin=
g.
> -             */
> -            if (target_el =3D=3D 3 || !secure) {
> -                unmasked =3D 1;
> -            }
> -        } else {
> -            /* The old 32-bit-only environment has a more complicated
> -             * masking setup. HCR and SCR bits not only affect interrupt
> -             * routing but also change the behaviour of masking.
> -             */
> -            bool hcr, scr;
> -
> -            switch (excp_idx) {
> -            case EXCP_FIQ:
> -                /* If FIQs are routed to EL3 or EL2 then there are cases=
 where
> -                 * we override the CPSR.F in determining if the exceptio=
n is
> -                 * masked or not. If neither of these are set then we fa=
ll back
> -                 * to the CPSR.F setting otherwise we further assess the=
 state
> -                 * below.
> -                 */
> -                hcr =3D hcr_el2 & HCR_FMO;
> -                scr =3D (env->cp15.scr_el3 & SCR_FIQ);
> -
> -                /* When EL3 is 32-bit, the SCR.FW bit controls whether t=
he
> -                 * CPSR.F bit masks FIQ interrupts when taken in non-sec=
ure
> -                 * state. If SCR.FW is set then FIQs can be masked by CP=
SR.F
> -                 * when non-secure but only when FIQs are only routed to=
 EL3.
> -                 */
> -                scr =3D scr && !((env->cp15.scr_el3 & SCR_FW) && !hcr);
> -                break;
> -            case EXCP_IRQ:
> -                /* When EL3 execution state is 32-bit, if HCR.IMO is set=
 then
> -                 * we may override the CPSR.I masking when in non-secure=
 state.
> -                 * The SCR.IRQ setting has already been taken into consi=
deration
> -                 * when setting the target EL, so it does not have a fur=
ther
> -                 * affect here.
> -                 */
> -                hcr =3D hcr_el2 & HCR_IMO;
> -                scr =3D false;
> -                break;
> -            default:
> -                g_assert_not_reached();
> -            }
> -
> -            if ((scr || hcr) && !secure) {
> -                unmasked =3D 1;
> -            }
> -        }
> -    }
> -
> -    /* The PSTATE bits only mask the interrupt if we have not overriden =
the
> -     * ability above.
> -     */
> -    return unmasked || pstate_unmasked;
> -}
> -
>   #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
>   #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
>   #define CPU_RESOLVING_TYPE TYPE_ARM_CPU
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 81c33221f7..a36344d4c7 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -410,6 +410,125 @@ static void arm_cpu_reset(CPUState *s)
>       arm_rebuild_hflags(env);
>   }
>  =20
> +static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx=
,
> +                                     unsigned int target_el)
> +{
> +    CPUARMState *env =3D cs->env_ptr;
> +    unsigned int cur_el =3D arm_current_el(env);
> +    bool secure =3D arm_is_secure(env);
> +    bool pstate_unmasked;
> +    int8_t unmasked =3D 0;
> +    uint64_t hcr_el2;
> +
> +    /*
> +     * Don't take exceptions if they target a lower EL.
> +     * This check should catch any exceptions that would not be taken
> +     * but left pending.
> +     */
> +    if (cur_el > target_el) {
> +        return false;
> +    }
> +
> +    hcr_el2 =3D arm_hcr_el2_eff(env);
> +
> +    switch (excp_idx) {
> +    case EXCP_FIQ:
> +        pstate_unmasked =3D !(env->daif & PSTATE_F);
> +        break;
> +
> +    case EXCP_IRQ:
> +        pstate_unmasked =3D !(env->daif & PSTATE_I);
> +        break;
> +
> +    case EXCP_VFIQ:
> +        if (secure || !(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
> +            /* VFIQs are only taken when hypervized and non-secure.  */
> +            return false;
> +        }
> +        return !(env->daif & PSTATE_F);
> +    case EXCP_VIRQ:
> +        if (secure || !(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
> +            /* VIRQs are only taken when hypervized and non-secure.  */
> +            return false;
> +        }
> +        return !(env->daif & PSTATE_I);
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /*
> +     * Use the target EL, current execution state and SCR/HCR settings t=
o
> +     * determine whether the corresponding CPSR bit is used to mask the
> +     * interrupt.
> +     */
> +    if ((target_el > cur_el) && (target_el !=3D 1)) {
> +        /* Exceptions targeting a higher EL may not be maskable */
> +        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> +            /*
> +             * 64-bit masking rules are simple: exceptions to EL3
> +             * can't be masked, and exceptions to EL2 can only be
> +             * masked from Secure state. The HCR and SCR settings
> +             * don't affect the masking logic, only the interrupt routin=
g.
> +             */
> +            if (target_el =3D=3D 3 || !secure) {
> +                unmasked =3D 1;
> +            }
> +        } else {
> +            /*
> +             * The old 32-bit-only environment has a more complicated
> +             * masking setup. HCR and SCR bits not only affect interrupt
> +             * routing but also change the behaviour of masking.
> +             */
> +            bool hcr, scr;
> +
> +            switch (excp_idx) {
> +            case EXCP_FIQ:
> +                /*
> +                 * If FIQs are routed to EL3 or EL2 then there are cases=
 where
> +                 * we override the CPSR.F in determining if the exceptio=
n is
> +                 * masked or not. If neither of these are set then we fa=
ll back
> +                 * to the CPSR.F setting otherwise we further assess the=
 state
> +                 * below.
> +                 */
> +                hcr =3D hcr_el2 & HCR_FMO;
> +                scr =3D (env->cp15.scr_el3 & SCR_FIQ);
> +
> +                /*
> +                 * When EL3 is 32-bit, the SCR.FW bit controls whether t=
he
> +                 * CPSR.F bit masks FIQ interrupts when taken in non-sec=
ure
> +                 * state. If SCR.FW is set then FIQs can be masked by CP=
SR.F
> +                 * when non-secure but only when FIQs are only routed to=
 EL3.
> +                 */
> +                scr =3D scr && !((env->cp15.scr_el3 & SCR_FW) && !hcr);
> +                break;
> +            case EXCP_IRQ:
> +                /*
> +                 * When EL3 execution state is 32-bit, if HCR.IMO is set=
 then
> +                 * we may override the CPSR.I masking when in non-secure=
 state.
> +                 * The SCR.IRQ setting has already been taken into consi=
deration
> +                 * when setting the target EL, so it does not have a fur=
ther
> +                 * affect here.
> +                 */
> +                hcr =3D hcr_el2 & HCR_IMO;
> +                scr =3D false;
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +
> +            if ((scr || hcr) && !secure) {
> +                unmasked =3D 1;
> +            }
> +        }
> +    }
> +
> +    /*
> +     * The PSTATE bits only mask the interrupt if we have not overriden =
the
> +     * ability above.
> +     */
> +    return unmasked || pstate_unmasked;
> +}
> +
>   bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>   {
>       CPUClass *cc =3D CPU_GET_CLASS(cs);
>=20


