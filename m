Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B9C072B1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 01:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67B02075E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 01:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HTqA2RxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67B02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55298 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVQi1-0003f2-2S
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 21:15:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVQgJ-0002iz-P3
	for qemu-devel@nongnu.org; Mon, 27 May 2019 21:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVQgI-0006yE-2j
	for qemu-devel@nongnu.org; Mon, 27 May 2019 21:13:35 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:47345)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVQgF-0006kj-VA; Mon, 27 May 2019 21:13:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45CbST3Pnsz9s9N; Tue, 28 May 2019 11:13:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559005993;
	bh=NaqAY09AixoNrCtMM67sn2S/ijDfEydc9//tYzhzMU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTqA2RxSN6py9lVak6HQr4oHSvAT5r9bsCgT+yBkXI8oD05+0oUxfSe2P6VQUjmW+
	Aone7YHa6WK9lUr1Y7lciv36teXz4dbTD12Lt7xmwr5yX3HPZd43H68SG0hEO+H5Ij
	ggYMVWth23/eczmcp9W0JgF26ASKj1CGt4/RpTXc=
Date: Tue, 28 May 2019 11:07:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190528010703.GB11618@umbus.fritz.box>
References: <20190527071749.31499-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20190527071749.31499-1-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: introduce new skiboot platform
 properties
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


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2019 at 09:17:49AM +0200, C=E9dric Le Goater wrote:
> Newer skiboots (after 6.3) support QEMU platforms that have
> characteristics closer to real OpenPOWER systems. The CPU type is used
> to define the BMC drivers: Aspeed AST2400 for POWER8 processors and
> AST2500 for POWER9s.
>=20
> Advertise the new platform property names, "qemu,powernv8" and
> "qemu,powernv9", using the CPU type chosen for the QEMU PowerNV
> machine. Also, advertise the original platform name "qemu,powernv" in
> case of POWER8 processors for compatibility with older skiboots.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/pnv.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index dfb4ea5742c1..1f22cbf833a8 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -450,7 +450,8 @@ static void pnv_dt_power_mgt(void *fdt)
> =20
>  static void *pnv_dt_create(MachineState *machine)
>  {
> -    const char plat_compat[] =3D "qemu,powernv\0ibm,powernv";
> +    const char plat_compat8[] =3D "qemu,powernv8\0qemu,powernv\0ibm,powe=
rnv";
> +    const char plat_compat9[] =3D "qemu,powernv9\0ibm,powernv";
>      PnvMachineState *pnv =3D PNV_MACHINE(machine);
>      void *fdt;
>      char *buf;
> @@ -465,8 +466,14 @@ static void *pnv_dt_create(MachineState *machine)
>      _FDT((fdt_setprop_cell(fdt, 0, "#size-cells", 0x2)));
>      _FDT((fdt_setprop_string(fdt, 0, "model",
>                               "IBM PowerNV (emulated by qemu)")));
> -    _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat,
> -                      sizeof(plat_compat))));
> +    if (pnv_is_power9(pnv)) {
> +        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat9,
> +                          sizeof(plat_compat9))));
> +    } else {
> +        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat8,
> +                          sizeof(plat_compat8))));
> +    }
> +
> =20
>      buf =3D  qemu_uuid_unparse_strdup(&qemu_uuid);
>      _FDT((fdt_setprop_string(fdt, 0, "vm,uuid", buf)));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzsibcACgkQbDjKyiDZ
s5Ls4w//awR1QS09ov7489FmMAmTqMrKz3fJYR3ktA9Mc4ddjQQqNqBzSRask3Hr
1WKOekxb7UES1FgqRqZ+6LRaBIdnpxN2pGpCMuuy0ivBCG3dde4nlQ+xJk5BqhcY
Ot5F8vDi99GBilxcg7XtI5Y9ROQFWq0CnhfR6b2bRJwQbFXsY0euar4L5XlXDDDg
AUz8GF6QOOkNDhC9dA+LCF0IqsNWXKA3SWc8U2aiW97keqQd3cbPKMO3/t0rfjDN
r5zW3TumQTaFHkBlJkOd3vbIa0HjOGHplTbY5PyyCYF29x07zS8lKcEUbEat+jXu
YZvjfl86SE/X24c/pWDkKr8cBIvR/+qALBMpTtTSWxi++oC0D6T8JG9eB0yD/aBY
9bsmyMEqjh/jouhURCAKrl8dldwS4a8R86zafF7EldXL58FF1Myynx7B+Mezp8Uo
YuA1p1vWCniwMqNexEuIWESZ/w4dI894SVc8DnXKI/vGf2H0ucTERvkX/If5IgcO
gjndvRY3AaGGTYeVyQe1Os3AUoJzJBE97AMwRP3uvL9x/i1cXUAGHpObD6R48HFQ
E2olS+AwmvLH3SFF7GeqiAB+BXTIQ73DKjINdQ7rGo0pHpsyQFr/zyjuBRlTzAPr
ydEkB2nZgrV3R0UOIKy5puSMOQMkofs9k86E5bd5nAE3y8SPeu4=
=rdbA
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

