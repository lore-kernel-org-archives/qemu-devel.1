Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3556C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FCC2068E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FCC2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWc5k-0006Hg-PL
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWc47-0004RP-L5
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWc45-0005YR-C6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:07:19 -0500
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:36625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWc45-0005TD-4o
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:07:17 -0500
Received: from player159.ha.ovh.net (unknown [10.108.35.27])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id D495413EE55
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:07:14 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 52761C1E6A46;
 Mon, 18 Nov 2019 08:07:11 +0000 (UTC)
Subject: Re: [PATCH for-5.0 4/4] spapr: Abort if XICS interrupt controller
 cannot be initialized
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
 <157403285265.409804.8683093665795248192.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cb43b24e-182f-195b-a626-d5a48b16d708@kaod.org>
Date: Mon, 18 Nov 2019 09:07:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157403285265.409804.8683093665795248192.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5850738869892385619
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeggedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.173.157
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
> Failing to set any of the ICS property should really never happen:
> - object_property_add_child() always succeed unless the child object
>   already has a parent, which isn't the case here obviously since the
>   ICS has just been created with object_new()
> - the ICS has an "nr-irqs" property than can be set as long as the ICS
>   isn't realized
>=20
> In both cases, an error indicates there is a bug in QEMU. Propagating t=
he
> error, ie. exiting QEMU since spapr_irq_init() is called with &error_fa=
tal
> doesn't make much sense. Abort instead. This is consistent with what is
> done with XIVE : both qdev_create() and qdev_prop_set_uint32() abort QE=
MU
> on error.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/spapr_irq.c |   13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 487c8ceb35a3..37f65dac9ca8 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -313,20 +313,11 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
>          Object *obj;
> =20
>          obj =3D object_new(TYPE_ICS_SPAPR);
> -        object_property_add_child(OBJECT(spapr), "ics", obj, &local_er=
r);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> =20
> +        object_property_add_child(OBJECT(spapr), "ics", obj, &error_ab=
ort);
>          object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
>                                   &error_abort);
> -        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &local_=
err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -
> +        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &error_=
abort);
>          object_property_set_bool(obj, true, "realized", &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>=20


