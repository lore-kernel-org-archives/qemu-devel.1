Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786FAC31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 03:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B38217D4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 03:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B38217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hciWF-0006uh-2A
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 23:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43739)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <xiaoyao.li@linux.intel.com>) id 1hciUJ-00068e-TE
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 23:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@linux.intel.com>) id 1hciUH-0007Eq-P1
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 23:39:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:2806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@linux.intel.com>)
 id 1hciUG-0007B2-6I
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 23:39:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jun 2019 20:39:07 -0700
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.123])
 ([10.239.13.123])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 16 Jun 2019 20:39:05 -0700
To: Tao Xu <tao3.xu@intel.com>, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com
References: <20190616153525.27072-1-tao3.xu@intel.com>
 <20190616153525.27072-3-tao3.xu@intel.com>
From: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Message-ID: <94f9e831-38a0-3cc3-f566-6c8e5909d0fd@linux.intel.com>
Date: Mon, 17 Jun 2019 11:39:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616153525.27072-3-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH v3 2/2] target/i386: Add support for
 save/load IA32_UMWAIT_CONTROL MSR
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
Cc: cohuck@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 jingqi.liu@intel.com, mtosatti@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/16/2019 11:35 PM, Tao Xu wrote:
> UMWAIT and TPAUSE instructions use IA32_UMWAIT_CONTROL at MSR index
> E1H to determines the maximum time in TSC-quanta that the processor
> can reside in either C0.1 or C0.2.
> 
> This patch is to Add support for save/load IA32_UMWAIT_CONTROL MSR in
> guest.
> 
> Co-developed-by: Jingqi Liu <jingqi.liu@intel.com>
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> no changes in v3:
> ---
>   target/i386/cpu.h     |  2 ++
>   target/i386/kvm.c     | 13 +++++++++++++
>   target/i386/machine.c | 20 ++++++++++++++++++++
>   3 files changed, 35 insertions(+)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 2f7c57a3c2..eb98b2e54a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -450,6 +450,7 @@ typedef enum X86Seg {
>   
>   #define MSR_IA32_BNDCFGS                0x00000d90
>   #define MSR_IA32_XSS                    0x00000da0
> +#define MSR_IA32_UMWAIT_CONTROL         0xe1
>   
>   #define XSTATE_FP_BIT                   0
>   #define XSTATE_SSE_BIT                  1
> @@ -1348,6 +1349,7 @@ typedef struct CPUX86State {
>       uint16_t fpregs_format_vmstate;
>   
>       uint64_t xss;
> +    uint64_t umwait;
>   
>       TPRAccess tpr_access_type;
>   } CPUX86State;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 3efdb90f11..506c7cd038 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -91,6 +91,7 @@ static bool has_msr_hv_stimer;
>   static bool has_msr_hv_frequencies;
>   static bool has_msr_hv_reenlightenment;
>   static bool has_msr_xss;
> +static bool has_msr_umwait;
>   static bool has_msr_spec_ctrl;
>   static bool has_msr_virt_ssbd;
>   static bool has_msr_smi_count;
> @@ -1486,6 +1487,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>                   case MSR_IA32_XSS:
>                       has_msr_xss = true;
>                       break;
> +                case MSR_IA32_UMWAIT_CONTROL:
> +                    has_msr_umwait = true;
> +                    break;

Need to add MSR_IA32_UMWAIT_CONTROL into msrs_to_save[] in your kvm 
patches, otherwise qemu never goes into this case.

>                   case HV_X64_MSR_CRASH_CTL:
>                       has_msr_hv_crash = true;
>                       break;
> @@ -2023,6 +2027,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>       if (has_msr_xss) {
>           kvm_msr_entry_add(cpu, MSR_IA32_XSS, env->xss);
>       }
> +    if (has_msr_umwait) {
> +        kvm_msr_entry_add(cpu, MSR_IA32_UMWAIT_CONTROL, env->umwait);
> +    }
>       if (has_msr_spec_ctrl) {
>           kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, env->spec_ctrl);
>       }
> @@ -2416,6 +2423,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>       if (has_msr_xss) {
>           kvm_msr_entry_add(cpu, MSR_IA32_XSS, 0);
>       }
> +    if (has_msr_umwait) {
> +        kvm_msr_entry_add(cpu, MSR_IA32_UMWAIT_CONTROL, 0);
> +    }
>       if (has_msr_spec_ctrl) {
>           kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, 0);
>       }
> @@ -2665,6 +2675,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>           case MSR_IA32_XSS:
>               env->xss = msrs[i].data;
>               break;
> +        case MSR_IA32_UMWAIT_CONTROL:
> +            env->umwait = msrs[i].data;
> +            break;
>           default:
>               if (msrs[i].index >= MSR_MC0_CTL &&
>                   msrs[i].index < MSR_MC0_CTL + (env->mcg_cap & 0xff) * 4) {
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 4aff1a763f..db388b6b85 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -810,6 +810,25 @@ static const VMStateDescription vmstate_xss = {
>       }
>   };
>   
> +static bool umwait_needed(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +    CPUX86State *env = &cpu->env;
> +
> +    return env->umwait != 0;
> +}
> +
> +static const VMStateDescription vmstate_umwait = {
> +    .name = "cpu/umwait",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = umwait_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(env.umwait, X86CPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   #ifdef TARGET_X86_64
>   static bool pkru_needed(void *opaque)
>   {
> @@ -1100,6 +1119,7 @@ VMStateDescription vmstate_x86_cpu = {
>           &vmstate_msr_hyperv_reenlightenment,
>           &vmstate_avx512,
>           &vmstate_xss,
> +        &vmstate_umwait,
>           &vmstate_tsc_khz,
>           &vmstate_msr_smi_count,
>   #ifdef TARGET_X86_64
> 

