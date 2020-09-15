Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73D5C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F20520731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUSkG0Tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F20520731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI5Tg-0005RS-B1
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 03:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI5Sk-0004uW-BJ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 03:33:14 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI5Sh-0005Dh-Ti
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 03:33:14 -0400
Received: by mail-io1-xd43.google.com with SMTP id b6so2983347iof.6
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 00:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y/s+UJ/Ysdcnsmt2V+//M/LWXL1ge5dmgeawBIC+2t0=;
 b=cUSkG0Tg7qZiLWigWblG2NGWGNVkwgaY6C+WdmjM3qNjf2S3tLkKCURhkMYOJZcSJm
 Ks/m6p6ipzflQ1gq7JKRFEJc7JTdNMhfNMNEru2CDiFZ4qctezW5ORibrPkChvXrEks8
 YgPkDew0UEl97yWID5txZpoHV1cDKpX1cHuH9e7Lz0jQUazh62YiCnbMCNDZ1uH6WqgJ
 SXbtm8Pb/eomXrQWfEfD1eqshd/ixT4GtnkVgOiMLUyrpB0yktKnQHNjXANdWhkZWi2Y
 r4gRsQyhlvU5v+3LmlWTZlBhd/wL0xSR6T+NpAIR6JgQMYthCWfyM1+cfZak6kqLzedV
 j96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y/s+UJ/Ysdcnsmt2V+//M/LWXL1ge5dmgeawBIC+2t0=;
 b=dqygKmvBwXtpu87J4zyfIlQvLOmZ2BcmkBcg6Lth3ToLq43iYfLJ++eMj+UPf+N8zR
 htHx+Ix0bNBNRNB9RtY/UE+UgRqn1c3g3N4q2/y/LJfN93I9D3E+S/B9yGT5cLapzs+Q
 z4gc1mQr/nW0lvVhN2tuWVgfa+8VEbLxZr+6tr/KdeFWl3KdeiVC76W6/EbfvXB+JX2V
 25dzZcz9q0zI8Fc6WJcAXrX6lMCGgxhizn9i5c0rFIiWbkdWbPhzsYdGe8LRAKy1H7ZC
 d4i7DhL2qPlq2siaGP4DBgK3Nfp8XYad3Oejbi6h3H3QxjCT9s30lihS4Dv7FfSTGmdO
 +1Nw==
X-Gm-Message-State: AOAM532ldf9a856Qx1jsiSAYZKxzVEYm5q5wZw2PMqqchJsmYTvVgHfs
 cEr1n+iPOGLhTDT1EDNaxsXyz4pRaeBkXTG6XmMN
X-Google-Smtp-Source: ABdhPJzYip+2fTa/EtT+UCLXuCzKqbqDtB8+IuFYNR7VmdxYG0TsqB2hX7bkj2p4VKzvqVT+L5engF1fi0D86bTaW54=
X-Received: by 2002:a02:c72d:: with SMTP id h13mr17167274jao.17.1600155190602; 
 Tue, 15 Sep 2020 00:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600135462.git.haibo.xu@linaro.org>
 <90fec9ff0da7595f52caccf052c019d9359c8724.1600135462.git.haibo.xu@linaro.org>
 <20200915061058.zl7dbgmcjh5icu74@kamzik.brq.redhat.com>
