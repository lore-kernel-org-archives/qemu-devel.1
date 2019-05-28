Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71896C28CC0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 01:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CA02075E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 01:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LpXMZ+Cl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CA02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55301 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVQi1-0003fs-Ft
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 21:15:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVQgK-0002j5-WB
	for qemu-devel@nongnu.org; Mon, 27 May 2019 21:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVQgJ-0006zk-Qs
	for qemu-devel@nongnu.org; Mon, 27 May 2019 21:13:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43017 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVQgI-0006kY-2R; Mon, 27 May 2019 21:13:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45CbST4k6hz9s9y; Tue, 28 May 2019 11:13:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559005993;
	bh=AB2PI7Ip5npPxf7/mhaGao15oH8SX/OG7x1dT3Ap68g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpXMZ+ClyM1E8IViqoZxbStCtBMGBUfXOeFXcSLupN4GR+4D7KJcMFPYiXDuzADac
	BtSfYB26SsfL+pH4ZnTUct4hiV+p0aTsVtEU9qEBEzwtoa6RYLeFHssD/gknTij1aA
	WdnVe2ig6cnOsZF0//n1ZXy45N4Izr98yVl8WZNg=
Date: Tue, 28 May 2019 11:07:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190528010725.GC11618@umbus.fritz.box>
References: <20190527071722.31424-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <20190527071722.31424-1-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: add dummy XSCOM registers for PRD
 initialization
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2019 at 09:17:22AM +0200, C=E9dric Le Goater wrote:
> PRD (Processor recovery diagnostics) is a service available on
> OpenPower systems. The opal-prd daemon initializes the PowerPC
> Processor through the XSCOM bus and then waits for hardware diagnostic
> events.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/pnv_xscom.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index c285ef514e88..f53a6d7a9457 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -29,6 +29,12 @@
> =20
>  #include <libfdt.h>
> =20
> +/* PRD registers */
> +#define PRD_P8_IPOLL_REG_MASK           0x01020013
> +#define PRD_P8_IPOLL_REG_STATUS         0x01020014
> +#define PRD_P9_IPOLL_REG_MASK           0x000F0033
> +#define PRD_P9_IPOLL_REG_STATUS         0x000F0034
> +
>  static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
>  {
>      /*
> @@ -70,6 +76,12 @@ static uint64_t xscom_read_default(PnvChip *chip, uint=
32_t pcba)
>      case 0x1010c00:     /* PIBAM FIR */
>      case 0x1010c03:     /* PIBAM FIR MASK */
> =20
> +        /* PRD registers */
> +    case PRD_P8_IPOLL_REG_MASK:
> +    case PRD_P8_IPOLL_REG_STATUS:
> +    case PRD_P9_IPOLL_REG_MASK:
> +    case PRD_P9_IPOLL_REG_STATUS:
> +
>          /* P9 xscom reset */
>      case 0x0090018:     /* Receive status reg */
>      case 0x0090012:     /* log register */
> @@ -124,6 +136,12 @@ static bool xscom_write_default(PnvChip *chip, uint3=
2_t pcba, uint64_t val)
>      case 0x201302a:     /* CAPP stuff */
>      case 0x2013801:     /* CAPP stuff */
>      case 0x2013802:     /* CAPP stuff */
> +
> +        /* P8 PRD registers */
> +    case PRD_P8_IPOLL_REG_MASK:
> +    case PRD_P8_IPOLL_REG_STATUS:
> +    case PRD_P9_IPOLL_REG_MASK:
> +    case PRD_P9_IPOLL_REG_STATUS:
>          return true;
>      default:
>          return false;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzsic0ACgkQbDjKyiDZ
s5J3WQ/9Gu3tII+T0U98FjZzaKxmHYIpb1kqDezXLEWhK6hvvPXZNmXll/mgA/n8
bT4UXn1Vid2N1Dn1fn2m7lpcuZcMdF3+UAscE3fnAKrxykSarJ8VVwJNnCIYWGFq
E+uFkMCrd1tUUmqI7he8khWvvU8hM/7hALUkd6jMu04kqA5g4UNw61Y/+rkd9fFo
KNDKDH2XKFzSAugn4TNTIs7vm9CmZC8rtZkD2aETiKYGC6AfuHI5LgdX6tZ0dhue
iYAOcUlZrDmdcn5pvZe3G4FjuzfQi+vusby1JrtISgtUpCoy3PaltkMaFjdPU5xV
Kb2dMluYCLizKJojwZwUm7VxMVxkfyoEnpN+8n2YLFRL4axQ+bNrQ6HBBaGL2zaJ
cCbRiWKcOpoBZDxxx/SQ8Zn7jKo3HDf4pNHdz3W3RKh3j2NMp25C54hbvwADw7nc
kRaZT4AqVv7XSSqCotFRrVFKW4sjkMsbIpee2Wxtc6f/ZmuRkDSvm161f6zDsNl5
SBNWp55nYjw4dX4FRcumhtwCuphaZ1SNaNhqcLMsuhBGtIlFD1FY6/x3SfbOi88n
oE3yUqZB1Kcgz5s0qhpx1EDR5h6yTP2kpHfKEfdeJnSPbYs0tasE9sUwf55HvB8K
cCL/lIvHSzVKgDcJi9b+a1EMZetAm/z7535qwTt8IARCHwoBULA=
=gh5b
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--

