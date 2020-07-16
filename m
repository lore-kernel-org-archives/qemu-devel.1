Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F4C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6612063A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6612063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5jP-0003CB-NE
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jw5iD-0001s0-SB
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:22:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:54257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jw5iB-0001ye-Aw
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:22:17 -0400
IronPort-SDR: Lgm7XXylDLN3InUWq9hWkdnnvOSE/sKp19xtjEQM5gspb8AwlqY82oB5c489sPjyGLoP/R6KSl
 emPP1zaNtmTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="136856668"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; d="scan'208";a="136856668"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2020 08:22:10 -0700
IronPort-SDR: ouHVyTD4JWTg8nmr7Rt7TwJ8g9kmO/te4IIv2ScFfDR/+v0620ogo2Cir5u1LJ5zUk8BIC08G8
 LyczA4JksYpQ==
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; d="scan'208";a="460508938"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.31.173])
 ([10.255.31.173])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2020 08:22:09 -0700
Subject: Re: [PATCH 1/2] i386/cpu: Clear FEAT_XSAVE_COMP_{LO, HI} when XSAVE is
 not available
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200716082019.215316-1-xiaoyao.li@intel.com>
 <20200716082019.215316-2-xiaoyao.li@intel.com>
 <20200716151554.GL1274972@habkost.net>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <adeb9bc9-ccbd-9752-4052-bdf08ceebb49@intel.com>
Date: Thu, 16 Jul 2020 23:22:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716151554.GL1274972@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 11:22:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/2020 11:15 PM, Eduardo Habkost wrote:
> On Thu, Jul 16, 2020 at 04:20:18PM +0800, Xiaoyao Li wrote:
>> Per Intel SDM vol 1, 13.2, if CPUID.1:ECX.XSAVE[bit 26] is 0, the
>> processor provides no further enumeration through CPUID function 0DH.
> 
> Can you explain what's the bug you are trying to fix?
> env->features[FEAT_XSAVE_COMP_*] is already initialized as zero.

When "-cpu host", it's not zero I think.

> 
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/cpu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 1e5123251d74..f5f11603e805 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6261,6 +6261,8 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>>       uint64_t mask;
>>   
>>       if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
>> +        env->features[FEAT_XSAVE_COMP_LO] = 0;
>> +        env->features[FEAT_XSAVE_COMP_HI] = 0;
>>           return;
>>       }
>>   
>> -- 
>> 2.18.4
>>
> 


