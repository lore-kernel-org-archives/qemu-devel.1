Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701BEC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CC5208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CC5208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiIN2-0000t6-6R
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53525)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hiILy-0000Q2-Jk
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hiILx-00034U-Ae
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:57:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:25439)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hiILx-0002ou-1J
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:57:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jul 2019 05:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,443,1557212400"; d="scan'208";a="157635648"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga008.jf.intel.com with ESMTP; 02 Jul 2019 05:57:34 -0700
Date: Tue, 2 Jul 2019 08:51:38 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190702125138.GA9176@joy-OptiPlex-7040>
References: <1561760389-31325-1-git-send-email-yan.y.zhao@intel.com>
 <42713cac-27fb-f4a9-1b06-bfee409690a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42713cac-27fb-f4a9-1b06-bfee409690a5@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH v5] memory: do not notify for non inclusive
 overlap entry
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

On Mon, Jul 01, 2019 at 06:10:33PM +0800, Auger Eric wrote:
> Hi Yan,
> 
> On 6/29/19 12:19 AM, Yan Zhao wrote:
> > if an entry has non inclusive overlap with the notifier, print warning
> > message and do not do notification for it.
> > 
> > Out of scope mapping/unmapping would cause problem, as in below case:
> > 
> > 1. initially there are two notifiers with ranges
> > 0-0xfedfffff, 0xfef00000-0xffffffffffffffff,
> > IOVAs from 0x3c000000 - 0x3c1fffff is in shadow page table.
> > 
> > 2. in vfio, memory_region_register_iommu_notifier() is followed by
> > memory_region_iommu_replay(), which will first call address space
> > unmap,
> > and walk and add back all entries in vtd shadow page table. e.g.
> > (1) for notifier 0-0xfedfffff,
> >     IOVAs from 0 - 0xffffffff get unmapped,
> >     and IOVAs from 0x3c000000 - 0x3c1fffff get mapped
> > (2) for notifier 0xfef00000-0xffffffffffffffff
> >     IOVAs from 0 - 0x7fffffffff get unmapped,
> >     but IOVAs from 0x3c000000 - 0x3c1fffff cannot get mapped back.
> > 
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric

Thank you, Eric :)

Yan
> > 
> > ---
> > v5:
> > 1. still using warn_report instead of "assert"
> > 2. returning at the end to refuse notification for entry which has non
> > inclusive overlap with the notifier.
> > 3. updated commit title and warning message.
> > 
> > v4:
> > 1. modified commit title
> > 2. using "assert" instead of printing warning message
> > 
> > v3:
> > refined code style and message format
> > 
> > v2:
> > 1. added a local variable entry_end (Eric Auger)
> > 2. using PRIx64 as format for address range in warning message
> > (Eric Auger)
> > ---
> >  memory.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/memory.c b/memory.c
> > index 0a089a7..fe0d08d 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1937,13 +1937,13 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
> >                                IOMMUTLBEntry *entry)
> >  {
> >      IOMMUNotifierFlag request_flags;
> > +    hwaddr entry_end = entry->iova + entry->addr_mask;
> >  
> >      /*
> >       * Skip the notification if the notification does not overlap
> >       * with registered range.
> >       */
> > -    if (notifier->start > entry->iova + entry->addr_mask ||
> > -        notifier->end < entry->iova) {
> > +    if (notifier->start > entry_end || notifier->end < entry->iova) {
> >          return;
> >      }
> >  
> > @@ -1953,6 +1953,18 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
> >          request_flags = IOMMU_NOTIFIER_UNMAP;
> >      }
> >  
> > +    if (entry->iova < notifier->start || entry_end > notifier->end) {
> > +        warn_report("IOMMUTLBEntry 0x%" PRIx64 " - 0x%" PRIx64
> > +                " has non inclusive overlap with notifier 0x%" PRIx64
> > +                " - 0x%" PRIx64 ". %s is not allowed."
> > +                " Try to divide it into smaller sections.",
> > +                entry->iova, entry_end,
> > +                notifier->start, notifier->end,
> > +                (request_flags == IOMMU_NOTIFIER_MAP) ?
> > +                "Mapping" : "Unmapping");
> > +        return;
> > +    }
> > +
> >      if (notifier->notifier_flags & request_flags) {
> >          notifier->notify(notifier, entry);
> >      }
> > 

