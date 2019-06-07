Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897F9C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6069720840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6069720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZF4y-0004jw-Hy
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZF3X-0003Pw-3r
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZF3U-0007bR-Sh
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:37:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZF3S-0007Zc-TR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:37:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so2223449wrs.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BTSgfAfKiPw52zAQi1EVAPSp7Wl8ml8g5jEZmS5OajA=;
 b=LaJ+LXGY8F1ug8KLnXy+EwA7slQWOJq3BAkhcYCTorh4HRusPo64mQD4JhAGeS+opA
 ibrb9YitaZsaOdVBZ8ePQyFeNWI3XB633HqU8o8nrnRoju5d0d/N/isn+kOSzEAOVT/M
 0/EA0e/A/BsViFl5XPHNytcsQAGqytpYYFrsRZfXMGFrOMrQ7XzbdV+Q0FckmwquhIeO
 +n3SaH/w/Gbuw44KjiYZP6XwQPVPMA3TewB0SZAfQxyN4g6awW0oXaPh2D3OXRKyVatT
 G7wBz4UF2OVgWH0alGXy0IASi/nFBjnH63yrmp94PjU2jHskvHPqeQ0V70Ftiercf+Qq
 y73w==
X-Gm-Message-State: APjAAAWBndEiaHVu7WkB7q9l86xDtDOuhECEqs9e1Z1RgE0lEKO/fuaJ
 fZaEJN8kk/e3RqCM+iI53YBiHm8RbXg=
X-Google-Smtp-Source: APXvYqzPQrcZJHTZAa7DPZNsLaqVa1YOy+TGGieS9gbEv7vLNS1viHg4/wGRM/PCsXFb5/UpcJ7PxA==
X-Received: by 2002:adf:80e1:: with SMTP id 88mr25517544wrl.346.1559914633589; 
 Fri, 07 Jun 2019 06:37:13 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id x129sm2631533wmg.44.2019.06.07.06.37.12
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 06:37:13 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190517174046.11146-1-peter.maydell@linaro.org>
 <20190517174046.11146-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <329c104e-c5b8-2faa-53a5-b89db9b009f9@redhat.com>
Date: Fri, 7 Jun 2019 15:37:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517174046.11146-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 1/4] target/arm: Allow VFP and Neon to be
 disabled via a CPU property
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 7:40 PM, Peter Maydell wrote:
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
> @@ -763,6 +763,12 @@ static Property arm_cpu_cfgend_property =
>  static Property arm_cpu_has_pmu_property =
>              DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
>  
> +static Property arm_cpu_has_vfp_property =
> +            DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
> +
> +static Property arm_cpu_has_neon_property =
> +            DEFINE_PROP_BOOL("neon", ARMCPU, has_neon, true);
> +
>  static Property arm_cpu_has_mpu_property =
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

I wondered about that last week when refreshing Samuel TCG/KVM split,
because the VFP code pulls a lot of unnecessary code on KVM (in
particular the softfloat lib).

