Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913E0C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AC72071C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AC72071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWc1h-0001bp-D4
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWc06-0000cE-Bn
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWc05-0000N2-67
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:03:10 -0500
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:35508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWc04-0000HP-Ud
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:03:09 -0500
Received: from player687.ha.ovh.net (unknown [10.108.42.228])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0616923034D
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:03:05 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id B2182C2D37EE;
 Mon, 18 Nov 2019 08:03:01 +0000 (UTC)
Subject: Re: [PATCH for-5.0 1/4] xics: Link ICS_PROP_XICS property to
 ICSState::xics pointer
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
 <157403283596.409804.17347207690271971987.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <19b058f8-f71f-a224-a9f2-d92caa0b844e@kaod.org>
Date: Mon, 18 Nov 2019 09:03:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157403283596.409804.17347207690271971987.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5780651600646343507
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeggedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepud
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.43.98
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/11/2019 00:20, Greg Kurz wrote:
> The ICS object has both a pointer and an ICS_PROP_XICS property pointin=
g
> to the XICS fabric. Confusing bugs could arise if these ever go out of
> sync.
>=20
> Change the property definition so that it explicitely sets the pointer.
> The property isn't optional : not being able to set the link is a bug
> and QEMU should rather abort than exit in this case.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  hw/intc/xics.c     |   13 +++----------
>  hw/ppc/pnv_psi.c   |    3 +--
>  hw/ppc/spapr_irq.c |    9 ++-------
>  3 files changed, 6 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index e7ac9ba618fa..f7a454808992 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -609,17 +609,8 @@ static void ics_reset_handler(void *dev)
>  static void ics_realize(DeviceState *dev, Error **errp)
>  {
>      ICSState *ics =3D ICS(dev);
> -    Error *local_err =3D NULL;
> -    Object *obj;
> =20
> -    obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &loca=
l_err);
> -    if (!obj) {
> -        error_propagate_prepend(errp, local_err,
> -                                "required link '" ICS_PROP_XICS
> -                                "' not found: ");
> -        return;
> -    }
> -    ics->xics =3D XICS_FABRIC(obj);
> +    assert(ics->xics);
> =20
>      if (!ics->nr_irqs) {
>          error_setg(errp, "Number of interrupts needs to be greater 0")=
;
> @@ -699,6 +690,8 @@ static const VMStateDescription vmstate_ics =3D {
> =20
>  static Property ics_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
> +    DEFINE_PROP_LINK(ICS_PROP_XICS, ICSState, xics, TYPE_XICS_FABRIC,
> +                     XICSFabric *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index a360515a86f8..7e725aaf2bd5 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -497,8 +497,7 @@ static void pnv_psi_power8_realize(DeviceState *dev=
, Error **errp)
>      }
> =20
>      /* Create PSI interrupt control source */
> -    object_property_add_const_link(OBJECT(ics), ICS_PROP_XICS, obj,
> -                                   &error_abort);
> +    object_property_set_link(OBJECT(ics), obj, ICS_PROP_XICS, &error_a=
bort);
>      object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs"=
, &err);
>      if (err) {
>          error_propagate(errp, err);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 168044be853a..487c8ceb35a3 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -319,13 +319,8 @@ void spapr_irq_init(SpaprMachineState *spapr, Erro=
r **errp)
>              return;
>          }
> =20
> -        object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spap=
r),
> -                                       &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -
> +        object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
> +                                 &error_abort);
>          object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &local_=
err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>=20


