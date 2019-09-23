Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F528C3A5A2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 01:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E71D206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 01:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E71D206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCDRY-0008IZ-6P
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 21:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iCDQj-0007qP-27
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 21:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iCDQh-0004xE-3L
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 21:46:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:20728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iCDQg-0004t4-NF
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 21:46:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Sep 2019 18:46:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,538,1559545200"; d="scan'208";a="192935113"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.214])
 ([10.239.196.214])
 by orsmga006.jf.intel.com with ESMTP; 22 Sep 2019 18:46:08 -0700
Subject: Re: [PATCH v2] target/i386: clean up comments over 80 chars per line
To: Eduardo Habkost <ehabkost@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20190920053136.945-1-tao3.xu@intel.com>
 <20190920183339.GD5035@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <8da2883f-048a-2bc1-1e61-2a6adbc307f9@intel.com>
Date: Mon, 23 Sep 2019 09:46:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920183339.GD5035@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/2019 2:33 AM, Eduardo Habkost wrote:
> On Fri, Sep 20, 2019 at 01:31:36PM +0800, Tao Xu wrote:
>> Drop the duplicate definition of CPUID_7_0_ECX_VBMI. And add some
>> comments, clean up comments over 80 chars per line.
>>
>> There is an extra line in comment of CPUID_8000_0008_EBX_WBNOINVD,
>> remove the extra enter and spaces.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
> [...]
>> -#define CPUID_7_0_ECX_AVX512BMI (1U << 1)
>> -#define CPUID_7_0_ECX_VBMI     (1U << 1)  /* AVX-512 Vector Byte Manipulation Instrs */
> [...]
>> +/* AVX-512 Vector Byte Manipulation Instruction */
>> +#define CPUID_7_0_ECX_VBMI              (1U << 1)
> 
> I'd prefer to have the macro name matching the feature name that
> is already in feature_word_info[[FEAT_7_0_ECX].feat_names
> ("avx512vbmi").  It's also more similar to the name used in Intel
> SDM (AVX512_VBMI).
Thank for your suggestion. I will split this patch into 2 patches and 
rename the macro.

> 
> 
> [...]
>> diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
>> index 4d957fe896..5041f48b8a 100644
>> --- a/target/i386/hvf/x86_cpuid.c
>> +++ b/target/i386/hvf/x86_cpuid.c
>> @@ -89,7 +89,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>>                   ebx &= ~CPUID_7_0_EBX_INVPCID;
>>               }
>>   
>> -            ecx &= CPUID_7_0_ECX_AVX512BMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ;
>> +            ecx &= CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ;
>>               edx &= CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS;
>>           } else {
>>               ebx = 0;
>> -- 
>> 2.20.1
>>
> 


