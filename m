Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD27C4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 03:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F92206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 03:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F92206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNSXA-0006eB-WE
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 23:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1kNSWW-0006EO-Qp
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 23:11:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:63463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1kNSWQ-000495-Jo
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 23:11:20 -0400
IronPort-SDR: mzxtJJj841ke+EE7uUnVmvvebFeKMLbLfAr2Z2JBQ67puxwS16neGXsMam3CbMRgfjHhbjq7X1
 aCJkuIVu1Iog==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="142358574"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; d="scan'208";a="142358574"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 20:11:08 -0700
IronPort-SDR: CeD51ajG6jwbcyPEiexMq7XGwE08nmmvxmO0YtOk63aEwOvn2pb4F27VAxeEa3OVbZq8frY+t9
 ktyRAm/RH/Dg==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; d="scan'208";a="495045608"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.187])
 ([10.238.4.187])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 20:11:06 -0700
Subject: Re: [Qemu-devel PATCH v2] target/i386: add "-cpu,lbr-fmt=*" support
 to enable guest LBR
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200929061217.118440-1-like.xu@linux.intel.com>
 <20200929173822.GK3717385@habkost.net>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <13744495-bdc3-c649-086b-e5ed2b935fb5@linux.intel.com>
Date: Wed, 30 Sep 2020 11:11:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929173822.GK3717385@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.55.52.151;
 envelope-from=like.xu@linux.intel.com; helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 23:11:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Kang, Luwei" <luwei.kang@intel.com>, "Strong,
 Beeman" <beeman.strong@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eduardo,

On 2020/9/30 1:38, Eduardo Habkost wrote:
> (CCing the people from the thread, as kvm_exact_match_flags would
> be useful for INTEL_PT_IP_LIP)
> 
> On Tue, Sep 29, 2020 at 02:12:17PM +0800, Like Xu wrote:
>> The last branch recording (LBR) is a performance monitor unit (PMU)
>> feature on Intel processors that records a running trace of the most
>> recent branches taken by the processor in the LBR stack. The QEMU
>> could configure whether it's enabled or not for each guest via CLI.
>>
>> The LBR feature would be enabled on the guest if:
>> - the KVM is enabled and the PMU is enabled and,
>> - the msr-based-feature IA32_PERF_CAPABILITIES is supporterd on KVM and,
>> - the supported returned value for lbr_fmt from this msr is not zero and,
>> - the requested guest vcpu model does support FEAT_1_ECX.CPUID_EXT_PDCM,
>> - the configured lbr-fmt value is the same as the host lbr_fmt value.
>>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> 
> The approach below looks better, thanks!  Only one problem below,
> with a few suggestions and questions:
> 
>> ---
>>   target/i386/cpu.c | 16 ++++++++++++++++
>>   target/i386/cpu.h | 10 ++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 3ffd877dd5..b10344be01 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6461,6 +6461,13 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>>               x86_cpu_get_supported_feature_word(w, false);
>>           uint64_t requested_features = env->features[w];
>>           uint64_t unavailable_features = requested_features & ~host_feat;
>> +        if (w == FEAT_PERF_CAPABILITIES &&
>> +            (requested_features & PERF_CAP_LBR_FMT)) {
>> +            if ((host_feat & PERF_CAP_LBR_FMT) !=
>> +                (requested_features & PERF_CAP_LBR_FMT)) {
>> +                unavailable_features |= PERF_CAP_LBR_FMT;
>> +            }
>> +        }
> 
> This looks correct, but needs to be conditional on kvm_enabled().
> 
> I also have a suggestion: instead of hardcoding the
> PERF_CAPABILITIES rules in this loop, this could become a
> FeatureWordInfo field.  It would be very useful for other
> features like intel-pt, where we need some bits to match the host
> too.

The idea looks good to me.

