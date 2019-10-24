Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D22CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D64205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Armzvw1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D64205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcUl-0007wu-Ii
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iNcBq-00016P-2e
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iNcBo-00082L-99
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:26:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iNcBo-00081T-0G; Thu, 24 Oct 2019 08:26:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id s1so17089431wro.0;
 Thu, 24 Oct 2019 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zl8Qp6dJTRdyRz7AMr5NQJesKBKJIZvL1RF+5cEB3nQ=;
 b=Armzvw1Je9EZEKkLuOUnElojigAoGIS4yYdB9N4JmyLAvZZsbQoleGEMnQ3+XZ6GPL
 6NIc2aJGHzcSJTh52leEM0rePP+/kfoCQ/68dE3nlXgdxRgyonYqMuXCQX2TH6j5xWd0
 xnH141O768oJUQG7vxN3RG62O1PQPlcLdSEYpRb4clGnsnDT/y4BPQ+UabsOOnGsmCkK
 qezHTtRJwPKzD9i9xMIY4r1+kb+QIRRCp8iQFzecveGJaKdNaSLeTwVUIBOkX0wlA985
 S5SPHA5QdptPv5n3ErVLKUln52BJH9wBkYZbTsD/4W23KwKgeqX6b7QkNgURrszzVuVd
 eWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zl8Qp6dJTRdyRz7AMr5NQJesKBKJIZvL1RF+5cEB3nQ=;
 b=arN74MHwnuegmRiM0EOrUa+CVLRVyt7m+30qanTTNtoWsjSxrDWLiXh8NyKDLrpdag
 IH/g0gwW/HaFKxHzWJi2XkaXQH6UBz+boBVOWlWQY1q+dxExYDCSspjG+RELZdZr73Wh
 B6S0Pcf5gVAegfICs0Vhqc+xI++9/8WGPp12DbqYXcLCC6J1M2pBuG0FeFnd6NE8QUTX
 MdRJkaINeg+b6v3wpQKtHymHwLv3uqlL5rxKA9H0+GeSdW6V/YIhMPTLkBg30DEuHKQb
 lQl/q6puMl6RmWVhyqwjPSHpvNWZwmfrMClaiZYOGH7GSBF7vVDqqcrxZyROfKOE8av2
 hDuQ==
X-Gm-Message-State: APjAAAXiTrWvKowhc0vKrq3p2+HbN8J83OOG4najx/85NLCJ+2NPV+o9
 7jMKFq4G+4yxFzML19PaUbW6s2KPUXMyCpFehBw=
X-Google-Smtp-Source: APXvYqyyrkJQN82NG/VKPsAEyO6x9SlXT9/gIhvbjBawYw6BYm9+y9wsOLkBcI3JGemdZoP0Q0MkpCwTJ9glSuE2BJk=
X-Received: by 2002:a5d:6892:: with SMTP id h18mr3432048wru.370.1571919961831; 
 Thu, 24 Oct 2019 05:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-22-marcandre.lureau@redhat.com>
 <2d027692-e178-c1c8-8384-ad70ed345f29@redhat.com>
 <CAMxuvay9kroZUo7ZbdhJqKAdp52rMmLGv0LBvktb68B2CKg+Mw@mail.gmail.com>
 <2b9352d7-f4de-bd5c-62c5-cebec79e1c48@redhat.com>
In-Reply-To: <2b9352d7-f4de-bd5c-62c5-cebec79e1c48@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Oct 2019 14:25:49 +0200
Message-ID: <CAJ+F1CLnJwpNovT7XyVuNJw6tVyGZEdPfovjTZG_=mQo6Y=hHw@mail.gmail.com>
Subject: Re: [PATCH v3 21/33] lance: replace PROP_PTR with PROP_LINK
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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

