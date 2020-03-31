Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 02:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046E220774
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 02:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046E220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ6M7-0002yA-UG
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 22:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jJ6LD-0002Y4-6s
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 22:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jJ6LA-0002e8-TR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 22:09:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:44666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jJ6LA-0002ZU-J8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 22:09:20 -0400
IronPort-SDR: MGk+vndv5ZpthB5FhDR40B8nnGfcgPXzQDcu1FalF8PJtQYsPuCzqr1Do4LhZCDuGH63AijcAS
 TaINMxF3QniA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 19:09:16 -0700
IronPort-SDR: SfD6hkA9creN0GAcIMNk+WRmik3MOlYOH/73Uw0PEqy6H8gUjFCtEILsV5h7ZDxJmiyyHZTMWt
 K7TKAYlHGFSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,326,1580803200"; d="scan'208";a="272581793"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2020 19:09:14 -0700
Date: Mon, 30 Mar 2020 21:59:41 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] hw/vfio: let readonly flag take effect for mmaped regions
Message-ID: <20200331015941.GD6631@joy-OptiPlex-7040>
References: <20200327111934.71066-1-yan.y.zhao@intel.com>
 <20200327112537.2efd65ac@w520.home>
 <20200330013527.GA30683@joy-OptiPlex-7040>
 <20200330063402.GE30683@joy-OptiPlex-7040>
 <20200330085923.19d7345f@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330085923.19d7345f@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.151
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

On Mon, Mar 30, 2020 at 10:59:23PM +0800, Alex Williamson wrote:
> On Mon, 30 Mar 2020 02:34:02 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Mon, Mar 30, 2020 at 09:35:27AM +0800, Yan Zhao wrote:
> > > On Sat, Mar 28, 2020 at 01:25:37AM +0800, Alex Williamson wrote:  
> > > > On Fri, 27 Mar 2020 11:19:34 +0000
> > > > yan.y.zhao@intel.com wrote:
> > > >   
> > > > > From: Yan Zhao <yan.y.zhao@intel.com>
> > > > > 
> > > > > currently, vfio regions without VFIO_REGION_INFO_FLAG_WRITE are only
> > > > > read-only when VFIO_REGION_INFO_FLAG_MMAP is not set.
> > > > > 
> > > > > regions with flag VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_MMAP
> > > > > are only read-only in host page table for qemu.
> > > > > 
> > > > > This patch sets corresponding ept page entries read-only for regions
> > > > > with flag VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_MMAP.
> > > > > 
> > > > > accordingly, it ignores guest write when guest writes to the read-only
> > > > > regions are trapped.
> > > > > 
> > > > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > > > > Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> > > > > ---  
> > > > 
> > > > Currently we set the r/w protection on the mmap, do I understand
> > > > correctly that the change in the vfio code below results in KVM exiting
> > > > to QEMU to handle a write to a read-only region and therefore we need
> > > > the memory.c change to drop the write?  This prevents a SIGBUS or
> > > > similar?  
> > > yes, correct. the change in memory.c is to prevent a SIGSEGV in host as
> > > it's mmaped to read-only. we think it's better to just drop the writes
> > > from guest rather than corrupt the qemu.
> > >   
> > > > 
> > > > Meanwhile vfio_region_setup() uses the same vfio_region_ops for all
> > > > regions and vfio_region_write() would still allow writes, so if the
> > > > device were using x-no-mmap=on, I think we'd still get a write to this
> > > > region and expect the vfio device to drop it.  Should we prevent that
> > > > write in QEMU as well?  
> > > yes, it expects vfio device to drop it right now.
> > > As the driver sets the flag without VFIO_REGION_INFO_FLAG_WRITE, it should
> > > handle it properly.
> > > both dropping in qemu and dropping in vfio device are fine to us.
> > > we wonder which one is your preference :)
> 
> The kernel and device should always do the right thing, we cannot rely
> on the user to honor the mapping, but it's also a reasonable response
> from the kernel to kill the process with a SIGSEGV if the user ignores
> the protections.  So I don't think it's an either/or, the kernel needs
> to do the right thing for itself and in this case QEMU should do the
> right thing for itself, which is to drop writes for regions that don't
> support it.  So in general, I agree with your patch.
>
hi Alex
so is there anything I need to do? do I need to add a write dropping in
vfio_region_write() too? if yes, do I need to keep the
trace_vfio_region_write() before dropping ?

Thanks
Yan

> > > > Can you also identify what device and region requires this so that we
> > > > can decide whether this is QEMU 5.0 or 5.1 material?  PCI BARs are of
> > > > course always R/W and the ROM uses different ops and doesn't support
> > > > mmap, so this is a device specific region of some sort.  Thanks,
> > > >   
> > > It's a virtual mdev device for which we want to emulate a virtual
> > > read-only MMIO BAR.
> > > Is there any consideration that PCI BARs have to be R/W ?
> > > we didn't find it out in PCI specification.
> 
> What the device chooses to do with writes to a BAR is its own business,
> the PCI spec shouldn't try to define that.  There's also no PCI spec
> mechanism to declare the access protections for an entire BAR, that's
> device specific behavior.  The current QEMU vfio-pci behavior is
> therefore somewhat implicit in knowing this for a directly assigned
> device.  We can mmap the device and we expect writes to unwritable
> registers within that mapping to be dropped.
> 
> For an mdev device, we can't rely on the user honoring the access
> protections, ie. the user shouldn't be able to exploit the kernel or
> device by doing so, but I also agree that QEMU, as a friendly vfio
> user, should avoid unsupported operations and protect itself from how
> the kernel may handle the fault.
> 
> Since this mdev device doesn't exist yet, I'm thinking this is QEMU
> v5.1 material though.
> 
> > looks MMIO regions in vfio platform are also possible to be read-only and
> > mmaped.
> 
> Yes.  Thanks,
> 
> Alex
> 

