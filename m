Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE442C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 02:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A3220753
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 02:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A3220753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGDIv-0003Rr-Q4
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 22:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1jGDIF-0002zY-1u
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 22:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1jGDID-0007bd-SP
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 22:58:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:20239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1jGDID-0007b8-Ks
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 22:58:21 -0400
IronPort-SDR: SDe/YOf4YbqAYPmyFNpc8AKvIQQZmkSrY9Hj7en4988v10pKrO0HzkUDNC41I8X8pUrGfzTsLJ
 tq3jze5cjjTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 19:58:19 -0700
IronPort-SDR: hwH172pVtuk9wuD+IqdvNGtgGntADR8FOzh/bPS0vGbSlFLGngLKkNPOtt9NO2FoDlzcISa4gw
 8JLmFIOSRvUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,294,1580803200"; d="scan'208";a="392767861"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.169.56])
 ([10.249.169.56])
 by orsmga004.jf.intel.com with ESMTP; 22 Mar 2020 19:58:16 -0700
Subject: Re: [PATCH v2] target/i386: Add ARCH_CAPABILITIES related bits into
 Icelake-Server CPU model
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200316095605.12318-1-xiaoyao.li@intel.com>
 <38253eb8-059c-5020-50cd-e90f7e8e4ae5@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <8324d641-4a1d-cf64-5da5-9410eddc983c@intel.com>
Date: Mon, 23 Mar 2020 10:58:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <38253eb8-059c-5020-50cd-e90f7e8e4ae5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.115
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
Cc: Tao Xu <tao3.xu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/2020 10:32 AM, Tao Xu wrote:
> Hi Xiaoyao,
> 
> May be you can add .note for this new version.
> 
> for example:
> 
> +                .version = 3,
> +                .note = "ARCH_CAPABILITIES",
> +                .props = (PropValue[]) {

Hi Paolo and Eduardo,

Need I spin a new version to add the .note ?
Maybe you can add it when queue?

Thanks,
-Xiaoyao

> On 3/16/2020 5:56 PM, Xiaoyao Li wrote:
>> Current Icelake-Server CPU model lacks all the features enumerated by
>> MSR_IA32_ARCH_CAPABILITIES.
>>
>> Add them, so that guest of "Icelake-Server" can see all of them.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> v2:
>>   - Add it as a new version.
>> ---
>>   target/i386/cpu.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 92fafa265914..5fba6a2ad6b3 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -3496,6 +3496,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>                       { /* end of list */ }
>>                   },
>>               },
>> +            {
>> +                .version = 3,
>> +                .props = (PropValue[]) {
>> +                    { "arch-capabilities", "on" },
>> +                    { "rdctl-no", "on" },
>> +                    { "ibrs-all", "on" },
>> +                    { "skip-l1dfl-vmentry", "on" },
>> +                    { "mds-no", "on" },
>> +                    { "pschange-mc-no", "on" },
>> +                    { "taa-no", "on" },
>> +                    { /* end of list */ }
>> +                },
>> +            },
>>               { /* end of list */ }
>>           }
>>       },
>> -- 
>> 2.20.1
>>
>>


