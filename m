Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432DDC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C04A2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C04A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAMmZ-0002Bq-7r
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 20:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1kAMhj-0002VH-IV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 20:20:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:38951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1kAMhg-0006VY-Fb
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 20:20:46 -0400
IronPort-SDR: 7OCV7ttYnJ0ZF/Fo1xy3BQ/t5HFaCdu5UfBqeb9YpUzTkOsqgk+GeM0r5Vs7jsdCPYUUtWMkAH
 O6vEk8Q855Ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="156004880"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; d="scan'208";a="156004880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2020 17:20:39 -0700
IronPort-SDR: 7AaJtVBCdXvxN2V09PpWCIOn/PjxcKjhiHfr6lNdMOj3FPp4f/zQBbi+Flxkn9LaBW/hQZjywQ
 8kcGc/RuDbUg==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; d="scan'208";a="474133045"
Received: from jliu69-mobl.ccr.corp.intel.com (HELO [10.255.31.15])
 ([10.255.31.15])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2020 17:20:37 -0700
Subject: Re: [PATCH 2/2] target/i386: Add missed features to Cooperlake CPU
 model
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191225063018.20038-1-xiaoyao.li@intel.com>
 <20191225063018.20038-3-xiaoyao.li@intel.com>
 <20200824220759.GS642093@habkost.net>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <9cdaaa8d-4ce2-88c7-2400-eed62ffe779b@intel.com>
Date: Tue, 25 Aug 2020 08:20:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824220759.GS642093@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 20:20:39
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -81
X-Spam_score: -8.2
X-Spam_bar: --------
X-Spam_report: (-8.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_HI=-5,
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

On 8/25/2020 6:07 AM, Eduardo Habkost wrote:
> On Wed, Dec 25, 2019 at 02:30:18PM +0800, Xiaoyao Li wrote:
>> It lacks VMX features and two security feature bits (disclosed recently) in
>> MSR_IA32_ARCH_CAPABILITIES in current Cooperlake CPU model, so add them.
>>
>> Fixes: 22a866b6166d ("i386: Add new CPU model Cooperlake")
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/cpu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index e1eb9f473989..c9798ac8652b 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -3198,7 +3198,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               CPUID_7_0_EDX_SPEC_CTRL_SSBD | CPUID_7_0_EDX_ARCH_CAPABILITIES,
>>           .features[FEAT_ARCH_CAPABILITIES] =
>>               MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
>> -            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO,
>> +            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
>> +            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO,
> 
> This seems to break on some Cooperlake hosts, see:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1860743
> 
> Are all Cooperlake hosts supposed to have TAA_NO set?  Are there
> hosts where this requires a microcode update to be installed?
> 

All the production CPX in market should have IAA_NO bit. We can check it 
directly with rdmsr(0x10a).

The problem of this issue is due to commit db616173d787 ("x86/tsx: Add 
config options to set tsx=on|off|auto"), which sets the default to "off" 
for 100% safety. However, default to off may cause noticeable 
regressions on TSX safe platform, e.g., CPX.

Maybe we need to set CONFIG_X86_INTEL_TSX_MODE_AUTO=y for OSV released 
kernel?



