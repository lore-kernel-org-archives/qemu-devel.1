Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27051C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A89206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A89206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hstvy-0002v3-1D
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 15:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hstvZ-0002Rh-0B
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hstvX-0008C3-Fw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:06:20 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:42879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hstvX-00089p-BF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:06:19 -0400
Received: by mail-vs1-f49.google.com with SMTP id 190so46983432vsf.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 12:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ISm95VmXnJ4r8KGbd3EH5/GEST2Z7jYB0wYOVqFnTL8=;
 b=CVpsjOoMpdzhHcDYkF5vOgqQesqQdQLqHxfsn7b2Zj5QR5DbB08FINX53RM8Xk7Ihl
 NUVYmZ9/GmJaf85J34Pr4KUPmUoKjcGC+LU27/pFnijP+jIVE23OaOXpjLmCbJ21pUYA
 Vy1KliY51LkoXK3pJkh/hFEWEjkp2zfPmD56960veXe2novMjUsMuxjRlFrmwC2t7xvO
 k9JIai5cDXtLi42qChNxm729RE/kANWUTcg9ycFZqIyd84OQFVf7Iyh7mFk6jQWetKJf
 3xgH2SEdfGXAhKIpKPemaWp+bPOaM/erbOXGSHnwQ4vx5gjqhgooJLAhx5Li6aFHNsMH
 YUPA==
X-Gm-Message-State: APjAAAXJmB0sIFmqzdimtjgaX0GNnnEIU95M7VTLoTm8OyjYT084X6kV
 1Yf5HZiyswXnsP1STE4I87HhPQ==
X-Google-Smtp-Source: APXvYqw9wUyQ1JSagfNVg5Bray26+wJK2FKWWFpBA47OdoO0IJQtbwefD2LKox7HZRpRDdNR4wDaVA==
X-Received: by 2002:a67:d58a:: with SMTP id m10mr81867909vsj.15.1564599977827; 
 Wed, 31 Jul 2019 12:06:17 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 w9sm31146642vkd.41.2019.07.31.12.06.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 12:06:16 -0700 (PDT)
Date: Wed, 31 Jul 2019 15:06:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190731150448-mutt-send-email-mst@kernel.org>
References: <20190729125755.45008-1-slp@redhat.com>
 <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
 <20190730133546.056f8b19.cohuck@redhat.com>
 <09e5ceb5e7c03f74f05307a3b9f9a4df035ff74f.camel@redhat.com>
 <20190730151400.20686a5b.cohuck@redhat.com>
 <20190730160605-mutt-send-email-mst@kernel.org>
 <20190731155551.4bb57ec3.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731155551.4bb57ec3.cohuck@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.217.49
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

