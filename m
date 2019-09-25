Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2370AC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE23420640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE23420640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD73C-0006sp-At
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD6iU-00035Y-9w
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD6iS-0002vH-GA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:48:21 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:56230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD6iS-0002sn-Av
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:48:20 -0400
Received: from player792.ha.ovh.net (unknown [10.108.35.159])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id D04B9190D62
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 14:48:10 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id 03E1BA4A0A9A;
 Wed, 25 Sep 2019 12:47:58 +0000 (UTC)
Subject: Re: [PATCH 05/20] xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE
 classes
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-6-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b0e758c0-76d8-27d8-838d-5be5e04e4ecb@kaod.org>
Date: Wed, 25 Sep 2019 14:47:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7064177491461508056
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.253.128
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
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/2019 08:45, David Gibson wrote:
> TYPE_ICS_SIMPLE is the only subtype of TYPE_ICS_BASE that's ever
> instantiated, and the only one we're ever likely to want.  The
> existence of different classes is just a hang over from when we
> (misguidedly) had separate subtypes for the KVM and non-KVM version of
> the device.
>=20
> So, collapse the two classes together into just TYPE_ICS.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/xics.c        | 86 ++++++++++++++-----------------------------
>  hw/ppc/pnv_psi.c      |  2 +-
>  hw/ppc/spapr_irq.c    |  4 +-
>  include/hw/ppc/xics.h | 16 +++-----
>  4 files changed, 36 insertions(+), 72 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 82e6f09259..dfe7dbd254 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -555,7 +555,7 @@ static void ics_reset_irq(ICSIRQState *irq)
> =20
>  static void ics_reset(DeviceState *dev)
>  {
> -    ICSState *ics =3D ICS_BASE(dev);
> +    ICSState *ics =3D ICS(dev);
>      int i;
>      uint8_t flags[ics->nr_irqs];
> =20
> @@ -573,7 +573,7 @@ static void ics_reset(DeviceState *dev)
>      if (kvm_irqchip_in_kernel()) {
>          Error *local_err =3D NULL;
> =20
> -        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> +        ics_set_kvm_state(ICS(dev), &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>          }
> @@ -585,47 +585,15 @@ static void ics_reset_handler(void *dev)
>      ics_reset(dev);
>  }
> =20
> -static void ics_simple_realize(DeviceState *dev, Error **errp)
> +static void ics_realize(DeviceState *dev, Error **errp)
>  {
> -    ICSState *ics =3D ICS_SIMPLE(dev);
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
> +    ICSState *ics =3D ICS(dev);
>      Error *local_err =3D NULL;
> -
> -    icsc->parent_realize(dev, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    qemu_register_reset(ics_reset_handler, ics);
> -}
> -
> -static void ics_simple_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
> -
> -    device_class_set_parent_realize(dc, ics_simple_realize,
> -                                    &isc->parent_realize);
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
> -static void ics_base_realize(DeviceState *dev, Error **errp)
> -{
> -    ICSState *ics =3D ICS_BASE(dev);
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
> @@ -637,16 +605,18 @@ static void ics_base_realize(DeviceState *dev, Er=
ror **errp)
>          return;
>      }
>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
> +
> +    qemu_register_reset(ics_reset_handler, ics);
>  }
> =20
> -static void ics_base_instance_init(Object *obj)
> +static void ics_instance_init(Object *obj)
>  {
> -    ICSState *ics =3D ICS_BASE(obj);
> +    ICSState *ics =3D ICS(obj);
> =20
>      ics->offset =3D XICS_IRQ_BASE;
>  }
> =20
> -static int ics_base_pre_save(void *opaque)
> +static int ics_pre_save(void *opaque)
>  {
>      ICSState *ics =3D opaque;
> =20
> @@ -657,7 +627,7 @@ static int ics_base_pre_save(void *opaque)
>      return 0;
>  }
> =20
> -static int ics_base_post_load(void *opaque, int version_id)
> +static int ics_post_load(void *opaque, int version_id)
>  {
>      ICSState *ics =3D opaque;
> =20
> @@ -675,7 +645,7 @@ static int ics_base_post_load(void *opaque, int ver=
sion_id)
>      return 0;
>  }
> =20
> -static const VMStateDescription vmstate_ics_base_irq =3D {
> +static const VMStateDescription vmstate_ics_irq =3D {
>      .name =3D "ics/irq",
>      .version_id =3D 2,
>      .minimum_version_id =3D 1,
> @@ -689,45 +659,44 @@ static const VMStateDescription vmstate_ics_base_=
irq =3D {
>      },
>  };
> =20
> -static const VMStateDescription vmstate_ics_base =3D {
> +static const VMStateDescription vmstate_ics =3D {
>      .name =3D "ics",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> -    .pre_save =3D ics_base_pre_save,
> -    .post_load =3D ics_base_post_load,
> +    .pre_save =3D ics_pre_save,
> +    .post_load =3D ics_post_load,
>      .fields =3D (VMStateField[]) {
>          /* Sanity check */
>          VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
> =20
>          VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
> -                                             vmstate_ics_base_irq,
> +                                             vmstate_ics_irq,
>                                               ICSIRQState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> =20
> -static Property ics_base_properties[] =3D {
> +static Property ics_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> -static void ics_base_class_init(ObjectClass *klass, void *data)
> +static void ics_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    dc->realize =3D ics_base_realize;
> -    dc->props =3D ics_base_properties;
> +    dc->realize =3D ics_realize;
> +    dc->props =3D ics_properties;
>      dc->reset =3D ics_reset;
> -    dc->vmsd =3D &vmstate_ics_base;
> +    dc->vmsd =3D &vmstate_ics;
>  }
> =20
> -static const TypeInfo ics_base_info =3D {
> -    .name =3D TYPE_ICS_BASE,
> +static const TypeInfo ics_info =3D {
> +    .name =3D TYPE_ICS,
>      .parent =3D TYPE_DEVICE,
> -    .abstract =3D true,
>      .instance_size =3D sizeof(ICSState),
> -    .instance_init =3D ics_base_instance_init,
> -    .class_init =3D ics_base_class_init,
> +    .instance_init =3D ics_instance_init,
> +    .class_init =3D ics_class_init,
>      .class_size =3D sizeof(ICSStateClass),
>  };
> =20
> @@ -767,8 +736,7 @@ void ics_set_irq_type(ICSState *ics, int srcno, boo=
l lsi)
> =20
>  static void xics_register_types(void)
>  {
> -    type_register_static(&ics_simple_info);
> -    type_register_static(&ics_base_info);
> +    type_register_static(&ics_info);
>      type_register_static(&icp_info);
>      type_register_static(&xics_fabric_info);
>  }
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 8ea81e9d8e..a997f16bb4 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -469,7 +469,7 @@ static void pnv_psi_power8_instance_init(Object *ob=
j)
>      Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> =20
>      object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->=
ics),
> -                            TYPE_ICS_SIMPLE, &error_abort, NULL);
> +                            TYPE_ICS, &error_abort, NULL);
>  }
> =20
>  static const uint8_t irq_to_xivr[] =3D {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index ac189c5796..6c45d2a3c0 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -98,7 +98,7 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
>      Object *obj;
>      Error *local_err =3D NULL;
> =20
> -    obj =3D object_new(TYPE_ICS_SIMPLE);
> +    obj =3D object_new(TYPE_ICS);
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort)=
;
>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                     &error_fatal);
> @@ -109,7 +109,7 @@ static void spapr_irq_init_xics(SpaprMachineState *=
spapr, int nr_irqs,
>          return;
>      }
> =20
> -    spapr->ics =3D ICS_BASE(obj);
> +    spapr->ics =3D ICS(obj);
> =20
>      xics_spapr_init(spapr);
>  }
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 18fcd2b11c..5a9b73d144 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -89,17 +89,13 @@ struct PnvICPState {
>      uint32_t links[3];
>  };
> =20
> -#define TYPE_ICS_BASE "ics-base"
> -#define ICS_BASE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_BASE)
> +#define TYPE_ICS "ics"
> +#define ICS(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS)
> =20
> -/* Retain ics for sPAPR for migration from existing sPAPR guests */
> -#define TYPE_ICS_SIMPLE "ics"
> -#define ICS_SIMPLE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SIMPLE)
> -
> -#define ICS_BASE_CLASS(klass) \
> -     OBJECT_CLASS_CHECK(ICSStateClass, (klass), TYPE_ICS_BASE)
> -#define ICS_BASE_GET_CLASS(obj) \
> -     OBJECT_GET_CLASS(ICSStateClass, (obj), TYPE_ICS_BASE)
> +#define ICS_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(ICSStateClass, (klass), TYPE_ICS)
> +#define ICS_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(ICSStateClass, (obj), TYPE_ICS)
> =20
>  struct ICSStateClass {
>      DeviceClass parent_class;
>=20


