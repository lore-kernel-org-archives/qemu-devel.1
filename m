Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB404C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8ED4215F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d09y+XN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ED4215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacJA-0006Bo-RH
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iacF3-0004W1-7V
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iacEv-0003HE-UX
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:07:06 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iacEv-0002r7-Nh
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:07:01 -0500
Received: by mail-wr1-x444.google.com with SMTP id n1so34171944wra.10
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 01:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z0vTOcbAwCSNMDOAmYtd3e1WL76PDRj3I5bTn1vwIQg=;
 b=d09y+XN6W0XNyGhHc2wrhnwtU1y3N5138gi88+IztLW0NzrPssa3LDGlSuL6a3+6g/
 caVyYDnFZBTtOKyoI45UHhCNUhVunUEd6It+RE96WO0Eu+pOrJVPL0cGF1snbhr56wa1
 iYH9ZAsEjLg3b+e9+93O/PVYRoLXefPlnaYWv4Uvs03Wg1xfQ1J2xECqu/gznjvAanxf
 sQUk+9uX7aPetNgvNuDIoJtzNaWTgzvTMtuyH95Zli5Vpfv0eLSCozkjN1Sfb8lQRjp7
 mJrpqmlq5Lwc2zuk6rll7kG0PP8gHPbavE/Z7Elkw408WyEtvcAof+ttku0Ny23FHPtG
 /sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z0vTOcbAwCSNMDOAmYtd3e1WL76PDRj3I5bTn1vwIQg=;
 b=YiTy7raYXnIiiVUAFAIYJX+fOLxbZfT7Ebx14GJlGarelmqre573igQTmuS/PPC9Qb
 r7VADnwtAQO3weyqWY6Onp/DFZXhe5W1MxlkDlo/KES1AulaWiZ/G5hJ7PkR+6mucMsh
 RIXCwtFJNnEvrs7jVVlt/DxXKatvfSOV8x9ApfiMH8Ay5mW9AwXACmuwYK9n0MOvRDyM
 hYLI0a02qW/lzZewNLjzWGtR2qbPDyne049oOqMAau6ZBIsMStOI+0QAWcSFongQm+2u
 uKdd+Y5rNfNiGHeR0T5Pws48KyRgndxRdqmsSj4h6nNnms41yFi5Rp8e8aOywrotjoUQ
 lGOQ==
X-Gm-Message-State: APjAAAWQByHTFvKpeR4nnr4rMnMrWAhTKLRyQ7Lho1EsEGy56m5woDo7
 t8nBppYOIzHXMjqyQ4h/WCj2gRzlJRxmaxk5fu8=
X-Google-Smtp-Source: APXvYqyDRP/qP3xCOywWrAXxcbMSn5hu+J3Vs1rM60VMMjxpRnz3tH63/3+ktY3Y4V+pvSKiLhnbR8mRZx48VGz0cgE=
X-Received: by 2002:adf:e310:: with SMTP id b16mr45157525wrj.202.1575018413925; 
 Fri, 29 Nov 2019 01:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-32-marcandre.lureau@redhat.com>
 <20191121224351.GN3556@minyard.net>
In-Reply-To: <20191121224351.GN3556@minyard.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 Nov 2019 13:06:41 +0400
Message-ID: <CAJ+F1CKCp2McVyeEou4erXaGZmPmByKCtT0SpK9RVfmcqc9Opw@mail.gmail.com>
Subject: Re: [PATCH v4 31/37] smbus-eeprom: remove PROP_PTR
To: Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Corey

On Fri, Nov 22, 2019 at 2:44 AM Corey Minyard <cminyard@mvista.com> wrote:
>
> On Wed, Nov 20, 2019 at 07:24:36PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Instead, set the initial data field directly.
> >
> > (the initial data is an array of 256 bytes. As I don't know if it may
> > change over time, I keep the pointer to original buffer as is, but it
> > might be worth to consider to copy it instead)
>
> This looks ok to me, I can add it to my tree.  I think we are in hard
> freeze now, so this will have to wait until that's done.

Thanks, I think I would rather keep it in this series, as the goal is
to remove PROP_PTR, and tracking various subsystems will be tedious.
Instead, we can hopefully do it in one go.

Does it get your reviewed-by then?

>
> -corey
>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/i2c/smbus_eeprom.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> > index 54c86a0112..533c728b3b 100644
> > --- a/hw/i2c/smbus_eeprom.c
> > +++ b/hw/i2c/smbus_eeprom.c
> > @@ -44,7 +44,7 @@
> >  typedef struct SMBusEEPROMDevice {
> >      SMBusDevice smbusdev;
> >      uint8_t data[SMBUS_EEPROM_SIZE];
> > -    void *init_data;
> > +    uint8_t *init_data;
> >      uint8_t offset;
> >      bool accessed;
> >  } SMBusEEPROMDevice;
> > @@ -129,14 +129,14 @@ static void smbus_eeprom_reset(DeviceState *dev)
> >
> >  static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
> >  {
> > +    SMBusEEPROMDevice *eeprom =3D SMBUS_EEPROM(dev);
> > +
> >      smbus_eeprom_reset(dev);
> > +    if (eeprom->init_data =3D=3D NULL) {
> > +        error_setg(errp, "init_data cannot be NULL");
> > +    }
> >  }
> >
> > -static Property smbus_eeprom_properties[] =3D {
> > -    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
> > -    DEFINE_PROP_END_OF_LIST(),
> > -};
> > -
> >  static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -146,9 +146,8 @@ static void smbus_eeprom_class_initfn(ObjectClass *=
klass, void *data)
> >      dc->reset =3D smbus_eeprom_reset;
> >      sc->receive_byte =3D eeprom_receive_byte;
> >      sc->write_data =3D eeprom_write_data;
> > -    dc->props =3D smbus_eeprom_properties;
> >      dc->vmsd =3D &vmstate_smbus_eeprom;
> > -    /* Reason: pointer property "data" */
> > +    /* Reason: init_data */
> >      dc->user_creatable =3D false;
> >  }
> >
> > @@ -172,7 +171,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t a=
ddress, uint8_t *eeprom_buf)
> >
> >      dev =3D qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
> >      qdev_prop_set_uint8(dev, "address", address);
> > -    qdev_prop_set_ptr(dev, "data", eeprom_buf);
> > +    SMBUS_EEPROM(dev)->init_data =3D eeprom_buf;
> >      qdev_init_nofail(dev);
> >  }
> >
> > --
> > 2.24.0
> >
>


--=20
Marc-Andr=C3=A9 Lureau

