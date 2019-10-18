Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BF6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72BD20663
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72BD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVGD-0004La-Sv
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iLVFL-0003iA-1D
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iLVFJ-0003ag-Qx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:36:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iLVFJ-0003Zp-Hh
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:36:57 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2FC2C7FDFA
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 16:36:56 +0000 (UTC)
Received: by mail-oi1-f199.google.com with SMTP id r67so3525733oif.18
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LBwqDq2Dfi8/fiiAuID7RbJbgMcQBilq2FJMHLHi0VU=;
 b=kUGS648K4ONEUkjYFdV/ph34Ru63dYf1kuxZh0xsPduIA9i7kjk3XuDIRwTKTdYS48
 vi/XoTXn9m+dnyZ6j1K1sY58e5Y/ecIDX0EYIrUipsEDyDRIoDFiUU/bNdOlgJQOyJtM
 WQ7MDlfatPUhchzPQ1ZlzXgH2fszmwi0g9fDntLiW0jCXfopovbePDzUP84DJfadBP5C
 dnGe53L41g3VLBoxgm17zaInpl/qWHS9SWHedhC/7n24MqrN646C3FQ7pWlkh9OMy5fD
 2iwYBMYA4Daad2oRd5p2IO+3d8jLIwXri/sbYGEEoDbFVs3QI7AWMx4e9uEKStjOkbNC
 GaSg==
X-Gm-Message-State: APjAAAXMDb3NntARddwNWPnBovdya4foYw5jWGBD20TmWCG43lKgk/PF
 QV61M4hxUzKIVqZboMc2iBizcpvExiDKz+Ooz0WYQpxPMcvGqkUBFOcLGkJLzyDjWp1WrC1NQo+
 kxnHRekySlvXq+FRIBpZ/toOzs8F4trc=
X-Received: by 2002:aca:f356:: with SMTP id r83mr8512340oih.13.1571416615568; 
 Fri, 18 Oct 2019 09:36:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxR7QpRkBusWC5sU+Cpy5bpx7AWpM7fbTfn8n566TYuUPBEFxG1JhStYq3Srd5pbo+qV8rc0DhdkEHesWQLSB4=
X-Received: by 2002:aca:f356:: with SMTP id r83mr8512290oih.13.1571416615150; 
 Fri, 18 Oct 2019 09:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-2-marcandre.lureau@redhat.com>
 <CAFEAcA_7zxe6YfM6c8v_SQ+qh2L7Q5RS_xEPvy01q9aPZ6YyiQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_7zxe6YfM6c8v_SQ+qh2L7Q5RS_xEPvy01q9aPZ6YyiQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 18 Oct 2019 18:36:43 +0200
Message-ID: <CAMxuvaw2CMqOuGXVq4Gk+GDNrjq++Ho+460WN9yo-pJFPVZhjw@mail.gmail.com>
Subject: Re: [PATCH 01/14] sm501: replace PROP_PTR with PROP_LINK
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Oct 18, 2019 at 6:22 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Fri, 18 Oct 2019 at 16:42, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/display/sm501.c | 5 +++--
> >  hw/sh4/r2d.c       | 3 ++-
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> > index 1f33c87e65..a87d18efab 100644
> > --- a/hw/display/sm501.c
> > +++ b/hw/display/sm501.c
> > @@ -1930,7 +1930,7 @@ typedef struct {
> >      SM501State state;
> >      uint32_t vram_size;
> >      uint32_t base;
> > -    void *chr_state;
> > +    Chardev *chr_state;
> >  } SM501SysBusState;
> >
> >  static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
> > @@ -1968,7 +1968,8 @@ static void sm501_realize_sysbus(DeviceState *dev=
, Error **errp)
> >  static Property sm501_sysbus_properties[] =3D {
> >      DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
> >      DEFINE_PROP_UINT32("base", SM501SysBusState, base, 0),
> > -    DEFINE_PROP_PTR("chr-state", SM501SysBusState, chr_state),
> > +    DEFINE_PROP_LINK("chr-state", SM501SysBusState, chr_state,
> > +                     TYPE_CHARDEV, Chardev *),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> > index ee0840f380..5780ee85d9 100644
> > --- a/hw/sh4/r2d.c
> > +++ b/hw/sh4/r2d.c
> > @@ -272,7 +272,8 @@ static void r2d_init(MachineState *machine)
> >      busdev =3D SYS_BUS_DEVICE(dev);
> >      qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
> >      qdev_prop_set_uint32(dev, "base", 0x10000000);
> > -    qdev_prop_set_ptr(dev, "chr-state", serial_hd(2));
> > +    object_property_set_link(OBJECT(dev), OBJECT(serial_hd(2)),
> > +                             "chr-state", &error_abort);
> >      qdev_init_nofail(dev);
> >      sysbus_mmio_map(busdev, 0, 0x10000000);
> >      sysbus_mmio_map(busdev, 1, 0x13e00000);
>
> We have a typed way of passing a Chardev to devices:
> use qdev_prop_set_chr(). Unfortunately it's not trivially
> easy to drop in here, because it sets a property defined
> with DEFINE_PROP_CHR to set a field of type CharBackend
> (note, not Chardev, and not a pointer) in the device struct.
> But serial_mm_init() wants a Chardev*, because it is a
> non-QOM interface to the serial device and is manually
> doing the qemu_chr_fe_init() that connects the Chardev
> to its own CharBackend. The QOM CHR property setter wants
> to do that qemu_chr_fe_init() itself.
>
> So I think the right fix here is to properly QOMify the
> code which is not QOMified, ie hw/char/serial.c, in a
> way that means that the various "memory mapped 16650-ish
> devices" we have can use it and can define a
> TYPE_CHARDEV property.

I see, I can look at that.

> In general I think our uses of PROP_PTR are code smells
> that indicate places where we have not properly converted
> code over to the general approach that the QOM/qdev
> design desires; but we should be getting rid of PROP_PTR
> by actually doing all those (difficult) conversions.

I think all user_creatable =3D false are smelly in that regard.

> Merely removing PROP_PTR itself by rephrasing the dubious
> inter-device connections in a way that makes them harder
> to grep for doesn't seem to me to be necessarily worth

grep for user_creatable =3D false

> doing. Is the existence of PROP_PTR getting in your way
> for a change you want to make ?

Yes, I am looking at improving the qdev vs object and class vs
instance properties. I have a larger series of wip refactoring. This
initial series is preliminary cleanup that would help.

