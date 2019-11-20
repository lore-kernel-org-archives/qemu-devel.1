Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC0C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2087206CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2087206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKJS-0002BP-Sb
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 02:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXKI8-0001Oq-Qp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXKI7-0003Rs-Q3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:20:44 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:47074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXKI7-0003Oq-Jp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:20:43 -0500
Received: from player789.ha.ovh.net (unknown [10.108.35.74])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2B0FC1AFB3A
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:20:40 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id ED00CC441CF8;
 Wed, 20 Nov 2019 07:20:35 +0000 (UTC)
Subject: Re: [PATCH 3/5] hw/ppc/pnv_xscom: Power8 occ common area is in PBA
 BAR 3
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-4-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5bf3a54f-9ca2-60d7-938d-6e598df5e5c2@kaod.org>
Date: Wed, 20 Nov 2019 08:20:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119175056.32518-4-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16809685611458890726
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.172.75
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
> Fix incorrect PBA BAR and BARMASK value for Power8 occ common area
> region where skiboot enum declaration have it in BAR 3 and BARMASK
> is calculated BARMASK0 + BAR,
>=20
> enum P8_BAR {
>         P8_BAR_HOMER =3D 0,
>         P8_BAR_CENTAUR =3D 1,
>         P8_BAR_SLW =3D 2,
>         P8_BAR_OCC_COMMON =3D 3,
> };
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Please remove my SoB.

> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv_xscom.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index cdd5fa356e..cb6d6bbcfc 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -38,9 +38,9 @@
> =20
>  /* PBA BARs */
>  #define P8_PBA_BAR0                     0x2013f00
> -#define P8_PBA_BAR2                     0x2013f02
> +#define P8_PBA_BAR3                     0x2013f03
>  #define P8_PBA_BARMASK0                 0x2013f04
> -#define P8_PBA_BARMASK2                 0x2013f06
> +#define P8_PBA_BARMASK3                 0x2013f07

Why are you removing the BAR2 definitions ? they are still valid.


>  #define P9_PBA_BAR0                     0x5012b00
>  #define P9_PBA_BAR2                     0x5012b02
>  #define P9_PBA_BARMASK0                 0x5012b04
> @@ -99,11 +99,11 @@ static uint64_t xscom_read_default(PnvChip *chip, u=
int32_t pcba)
> =20
>      case P9_PBA_BAR2: /* P9 occ common area */
>          return PNV9_OCC_COMMON_AREA(chip);
> -    case P8_PBA_BAR2: /* P8 occ common area */
> +    case P8_PBA_BAR3: /* P8 occ common area */
>          return PNV_OCC_COMMON_AREA(chip);
> =20
>      case P9_PBA_BARMASK2: /* P9 occ common area size */
> -    case P8_PBA_BARMASK2: /* P8 occ common area size */
> +    case P8_PBA_BARMASK3: /* P8 occ common area size */
>          return OCC_SIZE_MASK;
> =20
>      case 0x1010c00:     /* PIBAM FIR */
> @@ -126,9 +126,9 @@ static uint64_t xscom_read_default(PnvChip *chip, u=
int32_t pcba)
>      case 0x202000f:     /* ADU stuff, receive status register*/
>          return 0;
>      case 0x2013f01:     /* PBA stuff */
> -    case 0x2013f03:     /* PBA stuff */
> +    case 0x2013f02:     /* PBA stuff */
>      case 0x2013f05:     /* PBA stuff */
> -    case 0x2013f07:     /* PBA stuff */
> +    case 0x2013f06:     /* PBA stuff */

We need defines for the above ^

>          return 0;
>      case 0x2013028:     /* CAPP stuff */
>      case 0x201302a:     /* CAPP stuff */
>=20


