Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DC8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCF52084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCF52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38421 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaba-0008OY-IL
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iNaMh-0006Dt-CD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iNaMd-0006uI-6m
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iNaMb-0006qi-Fo
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:29:07 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 50B80C049E12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:29:04 +0000 (UTC)
Received: by mail-oi1-f198.google.com with SMTP id g25so13953840oiy.12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d7Wp61BGCGzkAAW7NSNW4W65oL+oV43yXlrfwYxbZWA=;
 b=kjpNHNh5oUTsLYNPgQa4Ucu2H1ak9TPvsQVlBPGcn8B89uZeQf2cokT440DWtWYpTY
 AN2p/NZouc5F5IdGq5aheKhemaSHwgasojnQzWHMdnzmWwZSLKtsoj2rWWAo1yIP3chi
 vxJ7tqJc8QeMUi47Sq8tmQ4xseyoFYtMBUYuLWvdBKn0y3k4Z2odg5GWz2x3WQLtXXQ1
 BdSGTin1B8EGEaoVFkegC+xNvwN74V5muDux9DdVV/kqMWYHF5og48tLxdcVzhnkoZnD
 TFSLNEghLCZdubQoGswSMMRltZPgVhdGKoR1D6DpXPQ+Kc7cyYjDD+Hoaw3RHKJa19TP
 JTjA==
X-Gm-Message-State: APjAAAUdHqq+b1VnIb5zhdiAMmk8WD00wRaSx9NZlh7GnxcU5DwUJBgN
 cAh+qxGtg/hYWVI9uUWXYgao0QgVvaoL5Z91FsLqFEjOp3VKExGr21FRqfoONnRQ4xkimfVzn07
 awNhigS0/5l+Q/1fBcO7R/6b3XEImYd0=
X-Received: by 2002:aca:4fd8:: with SMTP id d207mr4093816oib.33.1571912943708; 
 Thu, 24 Oct 2019 03:29:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvhlXJ3ljF2QTE/gtS6/GxE7AjFNRkjgAfnbulIQ4VaJ8+kJcVKh66ncg9Ks1mqplAbLakCKkklSAL72QCrfQ=
X-Received: by 2002:aca:4fd8:: with SMTP id d207mr4093783oib.33.1571912943430; 
 Thu, 24 Oct 2019 03:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-20-marcandre.lureau@redhat.com>
 <0033fd98-f191-c3f5-4726-ba052254808a@redhat.com>
In-Reply-To: <0033fd98-f191-c3f5-4726-ba052254808a@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 24 Oct 2019 12:28:52 +0200
Message-ID: <CAMxuvawtzdWkyuZRoEs9Zmv9EsxeD6H_d+9-aEM0PetKjf1hbQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/33] sm501: make SerialMM a child,
 export chardev property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
 qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Oct 24, 2019 at 12:58 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Embed the SerialMM sybus device, and re-export its "chardev" property.
