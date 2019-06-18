Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A127C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E584206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E584206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd9mt-00061B-FH
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 04:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43622)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hd9jJ-0003dL-Si
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hd9jI-0003Fi-6P
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:44:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hd9jH-0003ED-Up
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:44:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 38BA8308FC4B;
 Tue, 18 Jun 2019 08:44:26 +0000 (UTC)
Received: from work-vm (ovpn-117-76.ams2.redhat.com [10.36.117.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B7F662926;
 Tue, 18 Jun 2019 08:44:23 +0000 (UTC)
Date: Tue, 18 Jun 2019 09:44:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190618084420.GA2850@work-vm>
References: <20190617175658.135869-1-liran.alon@oracle.com>
 <20190617175658.135869-5-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617175658.135869-5-liran.alon@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 18 Jun 2019 08:44:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU PATCH v3 4/9] KVM: i386: Block migration for
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Liran Alon (liran.alon@oracle.com) wrote:
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
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  target/i386/cpu.c |  6 ------
>  target/i386/cpu.h | 24 ++++++++++++++++++++++++
>  target/i386/kvm.c | 12 ++++++------
>  3 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 536d7d152044..197201087e65 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5170,12 +5170,6 @@ static int x86_cpu_filter_features(X86CPU *cpu)
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
> index fce6660bac00..79d9495ceb0c 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -728,6 +728,13 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
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
> @@ -1866,6 +1873,23 @@ static inline int32_t x86_get_a20_mask(CPUX86State *env)
>      }
>  }
>  
> +static inline bool cpu_has_vmx(CPUX86State *env)
> +{
> +    return (IS_INTEL_CPU(env) &&
> +            (env->features[FEAT_1_ECX] & CPUID_EXT_VMX));
> +}
> +
> +static inline bool cpu_has_svm(CPUX86State *env)
> +{
> +    return (IS_AMD_CPU(env) &&
> +            (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM));

Note that the Hygon Dhyana seems to have SVM set as well, see
target/i386/cpu.c and search for "Dhyana"

(Note the AMD users are going to be a bit more surprised by this
restriction than Intel users, since Nested has been enabled on AMD for a
long time).

Dave

> +}
> +
> +static inline bool cpu_has_nested_virt(CPUX86State *env)
> +{
> +    return (cpu_has_vmx(env) || cpu_has_svm(env));
> +}
> +
>  /* fpu_helper.c */
>  void update_fp_status(CPUX86State *env);
>  void update_mxcsr_status(CPUX86State *env);
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index c8fd53055d37..f43e2d69859e 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -906,7 +906,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>  }
>  
>  static Error *invtsc_mig_blocker;
> -static Error *vmx_mig_blocker;
> +static Error *nested_virt_mig_blocker;
>  
>  #define KVM_MAX_CPUID_ENTRIES  100
>  
> @@ -1270,13 +1270,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                                    !!(c->ecx & CPUID_EXT_SMX);
>      }
>  
> -    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
> -        error_setg(&vmx_mig_blocker,
> -                   "Nested VMX virtualization does not support live migration yet");
> -        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
> +    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
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
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

