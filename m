Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9654EC31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6831F207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v31NJkhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6831F207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRCJ-0003Dc-KS
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPoX-000633-PD
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPoR-0007W2-L4
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:30:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbPoR-0007Uq-Ba
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:30:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id f9so20769621wre.12
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CAQkI/KYT7c6DwMNv9emGR+PJjl1WDR1C4uGFY3y73M=;
 b=v31NJkhZOnZxQNZXRPStLU/t3uyU+1DIJMbH3xQ1I90gfA70o4Ehw/bwX1QY2QmE8r
 exoWXjeTj0DwdQmENDrps5YpvMmUOJVzKAjHvXty4aeTU17+pnRCEOjajTYA7s/0Uz7r
 WuhMY2wPbO/jUBeM29FAXnBPAdiBvMQ2QjBYh6A06BXLDVJ1nfTgCwtAt4ERprmqUkFU
 bpyFdBaLoNSdNFDs/sAxQZTgG6bkM3UgzF3XNZ+kKgvtFuNGW0Q3gwwwI6NPk744iBSe
 yb67Q+SiUPGecQCQ6W5UhVv/i+fkHw4AI6nxc0oocy4s8NqfQtZI4wWj6HSoLDi1eaBe
 Kwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CAQkI/KYT7c6DwMNv9emGR+PJjl1WDR1C4uGFY3y73M=;
 b=dx5upkokE3+ujZAAW93aIkCIoahnQUYg6+U0KQJYs5Sg77uOb5LVm6q1LvvSWeuZcc
 I1xXenMMufx7EQrhZVnX+XD65eqCO5vFiTi5FH7eG/EH37X4hRQ4EvF8k5kgN3Jt74oO
 5PRKVUDUyCnNCiA5vuyo/7dJYDKkNgX0a9DDbBL+RjLUR+7n/gpmm0bk3r5D/P4bbszO
 YFWFFikgy3h60cwqNZ2FcfZ9kcy+LUF197Ks1DHDsRNkvQXC1ngKB1Rs1wdrUM4j4J21
 YHmdOoNVG+3iEgu6MDJjOiSP6eOiEZR9V0CHUohRoKKLg62U6ti4W3rJSqDT3S3WJsER
 WfLA==
X-Gm-Message-State: APjAAAU3VvORIHloXQMa+zwU8gbqrYHMqOaXtjdF0cv+QNT7AEShbzcp
 QTPkyxn1EKFGUM43nZLO0k7vMqbA6pQ=
X-Google-Smtp-Source: APXvYqyAxrZGP6wSjJIudKesezgSvuG2kOVAbo2a1F1Kc4T83rg8nozzL2lFY3T1jtPXKTDBXyIRpQ==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr39664000wrw.309.1560432641874; 
 Thu, 13 Jun 2019 06:30:41 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q21sm4068078wmq.13.2019.06.13.06.30.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 06:30:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D90C61FF87;
 Thu, 13 Jun 2019 14:30:40 +0100 (BST)
References: <20190517174046.11146-1-peter.maydell@linaro.org>
 <20190517174046.11146-2-peter.maydell@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190517174046.11146-2-peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 14:30:40 +0100
Message-ID: <87a7elehof.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/4] target/arm: Allow VFP and
 Neon to be disabled via a CPU property
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


Peter Maydell <peter.maydell@linaro.org> writes:

