Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4D1C32757
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B208920665
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B208920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxx0b-0005MC-TQ
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 13:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1hxwzB-00042W-80
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1hxwz9-0001w3-6j
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:22:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1hxwz8-0001u5-VT
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:22:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id n19so11497702lfe.13
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 10:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a3YCWsIB+5v4k3YDEG/qqRU0o2uKGiRs93/X06JJfaE=;
 b=Z9HTfVEwdvD8F9pdOdpdD2EQzIiYq4Qouq9P4y5J5zjvffa/fYtUCVWD2GJZoMH073
 yHT+uOmuGi1WmUWhRmir2qhEtajwwtCDMEhVG/7UREY3e/3rj+99MAbShF22Ymctm8Qc
 gP1osl7Rgdf9CV97zfSHKenlgxTgjWgdTAkg4knLI3eX3TWWM1nWCN31tkmiz7Dy8Qw+
 rzxMc110LcY2LMq3XYrOI01Ipb13wGN6akNuKJ3HBI2HvFrMfxfPOvmTWzhb0Nq+yFmA
 6xdLXjeTF8nk3EA+c0EEJp2OZSTmMowDNwhSHGHdGLWyNm38ccvKGssC1zpLNDuAudKI
 cz9w==
X-Gm-Message-State: APjAAAXp5MRXrQ1Ee7hH05mYUc1r+2OuEXsZK9tV6QMF6B8oqQUci+Gv
 ZbEaqE1m36cp4S4oR8uPQqpExWowKCo3BJyI/8U0iA==
X-Google-Smtp-Source: APXvYqwRqNkJRKjeRdC0fHAwyrd6XRoQL5uXdtvupo9pcOTWL4M2iKGRZDaa3BCDN6bMVRiloGCJMaMPD4Ntgnk8AUo=
X-Received: by 2002:ac2:4562:: with SMTP id k2mr274007lfm.82.1565803372363;
 Wed, 14 Aug 2019 10:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190807082241.23984-1-jusual@redhat.com>
 <20190809123341-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190809123341-mutt-send-email-mst@kernel.org>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 14 Aug 2019 19:22:41 +0200
Message-ID: <CAMDeoFUhr9T1bSokO=jhq5=2Ra04TX6K0_w4oUP1oDYCYecF9A@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.67
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Add Function Level Reset
 support
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 9, 2019 at 6:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Aug 07, 2019 at 10:22:41AM +0200, Julia Suvorova wrote:
> > Using FLR becomes convenient in cases where resetting the bus is
> > impractical, for example, when debugging the behavior of individual
> > functions.
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 10 ++++++++++
> >  hw/virtio/virtio-pci.h |  1 +
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index f6d2223e78..37c5d6efbc 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -599,6 +599,10 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
> >
> >      pci_default_write_config(pci_dev, address, val, len);
> >
> > +    if (proxy->has_flr) {
> > +        pcie_cap_flr_write_config(pci_dev, address, val, len);
> > +    }
> > +
> >      if (range_covers_byte(address, len, PCI_COMMAND) &&
> >          !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> >          virtio_pci_stop_ioeventfd(proxy);
> > @@ -1718,6 +1722,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
> >      proxy->notify_pio.size = 0x4;
> >      proxy->notify_pio.type = VIRTIO_PCI_CAP_NOTIFY_CFG;
> >
> > +    proxy->has_flr = false;
> > +
> >      /* subclasses can enforce modern, so do this unconditionally */
> >      memory_region_init(&proxy->modern_bar, OBJECT(proxy), "virtio-pci",
> >                         /* PCI BAR regions must be powers of 2 */
> > @@ -1749,6 +1755,10 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
> >
> >          pci_dev->exp.pm_cap = pos;
> >
> > +        /* Set Function Level Reset capability bit */
> > +        pcie_cap_flr_init(pci_dev);
> > +        proxy->has_flr = true;
> > +
> >          /*
> >           * Indicates that this function complies with revision 1.2 of the
> >           * PCI Power Management Interface Specification.
>
>
> I don't think we can set this for everyone: this will break
> things like cross version migration.

I see. If I add a flag and a property, which version of hw_compat should I use?

Best regards, Julia Suvorova.

