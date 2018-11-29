Received: from eggs.gnu.org ([2001:4830:134:3::10]:42376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBH-0004aq-LO
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBF-0008N3-Un
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:03 -0500
Date: Thu, 29 Nov 2018 15:12:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129041244.GH14697@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-33-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-33-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 32/36] spapr/rtas: modify
 spapr_rtas_register() to remove RTAS handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:25AM +0100, C=E9dric Le Goater wrote:
> Removing RTAS handlers will become necessary when the new pseries
> machine supporting multiple interrupt mode is introduced.

I'd prefer this to be done as a separate spapr_rtas_unregister()
helper, just to improve greppability.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr_rtas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index d6a0952154ac..e005d5d08151 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -404,7 +404,7 @@ void spapr_rtas_register(int token, const char *name,=
 spapr_rtas_fn fn)
> =20
>      token -=3D RTAS_TOKEN_BASE;
> =20
> -    assert(!rtas_table[token].name);
> +    assert(!name || !rtas_table[token].name);
> =20
>      rtas_table[token].name =3D name;
>      rtas_table[token].fn =3D fn;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv/ZzwACgkQbDjKyiDZ
s5J5SA/8CEj6r6s5ksyoBYIaKWJmteoVJYy62alrCpacHXHRfaCTEyBmmuFfJ5Kn
KHbzDEpBRsXiG/Js0n/Bia5Bp2diOzvDGXiC5swMbdIetQb9UGt7qgjf1Ft9aJAD
3h+H6GUCzvL87ySytfyw0PYJD67EmhP8snAK3z+ZWrTApoCTyfU9HqS7EGirwWYb
hXz6x9Ft+ctOUfUcGbyMHTfB4zrFWPOqmkG0/z6jM0XGVCnpb7nYn+Fbu5fOqCO8
ENI+edj2lv+t69yDfll8pKi7nn2Yz0GhNrhklyFI1JR3KMa5fZH+EH1lg6hF7ief
X+CV9pVJMlbBqtmammpuxlu5XdxgLsT+hvEmy1Z+9GYOJqj0IK2VcBkW7utWB0+M
Gbp7RrR8qS1gQdWTMTXx0zrhNI6NS4T93wuk237Sm+P2LM6PYn1qaxi59O4W9ETL
EY0IH3q3icRyxHP66+hwHBwuIaRJlLln13flDlefX79TInBcSe1JM5t59z69g0qA
ddatgD6fwQS6LsPax89mDIL86cZ1ROqEkyIlFoW6fLxyCyRkKHuuKnFTMvIYhVBM
w7aw4vA0DHj1NtQsGrymbemEeZ0FavJrlCNgTfs8RTBBZT38Rd2RUrK6dT4pVxV+
MthCtLdoqgIHGyWksU9XJIdFSvpILhDdbPMTslne0tdWQakNM00=
=j8Rw
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
