Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E606C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1044E2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1044E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCdMD-00069e-5z
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 01:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iCdLC-0005ho-CZ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iCdLB-0000J5-4E
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:26:22 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:60602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iCdLA-0000IW-Uf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:26:21 -0400
Received: from player734.ha.ovh.net (unknown [10.108.42.170])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4E50A10B563
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 07:26:19 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 3B6FFA156E9F;
 Tue, 24 Sep 2019 05:26:15 +0000 (UTC)
Subject: Re: [PATCH 2/4] xics: Merge reset and realize hooks
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <20190924045952.11412-3-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f7fd584c-c4bb-d8b0-a06c-e3fd88088208@kaod.org>
Date: Tue, 24 Sep 2019 07:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924045952.11412-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12176326019262548744
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdelgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.109.80
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
Cc: gkurz@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/2019 06:59, David Gibson wrote:
> Currently TYPE_XICS_BASE and TYPE_XICS_SIMPLE have their own reset and
> realize methods, using the standard technique for having the subtype
> call the supertype's methods before doing its own thing.
>=20
> But TYPE_XICS_SIMPLE is the only subtype of TYPE_XICS_BASE ever
> instantiated, so there's no point having the split here.  Merge them
> together into just ics_reset() and ics_realize() functions.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.

> ---
>  hw/intc/xics.c        | 97 ++++++++++++++++---------------------------
>  include/hw/ppc/xics.h |  3 --
>  2 files changed, 35 insertions(+), 65 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 93139b0189..db0e532bd9 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -548,68 +548,13 @@ static void ics_eoi(ICSState *ics, uint32_t nr)
>      }
>  }
> =20
> -static void ics_simple_reset(DeviceState *dev)
> -{
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
> -
> -    icsc->parent_reset(dev);
> -
> -    if (kvm_irqchip_in_kernel()) {
> -        Error *local_err =3D NULL;
> -
> -        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> -        if (local_err) {
> -            error_report_err(local_err);
> -        }
> -    }
> -}
> -
> -static void ics_simple_reset_handler(void *dev)
> -{
> -    ics_simple_reset(dev);
> -}
> -
> -static void ics_simple_realize(DeviceState *dev, Error **errp)
> -{
> -    ICSState *ics =3D ICS_SIMPLE(dev);
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
> -    Error *local_err =3D NULL;
> -
> -    icsc->parent_realize(dev, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    qemu_register_reset(ics_simple_reset_handler, ics);
> -}
> -
> -static void ics_simple_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
> -
> -    device_class_set_parent_realize(dc, ics_simple_realize,
> -                                    &isc->parent_realize);
> -    device_class_set_parent_reset(dc, ics_simple_reset,
> -                                  &isc->parent_reset);
> -}
> -
> -static const TypeInfo ics_simple_info =3D {
> -    .name =3D TYPE_ICS_SIMPLE,
> -    .parent =3D TYPE_ICS_BASE,
> -    .instance_size =3D sizeof(ICSState),
> -    .class_init =3D ics_simple_class_init,
> -    .class_size =3D sizeof(ICSStateClass),
> -};
> -
>  static void ics_reset_irq(ICSIRQState *irq)
>  {
>      irq->priority =3D 0xff;
>      irq->saved_priority =3D 0xff;
>  }
> =20
> -static void ics_base_reset(DeviceState *dev)
> +static void ics_reset(DeviceState *dev)
>  {
>      ICSState *ics =3D ICS_BASE(dev);
>      int i;
> @@ -625,17 +570,31 @@ static void ics_base_reset(DeviceState *dev)
>          ics_reset_irq(ics->irqs + i);
>          ics->irqs[i].flags =3D flags[i];
>      }
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
> +    }
> +}
> +
> +static void ics_reset_handler(void *dev)
> +{
> +    ics_reset(dev);
>  }
> =20
> -static void ics_base_realize(DeviceState *dev, Error **errp)
> +static void ics_realize(DeviceState *dev, Error **errp)
>  {
>      ICSState *ics =3D ICS_BASE(dev);
> +    Error *local_err =3D NULL;
>      Object *obj;
> -    Error *err =3D NULL;
> =20
> -    obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &err)=
;
> +    obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &loca=
l_err);
>      if (!obj) {
> -        error_propagate_prepend(errp, err,
> +        error_propagate_prepend(errp, local_err,
>                                  "required link '" ICS_PROP_XICS
>                                  "' not found: ");
>          return;
> @@ -647,8 +606,22 @@ static void ics_base_realize(DeviceState *dev, Err=
or **errp)
>          return;
>      }
>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
> +
> +    qemu_register_reset(ics_reset_handler, ics);
> +}
> +
> +static void ics_simple_class_init(ObjectClass *klass, void *data)
> +{
>  }
> =20
> +static const TypeInfo ics_simple_info =3D {
> +    .name =3D TYPE_ICS_SIMPLE,
> +    .parent =3D TYPE_ICS_BASE,
> +    .instance_size =3D sizeof(ICSState),
> +    .class_init =3D ics_simple_class_init,
> +    .class_size =3D sizeof(ICSStateClass),
> +};
> +
>  static void ics_base_instance_init(Object *obj)
>  {
>      ICSState *ics =3D ICS_BASE(obj);
> @@ -725,9 +698,9 @@ static void ics_base_class_init(ObjectClass *klass,=
 void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    dc->realize =3D ics_base_realize;
> +    dc->realize =3D ics_realize;
>      dc->props =3D ics_base_properties;
> -    dc->reset =3D ics_base_reset;
> +    dc->reset =3D ics_reset;
>      dc->vmsd =3D &vmstate_ics_base;
>  }
> =20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 34d7985b7c..0eb39c2561 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -103,9 +103,6 @@ struct PnvICPState {
> =20
>  struct ICSStateClass {
>      DeviceClass parent_class;
> -
> -    DeviceRealize parent_realize;
> -    DeviceReset parent_reset;
>  };
> =20
>  struct ICSState {
>=20


