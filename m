Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB71C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 19:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0C7207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7bUgr88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0C7207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZKQJ-00009P-R3
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 14:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZKL4-0005bs-Sa
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZKL2-0000Bb-7n
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:48:02 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iZKKx-00008J-14; Mon, 25 Nov 2019 14:47:55 -0500
Received: by mail-wr1-x443.google.com with SMTP id b18so19644894wrj.8;
 Mon, 25 Nov 2019 11:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LFn3Wq/YocWi8xrKaJbVjs7kex9Q3oV79IiMvxunSPQ=;
 b=t7bUgr88TRQNPIv9naN5vFwEZSJSEt2OyjOeqGCugDgkKaWXwxtSvsxVvy8Civ0ZtW
 43w4T7ecNrdpiy1U63v99xtDQO4Zdpp2C8FRSXZxHpOb426V7C+xeFCJQxDR4Vdq9i5z
 +QTvCiurQ7zHC0zWFgZAARwqslJ2DVxwuTy9Suz1oUYbosXkzTAII2MKMLwftCCu2Xxj
 mPFAzfGMb6J2Ui9b5cOS9nU+zg0hUm/FPFylW179oeDQuFydxHCExe4KNrTVR7cvbz1/
 bR6H2s/+BDCeiBj413jlRYU5oPZR+BtyRw1Tdr2qitbkiVRVv9QQFi50HaqUiKArnQ0G
 /rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LFn3Wq/YocWi8xrKaJbVjs7kex9Q3oV79IiMvxunSPQ=;
 b=DP3k7vH4vBfKWXuT8i3Vl4oBoIrpdHNfWjEMR8iHAUs/Zaeq29lYyethtV5biEotqO
 cFUCLs2NP79lqXZQTalxbSq/EFd7KMdftQdBH703QP58lbtSsYHzKrGU9lltZ349mObV
 yvtJI2mEyh+MUMBc7hDzj3Wzv+Bxy7PVm+hCir0ZfNCofJngMSxkVzljLXNN/OlyzvM7
 qVm/yNlqFLeu7En8VBAtqCKBplD8GvSc+ZVKNgC3k2nDCdKL9M0/hBWujT8VBDADjPy8
 OufPNd4ACEObxpmQe6tjtYEfUS8zqRgqRen/5giv9geuGgq/FDyy8+YrbLetwX+EIR9P
 7k5Q==
X-Gm-Message-State: APjAAAWZEAVW5Nqq1oCiTVNVrqk9pmZchsTOZ/a4/t8eEIimxwxAAu73
 p/S4gDfJ0TvXyQLY/ehBm4dUzUyybGGRrmzSHC4=
X-Google-Smtp-Source: APXvYqwmZpwcvcIE6e4/iqd9cok3RDRZaFeplW4q3klYw1r79gHpY0XbJBojO4bj0p+UzZTrtWwxNP4XZgVy/8A6yQk=
X-Received: by 2002:a5d:670a:: with SMTP id o10mr34460551wru.312.1574711273002; 
 Mon, 25 Nov 2019 11:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-22-marcandre.lureau@redhat.com>
 <CAFEAcA-YYiKtFxegF4cqGNwVbEWk2xpPHEXHk1knTNr7x0HRyg@mail.gmail.com>
In-Reply-To: <CAFEAcA-YYiKtFxegF4cqGNwVbEWk2xpPHEXHk1knTNr7x0HRyg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 25 Nov 2019 23:47:37 +0400
Message-ID: <CAJ+F1CJRVnZJo+XAVJbKmDVY0oTqwRgHFDiGEgK64DMSJabNmw@mail.gmail.com>
Subject: Re: [PATCH v4 21/37] sm501: make SerialMM a child,
 export chardev property
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Magnus Damm <magnus.damm@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 21, 2019 at 6:04 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 20 Nov 2019 at 15:31, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Embed the SerialMM sybus device, and re-export its "chardev" property.
> > That way, we can get rid of PROP_PTR "chr-state" and better track
> > devices relationship.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/display/sm501.c | 33 ++++++++++++++++++++++++---------
> >  hw/sh4/r2d.c       |  2 +-
> >  2 files changed, 25 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> > index 1f33c87e65..c4445b28f9 100644
> > --- a/hw/display/sm501.c
> > +++ b/hw/display/sm501.c
> > @@ -1930,13 +1930,14 @@ typedef struct {
> >      SM501State state;
> >      uint32_t vram_size;
> >      uint32_t base;
> > -    void *chr_state;
> > +    SerialMM serial;
> >  } SM501SysBusState;
> >
> >  static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
> >  {
> >      SM501SysBusState *s =3D SYSBUS_SM501(dev);
> >      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > +    SerialState *ss =3D &s->serial.serial;
> >      DeviceState *usb_dev;
> >
> >      sm501_init(&s->state, dev, s->vram_size);
> > @@ -1958,17 +1959,19 @@ static void sm501_realize_sysbus(DeviceState *d=
ev, Error **errp)
> >      sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
> >
> >      /* bridge to serial emulation module */
> > -    if (s->chr_state) {
> > -        serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
> > -                       NULL, /* TODO : chain irq to IRL */
> > -                       115200, s->chr_state, DEVICE_LITTLE_ENDIAN);
> > +    /* FIXME: SM501_UART0 is always mapped, no need to check for the b=
ackend */
> > +    if (qemu_chr_fe_backend_connected(&ss->chr)) {
> > +        MemoryRegion *mr;
> > +        qdev_init_nofail(DEVICE(&s->serial));
> > +        mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->serial), 0);
> > +        memory_region_add_subregion(&s->state.mmio_region, SM501_UART0=
, mr);
> > +        /* TODO : chain irq to IRL */
> >      }
>
> I don't really understand what the FIXME is trying to
> tell me here. If we don't need to check for the backend,
> why is the code checking for it ? It means we have to fish
> around inside the SerialMM's implementation, which seems odd.
> Only mapping the UART registers if there happens to be a backend
> connected also doesn't conceptually seem like the right behaviour,
> because the registers should always exist. Since commit
> 12051d82f004024d5d the chardev mid-layer has correctly handled
> the backend not being connected (ie having a NULL chardev),
> so there's no longer any need for board/device code to special
> case the lack of a chardev.

