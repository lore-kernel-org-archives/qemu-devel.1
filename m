Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A903C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C572075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C572075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDlAS-0000BJ-Lt
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDl86-0006nh-HD
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDl85-0001Vh-0h
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:57:30 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:53174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDl84-0001UD-Qu
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:57:28 -0400
Received: from player726.ha.ovh.net (unknown [10.108.35.185])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 699BD1917D2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:57:26 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id 86E81A390A26;
 Fri, 27 Sep 2019 07:57:14 +0000 (UTC)
Date: Fri, 27 Sep 2019 09:57:14 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 10/33] spapr: Eliminate nr_irqs parameter to
 SpaprIrq::init
Message-ID: <20190927095714.2b7b8dea@bahia.lan>
In-Reply-To: <20190927055028.11493-11-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-11-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 13899797303545862630
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeehgdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.179.142
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

On Fri, 27 Sep 2019 15:50:05 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The only reason this parameter was needed was to work around the
> inconsistent meaning of nr_irqs between xics and xive.  Now that we've
> fixed that, we can consistently use the number directly in the SpaprIrq
> configuration.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Again ;)

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_irq.c         | 21 ++++++++++-----------
>  include/hw/ppc/spapr_irq.h |  2 +-
>  2 files changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 3207b6bd01..cded3a0154 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -92,8 +92,7 @@ static void spapr_irq_init_kvm(SpaprMachineState *spapr,
>   * XICS IRQ backend.
>   */
> =20
> -static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_xirqs,
> -                                Error **errp)
> +static void spapr_irq_init_xics(SpaprMachineState *spapr, Error **errp)
>  {
>      Object *obj;
>      Error *local_err =3D NULL;
> @@ -102,7 +101,8 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_xirqs,
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                     &error_fatal);
> -    object_property_set_int(obj, nr_xirqs, "nr-irqs",  &error_fatal);
> +    object_property_set_int(obj, spapr->irq->nr_xirqs,
> +                            "nr-irqs",  &error_fatal);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -256,15 +256,15 @@ SpaprIrq spapr_irq_xics =3D {
>  /*
>   * XIVE IRQ backend.
>   */
> -static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_xirqs,
> -                                Error **errp)
> +static void spapr_irq_init_xive(SpaprMachineState *spapr, Error **errp)
>  {
>      uint32_t nr_servers =3D spapr_max_server_number(spapr);
>      DeviceState *dev;
>      int i;
> =20
>      dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> -    qdev_prop_set_uint32(dev, "nr-irqs", nr_xirqs + SPAPR_XIRQ_BASE);
> +    qdev_prop_set_uint32(dev, "nr-irqs",
> +                         spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
>      /*
>       * 8 XIVE END structures per CPU. One for each available priority
>       */
> @@ -438,18 +438,17 @@ static SpaprIrq *spapr_irq_current(SpaprMachineStat=
e *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
> =20
> -static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_xirqs,
> -                                Error **errp)
> +static void spapr_irq_init_dual(SpaprMachineState *spapr, Error **errp)
>  {
>      Error *local_err =3D NULL;
> =20
> -    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_xirqs, &local_err);
> +    spapr_irq_xics.init(spapr, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
> =20
> -    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_xirqs, &local_err);
> +    spapr_irq_xive.init(spapr, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -678,7 +677,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
>          spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
>      }
> =20
> -    spapr->irq->init(spapr, spapr->irq->nr_xirqs, errp);
> +    spapr->irq->init(spapr, errp);
> =20
>      spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
>                                        spapr->irq->nr_xirqs + SPAPR_XIRQ_=
BASE);
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index a8f9a2ab11..7e26288fcd 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -41,7 +41,7 @@ typedef struct SpaprIrq {
>      uint32_t    nr_msis;
>      uint8_t     ov5;
> =20
> -    void (*init)(SpaprMachineState *spapr, int nr_irqs, Error **errp);
> +    void (*init)(SpaprMachineState *spapr, Error **errp);
>      int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **er=
rp);
>      void (*free)(SpaprMachineState *spapr, int irq, int num);
>      qemu_irq (*qirq)(SpaprMachineState *spapr, int irq);


