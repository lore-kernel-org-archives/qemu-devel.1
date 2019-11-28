Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E1C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F322154A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F322154A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaBl0-0005yx-0m
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 23:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iaBkL-0005Zo-1V
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iaBkJ-0002pc-42
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:49:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:48872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iaBkI-0002kf-SE
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:49:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 20:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,252,1571727600"; d="scan'208";a="234324242"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.13])
 ([10.239.197.13])
 by fmsmga004.fm.intel.com with ESMTP; 27 Nov 2019 20:49:30 -0800
Subject: Re: [PATCH v18 3/8] numa: Extend CLI to provide memory side cache
 information
From: Tao Xu <tao3.xu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20191127082613.22903-1-tao3.xu@intel.com>
 <20191127082613.22903-4-tao3.xu@intel.com>
 <871rttfxsc.fsf@dusky.pond.sub.org>
 <de826b02-34df-c3b4-2cf2-e6d813156f52@intel.com>
Message-ID: <1198abe5-0e81-dd9b-1a74-21ccaea60d19@intel.com>
Date: Thu, 28 Nov 2019 12:49:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <de826b02-34df-c3b4-2cf2-e6d813156f52@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "sw@weilnetz.de" <sw@weilnetz.de>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 Daniel Black <daniel@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/2019 10:46 AM, Tao Xu wrote:
> On 11/27/2019 5:56 PM, Markus Armbruster wrote:
>> Tao Xu <tao3.xu@intel.com> writes:
>>
>>> From: Liu Jingqi <jingqi.liu@intel.com>
>>>
>>> Add -numa hmat-cache option to provide Memory Side Cache Information.
>>> These memory attributes help to build Memory Side Cache Information
>>> Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).
>>
>> Please mention this requires -machine hmat=on.
> 
> OK I will add these for 3 related patches.
>>
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
>>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> [...]
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index c741649d7b..3d0ba226a9 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -428,10 +428,12 @@
>>>   #
>>>   # @hmat-lb: memory latency and bandwidth information (Since: 5.0)
>>>   #
>>> +# @hmat-cache: memory side cache information (Since: 5.0)
>>> +#
>>>   # Since: 2.1
>>>   ##
>>>   { 'enum': 'NumaOptionsType',
>>> -  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
>>> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
>>>   ##
>>>   # @NumaOptions:
>>> @@ -447,7 +449,8 @@
>>>       'node': 'NumaNodeOptions',
>>>       'dist': 'NumaDistOptions',
>>>       'cpu': 'NumaCpuOptions',
>>> -    'hmat-lb': 'NumaHmatLBOptions' }}
>>> +    'hmat-lb': 'NumaHmatLBOptions',
>>> +    'hmat-cache': 'NumaHmatCacheOptions' }}
>>>   ##
>>>   # @NumaNodeOptions:
>>> @@ -647,6 +650,77 @@
>>>       '*latency': 'uint64',
>>>       '*bandwidth': 'size' }}
>>> +##
>>> +# @HmatCacheAssociativity:
>>> +#
>>> +# Cache associativity in the Memory Side Cache
>>> +# Information Structure of HMAT
>>> +#
>>> +# For more information of @HmatCacheAssociativity see
>>> +# the chapter 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
>>
>>    # Cache associativity in the Memory Side Cache Information Structure
>>    # of HMAT
>>    #
>>    # For more information of @HmatCacheAssociativity, see chapter
>>    # 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
>>
>>> +#
>>> +# @none: None
>>
>> What does cache associativity @none mean?  A none-associative cache?  I
>> guess it makes sense to people familiar with the ACPI spec...
>>
> 
> This means this proximity domain has no memory cache, thus none for 
> Cache associativity, I will add more description about this.

Read again about ACPI spec, there is no description about 'none'. In
linux kernel HMAT code, this is handle as "other", maybe means not 
provided. I will also add a check when level is none, the associativity, 
policy and line_size should be none or 0.

