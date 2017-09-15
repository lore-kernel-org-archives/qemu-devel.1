Received: from eggs.gnu.org ([2001:4830:134:3::10]:59001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dslmY-0001SD-2w
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dslmU-0004Rt-Mu
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:15:26 -0400
Date: Fri, 15 Sep 2017 16:36:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170915063640.GG5250@umbus.fritz.box>
References: <150539846159.21523.16161730500010192093.stgit@bahia>
	<150539847337.21523.1659017394355445790.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <150539847337.21523.1659017394355445790.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] checkpatch: add hwaddr to @typeList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 04:14:33PM +0200, Greg Kurz wrote:
> The script doesn't know about all possible types and learn them as
> it parses the code. If it reaches a line with a type cast but the
> type isn't known yet, it is misinterpreted as an identifier.
>=20
> For example the following line:
>=20
>     foo =3D (hwaddr) -1;
>=20
> results in the following false-positive to be reported:
>=20
> ERROR: spaces required around that '-' (ctx:VxV)
>=20
> Let's add this standard QEMU type to the list of pre-known types.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Not sure who should queue this, though.

> ---
>  scripts/checkpatch.pl |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fa478074b88d..def5bc1cc0e1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -213,6 +213,7 @@ our @typeList =3D (
>  	qr{${Ident}_handler},
>  	qr{${Ident}_handler_fn},
>  	qr{target_(?:u)?long},
> +	qr{hwaddr},
>  );
> =20
>  # This can be modified by sub possible.  Since it can be empty, be caref=
ul
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7dPgACgkQbDjKyiDZ
s5IHfxAAj+oHOdMkDum/XYVuWV8njIX7FBZ7XSKBtDuTP/iXzqFD6nuHvRl5TELT
2gKSZdEUbxoGWolunB2zD7qnESwYb04gP2DqaIlaQOozAZKbjiwk8e5PG9O0ws4b
g+sAB8PBmn3JtBWmPKRngNI/OOCcDP0w+6vWwyxIu7zHJX/2WxfaxFj3soiZV6JA
getj5Wx0zq8eNpbk/RtCmG3sQqOB8cip6e/p0zDOpFpnfreN83VoK/qIl7Cyd96R
ejEy0yo/JTAoxwi7K2zyAs4Yrq91pRvkmR5Qt43MACqUW/2pCPY1OXBKIzpuclQ5
3U0WVrVh2FZzRFk19IjQgeuEXqoxBqZnDfycgi+fMsdF+Gv/Y4FiNzCPWHtgNi8z
3/KYgYjPiZpTGWTlQyNAjtQLqU1FQ82ir6mJ/sClEaC8k8g7drBYrZGwJzpt2S4p
B86xj4G1tF+lGTTWaPqKmC8Cgr4KWMx8POAccw9IE2Mx/5wrqZjZmzAUvRVewEag
jTJ63TDr8udKlKPdrOcZzcZ1HTtWaUHCXpSS72PKehk/6PQ2K1dB/otwMTjpeyPS
MkaBv/tcl/chbmeJLfItAo0A5ItrnFUBAsUdrIK/OGBsZ3nzH8YyNrQXrZu3w+yG
Zhhmd5Rdmn4EuNjHGeM/gzi+9aIc0gP/L3YOHSRKK5dHSbaIang=
=zZvg
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
