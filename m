Received: from eggs.gnu.org ([2001:4830:134:3::10]:60468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWDyj-0002OR-HC
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 00:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWDye-0001lT-Fl
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 00:19:36 -0500
Date: Mon, 10 Dec 2018 14:46:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181210034642.GJ4261@umbus.fritz.box>
References: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
	<20181207160806.13569-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCKy2vjPBX+S/5dE"
Content-Disposition: inline
In-Reply-To: <20181207160806.13569-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/3] mac_newworld: enable access to EDID
 data for the VGA device
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


--FCKy2vjPBX+S/5dE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 04:08:05PM +0000, Mark Cave-Ayland wrote:
> This is in preparation for some upcoming QEMU NDRV driver changes that pa=
ss
> display information from the host to the guest.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This looks fine by my limited knowledge of this area.  I'm slightly
perturbed I can't see any existing examples in the tree of setting the
edid property from the machine.

> ---
>  hw/ppc/mac_newworld.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 14273a123e..df0a2f03ff 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -430,7 +430,10 @@ static void ppc_core99_init(MachineState *machine)
>          }
>      }
> =20
> -    pci_vga_init(pci_bus);
> +    dev =3D qdev_create(BUS(pci_bus), "VGA");
> +    qdev_prop_set_int32(dev, "addr", -1);
> +    qdev_prop_set_bit(dev, "edid", true);
> +    qdev_init_nofail(dev);
> =20
>      if (graphic_depth !=3D 15 && graphic_depth !=3D 32 && graphic_depth =
!=3D 8) {
>          graphic_depth =3D 15;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FCKy2vjPBX+S/5dE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwN4aIACgkQbDjKyiDZ
s5L44g/8ChlW2+nT1fsYFq9u+oMkJUGkbT+7NQxCG/lF7UZWWaOltci76z8Q4t0Y
3+UqGe/PQuQeaeYjDeNJU4IsM5RsbxLV60VKTWhq+JCsCSqqfD5Ws89sX5gbAFCr
JOBYldn9i+WHRSCr5lxHMvohAvxDb9m/C8exwcpCO3JbynV4OVAeOsSUWIk1SlxC
fL7QRHrh70pZ5eWOih8Gqw3Nv5UugQ1XtibZa7vKWTcjpGNNcASEvaCEh/5ZtH6E
k2n2oRZv1bAJ76SzwDmAyXuw8/IYf9Wv7pYpqv3BSfwjMTI/jDMlu5Ll2z1FAe7d
yLezypD7qoNcDqUJ7l1QwuFsK7mdu45OAtUZGl/N9xaJD+4nPRoz9oZuU7cE5Auw
PBz9pWtAWarBzA2l9WcBbjGS4Kua8luvOhChyUUfHoSqClxVYiVPKbJD8s84mT3w
Nr5OVNpXW3LLZGrylYPkSopDQj/QcKgAA/6HM7IAIRwaqFaqOIBNJeo0jJ86K4NZ
diUi9x75SLGPq9S3u+bhgE8CVk13vncPcp1Mz7BxJKZpFaONkFSwWTQA5F1QByLM
CUxE9ywWBEWO4AVsIQnhcs2fON/8xbRCXKq8s/DIyJ6qiCQSCrDbVgx/rhHtoUEx
CjfEufrCvwearxdB1MLoMTbyXsIZkaH1+OH9tPR7BPFYuRaCR50=
=J6F5
-----END PGP SIGNATURE-----

--FCKy2vjPBX+S/5dE--
