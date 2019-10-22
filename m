Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88929CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50431214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYvmolYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50431214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwNQ-00037T-4Z
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 11:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iMwIR-00089G-1J
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iMwIO-0007p3-BQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:42:06 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iMwIM-0007mD-By
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:42:03 -0400
Received: by mail-il1-x144.google.com with SMTP id i12so5345701ils.6
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3UvwCURAdhSeJtnX3N66EUsZ6znlKuIw+tRWhdxOI8Q=;
 b=hYvmolYh13GgwlSe1swT0cQZZYOwlO9px0SdW/Zjxtu3PmYQmdBWN9HI0nE3yEg5wd
 mnBC/43jUmUsHUL1GYLIfP4k7fxIReCl/IZ9FVxH8RZJnK9llcgi7HE327Zbl1GIk1XN
 nlqDZtimWwkca20MkiZ2jUR/o2FNF3uXbvhqfpBA2jLU4q5frU0MJ90jLC6yUHDC2n2R
 qXD0lAuJwg/VhZYm2R8Lmy62Tq0GLuMHqtGTmgjDLdb62aSVWtTFGBnfaPiHK0i7dCKz
 omjMCB3sI9zEEgR22xfMnFArA21/NP/ihlDEQHbmS7O0jLx78APkYCSpQ4PgdQFCB7Hp
 5v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3UvwCURAdhSeJtnX3N66EUsZ6znlKuIw+tRWhdxOI8Q=;
 b=Glp9F7UMIsP4krQlaMWw6et9hFSdbgPkCas2l7ZN7Kn+b0Y3xJvNtth3ZWJl/WAv0Y
 4INllIvhiiDKNqdsLC/HcHubdz/dhJKlMzkrQ1o5ywQAgLS0GnmNA/aUDF+rYn5PlS9e
 rkiaEtwmQQMoV7aTtkdaAha3n/n0HJENvoRpz0JZlRuz3LpyY2XX5QWLskFUAdNI8/y+
 UgYk8gnu+6VD5EXVSWZ1a7GYUSp5c0kVXmAxRunxnkIwRGzrdE1b612KyXDDPL45j4GP
 g0Ndrv9/2WAHALpocuwrhl6S4Xzu53mtARuBgikcWqEDcyJmSgK2D6QL7d0i0HmABVOm
 4YpQ==
X-Gm-Message-State: APjAAAXc6BVd/5drhM3Jzc7NY4VnJ8VWPZoa/HLU5yX/mmShaP4CDyw4
 EmhJdUG3AYqqo1TiPMqJiULqsgYIwRw+PZjKGVAB4Q==
X-Google-Smtp-Source: APXvYqwaqkrk9Zi2ZH9Upg6zTMgzRwH6Poel8RYsFtFrd3WZvWynP+GlhmS4bX4P3O7C3pKBehBCIzYTft49G8aJIfQ=
X-Received: by 2002:a92:2406:: with SMTP id k6mr34315753ilk.260.1571758920300; 
 Tue, 22 Oct 2019 08:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085408.24360-1-drjones@redhat.com>
 <20191016085408.24360-4-drjones@redhat.com>
In-Reply-To: <20191016085408.24360-4-drjones@redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 22 Oct 2019 16:41:47 +0100
Message-ID: <CADSWDzu_QvnmSg1RMBsxQ0Hj81TuaeZqg7NsvHnagemtTnWHow@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] target/arm: Allow SVE to be disabled via a CPU
 property
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew

On Wed, 16 Oct 2019 at 09:57, Andrew Jones <drjones@redhat.com> wrote:
>
> Since 97a28b0eeac14 ("target/arm: Allow VFP and Neon to be disabled via
> a CPU property") we can disable the 'max' cpu model's VFP and neon
> features, but there's no way to disable SVE. Add the 'sve=on|off'
> property to give it that flexibility. We also rename
> cpu_max_get/set_sve_vq to cpu_max_get/set_sve_max_vq in order for them
> to follow the typical *_get/set_<property-name> pattern.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Beata Michalska <beata.michalska@linaro.org>

Thanks.

BR
Beata
> ---
>  target/arm/cpu.c         |  3 ++-
>  target/arm/cpu64.c       | 52 ++++++++++++++++++++++++++++++++++------
>  target/arm/monitor.c     |  2 +-
>  tests/arm-cpu-features.c |  1 +
>  4 files changed, 49 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 13813fb21354..2a1e95e90df3 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -200,7 +200,8 @@ static void arm_cpu_reset(CPUState *s)
>          env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
>          env->cp15.cptr_el[3] |= CPTR_EZ;
>          /* with maximum vector length */
> -        env->vfp.zcr_el[1] = cpu->sve_max_vq - 1;
> +        env->vfp.zcr_el[1] = cpu_isar_feature(aa64_sve, cpu) ?
> +                             cpu->sve_max_vq - 1 : 0;
>          env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
>          env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
>          /*
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index d7f5bf610a7d..89a8ae77fe84 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -256,15 +256,23 @@ static void aarch64_a72_initfn(Object *obj)
>      define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
>  }
>
> -static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
> -                               void *opaque, Error **errp)
> +static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> -    visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
> +    uint32_t value;
> +
> +    /* All vector lengths are disabled when SVE is off. */
> +    if (!cpu_isar_feature(aa64_sve, cpu)) {
> +        value = 0;
> +    } else {
> +        value = cpu->sve_max_vq;
> +    }
> +    visit_type_uint32(v, name, &value, errp);
>  }
>
> -static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
> -                               void *opaque, Error **errp)
> +static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>      Error *err = NULL;
> @@ -279,6 +287,34 @@ static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
>      error_propagate(errp, err);
>  }
>
> +static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    bool value = cpu_isar_feature(aa64_sve, cpu);
> +
> +    visit_type_bool(v, name, &value, errp);
> +}
> +
> +static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    Error *err = NULL;
> +    bool value;
> +    uint64_t t;
> +
> +    visit_type_bool(v, name, &value, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    t = cpu->isar.id_aa64pfr0;
> +    t = FIELD_DP64(t, ID_AA64PFR0, SVE, value);
> +    cpu->isar.id_aa64pfr0 = t;
> +}
> +
>  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
>   * otherwise, a CPU with as many features enabled as our emulation supports.
>   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> @@ -391,8 +427,10 @@ static void aarch64_max_initfn(Object *obj)
>  #endif
>
>          cpu->sve_max_vq = ARM_MAX_VQ;
> -        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
> -                            cpu_max_set_sve_vq, NULL, NULL, &error_fatal);
> +        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
> +                            cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
> +        object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> +                            cpu_arm_set_sve, NULL, NULL, &error_fatal);
>      }
>  }
>
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index 560970de7f5c..2209b27b9a08 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -97,7 +97,7 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
>   * then the order that considers those dependencies must be used.
>   */
>  static const char *cpu_model_advertised_features[] = {
> -    "aarch64", "pmu",
> +    "aarch64", "pmu", "sve",
>      NULL
>  };
>
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> index 198ff6d6b495..202bc0e3e823 100644
> --- a/tests/arm-cpu-features.c
> +++ b/tests/arm-cpu-features.c
> @@ -179,6 +179,7 @@ static void test_query_cpu_model_expansion(const void *data)
>
>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
>          assert_has_feature(qts, "max", "aarch64");
> +        assert_has_feature(qts, "max", "sve");
>          assert_has_feature(qts, "cortex-a57", "pmu");
>          assert_has_feature(qts, "cortex-a57", "aarch64");
>
> --
> 2.21.0
>
>

