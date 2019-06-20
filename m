Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8BC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96612085A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96612085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdsTr-0004DI-5s
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 04:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58809)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hdsIN-0003mf-C7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hdsIL-0004fh-DT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:19:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:57182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hdsIK-0004c9-Am
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:19:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jun 2019 01:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; d="scan'208";a="150860441"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga007.jf.intel.com with ESMTP; 20 Jun 2019 01:19:38 -0700
Date: Thu, 20 Jun 2019 04:13:46 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190620081345.GC9303@joy-OptiPlex-7040>
References: <1560934185-14152-1-git-send-email-yan.y.zhao@intel.com>
 <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
 <20190620040230.GB9073@xz-x1>
 <20190620041400.GB9303@joy-OptiPlex-7040>
 <20190620081437.GA11135@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620081437.GA11135@xz-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 04:14:37PM +0800, Peter Xu wrote:
> On Thu, Jun 20, 2019 at 12:14:00AM -0400, Yan Zhao wrote:
> > On Thu, Jun 20, 2019 at 12:02:30PM +0800, Peter Xu wrote:
> > > On Wed, Jun 19, 2019 at 03:17:41PM +0200, Auger Eric wrote:
> > > > Hi Yan,
> > > > 
> > > > [+ Peter]
> > > > 
> > > > On 6/19/19 10:49 AM, Yan Zhao wrote:
> > > > > even if an entry overlaps with notifier's range, should not map/unmap
> > > > > out of bound part in the entry.
> > > > 
> > > > I don't think the patch was based on the master as the trace at the very
> > > > end if not part of the upstream code.
> > > > > 
> > > > > This would cause problem in below case:
> > > > > 1. initially there are two notifiers with ranges
> > > > > 0-0xfedfffff, 0xfef00000-0xffffffffffffffff,
> > > > > IOVAs from 0x3c000000 - 0x3c1fffff is in shadow page table.
> > > > > 
> > > > > 2. in vfio, memory_region_register_iommu_notifier() is followed by
> > > > > memory_region_iommu_replay(), which will first call address space unmap,
> > > > > and walk and add back all entries in vtd shadow page table. e.g.
> > > > > (1) for notifier 0-0xfedfffff,
> > > > >     IOVAs from 0 - 0xffffffff get unmapped,
> > > > >     and IOVAs from 0x3c000000 - 0x3c1fffff get mapped
> > > > 
> > > > While the patch looks sensible, the issue is the notifier scope used in
> > > > vtd_address_space_unmap is not a valid mask (ctpop64(size) != 1). Then
> > > > the size is recomputed (either using n = 64 - clz64(size) for the 1st
> > > > notifier or n = s->aw_bits for the 2d) and also the entry (especially
> > > > for the 2d notifier where it becomes 0) to get a proper alignment.
> > > > 
> > > > vtd_page_walk sends notifications per block or page (with valid
> > > > addr_mask) so stays within the notifier.
> > > > 
> > > > Modifying the entry->iova/addr_mask again in memory_region_notify_one
> > > > leads to unaligned start address / addr_mask. I don't think we want that.
> > > > 
> > > > Can't we modity the vtd_address_space_unmap() implementation to split
> > > > the invalidation in smaller chunks instead?
> > > 
> > > Seems workable, to be explicit - we can even cut it into chunks with
> > > different size to be efficient.  Like, this range:
> > > 
> > >   0x0e00_0000 - 0x1_0000_0000 (size 0xf200_0000)
> > > 
> > > can be one of this:
> > > 
> > >   0x0e000000 - 0x1000_0000 (size 0x0200_0000)
> > > 
> > > plus one of this:
> > > 
> > >   0x1000_0000 - 0x1_0000_0000 (size 0xf000_0000)
> > > 
> > > Yan, could you help explain the issue better on how to reproduce and
> > > what's the error when the problem occurs?  For example, is that
> > > happened when a device hot-plugged into an existing VFIO container
> > > (with some mapped IOVAs)?  Did you get host DMA errors later on?
> > > 
> > > Thanks,
> > > 
> > > -- 
> > > Peter Xu
> > 
> > Hi Peter
> > it happens when there's an RMRR region in my guest iommu driver.
> 
> Do you mean a RMRR region in the ACPI table?  AFAIK current QEMU VT-d
> does not have RMRR at all, so that's a customized QEMU?

it can be a customized QEMU with RMRR region in ACPI table. or simply
hardcode in guest kernel.

> 
> > if not adding this range check, IOVAs in this region would be unmapped and DMA
> > faults are met in host.
> 
> I see, thanks.
> 
> -- 
> Peter Xu

