Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E3C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0582054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0582054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1uT-0007tk-Mh
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1mU-0000Tr-4S
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1mS-0002RT-GM
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:32:09 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:51021)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1mS-0002R3-9A
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:32:08 -0400
Received: from player726.ha.ovh.net (unknown [10.109.146.19])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6DBC61437BD
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:32:05 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id 0AB67A20887A;
 Wed, 25 Sep 2019 07:31:55 +0000 (UTC)
Subject: Re: [PATCH 20/20] spapr: Eliminate SpaprIrq::init hook
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-21-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1b74c0fc-b318-df5a-d66d-fe59ae562d70@kaod.org>
Date: Wed, 25 Sep 2019 09:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-21-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1726286032707423192
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.76
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
> This method is used to set up the interrupt backends for the current
> configuration.  However, this means some confusing redirection between
> the "dual" mode init and the init hooks for xics only and xive only mod=
es.
>=20
> Since we now have simple flags indicating whether XICS and/or XIVE are
> supported, it's easier to just open code each initialization directly i=
n
> spapr_irq_init().  This will also make some future cleanups simpler.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

one comment below,

> ---
>  hw/ppc/spapr_irq.c          | 138 ++++++++++++++++--------------------
>  include/hw/ppc/spapr_irq.h  |   1 -
>  include/hw/ppc/xics_spapr.h |   1 +
>  3 files changed, 63 insertions(+), 77 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 073f375ba2..62647dd5a3 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -91,27 +91,6 @@ static void spapr_irq_init_kvm(SpaprMachineState *sp=
apr,
>  /*
>   * XICS IRQ backend.
>   */
> -
> -static void spapr_irq_init_xics(SpaprMachineState *spapr, Error **errp=
)
> -{
> -    Object *obj;
> -    Error *local_err =3D NULL;
> -
> -    obj =3D object_new(TYPE_ICS_SPAPR);
> -    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort)=
;
> -    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
> -                                   &error_fatal);
> -    object_property_set_int(obj, spapr->irq->nr_xirqs,
> -                            "nr-irqs",  &error_fatal);
> -    object_property_set_bool(obj, true, "realized", &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    spapr->ics =3D ICS_SPAPR(obj);
> -}
> -
>  static void spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bo=
ol lsi,
>                                   Error **errp)
>  {
> @@ -212,7 +191,6 @@ SpaprIrq spapr_irq_xics =3D {
>      .xics        =3D true,
>      .xive        =3D false,
> =20
> -    .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
>      .free        =3D spapr_irq_free_xics,
>      .print_info  =3D spapr_irq_print_info_xics,
> @@ -227,37 +205,6 @@ SpaprIrq spapr_irq_xics =3D {
>  /*
>   * XIVE IRQ backend.
>   */
> -static void spapr_irq_init_xive(SpaprMachineState *spapr, Error **errp=
)
> -{
> -    uint32_t nr_servers =3D spapr_max_server_number(spapr);
> -    DeviceState *dev;
> -    int i;
> -
> -    dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> -    qdev_prop_set_uint32(dev, "nr-irqs",
> -                         spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> -    /*
> -     * 8 XIVE END structures per CPU. One for each available priority
> -     */
> -    qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> -    qdev_init_nofail(dev);
> -
> -    spapr->xive =3D SPAPR_XIVE(dev);
> -
> -    /* Enable the CPU IPIs */
> -    for (i =3D 0; i < nr_servers; ++i) {
> -        Error *local_err =3D NULL;
> -
> -        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false, &l=
ocal_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    }
> -
> -    spapr_xive_hcall_init(spapr);
> -}
> -
>  static void spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bo=
ol lsi,
>                                   Error **errp)
>  {
> @@ -361,7 +308,6 @@ SpaprIrq spapr_irq_xive =3D {
>      .xics        =3D false,
>      .xive        =3D true,
> =20
> -    .init        =3D spapr_irq_init_xive,
>      .claim       =3D spapr_irq_claim_xive,
>      .free        =3D spapr_irq_free_xive,
>      .print_info  =3D spapr_irq_print_info_xive,
> @@ -392,23 +338,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineSta=
te *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
> =20
> -static void spapr_irq_init_dual(SpaprMachineState *spapr, Error **errp=
)
> -{
> -    Error *local_err =3D NULL;
> -
> -    spapr_irq_xics.init(spapr, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    spapr_irq_xive.init(spapr, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -}
> -
>  static void spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bo=
ol lsi,
>                                   Error **errp)
>  {
> @@ -520,7 +449,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .xics        =3D true,
>      .xive        =3D true,
> =20
> -    .init        =3D spapr_irq_init_dual,
>      .claim       =3D spapr_irq_claim_dual,
>      .free        =3D spapr_irq_free_dual,
>      .print_info  =3D spapr_irq_print_info_dual,
> @@ -608,8 +536,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
> =20
>      spapr_irq_check(spapr, &local_err);
>      if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> +        goto out;
>      }
> =20
>      /* Initialize the MSI IRQ allocator. */
> @@ -617,10 +544,70 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
>          spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
>      }
> =20
> -    spapr->irq->init(spapr, errp);
> +    if (spapr->irq->xics) {
> +        Object *obj;
> +
> +        obj =3D object_new(TYPE_ICS_SPAPR);
> +        object_property_add_child(OBJECT(spapr), "ics", obj, &local_er=
r);
> +        if (local_err) {
> +            goto out;
> +        }
> +
> +        object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spap=
r),
> +                                       &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +
> +        object_property_set_int(obj, spapr->irq->nr_xirqs, "nr-irqs",
> +                                &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +
> +        object_property_set_bool(obj, true, "realized", &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +
> +        spapr->ics =3D ICS_SPAPR(obj);
> +    }
> +
> +    if (spapr->irq->xive) {
> +        uint32_t nr_servers =3D spapr_max_server_number(spapr);
> +        DeviceState *dev;
> +        int i;
> +
> +        dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> +        qdev_prop_set_uint32(dev, "nr-irqs",
> +                             spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> +        /*
> +         * 8 XIVE END structures per CPU. One for each available
> +         * priority
> +         */
> +        qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> +        qdev_init_nofail(dev);
> +
> +        spapr->xive =3D SPAPR_XIVE(dev);
> +
> +        /* Enable the CPU IPIs */
> +        for (i =3D 0; i < nr_servers; ++i) {
> +            Error *local_err =3D NULL;
> +
> +            spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false=
, &local_err);
> +            if (local_err) {
> +                goto out;
> +            }
> +        }

We could move the IPI claim part in the realize routine of SPAPR_XIVE.


> +        spapr_xive_hcall_init(spapr);

This also.

It can be done later one.

C.

> +    }
> =20
>      spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
>                                        spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
> +
> +out:
> +    error_propagate(errp, local_err);
>  }
> =20
>  void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Erro=
r **errp)
> @@ -757,7 +744,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .xics        =3D true,
>      .xive        =3D false,
> =20
> -    .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
>      .free        =3D spapr_irq_free_xics,
>      .print_info  =3D spapr_irq_print_info_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 6816cb0500..fa862c665b 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -42,7 +42,6 @@ typedef struct SpaprIrq {
>      bool        xics;
>      bool        xive;
> =20
> -    void (*init)(SpaprMachineState *spapr, Error **errp);
>      void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>      void (*free)(SpaprMachineState *spapr, int irq);
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 691a6d00f7..267984a97b 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -34,6 +34,7 @@
>  #define TYPE_ICS_SPAPR "ics-spapr"
>  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> =20
> +void ics_spapr_create(SpaprMachineState *spapr, int nr_xirqs, Error **=
errp);
>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
>                     uint32_t phandle);
>  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
>=20