> +    if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
> +        cpu->has_vfp = true;
> +        if (!kvm_enabled()) {
> +            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property,
> +                                     &error_abort);
> +        }
> +    }
> +
> +    if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
> +        cpu->has_neon = true;
> +        if (!kvm_enabled()) {
> +            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property,
> +                                     &error_abort);
> +        }
> +    }
> +
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
>          qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property,
>                                   &error_abort);
> @@ -956,6 +990,116 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> +        cpu->has_vfp != cpu->has_neon) {
> +        /*
> +         * This is an architectural requirement for AArch64; AArch32 is
> +         * more flexible and permits VFP-no-Neon and Neon-no-VFP.
> +         */
> +        error_setg(errp,
> +                   "AArch64 CPUs must have both VFP and Neon or neither");
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
> +        t = cpu->isar.id_aa64isar1;
> +        t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 0);
> +        cpu->isar.id_aa64isar1 = t;
> +
> +        t = cpu->isar.id_aa64pfr0;
> +        t = FIELD_DP64(t, ID_AA64PFR0, FP, 0xf);
> +        cpu->isar.id_aa64pfr0 = t;
> +
> +        u = cpu->isar.id_isar6;
> +        u = FIELD_DP32(u, ID_ISAR6, JSCVT, 0);
> +        cpu->isar.id_isar6 = u;
> +
> +        u = cpu->isar.mvfr0;
> +        u = FIELD_DP32(u, MVFR0, FPSP, 0);
> +        u = FIELD_DP32(u, MVFR0, FPDP, 0);
> +        u = FIELD_DP32(u, MVFR0, FPTRAP, 0);
> +        u = FIELD_DP32(u, MVFR0, FPDIVIDE, 0);
> +        u = FIELD_DP32(u, MVFR0, FPSQRT, 0);
> +        u = FIELD_DP32(u, MVFR0, FPSHVEC, 0);
> +        u = FIELD_DP32(u, MVFR0, FPROUND, 0);
> +        cpu->isar.mvfr0 = u;
> +
> +        u = cpu->isar.mvfr1;
> +        u = FIELD_DP32(u, MVFR1, FPFTZ, 0);
> +        u = FIELD_DP32(u, MVFR1, FPDNAN, 0);
> +        u = FIELD_DP32(u, MVFR1, FPHP, 0);
> +        cpu->isar.mvfr1 = u;
> +
> +        u = cpu->isar.mvfr2;
> +        u = FIELD_DP32(u, MVFR2, FPMISC, 0);
> +        cpu->isar.mvfr2 = u;
> +    }
> +
> +    if (!cpu->has_neon) {
> +        uint64_t t;
> +        uint32_t u;
> +
> +        unset_feature(env, ARM_FEATURE_NEON);
> +
> +        t = cpu->isar.id_aa64isar0;
> +        t = FIELD_DP64(t, ID_AA64ISAR0, DP, 0);
> +        cpu->isar.id_aa64isar0 = t;
> +
> +        t = cpu->isar.id_aa64isar1;
> +        t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 0);
> +        cpu->isar.id_aa64isar1 = t;
> +
> +        t = cpu->isar.id_aa64pfr0;
> +        t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 0xf);
> +        cpu->isar.id_aa64pfr0 = t;
> +
> +        u = cpu->isar.id_isar5;
> +        u = FIELD_DP32(u, ID_ISAR5, RDM, 0);
> +        u = FIELD_DP32(u, ID_ISAR5, VCMA, 0);
> +        cpu->isar.id_isar5 = u;
> +
> +        u = cpu->isar.id_isar6;
> +        u = FIELD_DP32(u, ID_ISAR6, DP, 0);
> +        u = FIELD_DP32(u, ID_ISAR6, FHM, 0);
> +        cpu->isar.id_isar6 = u;
> +
> +        u = cpu->isar.mvfr1;
> +        u = FIELD_DP32(u, MVFR1, SIMDLS, 0);
> +        u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
> +        u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
> +        u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
> +        u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
> +        cpu->isar.mvfr1 = u;
> +
> +        u = cpu->isar.mvfr2;
> +        u = FIELD_DP32(u, MVFR2, SIMDMISC, 0);
> +        cpu->isar.mvfr2 = u;
> +    }
> +
> +    if (!cpu->has_neon && !cpu->has_vfp) {
> +        uint64_t t;
> +        uint32_t u;
> +
> +        t = cpu->isar.id_aa64isar0;
> +        t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 0);
> +        cpu->isar.id_aa64isar0 = t;
> +
> +        t = cpu->isar.id_aa64isar1;
> +        t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 0);
> +        cpu->isar.id_aa64isar1 = t;
> +
> +        u = cpu->isar.mvfr0;
> +        u = FIELD_DP32(u, MVFR0, SIMDREG, 0);
> +        cpu->isar.mvfr0 = u;
> +    }
> +
>      /* Some features automatically imply others: */
>      if (arm_feature(env, ARM_FEATURE_V8)) {
>          if (arm_feature(env, ARM_FEATURE_M)) {
> @@ -1016,12 +1160,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
> 

I really like the *_feature() API, it is very clean and powerful.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

