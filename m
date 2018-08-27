Received: from eggs.gnu.org ([2001:4830:134:3::10]:47904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fu5kQ-0005TI-Qk
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 20:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fu5gn-0006vM-HT
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 20:47:32 -0400
Date: Mon, 27 Aug 2018 10:43:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180827004329.GB2222@umbus.fritz.box>
References: <153512460418.276612.14744411474887601809.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <153512460418.276612.14744411474887601809.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: fix potential NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2018 at 05:30:04PM +0200, Greg Kurz wrote:
> Commit 2c88b098e76fd added a call to SPAPR_MACHINE_GET_CLASS(spapr) in
> spapr_phb_realize() before we check spapr isn't NULL. This causes QEMU
> to crash when starting a non-pseries machine with a sPAPR PHB.
>=20
> This could be fixed by setting the smc variable after the null check,
> but it seems more explicit to use a ternary operator to skip the call
> to SPAPR_MACHINE_GET_CLASS() if spapr is NULL, since spapr_phb_realize()
> will return immediately in this case.
>=20
> This was reported by Coverity (CID 1395170 and 1395183).
>=20
> Fixes: 2c88b098e76fde0c7fcc0476dd3f80ce58409505
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5cd676e4430d..6bcb4f419b6b 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1559,7 +1559,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      sPAPRMachineState *spapr =3D
>          (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
>                                                    TYPE_SPAPR_MACHINE);
> -    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    sPAPRMachineClass *smc =3D spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : =
NULL;
>      SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluDSTEACgkQbDjKyiDZ
s5Kijw//Ucjx0vIXRIBgGrGIQis0yPRTZtOW3m2xy2f68Zkl68wN4O42jVy4+PO4
T0pqxBOQvC0k8sCYHm1OBuQ3Mb0ym/k3SqbkGZSfhcJB1JkfaWA8JH+u/16iFIU3
c5ietP1hjyIwzlwunZzWIFiVpFUbgG2+is2B/aQlSX2ImR+X2+iGjSq6NiSQMMjJ
8RH2DTVHVx50GTcBxQHtWKjkMOE8n4cLpzUewW3mnGKIF1wYGuPWC3SqcgMErfe7
rDs0q17LWVZUglXMYWzf3dIx1xdLmK93E9/520qPMTWy3vHvTF+EFP3OPMxfBGpO
8UsEe4kwH7wSxEixd6Run+5iFtHKP+toukzAy4TWJlUBpvnNpZfs7cUbQdyCjgRF
p+aPmOSETdD6f7SqwQ4A23m1pi26VEmWry50OtMxQD+qptx9s/Y3oYRcc0texP/c
wra1PDp/FFRJTVFSGQFSnPy7WwAztMWFurZ9ICQkIIpR2AWbVG1h/dGfkjB/DGyh
QmtQLmPM7sS6qc0kJ42XsI4RMMFU5CWYFzBmky2v7ecYa45e+MUXphzC7S9uKwn5
Jq3FriZka4ysH+9J/d/MzYBicNGOzUQdLmIxl3/uEmNaTRWLMsSZZ9mZjpUl8aPd
gN8+irvPKsgnbLMW2AOKAFNs7DI4QhXDn/ZfF8w9uGDJ+DWTUrw=
=Mu9n
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