In-Reply-To: <20200915061058.zl7dbgmcjh5icu74@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Tue, 15 Sep 2020 15:33:09 +0800
Message-ID: <CAJc+Z1FmOOJVp5xqUZAf7eKmwS6UROJ7x4PSCh5ZcfYtstMoOQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] target/arm/cpu: spe: Add an option to turn
 on/off vSPE support
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 at 14:11, Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Sep 15, 2020 at 03:11:39AM +0000, Haibo Xu wrote:
> > Adds a spe=[on/off] option to enable/disable vSPE support in
> > guest vCPU.
> >
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> > ---
> >  target/arm/cpu.c   |  6 ++++++
> >  target/arm/cpu.h   | 13 ++++++++++++
> >  target/arm/cpu64.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 71 insertions(+)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index c179e0752d..f211958eaa 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1310,6 +1310,12 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
> >              error_propagate(errp, local_err);
> >              return;
> >          }
> > +
> > +        arm_cpu_spe_finalize(cpu, &local_err);
> > +        if (local_err != NULL) {
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
> >      }
> >  }
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index a1c7d8ebae..baf2bbcee8 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -24,6 +24,7 @@
> >  #include "hw/registerfields.h"
> >  #include "cpu-qom.h"
> >  #include "exec/cpu-defs.h"
> > +#include "qapi/qapi-types-common.h"
> >
> >  /* ARM processors have a weak memory model */
> >  #define TCG_GUEST_DEFAULT_MO      (0)
> > @@ -196,9 +197,11 @@ typedef struct {
> >  #ifdef TARGET_AARCH64
> >  # define ARM_MAX_VQ    16
> >  void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
> > +void arm_cpu_spe_finalize(ARMCPU *cpu, Error **errp);
> >  #else
> >  # define ARM_MAX_VQ    1
> >  static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
> > +static inline void arm_cpu_spe_finalize(ARMCPU *cpu, Error **errp) { }
> >  #endif
> >
> >  typedef struct ARMVectorReg {
> > @@ -829,6 +832,8 @@ struct ARMCPU {
> >      bool has_el3;
> >      /* CPU has PMU (Performance Monitor Unit) */
> >      bool has_pmu;
> > +    /* CPU has SPE (Statistical Profiling Extension) */
> > +    OnOffAuto has_spe;
> >      /* CPU has VFP */
> >      bool has_vfp;
> >      /* CPU has Neon */
> > @@ -3869,6 +3874,14 @@ static inline bool isar_feature_aa64_pmu_8_4(const ARMISARegisters *id)
> >          FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
> >  }
> >
> > +/*
> > + * Currently we don't differentiate between the ARMv8.2-SPE and ARMv8.3-SPE.
> > + */
> > +static inline bool isar_feature_aa64_spe(const ARMISARegisters *id)
> > +{
> > +    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMSVER) != 0;
> > +}
> > +
> >  static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
> >  {
> >      return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 3c2b3d9599..4997c4a3c0 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -572,6 +572,55 @@ void aarch64_add_sve_properties(Object *obj)
> >      }
> >  }
> >
> > +void arm_cpu_spe_finalize(ARMCPU *cpu, Error **errp)
> > +{
> > +    uint64_t t;
> > +    uint32_t value = 0;
> > +
> > +    if (cpu->has_spe == ON_OFF_AUTO_AUTO) {
> > +        if (kvm_enabled() && kvm_arm_spe_supported()) {
> > +            cpu->has_spe = ON_OFF_AUTO_ON;
> > +        } else {
> > +            cpu->has_spe = ON_OFF_AUTO_OFF;
> > +        }
> > +    } else if (cpu->has_spe == ON_OFF_AUTO_ON) {
> > +        if (!kvm_enabled() || !kvm_arm_spe_supported()) {
> > +            error_setg(errp, "'spe' cannot be enabled on this host");
> > +            return;
> > +        }
> > +    }
> > +
> > +    /*
> > +     * According to the ARM ARM, the ID_AA64DFR0[PMSVER] currently
> > +     * support 3 values:
> > +     *
> > +     * 0b0000: SPE not implemented
> > +     * 0b0001: ARMv8.2-SPE implemented
> > +     * 0b0010: ARMv8.3-SPE implemented
> > +     *
> > +     * But the kernel KVM API didn't expose all these 3 values, and
> > +     * we can only get whether the SPE feature is supported or not.
> > +     * So here we just set the PMSVER to 1 if this feature was supported.
> > +     */
> > +    if (cpu->has_spe == ON_OFF_AUTO_ON) {
> > +        value = 1;
> > +    }
> > +
> > +    t = cpu->isar.id_aa64dfr0;
> > +    t = FIELD_DP64(t, ID_AA64DFR0, PMSVER, value);
> > +    cpu->isar.id_aa64dfr0 = t;
> > +}
> > +
> > +static bool arm_spe_get(Object *obj, Error **errp)
> > +{
> > +    return ARM_CPU(obj)->has_spe != ON_OFF_AUTO_OFF;
> > +}
> > +
> > +static void arm_spe_set(Object *obj, bool value, Error **errp)
> > +{
> > +    ARM_CPU(obj)->has_spe = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> > +}
> > +
> >  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
> >   * otherwise, a CPU with as many features enabled as our emulation supports.
> >   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> > @@ -721,6 +770,9 @@ static void aarch64_max_initfn(Object *obj)
> >      aarch64_add_sve_properties(obj);
> >      object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
> >                          cpu_max_set_sve_max_vq, NULL, NULL);
> > +
> > +    cpu->has_spe = ON_OFF_AUTO_AUTO;
> > +    object_property_add_bool(obj, "spe", arm_spe_get, arm_spe_set);
> >  }
>
> The cover-letter says we're only providing the 'spe' property for KVM
> enabled guests, but we're adding it here in the common part of the
> max init function. It should be added in the kvm_enabled() part only.
>
> Thanks,
> drew
>

Yes,  It should be in the kvm_enabled() part.
Will fix it in the next version.

Thanks,
Haibo

> >
> >  static const ARMCPUInfo aarch64_cpus[] = {
> > --
> > 2.17.1
> >
> >
>