As you noted, this is addressed by "[PATCH-for-5.0] hw/display/sm501:
Always map the UART0".

It's preferable to keep those 2 seperate. I can include Philippe
change on top, or earlier in my series, is that ok?

>
> >  }
> >
> >  static Property sm501_sysbus_properties[] =3D {
> >      DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
> >      DEFINE_PROP_UINT32("base", SM501SysBusState, base, 0),
> > -    DEFINE_PROP_PTR("chr-state", SM501SysBusState, chr_state),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > @@ -1999,9 +2002,20 @@ static void sm501_sysbus_class_init(ObjectClass =
*klass, void *data)
> >      dc->props =3D sm501_sysbus_properties;
> >      dc->reset =3D sm501_reset_sysbus;
> >      dc->vmsd =3D &vmstate_sm501_sysbus;
> > -    /* Note: pointer property "chr-state" may remain null, thus
> > -     * no need for dc->user_creatable =3D false;
> > -     */
> > +}
> > +
> > +static void sm501_sysbus_init(Object *o)
> > +{
> > +    SM501SysBusState *sm501 =3D SYSBUS_SM501(o);
> > +    SerialMM *smm =3D &sm501->serial;
> > +
> > +    sysbus_init_child_obj(o, "serial", smm, sizeof(SerialMM), TYPE_SER=
IAL_MM);
> > +    qdev_set_legacy_instance_id(DEVICE(smm), SM501_UART0, 2);
>
> The only board we use the sm501 sysbus device is the sh4 r2d
> board, and we don't care about migration compatibility there
> (indeed I would be unsurprised to find that it doesn't even work ;-))
> So I think we can reasonably not set the legacy-instance-ID
> and just declare in the commit message that this is a migration
> compat break for that board.
>

I am simply adapting serial_mm_init() code from "serial: register vmsd
with DeviceClass" here.

Dropping qdev_set_legacy_instance_id() is proabably a seperate concern.

> > +    qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
> > +    qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIA=
N);
> > +
> > +    object_property_add_alias(o, "chardev",
> > +                              OBJECT(smm), "chardev", &error_abort);
> >  }
> >
> >  static const TypeInfo sm501_sysbus_info =3D {
> > @@ -2009,6 +2023,7 @@ static const TypeInfo sm501_sysbus_info =3D {
> >      .parent        =3D TYPE_SYS_BUS_DEVICE,
> >      .instance_size =3D sizeof(SM501SysBusState),
> >      .class_init    =3D sm501_sysbus_class_init,
> > +    .instance_init =3D sm501_sysbus_init,
> >  };
> >
> >  #define TYPE_PCI_SM501 "sm501"
> > diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> > index ee0840f380..72bb5285cc 100644
> > --- a/hw/sh4/r2d.c
> > +++ b/hw/sh4/r2d.c
> > @@ -272,7 +272,7 @@ static void r2d_init(MachineState *machine)
> >      busdev =3D SYS_BUS_DEVICE(dev);
> >      qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
> >      qdev_prop_set_uint32(dev, "base", 0x10000000);
> > -    qdev_prop_set_ptr(dev, "chr-state", serial_hd(2));
> > +    qdev_prop_set_chr(dev, "chardev", serial_hd(2));
> >      qdev_init_nofail(dev);
> >      sysbus_mmio_map(busdev, 0, 0x10000000);
> >      sysbus_mmio_map(busdev, 1, 0x13e00000);
> > --
> > 2.24.0
>
> thanks
> -- PMM
>


--=20
Marc-Andr=C3=A9 Lureau