On Thu, Oct 24, 2019 at 2:17 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 10/24/19 1:09 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> >
> > On Thu, Oct 24, 2019 at 1:01 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com> wrote:
> >>
> >> On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >>> ---
> >>>    hw/dma/sparc32_dma.c | 2 +-
> >>>    hw/net/lance.c       | 5 ++---
> >>>    hw/net/pcnet-pci.c   | 2 +-
> >>>    hw/net/pcnet.h       | 2 +-
> >>>    4 files changed, 5 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> >>> index 0e5bbcdc7f..3e4da0c47f 100644
> >>> --- a/hw/dma/sparc32_dma.c
> >>> +++ b/hw/dma/sparc32_dma.c
> >>> @@ -346,7 +346,7 @@ static void sparc32_ledma_device_realize(DeviceSt=
ate *dev, Error **errp)
> >>>        d =3D qdev_create(NULL, TYPE_LANCE);
> >>>        object_property_add_child(OBJECT(dev), "lance", OBJECT(d), err=
p);
> >>>        qdev_set_nic_properties(d, nd);
> >>> -    qdev_prop_set_ptr(d, "dma", dev);
> >>> +    object_property_set_link(OBJECT(d), OBJECT(dev), "dma", errp);
> >>>        qdev_init_nofail(d);
> >>>    }
> >>>
> >>> diff --git a/hw/net/lance.c b/hw/net/lance.c
> >>> index 6631e2a4e0..4d96299041 100644
> >>> --- a/hw/net/lance.c
> >>> +++ b/hw/net/lance.c
> >>> @@ -138,7 +138,8 @@ static void lance_instance_init(Object *obj)
> >>>    }
> >>>
> >>>    static Property lance_properties[] =3D {
> >>> -    DEFINE_PROP_PTR("dma", SysBusPCNetState, state.dma_opaque),
> >>> +    DEFINE_PROP_LINK("dma", SysBusPCNetState, state.dma_opaque,
> >>> +                     TYPE_DEVICE, DeviceState *),
> >>>        DEFINE_NIC_PROPERTIES(SysBusPCNetState, state.conf),
> >>>        DEFINE_PROP_END_OF_LIST(),
> >>>    };
> >>> @@ -153,8 +154,6 @@ static void lance_class_init(ObjectClass *klass, =
void *data)
> >>>        dc->reset =3D lance_reset;
> >>>        dc->vmsd =3D &vmstate_lance;
> >>>        dc->props =3D lance_properties;
> >>> -    /* Reason: pointer property "dma" */
> >>> -    dc->user_creatable =3D false;
> >>
> >> But we still can not start it with the -device option and set the dma,
> >> can we?
> >
> > This is a sysbus device, so you can't. I'll add a commit comment.
>
> Ah OK, understood now.
>
> With comment:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> >
> > In theory, link property allows you to pass a QOM path to reference a
> > QOM instance from -device.
>
> Just wondering, if we had a "bus_address" property to the abstract
> SysBus class (and eventually "bus_name" for later) we could create/map
> sysbus devices from command line?

I can't tell much, as I am not very familiar with the various sysbus
devices. I think you'll have troubles to specify the various io/mmio &
irq to map to. In theory though, we could probably go in that
direction, even perhaps make "machine" from command line or
description file... I am not sure it's worth though.

>
> >>
> >>>    }
> >>>
> >>>    static const TypeInfo lance_info =3D {
> >>> diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
> >>> index 4723c30c79..d067d21e2c 100644
> >>> --- a/hw/net/pcnet-pci.c
> >>> +++ b/hw/net/pcnet-pci.c
> >>> @@ -231,7 +231,7 @@ static void pci_pcnet_realize(PCIDevice *pci_dev,=
 Error **errp)
> >>>        s->irq =3D pci_allocate_irq(pci_dev);
> >>>        s->phys_mem_read =3D pci_physical_memory_read;
> >>>        s->phys_mem_write =3D pci_physical_memory_write;
> >>> -    s->dma_opaque =3D pci_dev;
> >>> +    s->dma_opaque =3D DEVICE(pci_dev);
> >>>
> >>>        pcnet_common_init(DEVICE(pci_dev), s, &net_pci_pcnet_info);
> >>>    }
> >>> diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
> >>> index 28d19a5c6f..f49b213c57 100644
> >>> --- a/hw/net/pcnet.h
> >>> +++ b/hw/net/pcnet.h
> >>> @@ -50,7 +50,7 @@ struct PCNetState_st {
> >>>                             uint8_t *buf, int len, int do_bswap);
> >>>        void (*phys_mem_write)(void *dma_opaque, hwaddr addr,
> >>>                              uint8_t *buf, int len, int do_bswap);
> >>> -    void *dma_opaque;
> >>> +    DeviceState *dma_opaque;
> >>>        int tx_busy;
> >>>        int looptest;
> >>>    };
> >>>
>


--=20
Marc-Andr=C3=A9 Lureau

