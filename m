Received: from eggs.gnu.org ([2001:4830:134:3::10]:56687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXypJ-0003z2-Nl
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 21:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXypE-0007gg-25
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 21:00:52 -0400
Date: Wed, 27 Jun 2018 10:35:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180627003508.GF14434@umbus.fritz.box>
References: <20180626142214.27801-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <20180626142214.27801-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix pnv_core_realize() error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 04:22:14PM +0200, C=E9dric Le Goater wrote:
> commit d35aefa9ae15 ("ppc/pnv: introduce a new intc_create() operation
> to the chip model") changed the object link in the pnv_core_realize()
> routine but a return was forgotten in case of error, which can lead to
> more problems afterwards (segv)
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/pnv_core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index a9f129fc2c5f..9750464bf4a1 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -150,6 +150,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>      if (!chip) {
>          error_propagate(errp, local_err);
>          error_prepend(errp, "required link 'chip' not found: ");
> +        return;
>      }
> =20
>      pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsy27cACgkQbDjKyiDZ
s5IycRAAk3TTN/zIYKYyRukmjPRksxa8+iCWGaV2fJy84kR/TJSEEHkuslYNGyai
SpA9qFMLFHnE0tnsYxbIX0TQCHyN+K/fsiI6FE8w6h2ozlCBSitWYtyQoe8KSCef
WBgjB6dRX4Vpxr/0qjzpJlkJzDfjUccd4rPJNoQl01mn87pI3MxSEB2pHWDgiG8R
BiaZJTMFP9xcVDhdOlx9iNlyq6hg0nsKMZ8ODmVSaTCrKFOK7HctvQAO/ImisRKp
3+TOR8fZWW+Us10VS1pgZyPwvGPHwOfCUZhg0ThNoItDQ/Y8u83SWio0BJ4nBo62
E/zKUs7pTLAfJg/XR/daVzL9cu9aACcQPgU1JaGizUBn5MjrdcQp+PQcouMKGm9U
KAZzamSuEZM5B4Bb7fChU6EvncPBc9b2yOp0vCVN4UQvvca1F2cZ4llR4nVNBbiJ
FF4cWMJQo6B5zHZExfr0kL6IJ/Y96KMCiMASWC19m5Or/vMp8nH4GOCcO2ZAus4L
KqmWTz5ML/+aBe7Uyy+dJx4pOVj7o9IdFnGrKno7OyaP1DBxyuYs3nYvo61pXZ6s
94kSQuJ5hpzYC58xwazI3rqGb3yVT5zfcbHTYq4RBlqjsCrxG/FBFtxhAekjlvUB
WUJRyJlQKVes1koLw885b/k+MYXSgPLMnYD3Y8ufvRIFIaLJFXE=
=U3oV
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
