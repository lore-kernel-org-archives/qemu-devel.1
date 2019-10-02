Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC12CC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D34215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D34215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFXis-0004cN-I0
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 02:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFXe5-0001gc-HW
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFXe3-00045D-SL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:57:53 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:56202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFXe3-000433-Mc
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:57:51 -0400
Received: from player786.ha.ovh.net (unknown [10.108.42.184])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id AB54E143C29
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 07:57:49 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 202B9A8A2E86;
 Wed,  2 Oct 2019 05:57:39 +0000 (UTC)
Subject: Re: [PATCH v3 09/34] spapr: Clarify and fix handling of nr_irqs
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-10-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0a680338-66b0-6a90-6425-668767185880@kaod.org>
Date: Wed, 2 Oct 2019 07:57:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002025208.3487-10-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4349632815449213849
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeehgddutdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.250.45
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
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2019 04:51, David Gibson wrote:
> Both the XICS and XIVE interrupt backends have a "nr-irqs" property, bu=
t
> it means slightly different things.  For XICS (or, strictly, the ICS) i=
t
> indicates the number of "real" external IRQs.  Those start at XICS_IRQ_=
BASE
> (0x1000) and don't include the special IPI vector.  For XIVE, however, =
it
> includes the whole IRQ space, including XIVE's many IPI vectors.
>=20
> The spapr code currently doesn't handle this sensibly, with the
> nr_irqs value in SpaprIrq having different meanings depending on the
> backend.  We fix this by renaming nr_irqs to nr_xirqs and making it
> always indicate just the number of external irqs, adjusting the value
> we pass to XIVE accordingly.  We also move to using common constants
> in most of the irq configurations, to make it clearer that the IRQ
> space looks the same to the guest (and emulated devices), even if the
> backend is different.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_irq.c         | 53 ++++++++++++++------------------------
>  include/hw/ppc/spapr_irq.h | 19 +++++++++-----
>  2 files changed, 31 insertions(+), 41 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 8c26fa2d1e..3207b6bd01 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -92,7 +92,7 @@ static void spapr_irq_init_kvm(SpaprMachineState *spa=
pr,
>   * XICS IRQ backend.
>   */
> =20
> -static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
> +static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_xirqs=
,
>                                  Error **errp)
>  {
>      Object *obj;
> @@ -102,7 +102,7 @@ static void spapr_irq_init_xics(SpaprMachineState *=
spapr, int nr_irqs,
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort)=
;
>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                     &error_fatal);
> -    object_property_set_int(obj, nr_irqs, "nr-irqs",  &error_fatal);
> +    object_property_set_int(obj, nr_xirqs, "nr-irqs",  &error_fatal);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -234,13 +234,9 @@ static void spapr_irq_init_kvm_xics(SpaprMachineSt=
ate *spapr, Error **errp)
>      }
>  }
> =20
> -#define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> -#define SPAPR_IRQ_XICS_NR_MSIS     \
> -    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> -
>  SpaprIrq spapr_irq_xics =3D {
> -    .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
> -    .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
> +    .nr_xirqs    =3D SPAPR_NR_XIRQS,
> +    .nr_msis     =3D SPAPR_NR_MSIS,
>      .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
> =20
>      .init        =3D spapr_irq_init_xics,
> @@ -260,7 +256,7 @@ SpaprIrq spapr_irq_xics =3D {
>  /*
>   * XIVE IRQ backend.
>   */
> -static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_irqs,
> +static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_xirqs=
,
>                                  Error **errp)
>  {
>      uint32_t nr_servers =3D spapr_max_server_number(spapr);
> @@ -268,7 +264,7 @@ static void spapr_irq_init_xive(SpaprMachineState *=
spapr, int nr_irqs,
>      int i;
> =20
>      dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> -    qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
> +    qdev_prop_set_uint32(dev, "nr-irqs", nr_xirqs + SPAPR_XIRQ_BASE);
>      /*
>       * 8 XIVE END structures per CPU. One for each available priority
>       */
> @@ -308,7 +304,7 @@ static qemu_irq spapr_qirq_xive(SpaprMachineState *=
spapr, int irq)
>  {
>      SpaprXive *xive =3D spapr->xive;
> =20
> -    if (irq >=3D xive->nr_irqs) {
> +    if ((irq < SPAPR_XIRQ_BASE) || (irq >=3D xive->nr_irqs)) {
>          return NULL;
>      }
> =20
> @@ -404,17 +400,9 @@ static void spapr_irq_init_kvm_xive(SpaprMachineSt=
ate *spapr, Error **errp)
>      }
>  }
> =20
> -/*
> - * XIVE uses the full IRQ number space. Set it to 8K to be compatible
> - * with XICS.
> - */
> -
> -#define SPAPR_IRQ_XIVE_NR_IRQS     0x2000
> -#define SPAPR_IRQ_XIVE_NR_MSIS     (SPAPR_IRQ_XIVE_NR_IRQS - SPAPR_IRQ=
_MSI)
> -
>  SpaprIrq spapr_irq_xive =3D {
> -    .nr_irqs     =3D SPAPR_IRQ_XIVE_NR_IRQS,
> -    .nr_msis     =3D SPAPR_IRQ_XIVE_NR_MSIS,
> +    .nr_xirqs    =3D SPAPR_NR_XIRQS,
> +    .nr_msis     =3D SPAPR_NR_MSIS,
>      .ov5         =3D SPAPR_OV5_XIVE_EXPLOIT,
> =20
>      .init        =3D spapr_irq_init_xive,
> @@ -450,18 +438,18 @@ static SpaprIrq *spapr_irq_current(SpaprMachineSt=
ate *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
> =20
> -static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_irqs,
> +static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_xirqs=
,
>                                  Error **errp)
>  {
>      Error *local_err =3D NULL;
> =20
> -    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_irqs, &local_err);
> +    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_xirqs, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
> =20
> -    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_irqs, &local_err);
> +    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_xirqs, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -586,12 +574,9 @@ static const char *spapr_irq_get_nodename_dual(Spa=
prMachineState *spapr)
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> -#define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
> -#define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IRQ=
_MSI)
> -
>  SpaprIrq spapr_irq_dual =3D {
> -    .nr_irqs     =3D SPAPR_IRQ_DUAL_NR_IRQS,
> -    .nr_msis     =3D SPAPR_IRQ_DUAL_NR_MSIS,
> +    .nr_xirqs    =3D SPAPR_NR_XIRQS,
> +    .nr_msis     =3D SPAPR_NR_MSIS,
>      .ov5         =3D SPAPR_OV5_XIVE_BOTH,
> =20
>      .init        =3D spapr_irq_init_dual,
> @@ -693,10 +678,10 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
>          spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
>      }
> =20
> -    spapr->irq->init(spapr, spapr->irq->nr_irqs, errp);
> +    spapr->irq->init(spapr, spapr->irq->nr_xirqs, errp);
> =20
>      spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
> -                                      spapr->irq->nr_irqs);
> +                                      spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
>  }
> =20
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> @@ -804,11 +789,11 @@ int spapr_irq_find(SpaprMachineState *spapr, int =
num, bool align, Error **errp)
>      return first + ics->offset;
>  }
> =20
> -#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
> +#define SPAPR_IRQ_XICS_LEGACY_NR_XIRQS     0x400
> =20
>  SpaprIrq spapr_irq_xics_legacy =3D {
> -    .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> -    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> +    .nr_xirqs    =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
> +    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
>      .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
> =20
>      .init        =3D spapr_irq_init_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 5db305165c..a8f9a2ab11 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -16,13 +16,18 @@
>   * IRQ range offsets per device type
>   */
>  #define SPAPR_IRQ_IPI        0x0
> -#define SPAPR_IRQ_EPOW       0x1000  /* XICS_IRQ_BASE offset */
> -#define SPAPR_IRQ_HOTPLUG    0x1001
> -#define SPAPR_IRQ_VIO        0x1100  /* 256 VIO devices */
> -#define SPAPR_IRQ_PCI_LSI    0x1200  /* 32+ PHBs devices */
> =20
> -#define SPAPR_IRQ_MSI        0x1300  /* Offset of the dynamic range co=
vered
> -                                      * by the bitmap allocator */
> +#define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
> +#define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
> +#define SPAPR_IRQ_HOTPLUG    (SPAPR_XIRQ_BASE + 0x0001)
> +#define SPAPR_IRQ_VIO        (SPAPR_XIRQ_BASE + 0x0100)  /* 256 VIO de=
vices */
> +#define SPAPR_IRQ_PCI_LSI    (SPAPR_XIRQ_BASE + 0x0200)  /* 32+ PHBs d=
evices */
> +
> +/* Offset of the dynamic range covered by the bitmap allocator */
> +#define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
> +
> +#define SPAPR_NR_XIRQS       0x1000
> +#define SPAPR_NR_MSIS        (SPAPR_XIRQ_BASE + SPAPR_NR_XIRQS - SPAPR=
_IRQ_MSI)
> =20
>  typedef struct SpaprMachineState SpaprMachineState;
> =20
> @@ -32,7 +37,7 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uin=
t32_t num, bool align,
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t nu=
m);
> =20
>  typedef struct SpaprIrq {
> -    uint32_t    nr_irqs;
> +    uint32_t    nr_xirqs;
>      uint32_t    nr_msis;
>      uint8_t     ov5;
> =20
>=20


