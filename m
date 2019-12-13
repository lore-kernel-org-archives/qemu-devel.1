Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A30C2D0CC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0243024125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0243024125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkJ2-0000jg-4B
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ifkIB-0008EC-LI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ifkIA-00038F-Ic
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:43:35 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:54620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ifkIA-00035v-B8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:43:34 -0500
Received: from player735.ha.ovh.net (unknown [10.109.146.50])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7F7D81B5F09
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 13:43:32 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id 51723D2F24B8;
 Fri, 13 Dec 2019 12:43:26 +0000 (UTC)
Subject: Re: [PATCH 03/13] ppc/pnv: Drop PnvPsiClass::chip_type
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623838530.360005.15470128760871845396.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7fde18e9-153b-bea7-ffc9-eb161fa8ea81@kaod.org>
Date: Fri, 13 Dec 2019 13:43:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157623838530.360005.15470128760871845396.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9760426295776349011
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelledggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.181.248
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
> It isn't used anymore.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/pnv_psi.c         |    3 ---
>  include/hw/ppc/pnv_psi.h |    1 -
>  2 files changed, 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 98a82b25e01f..75e20d9da08b 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -574,7 +574,6 @@ static void pnv_psi_power8_class_init(ObjectClass *=
klass, void *data)
>      dc->desc    =3D "PowerNV PSI Controller POWER8";
>      dc->realize =3D pnv_psi_power8_realize;
> =20
> -    ppc->chip_type =3D  PNV_CHIP_POWER8;
>      ppc->xscom_pcba =3D PNV_XSCOM_PSIHB_BASE;
>      ppc->xscom_size =3D PNV_XSCOM_PSIHB_SIZE;
>      ppc->bar_mask   =3D PSIHB_BAR_MASK;
> @@ -884,7 +883,6 @@ static void pnv_psi_power9_class_init(ObjectClass *=
klass, void *data)
>      dc->desc    =3D "PowerNV PSI Controller POWER9";
>      dc->realize =3D pnv_psi_power9_realize;
> =20
> -    ppc->chip_type  =3D PNV_CHIP_POWER9;
>      ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
>      ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
>      ppc->bar_mask   =3D PSIHB9_BAR_MASK;
> @@ -915,7 +913,6 @@ static void pnv_psi_power10_class_init(ObjectClass =
*klass, void *data)
> =20
>      dc->desc    =3D "PowerNV PSI Controller POWER10";
> =20
> -    ppc->chip_type  =3D PNV_CHIP_POWER10;
>      ppc->xscom_pcba =3D PNV10_XSCOM_PSIHB_BASE;
>      ppc->xscom_size =3D PNV10_XSCOM_PSIHB_SIZE;
>      ppc->compat     =3D compat;
> diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
> index fc068c95e543..f0f5b5519767 100644
> --- a/include/hw/ppc/pnv_psi.h
> +++ b/include/hw/ppc/pnv_psi.h
> @@ -79,7 +79,6 @@ typedef struct Pnv9Psi {
>  typedef struct PnvPsiClass {
>      SysBusDeviceClass parent_class;
> =20
> -    int chip_type;
>      uint32_t xscom_pcba;
>      uint32_t xscom_size;
>      uint64_t bar_mask;
>=20


