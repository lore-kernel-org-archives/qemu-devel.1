Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E1C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93E02082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93E02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2Ih-0003sT-G3
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iD2Dc-0008Gu-Ae
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iD2Da-00088f-Oq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:00:12 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:44220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iD2Da-00085Q-J2
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:00:10 -0400
Received: from player159.ha.ovh.net (unknown [10.109.146.168])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3E9911ACC1C
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 10:00:04 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id E2B13A1B6DE1;
 Wed, 25 Sep 2019 07:59:53 +0000 (UTC)
Date: Wed, 25 Sep 2019 09:59:52 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 04/20] xics: Eliminate reset hook
Message-ID: <20190925095952.09852a8b@bahia.lan>
In-Reply-To: <20190925064534.19155-5-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-5-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 2198882521749887462
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.172.75
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 16:45:18 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently TYPE_XICS_BASE and TYPE_XICS_SIMPLE have their own reset method=
s,
> using the standard technique for having the subtype call the supertype's
> methods before doing its own thing.
>=20
> But TYPE_XICS_SIMPLE is the only subtype of TYPE_XICS_BASE ever
> instantiated, so there's no point having the split here.  Merge them
> together into just an ics_reset() function.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/intc/xics.c        | 57 ++++++++++++++++++-------------------------
>  include/hw/ppc/xics.h |  1 -
>  2 files changed, 24 insertions(+), 34 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 310dc72b46..82e6f09259 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -547,11 +547,28 @@ static void ics_eoi(ICSState *ics, uint32_t nr)
>      }
>  }
> =20
> -static void ics_simple_reset(DeviceState *dev)
> +static void ics_reset_irq(ICSIRQState *irq)
>  {
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
> +    irq->priority =3D 0xff;
> +    irq->saved_priority =3D 0xff;
> +}
> =20
> -    icsc->parent_reset(dev);
> +static void ics_reset(DeviceState *dev)
> +{
> +    ICSState *ics =3D ICS_BASE(dev);
> +    int i;
> +    uint8_t flags[ics->nr_irqs];
> +
> +    for (i =3D 0; i < ics->nr_irqs; i++) {
> +        flags[i] =3D ics->irqs[i].flags;
> +    }
> +
> +    memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
> +
> +    for (i =3D 0; i < ics->nr_irqs; i++) {
> +        ics_reset_irq(ics->irqs + i);
> +        ics->irqs[i].flags =3D flags[i];
> +    }
> =20
>      if (kvm_irqchip_in_kernel()) {
>          Error *local_err =3D NULL;
> @@ -563,9 +580,9 @@ static void ics_simple_reset(DeviceState *dev)
>      }
>  }
> =20
> -static void ics_simple_reset_handler(void *dev)
> +static void ics_reset_handler(void *dev)
>  {
> -    ics_simple_reset(dev);
> +    ics_reset(dev);
>  }
> =20
>  static void ics_simple_realize(DeviceState *dev, Error **errp)
> @@ -580,7 +597,7 @@ static void ics_simple_realize(DeviceState *dev, Erro=
r **errp)
>          return;
>      }
> =20
> -    qemu_register_reset(ics_simple_reset_handler, ics);
> +    qemu_register_reset(ics_reset_handler, ics);

As suggested by Philippe, this could be the opportunity to add
a comment that explain why we rely on qemu_register_reset()
rather than dc->reset.

>  }
> =20
>  static void ics_simple_class_init(ObjectClass *klass, void *data)
> @@ -590,8 +607,6 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
> =20
>      device_class_set_parent_realize(dc, ics_simple_realize,
>                                      &isc->parent_realize);
> -    device_class_set_parent_reset(dc, ics_simple_reset,
> -                                  &isc->parent_reset);
>  }
> =20
>  static const TypeInfo ics_simple_info =3D {
> @@ -602,30 +617,6 @@ static const TypeInfo ics_simple_info =3D {
>      .class_size =3D sizeof(ICSStateClass),
>  };
> =20
> -static void ics_reset_irq(ICSIRQState *irq)
> -{
> -    irq->priority =3D 0xff;
> -    irq->saved_priority =3D 0xff;
> -}
> -
> -static void ics_base_reset(DeviceState *dev)
> -{
> -    ICSState *ics =3D ICS_BASE(dev);
> -    int i;
> -    uint8_t flags[ics->nr_irqs];
> -
> -    for (i =3D 0; i < ics->nr_irqs; i++) {
> -        flags[i] =3D ics->irqs[i].flags;
> -    }
> -
> -    memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
> -
> -    for (i =3D 0; i < ics->nr_irqs; i++) {
> -        ics_reset_irq(ics->irqs + i);
> -        ics->irqs[i].flags =3D flags[i];
> -    }
> -}
> -
>  static void ics_base_realize(DeviceState *dev, Error **errp)
>  {
>      ICSState *ics =3D ICS_BASE(dev);
> @@ -726,7 +717,7 @@ static void ics_base_class_init(ObjectClass *klass, v=
oid *data)
> =20
>      dc->realize =3D ics_base_realize;
>      dc->props =3D ics_base_properties;
> -    dc->reset =3D ics_base_reset;
> +    dc->reset =3D ics_reset;

I hadn't spotted it previously but since you're removing the call to
device_class_set_parent_reset(), we don't need dc->reset anymore.

This basically reverts:

commit eeefd43b3cf342d1696128462a16e092995ff1b5
Author: C=C3=A9dric Le Goater <clg@kaod.org>
Date:   Mon Jun 25 11:17:16 2018 +0200

    ppx/xics: introduce a parent_reset in ICSStateClass
   =20
    Just like for the realize handlers, this makes possible to move the
    common ICSState code of the reset handlers in the ics-base class.
   =20
    Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

With dc->reset removed,

Reviewed-by: Greg Kurz <groug@kaod.org>

>      dc->vmsd =3D &vmstate_ics_base;
>  }
> =20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index e72fb67968..18fcd2b11c 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -105,7 +105,6 @@ struct ICSStateClass {
>      DeviceClass parent_class;
> =20
>      DeviceRealize parent_realize;
> -    DeviceReset parent_reset;
>  };
> =20
>  struct ICSState {


