Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EA0206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EA0206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAlPu-0007eM-A6
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 22:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1kAlPJ-0006oU-CE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 22:43:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:32684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1kAlPG-0003Do-FT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 22:43:24 -0400
IronPort-SDR: gmBPM/oSwPcz3wgP1I3/GOHBGph05eLrP9isOzpR8szvave1TduIWutsmPUeaTcJKo/ZKKO02i
 CVuvyyQj7YpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="143889320"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; d="scan'208";a="143889320"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 19:43:18 -0700
IronPort-SDR: yz0WD4t8sQ1JBpezTRpKP/rBpiMwuO0pyDi8xzpJt605NUI//N7XOEYfy7jslFBFdt4xOq3qhP
 /yoYk5eDjPQA==
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; d="scan'208";a="474599333"
Received: from kblgvt-desktop.sh.intel.com (HELO [10.239.13.113])
 ([10.239.13.113])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 19:43:17 -0700
Subject: Re: [PATCH 2/2] target/i386: Add missed features to Cooperlake CPU
 model
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191225063018.20038-1-xiaoyao.li@intel.com>
 <20191225063018.20038-3-xiaoyao.li@intel.com>
 <20200824220759.GS642093@habkost.net>
 <9cdaaa8d-4ce2-88c7-2400-eed62ffe779b@intel.com>
 <20200825140145.GU642093@habkost.net>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <3644bc2e-feaa-94cb-7c57-701539894384@intel.com>
Date: Wed, 26 Aug 2020 10:43:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825140145.GU642093@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 22:43:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Cathy Zhang <cathy.zhang@intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/2020 10:01 PM, Eduardo Habkost wrote:
> On Tue, Aug 25, 2020 at 08:20:35AM +0800, Xiaoyao Li wrote:
>> On 8/25/2020 6:07 AM, Eduardo Habkost wrote:
>>> On Wed, Dec 25, 2019 at 02:30:18PM +0800, Xiaoyao Li wrote:
>>>> It lacks VMX features and two security feature bits (disclosed recently) in
>>>> MSR_IA32_ARCH_CAPABILITIES in current Cooperlake CPU model, so add them.
>>>>
>>>> Fixes: 22a866b6166d ("i386: Add new CPU model Cooperlake")
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> ---
>>>>    target/i386/cpu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 50 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index e1eb9f473989..c9798ac8652b 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -3198,7 +3198,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>>>                CPUID_7_0_EDX_SPEC_CTRL_SSBD | CPUID_7_0_EDX_ARCH_CAPABILITIES,
>>>>            .features[FEAT_ARCH_CAPABILITIES] =
>>>>                MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
>>>> -            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO,
>>>> +            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
>>>> +            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO,
>>>
>>> This seems to break on some Cooperlake hosts, see:
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1860743
>>>
>>> Are all Cooperlake hosts supposed to have TAA_NO set?  Are there
>>> hosts where this requires a microcode update to be installed?
>>>
>>
>> All the production CPX in market should have IAA_NO bit. We can check it
>> directly with rdmsr(0x10a).
>>
>> The problem of this issue is due to commit db616173d787 ("x86/tsx: Add
>> config options to set tsx=on|off|auto"), which sets the default to "off" for
>> 100% safety. However, default to off may cause noticeable regressions on TSX
>> safe platform, e.g., CPX.
>>
>> Maybe we need to set CONFIG_X86_INTEL_TSX_MODE_AUTO=y for OSV released
>> kernel?
> 
> Considering that disabling TSX is a policy decision likely to be
> taken by the OS vendor or by the system administrator, we could
> at least make the CPU model easier to use on those cases.
> 
> Maybe we should provide a version of Cooperlake without TSX, like
> we already do for the other CPU models?
> 

sure we can do it.

