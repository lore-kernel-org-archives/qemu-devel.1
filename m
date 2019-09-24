Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33AFC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83097214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6mtqp2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83097214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChTi-0001md-B5
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iChOr-00007P-OH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iChOp-00023Y-S4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:46:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iChOp-00022x-Lu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569318382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=AbTkgRoLJMmPP8LNvyp9AQr9hLo0nHx2Ku+qjO38vtY=;
 b=i6mtqp2XKnTwxj8tV+7SGwLRN9+2xUYG1TDU+dK0b4lJ6UcR+KfFpz+a/MtWBD954zFjLd
 +XSy74ooesBnIVUqnSsgPOWTevPI/CUy5H8y2va5hiCjsG+UTGXLieCOPP544cPbYWqo92
 sGrfGbVM6T0V6R9wJm4TIanGXNIiAPU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-gXvA8Dg-NCO8vOscbONRsA-1; Tue, 24 Sep 2019 05:46:21 -0400
Received: by mail-wm1-f72.google.com with SMTP id k184so692526wmk.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 02:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=66UcyVq0dNDIVqB5HTDZ6RfeJgPXM8wnFrLu6VbH/MA=;
 b=kIrARBn1kMx62E6tMSYPn8637roLSmXYiA8TrWiXpnSDzbca/TqEKg0GfTMyYCZG8I
 V1pTfO1kFfMOPqjPoRt9iig53Vn7tIdDqSYc5XuFp7Dqj6A4QdRgSZxe+81cJe8k2mks
 d5YcqWmX9pCWWQT0w7Q2c/f9mOf3EbYdz/aEMy/JPmQhT0B4waLyYpm6oA457xGKRhfO
 xhjULC8O1BZRicwoAs1NeWml0pgdb+yqqaiRMCplqe0/RXVygl8hKtbOuF+fUCKBfJk/
 pD3qD9MlejxfTwAES6+RNjkiMMYvvhlsa/WYOgDGKzOBcCo1paOJbberJycbSeB+kyhA
 GNmA==
X-Gm-Message-State: APjAAAVDm/OrcCc8w+Wg1yFIMukZ/VqB6jkq9bXPMmyQrNFrDw0RMAfO
 sKEvebRd4sFCtckO0vGzU7RYk1KllCTv4G9uY4vlApZVXRtbyi/FcxbWQBlBwpgA5Yjk6kh+1F5
 8aJvpBXOQN2pxK7Y=
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr1650319wrg.13.1569318379675; 
 Tue, 24 Sep 2019 02:46:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmD1n/VPB0kw26SqXT5tLJ0lOAXmmvjhh/gxHzr1/Bilc4bCRWek9JHkBOIeqL58X0QhvcBA==
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr1650306wrg.13.1569318379439; 
 Tue, 24 Sep 2019 02:46:19 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id r28sm2896072wrr.94.2019.09.24.02.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 02:46:18 -0700 (PDT)
