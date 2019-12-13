Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285C2C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8E524125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8E524125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkdK-00063t-3i
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 08:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ifkbN-0004ax-35
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ifkbL-0002fI-Tx
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:03:24 -0500
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:52059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ifkbL-0002bZ-Nm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:03:23 -0500
Received: from player789.ha.ovh.net (unknown [10.109.146.131])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 2C25B145AEB
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 14:03:21 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 47D9FD36F13B;
 Fri, 13 Dec 2019 13:03:15 +0000 (UTC)
Subject: Re: [PATCH 09/13] ppc/pnv: Pass XSCOM base address and address size
 to pnv_dt_xscom()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623841868.360005.17577624823547136435.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b93304e0-8b51-cc69-e224-8c2c446e231c@kaod.org>
Date: Fri, 13 Dec 2019 14:03:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157623841868.360005.17577624823547136435.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10094818565461936979
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelledggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedu
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.60
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
> it shouldn't have to guess the chip type in order to populate the "reg"
> property. Just pass the base address and address size as arguments.

Much better,
=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/pnv.c               |   12 +++++++++---
>  hw/ppc/pnv_xscom.c         |   16 +++-------------
>  include/hw/ppc/pnv_xscom.h |    3 ++-
>  3 files changed, 14 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 88efa755e611..c532e98e752a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -282,7 +282,9 @@ static void pnv_chip_power8_dt_populate(PnvChip *ch=
ip, void *fdt)
>  {
>      int i;
> =20
> -    pnv_dt_xscom(chip, fdt, 0);
> +    pnv_dt_xscom(chip, fdt, 0,
> +                 cpu_to_be64(PNV_XSCOM_BASE(chip)),
> +                 cpu_to_be64(PNV_XSCOM_SIZE));
> =20
>      for (i =3D 0; i < chip->nr_cores; i++) {
>          PnvCore *pnv_core =3D chip->cores[i];
> @@ -302,7 +304,9 @@ static void pnv_chip_power9_dt_populate(PnvChip *ch=
ip, void *fdt)
>  {
>      int i;
> =20
> -    pnv_dt_xscom(chip, fdt, 0);
> +    pnv_dt_xscom(chip, fdt, 0,
> +                 cpu_to_be64(PNV9_XSCOM_BASE(chip)),
> +                 cpu_to_be64(PNV9_XSCOM_SIZE));
> =20
>      for (i =3D 0; i < chip->nr_cores; i++) {
>          PnvCore *pnv_core =3D chip->cores[i];
> @@ -321,7 +325,9 @@ static void pnv_chip_power10_dt_populate(PnvChip *c=
hip, void *fdt)
>  {
>      int i;
> =20
> -    pnv_dt_xscom(chip, fdt, 0);
> +    pnv_dt_xscom(chip, fdt, 0,
> +                 cpu_to_be64(PNV10_XSCOM_BASE(chip)),
> +                 cpu_to_be64(PNV10_XSCOM_SIZE));
> =20
>      for (i =3D 0; i < chip->nr_cores; i++) {
>          PnvCore *pnv_core =3D chip->cores[i];
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index df926003f2ba..8189767eb0bb 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -286,24 +286,14 @@ static const char compat_p8[] =3D "ibm,power8-xsc=
om\0ibm,xscom";
>  static const char compat_p9[] =3D "ibm,power9-xscom\0ibm,xscom";
>  static const char compat_p10[] =3D "ibm,power10-xscom\0ibm,xscom";
> =20
> -int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset)
> +int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
> +                 uint64_t xscom_base, uint64_t xscom_size)
>  {
> -    uint64_t reg[2];
> +    uint64_t reg[] =3D { xscom_base, xscom_size };
>      int xscom_offset;
>      ForeachPopulateArgs args;
>      char *name;
> =20
> -    if (pnv_chip_is_power10(chip)) {
> -        reg[0] =3D cpu_to_be64(PNV10_XSCOM_BASE(chip));
> -        reg[1] =3D cpu_to_be64(PNV10_XSCOM_SIZE);
> -    } else if (pnv_chip_is_power9(chip)) {
> -        reg[0] =3D cpu_to_be64(PNV9_XSCOM_BASE(chip));
> -        reg[1] =3D cpu_to_be64(PNV9_XSCOM_SIZE);
> -    } else {
> -        reg[0] =3D cpu_to_be64(PNV_XSCOM_BASE(chip));
> -        reg[1] =3D cpu_to_be64(PNV_XSCOM_SIZE);
> -    }
> -
>      name =3D g_strdup_printf("xscom@%" PRIx64, be64_to_cpu(reg[0]));
>      xscom_offset =3D fdt_add_subnode(fdt, root_offset, name);
>      _FDT(xscom_offset);
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 2bdb7ae84fd3..ad53f788b44c 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -114,7 +114,8 @@ typedef struct PnvXScomInterfaceClass {
>  #define PNV10_XSCOM_PSIHB_SIZE     0x100
> =20
>  void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
> -int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
> +int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
> +                 uint64_t xscom_base, uint64_t xscom_size);
> =20
>  void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
>                               MemoryRegion *mr);
>=20


