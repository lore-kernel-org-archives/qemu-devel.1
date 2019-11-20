Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48760C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207F52080F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207F52080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXU4R-0000f2-B5
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXTzD-0003vx-0z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXTz9-0006iX-Bi
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:41:50 -0500
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:45472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXTz9-0006h4-3t
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:41:47 -0500
Received: from player168.ha.ovh.net (unknown [10.109.146.82])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 84B3D1B544F
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 18:41:44 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 7311EC3F4844;
 Wed, 20 Nov 2019 17:41:40 +0000 (UTC)
Date: Wed, 20 Nov 2019 18:41:39 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 13/23] ppc/pnv: Implement the XiveFabric
 interface
Message-ID: <20191120184139.18442da3@bahia.lan>
In-Reply-To: <20191115162436.30548-14-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-14-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 8851825070155995531
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduieekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.48.182
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

On Fri, 15 Nov 2019 17:24:26 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The CAM line matching on the PowerNV machine now scans all chips of
> the system and all CPUs of a chip to find a dispatched NVT in the
> thread contexts.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/pnv.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 94c9f536413f..207a5cf2c650 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1446,6 +1446,35 @@ static void pnv_pic_print_info(InterruptStatsProvi=
der *obj,
>      }
>  }
> =20
> +static int pnv_xive_match_nvt(XiveFabric *xfb, uint8_t format,
> +                               uint8_t nvt_blk, uint32_t nvt_idx,
> +                               bool cam_ignore, uint8_t priority,
> +                               uint32_t logic_serv,
> +                               XiveTCTXMatch *match)
> +{
> +    PnvMachineState *pnv =3D PNV_MACHINE(xfb);
> +    int total_count =3D 0;
> +    int i;
> +
> +    for (i =3D 0; i < pnv->num_chips; i++) {
> +        Pnv9Chip *chip9 =3D PNV9_CHIP(pnv->chips[i]);
> +        XivePresenter *xptr =3D XIVE_PRESENTER(&chip9->xive);
> +        XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
> +        int count;
> +
> +        count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ign=
ore,
> +                               priority, logic_serv, match);
> +
> +        if (count < 0) {
> +            return count;
> +        }
> +
> +        total_count +=3D count;
> +    }
> +
> +    return total_count;
> +}
> +
>  static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
> @@ -1509,9 +1538,11 @@ static void pnv_machine_power8_class_init(ObjectCl=
ass *oc, void *data)
>  static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
> +    xfc->match_nvt =3D pnv_xive_match_nvt;
> =20
>      mc->alias =3D "powernv";
>  }
> @@ -1558,6 +1589,10 @@ static const TypeInfo types[] =3D {
>          .name          =3D MACHINE_TYPE_NAME("powernv9"),
>          .parent        =3D TYPE_PNV_MACHINE,
>          .class_init    =3D pnv_machine_power9_class_init,
> +        .interfaces =3D (InterfaceInfo[]) {
> +            { TYPE_XIVE_FABRIC },
> +            { },
> +        },
>      },
>      {
>          .name          =3D MACHINE_TYPE_NAME("powernv8"),


