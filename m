Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9C4C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52C5223CA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52C5223CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKCg-0007ra-5T
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 02:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXKBc-0007Jw-F4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXKBb-0003uo-3A
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:14:00 -0500
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:46716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXKBa-0003ru-Ti
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:13:59 -0500
Received: from player796.ha.ovh.net (unknown [10.108.42.196])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id DAE0921366C
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:13:56 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id 83952C2D5FC0;
 Wed, 20 Nov 2019 07:13:50 +0000 (UTC)
Subject: Re: [PATCH 1/5] hw/ppc/pnv: incorrect homer and occ common area size
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-2-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <15b1557e-4bb4-434e-2554-99cd475150a4@kaod.org>
Date: Wed, 20 Nov 2019 08:13:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119175056.32518-2-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16695969722412010470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.176
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
Cc: qemu-ppc@nongnu.org, groug@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/11/2019 18:50, Balamuruhan S wrote:
> Homer size is 4MB and OCC common area size is 8MB, but currently
> it is assigned with bar mask value. Also pass on the occ sram
> size 3 bits right shifted to initialize the size appropriately.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv_occ.c     | 2 +-
>  include/hw/ppc/pnv.h | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> index 785653bb67..05c51c9de0 100644
> --- a/hw/ppc/pnv_occ.c
> +++ b/hw/ppc/pnv_occ.c
> @@ -276,7 +276,7 @@ static void pnv_occ_realize(DeviceState *dev, Error=
 **errp)
> =20
>      /* XScom region for OCC SRAM registers */
>      pnv_xscom_region_init(&occ->sram_regs, OBJECT(dev), poc->sram_ops,
> -                          occ, "occ-common-area", poc->sram_size);
> +                          occ, "occ-common-area", poc->sram_size >> 3)=
;

the OCC common area seems to be accessed through MMIO also. Not only XSCO=
M.

In skiboot  :=20

    bool occ_sensors_init(void)
    {
        ...
	occ_sensor_base =3D chip->occ_common_base + OCC_SENSOR_DATA_BLOCK_OFFSET=
;
        ...
    }

OCC would need two regions. One for the XSCOM access and one for the MMIO=
.

>  }
> =20
>  static void pnv_occ_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 0b4c722e6b..e9ed8b928a 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -203,12 +203,12 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>  #define PNV_XSCOM_BASE(chip)                                          =
  \
>      (0x0003fc0000000000ull + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_S=
IZE)
> =20
> -#define PNV_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
> +#define PNV_OCC_COMMON_AREA_SIZE    0x0000000000800000ull

ok. These are the BAR sizes. Can we deduce the barmask from the size ?=20


>  #define PNV_OCC_COMMON_AREA(chip)                                     =
  \
>      (0x7fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
>                           PNV_OCC_COMMON_AREA_SIZE))
> =20
> -#define PNV_HOMER_SIZE              0x0000000000300000ull
> +#define PNV_HOMER_SIZE              0x0000000000400000ull
>  #define PNV_HOMER_BASE(chip)                                          =
  \
>      (0x7ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_HOMER_SI=
ZE)
> =20
> @@ -271,12 +271,12 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>  #define PNV9_XSCOM_SIZE              0x0000000400000000ull
>  #define PNV9_XSCOM_BASE(chip)        PNV9_CHIP_BASE(chip, 0x00603fc000=
00000ull)
> =20
> -#define PNV9_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
> +#define PNV9_OCC_COMMON_AREA_SIZE    0x0000000000800000ull
>  #define PNV9_OCC_COMMON_AREA(chip)                                    =
  \
>      (0x203fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
>                             PNV9_OCC_COMMON_AREA_SIZE))
> =20
> -#define PNV9_HOMER_SIZE              0x0000000000300000ull
> +#define PNV9_HOMER_SIZE              0x0000000000400000ull
>  #define PNV9_HOMER_BASE(chip)                                         =
  \
>      (0x203ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV9_HOMER=
_SIZE)
>  #endif /* PPC_PNV_H */
>=20


