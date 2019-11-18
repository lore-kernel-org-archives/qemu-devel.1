Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580FFC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D34206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuTglVXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D34206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWiGb-0007zf-8b
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWiFn-0007JT-95
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWiFl-00067j-U7
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:43:47 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWiFl-00066O-NR
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:43:45 -0500
Received: by mail-oi1-x242.google.com with SMTP id n14so15470426oie.13
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+jsIsPEQoLu9d8nup1pe9kvAUSu0Py/WlxBrGT80qXM=;
 b=fuTglVXnR6wykZFDZpJcrPQaaJPGGX42Dztzx9dyatGRdscDmuoDHi/sHu5+4dB68y
 xExqrNC9wX0Uyym/0urZ7kEFMDm/FraYD4s2On5drKUZDK/IXvnComefR9gpO/n/hRoo
 WEA4qYjaX3YIka8CDlk8HWgMgNUlCm0dFTisA7yX4rgackfYpU/D2HOrGZ/xn5/u77OY
 f18IdKh60+Z5sOMGjVau/FXDshDca1XjysifcJYLITBqGJwz6hH4dGlPxYzGv1fF8ryJ
 VyM6xlG7H4Y31TggsvYwvOLum78NJk+kZIvYtipQaCHH9v48jWcRIBqeSno8KD0g9UXe
 FulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+jsIsPEQoLu9d8nup1pe9kvAUSu0Py/WlxBrGT80qXM=;
 b=V6gPrgGs3E01dFGKWgf/Lwzj0p7F/OutEt3WGtlcGf1kIrAnBjyDGIEh+qDTP5crxg
 DgBGkAKj8RmhbX2FWDDUb9JB5Ems+5yq8RqWYqHo4J2uUroazBJkEq+0MtRooJvc4UoO
 cUL0kpQQuiYfdTAaxnbAnwsLhipRGoJWDEaPWL+K2NYJcPwHzaN5qeNuUUQ8OoIXfm6v
 buYxzJmf/neAc4ezPbNgvv4dNhyaWH8caJBO4o5zKxUsHmCQ9DYQg9qNpyhRewF3lUY6
 kpIvaLQxhOLV83G1pYCPTi98mJSn8wMUMbi8rLgSo2pbUySGs4QJRuI8w+e5Hvlz0txi
 LyVA==
X-Gm-Message-State: APjAAAUJp49Hs4E9SWVvbn7pAGGicz/MZ8J0P3pHuhshWu/tix7udkGg
 KlK4nG+Z+oxFKVeXGkNWO8kiYjM1swvsSbNVKdY+rg==
X-Google-Smtp-Source: APXvYqwFuiSIOpgyHBUzJTNPJjKxCu0F5jpfRj6QuJKJBZ4rcRQFIYU/RKtr8SRn2X5EkRLCMzaUin0xvXCMIrT8ouQ=
X-Received: by 2002:aca:a9d4:: with SMTP id
 s203mr19873230oie.146.1574088224529; 
 Mon, 18 Nov 2019 06:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-14-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-14-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 14:43:33 +0000
Message-ID: <CAFEAcA9Cq_MkAzqAjt5uPNu3HDUfxO0hyVWtqEiAashPEEq3=g@mail.gmail.com>
Subject: Re: [PATCH v3 13/33] serial: start making SerialMM a sysbus device
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
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

On Wed, 23 Oct 2019 at 18:33, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Memory mapped serial device is in fact a sysbus device. The following
> patches will make use of sysbus facilities for resource and
> registration.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/omap_uart.c      |  2 +-
>  hw/char/serial.c         | 47 ++++++++++++++++++++++++++++------------
>  hw/mips/boston.c         |  2 +-
>  hw/mips/mips_malta.c     |  2 +-
>  include/hw/char/serial.h | 20 ++++++++++++-----
>  5 files changed, 51 insertions(+), 22 deletions(-)


> -SerialState *serial_mm_init(MemoryRegion *address_space,
> +SerialMM *serial_mm_init(MemoryRegion *address_space,
>                              hwaddr base, int it_shift,
>                              qemu_irq irq, int baudbase,
>                              Chardev *chr, enum device_endian end)
>  {
> -    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> -    SerialState *s =3D SERIAL(dev);
> +    SerialMM *self =3D SERIAL_MM(qdev_create(NULL, TYPE_SERIAL_MM));
> +    SerialState *s =3D &self->serial;
>
> -    s->it_shift =3D it_shift;
> +    self->it_shift =3D it_shift;
>      s->irq =3D irq;
> -    qdev_prop_set_uint32(dev, "baudbase", baudbase);
> -    qdev_prop_set_chr(dev, "chardev", chr);
> -    qdev_prop_set_int32(dev, "instance-id", base);
> -    qdev_init_nofail(dev);
> +    qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
> +    qdev_prop_set_chr(DEVICE(s), "chardev", chr);
> +    qdev_prop_set_int32(DEVICE(s), "instance-id", base);
> +
> +    qdev_init_nofail(DEVICE(s));
> +    qdev_init_nofail(DEVICE(self));

Something odd is going on here. This is a convenience
wrapper around creating the SERIAL_MM device, so it's
correct that it has to init DEVICE(self). But it should
not be doing anything with the internals of 'self'.
It's the instance_init/realize of the SERIAL_MM object that should
instance_init/realize the 'self->serial' object. You have the
code below to do the 'instance_init' in the serial_mm_instance_init
function, but are missing the equivalent realize code.

> -    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
> +    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], self,
>                            "serial", 8 << it_shift);
>      memory_region_add_subregion(address_space, base, &s->io);
> -    return s;
> +
> +    return self;
> +}
> +
> +static void serial_mm_instance_init(Object *o)
> +{
> +    SerialMM *self =3D SERIAL_MM(o);

'self' is not idiomatic for the name of the variable containing
the pointer to the object in QOM code ("git grep '\Wself\W' hw"
shows no uses of it at all, which is quite unusual for us --
usually the codebase has at least a few uses of any non-standard
way of writing something ;-))

Usually we use something approximating to the abbreviation
of the type name, so here 'smm' would do.

> +
> +    object_initialize_child(o, "serial", &self->serial, sizeof(self->ser=
ial),
> +                            TYPE_SERIAL, &error_abort, NULL);
>  }

thanks
-- PMM

