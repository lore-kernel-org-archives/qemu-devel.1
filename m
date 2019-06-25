Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576D1C4646C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 03:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2D920665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 03:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2D920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56092 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfbpo-0003cv-EC
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 23:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35408)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hfboh-0002py-QJ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 23:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hfbog-00006o-En
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 23:08:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:49331)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hfbog-0008W8-6O
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 23:08:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jun 2019 20:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; d="scan'208";a="312925081"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga004.jf.intel.com with ESMTP; 24 Jun 2019 20:08:12 -0700
Date: Mon, 24 Jun 2019 23:02:18 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190625030218.GA6971@joy-OptiPlex-7040>
References: <20190624091811.30412-1-peterx@redhat.com>
 <20190624091811.30412-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624091811.30412-3-peterx@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH v2 2/2] intel_iommu: Fix unexpected unmaps
 during global unmap
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Auger Eric <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Yan Zhao <yan.y.zhao@intel.com>

On Mon, Jun 24, 2019 at 05:18:11PM +0800, Peter Xu wrote:
> This is an replacement work of Yan Zhao's patch:
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg625340.html
> 
> vtd_address_space_unmap() will do proper page mask alignment to make
> sure each IOTLB message will have correct masks for notification
> messages (2^N-1), but sometimes it can be expanded to even supercede
> the registered range.  That could lead to unexpected UNMAP of already
> mapped regions in some other notifiers.
> 
> Instead of doing mindless expension of the start address and address
> mask, we split the range into smaller ones and guarantee that each
> small range will have correct masks (2^N-1) and at the same time we
> should also try our best to generate as less IOTLB messages as
> possible.
> 
> Reported-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 67 ++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 719ce19ab3..de86f53b4e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3363,11 +3363,28 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
>      return vtd_dev_as;
>  }
>  
> +static uint64_t get_naturally_aligned_size(uint64_t start,
> +                                           uint64_t size, int gaw)
> +{
> +    uint64_t max_mask = 1ULL << gaw;
> +    uint64_t alignment = start ? start & -start : max_mask;
> +
> +    alignment = MIN(alignment, max_mask);
> +    size = MIN(size, max_mask);
> +
> +    if (alignment <= size) {
> +        /* Increase the alignment of start */
> +        return alignment;
> +    } else {
> +        /* Find the largest page mask from size */
> +        return 1ULL << (63 - clz64(size));
> +    }
> +}
> +
>  /* Unmap the whole range in the notifier's scope. */
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
> -    IOMMUTLBEntry entry;
> -    hwaddr size;
> +    hwaddr size, remain;
>      hwaddr start = n->start;
>      hwaddr end = n->end;
>      IntelIOMMUState *s = as->iommu_state;
> @@ -3388,39 +3405,37 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      }
>  
>      assert(start <= end);
> -    size = end - start;
> +    size = remain = end - start + 1;
>  
> -    if (ctpop64(size) != 1) {
> -        /*
> -         * This size cannot format a correct mask. Let's enlarge it to
> -         * suite the minimum available mask.
> -         */
> -        int n = 64 - clz64(size);
> -        if (n > s->aw_bits) {
> -            /* should not happen, but in case it happens, limit it */
> -            n = s->aw_bits;
> -        }
> -        size = 1ULL << n;
> +    while (remain >= VTD_PAGE_SIZE) {
> +        IOMMUTLBEntry entry;
> +        uint64_t mask = get_naturally_aligned_size(start, remain, s->aw_bits);
> +
> +        assert(mask);
> +
> +        entry.iova = start;
> +        entry.addr_mask = mask - 1;
> +        entry.target_as = &address_space_memory;
> +        entry.perm = IOMMU_NONE;
> +        /* This field is meaningless for unmap */
> +        entry.translated_addr = 0;
> +
> +        memory_region_notify_one(n, &entry);
> +
> +        start += mask;
> +        remain -= mask;
>      }
>  
> -    entry.target_as = &address_space_memory;
> -    /* Adjust iova for the size */
> -    entry.iova = n->start & ~(size - 1);
> -    /* This field is meaningless for unmap */
> -    entry.translated_addr = 0;
> -    entry.perm = IOMMU_NONE;
> -    entry.addr_mask = size - 1;
> +    assert(!remain);
>  
>      trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
>                               VTD_PCI_SLOT(as->devfn),
>                               VTD_PCI_FUNC(as->devfn),
> -                             entry.iova, size);
> +                             n->start, size);
>  
> -    map.iova = entry.iova;
> -    map.size = entry.addr_mask;
> +    map.iova = n->start;
> +    map.size = size;
>      iova_tree_remove(as->iova_tree, &map);
> -
> -    memory_region_notify_one(n, &entry);
>  }
>  
>  static void vtd_address_space_unmap_all(IntelIOMMUState *s)
> -- 
> 2.21.0
> 

