Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98473C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE43206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE43206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsRyD-00037v-3Z
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45337)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hsRxH-0002e6-Jg
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hsRxE-0002Kp-LH
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hsRxD-0002KF-Nn
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:14:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 808C7368E3;
 Tue, 30 Jul 2019 13:14:10 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5459810016E8;
 Tue, 30 Jul 2019 13:14:02 +0000 (UTC)
Date: Tue, 30 Jul 2019 15:14:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Message-ID: <20190730151400.20686a5b.cohuck@redhat.com>
In-Reply-To: <09e5ceb5e7c03f74f05307a3b9f9a4df035ff74f.camel@redhat.com>
References: <20190729125755.45008-1-slp@redhat.com>
 <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
 <20190730133546.056f8b19.cohuck@redhat.com>
 <09e5ceb5e7c03f74f05307a3b9f9a4df035ff74f.camel@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 30 Jul 2019 13:14:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Sergio Lopez <slp@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 14:17:48 +0200
Andrea Bolognani <abologna@redhat.com> wrote:

> On Tue, 2019-07-30 at 13:35 +0200, Cornelia Huck wrote:
> > On Tue, 30 Jul 2019 12:25:30 +0200
> > Andrea Bolognani <abologna@redhat.com> wrote:  
> > > Can you please make sure virtio-mmio uses the existing interface
> > > instead of introducing a new one?  
> > 
> > FWIW, I really hate virtio-pci's disable-modern/disable-legacy... for a
> > starter, what is 'modern'? Will we have 'ultra-modern' in the future?  
> 
> AIUI the modern/legacy terminology is part of the VirtIO spec, so
> while I agree that it's not necessarily the least prone to ambiguity
> at least it's well defined.

Legacy is, modern isn't :) Devices/drivers are conforming to the
standard, I don't think there's a special term for that.

> 
> > It is also quite backwards with the 'disable' terminology.  
> 
> That's also true. I never claimed the way virtio-pci does it is
> perfect!
> 
> > We also have a different mechanism for virtio-ccw ('max_revision',
> > which covers a bit more than virtio-1; it doesn't have a 'min_revision',
> > as negotiating the revision down is fine), so I don't see why
> > virtio-mmio should replicate the virtio-pci mechanism.
> > 
> > Also, IIUC, virtio-mmio does not have transitional devices, but either
> > version 1 (legacy) or version 2 (virtio-1). It probably makes more
> > sense to expose the device version instead; either as an exact version
> > (especially if it isn't supposed to go up without incompatible
> > changes), or with some min/max concept (where version 1 would stand a
> > bit alone, so that would probably be a bit awkward.)  
> 
> I think that if reinventing the wheel is generally agreed not to be
> a good idea, then it stands to reason that reinventing it twice can
> only be described as absolute madness :)
> 
> We should have a single way to control the VirtIO protocol version
> that works for all VirtIO devices, regardless of transport. We might
> even want to have virtio-*-{device,ccw}-non-transitional to mirror
> the existing virtio-*-pci-non-transitional.
> 
> FWIW, libvirt already implements support for (non)-transitional
> virtio-pci devices using either the dedicated devices or the base
> virtio-pci plus the disable-{modern,legacy} attributes.

One problem (besides my dislike of the existing virtio-pci
interfaces :) is that pci, ccw, and mmio all have slightly different
semantics.

- pci: If we need to keep legacy support around, we cannot enable some
  features (IIRC, pci-e, maybe others as well.) That means transitional
  devices are in some ways inferior to virtio-1 only devices, so it
  makes a lot of sense to be able to configure devices without legacy
  support. The differences between legacy and virtio-1 are quite large.
- ccw: Has revisions negotiated between device and driver; virtio-1
  requires revision 1 or higher. (Legacy drivers that don't know the
  concept of revisions automatically get revision 0.) Differences
  between legacy and virtio-1 are mostly virtqueue endianness and some
  control structures.
- mmio: Has device versions offered by the device, the driver can take
  it or leave it. No transitional devices. Differences don't look as
  large as the ones for pci, either.

So, if we were to duplicate the same scheme as for pci for ccw and mmio
as well, we'd get

- ccw: devices that support revision 0 only (disable-modern), that act
  as today, or that support at least revision 1 (disable-legacy). We
  still need to keep max_revision around for backwards compatibility.
  Legacy only makes sense for compat machines (although this is
  equivalent to max_revision 0); I don't see a reason why you would
  want virtio-1 only devices, unless you'd want to rip out legacy
  support in QEMU completely.
- mmio: devices that support version 1 (disable-modern), or version 2
  (disable-legacy). You cannot have both at the same time. Whether this
  makes sense depends on whether there will be a version 3 in the
  future.

So, this might make some sense for mmio; for ccw, I don't see any
advantages other than confusing people further...

