Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C0AC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A50E218B8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="doDEDbtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A50E218B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvwrT-0000Bn-QB
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 00:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58502)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvwqR-00079k-Ax
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvwqQ-0008TQ-6Z
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:39 -0400
Received: from ozlabs.org ([203.11.71.1]:51543)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hvwqP-0008RH-Ji
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464XpM16NHz9sP7; Fri,  9 Aug 2019 14:49:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565326171;
 bh=+Oo/PMZD5d0Dc5cDKsr+eks31wIKAhVkiGMYOdupUDk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=doDEDbtmOLdoTHYtyKdPC68rO9V4IiMTEfTuVs0JKZnhc9BAyviiF7SBl0sFy7q8J
 Zg3vLGNUPscOzyDJ1+lQ9/AQiPsxaQjQ5Cjx+frn4yfQGtjRioWt5+hCo8q63eQTQ8
 CxK2qhei1yxPFofRr68O2Qe9uT5ZL6YNxMmM9gLc=
Date: Fri, 9 Aug 2019 14:45:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190809044540.GM5465@umbus.fritz.box>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-6-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vdqwC0msT4ilQ2it"
Content-Disposition: inline
In-Reply-To: <20190807071445.4109-6-bala24@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] hw/ppc/pnv_xscom: retrieve
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
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 hari@linux.vnet.ibm.com, clg@kaod.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vdqwC0msT4ilQ2it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 12:44:44PM +0530, Balamuruhan S wrote:
> During PowerNV boot skiboot populates the device tree by retrieving
> base address of homer/occ common area from PBA BARs and prd ipoll
> mask by accessing xscom read/write accesses.
>=20
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>

Again seems unrelatedto the scripting.

> ---
>  hw/ppc/pnv_xscom.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 5d5b5e9884..18a780bcdf 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -77,6 +77,29 @@ static uint64_t xscom_read_default(PnvChip *chip, uint=
32_t pcba)
>      case 0x18002:       /* ECID2 */
>          return 0;
> =20
> +    /* PBA BAR0 */
> +    case 0x5012b00: /* P9 homer base address */
> +        return PNV9_HOMER_BASE(chip);
> +    case 0x2013f00: /* P8 homer base address */
> +        return PNV_HOMER_BASE(chip);
> +
> +    /* PBA BARMASK0 */
> +    case 0x5012b04: /* P9 homer region size */
> +    case 0x2013f04: /* P8 homer region size */
> +        return PNV_HOMER_SIZE;
> +
> +    /* PBA BAR2 */
> +    case 0x5012b02: /* P9 occ common area */
> +        return PNV9_OCC_COMMON_AREA(chip);
> +    case 0x2013f02: /* P8 occ common area */
> +        return PNV_OCC_COMMON_AREA(chip);
> +
> +    /* PBA BARMASK2 */
> +    case 0x5012b06: /* P9 occ common area size */
> +    case 0x2013f06: /* P8 occ common area size */
> +        return PNV_OCC_COMMON_AREA_SIZE;
> +
> +
>      case 0x1010c00:     /* PIBAM FIR */
>      case 0x1010c03:     /* PIBAM FIR MASK */
> =20
> @@ -96,13 +119,9 @@ static uint64_t xscom_read_default(PnvChip *chip, uin=
t32_t pcba)
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vdqwC0msT4ilQ2it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1M+nQACgkQbDjKyiDZ
s5LOdg/9EHkOGgSlestn44+WA+4RmtzPZnFhJbqgqhamdFJlItc9p88lVm2DQhTY
43pp2xdRct3Lnfu9dM4uJ+UopUcy2bUUdzhhAaYshRm4rugNXP52PQwGVi/9F7WD
ksIrcBBB/Ov3b7/TEIGEBWjWQHxZWTrXftvtaTvtLFNkb9AfQQTguv8sXYr5RXca
D+oZA3YnND6r74121A21tcF4ZjMuepaxi16EGlzY8gEwkQJZWEkL21LHGTLRgdcr
FGjjYcCdxuAdAoRf4x7z8mU3myYkT7P5mAY9PHDttEJFqOgvXGxg/a1mCoGhcbdz
zdC6jEZ37VQDirHHDvPUaT+aGAU+V7WcjV9PdwefrUWfak+sDHb19Fhepzs3S9j5
kOLoA4hY+8iACuU1hLF9NXyxSVmhF1S52ie1Vff8LWtCducfGA9Mg8m5YxpqJGPC
83rhyygyEH5FVLnGBz316VVStWhXskdYl6NFidPn6z1DiR7uQ1vwc/8VLYYzkJOY
GzrP3m3KPSRCReehjxuWxABF7Y2uO0ho4MskXbOIQn8MHj6Gj/eoKc+iNvm5So7x
DQUMKKTYjiagNdoqMyo5cqTCXVXnl28OMepHBpI0/Hm8FyqXSX8kUGZV7ovWybOZ
4o4ZhctRBXQuV3R5ij0GZ4q9Ydl6uZijdeoCT3ViC6+KWlwbAgk=
=u5Ws
-----END PGP SIGNATURE-----

--vdqwC0msT4ilQ2it--

