Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA92C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED0920715
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED0920715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXaxQ-0000OF-Ci
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 20:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iXawn-0008OP-WB
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iXawm-0001rh-6B
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:07:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:25813)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iXawl-0001q2-LR
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:07:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Nov 2019 17:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; d="scan'208";a="357631513"
Received: from unknown (HELO [10.239.197.13]) ([10.239.197.13])
 by orsmga004.jf.intel.com with ESMTP; 20 Nov 2019 17:07:41 -0800
Subject: Re: [PATCH v16 08/14] numa: Extend CLI to provide memory latency and
 bandwidth information
To: Igor Mammedov <imammedo@redhat.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
 <20191115075352.17734-9-tao3.xu@intel.com>
 <20191119120302.6ff9e61e@redhat.com>
 <f82a9d01-e9cb-902e-34bd-c81fab380995@intel.com>
 <20191120135612.58f3bd01@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <aa817879-cccd-7fbd-4d05-22e1ecd3b8ef@intel.com>
Date: Thu, 21 Nov 2019 09:07:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191120135612.58f3bd01@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
 "Liu, Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/2019 8:56 PM, Igor Mammedov wrote:
> On Wed, 20 Nov 2019 15:55:04 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> On 11/19/2019 7:03 PM, Igor Mammedov wrote:
>>> On Fri, 15 Nov 2019 15:53:46 +0800
>>> Tao Xu <tao3.xu@intel.com> wrote:
>>>    
>>>> From: Liu Jingqi <jingqi.liu@intel.com>
>>>>
>>>> Add -numa hmat-lb option to provide System Locality Latency and
>>>> Bandwidth Information. These memory attributes help to build
>>>> System Locality Latency and Bandwidth Information Structure(s)
>>>> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>>>>
>>>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>>
>>> looks good to me, so
>>>
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>>
>>>
>>> PS:
>>> also see question below
>>>    
>> [...]
>>>> +
>>>> +        hmat_lb->range_bitmap |= node->bandwidth;
>>>> +        first_bit = ctz64(hmat_lb->range_bitmap);
>>>> +        hmat_lb->base = UINT64_C(1) << first_bit;
>>>> +        max_entry = node->bandwidth / hmat_lb->base;
>>>> +        last_bit = 64 - clz64(hmat_lb->range_bitmap);
>>>> +
>>>> +        /*
>>>> +         * For bandwidth, first_bit record the base unit of bandwidth bits,
>>>> +         * last_bit record the last bit of the max bandwidth. The max compressed
>>>> +         * bandwidth should be less than 0xFFFF (UINT16_MAX)
>>>> +         */
>>>> +        if ((last_bit - first_bit) > UINT16_BITS || max_entry >= UINT16_MAX) {
>>>                                                          ^^^^^^^^^^^^^^^^^^^
>>> what bandwidth combination is going to trigger above condition?
>>>    
>> Only use (last_bit - first_bit) > UINT16_BITS, we can't trigger error if
>> the max compressed bandwidth is 0xFFFF. Because in that condition,
>> "last_bit - first_bit == UINT16_BITS". So I add "max_entry >=
>> UINT16_MAX" to catch 0xFFFF. For example:
>>
>> Combination 1 (Error):
>> bandwidth1   = ...0000 1111 1111 1111 1110 0000... (max_entry 32767)
>> range_bitmap = ...0000 1111 1111 1111 1110 0000... (range is 15 bits)
>> bandwidth2   = ...0000 1111 1111 1111 1111 0000... (max_entry 65535)
>> range_bitmap = ...0000 1111 1111 1111 1111 0000... (range is 16 bits)
>>
>> Combination 2 (Error):
>> bandwidth1   = ...0000 1111 1111 1111 1110 0000... (max_entry 32767)
>> range_bitmap = ...0000 1111 1111 1111 1110 0000... (range is 15 bits)
>> bandwidth2   = ...0001 1111 1111 1111 1110 0000... (max_entry 65535)
>> range_bitmap = ...0001 1111 1111 1111 1110 0000... (range is 16 bits)
>>
>> Combination 3 (OK, because bandwidth1 will be compressed to 65534):
>> bandwidth1   = ...0000 1111 1111 1111 1110 0000... (max_entry 32767)
>> range_bitmap = ...0000 1111 1111 1111 1110 0000... (range is 15 bits)
>> bandwidth2   = ...0000 0111 1111 1111 1111 0000... (max_entry 32767)
>> range_bitmap = ...0000 1111 1111 1111 1111 0000... (range is 16 bits)
>>
>> Combination 4 (Error):
>> bandwidth1   = ...0000 1111 1111 1111 1111 0000... (max_entry 65535)
>> range_bitmap = ...0000 1111 1111 1111 1111 0000... (range is 16 bits)
> 
> ok, I'd use in max/min possible values in bios-tables-test,
> to make sure that we are testing whole range and would be able
> to detect a error in case the valid ranges regressed (shrink)
> and x-fail tests I've asked for in QMP test should detect
> error other way around.
> 
OK I will add these tests.

