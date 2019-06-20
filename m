Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF7DC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BED2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BED2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdvAW-0006Ql-VG
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:23:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52851)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hdv4E-0004QD-IR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hdv0N-0003Gq-2D
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:13:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:23108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hdurI-0000FF-Np
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:04:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jun 2019 04:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; d="scan'208";a="170842452"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga002.jf.intel.com with ESMTP; 20 Jun 2019 04:03:45 -0700
Date: Thu, 20 Jun 2019 06:57:53 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190620105752.GD9303@joy-OptiPlex-7040>
References: <1560934185-14152-1-git-send-email-yan.y.zhao@intel.com>
 <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
 <20190620040230.GB9073@xz-x1>
 <6829b139-3eab-449e-04d6-07f1e381316d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6829b139-3eab-449e-04d6-07f1e381316d@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH] memory: do not do out of bound notification
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
Cc: Auger Eric <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 04:35:29PM +0800, Paolo Bonzini wrote:
> On 20/06/19 06:02, Peter Xu wrote:
> > Seems workable, to be explicit - we can even cut it into chunks with
> > different size to be efficient.
> 
> Yes, this is not hard (completely untested):
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 44b1231157..541538bc6c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3388,39 +3388,34 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      }
>  
>      assert(start <= end);
> -    size = end - start;
> +    while (end > start) {
> +        size = end - start;
> +        /* Only keep the lowest bit of either size or start.  */
> +        size = MIN(size & -size, start & -start);
> +        /* Should not happen, but limit to address width too just in case */
> +        size = MIN(size, 1ULL << s->aw_bits);
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
> -    }
> +        assert((start & (size - 1)) == 0);
>  
> -    entry.target_as = &address_space_memory;
> -    /* Adjust iova for the size */
> -    entry.iova = n->start & ~(size - 1);
> -    /* This field is meaningless for unmap */
> -    entry.translated_addr = 0;
> -    entry.perm = IOMMU_NONE;
> -    entry.addr_mask = size - 1;
> +        entry.target_as = &address_space_memory;
> +        entry.iova = start;
> +        /* This field is meaningless for unmap */
> +        entry.translated_addr = 0;
> +        entry.perm = IOMMU_NONE;
> +        entry.addr_mask = size - 1;
>  
> -    trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
> -                             VTD_PCI_SLOT(as->devfn),
> -                             VTD_PCI_FUNC(as->devfn),
> -                             entry.iova, size);
> +        trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
> +                                 VTD_PCI_SLOT(as->devfn),
> +                                 VTD_PCI_FUNC(as->devfn),
> +                                 entry.iova, size);
>  
> -    map.iova = entry.iova;
> -    map.size = entry.addr_mask;
> -    iova_tree_remove(as->iova_tree, &map);
> +        map.iova = entry.iova;
> +        map.size = entry.addr_mask;
> +        iova_tree_remove(as->iova_tree, &map);
>  
> -    memory_region_notify_one(n, &entry);
> +        memory_region_notify_one(n, &entry);
> +        start += size;
> +    }
>  }
>  
>  static void vtd_address_space_unmap_all(IntelIOMMUState *s)
> 
> 
> Yan,
> 
> if something like this works for you, let me know and I will submit it
> as a proper patch.
> 
> Paolo

hi Paolo

Thanks and I'll try it tomorrow and let you know the result.
But may I know why it cannot simply be like below?

Thanks
Yan


diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b0d8a1c..2956db6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3374,7 +3374,6 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     IntelIOMMUState *s = as->iommu_state;
     DMAMap map;

     /*
      * Note: all the codes in this function has a assumption that IOVA
      * bits are no more than VTD_MGAW bits (which is restricted by
@@ -3392,23 +3391,8 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     assert(start <= end);
     size = end - start;

-    if (ctpop64(size) != 1) {
-        /*
-         * This size cannot format a correct mask. Let's enlarge it to
-         * suite the minimum available mask.
-         */
-        int n = 64 - clz64(size);
-        if (n > s->aw_bits) {
-            /* should not happen, but in case it happens, limit it */
-            n = s->aw_bits;
-        }
-        size = 1ULL << n;
-    }
-
-
     entry.target_as = &address_space_memory;
-    /* Adjust iova for the size */
-    entry.iova = n->start & ~(size - 1);
+    entry.iova = n->start;
     /* This field is meaningless for unmap */
     entry.translated_addr = 0;
     entry.perm = IOMMU_NONE;




