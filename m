Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF444C2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB2D21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB2D21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifke6-0006pE-07
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 08:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ifkby-00052d-Ai
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ifkbw-0003Xh-0I
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:04:02 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:48214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ifkbv-0003SA-6U
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:03:59 -0500
Received: from player159.ha.ovh.net (unknown [10.108.1.153])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5D9C51F5064
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 14:03:56 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id AB897D2AC495;
 Fri, 13 Dec 2019 13:03:50 +0000 (UTC)
Subject: Re: [PATCH 10/13] ppc/pnv: Pass content of the "compatible" property
 to pnv_dt_xscom()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623842430.360005.9513965612524265862.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <763b4837-6dc6-20bd-e626-a86bbe77aba9@kaod.org>
Date: Fri, 13 Dec 2019 14:03:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157623842430.360005.9513965612524265862.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10104951664664611667
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelledggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedu
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.139.208
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
> Since pnv_dt_xscom() is called from chip specific dt_populate() hooks,
> it shouldn't have to guess the chip type in order to populate the
> "compatible" property. Just pass the compat string and its size as
> arguments.

Yeah. That is where I think a PnXscom model and class could be a little
cleaner. This is minor.

> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/pnv.c               |   12 +++++++++---
>  hw/ppc/pnv_xscom.c         |   20 +++-----------------
>  include/hw/ppc/pnv_xscom.h |    3 ++-
>  3 files changed, 14 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c532e98e752a..0447b534b8c5 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -280,11 +280,13 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, =
uint32_t pir,
> =20
>  static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
>  {
> +    static const char compat[] =3D "ibm,power8-xscom\0ibm,xscom";
>      int i;
> =20
>      pnv_dt_xscom(chip, fdt, 0,
>                   cpu_to_be64(PNV_XSCOM_BASE(chip)),
> -                 cpu_to_be64(PNV_XSCOM_SIZE));
> +                 cpu_to_be64(PNV_XSCOM_SIZE),
> +                 compat, sizeof(compat));
> =20
>      for (i =3D 0; i < chip->nr_cores; i++) {
>          PnvCore *pnv_core =3D chip->cores[i];
> @@ -302,11 +304,13 @@ static void pnv_chip_power8_dt_populate(PnvChip *=
chip, void *fdt)
> =20
>  static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
>  {
> +    static const char compat[] =3D "ibm,power9-xscom\0ibm,xscom";
>      int i;
> =20
>      pnv_dt_xscom(chip, fdt, 0,
>                   cpu_to_be64(PNV9_XSCOM_BASE(chip)),
> -                 cpu_to_be64(PNV9_XSCOM_SIZE));
> +                 cpu_to_be64(PNV9_XSCOM_SIZE),
> +                 compat, sizeof(compat));
> =20
>      for (i =3D 0; i < chip->nr_cores; i++) {
>          PnvCore *pnv_core =3D chip->cores[i];
> @@ -323,11 +327,13 @@ static void pnv_chip_power9_dt_populate(PnvChip *=
chip, void *fdt)
> =20
>  static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>  {
> +    static const char compat[] =3D "ibm,power10-xscom\0ibm,xscom";
>      int i;
> =20
>      pnv_dt_xscom(chip, fdt, 0,
>                   cpu_to_be64(PNV10_XSCOM_BASE(chip)),
> -                 cpu_to_be64(PNV10_XSCOM_SIZE));
> +                 cpu_to_be64(PNV10_XSCOM_SIZE),
> +                 compat, sizeof(compat));
> =20
>      for (i =3D 0; i < chip->nr_cores; i++) {
>          PnvCore *pnv_core =3D chip->cores[i];
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 8189767eb0bb..5ae9dfbb88ad 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -282,12 +282,9 @@ static int xscom_dt_child(Object *child, void *opa=
que)
>      return 0;
>  }
> =20
> -static const char compat_p8[] =3D "ibm,power8-xscom\0ibm,xscom";
> -static const char compat_p9[] =3D "ibm,power9-xscom\0ibm,xscom";
> -static const char compat_p10[] =3D "ibm,power10-xscom\0ibm,xscom";
> -
>  int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
> -                 uint64_t xscom_base, uint64_t xscom_size)
> +                 uint64_t xscom_base, uint64_t xscom_size,
> +                 const char *compat, int compat_size)
>  {
>      uint64_t reg[] =3D { xscom_base, xscom_size };
>      int xscom_offset;
> @@ -302,18 +299,7 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int roo=
t_offset,
>      _FDT((fdt_setprop_cell(fdt, xscom_offset, "#address-cells", 1)));
>      _FDT((fdt_setprop_cell(fdt, xscom_offset, "#size-cells", 1)));
>      _FDT((fdt_setprop(fdt, xscom_offset, "reg", reg, sizeof(reg))));
> -
> -    if (pnv_chip_is_power10(chip)) {
> -        _FDT((fdt_setprop(fdt, xscom_offset, "compatible", compat_p10,
> -                          sizeof(compat_p10))));
> -    } else if (pnv_chip_is_power9(chip)) {
> -        _FDT((fdt_setprop(fdt, xscom_offset, "compatible", compat_p9,
> -                          sizeof(compat_p9))));
> -    } else {
> -        _FDT((fdt_setprop(fdt, xscom_offset, "compatible", compat_p8,
> -                          sizeof(compat_p8))));
> -    }
> -
> +    _FDT((fdt_setprop(fdt, xscom_offset, "compatible", compat, compat_=
size)));
>      _FDT((fdt_setprop(fdt, xscom_offset, "scom-controller", NULL, 0)))=
;
> =20
>      args.fdt =3D fdt;
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index ad53f788b44c..f74c81a980f3 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -115,7 +115,8 @@ typedef struct PnvXScomInterfaceClass {
> =20
>  void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
>  int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
> -                 uint64_t xscom_base, uint64_t xscom_size);
> +                 uint64_t xscom_base, uint64_t xscom_size,
> +                 const char *compat, int compat_size);
> =20
>  void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
>                               MemoryRegion *mr);
>=20


