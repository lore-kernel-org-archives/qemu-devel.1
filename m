Received: from eggs.gnu.org ([209.51.188.92]:57593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIpe-0006cl-GV
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIpY-0001nJ-He
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:45:59 -0500
Date: Wed, 20 Feb 2019 14:45:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220034541.GP9345@umbus.fritz.box>
References: <20190219142530.17807-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ht+/lPZLak6eP81R"
Content-Disposition: inline
In-Reply-To: <20190219142530.17807-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/xive: xive does not have a POWER7
 interrupt model
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


--Ht+/lPZLak6eP81R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 03:25:30PM +0100, C=E9dric Le Goater wrote:
> Patch "target/ppc: Add POWER9 external interrupt model" should have
> removed the section covering PPC_FLAGS_INPUT_POWER7.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.0, thanks.

> ---
>  hw/intc/xive.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 425aa97ef9f6..daa7badc8492 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -481,9 +481,6 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
> =20
>      env =3D &cpu->env;
>      switch (PPC_INPUT(env)) {
> -    case PPC_FLAGS_INPUT_POWER7:
> -        tctx->output =3D env->irq_inputs[POWER7_INPUT_INT];
> -        break;
>      case PPC_FLAGS_INPUT_POWER9:
>          tctx->output =3D env->irq_inputs[POWER9_INPUT_INT];
>          break;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ht+/lPZLak6eP81R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxszWMACgkQbDjKyiDZ
s5JffhAAim6qtLx3uz+WziM5qz7C+PkgZR49dad/qSqbrZCFCT011/DNiKj3Dx54
vJhWVyDkcMohw8kxt4CRthptqyDKO69voJ7YXt/UVblXFk7mO+byBuqdqg/62Vxw
hfBRV9JyPoseShh/kQDmsItnruWxqZwLEk9aRiWEVs5gM+ZtU/SXM70atVq6PD0W
dbF0O+GHfxX5JlT4tD9QVFu24guOzursaL3IhLOhkcrFSqPCle3K2YCrHVhmniQs
qZkfZe97m9M3KSm+aAkrPaH+KG9+wl2yoUr+KE9RTSppbYhI9FunLLexO2iTm58/
5DHf+AvUAuPkHOPZeQZDp89nTWRSX6ACdoPw8xXFVbaavHx/Bd0Z3PjgseCH3awC
p3xvhctGNR1Itix4J/cr4rnWqbvd2CnA3GqUREY2WwXICGf/5rCFxWZ7OkEfWrZD
64pO4QL5KElSTGX9zfVorz1W2Tbd63SHy4Z5rshSQljYIenZh+nPIYZUEzfBLcj/
yNWJgGF10opZOK2ujn2jluORtmtRAcu6MgqwGBtTiE94MTM66ULdnMmHIDXKQf7a
wYaDLt2yNPlsEWSyRLVbXmfAw3QEXo8nzUFJBCyV0HdyNNnWqQEkucwIAhJzVRGu
tePkSB++zJhPBl9VxnZh4VuScBV768VOiKUf5/r9HJ0Mu13Yq4E=
=g7xM
-----END PGP SIGNATURE-----

--Ht+/lPZLak6eP81R--
