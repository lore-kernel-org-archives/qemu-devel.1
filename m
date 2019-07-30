Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD854C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7B920693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7B920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsYLB-0004Uo-Pl
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 16:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33851)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsYKW-000453-PI
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsYKV-0005yV-BJ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:02:40 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsYKV-0005yP-4e
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:02:39 -0400
Received: by mail-vs1-f65.google.com with SMTP id k9so44462446vso.5
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 13:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0tAGh8WbUyfrjkFxtAUTtslhB54Cbr6M2sodD2yaUxY=;
 b=sWUlVdSVuWEsBSiIPBSzwvAXfP2ONFvvq+89Ucyj4fCnG9x87qRDvpVDusgh/vEpMm
 uqL32Zbf+AGF0sRDB4iwctowBMXsItbDLsRNE/xMasaoNJxZaE8qF9zIwiHp11q08sAr
 XaLh53x1ZyKcD5uNgPHBkiwDssRaeVUlo/XUWiGzrZ/JaDvs26vyRqkg0IT4k49NbWIF
 o5/DyqdApul2CfaC0ozKYOYAkjYT7Gcq/7TjcqPZZxB7Kz7RfdtKHgdSr4NVRhgF+bsa
 f/ZZBsz563NY33F6jCgtdTS0JrRhRD8lN9XvsnHOD3uuS6lZkZynhFD8ru1VW6p2Mp3I
 3uhA==
X-Gm-Message-State: APjAAAV8OFwWHytIZx4/ip6C6Pc21s6MFYTtywpPVRI4HsRCLh0oqr93
 Fb1YS6G2ovZ1Y4fa/hc92v2LEg==
X-Google-Smtp-Source: APXvYqyoJbdR6pKDRqWowmaNJiUeMd6a4mB4uEQsXlOfe1hF/iRdjVc41MJTdH67fQ4oXDpg1bs4QA==
X-Received: by 2002:a05:6102:2008:: with SMTP id
 p8mr76003498vsr.188.1564516958466; 
 Tue, 30 Jul 2019 13:02:38 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 d134sm14916855vsc.26.2019.07.30.13.02.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 13:02:37 -0700 (PDT)
Date: Tue, 30 Jul 2019 16:02:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190730155128-mutt-send-email-mst@kernel.org>
References: <20190729125755.45008-1-slp@redhat.com>
 <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
 <20190730133546.056f8b19.cohuck@redhat.com>
 <09e5ceb5e7c03f74f05307a3b9f9a4df035ff74f.camel@redhat.com>
 <20190730151400.20686a5b.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730151400.20686a5b.cohuck@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.217.65
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, Andrea Bolognani <abologna@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 03:14:00PM +0200, Cornelia Huck wrote:
> On Tue, 30 Jul 2019 14:17:48 +0200
> Andrea Bolognani <abologna@redhat.com> wrote:
> 
> > On Tue, 2019-07-30 at 13:35 +0200, Cornelia Huck wrote:
> > > On Tue, 30 Jul 2019 12:25:30 +0200
> > > Andrea Bolognani <abologna@redhat.com> wrote:  
> > > > Can you please make sure virtio-mmio uses the existing interface
> > > > instead of introducing a new one?  
> > > 
> > > FWIW, I really hate virtio-pci's disable-modern/disable-legacy... for a
> > > starter, what is 'modern'? Will we have 'ultra-modern' in the future?  
> > 
> > AIUI the modern/legacy terminology is part of the VirtIO spec, so
> > while I agree that it's not necessarily the least prone to ambiguity
> > at least it's well defined.
> 
> Legacy is, modern isn't :) Devices/drivers are conforming to the
> standard, I don't think there's a special term for that.

Right, the best we have is "non-transitional":

	Devices or drivers with no legacy compatibility are referred to as non-transitional devices and drivers, re-
	spectively.

> > 
> > > It is also quite backwards with the 'disable' terminology.  
> > 
> > That's also true. I never claimed the way virtio-pci does it is
> > perfect!
> > 
> > > We also have a different mechanism for virtio-ccw ('max_revision',
> > > which covers a bit more than virtio-1; it doesn't have a 'min_revision',
> > > as negotiating the revision down is fine), so I don't see why
> > > virtio-mmio should replicate the virtio-pci mechanism.
> > > 
> > > Also, IIUC, virtio-mmio does not have transitional devices, but either
> > > version 1 (legacy) or version 2 (virtio-1). It probably makes more
> > > sense to expose the device version instead; either as an exact version
> > > (especially if it isn't supposed to go up without incompatible
> > > changes), or with some min/max concept (where version 1 would stand a
> > > bit alone, so that would probably be a bit awkward.)  
> > 
> > I think that if reinventing the wheel is generally agreed not to be
> > a good idea, then it stands to reason that reinventing it twice can
> > only be described as absolute madness :)
> > 
> > We should have a single way to control the VirtIO protocol version
> > that works for all VirtIO devices, regardless of transport. We might
> > even want to have virtio-*-{device,ccw}-non-transitional to mirror
> > the existing virtio-*-pci-non-transitional.
> > 
> > FWIW, libvirt already implements support for (non)-transitional
> > virtio-pci devices using either the dedicated devices or the base
> > virtio-pci plus the disable-{modern,legacy} attributes.
> 
> One problem (besides my dislike of the existing virtio-pci
> interfaces :) is that pci, ccw, and mmio all have slightly different
> semantics.
> 
> - pci: If we need to keep legacy support around, we cannot enable some
>   features (IIRC, pci-e, maybe others as well.)
>	 That means transitional
>   devices are in some ways inferior to virtio-1 only devices, so it
>   makes a lot of sense to be able to configure devices without legacy
>   support.

That's not coming from the spec though. You can put a transitional
device on pci-e, in some configurations legacy guests will fail to boot
but modern ones will always work.

QEMU made modern a requirement for pcie to simplify things, such
that you can always be sure transitional supports a legacy guest.
We can relax that if we like.

> The differences between legacy and virtio-1 are quite large.
>
> - ccw: Has revisions negotiated between device and driver; virtio-1
>   requires revision 1 or higher. (Legacy drivers that don't know the
>   concept of revisions automatically get revision 0.) Differences
>   between legacy and virtio-1 are mostly virtqueue endianness and some
>   control structures.
> - mmio: Has device versions offered by the device, the driver can take
>   it or leave it. No transitional devices. Differences don't look as
>   large as the ones for pci, either.
> 
> So, if we were to duplicate the same scheme as for pci for ccw and mmio
> as well, we'd get
> 
> - ccw: devices that support revision 0 only (disable-modern), that act
>   as today, or that support at least revision 1 (disable-legacy). We
>   still need to keep max_revision around for backwards compatibility.
>   Legacy only makes sense for compat machines (although this is
>   equivalent to max_revision 0); I don't see a reason why you would
>   want virtio-1 only devices, unless you'd want to rip out legacy
>   support in QEMU completely.
> - mmio: devices that support version 1 (disable-modern), or version 2
>   (disable-legacy). You cannot have both at the same time. Whether this
>   makes sense depends on whether there will be a version 3 in the
>   future.

Told you so ;) When the TC approved the decision not to
have transitional support I tried to complain but
enough people felt there will be more devices/drivers in the
future than in the past, so we should not worry too much.

Here we are, lots of time passed and now MMIO is held
back from even offering virtio 1 by default because
people want to run legacy guests and no one has the
energy to upgrade legacy drivers.

I don't think we'll repeat the mistake again though,
so I don't really expect another incompatible upgrade.

> So, this might make some sense for mmio; for ccw, I don't see any
> advantages other than confusing people further...

