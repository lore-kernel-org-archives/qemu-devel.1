Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C21C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E029F20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E029F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKCA-0007Ns-Qu
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iCJoj-0003At-7l
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iCJoh-0001ww-E7
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:35:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:24355)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iCJoh-0001un-5q
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:35:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Sep 2019 01:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; d="scan'208";a="388411360"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.214])
 ([10.239.196.214])
 by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2019 01:35:23 -0700
Subject: Re: [PATCH v3 2/2] target/i386: drop the duplicated definition of
 cpuid AVX512_VBMI marco
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190923063041.12420-1-tao3.xu@intel.com>
 <20190923063041.12420-3-tao3.xu@intel.com>
 <20190923080816.hzfzikw5mx4n3ejn@steredhat>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <b525b663-4a90-58b1-90e3-6c0b5b22e7d1@intel.com>
Date: Mon, 23 Sep 2019 16:35:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190923080816.hzfzikw5mx4n3ejn@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/2019 4:08 PM, Stefano Garzarella wrote:
> On Mon, Sep 23, 2019 at 02:30:41PM +0800, Tao Xu wrote:
>> Drop the duplicated definition of cpuid AVX512_VBMI marco and rename it
>> as CPUID_7_0_ECX_AVX512_VBMI.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>   target/i386/cpu.c           | 4 ++--
>>   target/i386/cpu.h           | 3 +--
>>   target/i386/hvf/x86_cpuid.c | 2 +-
>>   3 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 9e0bac31e8..f87fe88259 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2412,7 +2412,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
>>               CPUID_7_0_EBX_SMAP,
>>           .features[FEAT_7_0_ECX] =
>> -            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
>> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
>>               CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
>>               CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
>>               CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
>> @@ -2470,7 +2470,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>>               CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
>>           .features[FEAT_7_0_ECX] =
>> -            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
>> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
>>               CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
>>               CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
>>               CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index fa4c4cad79..61f6287294 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -695,8 +695,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>>   #define CPUID_7_0_EBX_AVX512VL          (1U << 31)
>>   
>>   /* AVX-512 Vector Byte Manipulation Instruction */
>> -#define CPUID_7_0_ECX_AVX512BMI         (1U << 1)
>> -#define CPUID_7_0_ECX_VBMI              (1U << 1)
>> +#define CPUID_7_0_ECX_AVX512_VBMI       (1U << 1)
> 
> Since we're here, should we also update CPUID_7_0_ECX_VBMI2?
> 
> Thanks,
> Stefano
> 
Thank you for reminding me. I check the vmbi2's flag is 'avx512_vbmi2'. 
And linux kernel source and SDM also use AVX512_VBMI2. I will update this.

