Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19794C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E372071C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E372071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWc2W-0002v7-1h
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWc1H-0001YY-1M
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWc1F-0001yN-Oi
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:04:22 -0500
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:42325)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWc1F-0001w8-GC
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:04:21 -0500
Received: from player773.ha.ovh.net (unknown [10.109.159.48])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6915E19AB7D
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:04:19 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id 0DC28C36425C;
 Mon, 18 Nov 2019 08:04:14 +0000 (UTC)
Subject: Re: [PATCH for-5.0 3/4] xics: Link ICP_PROP_CPU property to
 ICPState::cs pointer
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157403283036.409804.13586263493813758117.stgit@bahia.lan>
 <157403284709.409804.16142099083325945141.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cf7b4c63-9e46-6e5c-e7e7-8996893a5374@kaod.org>
Date: Mon, 18 Nov 2019 09:04:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157403284709.409804.16142099083325945141.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5801199272434895699
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeggedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/11/2019 00:20, Greg Kurz wrote:
> The ICP object has both a pointer and an ICP_PROP_CPU property pointing
> to the cpu. Confusing bugs could arise if these ever go out of sync.
>=20
> Change the property definition so that it explicitely sets the pointer.

 explicitly

> The property isn't optional : not being able to set the link is a bug
> and QEMU should rather abort than exit in this case.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  hw/intc/xics.c |   21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 35dddb88670e..0b259a09c545 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -305,25 +305,13 @@ void icp_reset(ICPState *icp)
>  static void icp_realize(DeviceState *dev, Error **errp)
>  {
>      ICPState *icp =3D ICP(dev);
> -    PowerPCCPU *cpu;
>      CPUPPCState *env;
> -    Object *obj;
>      Error *err =3D NULL;
> =20
>      assert(icp->xics);
> +    assert(icp->cs);
> =20
> -    obj =3D object_property_get_link(OBJECT(dev), ICP_PROP_CPU, &err);
> -    if (!obj) {
> -        error_propagate_prepend(errp, err,
> -                                "required link '" ICP_PROP_CPU
> -                                "' not found: ");
> -        return;
> -    }
> -
> -    cpu =3D POWERPC_CPU(obj);
> -    icp->cs =3D CPU(obj);
> -
> -    env =3D &cpu->env;
> +    env =3D &POWERPC_CPU(icp->cs)->env;
>      switch (PPC_INPUT(env)) {
>      case PPC_FLAGS_INPUT_POWER7:
>          icp->output =3D env->irq_inputs[POWER7_INPUT_INT];
> @@ -363,6 +351,7 @@ static void icp_unrealize(DeviceState *dev, Error *=
*errp)
>  static Property icp_properties[] =3D {
>      DEFINE_PROP_LINK(ICP_PROP_XICS, ICPState, xics, TYPE_XICS_FABRIC,
>                       XICSFabric *),
> +    DEFINE_PROP_LINK(ICP_PROP_CPU, ICPState, cs, TYPE_CPU, CPUState *)=
,
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -397,8 +386,7 @@ Object *icp_create(Object *cpu, const char *type, X=
ICSFabric *xi, Error **errp)
>      object_property_add_child(cpu, type, obj, &error_abort);
>      object_unref(obj);
>      object_property_set_link(obj, OBJECT(xi), ICP_PROP_XICS, &error_ab=
ort);
> -    object_ref(cpu);
> -    object_property_add_const_link(obj, ICP_PROP_CPU, cpu, &error_abor=
t);
> +    object_property_set_link(obj, cpu, ICP_PROP_CPU, &error_abort);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>          object_unparent(obj);
> @@ -413,7 +401,6 @@ void icp_destroy(ICPState *icp)
>  {
>      Object *obj =3D OBJECT(icp);
> =20
> -    object_unref(object_property_get_link(obj, ICP_PROP_CPU, &error_ab=
ort));
>      object_unparent(obj);
>  }
> =20
>=20


