Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AFACA9EAF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 01:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2452166E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 01:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2452166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMiZN-0004Z8-4s
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 21:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iMiYP-0003zU-0E
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 21:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iMiYM-0001iS-4X
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 21:01:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:48900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iMiYL-0001he-SA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 21:01:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Oct 2019 18:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,325,1566889200"; d="scan'208";a="227516680"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.6])
 ([10.239.197.6])
 by fmsmga002.fm.intel.com with ESMTP; 21 Oct 2019 18:01:27 -0700
Subject: Re: [PATCH v13 05/12] numa: Extend CLI to provide initiator
 information for numa nodes
To: Igor Mammedov <imammedo@redhat.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-6-tao3.xu@intel.com>
 <20191021142901.24b33faa@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <3a4a361f-9d7d-c305-8059-305f9c99dfbe@intel.com>
Date: Tue, 22 Oct 2019 09:01:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021142901.24b33faa@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/2019 8:29 PM, Igor Mammedov wrote:
> On Sun, 20 Oct 2019 19:11:18 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),
>> The initiator represents processor which access to memory. And in 5.2.27.3
>> Memory Proximity Domain Attributes Structure, the attached initiator is
>> defined as where the memory controller responsible for a memory proximity
>> domain. With attached initiator information, the topology of heterogeneous
>> memory can be described.
>>
>> Extend CLI of "-numa node" option to indicate the initiator numa node-id.
>> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
>> the platform's HMAT tables.
>>
>> Reviewed-by: Jingqi Liu <jingqi.liu@intel.com>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
[...]
>> +static void numa_validate_initiator(NumaState *numa_state)
>> +{
>> +    int i;
>> +    NodeInfo *numa_info = numa_state->nodes;
>> +
>> +    for (i = 0; i < numa_state->num_nodes; i++) {
>> +        if (numa_info[i].initiator == MAX_NODES) {
>> +            error_report("The initiator of NUMA node %d is missing, use "
>> +                         "'-numa node,initiator' option to declare it.", i);
>> +            goto err;
>> +        }
>> +
>> +        if (!numa_info[numa_info[i].initiator].present) {
>> +            error_report("NUMA node %" PRIu16 " is missing, use "
>> +                         "'-numa node' option to declare it first.",
>> +                         numa_info[i].initiator);
>> +            goto err;
>> +        }
>> +
>> +        if (!numa_info[numa_info[i].initiator].has_cpu) {
>> +            error_report("The initiator of NUMA node %d is invalid.", i);
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    return;
>> +
>> +err:
>> +    error_printf("\n");
> error_report() does ^^^, drop it

OK, I will drop it.
> 
> with this fixed,
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
[...]

