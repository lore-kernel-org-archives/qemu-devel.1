Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A357AC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7959221907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7959221907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iApti-00076X-Jx
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 02:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1iApsx-0006LR-F9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1iApsv-0006km-By
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:25:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:2262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1iApsv-0006hQ-3n
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:25:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Sep 2019 23:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; d="scan'208";a="177952696"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by orsmga007.jf.intel.com with ESMTP; 18 Sep 2019 23:25:39 -0700
Date: Thu, 19 Sep 2019 02:17:56 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Jason Wang <jasowang@redhat.com>
Message-ID: <20190919061756.GB18391@joy-OptiPlex-7040>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <8302a4ae-1914-3046-b3b5-b3234d7dda02@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B1D1@SHSMSX104.ccr.corp.intel.com>
 <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B90C@SHSMSX104.ccr.corp.intel.com>
 <204219fa-ee72-ca60-52a4-fb4bbc887773@redhat.com>
 <20190919052819.GA18391@joy-OptiPlex-7040>
 <7b6d6343-33de-ebd7-9846-af54a45a82a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b6d6343-33de-ebd7-9846-af54a45a82a2@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 'Alex Williamson' <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 02:09:53PM +0800, Jason Wang wrote:
> 
> On 2019/9/19 下午1:28, Yan Zhao wrote:
> > On Thu, Sep 19, 2019 at 09:05:12AM +0800, Jason Wang wrote:
> >> On 2019/9/18 下午4:37, Tian, Kevin wrote:
> >>>> From: Jason Wang [mailto:jasowang@redhat.com]
> >>>> Sent: Wednesday, September 18, 2019 2:10 PM
> >>>>
> >>>>>> Note that the HVA to GPA mapping is not an 1:1 mapping. One HVA
> >>>> range
> >>>>>> could be mapped to several GPA ranges.
> >>>>> This is fine. Currently vfio_dma maintains IOVA->HVA mapping.
> >>>>>
> >>>>> btw under what condition HVA->GPA is not 1:1 mapping? I didn't realize it.
> >>>> I don't remember the details e.g memory region alias? And neither kvm
> >>>> nor kvm API does forbid this if my memory is correct.
> >>>>
> >>> I checked https://qemu.weilnetz.de/doc/devel/memory.html, which
> >>> provides an example of aliased layout. However, its aliasing is all
> >>> 1:1, instead of N:1. From guest p.o.v every writable GPA implies an
> >>> unique location. Why would we hit the situation where multiple
> >>> write-able GPAs are mapped to the same HVA (i.e. same physical
> >>> memory location)?
> >>
> >> I don't know, just want to say current API does not forbid this. So we
> >> probably need to take care it.
> >>
> > yes, in KVM API level, it does not forbid two slots to have the same HVA(slot->userspace_addr).
> > But
> > (1) there's only one kvm instance for each vm for each qemu process.
> > (2) all ramblock->host (corresponds to HVA and slot->userspace_addr) in one qemu
> > process is non-overlapping as it's obtained from mmmap().
> > (3) qemu ensures two kvm slots will not point to the same section of one ramblock.
> >
> > So, as long as kvm instance is not shared in two processes, and
> > there's no bug in qemu, we can assure that HVA to GPA is 1:1.
> 
> 
> Well, you leave this API for userspace, so you can't assume qemu is the 
> only user or any its behavior. If you had you should limit it in the API 
> level instead of open window for them.
> 
> 
> >
> > But even if there are two processes operating on the same kvm instance
> > and manipulating on memory slots, adding an extra GPA along side current
> > IOVA & HVA to ioctl VFIO_IOMMU_MAP_DMA can still let driver knows the
> > right IOVA->GPA mapping, right?
> 
> 
> It looks fragile. Consider HVA was mapped to both GPA1 and GPA2. Guest 
> maps IOVA to GPA2, so we have IOVA GPA2 HVA in the new ioctl and then 
> log through GPA2. If userspace is trying to sync through GPA1, it will 
> miss the dirty page. So for safety we need log both GPA1 and GPA2. (See 
> what has been done in log_write_hva() in vhost.c). The only way to do 
> that is to maintain an independent HVA to GPA mapping like what KVM or 
> vhost did.
> 
why GPA1 and GPA2 should be both dirty?
even they have the same HVA due to overlaping virtual address space in
two processes, they still correspond to two physical pages.
don't get what's your meaning :)

Thanks
Yan


> Thanks
> 
> 
> >
> > Thanks
> > Yan
> >
> >>> Is Qemu doing its own same-content memory
> >>> merging in GPA level, similar to KSM?
> >>
> >> AFAIK, it doesn't.
> >>
> >> Thanks
> >>
> >>
> >>> Thanks
> >>> Kevin
> >>
> >>

