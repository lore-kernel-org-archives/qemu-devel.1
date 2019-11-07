Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B234C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E842166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SQIZL6eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E842166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSlCi-0002dF-5u
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iSl9N-0008AX-Gt
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iSl9I-0006g4-H2
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:00:49 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:50741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iSl9H-0006eH-IZ; Thu, 07 Nov 2019 12:00:44 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4788mR5XrPz9sR0; Fri,  8 Nov 2019 04:00:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573146039;
 bh=rXeO5yIgIJ7J4OD74Zp4mdtiGA/fpX94PHq6H+fORIw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SQIZL6ehzeLF6d3VulaczTFiLERmfu3TKGeDKjMnIH93gVK4uA/tjtmQu41RXN9PR
 WO+esTyOrXBlhsDQaPGlIsyOPxUtR/ILFJMi07T/opB3OKTJGuTn6A7n0oZbvfZdtY
 blx0wuN03q4AVplMHQXDfjEwdGCQTwMd9ADSLKF0=
Date: Thu, 7 Nov 2019 17:54:58 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Add a "/qemu" device tree node
Message-ID: <20191107165458.GB2461@umbus.Home>
References: <20191106142129.4908-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <20191106142129.4908-1-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 03:21:29PM +0100, C=E9dric Le Goater wrote:
> It helps skiboot identifying that is running on a QEMU platform. The
> compatible string will define the POWERPC processor version.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.3.

> ---
>  hw/ppc/pnv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 627c08e5b985..4c3d5184126a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -479,6 +479,9 @@ static void *pnv_dt_create(MachineState *machine)
>      fdt =3D g_malloc0(FDT_MAX_SIZE);
>      _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
> =20
> +    /* /qemu node */
> +    _FDT((fdt_add_subnode(fdt, 0, "qemu")));
> +
>      /* Root node */
>      _FDT((fdt_setprop_cell(fdt, 0, "#address-cells", 0x2)));
>      _FDT((fdt_setprop_cell(fdt, 0, "#size-cells", 0x2)));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3ETGIACgkQbDjKyiDZ
s5JhRBAAh5S7CZMkeQnZVwun9UTiQI0eMLNcflzR0JADLOkIb3flIM0dnggL/lgC
R8moav1g3OWbsX5mAdKNCaLvHvk6SuMI16sIlrQ7LHIuYRLvGXRYrAvcdFMcY+wj
d8J4Jn8vJNAml5V7eDdFVwnA77EjjaszVmbFflfwKnSC7JtPiMw47UIDgDQ6Uv67
Gs16P7GWbSpE/kHV50lQoFAvzkIPyqpCtKo2Y+m2i7Br7bzKmsymJ3JuE2weNm27
tUzxT2lYOrtmSHCF5zf9GK5aMlIG8Ltb8XobqOv+BdyxGL4JDBaKj8Hwax44WUET
G1RsJb0Y3FM29uGge09PC7pdewxVvFzAnOQCsBumIBOXGkSdgg1DvucP3l+Z8Y7L
KKPOYNnMxdXpDNPswsym9oFUyWuSjtZxOqm9PwsTV7D70zgn1+uhjm0AbmHJu1v5
YrY97MsWLy/iDXwJ45+aXl6oCoN7GsAb/WHezen3UYBFJj9ExTjluCGjFiF5Kol1
c/foJjwBQv2qc8es3KqILajVJWR+jJeJ3etAIIVAd62dVBuRlBaqk8DN5B/+U7+G
oSkUgkP+u3E1CZeeW6lJoiZOOFJ+bf7mbA0Unt3tLKgzQ/wUWWfjCg5dwR9TQEUl
gHj4+LNhOcatobJoGVd0VIFx4Ey3LnIZT+mQqBblBNfkRC1QcEo=
=TkHF
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--

