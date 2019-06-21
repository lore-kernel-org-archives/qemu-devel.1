Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5656FC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8552089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8552089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heMqS-0003hO-G2
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 12:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49922)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1heMox-0002Gb-KB
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1heMov-0000oz-Fc
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:55:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1heMot-0008TP-BT
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:55:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so7270790wmj.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 09:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B3cXNPMkQ85M24RjOgjVB/8elmr11voPu9Ti1BakA00=;
 b=aEoMeAqflG5sLRhWDW6XOugfrDNnn0F40edMP8tH+upul02vKMK4Powx/7Xn2dQZns
 5G2DS60GFB1D4z4iDoIaX6dMSlQT1cudJwWTTTybJokDaiYRVDAjbTskCJkwwSlhp81N
 n+W4LU3MPotWs30YyzDLSVALgAjXvp0zhnnHyBOs/9+zIyYJsrJNoUFiet5LXgpinA39
 TMgJR5gLHV23tdtUCglbq565q7O/K1TZoLySn924fRGPfBQO4tcGfODcVM4K+d7v875T
 QfJlaaIAzVgWnoCV8qhWIFnGcUBtOVVMAG0mY8ihuTSkq+SJbWuxUcGK7XjwlSkBBiiU
 fW1w==
X-Gm-Message-State: APjAAAV6zyOaBDa5rzt2QKSNC5+ZIV+CG69RYkrRl0Pd//3jU5Uo/7/g
 tYSMtVs9+2+qETCfDCIj17Uqnw==
X-Google-Smtp-Source: APXvYqy0WBPIE/POL0vFh8FdMXRz8d0smOzPUIxHmu+62M08HWx2l1PT7DcPiHa4KamFYPL9SkcMhQ==
X-Received: by 2002:a1c:1f06:: with SMTP id f6mr4991666wmf.60.1561136104380;
 Fri, 21 Jun 2019 09:55:04 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id s3sm4977789wmh.27.2019.06.21.09.55.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 09:55:03 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-7-drjones@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <80cf8467-ac4a-062e-2d50-1cefdf18b532@redhat.com>
Date: Fri, 21 Jun 2019 18:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-7-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 06/14] target/arm: Allow SVE to be
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 eric.auger@redhat.com, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 6/21/19 6:34 PM, Andrew Jones wrote:
> Since 97a28b0eeac14 ("target/arm: Allow VFP and Neon to be disabled via
> a CPU property") we can disable the 'max' cpu model's VFP and neon
> features, but there's no way to disable SVE. Add the 'sve=on|off'
> property to give it that flexibility. We also rename
> cpu_max_get/set_sve_vq to cpu_max_get/set_sve_max_vq in order for them
> to follow the typical *_get/set_<property-name> pattern.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.c         | 10 +++++-
>  target/arm/cpu64.c       | 72 ++++++++++++++++++++++++++++++++++------
>  target/arm/helper.c      |  8 +++--
>  target/arm/monitor.c     |  2 +-
>  tests/arm-cpu-features.c |  1 +
>  5 files changed, 78 insertions(+), 15 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 858f668d226e..f08e178fc84b 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -198,7 +198,7 @@ static void arm_cpu_reset(CPUState *s)
>          env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
>          env->cp15.cptr_el[3] |= CPTR_EZ;
>          /* with maximum vector length */
> -        env->vfp.zcr_el[1] = cpu->sve_max_vq - 1;
> +        env->vfp.zcr_el[1] = cpu->sve_max_vq ? cpu->sve_max_vq - 1 : 0;
>          env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
>          env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
>          /*
> @@ -1129,6 +1129,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          cpu->isar.mvfr0 = u;
>      }
>  
> +    if (!cpu->sve_max_vq) {
> +        uint64_t t;
> +
> +        t = cpu->isar.id_aa64pfr0;
> +        t = FIELD_DP64(t, ID_AA64PFR0, SVE, 0);
> +        cpu->isar.id_aa64pfr0 = t;
> +    }
> +
>      if (arm_feature(env, ARM_FEATURE_M) && !cpu->has_dsp) {
>          uint32_t u;
>  
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 946994838d8a..02ada65f240c 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -257,27 +257,75 @@ static void aarch64_a72_initfn(Object *obj)
>      define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
>  }
>  
> -static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
> -                               void *opaque, Error **errp)
> +static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>      visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
>  }
>  
> -static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
> -                               void *opaque, Error **errp)
> +static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>      Error *err = NULL;
> +    uint32_t value;
>  
> -    visit_type_uint32(v, name, &cpu->sve_max_vq, &err);
> +    visit_type_uint32(v, name, &value, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>  
> -    if (!err && (cpu->sve_max_vq == 0 || cpu->sve_max_vq > ARM_MAX_VQ)) {
> -        error_setg(&err, "unsupported SVE vector length");
> -        error_append_hint(&err, "Valid sve-max-vq in range [1-%d]\n",
> +    if (!cpu->sve_max_vq) {
> +        error_setg(errp, "cannot set sve-max-vq");
> +        error_append_hint(errp, "SVE has been disabled with sve=off\n");
> +        return;
> +    }
> +
> +    cpu->sve_max_vq = value;
> +
> +    if (cpu->sve_max_vq == 0 || cpu->sve_max_vq > ARM_MAX_VQ) {
> +        error_setg(errp, "unsupported SVE vector length");
> +        error_append_hint(errp, "Valid sve-max-vq in range [1-%d]\n",
>                            ARM_MAX_VQ);
>      }
> -    error_propagate(errp, err);
> +}
> +
> +static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    bool value = !!cpu->sve_max_vq;
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
> +
> +    visit_type_bool(v, name, &value, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    if (value) {
> +        /*
> +         * We handle the -cpu <cpu>,sve=off,sve=on case by reinitializing,
> +         * but otherwise we don't do anything as an sve=on could come after
> +         * a sve-max-vq setting.

I don't understand why would someone use that...

For the rest:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +         */
> +        if (!cpu->sve_max_vq) {
> +            cpu->sve_max_vq = ARM_MAX_VQ;
> +        }
> +    } else {
> +        cpu->sve_max_vq = 0;
> +    }
>  }
>  
>  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
> @@ -373,8 +421,10 @@ static void aarch64_max_initfn(Object *obj)
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
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index edba94004e0b..f500ccb6d31b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5314,9 +5314,13 @@ uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
>  static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                        uint64_t value)
>  {
> +    ARMCPU *cpu = env_archcpu(env);
>      int cur_el = arm_current_el(env);
> -    int old_len = sve_zcr_len_for_el(env, cur_el);
> -    int new_len;
> +    int old_len, new_len;
> +
> +    assert(cpu->sve_max_vq);
> +
> +    old_len = sve_zcr_len_for_el(env, cur_el);
>  
>      /* Bits other than [3:0] are RAZ/WI.  */
>      QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index 19e3120eef95..157c487a1551 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -90,7 +90,7 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
>  }
>  
>  static const char *cpu_model_advertised_features[] = {
> -    "aarch64", "pmu",
> +    "aarch64", "pmu", "sve",
>      NULL
>  };
>  
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> index 31b1c15bb979..509e458e9c2f 100644
> --- a/tests/arm-cpu-features.c
> +++ b/tests/arm-cpu-features.c
> @@ -158,6 +158,7 @@ static void test_query_cpu_model_expansion(const void *data)
>  
>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
>          assert_has_feature(qts, "max", "aarch64");
> +        assert_has_feature(qts, "max", "sve");
>          assert_has_feature(qts, "cortex-a57", "pmu");
>          assert_has_feature(qts, "cortex-a57", "aarch64");
>  
> 

