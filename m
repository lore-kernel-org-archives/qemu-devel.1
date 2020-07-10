Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EAEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 01:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4330E20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 01:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4330E20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jti7T-0006Vg-Jn
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 21:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jti6x-00066M-Bn
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 21:45:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:7353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jti6u-00065k-P7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 21:45:58 -0400
IronPort-SDR: r9D2wm6VWhAnTIb5r+4qlYKU8UnS1tlDNjpsxBbf6WHrCJiwLMwVb40svWBSECy8B2Z2IJk+mc
 2cvY72fK1/6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="147226706"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; d="scan'208";a="147226706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 18:45:52 -0700
IronPort-SDR: jUynXOGmi99VsdlT7dPH7IyX02daP5nNiaariiem2KPvnyAKyROisWAjWKzOFWlud5Guv5GgF6
 Ebj9ip+9RLDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; d="scan'208";a="389324311"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.238.2.93])
 ([10.238.2.93])
 by fmsmga001.fm.intel.com with ESMTP; 09 Jul 2020 18:45:50 -0700
Subject: Re: [PATCH v5 1/4] target/i386: add missing vmx features for several
 CPU models
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200619073114.24303-1-chenyi.qiang@intel.com>
 <20200619073114.24303-2-chenyi.qiang@intel.com>
 <20200709221226.GM780932@habkost.net>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Message-ID: <d3542ac6-9282-ed88-3819-3cc8b3368ee7@intel.com>
Date: Fri, 10 Jul 2020 09:45:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709221226.GM780932@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=chenyi.qiang@intel.com; helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 21:45:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/10/2020 6:12 AM, Eduardo Habkost wrote:
> 
> I'm very sorry for taking so long to review this.  Question
> below:
> 
> On Fri, Jun 19, 2020 at 03:31:11PM +0800, Chenyi Qiang wrote:
>> Add some missing VMX features in Skylake-Server, Cascadelake-Server and
>> Icelake-Server CPU models based on the output of Paolo's script.
>>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> Why are you changing the v1 definition instead adding those new
> features in a new version of the CPU model, just like you did in
> patch 3/4?
> 

I suppose these missing vmx features are not quite necessary for 
customers. Just post it here to see if they are worth being added.
Adding a new version is reasonable. Is it appropriate to put all the 
missing features in patch 1/4, 3/4, 4/4 in a same version?

>> ---
>>   target/i386/cpu.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index b1b311baa2..0b309ef3ab 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -3002,6 +3002,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>                VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
>>                VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
>>                VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
>> +        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
>>           .xlevel = 0x80000008,
>>           .model_id = "Intel Xeon Processor (Skylake)",
>>           .versions = (X86CPUVersionDefinition[]) {
>> @@ -3130,6 +3131,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>                VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
>>                VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
>>                VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
>> +        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
>>           .xlevel = 0x80000008,
>>           .model_id = "Intel Xeon Processor (Cascadelake)",
>>           .versions = (X86CPUVersionDefinition[]) {
>> @@ -3477,7 +3479,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>                VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
>>                VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
>>                VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
>> -             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
>> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
>> +             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
>> +        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
>>           .xlevel = 0x80000008,
>>           .model_id = "Intel Xeon Processor (Icelake)",
>>           .versions = (X86CPUVersionDefinition[]) {
>> -- 
>> 2.17.1
>>
>>
> 

