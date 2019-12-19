Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6ADC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F038206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F038206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxhM-00080a-Py
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ihxgf-000729-Rp
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ihxge-0000PX-DL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:26:01 -0500
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:39160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ihxge-0000AO-4s
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:26:00 -0500
Received: from player774.ha.ovh.net (unknown [10.108.1.112])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id BABAC1544FD
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 16:25:57 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id 1EF93D7C9DDF;
 Thu, 19 Dec 2019 15:25:52 +0000 (UTC)
Date: Thu, 19 Dec 2019 16:25:50 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 03/10] ppc/pnv: Introduce a "xics" property alias under
 the PSI model
Message-ID: <20191219162550.42204337@bahia.lan>
In-Reply-To: <20191219073001.26790-4-clg@kaod.org>
References: <20191219073001.26790-1-clg@kaod.org>
 <20191219073001.26790-4-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 10846075277694310795
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdduuddgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqfedtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.79.203
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Dec 2019 08:29:54 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> This removes the need of the intermediate link under PSI to pass the
> XICS link to the underlying ICSState object.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/pnv.c     |  4 ++--
>  hw/ppc/pnv_psi.c | 11 ++---------
>  2 files changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 2f611bfdda46..d6fe5ba13535 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -999,8 +999,6 @@ static void pnv_chip_power8_instance_init(Object *obj)
> =20
>      object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi),
>                              TYPE_PNV8_PSI, &error_abort, NULL);
> -    object_property_add_const_link(OBJECT(&chip8->psi), "xics",
> -                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
> =20
>      object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc),
>                              TYPE_PNV8_LPC, &error_abort, NULL);
> @@ -1069,6 +1067,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
>                              "bar", &error_fatal);
>      object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip->system_me=
mory),
>                               "system-memory", &error_abort);
> +    object_property_set_link(OBJECT(&chip8->psi), OBJECT(qdev_get_machin=
e()),
> +                             ICS_PROP_XICS, &error_abort);
>      object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &loc=
al_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 28d34e5c193a..d3124f673571 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -470,6 +470,8 @@ static void pnv_psi_power8_instance_init(Object *obj)
> =20
>      object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->ic=
s),
>                              TYPE_ICS, &error_abort, NULL);
> +    object_property_add_alias(obj, ICS_PROP_XICS, OBJECT(&psi8->ics),
> +                              ICS_PROP_XICS, &error_abort);
>  }
> =20
>  static const uint8_t irq_to_xivr[] =3D {
> @@ -485,21 +487,12 @@ static void pnv_psi_power8_realize(DeviceState *dev=
, Error **errp)
>  {
>      PnvPsi *psi =3D PNV_PSI(dev);
>      ICSState *ics =3D &PNV8_PSI(psi)->ics;
> -    Object *obj;
>      Error *err =3D NULL;
>      unsigned int i;
> =20
>      assert(psi->system_memory);
> =20
> -    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
> -    if (!obj) {
> -        error_setg(errp, "%s: required link 'xics' not found: %s",
> -                   __func__, error_get_pretty(err));
> -        return;
> -    }
> -
>      /* Create PSI interrupt control source */
> -    object_property_set_link(OBJECT(ics), obj, ICS_PROP_XICS, &error_abo=
rt);
>      object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs", =
&err);
>      if (err) {
>          error_propagate(errp, err);


