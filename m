Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC8BC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 07:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E44921019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 07:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E44921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho0QM-0002hQ-8O
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 03:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56596)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1ho0QB-0002GJ-6T
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ho0Q9-0004ey-SN
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:01:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:55096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ho0Q9-0004dN-KP
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:01:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jul 2019 00:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,276,1559545200"; d="scan'208";a="343275642"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.101])
 ([10.239.196.101])
 by orsmga005.jf.intel.com with ESMTP; 18 Jul 2019 00:01:36 -0700
To: Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20190717045731.19303-1-tao3.xu@intel.com>
 <54351c2d-0b8a-6877-6fda-dedec8372d00@intel.com>
 <20190717183819.GW26800@habkost.net>
 <c12d950d-87a8-2b7f-266e-e4031f779015@intel.com>
 <26970152-60d1-f334-2359-9b5b87105565@intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <477c52fc-a343-b3e0-b845-5bef1f7fcc77@intel.com>
Date: Thu, 18 Jul 2019 15:01:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <26970152-60d1-f334-2359-9b5b87105565@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: Introduce Denverton CPU
 model
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
 Xiaoyao Li <xiaoyao.li@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/2019 2:16 PM, Xiaoyao Li wrote:
> On 7/18/2019 9:56 AM, Tao Xu wrote:
>> On 7/18/2019 2:38 AM, Eduardo Habkost wrote:
>>> On Wed, Jul 17, 2019 at 01:39:01PM +0800, Tao Xu wrote:
>>>> Hi Eduardo,
>>>>
>>>> Could I ask a question about introducing a old CPU model? Maybe not 
>>>> so old
>>>> because it was launched in 2017. It is the former generation (Atom 
>>>> Server)
>>>> of Snowridge and if this cpu model be added, qemu may can migrate guest
>>>> between Denverton CPU and Snowridge CPU.
>>>>
>>>> I am wondering which way is more appropriate, because maybe there 
>>>> are a few
>>>> Denverton machines using old microcodes:
>>>>
>>>> 1. Just like this patch, introduce one version cpu cpu model.
>>>>
>>>> 2. Introduce multi versions of cpu model, cover old microcodes, may 
>>>> be 3
>>>> versions.
>>>
>>> What exactly are the differences between the old and new
>>> microcodes?  Is it always possible to install a new microcode on
>>> machines that are not up to date?
>>>
>> Denverton Machines with old microcodes didn't have 
>> CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD on host. But 
>> user can update their machine follow the links below:
>>
>> SSBD:
>> https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00115.html 
>>
>> https://access.redhat.com/articles/3436091
>>
>> SPEC_CTRL:
>> https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00088.html 
>>
>> https://access.redhat.com/articles/3436091
>>
>>
>>> Both options look good to me.  I think it's OK to just declare
>>> old microcode versions as not supported by QEMU, but I won't
>>> complain if you decide to add multiple versions.
>>>
>> Thank you Eduardo, I prefer option 1, just this patch. I think because 
>> Denverton CPU model will not have compatibility issue and the machines 
>> with old microcode are very few.
> 
> Hi Tao,
> 
> This patch also define CPUID_7_0_EDX_ARCH_CAPABILITIES in 
> features[FEAT_7_0_EDX], but there is no feature defined with 
> .feature[FEAT_ARCH_CAPABILITIES] in this cpu model.
> Do you miss some features enumerated by MSR_IA32_ARCH_CAPABILITIES in 
> this cpu model? Otherwise it can just remove 
> CPUID_7_0_EDX_ARCH_CAPABILITIES.
> 

OK, When I RDMSR 0x10a in a Denverton machine with latest microcode, I 
get 9. So I plan to add "rdctl-no" and "skip-l1dfl-vmentry" in next version.
>>>>
>>>> On 7/17/2019 12:57 PM, Tao Xu wrote:
>>>>> Denverton is the Atom Processor of Intel Harrisonville platform.
>>>>> +        .features[FEAT_7_0_EDX] =
>>>>> +            CPUID_7_0_EDX_SPEC_CTRL | 
>>>>> CPUID_7_0_EDX_ARCH_CAPABILITIES |
>>>>> +            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
>>>>> +        /*
>>>>> +         * Missing: XSAVES (not supported by some Linux versions,
>>>>> +         * including v4.1 to v4.12).
>>>>> +         * KVM doesn't yet expose any XSAVES state save component,
>>>>> +         * and the only one defined in Skylake (processor tracing)
>>>>> +         * probably will block migration anyway.
>>>>> +         */
>>>>> +        .features[FEAT_XSAVE] =
>>>>> +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC | 
>>>>> CPUID_XSAVE_XGETBV1,
>>>>> +        .features[FEAT_6_EAX] =
>>>>> +            CPUID_6_EAX_ARAT,
>>>>> +        .xlevel = 0x80000008,
>>>>> +        .model_id = "Intel Atom Processor (Denverton)",
>>>>> +    },
>>>>>        {
>>>>>            .name = "SnowRidge-Server",
>>>>>            .level = 27,
>>>>> -- 
>>>>> 2.20.1
>>>>>
>>>>>
>>>>
>>>
>>
>>


