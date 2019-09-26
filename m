Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74EAC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 01:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7665621655
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 01:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7665621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDIOy-0004HJ-Cx
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 21:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iDINQ-0002tz-QQ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 21:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iDINO-0001WN-LW
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 21:15:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:31121)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iDINO-0001RD-C8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 21:15:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 18:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,549,1559545200"; d="scan'208";a="189847069"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.173])
 ([10.239.196.173])
 by fmsmga007.fm.intel.com with ESMTP; 25 Sep 2019 18:15:12 -0700
Subject: Re: [PATCH v4 2/2] target/i386: drop the duplicated definition of
 cpuid AVX512_VBMI marco
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190924010209.27149-1-tao3.xu@intel.com>
 <20190924010209.27149-3-tao3.xu@intel.com>
 <20190925084228.sew5mtwdlwmwe4ju@steredhat>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <55a00364-4640-0d02-2b7e-ed7ab61f60c4@intel.com>
Date: Thu, 26 Sep 2019 09:15:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190925084228.sew5mtwdlwmwe4ju@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/2019 4:42 PM, Stefano Garzarella wrote:
> Hi Tao,
> 
> Typo in the commit title and message? s/marco/macro?
> 
> On Tue, Sep 24, 2019 at 09:02:09AM +0800, Tao Xu wrote:
>> Drop the duplicated definition of cpuid AVX512_VBMI and marco and
> I'm not native speaker but I'd remove some 'and'      ^ this
> 
>> rename it as CPUID_7_0_ECX_AVX512_VBMI. And rename CPUID_7_0_ECX_VBMI2
>                                            ^ this
> 
Oh, my mistake, I will correct these. Thank you for reminding me.
>> as CPUID_7_0_ECX_AVX512_VBMI2.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>   target/i386/cpu.c           | 8 ++++----
>>   target/i386/cpu.h           | 5 ++---
>>   target/i386/hvf/x86_cpuid.c | 2 +-
>>   3 files changed, 7 insertions(+), 8 deletions(-)
>>
> 
> The rest LGTM:
> 
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Thanks,
> Stefano
> 
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 9e0bac31e8..71034aeb5a 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2412,8 +2412,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
>>               CPUID_7_0_EBX_SMAP,
>>           .features[FEAT_7_0_ECX] =
>> -            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
>> -            CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
>> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
>> +            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
>>               CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
>>               CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
>>               CPUID_7_0_ECX_AVX512_VPOPCNTDQ,
>> @@ -2470,8 +2470,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>>               CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
>>           .features[FEAT_7_0_ECX] =
>> -            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
>> -            CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
>> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
>> +            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
>>               CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
>>               CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
>>               CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57,
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index fa4c4cad79..8e090acd74 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -695,8 +695,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>>   #define CPUID_7_0_EBX_AVX512VL          (1U << 31)
>>   
>>   /* AVX-512 Vector Byte Manipulation Instruction */
>> -#define CPUID_7_0_ECX_AVX512BMI         (1U << 1)
>> -#define CPUID_7_0_ECX_VBMI              (1U << 1)
>> +#define CPUID_7_0_ECX_AVX512_VBMI       (1U << 1)
>>   /* User-Mode Instruction Prevention */
>>   #define CPUID_7_0_ECX_UMIP              (1U << 2)
>>   /* Protection Keys for User-mode Pages */
>> @@ -704,7 +703,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>>   /* OS Enable Protection Keys */
>>   #define CPUID_7_0_ECX_OSPKE             (1U << 4)
>>   /* Additional AVX-512 Vector Byte Manipulation Instruction */
>> -#define CPUID_7_0_ECX_VBMI2             (1U << 6)
>> +#define CPUID_7_0_ECX_AVX512_VBMI2      (1U << 6)
>>   /* Galois Field New Instructions */
>>   #define CPUID_7_0_ECX_GFNI              (1U << 8)
>>   /* Vector AES Instructions */
>> diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
>> index 4d957fe896..16762b6eb4 100644
>> --- a/target/i386/hvf/x86_cpuid.c
>> +++ b/target/i386/hvf/x86_cpuid.c
>> @@ -89,7 +89,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>>                   ebx &= ~CPUID_7_0_EBX_INVPCID;
>>               }
>>   
>> -            ecx &= CPUID_7_0_ECX_AVX512BMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ;
>> +            ecx &= CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ;
>>               edx &= CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS;
>>           } else {
>>               ebx = 0;
>> -- 
>> 2.20.1
>>
> 


