Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8FFC06508
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 00:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAEA212F5
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 00:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAEA212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhkf8-000462-PA
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 20:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54667)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hhkef-0003hP-Bw
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 20:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hhkee-0007qZ-7b
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 20:58:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:62160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hhked-0007iC-Uk
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 20:58:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Jun 2019 17:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,437,1557212400"; d="scan'208";a="165657813"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.241])
 ([10.239.196.241])
 by orsmga003.jf.intel.com with ESMTP; 30 Jun 2019 17:58:36 -0700
To: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20190614155626.27932-1-tao3.xu@intel.com>
 <20190614155626.27932-7-tao3.xu@intel.com>
 <20190627165627.00007450@huawei.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <40108c39-4d58-4842-e171-474508b16a7e@intel.com>
Date: Mon, 1 Jul 2019 08:58:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627165627.00007450@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/2019 11:56 PM, Jonathan Cameron wrote:
> On Fri, 14 Jun 2019 23:56:24 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> HMAT is defined in ACPI 6.2: 5.2.27 Heterogeneous Memory Attribute Table (HMAT).
>> The specification references below link:
>> http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
>>
>> It describes the memory attributes, such as memory side cache
>> attributes and bandwidth and latency details, related to the
>> System Physical Address (SPA) Memory Ranges. The software is
>> expected to use this information as hint for optimization.
>>
>> This structure describes the System Physical Address(SPA) range
>> occupied by memory subsystem and its associativity with processor
>> proximity domain as well as hint for memory usage.
>>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> 
> Hi Tao,
> 
> Apologies if I missed an earlier discussion on this...
> 
> It's probably not letting an secrets out to say that there are very few
> real hardware systems out there using the 6.2 version of HMAT.
> 
> Does it make sense to implement it rather than the somewhat tidied
> up version in ACPI 6.3?
> 
> I would go so far as to say that one of the pushes behind making those
> changes was that it shouldn't have much impact as no one was shipping
> a firmware using the 6.2 version.  So any chance we can avoid
> qemu effectively doing so, or at least defaulting to doing so?
> 
> I'm entirely in favor of the patch set in general btw as it's much
> more useful than having to override with a hand crafted table, when
> wanting to test unusual topologies.
> 
> Thanks,
> 
> Jonathan
> 
Thanks for your suggestion. After discussion, we decide to use ACPI 6.3 
in next version.



