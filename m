Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32E5C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 02:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B165721951
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 02:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B165721951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpOXy-0007mw-SK
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 22:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59668)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jing2.liu@linux.intel.com>) id 1hpOXo-0007OW-N9
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 22:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1hpOXn-0000X1-MK
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 22:59:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:14588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1hpOXn-0000V4-Dg
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 22:59:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jul 2019 19:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,293,1559545200"; d="scan'208";a="174103525"
Received: from liujing-mobl.ccr.corp.intel.com (HELO [10.238.129.14])
 ([10.238.129.14])
 by orsmga006.jf.intel.com with ESMTP; 21 Jul 2019 19:59:14 -0700
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1562823509-13072-1-git-send-email-jing2.liu@linux.intel.com>
 <c572cdd2-d0f4-2e06-99f8-302b798a04dd@linux.intel.com>
 <0f9763fe-af69-e057-9fb1-00527e636fe4@redhat.com>
 <0ffa32db-3615-16e0-71bf-a8c552c2fcfb@linux.intel.com>
 <757b193f-90c6-0516-9372-74463ec4d117@redhat.com>
From: Jing Liu <jing2.liu@linux.intel.com>
Message-ID: <4e381ae0-78d5-afb6-9a4d-b58d0daa60ba@linux.intel.com>
Date: Mon, 22 Jul 2019 10:59:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <757b193f-90c6-0516-9372-74463ec4d117@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH v1] x86: Intel AVX512_BF16 feature enabling
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/19/2019 4:10 PM, Paolo Bonzini wrote:
> On 19/07/19 09:20, Jing Liu wrote:
>>> Then CPUID[7,0].EAX is set automatically to 0 or 1 depending on whether
>>> BF16 is enabled or not.
>>
>> Could I ask why don't we directly check BF16 enabling when
>> cpu_x86_cpuid(env, 7, 0, ...) during kvm_arch_init_vcpu ?
> 
> Because the code for setting CPUID is common for all accelerators (there
> are five supported: KVM, HAX, HVF, TCG, WHPX).
> 
>> What is the use of the two new properties? Are they used for users
>> setting parameters when boot up guest, and why we need users setting
>> func7 level?
> 
> For example to test guests with CPUID[7,0].EAX==1, even if the host does
> not have BF16.

Thanks. :)
> 
> 
>> @@ -5075,6 +5101,10 @@ static void x86_cpu_expand_features(X86CPU *cpu,
>> Error **errp)
>>           x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
>>           x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
>>
>> +       if ((env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_AVX512_BF16) &&
>> +            kvm_enabled()) {
> 
> No need to check KVM.  You could also do just
> x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX) and set
> cpu->min_level_func7 in x86_cpu_adjust_feat_level with something like
> 
>      if (eax == 7) {
>          x86_cpu_adjust_level(cpu, &env->cpu_min_level_func7,
>                               fi->cpuid.ecx);
>      }
> 

Got it. One question I'm wondering is, is it possible for users setting
an invalid property like level-func7=2? Do we need some protection?

>> @@ -5098,6 +5128,9 @@ static void x86_cpu_expand_features(X86CPU *cpu,
>> Error **errp)
>>       }
>>
>>       /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly
>> set */
>> +    if (env->cpuid_level_func7 == UINT32_MAX) {
>> +        env->cpuid_level_func7 = env->cpuid_min_level_func7;
>> +    }
> 
> Looks good.
> 
>>       if (env->cpuid_level == UINT32_MAX) {
>>           env->cpuid_level = env->cpuid_min_level;
>>       }
>> @@ -5869,9 +5902,11 @@ static Property x86_cpu_properties[] = {
>>       DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
>>       DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU,
>> host_phys_bits_limit, 0),
>>       DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
>> +    DEFINE_PROP_UINT32("level-func7", X86CPU, env.cpuid_level_func7,
>> UINT32_MAX),
> 
> Looks good.
> 
>>       DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
>>       DEFINE_PROP_UINT32("xlevel", X86CPU, env.cpuid_xlevel, UINT32_MAX),
>>       DEFINE_PROP_UINT32("xlevel2", X86CPU, env.cpuid_xlevel2, UINT32_MAX),
>> +    DEFINE_PROP_UINT32("min-level-func7", X86CPU,
>> env.cpuid_min_level_func7, 0),
> 
> No need for this property, just like there is no min-level property.
> 
Would remove it.

Thanks,
Jing



