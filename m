Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C698C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410972084B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410972084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfhrn-0003P8-Jq
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 05:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hfhrD-0002gP-7e
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hfhrB-0005UW-TE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:35:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hfhr8-0005Pj-WF; Tue, 25 Jun 2019 05:35:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA0CD3091851;
 Tue, 25 Jun 2019 09:35:12 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A35095D9C5;
 Tue, 25 Jun 2019 09:35:10 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-3-drjones@redhat.com>
Message-ID: <03eb93d5-0c9e-0799-6138-6f65bf60395f@redhat.com>
Date: Tue, 25 Jun 2019 11:35:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-3-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 25 Jun 2019 09:35:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 02/14] target/arm/cpu: Ensure we can use
 the pmu with kvm
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
> We first convert the pmu property from a static property to one with
> its own accessors. Then we use the set accessor to check if the PMU is
> supported when using KVM. Indeed a 32-bit KVM host does not support
> the PMU, so this check will catch an attempt to use it at property-set
> time.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.c     | 30 +++++++++++++++++++++++++-----
>  target/arm/kvm.c     |  9 +++++++++
>  target/arm/kvm_arm.h | 13 +++++++++++++
>  3 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 376db154f008..858f668d226e 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -759,10 +759,6 @@ static Property arm_cpu_has_el3_property =
>  static Property arm_cpu_cfgend_property =
>              DEFINE_PROP_BOOL("cfgend", ARMCPU, cfgend, false);
>  
> -/* use property name "pmu" to match other archs and virt tools */
> -static Property arm_cpu_has_pmu_property =
> -            DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
> -
>  static Property arm_cpu_has_vfp_property =
>              DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
>  
> @@ -785,6 +781,29 @@ static Property arm_cpu_pmsav7_dregion_property =
>                                             pmsav7_dregion,
>                                             qdev_prop_uint32, uint32_t);
>  
> +static bool arm_get_pmu(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    return cpu->has_pmu;
> +}
> +
> +static void arm_set_pmu(Object *obj, bool value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    if (value) {
> +        if (kvm_enabled() && !kvm_arm_pmu_supported(CPU(cpu))) {
> +            error_setg(errp, "'pmu' feature not supported by KVM on this host");
> +            return;
> +        }
> +        set_feature(&cpu->env, ARM_FEATURE_PMU);
> +    } else {
> +        unset_feature(&cpu->env, ARM_FEATURE_PMU);
> +    }
> +    cpu->has_pmu = value;
> +}
> +
>  static void arm_get_init_svtor(Object *obj, Visitor *v, const char *name,
>                                 void *opaque, Error **errp)
>  {
> @@ -859,7 +878,8 @@ void arm_cpu_post_init(Object *obj)
>      }
>  
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
> -        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_pmu_property,
> +        cpu->has_pmu = true;
> +        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu,
>                                   &error_abort);
>      }
>  
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index fe4f461d4ef6..69c961a4c62c 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -162,6 +162,15 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>      env->features = arm_host_cpu_features.features;
>  }
>  
> +bool kvm_arm_pmu_supported(CPUState *cpu)
> +{
> +    KVMState *s = KVM_STATE(current_machine->accelerator);
> +    int ret;
> +
> +    ret = kvm_check_extension(s, KVM_CAP_ARM_PMU_V3);
> +    return ret > 0;
return kvm_check_extension
> +}
> +
>  int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
>  {
>      KVMState *s = KVM_STATE(ms->accelerator);
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 812125f805a1..e0ded3607996 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -216,6 +216,14 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>   */
>  bool kvm_arm_aarch32_supported(CPUState *cs);
>  
> +/**
> + * bool kvm_arm_pmu_supported:
> + * @cs: CPUState
kernel-doc comment style?
> + *
> + * Returns true if the KVM VCPU can enable its PMU and false otherwise.
> + */
> +bool kvm_arm_pmu_supported(CPUState *cs);
> +
>  /**
>   * kvm_arm_get_max_vm_ipa_size - Returns the number of bits in the
>   * IPA address space supported by KVM
> @@ -261,6 +269,11 @@ static inline bool kvm_arm_aarch32_supported(CPUState *cs)
>      return false;
>  }
>  
> +static inline bool kvm_arm_pmu_supported(CPUState *cs)
> +{
> +    return false;
> +}
> +
>  static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
>  {
>      return -ENOENT;
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


