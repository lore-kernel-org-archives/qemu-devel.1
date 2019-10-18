Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F2CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEB520854
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSEf11Fu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEB520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLV3C-0004Rf-8u
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLV17-0002ro-ED
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLV15-0005D3-Vr
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:22:17 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLV15-0005CW-Nt
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:22:15 -0400
Received: by mail-oi1-x243.google.com with SMTP id i185so5673747oif.9
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z3J8zBG/x0gGvw/4SLO7Xf14rp5jikY8twc4FguRhQw=;
 b=aSEf11FuU18DhALqeJuiPbLB0yKfBi1x+j9vRF/peZuvV27hc/rRgM/Qa7ymRqZv0y
 yDWqK2S6HGT/jLQTKvaEk398IHBhxoViCQiJVm/knM9jThay+QQEhlG8CIXPw3SLvoiK
 GkTkDeXJhLXPn4fRP+7Tbf9+lt+5D+l6pOkqe/woo1+3XB2bOJQBgvpgCZLTfhCQj6mv
 hu1ZtOYwVoY+i02K8gJvqP60tg7APv4VzPYq2vOCElY3nWbrd3UXc0VgU5sRlT76PL3z
 1N5ael3jRv7jzJZljkmrvliMGiCI9SozI4RCQMh1ueSXD+NSmTNUOj5FddpJ0NyY/HNX
 RrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z3J8zBG/x0gGvw/4SLO7Xf14rp5jikY8twc4FguRhQw=;
 b=L3Iu1tDecHnv/NeOFN6LB6uPLjYRKizSn9T/zSY9+u/Monl5zU9JMuh6dHjTifvdAt
 kJj/ZhGB9LCOk9Dw0ROcXwggOjm6LQRJjJ1AU8G2f06l91ZIYX5kH6nynx0+0k+vekRO
 X/VyeSWkRgNKzTN2vaSOHLnQrV933DU0lbBAiy8SNYkeeC+udhP1OWDZqQpGm7rG1e6Y
 hQe0vKxIcBmFP4BqjkOnjmTyHmGRYn9/WktC31VVgaTLh0Uwx9ZFXfINZaEV+ysj/4Sw
 01cdQA5EmMxGdZkI1LPe8s2JQou+EiOSsy5wp8fHVRib+TRy2QrOH0WPyyF9ixDzipys
 L+rA==
X-Gm-Message-State: APjAAAVmFIy9Qd13HNNovToObtq0h4PmtvrCm9JctyBJTwLQAvKVGtRj
 X/l7tzZ6Y7iSqjotPZB/HyrgKQ1NrdZrKEh0NmSCzNr7hiQ=
X-Google-Smtp-Source: APXvYqw3OREf/eP9r/sePvEmHqqDSNNheixBlpEXwrDcpiGpxzv4tSLxhHlA7XsNgrHwZx8vufqhePkGuZNoiMrIdDU=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr8371759oia.48.1571415734844; 
 Fri, 18 Oct 2019 09:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-2-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-2-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 17:22:03 +0100
Message-ID: <CAFEAcA_7zxe6YfM6c8v_SQ+qh2L7Q5RS_xEPvy01q9aPZ6YyiQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] sm501: replace PROP_PTR with PROP_LINK
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, 18 Oct 2019 at 16:42, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/sm501.c | 5 +++--
>  hw/sh4/r2d.c       | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 1f33c87e65..a87d18efab 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1930,7 +1930,7 @@ typedef struct {
>      SM501State state;
>      uint32_t vram_size;
>      uint32_t base;
> -    void *chr_state;
> +    Chardev *chr_state;
>  } SM501SysBusState;
>
>  static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
> @@ -1968,7 +1968,8 @@ static void sm501_realize_sysbus(DeviceState *dev, =
Error **errp)
>  static Property sm501_sysbus_properties[] =3D {
>      DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
>      DEFINE_PROP_UINT32("base", SM501SysBusState, base, 0),
> -    DEFINE_PROP_PTR("chr-state", SM501SysBusState, chr_state),
> +    DEFINE_PROP_LINK("chr-state", SM501SysBusState, chr_state,
> +                     TYPE_CHARDEV, Chardev *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index ee0840f380..5780ee85d9 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -272,7 +272,8 @@ static void r2d_init(MachineState *machine)
>      busdev =3D SYS_BUS_DEVICE(dev);
>      qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
>      qdev_prop_set_uint32(dev, "base", 0x10000000);
> -    qdev_prop_set_ptr(dev, "chr-state", serial_hd(2));
> +    object_property_set_link(OBJECT(dev), OBJECT(serial_hd(2)),
> +                             "chr-state", &error_abort);
>      qdev_init_nofail(dev);
>      sysbus_mmio_map(busdev, 0, 0x10000000);
>      sysbus_mmio_map(busdev, 1, 0x13e00000);

We have a typed way of passing a Chardev to devices:
use qdev_prop_set_chr(). Unfortunately it's not trivially
easy to drop in here, because it sets a property defined
with DEFINE_PROP_CHR to set a field of type CharBackend
(note, not Chardev, and not a pointer) in the device struct.
But serial_mm_init() wants a Chardev*, because it is a
non-QOM interface to the serial device and is manually
doing the qemu_chr_fe_init() that connects the Chardev
to its own CharBackend. The QOM CHR property setter wants
to do that qemu_chr_fe_init() itself.

So I think the right fix here is to properly QOMify the
code which is not QOMified, ie hw/char/serial.c, in a
way that means that the various "memory mapped 16650-ish
devices" we have can use it and can define a
TYPE_CHARDEV property.

In general I think our uses of PROP_PTR are code smells
that indicate places where we have not properly converted
code over to the general approach that the QOM/qdev
design desires; but we should be getting rid of PROP_PTR
by actually doing all those (difficult) conversions.
Merely removing PROP_PTR itself by rephrasing the dubious
inter-device connections in a way that makes them harder
to grep for doesn't seem to me to be necessarily worth
doing. Is the existence of PROP_PTR getting in your way
for a change you want to make ?

thanks
-- PMM

