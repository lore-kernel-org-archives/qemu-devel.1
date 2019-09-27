Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2ECC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02EB2206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EB2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDkbb-00012Q-5E
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDkao-0000KC-VQ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDkan-0004b9-DN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:23:06 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:34341)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDkan-0004Pa-7H
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:23:05 -0400
Received: from player786.ha.ovh.net (unknown [10.108.42.88])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 115A2144E01
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:22:54 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 714F2A5E7EC7;
 Fri, 27 Sep 2019 07:22:41 +0000 (UTC)
Date: Fri, 27 Sep 2019 09:22:40 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 06/33] xics: Create sPAPR specific ICS subtype
Message-ID: <20190927092240.7f6e29f1@bahia.lan>
In-Reply-To: <20190927055028.11493-7-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-7-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 13316581151066855910
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeehgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.60
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

On Fri, 27 Sep 2019 15:50:01 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> We create a subtype of TYPE_ICS specifically for sPAPR.  For now all this
> does is move the setup of the PAPR specific hcalls and RTAS calls to
> the realize() function for this, rather than requiring the PAPR code to
> explicitly call xics_spapr_init().  In future it will have some more
> function.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/xics_spapr.c        | 34 +++++++++++++++++++++++++++++++++-
>  hw/ppc/spapr_irq.c          |  6 ++----
>  include/hw/ppc/xics_spapr.h |  4 +++-
>  3 files changed, 38 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 3e9444813a..e6dd004587 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -283,8 +283,18 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> =20
> -void xics_spapr_init(SpaprMachineState *spapr)
> +static void ics_spapr_realize(DeviceState *dev, Error **errp)
>  {
> +    ICSState *ics =3D ICS_SPAPR(dev);
> +    ICSStateClass *icsc =3D ICS_GET_CLASS(ics);
> +    Error *local_err =3D NULL;
> +
> +    icsc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
>      spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get_xive=
);
>      spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_int_off);
> @@ -319,3 +329,25 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_=
t nr_servers, void *fdt,
>      _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
>      _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
>  }
> +
> +static void ics_spapr_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ICSStateClass *isc =3D ICS_CLASS(klass);
> +
> +    device_class_set_parent_realize(dc, ics_spapr_realize,
> +                                    &isc->parent_realize);
> +}
> +
> +static const TypeInfo ics_spapr_info =3D {
> +    .name =3D TYPE_ICS_SPAPR,
> +    .parent =3D TYPE_ICS,
> +    .class_init =3D ics_spapr_class_init,
> +};
> +
> +static void xics_spapr_register_types(void)
> +{
> +    type_register_static(&ics_spapr_info);
> +}
> +
> +type_init(xics_spapr_register_types)
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 6c45d2a3c0..8c26fa2d1e 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -98,7 +98,7 @@ static void spapr_irq_init_xics(SpaprMachineState *spap=
r, int nr_irqs,
>      Object *obj;
>      Error *local_err =3D NULL;
> =20
> -    obj =3D object_new(TYPE_ICS);
> +    obj =3D object_new(TYPE_ICS_SPAPR);
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                     &error_fatal);
> @@ -109,9 +109,7 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
>          return;
>      }
> =20
> -    spapr->ics =3D ICS(obj);
> -
> -    xics_spapr_init(spapr);
> +    spapr->ics =3D ICS_SPAPR(obj);
>  }
> =20
>  static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool =
lsi,
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 5dabc9a138..691a6d00f7 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -31,11 +31,13 @@
> =20
>  #define XICS_NODENAME "interrupt-controller"
> =20
> +#define TYPE_ICS_SPAPR "ics-spapr"
> +#define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> +
>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
>                     uint32_t phandle);
>  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
> -void xics_spapr_init(SpaprMachineState *spapr);
> =20
>  #endif /* XICS_SPAPR_H */


