Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0A1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1BC20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1BC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbJS-0005PZ-7Z
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iNazb-0003f2-9G
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iNazZ-0008EA-Rx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iNazZ-0008Cx-Jn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:09:21 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA2774E4E6
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:09:20 +0000 (UTC)
Received: by mail-oi1-f198.google.com with SMTP id 6so805285oij.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 04:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Rpd4JWd7D9PJPkDkZ9ciXvbQnSeIpR/ey7a2SgA/3pA=;
 b=uBlJbA3t1rS7Q4nOsGm84Ju771sVmqhHWAgQZaKHVEgm9aQFqeVLLGSo728O5351wJ
 0ebNEVA9L4jDLR2qKkI4mdIWrg9McTinDd0B+t9pjg/LJzB0ujyZu/J1EfYyDSszir9V
 V/taR39GxycLCmPzWMIMb6tCyj/zOrFmDduu9covjgcC6pRUnpLdmitXyVn4kFREHqxD
 1fv6Mau8+dNQkC1jHA2M7XyBRp4xya/Fhl69BUGRIPkIe1LhPd1DCPHdBhBcXNr4wAlc
 LmOZl7/qwgBoLN+hfMm2K/pxGiL5Riq2PUcnInNOetgGMj6RoIoc/xXNxtIbnHbJAAv+
 Ha6g==
X-Gm-Message-State: APjAAAXmHpyJWuoryCU6QsrYL1Q7gH/PHRosZK3G2tp4rPsLdqRQDuZF
 xLTY5Ns/2qnNTZXCsl4jQBVCCxaMJnKdVpNhMfxSRxf2V9eBz8lUwoEVINz+/Q2Fl7hLUh7Sqph
 /4cgrMo7gW2qENtE/HSlAO+jQWpSaboM=
X-Received: by 2002:a05:6808:5c1:: with SMTP id
 d1mr4181323oij.76.1571915358862; 
 Thu, 24 Oct 2019 04:09:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzv5RX3lvPErVAP7grCUbmKJsXO88mG/pvhRU/a0SrV7Hi+Esgrhr2k3P6Ik5tlOkEP1ErnYA3hXRVuphe/CzE=
X-Received: by 2002:a05:6808:5c1:: with SMTP id
 d1mr4181298oij.76.1571915358579; 
 Thu, 24 Oct 2019 04:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-22-marcandre.lureau@redhat.com>
 <2d027692-e178-c1c8-8384-ad70ed345f29@redhat.com>
In-Reply-To: <2d027692-e178-c1c8-8384-ad70ed345f29@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 24 Oct 2019 13:09:06 +0200
Message-ID: <CAMxuvay9kroZUo7ZbdhJqKAdp52rMmLGv0LBvktb68B2CKg+Mw@mail.gmail.com>
Subject: Re: [PATCH v3 21/33] lance: replace PROP_PTR with PROP_LINK
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


On Thu, Oct 24, 2019 at 1:01 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/dma/sparc32_dma.c | 2 +-
> >   hw/net/lance.c       | 5 ++---
> >   hw/net/pcnet-pci.c   | 2 +-
> >   hw/net/pcnet.h       | 2 +-
> >   4 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> > index 0e5bbcdc7f..3e4da0c47f 100644
> > --- a/hw/dma/sparc32_dma.c
> > +++ b/hw/dma/sparc32_dma.c
> > @@ -346,7 +346,7 @@ static void sparc32_ledma_device_realize(DeviceStat=
e *dev, Error **errp)
> >       d =3D qdev_create(NULL, TYPE_LANCE);
> >       object_property_add_child(OBJECT(dev), "lance", OBJECT(d), errp);
> >       qdev_set_nic_properties(d, nd);
> > -    qdev_prop_set_ptr(d, "dma", dev);
> > +    object_property_set_link(OBJECT(d), OBJECT(dev), "dma", errp);
> >       qdev_init_nofail(d);
> >   }
> >
> > diff --git a/hw/net/lance.c b/hw/net/lance.c
> > index 6631e2a4e0..4d96299041 100644
> > --- a/hw/net/lance.c
> > +++ b/hw/net/lance.c
> > @@ -138,7 +138,8 @@ static void lance_instance_init(Object *obj)
> >   }
> >
> >   static Property lance_properties[] =3D {
> > -    DEFINE_PROP_PTR("dma", SysBusPCNetState, state.dma_opaque),
> > +    DEFINE_PROP_LINK("dma", SysBusPCNetState, state.dma_opaque,
> > +                     TYPE_DEVICE, DeviceState *),
> >       DEFINE_NIC_PROPERTIES(SysBusPCNetState, state.conf),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> > @@ -153,8 +154,6 @@ static void lance_class_init(ObjectClass *klass, vo=
id *data)
> >       dc->reset =3D lance_reset;
> >       dc->vmsd =3D &vmstate_lance;
> >       dc->props =3D lance_properties;
> > -    /* Reason: pointer property "dma" */
> > -    dc->user_creatable =3D false;
>
> But we still can not start it with the -device option and set the dma,
> can we?

This is a sysbus device, so you can't. I'll add a commit comment.

In theory, link property allows you to pass a QOM path to reference a
QOM instance from -device.

>
> >   }
> >
> >   static const TypeInfo lance_info =3D {
> > diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
> > index 4723c30c79..d067d21e2c 100644
> > --- a/hw/net/pcnet-pci.c
> > +++ b/hw/net/pcnet-pci.c
> > @@ -231,7 +231,7 @@ static void pci_pcnet_realize(PCIDevice *pci_dev, E=
rror **errp)
> >       s->irq =3D pci_allocate_irq(pci_dev);
> >       s->phys_mem_read =3D pci_physical_memory_read;
> >       s->phys_mem_write =3D pci_physical_memory_write;
> > -    s->dma_opaque =3D pci_dev;
> > +    s->dma_opaque =3D DEVICE(pci_dev);
> >
> >       pcnet_common_init(DEVICE(pci_dev), s, &net_pci_pcnet_info);
> >   }
> > diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
> > index 28d19a5c6f..f49b213c57 100644
> > --- a/hw/net/pcnet.h
> > +++ b/hw/net/pcnet.h
> > @@ -50,7 +50,7 @@ struct PCNetState_st {
> >                            uint8_t *buf, int len, int do_bswap);
> >       void (*phys_mem_write)(void *dma_opaque, hwaddr addr,
> >                             uint8_t *buf, int len, int do_bswap);
> > -    void *dma_opaque;
> > +    DeviceState *dma_opaque;
> >       int tx_busy;
> >       int looptest;
> >   };
> >

