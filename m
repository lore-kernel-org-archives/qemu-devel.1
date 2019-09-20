Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C7EC3A5A6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B1C206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B1C206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB7Ef-0006gY-QF
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 20:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iB7DK-0005he-J9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iB7DI-00046h-Cm
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:55:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:22655)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iB7DI-00045S-56
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:55:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 17:55:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,526,1559545200"; d="scan'208";a="199580480"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.107])
 ([10.239.196.107])
 by orsmga002.jf.intel.com with ESMTP; 19 Sep 2019 17:55:49 -0700
Subject: Re: [Qemu-devel] [PATCH] target/i386: Correct extra enter and spaces
 in comment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190919020629.26530-1-tao3.xu@intel.com>
 <03994df5-69b7-8663-fc19-0f551a9b29d6@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <327cd301-f98c-c097-47aa-b85a70c4490d@intel.com>
Date: Fri, 20 Sep 2019 08:55:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <03994df5-69b7-8663-fc19-0f551a9b29d6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/2019 5:41 PM, Philippe Mathieu-Daudé wrote:
> Hi Tao,
> 
> On 9/19/19 4:06 AM, Tao Xu wrote:
>> There is an extra line in comment of CPUID_8000_0008_EBX_WBNOINVD,
>> remove the extra enter and spaces.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>   target/i386/cpu.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 5f6e3a029a..71b6193390 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -695,8 +695,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>>   
>>   #define CPUID_7_1_EAX_AVX512_BF16 (1U << 5) /* AVX512 BFloat16 Instruction */
>>   
>> -#define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
>> -                                                                             do not invalidate cache */
>> +#define CPUID_8000_0008_EBX_WBNOINVD (1U << 9) /* Write back and do not invalidate cache */
> 
> The QEMU CODING_STYLE [*] recommend a 80 chars per line limit:
> 
> Line width
> ==========
> 
> Lines should be 80 characters; try not to make them longer.
> 
> Sometimes it is hard to do, especially when dealing with QEMU subsystems
> that use long function or symbol names.  Even in that case, do not make
> lines much longer than 80 characters.
> 
> Rationale:
> 
> * Some people like to tile their 24" screens with a 6x4 matrix of 80x24
>    xterms and use vi in all of them.  The best way to punish them is to
>    let them keep doing it.
> * Code and especially patches is much more readable if limited to a sane
>    line length.  Eighty is traditional.
> * The four-space indentation makes the most common excuse ("But look
>    at all that white space on the left!") moot.
> * It is the QEMU coding style.
> 
> [*]
> https://git.qemu.org/?p=qemu.git;a=blob;f=CODING_STYLE.rst;h=427699e0e425431ea99d4046e40543bdcc22e9c5;hb=HEAD#l82
> 
> Can you repost using correct lenght comments?

Yes, But it is hard to do and in this header file there are lots of 
lines over 80 chars even 90 chars. So how about I correct all the lines 
over 80 like this:

/* Write back and do not invalidate cache */
#define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)
/* Indirect Branch Prediction Barrier */
#define CPUID_8000_0008_EBX_IBPB    (1U << 12)

> 
>>   #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
>>   
>>   #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
>>


