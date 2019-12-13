Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C25C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED0424671
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED0424671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkID-00084m-O5
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ifkHQ-0007Hq-4t
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ifkHL-00022k-64
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:42:47 -0500
Received: from 8.mo7.mail-out.ovh.net ([46.105.77.114]:55519)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ifkHK-0001yV-Un
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:42:43 -0500
Received: from player696.ha.ovh.net (unknown [10.108.1.202])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 57D8A147295
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 13:42:40 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id A8F61D516898;
 Fri, 13 Dec 2019 12:42:32 +0000 (UTC)
Subject: Re: [PATCH 02/13] ppc/pnv: Introduce PnvPsiClass::compat
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623837974.360005.14706607446188964477.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a4240408-f53f-36b5-786a-f7f915027a58@kaod.org>
Date: Fri, 13 Dec 2019 13:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157623837974.360005.14706607446188964477.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9745508121677171539
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelledggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.77.114
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

On 13/12/2019 12:59, Greg Kurz wrote:
> The Processor Service Interface (PSI) model has a chip_type class level
> attribute, which is used to generate the content of the "compatible" DT
> property according to the CPU type.
>=20
> Since the PSI model already has specialized classes for each supported
> CPU type, it seems cleaner to achieve this with QOM. Provide the conten=
t
> of the "compatible" property with a new class level attribute.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/pnv_psi.c         |   25 +++++++++++--------------
>  include/hw/ppc/pnv_psi.h |    2 ++
>  2 files changed, 13 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 572924388b3c..98a82b25e01f 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -536,10 +536,6 @@ static void pnv_psi_power8_realize(DeviceState *de=
v, Error **errp)
>      qemu_register_reset(pnv_psi_reset, dev);
>  }
> =20
> -static const char compat_p8[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
> -static const char compat_p9[] =3D "ibm,power9-psihb-x\0ibm,psihb-x";
> -static const char compat_p10[] =3D "ibm,power10-psihb-x\0ibm,psihb-x";
> -
>  static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xsc=
om_offset)
>  {
>      PnvPsiClass *ppc =3D PNV_PSI_GET_CLASS(dev);
> @@ -558,16 +554,8 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *dev=
, void *fdt, int xscom_offset)
>      _FDT(fdt_setprop(fdt, offset, "reg", reg, sizeof(reg)));
>      _FDT(fdt_setprop_cell(fdt, offset, "#address-cells", 2));
>      _FDT(fdt_setprop_cell(fdt, offset, "#size-cells", 1));
> -    if (ppc->chip_type =3D=3D PNV_CHIP_POWER10) {
> -        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p10,
> -                         sizeof(compat_p10)));
> -    } else if (ppc->chip_type =3D=3D PNV_CHIP_POWER9) {
> -        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p9,
> -                         sizeof(compat_p9)));
> -    } else {
> -        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p8,
> -                         sizeof(compat_p8)));
> -    }
> +    _FDT(fdt_setprop(fdt, offset, "compatible", ppc->compat,
> +                     ppc->compat_size));
>      return 0;
>  }
> =20
> @@ -581,6 +569,7 @@ static void pnv_psi_power8_class_init(ObjectClass *=
klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
> +    static const char compat[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
> =20
>      dc->desc    =3D "PowerNV PSI Controller POWER8";
>      dc->realize =3D pnv_psi_power8_realize;
> @@ -590,6 +579,8 @@ static void pnv_psi_power8_class_init(ObjectClass *=
klass, void *data)
>      ppc->xscom_size =3D PNV_XSCOM_PSIHB_SIZE;
>      ppc->bar_mask   =3D PSIHB_BAR_MASK;
>      ppc->irq_set    =3D pnv_psi_power8_irq_set;
> +    ppc->compat     =3D compat;
> +    ppc->compat_size =3D sizeof(compat);
>  }
> =20
>  static const TypeInfo pnv_psi_power8_info =3D {
> @@ -888,6 +879,7 @@ static void pnv_psi_power9_class_init(ObjectClass *=
klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
>      XiveNotifierClass *xfc =3D XIVE_NOTIFIER_CLASS(klass);
> +    static const char compat[] =3D "ibm,power9-psihb-x\0ibm,psihb-x";
> =20
>      dc->desc    =3D "PowerNV PSI Controller POWER9";
>      dc->realize =3D pnv_psi_power9_realize;
> @@ -897,6 +889,8 @@ static void pnv_psi_power9_class_init(ObjectClass *=
klass, void *data)
>      ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
>      ppc->bar_mask   =3D PSIHB9_BAR_MASK;
>      ppc->irq_set    =3D pnv_psi_power9_irq_set;
> +    ppc->compat     =3D compat;
> +    ppc->compat_size =3D sizeof(compat);
> =20
>      xfc->notify      =3D pnv_psi_notify;
>  }
> @@ -917,12 +911,15 @@ static void pnv_psi_power10_class_init(ObjectClas=
s *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
> +    static const char compat[] =3D "ibm,power10-psihb-x\0ibm,psihb-x";
> =20
>      dc->desc    =3D "PowerNV PSI Controller POWER10";
> =20
>      ppc->chip_type  =3D PNV_CHIP_POWER10;
>      ppc->xscom_pcba =3D PNV10_XSCOM_PSIHB_BASE;
>      ppc->xscom_size =3D PNV10_XSCOM_PSIHB_SIZE;
> +    ppc->compat     =3D compat;
> +    ppc->compat_size =3D sizeof(compat);
>  }
> =20
>  static const TypeInfo pnv_psi_power10_info =3D {
> diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
> index a044aab304ae..fc068c95e543 100644
> --- a/include/hw/ppc/pnv_psi.h
> +++ b/include/hw/ppc/pnv_psi.h
> @@ -83,6 +83,8 @@ typedef struct PnvPsiClass {
>      uint32_t xscom_pcba;
>      uint32_t xscom_size;
>      uint64_t bar_mask;
> +    const char *compat;
> +    int compat_size;
> =20
>      void (*irq_set)(PnvPsi *psi, int, bool state);
>  } PnvPsiClass;
>=20


