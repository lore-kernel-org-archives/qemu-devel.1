Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2408C433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F3C207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F3C207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyI8K-0002qf-RI
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jyI6n-0001cF-4E; Wed, 22 Jul 2020 13:00:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:20977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jyI6j-0003IL-0q; Wed, 22 Jul 2020 13:00:44 -0400
IronPort-SDR: xurqIrJqKDQ4L7XDiTxs83lQURYVOAmqf2FTdVewAFZIuwaM2HNG4uRa91YuvWZWWPuGgJ3Os8
 ZhwPrqgNwBzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="138460139"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="138460139"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 10:00:33 -0700
IronPort-SDR: H6Y4IokFQdvCraijod3zeikeFMtRtcK/WtSzzEfu+/BF1n3tAD91zuhXRPSm3vHCSohAnELcv3
 Yk4oB8aR5sYA==
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="432440776"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.212.27.19])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 10:00:32 -0700
Subject: Re: [PATCH v4 2/2] nvme: allow cmb and pmr to be enabled on same
 device
To: Klaus Jensen <its@irrelevant.dk>
References: <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>
 <20200702101318.rmd65uzwfpcmb24n@apples.localdomain>
 <20200702103127.hoonqkas3bw2v7re@apples.localdomain>
 <8f871a0d-47f1-1c8a-fcc2-aab2638c70cf@linux.intel.com>
 <20200702175113.6qtnpxqimpavzx7h@apples.localdomain>
 <191b39ed-0588-b5db-d352-965efd19128a@linux.intel.com>
 <20200706071545.md4tivimefffgyi6@apples.localdomain>
 <16d74d40-bd55-997d-7fd6-e7ec59566a68@linux.intel.com>
 <20200715080658.GA506302@apples.localdomain>
 <9143a543-d32d-f3e7-c37b-b3df7f853952@linux.intel.com>
 <20200722074305.GA606300@apples.localdomain>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <63d2e5ed-3c73-4a80-ae45-ce3665b406c8@linux.intel.com>
Date: Wed, 22 Jul 2020 10:00:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200722074305.GA606300@apples.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 13:00:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On 7/22/20 12:43 AM, Klaus Jensen wrote:
> @keith, please see below - can you comment on the Linux kernel 2 MB
> boundary requirement for the CMB? Or should we hail Stephen (or Logan
> maybe) since this seems to be related to p2pdma?
> 
> On Jul 21 14:54, Andrzej Jakowski wrote:
>> On 7/15/20 1:06 AM, Klaus Jensen wrote:
>>> Hi Andrzej,
>>>
>>> I've not been ignoring this, but sorry for not following up earlier.
>>>
>>> I'm hesitent to merge anything that very obviously breaks an OS that we
>>> know is used a lot to this using this device. Also because the issue has
>>> not been analyzed well enough to actually know if this is a QEMU or
>>> kernel issue.
>>
>> Hi Klaus,
>>
>> Thx for your response! I understand your hesitance on merging stuff that
>> obviously breaks guest OS. 
>>
>>>
>>> Now, as far as I can test, having the MSI-X vector table and PBA in BAR
>>> 0, PMR in BAR 2 and CMB in BAR 4 seems to make everyone happy
>>> (irregardless of IOMMU on/off).
>>>
>>> Later, when the issue is better understood, we can add options to set
>>> offsets, BIRs etc.
>>>
>>> The patch below replaces your "[PATCH v4 2/2] nvme: allow cmb and pmr to
>>> be enabled" (but still requires "[PATCH v4 1/2] ...") and applies to
>>> git://git.infradead.org/qemu-nvme.git nvme-next branch.
>>>
>>> Can you reproduce the issues with that patch? I can't on a stock Arch
>>> Linux 5.7.5-arch1-1 kernel.
>>
>> While I'm happy that approach with MSIX and PBA in BAR0 works fine, I
>> feel that investigation part why it works while mine doesn't is
>> missing. It looks to me that both patches are basically following same 
>> approach: create memory subregion and overlay on top of other memory
>> region. Why one works and the other doesn't then?
>>
>> Having in mind that, I have recently focused on understanding problem.
>> I observed that when guest assigns address to BAR4, addr field in
>> nvme-bar4 memory region gets populated, but it doesn't get automatically
>> populated in ctrl_mem (cmb) memory subregion, so later when nvme_addr_is_cmb() 
>> is called address check works incorrectly and as a consequence vmm does dma 
>> read instead of memcpy.
>> I created a patch that sets correct address on ctrl_mem subregion and guest 
>> OS boots up correctly.
>>
>> When I looked into pci and memory region code I noticed that indeed address
>> is only assigned to top level memory region but not to contained subregions.
>> I think that because in your approach cmb grabs whole bar exclusively it works
>> fine.
>>
>> Here is my question (perhaps pci folks can help answer :)): if we consider 
>> memory region overlapping for pci devices as valid use case should pci 
>> code on configuration cycles walk through all contained subregion and
>> update addr field accordingly?
>>
>> Thx!
>>
> 
> Hi Andrzej,
> 
> Thanks for looking into this. I think your analysis helped me nail this.
> The problem is that we added the use of a subregion and have some
> assumptions that no longer hold.
> 
> nvme_addr_is_cmb() assumes that n->ctrl_mem.addr is an absolute address.
> But when the memory region is a subregion, addr holds an offset into the
> parent container instead. Thus, changing all occurances of
> n->ctrl_mem.addr to (n->bar0.addr + n->ctrl_mem.addr) fixes the issue
> (this is required in nvme_addr_is_cmb and nvme_map_prp). I patched that
> in your original patch[1]. The reason my version worked is because there
> was no subregion involved for the CMB, so the existing address
> validation calculations were still correct.

I'm a little bit concerned with this approach:
(n->bar0.addr + n->ctrl_mem.addr) and hoping to have some debate. Let me 
describe my understanding of the problem.
It looks to me that addr field sometimes contains *absolute* address (when no 
hierarchy is used) and other times it contains *relative* address (when
hierarchy is created). From my perspective use of this field is inconsistent
and thus error-prone.  
Because of that I think that doing n->bar0.addr + n->ctrl_mem.addr doesn't
solve root problem and is still prone to the same problem if in the future
we potentially build even more complicated hierarchy.
I think that we could solve it by introducing helper function like

hwaddr memory_region_get_abs_addr(MemoryRegion *mr) 

to retrieve absolute address and in the documentation indicate that addr field
can be relative or absolute and it is recommended to use above function to 
retrieve absolute address.
What do you think?

> 
> This leaves us with the Linux kernel complaining about not being able to
> register the CMB if it is not on a 2MB boundary - this is probably just
> a constraint in the kernel that we can't do anything about (but I'm no
> kernel hacker...), which can be fixed by either being "nice" towards the
> Linux kernel by forcing a 2 MB alignment in the device or exposing the
> SZU field such that the user can choose 16MiB size units (or higher)
> instead of 1MiB. I'm leaning towards ensuring the 2 MB alignment in the
> device such that we do not have to introduce new cmb_size parameters,
> while also making it easier for the user to configure. But I'm not
> really sure.
This is kernel limitation that we have to live with. The minimum granularity
of devm_memremap_pages() is 2MB and it must be 2MB aligned. It used to worse
at 128MB size+align (section-size), but sub-section memory-hotplug patches 
adjusted that to a 2MB section. 
Ensuring 2MiB size and alignment in the device emulation makes sense to me.
Perhaps we could document that limitations - making user more aware of it.

> 
>   [1]: Message-Id: <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>
> 


