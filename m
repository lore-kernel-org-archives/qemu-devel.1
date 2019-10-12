Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78ECC47404
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 01:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BED420679
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 01:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BED420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ61W-0003OG-Nf
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 21:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1iJ60r-0002yo-K8
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 21:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1iJ60p-0005xy-T9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 21:16:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:58914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1iJ60p-0005oq-LI
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 21:16:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Oct 2019 18:15:59 -0700
X-IronPort-AV: E=Sophos;i="5.67,286,1566889200"; d="scan'208";a="184940266"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.123])
 ([10.239.13.123])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 11 Oct 2019 18:15:58 -0700
Subject: Re: [PATCH v2] target/i386: Add Snowridge-v2 (noMPX) CPU model
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191011145349.123425-1-xiaoyao.li@intel.com>
 <20191011182143.GD4084@habkost.net>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <e89e2380-8d3c-621f-6534-9ec783405b11@intel.com>
Date: Sat, 12 Oct 2019 09:15:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011182143.GD4084@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/2019 2:21 AM, Eduardo Habkost wrote:
> On Fri, Oct 11, 2019 at 10:53:49PM +0800, Xiaoyao Li wrote:
>> Add new version of Snowridge CPU model that removes MPX feature.
>>
>> MPX support is being phased out by Intel. GCC has dropped it, Linux kernel
>> and kvm are also going to do that in the future.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v2:
>>      - Use CPU model versioning mechanism instead of machine-type compat
>> ---
>>   target/i386/cpu.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 44f1bbdcac76..27b0a17b46a8 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2793,6 +2793,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               CPUID_6_EAX_ARAT,
>>           .xlevel = 0x80000008,
>>           .model_id = "Intel Atom Processor (SnowRidge)",
>> +        .versions = (X86CPUVersionDefinition[]) {
>> +            { .version = 1 },
>> +            {
>> +                .version = 2,
>> +                .alias = "Snowridge-noMPX",
> 
> The intention is to stop creating new funny names for CPU model
> variations, now, and stick to -v1, -v2, -v3, etc.
> 
> The .alias field is optional, and was added only for
> compatibility with the existing -noTSX and -IBRS CPU models.

Got it.

>> +                .props = (PropValue[]) {
>> +                    { "mpx", "off" },
>> +                    { "model-id", "Intel Atom Processor (Snowridge, no MPX)" },
> 
> Do you think it's important to report a different model-id?
> I would keep it the same and only add mpx=off.

I just want to let user know easily the differences between Snowridge-v1 
and Snowridge-v2. Unfortunately, it seems ugly.

When testing with Cascadelake-Server, it puzzles every time that which 
one should I choose between Cascadelake-Server-v1 and 
Cascadelake-Server-v2. From the output of "-cpu ?", I don't know the 
differences between them. Everytime I have to go to the source code to 
see the difference.

Maybe there is a way to see/report the differences between different 
versions of the same CPU model that I just don't know?

>> +                    { /* end of list */ },
>> +                },
>> +            },
>> +            { /* end of list */ },
>> +        },
>>       },
>>       {
>>           .name = "KnightsMill",
>> -- 
>> 2.19.1
>>
> 

