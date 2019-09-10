Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ED0C49ED6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3482E20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3482E20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7aP2-0007ch-Cc
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i7aO9-00072e-RG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i7aO8-0000FX-A9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:16:33 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:46608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i7aO8-0000Ei-3o
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:16:32 -0400
Received: from player728.ha.ovh.net (unknown [10.108.57.18])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id DA66E226D02
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 09:16:29 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id 55AE198B7F24;
 Tue, 10 Sep 2019 07:16:20 +0000 (UTC)
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20190910071019.16689-1-bala24@linux.ibm.com>
 <20190910071019.16689-2-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3733cbe3-41dc-2748-0b1a-80453c26582b@kaod.org>
Date: Tue, 10 Sep 2019 09:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910071019.16689-2-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5606137113925356370
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudekjedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.36
Subject: Re: [Qemu-devel] [PATCH v1 1/3] hw/ppc/pnv_xscom: retrieve
 homer/occ base address from PBA BARs
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
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, groug@kaod.org,
 hari@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/2019 09:10, Balamuruhan S wrote:
> During PowerNV boot skiboot populates the device tree by
> retrieving base address of homer/occ common area from
> PBA BARs and prd ipoll mask by accessing xscom read/write
> accesses.
>=20
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>

LGTM,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv_xscom.c   | 34 ++++++++++++++++++++++++++++++----
>  include/hw/ppc/pnv.h | 18 ++++++++++++++++++
>  2 files changed, 48 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 67aab98fef..f01d788a65 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -36,6 +36,16 @@
>  #define PRD_P9_IPOLL_REG_MASK           0x000F0033
>  #define PRD_P9_IPOLL_REG_STATUS         0x000F0034
> =20
> +/* PBA BARs */
> +#define P8_PBA_BAR0                     0x2013f00
> +#define P8_PBA_BAR2                     0x2013f02
> +#define P8_PBA_BARMASK0                 0x2013f04
> +#define P8_PBA_BARMASK2                 0x2013f06
> +#define P9_PBA_BAR0                     0x5012b00
> +#define P9_PBA_BAR2                     0x5012b02
> +#define P9_PBA_BARMASK0                 0x5012b04
> +#define P9_PBA_BARMASK2                 0x5012b06
> +
>  static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
>  {
>      /*
> @@ -74,6 +84,26 @@ static uint64_t xscom_read_default(PnvChip *chip, ui=
nt32_t pcba)
>      case 0x18002:       /* ECID2 */
>          return 0;
> =20
> +    case P9_PBA_BAR0:
> +        return PNV9_HOMER_BASE(chip);
> +    case P8_PBA_BAR0:
> +        return PNV_HOMER_BASE(chip);
> +
> +    case P9_PBA_BARMASK0: /* P9 homer region size */
> +        return PNV9_HOMER_SIZE;
> +    case P8_PBA_BARMASK0: /* P8 homer region size */
> +        return PNV_HOMER_SIZE;
> +
> +    case P9_PBA_BAR2: /* P9 occ common area */
> +        return PNV9_OCC_COMMON_AREA(chip);
> +    case P8_PBA_BAR2: /* P8 occ common area */
> +        return PNV_OCC_COMMON_AREA(chip);
> +
> +    case P9_PBA_BARMASK2: /* P9 occ common area size */
> +        return PNV9_OCC_COMMON_AREA_SIZE;
> +    case P8_PBA_BARMASK2: /* P8 occ common area size */
> +        return PNV_OCC_COMMON_AREA_SIZE;
> +
>      case 0x1010c00:     /* PIBAM FIR */
>      case 0x1010c03:     /* PIBAM FIR MASK */
> =20
> @@ -93,13 +123,9 @@ static uint64_t xscom_read_default(PnvChip *chip, u=
int32_t pcba)
>      case 0x2020009:     /* ADU stuff, error register */
>      case 0x202000f:     /* ADU stuff, receive status register*/
>          return 0;
> -    case 0x2013f00:     /* PBA stuff */
>      case 0x2013f01:     /* PBA stuff */
> -    case 0x2013f02:     /* PBA stuff */
>      case 0x2013f03:     /* PBA stuff */
> -    case 0x2013f04:     /* PBA stuff */
>      case 0x2013f05:     /* PBA stuff */
> -    case 0x2013f06:     /* PBA stuff */
>      case 0x2013f07:     /* PBA stuff */
>          return 0;
>      case 0x2013028:     /* CAPP stuff */
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index fb123edc4e..63a4b7b6a7 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -198,6 +198,16 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>  #define PNV_XSCOM_BASE(chip)                                          =
  \
>      (0x0003fc0000000000ull + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_S=
IZE)
> =20
> +#define PNV_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
> +#define PNV_OCC_COMMON_AREA(chip)                                     =
  \
> +    (0x7fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
> +                         PNV_OCC_COMMON_AREA_SIZE))
> +
> +#define PNV_HOMER_SIZE              0x0000000000300000ull
> +#define PNV_HOMER_BASE(chip)                                          =
  \
> +    (0x7ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_HOMER_SI=
ZE)
> +
> +
>  /*
>   * XSCOM 0x20109CA defines the ICP BAR:
>   *
> @@ -256,4 +266,12 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>  #define PNV9_XSCOM_SIZE              0x0000000400000000ull
>  #define PNV9_XSCOM_BASE(chip)        PNV9_CHIP_BASE(chip, 0x00603fc000=
00000ull)
> =20
> +#define PNV9_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
> +#define PNV9_OCC_COMMON_AREA(chip)                                    =
  \
> +    (0x203fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
> +                           PNV9_OCC_COMMON_AREA_SIZE))
> +
> +#define PNV9_HOMER_SIZE              0x0000000000300000ull
> +#define PNV9_HOMER_BASE(chip)                                         =
  \
> +    (0x203ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV9_HOMER=
_SIZE)
>  #endif /* PPC_PNV_H */
>=20


