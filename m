Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98C2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 06:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9F62073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 06:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9F62073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIo9l-0003Qn-J7
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 02:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jIo9A-0002ox-3Z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 02:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jIo98-0007A1-7j
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 02:43:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:46064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jIo97-000750-RA
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 02:43:42 -0400
IronPort-SDR: tHqRPtNi5UA36DNRdnuZBEOby20ck38oCSbLi249xs83DsRWUvPggvMgAbVL703kUdvs13tfmp
 rp6v0rULjOuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 23:43:36 -0700
IronPort-SDR: XxlMa3UiUsMlNJGoCbXU1S4FxtuLIgEwdkc+6Nrk2B94h7VNVTmJ1clysoTaWLVjJ9dche0k7X
 iSy3JRrDJO8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,323,1580803200"; d="scan'208";a="251793967"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga006.jf.intel.com with ESMTP; 29 Mar 2020 23:43:35 -0700
Date: Mon, 30 Mar 2020 02:34:02 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] hw/vfio: let readonly flag take effect for mmaped regions
Message-ID: <20200330063402.GE30683@joy-OptiPlex-7040>
References: <20200327111934.71066-1-yan.y.zhao@intel.com>
 <20200327112537.2efd65ac@w520.home>
 <20200330013527.GA30683@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330013527.GA30683@joy-OptiPlex-7040>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.65
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Zeng,
 Xin" <xin.zeng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 09:35:27AM +0800, Yan Zhao wrote:
> On Sat, Mar 28, 2020 at 01:25:37AM +0800, Alex Williamson wrote:
> > On Fri, 27 Mar 2020 11:19:34 +0000
> > yan.y.zhao@intel.com wrote:
> > 
> > > From: Yan Zhao <yan.y.zhao@intel.com>
> > > 
> > > currently, vfio regions without VFIO_REGION_INFO_FLAG_WRITE are only
> > > read-only when VFIO_REGION_INFO_FLAG_MMAP is not set.
> > > 
> > > regions with flag VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_MMAP
> > > are only read-only in host page table for qemu.
> > > 
> > > This patch sets corresponding ept page entries read-only for regions
> > > with flag VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_MMAP.
> > > 
> > > accordingly, it ignores guest write when guest writes to the read-only
> > > regions are trapped.
> > > 
> > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > > Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> > > ---
> > 
> > Currently we set the r/w protection on the mmap, do I understand
> > correctly that the change in the vfio code below results in KVM exiting
> > to QEMU to handle a write to a read-only region and therefore we need
> > the memory.c change to drop the write?  This prevents a SIGBUS or
> > similar?
> yes, correct. the change in memory.c is to prevent a SIGSEGV in host as
> it's mmaped to read-only. we think it's better to just drop the writes
> from guest rather than corrupt the qemu.
> 
> > 
> > Meanwhile vfio_region_setup() uses the same vfio_region_ops for all
> > regions and vfio_region_write() would still allow writes, so if the
> > device were using x-no-mmap=on, I think we'd still get a write to this
> > region and expect the vfio device to drop it.  Should we prevent that
> > write in QEMU as well?
> yes, it expects vfio device to drop it right now.
> As the driver sets the flag without VFIO_REGION_INFO_FLAG_WRITE, it should
> handle it properly.
> both dropping in qemu and dropping in vfio device are fine to us.
> we wonder which one is your preference :)
>
> 
> > Can you also identify what device and region requires this so that we
> > can decide whether this is QEMU 5.0 or 5.1 material?  PCI BARs are of
> > course always R/W and the ROM uses different ops and doesn't support
> > mmap, so this is a device specific region of some sort.  Thanks,
> > 
> It's a virtual mdev device for which we want to emulate a virtual
> read-only MMIO BAR.
> Is there any consideration that PCI BARs have to be R/W ?
> we didn't find it out in PCI specification.
> 
>
looks MMIO regions in vfio platform are also possible to be read-only and
mmaped.

Thanks
Yan

> 
> > 
> > >  hw/vfio/common.c | 4 ++++
> > >  memory.c         | 3 +++
> > >  2 files changed, 7 insertions(+)
> > > 
> > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > index 0b3593b3c0..e901621ca0 100644
> > > --- a/hw/vfio/common.c
> > > +++ b/hw/vfio/common.c
> > > @@ -971,6 +971,10 @@ int vfio_region_mmap(VFIORegion *region)
> > >                                            name, region->mmaps[i].size,
> > >                                            region->mmaps[i].mmap);
> > >          g_free(name);
> > > +
> > > +        if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
> > > +            memory_region_set_readonly(&region->mmaps[i].mem, true);
> > > +        }
> > >          memory_region_add_subregion(region->mem, region->mmaps[i].offset,
> > >                                      &region->mmaps[i].mem);
> > >  
> > > diff --git a/memory.c b/memory.c
> > > index 601b749906..4b1071dc74 100644
> > > --- a/memory.c
> > > +++ b/memory.c
> > > @@ -1313,6 +1313,9 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
> > >      MemoryRegion *mr = opaque;
> > >  
> > >      trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
> > > +    if (mr->readonly) {
> > > +        return;
> > > +    }
> > >  
> > >      switch (size) {
> > >      case 1:
> > 
> 