> 
> Could you please check if the following patch works?
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b10344be010..d4107dcc026 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -704,6 +704,8 @@ typedef struct FeatureWordInfo {
>       uint64_t migratable_flags; /* Feature flags known to be migratable */
>       /* Features that shouldn't be auto-enabled by "-cpu host" */
>       uint64_t no_autoenable_flags;
> +    /* Bits that must match host exactly when using KVM */
> +    uint64_t kvm_exact_match_flags;
>   } FeatureWordInfo;
>   
>   static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> @@ -1143,6 +1145,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           .msr = {
>               .index = MSR_IA32_PERF_CAPABILITIES,
>           },
> +        /*
> +         * KVM is not able to emulate a VCPU with LBR_FMT different
> +         * from the host, so LBR_FMT must match the host exactly.
> +         */
> +        .kvm_exact_match_flags = PERF_CAP_LBR_FMT,
>       },
>   
>       [FEAT_VMX_PROCBASED_CTLS] = {
> @@ -6457,16 +6464,15 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>       }
>   
>       for (w = 0; w < FEATURE_WORDS; w++) {
> +        FeatureWordInfo *fi = &feature_word_info[w];
>           uint64_t host_feat =
>               x86_cpu_get_supported_feature_word(w, false);
>           uint64_t requested_features = env->features[w];
>           uint64_t unavailable_features = requested_features & ~host_feat;
> -        if (w == FEAT_PERF_CAPABILITIES &&
> -            (requested_features & PERF_CAP_LBR_FMT)) {
> -            if ((host_feat & PERF_CAP_LBR_FMT) !=
> -                (requested_features & PERF_CAP_LBR_FMT)) {
> -                unavailable_features |= PERF_CAP_LBR_FMT;
> -            }
> +        if (kvm_enabled()) {
> +            uint64_t mismatches = (requested_features ^ host_feat) &
> +                                  fi->kvm_exact_match_flags;
> +            mark_unavailable_features(cpu, w, mismatches, "feature doesn't match host");
>           }
>           mark_unavailable_features(cpu, w, unavailable_features, prefix);
>       }
>    
> ---------------------------

I may refine this part in this way:

     for (w = 0; w < FEATURE_WORDS; w++) {
         FeatureWordInfo *fi = &feature_word_info[w];
         uint64_t match_flags = fi->kvm_exact_match_flags;
         uint64_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
         uint64_t requested_features = env->features[w];
         uint64_t unavailable_features = requested_features & ~host_feat;
         if (kvm_enabled() && match_flags) {
             uint64_t mismatches = (requested_features & match_flags) &&
                 (requested_features ^ host_feat) & match_flags;
             mark_unavailable_features(cpu, w, mismatches, "feature doesn't 
match host");
             unavailable_features &= ~match_flags;
         }
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }

which helps to:
- make "-cpu host,pmu=true,lbr-fmt=0" just work as disable-lbr;
- save a little overhead to get mismatches for non-related FEATURE_WORDS;
- avoid to do mark_unavailable_features twice;

> 
>>           mark_unavailable_features(cpu, w, unavailable_features, prefix);
>>       }
>>   
>> @@ -6533,6 +6540,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>>           }
>>       }
>>   
>> +    if (cpu->lbr_fmt) {
>> +        if (!cpu->enable_pmu) {
>> +            error_setg(errp, "LBR is unsupported since guest PMU is disabled.");
>> +            return;
>> +        }
> 
> This is not wrong, but looks like an obstacle for making the
> feature migratable and needs to be addressed as a follow up if
> you want live migration support.  CPUID[0xA] is exposing host
> CPUID directly if enable_pmu is enabled.

It's true. I have noticed the issue as well and
will follow up to make pmu-enabled guest migratable.

> 
> Also, I don't understand why PDCM is being silently disabled at
> cpu_x86_cpuid() if enable_pmu is not set.  Isn't it valid to set
> PDCM=1 without CPUID[0xA]?

It's invalid to set PDCM=1 w/o CPUID[0xA] since all features
on the PERF_CAPABILITIES are dependent on the enabled guest pmu
(which provides basic event counters to make LBR work).

Thanks,
Like Xu

> 
> 
>> +        env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
>> +    }
>> +
>>       /* mwait extended info: needed for Core compatibility */
>>       /* We always wake on interrupt even if host does not have the capability */
>>       cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
>> @@ -7157,6 +7172,7 @@ static Property x86_cpu_properties[] = {
>>   #endif
>>       DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
>>       DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
>> +    DEFINE_PROP_UINT8("lbr-fmt", X86CPU, lbr_fmt, 0),
>>   
>>       DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
>>                          HYPERV_SPINLOCK_NEVER_NOTIFY),
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index f519d2bfd4..c1cf8b7160 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -357,6 +357,7 @@ typedef enum X86Seg {
>>   #define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
>>   
>>   #define MSR_IA32_PERF_CAPABILITIES      0x345
>> +#define PERF_CAP_LBR_FMT      0x3f
>>   
>>   #define MSR_IA32_TSX_CTRL		0x122
>>   #define MSR_IA32_TSCDEADLINE            0x6e0
>> @@ -1701,6 +1702,15 @@ struct X86CPU {
>>        */
>>       bool enable_pmu;
>>   
>> +    /*
>> +     * Configure LBR_FMT bits on IA32_PERF_CAPABILITIES MSR.
>> +     * This can't be enabled by default yet because it doesn't have
>> +     * ABI stability guarantees, as it is only allowed to pass all
>> +     * LBR_FMT bits returned by kvm_arch_get_supported_msr_feature()
>> +     * (that depends on host CPU and kernel capabilities) to the guest.
>> +     */
>> +    uint8_t lbr_fmt;
>> +
>>       /* LMCE support can be enabled/disabled via cpu option 'lmce=on/off'. It is
>>        * disabled by default to avoid breaking migration between QEMU with
>>        * different LMCE configurations.
>> -- 
>> 2.21.3
>>
> 