Subject: Re: [PATCH 4/4] xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <20190924045952.11412-5-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2f21edeb-de3f-a9aa-cbfe-b45e2e0bf63d@redhat.com>
Date: Tue, 24 Sep 2019 11:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924045952.11412-5-david@gibson.dropbear.id.au>
Content-Language: en-US
X-MC-Unique: gXvA8Dg-NCO8vOscbONRsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 9/24/19 6:59 AM, David Gibson wrote:
> TYPE_ICS_SIMPLE is the only subtype of TYPE_ICS_BASE that's ever
> instantiated, and the only one we're ever likely to want.  The
> existence of different classes is just a hang over from when we
> (misguidedly) had separate subtypes for the KVM and non-KVM version of
> the device.
>=20
> So, collapse the two classes together into just TYPE_ICS.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/intc/xics.c        | 57 ++++++++++++++++---------------------------
>  hw/ppc/pnv_psi.c      |  2 +-
>  hw/ppc/spapr_irq.c    |  4 +--
>  include/hw/ppc/xics.h | 17 ++-----------
>  4 files changed, 26 insertions(+), 54 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 9ae51bbc76..388dbba870 100644
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
> @@ -587,7 +587,7 @@ static void ics_reset_handler(void *dev)
> =20
>  static void ics_realize(DeviceState *dev, Error **errp)
>  {
> -    ICSState *ics =3D ICS_BASE(dev);
> +    ICSState *ics =3D ICS(dev);
>      Error *local_err =3D NULL;
>      Object *obj;
> =20
> @@ -609,26 +609,14 @@ static void ics_realize(DeviceState *dev, Error **e=
rrp)
>      qemu_register_reset(ics_reset_handler, ics);
>  }
> =20
> -static void ics_simple_class_init(ObjectClass *klass, void *data)
> +static void ics_instance_init(Object *obj)
>  {
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
> -static void ics_base_instance_init(Object *obj)
> -{
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
> @@ -639,7 +627,7 @@ static int ics_base_pre_save(void *opaque)
>      return 0;
>  }
> =20
> -static int ics_base_post_load(void *opaque, int version_id)
> +static int ics_post_load(void *opaque, int version_id)
>  {
>      ICSState *ics =3D opaque;
> =20
> @@ -657,7 +645,7 @@ static int ics_base_post_load(void *opaque, int versi=
on_id)
>      return 0;
>  }
> =20
> -static const VMStateDescription vmstate_ics_base_irq =3D {
> +static const VMStateDescription vmstate_ics_irq =3D {
>      .name =3D "ics/irq",
>      .version_id =3D 2,
>      .minimum_version_id =3D 1,
> @@ -671,46 +659,44 @@ static const VMStateDescription vmstate_ics_base_ir=
q =3D {
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
>      dc->realize =3D ics_realize;
> -    dc->props =3D ics_base_properties;
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

Ah now I see this, OK.

> -    .abstract =3D true,
>      .instance_size =3D sizeof(ICSState),
> -    .instance_init =3D ics_base_instance_init,
> -    .class_init =3D ics_base_class_init,
> -    .class_size =3D sizeof(ICSStateClass),
> +    .instance_init =3D ics_instance_init,
> +    .class_init =3D ics_class_init,
>  };
> =20
>  static const TypeInfo xics_fabric_info =3D {
> @@ -749,8 +735,7 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool =
lsi)
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
> @@ -469,7 +469,7 @@ static void pnv_psi_power8_instance_init(Object *obj)
>      Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> =20
>      object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->ic=
s),
> -                            TYPE_ICS_SIMPLE, &error_abort, NULL);
> +                            TYPE_ICS, &error_abort, NULL);
>  }
> =20
>  static const uint8_t irq_to_xivr[] =3D {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index ac189c5796..6c45d2a3c0 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -98,7 +98,7 @@ static void spapr_irq_init_xics(SpaprMachineState *spap=
r, int nr_irqs,
>      Object *obj;
>      Error *local_err =3D NULL;
> =20
> -    obj =3D object_new(TYPE_ICS_SIMPLE);
> +    obj =3D object_new(TYPE_ICS);
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                     &error_fatal);
> @@ -109,7 +109,7 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
>          return;
>      }
> =20
> -    spapr->ics =3D ICS_BASE(obj);
> +    spapr->ics =3D ICS(obj);
> =20
>      xics_spapr_init(spapr);
>  }
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 92628e7cab..d8cf206a69 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -89,21 +89,8 @@ struct PnvICPState {
>      uint32_t links[3];
>  };
> =20
> -#define TYPE_ICS_BASE "ics-base"
> -#define ICS_BASE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_BASE)
> -
> -/* Retain ics for sPAPR for migration from existing sPAPR guests */
> -#define TYPE_ICS_SIMPLE "ics"
> -#define ICS_SIMPLE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SIMPLE)
> -
> -#define ICS_BASE_CLASS(klass) \
> -     OBJECT_CLASS_CHECK(ICSStateClass, (klass), TYPE_ICS_BASE)
> -#define ICS_BASE_GET_CLASS(obj) \
> -     OBJECT_GET_CLASS(ICSStateClass, (obj), TYPE_ICS_BASE)
> -
> -struct ICSStateClass {
> -    DeviceClass parent_class;
> -};
> +#define TYPE_ICS "ics"
> +#define ICS(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS)
> =20
>  struct ICSState {
>      /*< private >*/
>=20


