Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B681C606CF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 00:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D456216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 00:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D456216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkeLG-0002rh-0r
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 20:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50972)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hkeG3-000245-FY
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 20:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hkeG0-0005oJ-CA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 20:45:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:58569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hkeFx-0005iV-Qg
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 20:45:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jul 2019 17:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,468,1557212400"; d="scan'208";a="167269425"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.197])
 ([10.239.196.197])
 by fmsmga007.fm.intel.com with ESMTP; 08 Jul 2019 17:45:05 -0700
To: Igor Mammedov <imammedo@redhat.com>
References: <20190614155626.27932-1-tao3.xu@intel.com>
 <20190614155626.27932-7-tao3.xu@intel.com>
 <20190701132532.2699a98a@redhat.com>
 <77ae1297-edb1-dcb2-b57e-e9e01b64139a@intel.com>
 <20190708110920.40204b47@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <8f237238-2297-01fc-45c5-4d3583de977c@intel.com>
Date: Tue, 9 Jul 2019 08:45:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708110920.40204b47@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH v5 6/8] hmat acpi: Build Memory Subsystem
 Address Range Structure(s) in ACPI HMAT
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/2019 5:09 PM, Igor Mammedov wrote:
> On Tue, 2 Jul 2019 16:50:24 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> On 7/1/2019 7:25 PM, Igor Mammedov wrote:
>>> On Fri, 14 Jun 2019 23:56:24 +0800
>>> Tao Xu <tao3.xu@intel.com> wrote:
>>>    
>> ...
>>>> @@ -2710,6 +2711,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>>>>                acpi_add_table(table_offsets, tables_blob);
>>>>                build_slit(tables_blob, tables->linker, machine);
>>>>            }
>>>> +        acpi_add_table(table_offsets, tables_blob);
>>>> +        build_hmat(tables_blob, tables->linker, machine);
>>> I'm not sure if we should add it unconditionally.
>>> Is this table used in any meaningful manner by guest when
>>> it's incomplete (i.e. populated only with SPA records)?
>>>    
>> Hi Igor,
>>
>> In ACPI 6.2, the linux kernel use it to show the memory ranges'
>> node-id(Proximity Domain). In ACPI 6.3, the linux kernel use it to show
>> the numa node's closest initiator(Generic Initiator or Processor, directly
>> attached). It is useful for a memory only numa node, because with
>> SPA(renamed as "Memory Proximity Domain Attributes Structure" in ACPI
>> 6.3) the user-space can know the topology of hardware heterogeneous
>> memory. I think I should add a doc to describe the use case in QEMU.
> Could you point out to me the specific kernel code that parses and uses HMAT?
> 

OK, it is in drivers/acpi/hmat/hmat.c

>>
>> Therefore, the numa CLI may be lack of a input which can indicate the
>> Initiator of a memory only numa node. Dan suggested me to add a new
>> parameter for that[1].
>>
>> Maybe like:
>> -numa node,mem=4G,nodeid=2,initiator=0
>>
>> [1] https://patchwork.kernel.org/cover/10934417/
>>
>> Thanks
>>
>> Tao
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
> 


