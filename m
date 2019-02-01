Received: from eggs.gnu.org ([209.51.188.92]:44171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gpPPj-000192-1S
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 22:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gpPIo-0000gg-Ux
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 22:15:39 -0500
Date: Fri, 1 Feb 2019 12:00:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190201010018.GA26425@umbus.fritz.box>
References: <20190201005622.14716-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20190201005622.14716-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] spapr_pci: Fix endianness in
 assigned-addresses property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.ibm.com>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 11:56:22AM +1100, Alexey Kardashevskiy wrote:
> reg->phys_hi and assigned->phys_hi are big endian but we do an extra
> byteswap anyway when copying reg->phys_hi to assigned->phys_hi.
> To make things slightly more messy, we also add a relocatable bit (b_n())
> although in the right endianness.
>=20
> This fixes endianness of assigned->phys_hi.
>=20
> This is unlikely to produce any visible difference though as we should en=
d up
> there only in the case of PCI hotplug and even then I am not sure if
> (d->io_regions[i].addr =3D=3D PCI_BAR_UNMAPPED) =3D=3D true.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-4.0, thanks.

> ---
>  hw/ppc/spapr_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index b74f263..a174952 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -964,7 +964,7 @@ static void populate_resource_props(PCIDevice *d, Res=
ourceProps *rp)
>          }
> =20
>          assigned =3D &rp->assigned[assigned_idx++];
> -        assigned->phys_hi =3D cpu_to_be32(reg->phys_hi | b_n(1));
> +        assigned->phys_hi =3D cpu_to_be32(be32_to_cpu(reg->phys_hi) | b_=
n(1));
>          assigned->phys_mid =3D cpu_to_be32(d->io_regions[i].addr >> 32);
>          assigned->phys_lo =3D cpu_to_be32(d->io_regions[i].addr);
>          assigned->size_hi =3D reg->size_hi;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxTmiAACgkQbDjKyiDZ
s5LRrRAAtsWhdWoYw4BCrWF/RPiW2ms+qo3oYK6ItYwVWRWpOTUww2Yhw4H3UXr0
w526vm3e9HD5/sg2J4vnWNd8FhhQz6nms4XS5ldjv7P+wGnyATGy2qYNePSk2KdB
2ugezJEU10aiQFrocDFDF1ZPaoZtrTodNBYFzZc5xDRSpAj6tUYxVXF8mVSoMzed
VVD45PXyRdD+rxFIgFAKa/lFRVKC55iY5LlkhVmMOXA1dZrRHZDpOw6yvv7QdgLT
vcizWoqzuhKvyxEui8gZDBATt7pSyeiCx4OV+asWVNfJkc0SQ3DbVfzl2s8A8SjR
xDdh0GDcAscLt/GxYN1AyGkCzkUbRe9OLvlLfvs9NXdfljie2UxH9wfwuC4C25oF
MWT9UphQYzbCp/16PC/4ZPoH/uZ5aVolQmVNBOnKiu2xWI7+rKxqLbm8UgriOeY7
LH9CrrKbzNhYtGsiEBeeVxkkkgpZoB3MMjT2iYjSTZHnpVtzrS718pIwf/fwQBIC
QR79IlKU2S+++jrvUCb2dtvtgBCJf7zz24SXpV+w8G94tSZRlg/APUi7vMuc9p5c
KRt97WQOZNoMUyRmZWfpgIy2NG/Pg7zOFR6HfeqSppfxkgrF7Rs0YyJrx425gV3H
eDQOVt+gmPnjxLE7GMZGwyzC0iGSyzyp7r98SLhilgIOI3jbxjI=
=5Gaq
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
