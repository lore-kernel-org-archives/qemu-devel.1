Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D39DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2227E22463
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2227E22463
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKKD-0002im-8B
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 02:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXKGH-0000mO-59
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXKGE-0000vK-Va
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:18:47 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:54258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXKGE-0000sT-Lc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:18:46 -0500
Received: from player779.ha.ovh.net (unknown [10.108.54.9])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 85452122AE4
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:18:44 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id 769A2C341A81;
 Wed, 20 Nov 2019 07:18:39 +0000 (UTC)
Subject: Re: [PATCH 2/5] hw/ppc/pnv_xscom: PBA bar mask values are incorrect
 with homer/occ sizes
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-3-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c3d41780-70fb-0088-3458-ef8db48ff7c9@kaod.org>
Date: Wed, 20 Nov 2019 08:18:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119175056.32518-3-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16777034512876145638
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.1
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
> homer/occ sizes are calculated in skiboot with `(mask | 0xfffff) + 1`,
> and from xscom access should return correct mask values instead of actu=
al
> sizes.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv_xscom.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index f01d788a65..cdd5fa356e 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -46,6 +46,10 @@
>  #define P9_PBA_BARMASK0                 0x5012b04
>  #define P9_PBA_BARMASK2                 0x5012b06
> =20
> +/* Mask to calculate Homer/Occ size */
> +#define HOMER_SIZE_MASK                 0x0000000000300000ull
> +#define OCC_SIZE_MASK                   0x0000000000700000ull
> +

Can't we deduce these values from the size ?=20

>  static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
>  {
>      /*
> @@ -90,9 +94,8 @@ static uint64_t xscom_read_default(PnvChip *chip, uin=
t32_t pcba)
>          return PNV_HOMER_BASE(chip);
> =20
>      case P9_PBA_BARMASK0: /* P9 homer region size */
> -        return PNV9_HOMER_SIZE;
>      case P8_PBA_BARMASK0: /* P8 homer region size */
> -        return PNV_HOMER_SIZE;
> +        return HOMER_SIZE_MASK;

I would prefer to move all the HOMER accesses in a XSCOM region
under the PnvHomer model than expanding the default handlers.=20
You will need a different set of handlers for P8 and P9 and a=20
different mapping address also.=20

Could you do that please ?=20
 =20
>      case P9_PBA_BAR2: /* P9 occ common area */
>          return PNV9_OCC_COMMON_AREA(chip);
> @@ -100,9 +103,8 @@ static uint64_t xscom_read_default(PnvChip *chip, u=
int32_t pcba)
>          return PNV_OCC_COMMON_AREA(chip);
> =20
>      case P9_PBA_BARMASK2: /* P9 occ common area size */
> -        return PNV9_OCC_COMMON_AREA_SIZE;
>      case P8_PBA_BARMASK2: /* P8 occ common area size */

Shouldn't that be PBA_*3 under P8 ?=20

C.=20

> -        return PNV_OCC_COMMON_AREA_SIZE;
> +        return OCC_SIZE_MASK;
> =20
>      case 0x1010c00:     /* PIBAM FIR */
>      case 0x1010c03:     /* PIBAM FIR MASK */
>=20


