Received: from eggs.gnu.org ([2001:4830:134:3::10]:47829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fmVcp-0003xt-Tg
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 22:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fmVco-0008Md-SP
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 22:52:03 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fmVcn-0008LQ-Uu
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 22:52:02 -0400
Date: Mon, 6 Aug 2018 12:50:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180806025031.GA7429@umbus.fritz.box>
References: <20180806012723.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20180806012723.5639-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] target/ppc: Fixes for my fpu cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 05, 2018 at 06:27:21PM -0700, Richard Henderson wrote:
> David, please squash these with the patches you already
> have on your ppc-for-3.1 branch.
>=20
> The first fixes fp division within the vector insns.
> The second fixes some typos within the load/store converters
> as reported by Mark Cave-Ayland.

Done, thanks.

>=20
>=20
> r~
>=20
>=20
> Richard Henderson (2):
>   fixup! target/ppc: Honor fpscr_ze semantics and tidy fdiv
>   fixup! target/ppc: Use non-arithmetic conversions for fp load/store
>=20
>  target/ppc/fpu_helper.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltnt3UACgkQbDjKyiDZ
s5IQfg/8DcHFl1koeax1W+frFx4GO6Ul+ibTlUls7Cqg3LFoMYLkbTfICZcIczIw
Vv91JnoU28I6GzaRJVLl2ZB3L5hBcow1w8ReASyXdXxoaDW2o1reZ22+WmWa/HO9
G6NMGz4jtA8OCobDEsA/NIoF3lZNZ86O7pX5frdbil9ARJShMqFOJTQQ8TS8uMIl
+SdGRaXWu+7Hv1qHX4BlPJAwxWoD2ZoK7zWFzDtmHLTXB5oWx7/VTHBj8JRHJoba
bK+FO7YnBc+J/u9i7hazlhA4kyNFmC2/Sfv/fmHFyrgd1hDyTWy528VM2FMXO4ck
t5TZEYPwDal93POupwv1K42Of/9uvWYXASM7ddb89H8U5WWefvaODuqQHg8StbzS
2HDYx+sSS4tQKAGOaDczTJjngbsUoMvge5fXsP1n0ubBFY8qA4tSis95527Dho9l
jz9PpSfO4bhf/HZD7VP5FnpAfFsQl99uS/SZswbkOpY+tbcIQ8aJ6GHk15QluNBL
I3TFtZbPaUWWKLfzdVPGvWY4SOHX746jEAJPwwju19Xwp4iJjDQesyeR4JZsqlvN
Zkmh/YVdPAYfc4NCMgZpSHVmI53S5K34J3jFXco56yQ8xWitBoBxfea3Dwxpfuqu
EcdiJwEB+jnqfON+qjepXKJiOPeCeoqPK+T+J5c5RHUuqn2IGnk=
=Y2LN
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
