Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F63DC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3542086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3542086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgucJ-0000cZ-8O
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37744)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hgtWq-0001Z2-Rs
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hgtWo-0001ru-VX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:15:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hgtWf-0001dB-IF; Fri, 28 Jun 2019 12:15:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C77FD81F13;
 Fri, 28 Jun 2019 16:14:51 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0A36608CD;
 Fri, 28 Jun 2019 16:14:41 +0000 (UTC)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-12-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <026dd970-f524-ed17-ea25-bcad39ac8b1b@redhat.com>
Date: Fri, 28 Jun 2019 18:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-12-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 16:14:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 11/14] target/arm/kvm64: max cpu: Enable
 SVE when available
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
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 6/21/19 6:34 PM, Andrew Jones wrote:
> Enable SVE in the KVM guest when the 'max' cpu type is configured
> and KVM supports it. KVM SVE requires use of the new finalize
> vcpu ioctl, so we add that now too. For starters SVE can only be
> turned on or off, getting all vector lengths the host CPU supports
> when on. We'll add the other SVE CPU properties in later patches.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu64.c       | 24 ++++++++++++++++++++++--
>  target/arm/kvm.c         |  5 +++++
>  target/arm/kvm64.c       | 25 ++++++++++++++++++++++++-
>  target/arm/kvm_arm.h     | 27 +++++++++++++++++++++++++++
>  tests/arm-cpu-features.c |  1 +
>  5 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 5def82111dee..2e595ad53137 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -371,6 +371,11 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    /* sve-max-vq and sve<vl-bits> properties not yet implemented for KVM */
> +    if (kvm_enabled()) {
> +        return;
> +    }
> +
>      if (cpu->sve_max_vq == ARM_SVE_INIT) {
>          object_property_set_uint(OBJECT(cpu), ARM_MAX_VQ, "sve-max-vq", &err);
>          if (err) {
> @@ -632,6 +637,10 @@ static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
>      ARMCPU *cpu = ARM_CPU(obj);
>      bool value = !!cpu->sve_max_vq;
>  
> +    if (kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
> +        value = false;
> +    }
> +
>      visit_type_bool(v, name, &value, errp);
>  }
>  
> @@ -649,6 +658,11 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
>      }
>  
>      if (value) {
> +        if (kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
> +            error_setg(errp, "'sve' feature not supported by KVM on this host");
> +            return;
> +        }
> +
>          /*
>           * We handle the -cpu <cpu>,sve=off,sve=on case by reinitializing,
>           * but otherwise we don't do anything as an sve=on could come after
> @@ -675,6 +689,11 @@ static void aarch64_max_initfn(Object *obj)
>  
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> +        /*
> +         * KVM doesn't yet support the sve-max-vq property, but
> +         * setting cpu->sve_max_vq is also used to turn SVE on.
> +         */
> +        cpu->sve_max_vq = ARM_SVE_INIT;
>      } else {
>          uint64_t t;
>          uint32_t u;
> @@ -764,8 +783,6 @@ static void aarch64_max_initfn(Object *obj)
>          cpu->sve_max_vq = ARM_SVE_INIT;
>          object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
>                              cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
> -        object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> -                            cpu_arm_set_sve, NULL, NULL, &error_fatal);
>  
>          /*
>           * sve_vq_map uses a special state while setting properties, so
> @@ -780,6 +797,9 @@ static void aarch64_max_initfn(Object *obj)
>                                  cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
>          }
>      }
> +
> +    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> +                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
>  }
>  
>  struct ARMCPUInfo {
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 69c961a4c62c..60645a196d3d 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -49,6 +49,11 @@ int kvm_arm_vcpu_init(CPUState *cs)
>      return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_INIT, &init);
>  }
>  
> +int kvm_arm_vcpu_finalize(CPUState *cs, int feature)
> +{
> +    return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_FINALIZE, &feature);
> +}
> +
>  void kvm_arm_init_serror_injection(CPUState *cs)
>  {
>      cap_has_inject_serror_esr = kvm_check_extension(cs->kvm_state,
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 706541327491..9fc7f078cf68 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -604,6 +604,15 @@ bool kvm_arm_aarch32_supported(CPUState *cpu)
>      return ret > 0;
>  }
>  
> +bool kvm_arm_sve_supported(CPUState *cpu)
> +{
> +    KVMState *s = KVM_STATE(current_machine->accelerator);
> +    int ret;
> +
> +    ret = kvm_check_extension(s, KVM_CAP_ARM_SVE);
> +    return ret > 0;
return kvm_check_extension()

Eric
> +}
> +
>  #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
>  
>  int kvm_arch_init_vcpu(CPUState *cs)
> @@ -632,13 +641,20 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
>      }
>      if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
> -            cpu->has_pmu = false;
> +        cpu->has_pmu = false;
>      }
>      if (cpu->has_pmu) {
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>      } else {
>          unset_feature(&env->features, ARM_FEATURE_PMU);
>      }
> +    if (cpu->sve_max_vq) {
> +        if (!kvm_arm_sve_supported(cs)) {
> +            cpu->sve_max_vq = 0;
> +        } else {
> +            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
> +        }
> +    }
>  
>      /* Do KVM_ARM_VCPU_INIT ioctl */
>      ret = kvm_arm_vcpu_init(cs);
> @@ -646,6 +662,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
>  
> +    if (cpu->sve_max_vq) {
> +        ret = kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
>      /*
>       * When KVM is in use, PSCI is emulated in-kernel and not by qemu.
>       * Currently KVM has its own idea about MPIDR assignment, so we
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index e0ded3607996..2367f8ab78ed 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -27,6 +27,20 @@
>   */
>  int kvm_arm_vcpu_init(CPUState *cs);
>  
> +/**
> + * kvm_arm_vcpu_finalize
> + * @cs: CPUState
> + * @feature: int
> + *
> + * Finalizes the configuration of the specified VCPU feature by
> + * invoking the KVM_ARM_VCPU_FINALIZE ioctl. Features requiring
> + * this are documented in the "KVM_ARM_VCPU_FINALIZE" section of
> + * KVM's API documentation.
> + *
> + * Returns: 0 if success else < 0 error code
> + */
> +int kvm_arm_vcpu_finalize(CPUState *cs, int feature);
> +
>  /**
>   * kvm_arm_register_device:
>   * @mr: memory region for this device
> @@ -224,6 +238,14 @@ bool kvm_arm_aarch32_supported(CPUState *cs);
>   */
>  bool kvm_arm_pmu_supported(CPUState *cs);
>  
> +/**
> + * bool kvm_arm_sve_supported:
> + * @cs: CPUState
> + *
> + * Returns true if the KVM VCPU can enable SVE and false otherwise.
> + */
> +bool kvm_arm_sve_supported(CPUState *cs);
> +
>  /**
>   * kvm_arm_get_max_vm_ipa_size - Returns the number of bits in the
>   * IPA address space supported by KVM
> @@ -274,6 +296,11 @@ static inline bool kvm_arm_pmu_supported(CPUState *cs)
>      return false;
>  }
>  
> +static inline bool kvm_arm_sve_supported(CPUState *cs)
> +{
> +    return false;
> +}
> +
>  static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
>  {
>      return -ENOENT;
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> index a4bf6aec00df..67ad5f2b78d5 100644
> --- a/tests/arm-cpu-features.c
> +++ b/tests/arm-cpu-features.c
> @@ -393,6 +393,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>  
>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
>          assert_has_feature(qts, "host", "aarch64");
> +        assert_has_feature(qts, "max", "sve");
>  
>          assert_error(qts, "cortex-a15",
>              "The CPU definition 'cortex-a15' cannot "
> 

