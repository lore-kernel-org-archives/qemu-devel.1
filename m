Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29063C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7B0223D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7B0223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKVK-0006Rk-5z
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 02:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXKT4-0005bQ-AA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXKT1-0001tu-Dz
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:32:02 -0500
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:47976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXKT1-0001r1-5U
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:31:59 -0500
Received: from player716.ha.ovh.net (unknown [10.109.143.223])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id D98C12125C6
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:31:56 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player716.ha.ovh.net (Postfix) with ESMTPSA id D54F6C4056C5;
 Wed, 20 Nov 2019 07:31:51 +0000 (UTC)
Subject: Re: [PATCH 5/5] hw/ppc/pnv_xscom: add PBA BARs for Power8 slw image
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-6-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9ad3aae4-1164-74aa-9e35-3a0a4d701d51@kaod.org>
Date: Wed, 20 Nov 2019 08:31:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119175056.32518-6-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16999962694897339366
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.36.253
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
> slw base and size mask are accessed during boot in homer_init_chip(),
> so include BAR2 and BARMASK2 for Power8.
> 
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv_xscom.c   | 10 ++++++++--
>  include/hw/ppc/pnv.h |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index f797a5ec7d..828a2e2a5a 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -38,8 +38,10 @@
>  
>  /* PBA BARs */
>  #define P8_PBA_BAR0                     0x2013f00
> +#define P8_PBA_BAR2                     0x2013f02
>  #define P8_PBA_BAR3                     0x2013f03
>  #define P8_PBA_BARMASK0                 0x2013f04
> +#define P8_PBA_BARMASK2                 0x2013f06

and you add the definitions back ! :)

>  #define P8_PBA_BARMASK3                 0x2013f07
>  #define P9_PBA_BAR0                     0x5012b00
>  #define P9_PBA_BAR2                     0x5012b02
> @@ -49,6 +51,7 @@
>  /* Mask to calculate Homer/Occ size */
>  #define HOMER_SIZE_MASK                 0x0000000000300000ull
>  #define OCC_SIZE_MASK                   0x0000000000700000ull
> +#define SLW_SIZE_MASK                   0x0
>  
>  static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
>  {
> @@ -115,6 +118,11 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
>          }
>          return 0;
>  
> +    case P8_PBA_BAR2: /* P8 slw image */
> +        return PNV_SLW_IMAGE_BASE(chip);
> +    case P8_PBA_BARMASK2: /* P8 slw image size is 1MB and mask is zero*/
> +        return SLW_SIZE_MASK;

We need a HOMER XSCOM region.

> +
>      case 0x1010c00:     /* PIBAM FIR */
>      case 0x1010c03:     /* PIBAM FIR MASK */
>  
> @@ -135,9 +143,7 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
>      case 0x202000f:     /* ADU stuff, receive status register*/
>          return 0;
>      case 0x2013f01:     /* PBA stuff */
> -    case 0x2013f02:     /* PBA stuff */
>      case 0x2013f05:     /* PBA stuff */
> -    case 0x2013f06:     /* PBA stuff */
>          return 0;
>      case 0x2013028:     /* CAPP stuff */
>      case 0x201302a:     /* CAPP stuff */
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index e9ed8b928a..bd22dbf8a9 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -212,6 +212,10 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>  #define PNV_HOMER_BASE(chip)                                            \
>      (0x7ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_HOMER_SIZE)
>  
> +#define PNV_SLW_SIZE                0x0000000000100000ull
> +#define PNV_SLW_IMAGE_BASE(chip)                                        \
> +    (0x2ffda00000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_SLW_SIZE)
> +
>  
>  /*
>   * XSCOM 0x20109CA defines the ICP BAR:
> 


