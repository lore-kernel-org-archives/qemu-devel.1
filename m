Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505B0C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287F320663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287F320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfJQL-0001Am-7P
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 03:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54619)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hfJPR-0000m9-2R
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hfJPQ-0002Fj-3t
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:29:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:62668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hfJPP-0002Bf-QW
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:29:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jun 2019 00:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; d="scan'208";a="359476657"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga005.fm.intel.com with ESMTP; 24 Jun 2019 00:27:07 -0700
Date: Mon, 24 Jun 2019 03:21:14 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190624072114.GD27894@joy-OptiPlex-7040>
References: <1561354383-21322-1-git-send-email-yan.y.zhao@intel.com>
 <ff6e9034-5e23-7a29-1377-1892036bfec2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff6e9034-5e23-7a29-1377-1892036bfec2@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH] memory: warning on out of scope
 notification
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 03:09:24PM +0800, Auger Eric wrote:
> Hi Yan,
> 
> On 6/24/19 7:33 AM, Yan Zhao wrote:
> > if an entry has parts out of scope of notifier's range, print warning
> > message.
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
> > Cc: Auger Eric <eric.auger@redhat.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  memory.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/memory.c b/memory.c
> > index 0a089a7..18927f2 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1953,6 +1953,16 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
> >          request_flags = IOMMU_NOTIFIER_UNMAP;
> >      }
> I think introducing a local variable for entry end would be worth now
> >  
> > +    if (entry->iova < notifier->start ||
> > +            entry->iova + entry->addr_mask > notifier->end) {
> > +        warn_report("%s IOMMUTLBEntry %lx-%lx outside of "
> > +                "notifier scope %lx-%lx",
> Also I think you should use PRIx64 instead.
>
Got it!
Thanks :)

> Thanks
> 
> Eric
> > +                (request_flags == IOMMU_NOTIFIER_MAP) ?
> > +                "Mapping" : "Unmapping",
> > +                entry->iova, entry->iova + entry->addr_mask,
> > +                notifier->start, notifier->end);
> > +    }
> > +
> >      if (notifier->notifier_flags & request_flags) {
> >          notifier->notify(notifier, entry);
> >      }
> > 

