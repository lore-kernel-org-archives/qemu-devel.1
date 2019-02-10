Received: from eggs.gnu.org ([209.51.188.92]:42866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gsyVV-0002pE-SM
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 18:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gsyVN-00035D-4X
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 18:27:26 -0500
Date: Mon, 11 Feb 2019 10:24:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190210232437.GD7230@umbus.fritz.box>
References: <20190208172201.29001-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <20190208172201.29001-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] mac_newworld: change default NIC to sungem
 for mac99 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hsp.cat7@gmail.com


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 05:22:01PM +0000, Mark Cave-Ayland wrote:
> This model brings out-of-the-box networking for all of Linux, MacOS 9 and=
 OS X
> without requiring the installation of additional drivers.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/ppc/mac_newworld.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 10be728c37..98461052ac 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -432,7 +432,7 @@ static void ppc_core99_init(MachineState *machine)
>      }
> =20
>      for (i =3D 0; i < nb_nics; i++) {
> -        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
> +        pci_nic_init_nofail(&nd_table[i], pci_bus, "sungem", NULL);
>      }
> =20
>      /* The NewWorld NVRAM is not located in the MacIO device */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxgsrQACgkQbDjKyiDZ
s5JGQQ//ZztmJVSc/tU6kKvy0AJdWAszbUrlci6996I2LG/Kcf68fj2iNgZBJ1MB
qUajhGRuntY9X0OqbkHS8nFzu2/EJ65pxwunXNStWBK7nsFwAc4X74p31lpxwrxz
k2KyTGq5EAywJIbw8TkXEduiu/BFRo9Ma2zago979uxcwPG0HSvexXs8nEPH2URO
7EgHyUxFsZqOMmhnlasPjxbNpzOsWlZ3V2R23R+F3ptQncBNPYR+ZRjI98+oSg5w
2sPf+ljc7S1RNwr9Y/wukrVNfev2WMr6ryZuvMLfOrbuDr468FIOpytE8tJqkdzn
D7l3j1oBFRt+x4NoWmpvgWC5RTtHby8M+to2+jdkkU38YQvJjE+4eMofF7/PoiLj
MhSxqVEc4FMT1s2ckSZE6olN+uyTDaQ/xGe7ZzQyoTOYlcrvoZbV+GnAOaFqXWV3
ceve1wI6Q1bo+wey7LciUo0NIUgnonbi8bobVBBNulhmk3EIXpYLVomp/U4F9SLK
psof3oOMaJ/wXx6IWpmDgxFey+gUbuaZ/fDYmzw5wtbV85NQFIQE0W+bx3RrQMyT
napTRjBYIWz6PMAncoc97ubD3gOTmPHz7GAdbppk8YJCfkNC9JXl9077Sc/LAeYL
xp0ZnqEW1NBSkTpjhUQFH2gMeGBs9A52onT/+gzaYVDdVommEtI=
=RCG9
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
