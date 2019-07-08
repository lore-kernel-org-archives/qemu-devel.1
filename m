Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D28C606C7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3213321852
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3213321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkYHd-0006Vl-8T
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 14:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@siemens.com>) id 1hkYHA-00064f-0Q
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1hkYH8-00061v-Qp
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:22:07 -0400
Received: from thoth.sbs.de ([192.35.17.2]:57507)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1hkYH8-0005td-GA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:22:06 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x68IM1oB031924
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jul 2019 20:22:01 +0200
Received: from [167.87.37.3] ([167.87.37.3])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x68ILxOD015879;
 Mon, 8 Jul 2019 20:21:59 +0200
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-18-git-send-email-pbonzini@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a63806a8-995a-82de-a74b-a8e791073f3d@siemens.com>
Date: Mon, 8 Jul 2019 20:21:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <1561116620-22245-18-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 192.35.17.2
Subject: Re: [Qemu-devel] [PULL 17/25] target/i386: kvm: Block migration for
 vCPUs exposed with nested virtualization
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21.06.19 13:30, Paolo Bonzini wrote:
> From: Liran Alon <liran.alon@oracle.com>
> 
> Commit d98f26073beb ("target/i386: kvm: add VMX migration blocker")
> added a migration blocker for vCPU exposed with Intel VMX.
> However, migration should also be blocked for vCPU exposed with
> AMD SVM.
> 
> Both cases should be blocked because QEMU should extract additional
> vCPU state from KVM that should be migrated as part of vCPU VMState.
> E.g. Whether vCPU is running in guest-mode or host-mode.
> 
> Fixes: d98f26073beb ("target/i386: kvm: add VMX migration blocker")
> Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> Message-Id: <20190619162140.133674-6-liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c |  6 ------
>  target/i386/cpu.h | 12 ++++++++++++
>  target/i386/kvm.c | 14 +++++++-------
>  3 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c330fd9..61e44cb 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5215,12 +5215,6 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>      return rv;
>  }
>  
> -#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
> -                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
> -                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
> -#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
> -                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
> -                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
>  static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs = CPU(dev);
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7f48136..bf0c9c2 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -722,6 +722,13 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  
>  #define CPUID_VENDOR_HYGON    "HygonGenuine"
>  
> +#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
> +                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
> +                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
> +#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
> +                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
> +                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
> +
>  #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
>  #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
>  
> @@ -1848,6 +1855,11 @@ static inline int32_t x86_get_a20_mask(CPUX86State *env)
>      }
>  }
>  
> +static inline bool cpu_has_vmx(CPUX86State *env)
> +{
> +    return env->features[FEAT_1_ECX] & CPUID_EXT_VMX;
> +}
> +
>  /* fpu_helper.c */
>  void update_fp_status(CPUX86State *env);
>  void update_mxcsr_status(CPUX86State *env);
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 9864aa0..f9872f1 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1299,7 +1299,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>  }
>  
>  static Error *invtsc_mig_blocker;
> -static Error *vmx_mig_blocker;
> +static Error *nested_virt_mig_blocker;
>  
>  #define KVM_MAX_CPUID_ENTRIES  100
>  
> @@ -1597,13 +1597,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                                    !!(c->ecx & CPUID_EXT_SMX);
>      }
>  
> -    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
> -        error_setg(&vmx_mig_blocker,
> -                   "Nested VMX virtualization does not support live migration yet");
> -        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
> +    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {

This broke bisection (which I currently have to do because this pull manages to
lock up 5.1 host kernels): cpu_has_nested_virt will only come later in this series.

Jan

> +        error_setg(&nested_virt_mig_blocker,
> +                   "Nested virtualization does not support live migration yet");
> +        r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
> -            error_free(vmx_mig_blocker);
> +            error_free(nested_virt_mig_blocker);
>              return r;
>          }
>      }
> @@ -1674,7 +1674,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>   fail:
>      migrate_del_blocker(invtsc_mig_blocker);
>   fail2:
> -    migrate_del_blocker(vmx_mig_blocker);
> +    migrate_del_blocker(nested_virt_mig_blocker);
>  
>      return r;
>  }
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