> Allow VFP and neon to be disabled via a CPU property. As with
> the "pmu" property, we only allow these features to be removed
> from CPUs which have it by default, not added to CPUs which
> don't have it.
>
> The primary motivation here is to be able to optionally
> create Cortex-M33 CPUs with no FPU, but we provide switches
> for both VFP and Neon because the two interact:
>  * AArch64 can't have one without the other
>  * Some ID register fields only change if both are disabled
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h |   4 ++
>  target/arm/cpu.c | 150 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 148 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 733b840a712..778fb293e7c 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -797,6 +797,10 @@ struct ARMCPU {
>      bool has_el3;
>      /* CPU has PMU (Performance Monitor Unit) */
>      bool has_pmu;
> +    /* CPU has VFP */
> +    bool has_vfp;
> +    /* CPU has Neon */
> +    bool has_neon;
>
>      /* CPU has memory protection unit */
>      bool has_mpu;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 8eee1d8c59a..406fd360a2a 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -763,6 +763,12 @@ static Property arm_cpu_cfgend_property =3D
>  static Property arm_cpu_has_pmu_property =3D
>              DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
>
> +static Property arm_cpu_has_vfp_property =3D
> +            DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
> +
> +static Property arm_cpu_has_neon_property =3D
> +            DEFINE_PROP_BOOL("neon", ARMCPU, has_neon, true);
> +
>  static Property arm_cpu_has_mpu_property =3D
>              DEFINE_PROP_BOOL("has-mpu", ARMCPU, has_mpu, true);
>
> @@ -803,6 +809,13 @@ void arm_cpu_post_init(Object *obj)
>      if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
>          set_feature(&cpu->env, ARM_FEATURE_PMSA);
>      }
> +    /* Similarly for the VFP feature bits */
> +    if (arm_feature(&cpu->env, ARM_FEATURE_VFP4)) {
> +        set_feature(&cpu->env, ARM_FEATURE_VFP3);
> +    }
> +    if (arm_feature(&cpu->env, ARM_FEATURE_VFP3)) {
> +        set_feature(&cpu->env, ARM_FEATURE_VFP);
> +    }
>
>      if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
>          arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
> @@ -847,6 +860,27 @@ void arm_cpu_post_init(Object *obj)
>                                   &error_abort);
>      }
>
> +    /*
> +     * Allow user to turn off VFP and Neon support, but only for TCG --
> +     * KVM does not currently allow us to lie to the guest about its
> +     * ID/feature registers, so the guest always sees what the host has.
> +     */
> +    if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
> +        cpu->has_vfp =3D true;
> +        if (!kvm_enabled()) {
> +            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_prope=
rty,
> +                                     &error_abort);
> +        }
> +    }
> +
> +    if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
> +        cpu->has_neon =3D true;
> +        if (!kvm_enabled()) {
> +            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_prop=
erty,
> +                                     &error_abort);
> +        }
> +    }
> +
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
>          qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property,
>                                   &error_abort);
> @@ -956,6 +990,116 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>          return;
>      }
>
> +    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> +        cpu->has_vfp !=3D cpu->has_neon) {
> +        /*
> +         * This is an architectural requirement for AArch64; AArch32 is
> +         * more flexible and permits VFP-no-Neon and Neon-no-VFP.
> +         */
> +        error_setg(errp,
> +                   "AArch64 CPUs must have both VFP and Neon or neither"=
);
> +        return;
> +    }
> +
> +    if (!cpu->has_vfp) {
> +        uint64_t t;
> +        uint32_t u;
> +
> +        unset_feature(env, ARM_FEATURE_VFP);
> +        unset_feature(env, ARM_FEATURE_VFP3);
> +        unset_feature(env, ARM_FEATURE_VFP4);
> +
> +        t =3D cpu->isar.id_aa64isar1;
> +        t =3D FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 0);
> +        cpu->isar.id_aa64isar1 =3D t;
> +
> +        t =3D cpu->isar.id_aa64pfr0;
> +        t =3D FIELD_DP64(t, ID_AA64PFR0, FP, 0xf);
> +        cpu->isar.id_aa64pfr0 =3D t;
> +
> +        u =3D cpu->isar.id_isar6;
> +        u =3D FIELD_DP32(u, ID_ISAR6, JSCVT, 0);
> +        cpu->isar.id_isar6 =3D u;
> +
> +        u =3D cpu->isar.mvfr0;
> +        u =3D FIELD_DP32(u, MVFR0, FPSP, 0);
> +        u =3D FIELD_DP32(u, MVFR0, FPDP, 0);
> +        u =3D FIELD_DP32(u, MVFR0, FPTRAP, 0);
> +        u =3D FIELD_DP32(u, MVFR0, FPDIVIDE, 0);
> +        u =3D FIELD_DP32(u, MVFR0, FPSQRT, 0);
> +        u =3D FIELD_DP32(u, MVFR0, FPSHVEC, 0);
> +        u =3D FIELD_DP32(u, MVFR0, FPROUND, 0);
> +        cpu->isar.mvfr0 =3D u;
> +
> +        u =3D cpu->isar.mvfr1;
> +        u =3D FIELD_DP32(u, MVFR1, FPFTZ, 0);
> +        u =3D FIELD_DP32(u, MVFR1, FPDNAN, 0);
> +        u =3D FIELD_DP32(u, MVFR1, FPHP, 0);
> +        cpu->isar.mvfr1 =3D u;
> +
> +        u =3D cpu->isar.mvfr2;
> +        u =3D FIELD_DP32(u, MVFR2, FPMISC, 0);
> +        cpu->isar.mvfr2 =3D u;
> +    }
> +
> +    if (!cpu->has_neon) {
> +        uint64_t t;
> +        uint32_t u;
> +
> +        unset_feature(env, ARM_FEATURE_NEON);
> +
> +        t =3D cpu->isar.id_aa64isar0;
> +        t =3D FIELD_DP64(t, ID_AA64ISAR0, DP, 0);
> +        cpu->isar.id_aa64isar0 =3D t;
> +
> +        t =3D cpu->isar.id_aa64isar1;
> +        t =3D FIELD_DP64(t, ID_AA64ISAR1, FCMA, 0);
> +        cpu->isar.id_aa64isar1 =3D t;
> +
> +        t =3D cpu->isar.id_aa64pfr0;
> +        t =3D FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 0xf);
> +        cpu->isar.id_aa64pfr0 =3D t;
> +
> +        u =3D cpu->isar.id_isar5;
> +        u =3D FIELD_DP32(u, ID_ISAR5, RDM, 0);
> +        u =3D FIELD_DP32(u, ID_ISAR5, VCMA, 0);
> +        cpu->isar.id_isar5 =3D u;
> +
> +        u =3D cpu->isar.id_isar6;
> +        u =3D FIELD_DP32(u, ID_ISAR6, DP, 0);
> +        u =3D FIELD_DP32(u, ID_ISAR6, FHM, 0);
> +        cpu->isar.id_isar6 =3D u;
> +
> +        u =3D cpu->isar.mvfr1;
> +        u =3D FIELD_DP32(u, MVFR1, SIMDLS, 0);
> +        u =3D FIELD_DP32(u, MVFR1, SIMDINT, 0);
> +        u =3D FIELD_DP32(u, MVFR1, SIMDSP, 0);
> +        u =3D FIELD_DP32(u, MVFR1, SIMDHP, 0);
> +        u =3D FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
> +        cpu->isar.mvfr1 =3D u;
> +
> +        u =3D cpu->isar.mvfr2;
> +        u =3D FIELD_DP32(u, MVFR2, SIMDMISC, 0);
> +        cpu->isar.mvfr2 =3D u;
> +    }
> +
> +    if (!cpu->has_neon && !cpu->has_vfp) {
> +        uint64_t t;
> +        uint32_t u;
> +
> +        t =3D cpu->isar.id_aa64isar0;
> +        t =3D FIELD_DP64(t, ID_AA64ISAR0, FHM, 0);
> +        cpu->isar.id_aa64isar0 =3D t;
> +
> +        t =3D cpu->isar.id_aa64isar1;
> +        t =3D FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 0);
> +        cpu->isar.id_aa64isar1 =3D t;
> +
> +        u =3D cpu->isar.mvfr0;
> +        u =3D FIELD_DP32(u, MVFR0, SIMDREG, 0);
> +        cpu->isar.mvfr0 =3D u;
> +    }
> +
>      /* Some features automatically imply others: */
>      if (arm_feature(env, ARM_FEATURE_V8)) {
>          if (arm_feature(env, ARM_FEATURE_M)) {
> @@ -1016,12 +1160,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>      if (arm_feature(env, ARM_FEATURE_V5)) {
>          set_feature(env, ARM_FEATURE_V4T);
>      }
> -    if (arm_feature(env, ARM_FEATURE_VFP4)) {
> -        set_feature(env, ARM_FEATURE_VFP3);
> -    }
> -    if (arm_feature(env, ARM_FEATURE_VFP3)) {
> -        set_feature(env, ARM_FEATURE_VFP);
> -    }
>      if (arm_feature(env, ARM_FEATURE_LPAE)) {
>          set_feature(env, ARM_FEATURE_V7MP);
>          set_feature(env, ARM_FEATURE_PXN);


--
Alex Benn=C3=A9e