On Wed, Jul 31, 2019 at 03:55:51PM +0200, Cornelia Huck wrote:
> On Tue, 30 Jul 2019 16:18:52 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Jul 30, 2019 at 03:14:00PM +0200, Cornelia Huck wrote:
> > > On Tue, 30 Jul 2019 14:17:48 +0200
> > > Andrea Bolognani <abologna@redhat.com> wrote:
> > >   
> > > > On Tue, 2019-07-30 at 13:35 +0200, Cornelia Huck wrote:  
> > > > > On Tue, 30 Jul 2019 12:25:30 +0200
> > > > > Andrea Bolognani <abologna@redhat.com> wrote:    
> > > > > > Can you please make sure virtio-mmio uses the existing interface
> > > > > > instead of introducing a new one?    
> > > > > 
> > > > > FWIW, I really hate virtio-pci's disable-modern/disable-legacy... for a
> > > > > starter, what is 'modern'? Will we have 'ultra-modern' in the future?    
> > > > 
> > > > AIUI the modern/legacy terminology is part of the VirtIO spec, so
> > > > while I agree that it's not necessarily the least prone to ambiguity
> > > > at least it's well defined.  
> > > 
> > > Legacy is, modern isn't :) Devices/drivers are conforming to the
> > > standard, I don't think there's a special term for that.  
> > 
> > Right, if we followed the spec, disable-modern would have been
> > force-legacy.
> > 
> > I'm fine with adding force-legacy for everyone and asking tools to
> > transition if there. Document it's same as disable-modern for pci.
> > Cornelia?
> 
> 'force-legacy' is certainly better than 'disable-modern'. Not sure if
> it's much of a gain at this point in time, and it does not really add
> anything over limiting the revision to 0 for ccw, but I don't really
> object to it.
> 
> > 
> > 
> > > >   
> > > > > It is also quite backwards with the 'disable' terminology.    
> > > > 
> > > > That's also true. I never claimed the way virtio-pci does it is
> > > > perfect!
> > > >   
> > > > > We also have a different mechanism for virtio-ccw ('max_revision',
> > > > > which covers a bit more than virtio-1; it doesn't have a 'min_revision',
> > > > > as negotiating the revision down is fine), so I don't see why
> > > > > virtio-mmio should replicate the virtio-pci mechanism.
> > > > > 
> > > > > Also, IIUC, virtio-mmio does not have transitional devices, but either
> > > > > version 1 (legacy) or version 2 (virtio-1). It probably makes more
> > > > > sense to expose the device version instead; either as an exact version
> > > > > (especially if it isn't supposed to go up without incompatible
> > > > > changes), or with some min/max concept (where version 1 would stand a
> > > > > bit alone, so that would probably be a bit awkward.)    
> > > > 
> > > > I think that if reinventing the wheel is generally agreed not to be
> > > > a good idea, then it stands to reason that reinventing it twice can
> > > > only be described as absolute madness :)
> > > > 
> > > > We should have a single way to control the VirtIO protocol version
> > > > that works for all VirtIO devices, regardless of transport. We might
> > > > even want to have virtio-*-{device,ccw}-non-transitional to mirror
> > > > the existing virtio-*-pci-non-transitional.
> > > > 
> > > > FWIW, libvirt already implements support for (non)-transitional
> > > > virtio-pci devices using either the dedicated devices or the base
> > > > virtio-pci plus the disable-{modern,legacy} attributes.  
> > > 
> > > One problem (besides my dislike of the existing virtio-pci
> > > interfaces :) is that pci, ccw, and mmio all have slightly different
> > > semantics.
> > > 
> > > - pci: If we need to keep legacy support around, we cannot enable some
> > >   features (IIRC, pci-e, maybe others as well.) That means transitional
> > >   devices are in some ways inferior to virtio-1 only devices, so it
> > >   makes a lot of sense to be able to configure devices without legacy
> > >   support. The differences between legacy and virtio-1 are quite large.
> > > - ccw: Has revisions negotiated between device and driver; virtio-1
> > >   requires revision 1 or higher. (Legacy drivers that don't know the
> > >   concept of revisions automatically get revision 0.) Differences
> > >   between legacy and virtio-1 are mostly virtqueue endianness and some
> > >   control structures.
> > > - mmio: Has device versions offered by the device, the driver can take
> > >   it or leave it. No transitional devices. Differences don't look as
> > >   large as the ones for pci, either.
> > > 
> > > So, if we were to duplicate the same scheme as for pci for ccw and mmio
> > > as well, we'd get
> > > 
> > > - ccw: devices that support revision 0 only (disable-modern), that act
> > >   as today, or that support at least revision 1 (disable-legacy). We
> > >   still need to keep max_revision around for backwards compatibility.
> > >   Legacy only makes sense for compat machines (although this is
> > >   equivalent to max_revision 0); I don't see a reason why you would
> > >   want virtio-1 only devices, unless you'd want to rip out legacy
> > >   support in QEMU completely.  
> > 
> > Reduce security attack surface slightly. Save some cycles
> > (down the road) on branches in the endian-ness handling.
> 
> Most of that stuff is actually in the core code, right? Ripping out
> legacy will have much more impact outside of ccw, I guess.
> 
> > Make sure your guests
> > are all up to date in preparation to the day when legacy will go away.
> 
> If legacy goes away, legacy guests will be busted anyway :)

It'll take a while for it to go away. But we can try to
push guests in the direction of coding up modern
support e.g. by forcing modern by default.

> (There should not be many, if any, of these -- ccw switched on virtio-1
> by default quite some time ago, and the s390x legacy virtio transport
> was s390-virtio anyway :)
> 
> > 
> > Not a huge win, for sure, but hey - it's something.
> > 
> > > - mmio: devices that support version 1 (disable-modern), or version 2
> > >   (disable-legacy). You cannot have both at the same time. Whether this
> > >   makes sense depends on whether there will be a version 3 in the
> > >   future.
> > > 
> > > So, this might make some sense for mmio; for ccw, I don't see any
> > > advantages other than confusing people further...  

