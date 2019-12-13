Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F373DC00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713FB24125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713FB24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkbJ-0004OV-K3
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 08:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ifkZr-0003OE-MX
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ifkZn-0008Oo-Nl
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:01:49 -0500
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:43708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ifkZk-0008KC-R4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:01:45 -0500
Received: from player778.ha.ovh.net (unknown [10.109.146.175])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id CB7DC1F51B1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 14:01:42 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 8ACF3D321BE8;
 Fri, 13 Dec 2019 13:01:36 +0000 (UTC)
Subject: Re: [PATCH 08/13] ppc/pnv: Introduce PnvChipClass::xscom_core_base()
 method
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623841311.360005.4705705734873339545.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c9e8f36d-e3c3-21f5-4602-123f8b4284a9@kaod.org>
Date: Fri, 13 Dec 2019 14:01:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157623841311.360005.4705705734873339545.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10067234020864723795
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelledggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.59.196
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

On 13/12/2019 13:00, Greg Kurz wrote:
> The pnv_chip_core_realize() function configures the XSCOM MMIO subregio=
n
> for each core of a single chip. The base address of the subregion depen=
ds
> on the CPU type. Its computation is currently open-code using the
> pnv_chip_is_powerXX() helpers. This can be achieved with QOM. Introduce
> a method for this in the base chip class and implement it in child clas=
ses.

OK. We might need to introduce a PnvXscom model one day but this is fine
for now.

> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/pnv.c         |   31 ++++++++++++++++++++++++-------
>  include/hw/ppc/pnv.h |    1 +
>  2 files changed, 25 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 2a53e99bda2e..88efa755e611 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -616,6 +616,24 @@ static void pnv_chip_power9_pic_print_info(PnvChip=
 *chip, Monitor *mon)
>      pnv_psi_pic_print_info(&chip9->psi, mon);
>  }
> =20
> +static uint64_t pnv_chip_power8_xscom_core_base(PnvChip *chip,
> +                                                uint32_t core_id)
> +{
> +    return PNV_XSCOM_EX_BASE(core_id);
> +}
> +
> +static uint64_t pnv_chip_power9_xscom_core_base(PnvChip *chip,
> +                                                uint32_t core_id)
> +{
> +    return PNV9_XSCOM_EC_BASE(core_id);
> +}
> +
> +static uint64_t pnv_chip_power10_xscom_core_base(PnvChip *chip,
> +                                                 uint32_t core_id)
> +{
> +    return PNV10_XSCOM_EC_BASE(core_id);
> +}
> +
>  static bool pnv_match_cpu(const char *default_type, const char *cpu_ty=
pe)
>  {
>      PowerPCCPUClass *ppc_default =3D
> @@ -1107,6 +1125,7 @@ static void pnv_chip_power8e_class_init(ObjectCla=
ss *klass, void *data)
>      k->isa_create =3D pnv_chip_power8_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> +    k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
>      dc->desc =3D "PowerNV Chip POWER8E";
> =20
>      device_class_set_parent_realize(dc, pnv_chip_power8_realize,
> @@ -1129,6 +1148,7 @@ static void pnv_chip_power8_class_init(ObjectClas=
s *klass, void *data)
>      k->isa_create =3D pnv_chip_power8_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> +    k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
>      dc->desc =3D "PowerNV Chip POWER8";
> =20
>      device_class_set_parent_realize(dc, pnv_chip_power8_realize,
> @@ -1151,6 +1171,7 @@ static void pnv_chip_power8nvl_class_init(ObjectC=
lass *klass, void *data)
>      k->isa_create =3D pnv_chip_power8nvl_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> +    k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
>      dc->desc =3D "PowerNV Chip POWER8NVL";
> =20
>      device_class_set_parent_realize(dc, pnv_chip_power8_realize,
> @@ -1323,6 +1344,7 @@ static void pnv_chip_power9_class_init(ObjectClas=
s *klass, void *data)
>      k->isa_create =3D pnv_chip_power9_isa_create;
>      k->dt_populate =3D pnv_chip_power9_dt_populate;
>      k->pic_print_info =3D pnv_chip_power9_pic_print_info;
> +    k->xscom_core_base =3D pnv_chip_power9_xscom_core_base;
>      dc->desc =3D "PowerNV Chip POWER9";
> =20
>      device_class_set_parent_realize(dc, pnv_chip_power9_realize,
> @@ -1404,6 +1426,7 @@ static void pnv_chip_power10_class_init(ObjectCla=
ss *klass, void *data)
>      k->isa_create =3D pnv_chip_power10_isa_create;
>      k->dt_populate =3D pnv_chip_power10_dt_populate;
>      k->pic_print_info =3D pnv_chip_power10_pic_print_info;
> +    k->xscom_core_base =3D pnv_chip_power10_xscom_core_base;
>      dc->desc =3D "PowerNV Chip POWER10";
> =20
>      device_class_set_parent_realize(dc, pnv_chip_power10_realize,
> @@ -1491,13 +1514,7 @@ static void pnv_chip_core_realize(PnvChip *chip,=
 Error **errp)
>                                   &error_fatal);
> =20
>          /* Each core has an XSCOM MMIO region */
> -        if (pnv_chip_is_power10(chip)) {
> -            xscom_core_base =3D PNV10_XSCOM_EC_BASE(core_hwid);
> -        } else if (pnv_chip_is_power9(chip)) {
> -            xscom_core_base =3D PNV9_XSCOM_EC_BASE(core_hwid);
> -        } else {
> -            xscom_core_base =3D PNV_XSCOM_EX_BASE(core_hwid);
> -        }
> +        xscom_core_base =3D pcc->xscom_core_base(chip, core_hwid);
> =20
>          pnv_xscom_add_subregion(chip, xscom_core_base,
>                                  &pnv_core->xscom_regs);
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 7d2402784d4b..17ca9a14ac8f 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -137,6 +137,7 @@ typedef struct PnvChipClass {
>      ISABus *(*isa_create)(PnvChip *chip, Error **errp);
>      void (*dt_populate)(PnvChip *chip, void *fdt);
>      void (*pic_print_info)(PnvChip *chip, Monitor *mon);
> +    uint64_t (*xscom_core_base)(PnvChip *chip, uint32_t core_id);
>  } PnvChipClass;
> =20
>  #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
>=20


