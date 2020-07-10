Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4851C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6132078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rzK02JUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6132078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtoVY-0007Z4-N5
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtoV1-00073a-2M
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:35:15 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtoUy-0005oX-5z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:35:14 -0400
Received: by mail-oi1-x241.google.com with SMTP id t198so4168874oie.7
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y8GCevOYgwLX9W0bjD2b/qUsreJbOqa0JmF/UhmYPrQ=;
 b=rzK02JUY61sFB7FcMzZrN6tg+ITgF20MSne1XTpQApUKOi+puNORq3VIgSaZC3pHjf
 QN5lVPH89MGaniy/3yhaupNowSD4Ro0VMH1IuNG3vrNP+fKlfCVvMT3KAEoIfZ7ysG6O
 QAF9O8CIdnuzGyX+wBvqEZ/YIWq/OhgGzDEmHQy822CpmpE4WEYTzs3WPpzNmlr4k/nm
 af4QuZH33kdyzixrYcxwZRobPHw/ouvoyWPGUxJaFaU9QqIypach8ptWOPepuP1y3qP/
 kvNBNe2BetnJaVFR8Q3OMV4auvMCkEgUDaYWlvavxdhZxXZTviI6fDcvTE6PSiEsfMXJ
 yYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y8GCevOYgwLX9W0bjD2b/qUsreJbOqa0JmF/UhmYPrQ=;
 b=BJeMQmdJkAtLcIHILcgjfhtaDJU4FqHXByp6W0f/cGoXonGM3r+VMaibHW+dbxeftP
 roNveQWy49t4i7uhLmvl/ChO31YhldK1p3q2E8XT8hFBQdF90PeQUB+wK4+Lf8VIsGrc
 imj04iWMxzMwNDpiRImxXqFvU3FRcIBiXTFUsttBls5/vD1htqf2Dw0zdq8fHgaYFUpf
 R4ds/7HqIteiJOvtbvdGUFreKYW/Hqza4kjvh7HVXvFpJwMf0LZGuYYRT+OgLF2OXzt5
 XD237ngDwOWwW8jrVKywZRw7PEiRkoFgaNyC+7qJHI6TMLenqN7dpk4u9AI4UMnCQ8/L
 6uxw==
X-Gm-Message-State: AOAM5311EF+33DW6Ql7sg4Cs5+kkpAYHnbm3lwk8CUcfnjrDWQj2lCyU
 8qDc7RnW4ItywYr7NwH0D74vlDsc2htlkNz7Ig21iQ==
X-Google-Smtp-Source: ABdhPJyAJoVax8nkfYPkuYzo1+XhxttNDCv+KFrFKGRpv6l7wcxJCwxxXMaZyeL4ts4JF4gZJvgjkQz36SqSh0P41do=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr3362245oib.163.1594370110627; 
 Fri, 10 Jul 2020 01:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200703185809.5896-1-f4bug@amsat.org>
 <20200703185809.5896-3-f4bug@amsat.org>
 <ef63ebb4-5f60-e4a7-3027-065b8d1d1f61@redhat.com>
In-Reply-To: <ef63ebb4-5f60-e4a7-3027-065b8d1d1f61@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 09:34:59 +0100
Message-ID: <CAFEAcA_WA89B_THUMmK4yqcPwU_4A8QRy-EwiLrmyFCNwY1Jdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/char/serial: Allow migration of the I/O serial
 device
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 11:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/07/20 20:58, Philippe Mathieu-Daud=C3=A9 wrote:
> > The serial device mapped on the I/O bus hold a migratable
> > SerialState. Keep the same version range from SerialState:
> >
> >  837 const VMStateDescription vmstate_serial =3D {
> >  838     .name =3D "serial",
> >  839     .version_id =3D 3,
> >  840     .minimum_version_id =3D 2,
> >
> > Fixes: 10315a7089 ("serial: make SerialIO a sysbus device")
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  hw/char/serial.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index 9eebcb27e7..c167b584fb 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -1002,12 +1002,22 @@ static void serial_io_realize(DeviceState *dev,=
 Error **errp)
> >      sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
> >  }
> >
> > +static const VMStateDescription vmstate_serial_io =3D {
> > +    .name =3D "serial",
> > +    .version_id =3D 3,
> > +    .minimum_version_id =3D 2,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_STRUCT(serial, SerialIO, 0, vmstate_serial, SerialStat=
e),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static void serial_io_class_init(ObjectClass *klass, void* data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >
> >      dc->realize =3D serial_io_realize;
> > -    /* No dc->vmsd: class has no migratable state */
> > +    dc->vmsd =3D &vmstate_serial_io;
> >  }
> >
> >  static void serial_io_instance_init(Object *o)
> >
>
> Is there any difference between SerialMM and SerialIO at this point?

SerialIO insists on 1-byte wide accesses; SerialMM allows the
creator of the device to specify the spacing between registers
and the endianness. So I suppose SerialIO is kind of a subset of
SerialMM.

It looks like the only user of TYPE_SERIAL_IO is hw/mips/mipssim.c,
Adding the migration state here would be a forwards migration
compat break anyway, so I think we could just change that
machine to use TYPE_SERIAL_MM and then delete TYPE_SERIAL_IO ?

thanks
-- PMM