> > That way, we can get rid of PROP_PTR "chr-state" and better track
> > devices relationship.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/sm501.c | 31 ++++++++++++++++++++++---------
> >   hw/sh4/r2d.c       |  2 +-
> >   2 files changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> > index 1f33c87e65..6efdf764c1 100644
> > --- a/hw/display/sm501.c
> > +++ b/hw/display/sm501.c
> > @@ -1930,13 +1930,14 @@ typedef struct {
> >       SM501State state;
> >       uint32_t vram_size;
> >       uint32_t base;
> > -    void *chr_state;
> > +    SerialMM serial;
> >   } SM501SysBusState;
> >
> >   static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
> >   {
> >       SM501SysBusState *s =3D SYSBUS_SM501(dev);
> >       SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > +    SerialState *ss =3D &s->serial.serial;
> >       DeviceState *usb_dev;
> >
> >       sm501_init(&s->state, dev, s->vram_size);
> > @@ -1958,17 +1959,18 @@ static void sm501_realize_sysbus(DeviceState *d=
ev, Error **errp)
> >       sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
> >
> >       /* bridge to serial emulation module */
> > -    if (s->chr_state) {
> > -        serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
> > -                       NULL, /* TODO : chain irq to IRL */
> > -                       115200, s->chr_state, DEVICE_LITTLE_ENDIAN);
> > +    if (qemu_chr_fe_backend_connected(&ss->chr)) {
>
> Oh, this is a Companion Chip (Northbridge + Southbridge), mostly
> implementing the display part, that's why it is in hw/display/.
>
> The SM501_UART0 is always mapped here, no need to check for the backend.
> (Not related to your series goal, but cleaning this might simplify this
> patch).

I see, I will drop a FIXME. Otherwise, it looks ok?


>
> > +        MemoryRegion *mr;
> > +        qdev_init_nofail(DEVICE(&s->serial));
> > +        mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->serial), 0);
> > +        memory_region_add_subregion(&s->state.mmio_region, SM501_UART0=
, mr);
> > +        /* TODO : chain irq to IRL */
> >       }
> >   }
> >
> >   static Property sm501_sysbus_properties[] =3D {
> >       DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
> >       DEFINE_PROP_UINT32("base", SM501SysBusState, base, 0),
> > -    DEFINE_PROP_PTR("chr-state", SM501SysBusState, chr_state),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> >
> > @@ -1999,9 +2001,19 @@ static void sm501_sysbus_class_init(ObjectClass =
*klass, void *data)
> >       dc->props =3D sm501_sysbus_properties;
> >       dc->reset =3D sm501_reset_sysbus;
> >       dc->vmsd =3D &vmstate_sm501_sysbus;
> > -    /* Note: pointer property "chr-state" may remain null, thus
> > -     * no need for dc->user_creatable =3D false;
> > -     */
> > +}
> > +
> > +static void sm501_sysbus_init(Object *o)
> > +{
> > +    SM501SysBusState *self =3D SYSBUS_SM501(o);
> > +    SerialMM *s =3D &self->serial;
> > +
> > +    sysbus_init_child_obj(o, "serial", s, sizeof(SerialMM), TYPE_SERIA=
L_MM);
> > +    qdev_prop_set_int32(DEVICE(s), "instance-id", SM501_UART0);
> > +    qdev_prop_set_uint8(DEVICE(s), "regshift", 2);
> > +    qdev_prop_set_uint8(DEVICE(s), "endianness", DEVICE_LITTLE_ENDIAN)=
;
> > +
> > +    object_property_add_alias(o, "chardev", OBJECT(s), "chardev", &err=
or_abort);
> >   }
> >
> >   static const TypeInfo sm501_sysbus_info =3D {
> > @@ -2009,6 +2021,7 @@ static const TypeInfo sm501_sysbus_info =3D {
> >       .parent        =3D TYPE_SYS_BUS_DEVICE,
> >       .instance_size =3D sizeof(SM501SysBusState),
> >       .class_init    =3D sm501_sysbus_class_init,
> > +    .instance_init =3D sm501_sysbus_init,
> >   };
> >
> >   #define TYPE_PCI_SM501 "sm501"
> > diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> > index ee0840f380..72bb5285cc 100644
> > --- a/hw/sh4/r2d.c
> > +++ b/hw/sh4/r2d.c
> > @@ -272,7 +272,7 @@ static void r2d_init(MachineState *machine)
> >       busdev =3D SYS_BUS_DEVICE(dev);
> >       qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
> >       qdev_prop_set_uint32(dev, "base", 0x10000000);
> > -    qdev_prop_set_ptr(dev, "chr-state", serial_hd(2));
> > +    qdev_prop_set_chr(dev, "chardev", serial_hd(2));
> >       qdev_init_nofail(dev);
> >       sysbus_mmio_map(busdev, 0, 0x10000000);
> >       sysbus_mmio_map(busdev, 1, 0x13e00000);
> >

