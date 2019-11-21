Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E4C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693FC2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Htc2pQU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693FC2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXr9W-0001du-QH
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXr8U-0000kw-Pu
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXr8T-0006KH-CT
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:24:58 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXr8T-0006K5-4y
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:24:57 -0500
Received: by mail-ot1-x344.google.com with SMTP id m15so3811961otq.7
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fc6S9Pfdoyq1siG9XrQvQHk0c3ob95qK9WGi9HaTnFE=;
 b=Htc2pQU6tS0GsrTDxE1BvdKnKKu9moR41WeVMxR60CSOvVLx3Q78y73x0yHCVZaF1x
 d7sHBIpiThowQxGpy6U2EOTqllEmGIYSeInu279jtXhXT6BlSyDyecvGsDMjv/G+gmZF
 KAM0uzF9pvcbxcPaVE6D+M/gM8PTmQe83gMTyXbOqiwTIhrAZMgxv0htr8TKKjfiBCex
 qlbJGbZ37jTSnEq2y2AWkA1OjRiK1HOL2a2NXQzhqb7QskJ1w5XZ7TjD55AcTHqES1vW
 MsQUptG/7WhMFlAUDpHYJiR56nbGktsCOWZ55z3vZmyb0Ue0Gh80uRtjDp+5zSlqbKNq
 DM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fc6S9Pfdoyq1siG9XrQvQHk0c3ob95qK9WGi9HaTnFE=;
 b=Ty9Ep31mZiyKqVFm22OLCX9XsGnuf+01KvdAU1e9+Nw3a+1L0INTq2yKCDpsPBKtB7
 M0lt8Z6DRTl2qeElTNg+mbYYmE6d5D0y6TYfbvLDmrfupeg46x9VlOP8AGiKQmVNy6tr
 3Zi2XeOu0EPvgZoIn9oMCo8vwDm0/CS1o+BfRBzaFUBMPb6qBvXZXb4Gicd4pRNNp6rp
 xd4WdAz4VDEhoLWxBAGtAtupGDVivJfpZ6H8Q4mBnkk8tN1utTb1HkdJDwxhbXqgvhFQ
 nkE5GhjWBRrwqFNMSXsW2ShijDpDhUxxojsUOo7fQ+Kpg9tiHQislXPOwAO3FgTijDWv
 i8OQ==
X-Gm-Message-State: APjAAAUf4mXhjuXgnHWONX0dqrml85QjxRrtqqeBAktBJZUJAukpjRTm
 t2dSlfpmG0dvRup5w4+wwyy6oYUGTT1yQOJ0OIn5tQ==
X-Google-Smtp-Source: APXvYqyIU+i2m454JZI5SLMh/eyQC/4h2xShHTNff+uSKTuIvG8eNcdekOGFfvH6aYgjGjFuAj+3HWTJBzca6k0Uqpw=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr7608475otn.135.1574360696124; 
 Thu, 21 Nov 2019 10:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-13-marcandre.lureau@redhat.com>
 <CAFEAcA8aj71ue1Y_o1PphD8+iAZeOgqo647hgXS0Z22T9Qa8yg@mail.gmail.com>
 <CAJ+F1CJhaQxrceCqPpPULN5RUUQ+jTVaRa912jX0Ct8MM0ucaw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJhaQxrceCqPpPULN5RUUQ+jTVaRa912jX0Ct8MM0ucaw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2019 18:24:45 +0000
Message-ID: <CAFEAcA82swZ82__hee1818L0RtD-3dNEOAKT2hdwgMOcaiAjHw@mail.gmail.com>
Subject: Re: [PATCH v4 12/37] serial: start making SerialMM a sysbus device
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 at 18:15, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> On Thu, Nov 21, 2019 at 5:47 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > On Wed, 20 Nov 2019 at 15:27, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > Memory mapped serial device is in fact a sysbus device. The following
> > > patches will make use of sysbus facilities for resource and
> > > registration. In particular, "serial-mm: use sysbus facilities" will
> > > move internal serial realization to serial_mm_realize callback to
> > > follow qdev best practices.
> >
> > What goes wrong if you just put the realize of smm->serial in
> > the right place to start with ?
>
> You mean squash the following patches?

No, I meant just having this patch have

static void serial_mm_realize(DeviceState *dev, Error **errp)
{
    SerialMM *smm =3D SERIAL_MM(dev);
    SerialState *s =3D &smm->serial;

    object_property_set_bool(OBJECT(dev), true, "realized", &err);
    if (err) {
        error_propagate(errp, err);
        return;
    }
}

and

+ dc->realize =3D serial_mm_realize;

rather than manually doing the qdev_init_nofail()
in serial_mm_init(). This seems to me like an integral
part of the change to doing the init of the subdevice in the
init method, so it would be better unless there's a reason
why it breaks something. The rest of patch 15 (which is
what currently makes the equivalent change to realize) is all
about passing through the properties and exposing the
sysbus MMIO/irq regions and should stay a separate patch.

(setting the 'realized' property is better in a realize method
than using qdev_init_nofail() because it means we can propagate
any error outward rather than killing qemu.)

thanks
-- PMM

