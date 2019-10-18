Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0DCCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A19205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs7+3/n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A19205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUyx-0007f3-Gk
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iLUqi-0007pR-HB
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iLUqh-0007o6-1A
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iLUqg-0007nC-Of; Fri, 18 Oct 2019 12:11:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id o15so6439145wru.5;
 Fri, 18 Oct 2019 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Y5PULPuT9aUOc2jHLrc3v6r7EulnXS/eTA+A22k80Fk=;
 b=fs7+3/n2Z+d8Z/P4MmRV/HVv2oKJkmO/XOdB3WxHAv0O29gw5XB8/U8Dr9rIDqnQaQ
 XF3wmON0LnILLr4E9oKLIn0wwoBb4IZW813+abfqVlGDDzy/KaYnCZjSo9jys7KN90Nm
 01DGXoAOneQyd0+RdwKWtNU1wMSGU8ECB/sOgeOc/lNeAd6RMweW6t0tYcyQsqoqM2hz
 399DKKGFWbx/VjnhQi9G6fc9gtE34d5wUnesYKpgdx6ejqLjEaJBDVnAlZWsxqqLc3ND
 5+xFtJlCRB+khNCShy5V/rp3W4bojNXg2uiDijEn1zrR27FscFWa/78EBYvB97emLQR0
 zkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y5PULPuT9aUOc2jHLrc3v6r7EulnXS/eTA+A22k80Fk=;
 b=jxJEV/RsBBR4FHGlZ8YBoBA/SvNjyWJIMSgb35Q1HYfb+Gilu+tJR9tNZ/NkmoVBxC
 O4Ckt7hhIUcKsxng8cw9YdsqNec+wmmDE3lKdYk50u32zjNmqdpRRrIG6IPVSEexzCMU
 +sSH64x38zyAib+m+Fby3ZIo9MaesoZL+0kGM3e8UVfcwmB0WNkTxVlnPRyFM3KSX7NQ
 GOD71pkkBtdoICv06xCCyzabefhghQRiO7SkRRJdVgwmxPIEv7sbt8syTYqiuI6EKS9j
 RRed65GYJHZhhhx4r9aGTXlqfuWVba4TIWOuW6lBS0UXrm+L/n+of6IRUzR136A47UfP
 OcqA==
X-Gm-Message-State: APjAAAVjMW8uWOIPtIHijnDBcU81mlMLFd5RxCeMQN7piOaOv57dzxt+
 Yf07pnesgQNrzOfJZd7Qb0tp8beMCbOzsj8SdcE=
X-Google-Smtp-Source: APXvYqyxGoKLIO9VaZM6Ba/DqPPdp4CLztpE2QnXDpxQ6d6Xy9ZuewjKo7QKBaBcqzW+tTyw0qUkCsbTbf3ss1xDoUQ=
X-Received: by 2002:adf:ef0f:: with SMTP id e15mr8884200wro.312.1571415088907; 
 Fri, 18 Oct 2019 09:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-5-marcandre.lureau@redhat.com>
 <CAFEAcA-Qaq0W-4kpRGSQTxzH1LZ3znoxZo6Fnd4NmnnE4O_G9w@mail.gmail.com>
In-Reply-To: <CAFEAcA-Qaq0W-4kpRGSQTxzH1LZ3znoxZo6Fnd4NmnnE4O_G9w@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 Oct 2019 18:11:16 +0200
Message-ID: <CAJ+F1CL8AdRv8ktb8V0Ox7XZEO7GOXqPjVd=_CsZ=oSmHxtP_Q@mail.gmail.com>
Subject: Re: [PATCH 04/14] etraxfs: remove PROP_PTR usage
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Oct 18, 2019 at 5:59 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Fri, 18 Oct 2019 at 16:42, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > etraxfs_dma_client are not Object, so can't be exposed to user with
> > QOM path. Let's remove property usage and move the constructor to the
> > .c unit, simplifying some code on the way.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > +
> > +/* Instantiate an ETRAXFS Ethernet MAC.  */
> > +DeviceState *
> > +etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
> > +                 struct etraxfs_dma_client *dma_out,
> > +                 struct etraxfs_dma_client *dma_in)
> > +{
> > +    DeviceState *dev;
> > +    qemu_check_nic_model(nd, "fseth");
> > +
> > +    dev =3D qdev_create(NULL, "etraxfs-eth");
> > +    qdev_set_nic_properties(dev, nd);
> > +    qdev_prop_set_uint32(dev, "phyaddr", phyaddr);
> > +    ETRAX_FS_ETH(dev)->dma_out =3D dma_out;
> > +    ETRAX_FS_ETH(dev)->dma_in =3D dma_in;
> > +    qdev_init_nofail(dev);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> > +
> > +    return dev;
> > +}
> > +
> >  static const TypeInfo etraxfs_eth_info =3D {
> >      .name          =3D TYPE_ETRAX_FS_ETH,
> >      .parent        =3D TYPE_SYS_BUS_DEVICE,
> > diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
> > index aa146a2cd8..403e7f95e6 100644
> > --- a/include/hw/cris/etraxfs.h
> > +++ b/include/hw/cris/etraxfs.h
> > @@ -30,23 +30,9 @@
> >  #include "hw/qdev-properties.h"
> >  #include "hw/sysbus.h"
> >
> > -/* Instantiate an ETRAXFS Ethernet MAC.  */
> > -static inline DeviceState *
> > -etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
> > -                 void *dma_out, void *dma_in)
> > -{
> > -    DeviceState *dev;
> > -    qemu_check_nic_model(nd, "fseth");
> > -
> > -    dev =3D qdev_create(NULL, "etraxfs-eth");
> > -    qdev_set_nic_properties(dev, nd);
> > -    qdev_prop_set_uint32(dev, "phyaddr", phyaddr);
> > -    qdev_prop_set_ptr(dev, "dma_out", dma_out);
> > -    qdev_prop_set_ptr(dev, "dma_in", dma_in);
> > -    qdev_init_nofail(dev);
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> > -    return dev;
> > -}
> > +DeviceState *etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
> > +                              struct etraxfs_dma_client *dma_out,
> > +                              struct etraxfs_dma_client *dma_in);
>
>
> I don't think this is an improvement -- it's taking a step
> back in the direction of "you need to call a funny _init
> function to initialize a device". You should be able to
> create devices using generic qdev functions.
>

Is there really much difference between:

dev =3D qdev_create()
qdev_prop_set_ptr(dev, "prop", ptr);
qdev_init_nofail()

and

dev =3D qdev_create(MYDEV)
MYDEV(dev)->prop =3D ptr;
qdev_init_nofail()


As "prop" can only be set from code, and those objects are usually
very tightly coupled with the parent/owner.

I don't think it's worth to keep PROP_PTR for this, it just adds complexity=
.

> What we're actually connecting here is 'etraxfs_dma_client'
> struct pointers between the devices like this ethernet
> device and the DMA controller. The connection is currently
> done via a pointer property because we don't have a more
> QOM-like way to do it, but if we want to get rid of the
> pointer property we need to actually implement the more
> QOM-like mechanism, not go backwards from having devices
> connected via properties.
>
> (Similar comments apply for the omap clock connections.
> In that case the answer might be Damien's clock framework
> API, eventually.)
>
> thanks
> -- PMM
>


--=20
Marc-Andr=C3=A9 Lureau

