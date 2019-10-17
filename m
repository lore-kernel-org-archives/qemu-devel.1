Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861EEECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A822089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOuD86FE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A822089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9KT-0005pV-TT
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1iL8rW-0004ze-UW
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1iL8rV-0004CO-An
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:42:54 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1iL8rV-0004BJ-5z; Thu, 17 Oct 2019 12:42:53 -0400
Received: by mail-qt1-x844.google.com with SMTP id w14so4491805qto.9;
 Thu, 17 Oct 2019 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HiiNYwNsBT8xcUSwDFs/OWWEXTaT1ouYkQZp0N3hl6k=;
 b=rOuD86FEFlVfXybEKlE/7IxpY3ENRbiaTNgBR7k1ED/qrFw5FAqynUgUeVc64x0aD1
 +AcTSKGymmbT2BpPFmUzB8Z1PtnrirnNJh8l2TucwNgKimntPNzqfF6TqLO7Cn3s9Is7
 BMWrmP3HRAa8COTvflb2LBF4Y1q+9VyYd9esf/3qLXoLFGMZaL5c4lttjHhED0VC44WH
 cZGXFjrHydl23l/mhmfxulgnnJ5bHj4M09zX0B9Ohe/eslN/+8F/5bQJU790GemAFAm5
 Dy4n4gQUHWfwFktggiunHF5U5pI5EkBv5FASOuPIK3Ict5T7SRFE16nvDt0ygG9ZMKaq
 FSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HiiNYwNsBT8xcUSwDFs/OWWEXTaT1ouYkQZp0N3hl6k=;
 b=VddiOvlXqNaCLKihznTaV1qfW8W7h1OWvuGmSFUFqVQx4gEhmJChLk1I5xsdfuPNs3
 GmeBtCXUckDUVX/c/JQ2TTc6nyMCd75mX+47HhyG7wWkPzNXwlX+GOSItGADYTT/2Ra9
 7+k4bnGsPOBtQQrAObRBtL2Ux8I4ylcBJDFjxO81C37J5k0bRwABl328idaNDPL0VD+z
 ppyMSteCyqW+PIY/FSpDDseIGql2OjUWHcKW3Uh0Pr1Y+QqXaEAnr/zDO7aTdUyyqb3w
 GzvBcLpGzWG00tXlNQdn01CPXOKFZVRctRjvDsvgTCJeOW8k4wGFbiH85k5yHtnvHufV
 3S/Q==
X-Gm-Message-State: APjAAAUxfOH5S1nk8j3ulSGGZXP/G5AqTYNGwmaUuwqp66JdF1IA+yD9
 EShO0HlY8oDqpzihk1nV5w==
X-Google-Smtp-Source: APXvYqw9qPIDYJgGS6C8W+BtoDxvgsSeV5bxWXMGTPQEvpJHlB+zuY3gdiePrs5ACLUdEcoldSdlEg==
X-Received: by 2002:ac8:529a:: with SMTP id s26mr4886081qtn.234.1571330571919; 
 Thu, 17 Oct 2019 09:42:51 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id a190sm1606819qkf.118.2019.10.17.09.42.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Oct 2019 09:42:51 -0700 (PDT)
Date: Thu, 17 Oct 2019 12:42:45 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v6 3/9] target/arm: Allow SVE to be disabled via a CPU
 property
Message-ID: <20191017164244.2ddbfwqwhpnvjkaq@gabell>
References: <20191016085408.24360-1-drjones@redhat.com>
 <20191016085408.24360-4-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016085408.24360-4-drjones@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 10:54:02AM +0200, Andrew Jones wrote:
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

This patch works well on aarch64 with SVE machine, thanks!
Please feel free to add:

    Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

- Masa

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

