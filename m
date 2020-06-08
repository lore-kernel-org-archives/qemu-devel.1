Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7416C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E752074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E752074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiNin-0001SR-Pc
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 15:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jiNhd-0000QU-T4; Mon, 08 Jun 2020 15:45:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:19653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jiNhc-0003v9-AR; Mon, 08 Jun 2020 15:45:01 -0400
IronPort-SDR: Uugv0oJf4SJULLdpzXjB4PPw/XWvEWKz/+npnUNSnWyrOUAoP+RkEZ/RVlIVO5hnXjYOqNW4qB
 JYKDgJvfkjZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2020 12:44:51 -0700
IronPort-SDR: eX5IYX8P7EgOMozIRUcPbqI7j9a5FZgQRHguQgFJRjVkdUimjGWaTk7o42uWDGjGnFMMZwZ5Zj
 NtbYNgNNahfQ==
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; d="scan'208";a="446859847"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.12.117])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2020 12:44:51 -0700
Subject: Re: [PATCH v1 2/2] nvme: allow cmb and pmr to be enabled on same
 device
To: Klaus Jensen <its@irrelevant.dk>
References: <20200605181043.28782-1-andrzej.jakowski@linux.intel.com>
 <20200605181043.28782-3-andrzej.jakowski@linux.intel.com>
 <20200608080750.ahze6ez3gvhginq7@apples.localdomain>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <c4c6eb4b-ed35-951c-0b00-079070638445@linux.intel.com>
Date: Mon, 8 Jun 2020 12:44:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608080750.ahze6ez3gvhginq7@apples.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.55.52.151;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 15:44:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kbusch@kernel.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 1:08 AM, Klaus Jensen wrote:
> On Jun  5 11:10, Andrzej Jakowski wrote:
>> So far it was not possible to have CMB and PMR emulated on the same
>> device, because BAR2 was used exclusively either of PMR or CMB. This
>> patch places CMB at BAR4 offset so it not conflicts with MSI-X vectors.
>>
> 
> Hi Andrzej,
> 
> Thanks for doing this, it's a nice addition!
> 
> Though, I would prefer that the table and pba was located in BAR0 and
> keeping BAR4 for exclusive CMB use. I'm no expert on this, but is it ok
> to have the table and pba in prefetchable memory? Having it "together"
> with the other controller-level configuration memory just feels more
> natural to me, but I'm not gonna put my foot down.
Hi Klaus,

Thx for your feedback!
I don't think it matters if MSIX table is in prefetchable vs 
non-prefetchable memory. 
My understanding is that spec allows MSIX and PBA to be in any BAR and
offset. I understand your preference and at the same time think that
since it is not in violation of the spec why don't we leave it as-is?
Does anybody know what's typical approach for real devices?
> 
> Using BAR0 would also slightly simplify the patch since no changes would
> be required for the CMB path.
> 
> Also, can you rebase this on Kevin's block branch? There are a bunch of
> refactoring patches that changes the realization code, so this patch
> doesn't apply at all.
Yep will reabse it.
> 
>> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
>> ---
>>  hw/block/nvme.c      | 127 +++++++++++++++++++++++++++++--------------
>>  hw/block/nvme.h      |   3 +-
>>  include/block/nvme.h |   4 +-
>>  3 files changed, 91 insertions(+), 43 deletions(-)
>>
>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>> index f0b45704be..353cf20e0a 100644
>> --- a/hw/block/nvme.c
>> +++ b/hw/block/nvme.c
>> @@ -22,12 +22,12 @@
>>   *              [pmrdev=<mem_backend_file_id>,] \
>>   *              num_queues=<N[optional]>
>>   *
>> - * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
>> - * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
>> + * Note cmb_size_mb denotes size of CMB in MB. CMB when configured is assumed
>> + * to be resident in BAR4 at certain offset - this is because BAR4 is also
>> + * used for storing MSI-X table that is available at offset 0 in BAR4.
>>   *
>> - * cmb_size_mb= and pmrdev= options are mutually exclusive due to limitation
>> - * in available BAR's. cmb_size_mb= will take precedence over pmrdev= when
>> - * both provided.
>> + * pmrdev is assumed to be resident in BAR2. When configured it consumes whole
>> + * BAR2 exclusively.
> 
> Actually it uses both BAR2 and BAR3 since its 64 bits.
Correct. That's what I implied here w/o actual verbiage. I can extend it
to add that information.
> 
>> @@ -1342,6 +1346,71 @@ static const MemoryRegionOps nvme_cmb_ops = {
>>      },
>>  };
>>  
>> +#define NVME_MSIX_BIR (4)
>> +static void nvme_bar4_init(PCIDevice *pci_dev)
>> +{
>> +    NvmeCtrl *n = NVME(pci_dev);
>> +    int status;
>> +    uint64_t bar_size = 4096;
>> +    uint32_t nvme_pba_offset = bar_size / 2;
>> +    uint32_t nvme_pba_size = QEMU_ALIGN_UP(n->num_queues, 64) / 8;
>> +    uint32_t cmb_size_units;
>> +
>> +    if (n->num_queues * PCI_MSIX_ENTRY_SIZE > nvme_pba_offset) {
>> +        nvme_pba_offset = n->num_queues * PCI_MSIX_ENTRY_SIZE;
>> +    }
>> +
>> +    if (nvme_pba_offset + nvme_pba_size > 4096) {
>> +        bar_size = nvme_pba_offset + nvme_pba_size;
>> +    }
>> +
> 
> This is migration compatibility stuff that is not needed because the
> nvme device is unmigratable anyway.
I don't understand that comment. Could you please explain more?
 


