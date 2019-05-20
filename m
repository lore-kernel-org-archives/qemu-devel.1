Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33812C04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 01:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A2620815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 01:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1hcWFru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A2620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56007 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSX7F-0000vN-Te
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 21:29:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hSX6K-0000Xo-JX
	for qemu-devel@nongnu.org; Sun, 19 May 2019 21:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hSX6I-0003Gv-OR
	for qemu-devel@nongnu.org; Sun, 19 May 2019 21:28:28 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>)
	id 1hSX6H-0003GE-Ok; Sun, 19 May 2019 21:28:26 -0400
Received: by mail-oi1-x242.google.com with SMTP id t187so8780433oie.10;
	Sun, 19 May 2019 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=iwd3H7j1Rkw3fNfho1CBYGCEkGb8ak8eTd6zR2yanWM=;
	b=h1hcWFru1pTUyDOYnF5ELVqLUsQFgUaG3DAa66KhMCwfJRhrbD8h0R2l0cu3Fy+u4F
	rhzHm/QZI3KuNuxmZR/n2NBFzSE2Rh0GYUh8y5sLNfIqoB+Oh1RHva8/7X+vaw7SWPQR
	pbpuEqNuyMivoZdixiaMiZ4oooU2R01ZfS6Yo8+kn6aaIWyiYTZmovz3MSAt9nM7As2f
	tFT7xOhjhb4MhlYU3IPH9F1CKSwAg0EtGhZeZFO120uMB/ex+HSz9iiAQmS7zoB57L7p
	IIeqQa2hVIVLJHl2wbrkR9US5Xar9sOLBsAP2b36IDmrna7HisIVM6qlYe07EyGRP6Y2
	nGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=iwd3H7j1Rkw3fNfho1CBYGCEkGb8ak8eTd6zR2yanWM=;
	b=oDpj1/d8rUCZdDnoR2sKcSz7S3iJkRonD8ScoOM5iGf+IrfM6VKzNeNwNHBKIttkmw
	ZU/5XvMc3oqYN7FQ7E9hxkjKjrPC4en15zaJXhnxNXPSVnJi14hdqTJd/LzqSP+8izi8
	8OXmWUN0NwyoYKpSorzR+7pdho0fUnz0744rtcjNa7edLAeY6/okMaqXelUefjbxbmcy
	uLJQy9aNgWTnwAIF5424yON4vbHbVFSK0xrQuISeUtFL4y2ctJb2ZIwvjn42cy91qfMn
	QVsBC++WNFrOhDwz4ew9eulJe14e38FAKgwAYWRuhNyNH8kMqGA4CMWDhQVlqIG8gQ4X
	IUbA==
X-Gm-Message-State: APjAAAWkbyRmnQ7/78hfPt+//d3zHZxtznQqXVAdlOEDBUeFb1glyH5J
	ui6ox/BWPN1bZO5OIQW7bjHWlPo0zR7qHhvSAZU=
X-Google-Smtp-Source: APXvYqzA68gsO/rd6NA6hNLuIUxSUhAz507RHNesga+3O8CzHW1Da5lg0v7sr6TdWL/Gf0bS/BL5KdCyCbpVAB1iseE=
X-Received: by 2002:aca:fc43:: with SMTP id a64mr1587143oii.129.1558315703318; 
	Sun, 19 May 2019 18:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190518032811.60341-1-liq3ea@163.com>
	<20190518081830.5adab426@x1.home>
In-Reply-To: <20190518081830.5adab426@x1.home>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 20 May 2019 09:27:47 +0800
Message-ID: <CAKXe6SK=Uw7ZNPDvWHFoTHynFsOrEDcAK-+p2ft7YMpo86uC+A@mail.gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/4] vfio: pci: make "vfio-pci-nohotplug"
 as MACRO
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-trivial@nongnu.org, Li Qiang <liq3ea@163.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Williamson <alex.williamson@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=9C=
=8818=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8810:18=E5=86=99=E9=81=93=
=EF=BC=9A

> On Fri, 17 May 2019 20:28:08 -0700
> Li Qiang <liq3ea@163.com> wrote:
>
> Why?  (No commit message, nor cover letter)
>
>
Once I think these are trivial so no cover letter and lack some commit
message.
I will add some commit message in the next revision.

For this patch, this is more consistent with QOMConventions:
-->https://wiki.qemu.org/Documentation/QOMConventions

Thanks,
Li Qiang


> > CC: qemu-trivial@nongnu.org
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  hw/vfio/pci.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 8cecb53d5c..08729e5875 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -40,6 +40,8 @@
> >  #define TYPE_VFIO_PCI "vfio-pci"
> >  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PC=
I)
> >
> > +#define TYPE_VIFO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> > +
> >  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
> >  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
> >
> > @@ -3304,8 +3306,8 @@ static void
> vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
> >  }
> >
> >  static const TypeInfo vfio_pci_nohotplug_dev_info =3D {
> > -    .name =3D "vfio-pci-nohotplug",
> > -    .parent =3D "vfio-pci",
> > +    .name =3D TYPE_VIFO_PCI_NOHOTPLUG,
> > +    .parent =3D TYPE_VFIO_PCI,
> >      .instance_size =3D sizeof(VFIOPCIDevice),
> >      .class_init =3D vfio_pci_nohotplug_dev_class_init,
> >  };
>
>
