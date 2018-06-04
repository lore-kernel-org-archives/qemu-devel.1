Received: from eggs.gnu.org ([2001:4830:134:3::10]:34374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPilY-000273-3w
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPilU-0006WW-U7
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:14:52 -0400
Date: Mon, 4 Jun 2018 11:28:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604012859.GH4251@umbus>
References: <20180525211523.14897-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Content-Disposition: inline
In-Reply-To: <20180525211523.14897-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] 40p: remove pci_allow_0_address = true
 from 40p machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hpoussin@reactos.org


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 10:15:23PM +0100, Mark Cave-Ayland wrote:
> The Linux sandalfoot zImage has an initialisation process which resets the
> VGA controller by setting all the BAR addresses to zero to access the VGA
> ioports at their legacy addresses.
>=20
> Unfortunately setting the framebuffer BAR to address 0 makes the framebuf=
fer
> memory overlap the internal VGA memory causing accesses to fail, and so
> prevents the kernel from switching successfully to text mode.
>=20
> Since OpenHackWare configures the framebuffer BAR address outside of the =
legacy
> VGA internal memory space, remove pci_allow_0_address from the 40p machin=
e class
> which causes the BAR reprogramming to zero to fail and so the VGA internal
> memory can be accessed correctly again.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/ppc/prep.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index be4db6a687..5ed0bcd862 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -884,7 +884,6 @@ static void ibm_40p_machine_init(MachineClass *mc)
>      mc->desc =3D "IBM RS/6000 7020 (40p)",
>      mc->init =3D ibm_40p_init;
>      mc->max_cpus =3D 1;
> -    mc->pci_allow_0_address =3D true;
>      mc->default_ram_size =3D 128 * M_BYTE;
>      mc->block_default_type =3D IF_SCSI;
>      mc->default_boot_order =3D "c";

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsUldsACgkQbDjKyiDZ
s5Lq1BAAtZjO+JXkRrGDfN8lYpOJZ+cQocOa6UfKwP62aDjvWheFmnKZTgSApqVf
tz00DuzH5xNx67DSkwGt8ur1omovgAydHFJSgjXBya19F6w7ZsAjVI4yuKu6qRgd
E4I+XGOPM4GILrXmfkX2wBuGDKQVkZFb5jIQfEMYcwQ+3yjdSQMCAaiTPTPHJISV
XHQfmRMAqT58qM23Dofbvf3Kgf+j7TA7Dr3On6ARsMQGy/w9lDcWrSPYboJ1m6rm
ybxxqqPblWCj+tsv4g2x/HEJIMJz212dRamob/ijKeorL0jsJxTDYGsN6BXdj7W8
1tKHJ8YdhH8wuFtkGZ9RXVeYq+pLJ/Ui33M683yYCl9i9vFF1552wZAoprO+mqH/
xbML0kW7BUn4/0nIXnZtiOWZ3uQ9e4eWJZJgjyyL56uHlKLauu1I7EREQg+SK3zk
br/+0XElWxiGG8DUakXU5Dfj1jrPs0kho1hljgvIeaYyx3NVSQzShhHeYuxRqFih
Y3602WcFC9LmfWKWpsPWvApxmIvRjZo7eB5jb76lGwYikaKP1F6rpx5aKZywgF9X
mcWLQl+szyZhPpnDRdtvzTUkylIAYPXVbF+vUsr8bOnp4eMMSiPyI78YVRN27nGG
DnSRwXd++2DTFkSSuzaANiMpTe74Jf8EgCuOBYx9KcZT8VuE+XQ=
=xGbM
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
