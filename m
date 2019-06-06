Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32859C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0DA207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0DA207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYo0Y-00058v-Pa
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 04:44:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hYnyk-0003Zd-GN
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hYnnJ-0002w5-6d
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:30:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hYnnH-0001pW-IU; Thu, 06 Jun 2019 04:30:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E68A380F81;
	Thu,  6 Jun 2019 08:30:09 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B587410841F0;
	Thu,  6 Jun 2019 08:30:01 +0000 (UTC)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-8-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <839be91f-6764-28b1-c0fb-304477bfadf8@redhat.com>
Date: Thu, 6 Jun 2019 10:30:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190512083624.8916-8-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 06 Jun 2019 08:30:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/13] target/arm/kvm: max cpu: Allow sve
 max vector length setting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
	abologna@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,
On 5/12/19 10:36 AM, Andrew Jones wrote:
> Allow the cpu type 'max' sve-max-vq property to work with kvm
> too. If the property is not specified then the maximum kvm
> supports is used. If it is specified we check that kvm supports
> that exact length or error out if it doesn't.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.h   |  4 +++
>  target/arm/cpu64.c |  7 ++--
>  target/arm/kvm64.c | 80 ++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 86 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 733b840a7127..8292d547e8f9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3122,6 +3122,10 @@ static inline uint64_t arm_sctlr(CPUARMState *env, int el)
>      }
>  }
>  
> +static inline int arm_cpu_fls64(uint64_t v)
> +{
> +    return !v ? 0 : 64 - clz64(v);
> +}
>  
>  /* Return true if the processor is in big-endian mode. */
>  static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 6c19ef6837d5..3756e7e2a3e5 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -292,7 +292,7 @@ static void aarch64_max_initfn(Object *obj)
>  
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> -        cpu->sve_max_vq = ARM_MAX_VQ;
> +        cpu->sve_max_vq = -1; /* set in kvm_arch_init_vcpu() */
>      } else {
>          uint64_t t;
>          uint32_t u;
> @@ -374,9 +374,10 @@ static void aarch64_max_initfn(Object *obj)
>  #endif
>  
>          cpu->sve_max_vq = ARM_MAX_VQ;
> -        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
> -                            cpu_max_set_sve_vq, NULL, NULL, &error_fatal);
>      }
> +
> +    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
> +                        cpu_max_set_sve_vq, NULL, NULL, &error_fatal);>  }
>  
>  struct ARMCPUInfo {
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index c2d92df75353..0c666e405357 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -446,6 +446,59 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
>      }
>  }
>  
> +static int kvm_arm_get_sve_vls(CPUState *cs, uint64_t sve_vls[])
> +{
> +    struct kvm_one_reg reg = {
> +        .id = KVM_REG_ARM64_SVE_VLS,
> +        .addr = (uint64_t)&sve_vls[0],
> +    };
> +    int i, ret;
> +
> +    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = 0;
is it mandated?
> +    for (i = KVM_ARM64_SVE_VLS_WORDS - 1; i >= 0; --i) {
> +        if (sve_vls[i]) {
> +            ret = arm_cpu_fls64(sve_vls[i]) + i * 64;
> +            break;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static int kvm_arm_set_sve_vls(CPUState *cs, uint64_t sve_vls[], int max_vq)
> +{
> +    struct kvm_one_reg reg = {
> +        .id = KVM_REG_ARM64_SVE_VLS,
> +        .addr = (uint64_t)&sve_vls[0],
> +    };
> +    int i;
> +
> +    for (i = KVM_ARM64_SVE_VLS_WORDS - 1; i >= 0; --i) {
> +        if (sve_vls[i]) {
> +            int vq = arm_cpu_fls64(sve_vls[i]) + i * 64;
nit: add a line
> +            while (vq > max_vq) {
> +                sve_vls[i] &= ~BIT_MASK(vq - 1);
Isn't BIT_MASK for 32b. MAKE_64BIT_MASK?
> +                vq = arm_cpu_fls64(sve_vls[i]) + i * 64;
> +            }
> +            if (vq < max_vq) {
I don't really get this check: having vq less than max_vq does not seems
weird. Do you absolutely want vq=max_vq?
> +                error_report("sve-max-vq=%d is not a valid length", max_vq);
> +                error_printf("next lowest is %d\n", vq);
why mixing error_report/printf?
> +                return -EINVAL;
> +            }
> +            if (vq == max_vq) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +}
> +
>  static inline void set_feature(uint64_t *features, int feature)
>  {
>      *features |= 1ULL << feature;
> @@ -605,7 +658,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>      if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE ||
>          !object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU)) {
> -        fprintf(stderr, "KVM is not supported for this guest CPU type\n");
> +        error_report("KVM is not supported for this guest CPU type");
>          return -EINVAL;
>      }
>  
> @@ -631,7 +684,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      }
>      if (cpu->sve_max_vq) {
>          if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_SVE)) {
> -            cpu->sve_max_vq = 0;
> +            if (cpu->sve_max_vq == -1) {> +                cpu->sve_max_vq = 0;
> +            } else {
> +                error_report("This KVM host does not support SVE");
> +                return -EINVAL;
> +            }
>          } else {
>              cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
>          }
> @@ -644,6 +702,24 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      }
>  
>      if (cpu->sve_max_vq) {
> +        uint64_t sve_vls[KVM_ARM64_SVE_VLS_WORDS];
line
> +        ret = kvm_arm_get_sve_vls(cs, sve_vls);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        if (cpu->sve_max_vq == -1) {> +            cpu->sve_max_vq = ret;
> +        } else if (cpu->sve_max_vq > ret) {
> +            error_report("This KVM host does not support SVE vectors "
I would rephrase the error mesg with something like:
This KVM host supports SVE vectors of max VQ=%d whereas requested VQ is %d
> +                         "of length %d quadwords (%d bytes)",
> +                         cpu->sve_max_vq, cpu->sve_max_vq * 16);
> +            return -EINVAL;
> +        } else {
> +            ret = kvm_arm_set_sve_vls(cs, sve_vls, cpu->sve_max_vq);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
>          ret = kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
>          if (ret) {
>              return ret;
> 
Thanks

Eric

