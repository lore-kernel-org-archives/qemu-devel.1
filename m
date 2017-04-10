Received: from eggs.gnu.org ([2001:4830:134:3::10]:45338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxSNI-00074v-LS
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxSNE-0006ws-EJ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:00:28 -0400
Date: Mon, 10 Apr 2017 15:59:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170410055951.GR27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-20-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1GSL5ZULXUIqbbH1"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-20-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 19/21] pci: Don't call pci_irq_handler()
 for a negative intx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--1GSL5ZULXUIqbbH1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:44PM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Under some circumstances, pci_intx() can return -1 (when the interrupt
> pin in the config space is 0 which normally means no interrupt).
>=20
> I have seen cases of pci_set_irq() being called on such devices, in
> turn causing pci_irq_handler() to be called with "-1" as an argument
> which doesn't seem like a terribly good idea.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> [clg: updated for qemu-2.9 ]
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

This looks like a real bug fix which should go to Michael independent
of the rest of the series.

> ---
>  hw/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 817ad14ed987..bfd65461348c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1419,7 +1419,9 @@ qemu_irq pci_allocate_irq(PCIDevice *pci_dev)
>  void pci_set_irq(PCIDevice *pci_dev, int level)
>  {
>      int intx =3D pci_intx(pci_dev);
> -    pci_irq_handler(pci_dev, intx, level);
> +    if (intx >=3D 0) {
> +        pci_irq_handler(pci_dev, intx, level);
> +    }
>  }
> =20
>  /* Special hooks used by device assignment */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1GSL5ZULXUIqbbH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6x9VAAoJEGw4ysog2bOSAdsP/jaxKNnSnHA63KkbE44EP952
WRuC2GFaIQVSHnst6724fRR0YpLdwPjshrO8G9Trw2JgtOaNf3lwhIGuuppDyZK9
kIh5lo1GB8SLZuUWUaVwgBVKANugvTOZPMFwSCpw/gFG43Et+x8/Bf6QgxSs76JO
4HnI6GZkY2WckZnfQpFg82CR7+Eez4FqfNH6HBNHdGsr/lIaWSGoRTCoZwuf9IID
gwkLTKRGbCxVZTlis2U6DG/gYogjzZcs+oelvtqwuPJi6nx1ZcBn5zmo2rPyKSEx
xZYKqGTwNHqA4Jt5kwOkbTCqFoIabAZSJTHnQMgNLx7O+v+phLQAYhAYHw9Eaxt6
3lXsfvsAnyGhugs1yz/Gytm5P71Ppgjt22WwY6BIqOG3LxoWpRT1hRHe2WwEaccU
/iuoO7burgMWZAU9lGxJXWO3Wl9/1BEF0DLhU5pps6KXkgePS7LI5ZTWh7nqLU0T
SruC9/CrclKcK0pnmRjKuIvk2cQchPc3xgOprvGvEw18SDy9iBLFrKpXak03G2rf
3UaeF4yb/bmgvNmcMF5cYF8GjgXGRQ24SGyfi0dFoux+nagshS5Sa53U9kdIfBqb
Yp2XFKbZRiN94PFOfdAAvZW9t474WUpvvYZoXC2eg3gSmyTV8cHF9lMClkSG8s+W
Zadpq2hInjywbiwODKSS
=I6y3
-----END PGP SIGNATURE-----

--1GSL5ZULXUIqbbH1--
