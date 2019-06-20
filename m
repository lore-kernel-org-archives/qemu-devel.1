Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF591C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67E82070B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67E82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdmFh-0005Fx-2v
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 21:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48466)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hdmF6-0004ng-Tn
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hdmF5-0002Bi-Kd
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:52:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:46733)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hdmF5-00029S-Aa
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:51:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jun 2019 18:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; d="scan'208";a="181754848"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2019 18:51:54 -0700
Date: Wed, 19 Jun 2019 21:46:02 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190620014601.GA9303@joy-OptiPlex-7040>
References: <1560934185-14152-1-git-send-email-yan.y.zhao@intel.com>
 <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hi Eric,
Thanks for your reply.

On Wed, Jun 19, 2019 at 09:17:41PM +0800, Auger Eric wrote:
> Hi Yan,
> 
> [+ Peter]
> 
> On 6/19/19 10:49 AM, Yan Zhao wrote:
> > even if an entry overlaps with notifier's range, should not map/unmap
> > out of bound part in the entry.
> 
> I don't think the patch was based on the master as the trace at the very
> end if not part of the upstream code.
> > 
It's indeed based on the latest master branch. but I added a debug log
and forgot to remove that before sending out the patch. sorry for that :)


> > This would cause problem in below case:
> > 1. initially there are two notifiers with ranges
> > 0-0xfedfffff, 0xfef00000-0xffffffffffffffff,
> > IOVAs from 0x3c000000 - 0x3c1fffff is in shadow page table.
> > 
> > 2. in vfio, memory_region_register_iommu_notifier() is followed by
> > memory_region_iommu_replay(), which will first call address space unmap,
> > and walk and add back all entries in vtd shadow page table. e.g.
> > (1) for notifier 0-0xfedfffff,
> >     IOVAs from 0 - 0xffffffff get unmapped,
> >     and IOVAs from 0x3c000000 - 0x3c1fffff get mapped
> 
> While the patch looks sensible, the issue is the notifier scope used in
> vtd_address_space_unmap is not a valid mask (ctpop64(size) != 1). Then
> the size is recomputed (either using n = 64 - clz64(size) for the 1st
> notifier or n = s->aw_bits for the 2d) and also the entry (especially
> for the 2d notifier where it becomes 0) to get a proper alignment.
>
maybe the size is calculated right, but 0 for the 2d notifier is because
this line below ?
 entry.iova = n->start & ~(size - 1);

> vtd_page_walk sends notifications per block or page (with valid
> addr_mask) so stays within the notifier.
> 
> Modifying the entry->iova/addr_mask again in memory_region_notify_one
> leads to unaligned start address / addr_mask. I don't think we want that.
>
if the notifier's start and end is aligned, and entry->iova/addr_mask is
aligned before modification,  then after modification, the start addr
/addr_mask are still aligned ?

> Can't we modity the vtd_address_space_unmap() implementation to split
> the invalidation in smaller chunks instead?
>
as this is an API, it cannot reply on the caller to ensure the entry is
within its address range. Do you think it's reasonable?

Thanks
Yan


> Thanks
> 
> Eric
> 
> 
> > (2) for notifier 0xfef00000-0xffffffffffffffff
> >     IOVAs from 0 - 0x7fffffffff get unmapped,>     but IOVAs from 0x3c000000 - 0x3c1fffff cannot get mapped back.
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  memory.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/memory.c b/memory.c
> > index 07c8315..a6b9da6 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1948,6 +1948,14 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
> >          return;
> >      }
> >  
> > +    if (entry->iova < notifier->start) {
> > +        entry->iova = notifier->start;
> > +    }
> > +
> > +    if (entry->iova + entry->addr_mask > notifier->end) {
> > +        entry->addr_mask = notifier->end - entry->iova;> +    }
> > +
> >      if (entry->perm & IOMMU_RW) {
> >          printf("map %lx %lx\n", entry->iova, entry->iova + entry->addr_mask);
> >          request_flags = IOMMU_NOTIFIER_MAP;
> 
> > 

