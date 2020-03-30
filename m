Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E4C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8E420714
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8E420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ09A-0006Og-IX
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 15:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJ08E-0005j4-Ti
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJ08D-0008Tr-Sz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:31:34 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJ08B-0008PH-Dr; Mon, 30 Mar 2020 15:31:31 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 05265BF720;
 Mon, 30 Mar 2020 19:31:27 +0000 (UTC)
Date: Mon, 30 Mar 2020 21:31:24 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RESEND v4] nvme: introduce PMR support from NVMe 1.4 spec
Message-ID: <20200330193124.axnelhsheec6ilw3@apples.localdomain>
References: <20200330164656.9348-1-andrzej.jakowski@linux.intel.com>
 <20200330165518.GA8234@redsun51.ssa.fujisawa.hgst.com>
 <20200330180732.towfrznvxovggzqk@apples.localdomain>
 <20200330181326.GA18238@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330181326.GA18238@redsun51.ssa.fujisawa.hgst.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: kwolf@redhat.com, haozhong.zhang@intel.com, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, yi.z.zhang@linux.intel.com, junyan.he@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mar 31 03:13, Keith Busch wrote:
> On Mon, Mar 30, 2020 at 08:07:32PM +0200, Klaus Birkelund Jensen wrote:
> > On Mar 31 01:55, Keith Busch wrote:
> > > On Mon, Mar 30, 2020 at 09:46:56AM -0700, Andrzej Jakowski wrote:
> > > > This patch introduces support for PMR that has been defined as part of NVMe 1.4
> > > > spec. User can now specify a pmrdev option that should point to HostMemoryBackend.
> > > > pmrdev memory region will subsequently be exposed as PCI BAR 2 in emulated NVMe
> > > > device. Guest OS can perform mmio read and writes to the PMR region that will stay
> > > > persistent across system reboot.
> > > 
> > > Looks pretty good to me.
> > > 
> > > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > > 
> > > For a possible future extention, it could be interesting to select the
> > > BAR for PMR dynamically, so that you could have CMB and PMR enabled on
> > > the same device.
> > > 
> > 
> > I thought about the same thing, but this would require disabling MSI-X
> > right? Otherwise there is not enough room. AFAIU, the iomem takes up
> > BAR0 and BAR1, CMB (or PMR) uses BAR2 and BAR3 and MSI-X uses BAR4 or 5.
> 
> That's the way the emulated device is currently set, but there's no
> reason for CMB or MSIx to use an exlusive bar. Both of those can be
> be offsets into BAR 0/1, for example. PMR is the only one that can't
> share.
> 

Oh, I did not consider that at all. Thanks!

