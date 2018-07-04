Received: from eggs.gnu.org ([2001:4830:134:3::10]:33683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faWpY-0006FQ-5E
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 21:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faWpX-0004ES-1u
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 21:43:40 -0400
Date: Wed, 4 Jul 2018 11:27:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180704012738.GA14043@umbus.fritz.box>
References: <20180703191043.4601-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20180703191043.4601-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] ppc: fix default VGA display for Mac
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 08:10:43PM +0100, Mark Cave-Ayland wrote:
> Commit 29f9cef39e "ppc: Include vga cirrus card into the compiling proces=
s"
> changed the default display adapter for all PPC machines to cirrus. Unfor=
tunately
> it missed setting the default display type to stdvga for both Mac machines
> causing the display to fail to initialise under OpenBIOS.
>=20
> Update the MachineClass for both Old World and New World Macs so that the
> default std(vga) display adapter is the default if no options are specifi=
ed
> which fixes the display for the Mac machines.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/mac_newworld.c | 1 +
>  hw/ppc/mac_oldworld.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index d11980166f..2ca294664b 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -525,6 +525,7 @@ static void core99_machine_class_init(ObjectClass *oc=
, void *data)
>      mc->block_default_type =3D IF_IDE;
>      mc->max_cpus =3D MAX_CPUS;
>      mc->default_boot_order =3D "cd";
> +    mc->default_display =3D "std";
>      mc->kvm_type =3D core99_kvm_type;
>  #ifdef TARGET_PPC64
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("970fx_v3.1");
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 06ed6f660e..064d7eb30a 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -383,6 +383,7 @@ static void heathrow_class_init(ObjectClass *oc, void=
 *data)
>      mc->default_boot_order =3D "cd";
>      mc->kvm_type =3D heathrow_kvm_type;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("750_v3.1");
> +    mc->default_display =3D "std";
>  }
> =20
>  static const TypeInfo ppc_heathrow_machine_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls8IokACgkQbDjKyiDZ
s5JCpRAAmOltF8AWK7IA+gqXhltkAnTVcR4wLs3OSM7K5wGogVcIaH/+vcfk3Kg4
Qkaf5PefvjgwlilJOcTynCQm8s8JQOAEGRnjl+r4HZl0ZF7YFckP1s7abdjalyaP
vT0du/7G4Vb5P6/7XDLcW2aBRbGkQ7kRqgIgr4XN3pLe1C56qnKejDzA1jn/iKLK
/QCH4LqflqnVAr+NEeNmYLhjnSiymIUQde5IcBUux4QszUxuPnIBKxoAXu7Nu74V
HDKv1aX3CDLA7cdmZagEfx5Sx+OUxz0ZCdGWzKnYR04OQs+ePcLkDoILCVRMnejU
hR90R8Szm4Kzz6IrXzLFrWefSGFz3JTdkxbK2O0Jqvz3zlfKwEq8EasQe+QHqAVO
wJST4LhIIhi4ttd5M9C3RGgN4/vzo1mWqzf2C/BME+18And7S1cGoYA7Hft/EeMM
y2w4geflReYvtUH8yOK9fWe6m46IFrUnpYizAVGNDhAoq0ryK3ogpidZrOZ5fxyy
ogSlPSsheNlg/gL80qb4v/KfNgIyJ1Jyr9VzarG2Lyg7YgQixIL+HogZBgm9+1QS
62WPeMhaSFH0mV0myLdMXYxCZI8Qt4svQcpCwcIRuMLJC1WQvr0+kit1LmhONt02
/OSDgsbg2SrfsvJw03pgBGMWLRL1qjSRM5gnhsDg44QerOndpX4=
=E7hh
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
