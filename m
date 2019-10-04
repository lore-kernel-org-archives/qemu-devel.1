Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A82FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D35D207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D35D207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJXg-00012P-5S
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iGJWg-0000KR-By
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iGJWe-00015z-Ub
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:05:26 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:49998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iGJWe-00010o-Mo
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:05:24 -0400
Received: from player691.ha.ovh.net (unknown [10.108.35.27])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2FAC91AED84
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 11:05:21 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 372D6AA8D105;
 Fri,  4 Oct 2019 09:05:17 +0000 (UTC)
Date: Fri, 4 Oct 2019 11:05:15 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 06/25] ppc/pnv: Implement the XiveFabric interface
Message-ID: <20191004110515.0896565c@bahia.lan>
In-Reply-To: <20190918160645.25126-7-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-7-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 815433010559687051
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrhedugddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.63.121
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

On Wed, 18 Sep 2019 18:06:26 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The CAM line matching on the PowerNV machine now scans all chips of
> the system and all CPUs of a chip to find a dispatched NVT in the
> thread contexts.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 77a86c6a2301..ca24dd62df23 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1378,6 +1378,35 @@ static void pnv_pic_print_info(InterruptStatsProvi=
der *obj,
>      }
>  }
> =20
> +static int pnv_xive_match_nvt(XiveFabric *xfb, uint8_t format,
> +                               uint8_t nvt_blk, uint32_t nvt_idx,
> +                               bool cam_ignore, uint8_t priority,
> +                               uint32_t logic_serv,
> +                               XiveTCTXMatch *match)

Hmm, patch 2 already introduces a function with the same name:

--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -392,6 +392,45 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_t =
blk, uint32_t idx,
     return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
 }
=20
+static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
+                              uint8_t nvt_blk, uint32_t nvt_idx,
+                              bool cam_ignore, uint8_t priority,
+                              uint32_t logic_serv, XiveTCTXMatch *match)
+{

This is valid because both are static functions in different compilation
units, but it usually better to avoid naming collisions (for an easier
gdb experience for example).

Anyway, I guess this isn't a problem if we reparent TM contexts to the
XIVE router, since we wouldn't need patches 1 to 3 anymore if I get it
right.

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
> @@ -1441,9 +1470,11 @@ static void pnv_machine_power8_class_init(ObjectCl=
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
> @@ -1495,6 +1526,7 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
>          .interfaces =3D (InterfaceInfo[]) {               \
>              { TYPE_XICS_FABRIC },                       \
>              { TYPE_INTERRUPT_STATS_PROVIDER },          \
> +            { TYPE_XIVE_FABRIC },                       \
>              { },                                        \
>          },                                              \
>      }


