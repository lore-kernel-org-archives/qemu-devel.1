Received: from eggs.gnu.org ([2001:4830:134:3::10]:39257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebzCZ-00046C-MN
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 20:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebzCY-0001XS-Em
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 20:41:11 -0500
Date: Thu, 18 Jan 2018 11:31:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118003130.GC30352@umbus.fritz.box>
References: <151618081462.20461.3393245354775542888.stgit@bahia.lan>
	<151618082784.20461.10973754439669848191.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aHyShe78FfJzbeER"
Content-Disposition: inline
In-Reply-To: <151618082784.20461.10973754439669848191.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr: drop duplicate variable in
 spapr_core_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--aHyShe78FfJzbeER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 10:20:27AM +0100, Greg Kurz wrote:
> A variable is already defined at the begining of the function to
> hold a pointer to the CPU core object:
>=20
>     sPAPRCPUCore *core =3D SPAPR_CPU_CORE(OBJECT(dev));
>=20
> No need to define it again in the pre-2.10 compatibility code snipplet.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.12, thanks.

> ---
>  hw/ppc/spapr.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 499ab647d882..bca838fce638 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3362,9 +3362,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>          int i;
> =20
>          for (i =3D 0; i < cc->nr_threads; i++) {
> -            sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(dev);
> -
> -            cs =3D CPU(sc->threads[i]);
> +            cs =3D CPU(core->threads[i]);
>              pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
>          }
>      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aHyShe78FfJzbeER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpf6uEACgkQbDjKyiDZ
s5KymxAAiic4+SuMGW0QoBdV50/QrweoX4Yhe5bHqeWq8LdKItwX6dTyWYfh6Ll2
Pt7ND6w7h1GbM6viNEpHlsrA/su9wSeQ20LSNitp9hfS8fm7IfEiR7VYgiOjr2IL
gvUogOh1dO15LfJkRhDZ3gEThZDFfsFLKjh/ASnBO3TYL4vME+d65yc1UzO6pZZw
GM3TsgMRYmUgjimgvd0AiGL6kFykrgD9WNpSOM2PzALoN4Kr+58/enEFcBNTcmsZ
xKrUk6Ila2bMOnNIQRqtWimbdCsq2piVrr2yQcAl3J69JJK4FWilbQGgz0QeIqTb
Kdaw6qH3qhmCSt8VOeL8vsSl3xHGkKWSGsgkuUt59N3Y5zXB3fHlgTI6tYG/aagq
DzUW1XD3sD7BnHYuuE1AJ1rBYIKiHcc2OXbcT+QDCe9o7kO4Dp8NACJljNT+ID51
oE0TEH+/qgxkpt3UeUM+rFZ/zZ1yHIw1YxTIUhJS/pbp3MPTVOqvtVyd1FxCiwSY
qRnsW0BAP4jKFsxcXNFszOSxU0es/Nc4NcEDe8kWHIOvL7olfIRMBmBnANaef8YT
lEWFpLmMD541R/JEBp3LnvN9l1Ysb2ePHex9WXuSh66mupXixOxzn3e7xLv106HP
sxXmakSneJ3stIit2qds2ikifiw9lNhbjgFTkCoSvgkma/SZhQc=
=Yeql
-----END PGP SIGNATURE-----

--aHyShe78FfJzbeER--
