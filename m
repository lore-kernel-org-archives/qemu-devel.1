Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76BE20715
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwMIWwoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76BE20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXLap-0000HV-23
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 03:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXLYj-0006aZ-5Y
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXLYh-0000v3-Ur
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:41:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iXLYh-0000uY-Oe; Wed, 20 Nov 2019 03:41:55 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so162204wru.3;
 Wed, 20 Nov 2019 00:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2Xfafg76e4Rt6GpyQj/9X9Bnuy1msy0V2PDUMoK8fY8=;
 b=YwMIWwoYl9umQMkhjIA3lBDRc1Dg6dP2FANJfbucKG7id6/B7g60F6T1so2OgGxgRw
 ejjhTUtzeem278yZvBZqv66PHbr7Xvowy7QjdwLH1/UOH3gvCghwhM8m95KSpoI71K4H
 Jdjh2Aahd5j5zqajg4JQR0FOERuEvLy70rSjZMsj2kY6L1dixnZB8w4+Zuep0VuN0sU8
 H/Zw0CHTfPTGSJI0eW20fOOJjor6ULypnuZ3lFOYaQhvG+02FRuWsF4kPyI5jeh7hj0P
 igJ8wbTDkaYV7pfHgZn/ezfU+X0kWL7TBG9fnQMGiV/T7qgYzXEHuKj7Yne1WwJtPGGQ
 w33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2Xfafg76e4Rt6GpyQj/9X9Bnuy1msy0V2PDUMoK8fY8=;
 b=kzcxhnUM7xYnciQdqv+BQEPy7H0AQuQ7LAxpR5+IKf3hjcRSxsXF4Q6LpzzSeyCbZq
 pLOTomszO0i0nEZQ4PxB/25+oJBXPyXhl1rO+KfFUG/5P5b32WUBE9atnHtQqn7kc6RV
 xR1NGNf2gzpauSLYLQGh8GTxIeHB0Xr/bR+2SM+g81MEWPcazmRsTBqOJbxRfYSQt6ZW
 3KehItHzo0YqCvwQjanlELqnUXP7XiDwsoT0Q90U+sdPPP7aTH/1u0W0gB4j6Pfwv3nE
 T2bb7NE/A90BulrtCu1+Z8i/g7SzFNOQ4Igde///AwQcN02MGyjNUxdOkOmVIPrHxAaC
 wqCA==
X-Gm-Message-State: APjAAAV2K/9EEq4MRwRQi+rBs9gbEIo33EQ8NI/8KpLw1PlZU7S2sksy
 gca/8m3YUYxnOsN7WTViMOcRQp8sYyaEoXWFRnw=
X-Google-Smtp-Source: APXvYqzQiCk8mQQDKGsGksHCK0gDfzqZW6FKarsAVRw63px/kbKmzwlmOLJGCVDZ97Fv4SBLKpaDhoaRi9KBFRb8Mhc=
X-Received: by 2002:adf:f20f:: with SMTP id p15mr1621683wro.370.1574239313803; 
 Wed, 20 Nov 2019 00:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-18-marcandre.lureau@redhat.com>
 <CAFEAcA-raK3HOjQjQCaOpqo0QQdT8WChx-njh_8-26R15tunaA@mail.gmail.com>
In-Reply-To: <CAFEAcA-raK3HOjQjQCaOpqo0QQdT8WChx-njh_8-26R15tunaA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Nov 2019 12:41:39 +0400
Message-ID: <CAJ+F1CKmPo9ccLdEVpGOSzbQmomQg5qxk-AU_eT92NvRb+irtQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/33] serial: make SerialIO a sysbus device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 18, 2019 at 7:17 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Make serial IO a proper sysbus device, similar to serial MM.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/char/serial.c         | 58 ++++++++++++++++++++++++++++++++--------
> >  include/hw/char/serial.h | 13 +++++++--
> >  2 files changed, 58 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index a40bc3ab81..84de2740a7 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -986,22 +986,57 @@ const MemoryRegionOps serial_io_ops =3D {
> >      .endianness =3D DEVICE_LITTLE_ENDIAN,
> >  };
> >
> > -SerialState *serial_init(int base, qemu_irq irq, int baudbase,
> > -                         Chardev *chr, MemoryRegion *system_io)
> > +static void serial_io_realize(DeviceState *dev, Error **errp)
> >  {
> > -    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> > -    SerialState *s =3D SERIAL(dev);
> > +    SerialIO *self =3D SERIAL_IO(dev);
>
> "sio" or something rather than "self".

"sio", or something, "s", "si", "serialio"... "self"? Isn't it more
clear that we are talking about the instance itself? No ambiguity,
less weird naming. Isn't this more familar to any OO programmer? Let's
keep the discussion in "serial: start making SerialMM a sysbus
device".


>
> > +    SerialState *s =3D &self->serial;
> >
> > -    s->irq =3D irq;
> > -    qdev_prop_set_uint32(dev, "baudbase", baudbase);
> > -    qdev_prop_set_chr(dev, "chardev", chr);
> > -    qdev_prop_set_int32(dev, "instance-id", base);
> > -    qdev_init_nofail(dev);
> > +    qdev_init_nofail(DEVICE(s));
> >
> >      memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8=
);
> > -    memory_region_add_subregion(system_io, base, &s->io);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(self), &self->serial.irq);
>
> You could say '&s->irq' here, since you have the local variable.

right, fixed

>
> > +}
> > +
> > +static void serial_io_class_init(ObjectClass *klass, void* data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D serial_io_realize;
>
> For class methods where the class has no data that needs
> to be migrated it's helpful to have a comment
>   /* No dc->vmsd: class has no migratable state */
> (which lets us know that it's intentional and not a forgotten
> thing). Some day I will get round to writing a patch so you
> can say "dc->vmsd =3D no_migratable_state;" ...
>

added

thanks

> > +}
> > +
> > +static void serial_io_instance_init(Object *o)
> > +{
> > +    SerialIO *self =3D SERIAL_IO(o);
> > +
> > +    object_initialize_child(o, "serial", &self->serial, sizeof(self->s=
erial),
> > +                            TYPE_SERIAL, &error_abort, NULL);
> > +
> > +    qdev_alias_all_properties(DEVICE(&self->serial), o);
> > +}
> > +
> > +
> > +static const TypeInfo serial_io_info =3D {
> > +    .name =3D TYPE_SERIAL_IO,
> > +    .parent =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(SerialIO),
> > +    .instance_init =3D serial_io_instance_init,
> > +    .class_init =3D serial_io_class_init,
> > +};
> > +
> > +SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> > +                         Chardev *chr, MemoryRegion *system_io)
> > +{
> > +    SerialIO *self =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
> >
> > -    return s;
> > +    qdev_prop_set_uint32(DEVICE(self), "baudbase", baudbase);
> > +    qdev_prop_set_chr(DEVICE(self), "chardev", chr);
> > +    qdev_prop_set_int32(DEVICE(self), "instance-id", base);
> > +    qdev_init_nofail(DEVICE(self));
> > +
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(self), 0, irq);
> > +    memory_region_add_subregion(system_io, base, &self->serial.io);
> > +
> > +    return self;
> >  }
>
> thanks
> -- PMM
>


--=20
Marc-Andr=C3=A9 Lureau

