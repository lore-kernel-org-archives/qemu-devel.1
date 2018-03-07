Received: from eggs.gnu.org ([2001:4830:134:3::10]:46256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etOzM-00072l-NM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 21:39:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etOzI-0006yb-MP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 21:39:32 -0500
Date: Wed, 7 Mar 2018 13:25:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180307022550.GB3083@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 01/19] uninorth: trivial style fixups
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


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:30:45PM +0000, Mark Cave-Ayland wrote:
> This makes sure we keep patchew/checkpatch happy during the remainder of =
this
> patchset.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/pci-host/uninorth.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 66991da975..710818e355 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -272,7 +272,6 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
>      UNINState *d;
> =20
>      /* Uninorth AGP bus */
> -
>      dev =3D qdev_create(NULL, TYPE_U3_AGP_HOST_BRIDGE);
>      qdev_init_nofail(dev);
>      s =3D SYS_BUS_DEVICE(dev);
> @@ -302,16 +301,23 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
> =20
>  static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
>  {
> -    d->config[0x0C] =3D 0x08; // cache_line_size
> -    d->config[0x0D] =3D 0x10; // latency_timer
> -    d->config[0x34] =3D 0x00; // capabilities_pointer
> +    /* cache_line_size */
> +    d->config[0x0C] =3D 0x08;
> +    /* latency_timer */
> +    d->config[0x0D] =3D 0x10;
> +    /* capabilities_pointer */
> +    d->config[0x34] =3D 0x00;
>  }
> =20
>  static void unin_agp_pci_host_realize(PCIDevice *d, Error **errp)
>  {
> -    d->config[0x0C] =3D 0x08; // cache_line_size
> -    d->config[0x0D] =3D 0x10; // latency_timer
> -    //    d->config[0x34] =3D 0x80; // capabilities_pointer
> +    /* cache_line_size */
> +    d->config[0x0C] =3D 0x08;
> +    /* latency_timer */
> +    d->config[0x0D] =3D 0x10;
> +    /* capabilities_pointer
> +    d->config[0x34] =3D 0x80; */
> +
>      /*
>       * Set kMacRISCPCIAddressSelect (0x48) register to indicate PCI
>       * memory space with base 0x80000000, size 0x10000000 for Apple's
> @@ -333,9 +339,12 @@ static void u3_agp_pci_host_realize(PCIDevice *d, Er=
ror **errp)
> =20
>  static void unin_internal_pci_host_realize(PCIDevice *d, Error **errp)
>  {
> -    d->config[0x0C] =3D 0x08; // cache_line_size
> -    d->config[0x0D] =3D 0x10; // latency_timer
> -    d->config[0x34] =3D 0x00; // capabilities_pointer
> +    /* cache_line_size */
> +    d->config[0x0C] =3D 0x08;
> +    /* latency_timer */
> +    d->config[0x0D] =3D 0x10;
> +    /* capabilities_pointer */
> +    d->config[0x34] =3D 0x00;
>  }
> =20
>  static void unin_main_pci_host_class_init(ObjectClass *klass, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqfTa4ACgkQbDjKyiDZ
s5IvGRAAtCkNQZJ2qvlazMCB0/PwU3+zgVXhZGeC6ZRJeErm28sboC5ESiUqEddZ
MTr6PlSoPWjG5zfU2rUeHCsfOhOZUQnNUOhWln0yXcS0GwaHyux076fu7uwsss4q
nhj4eT+6NXelVJB9/YxoOSmIk8/DimMV1AIQaC/GQ1omU3XEMCnp+pa6aXP+fSET
TjIyrKm4QdG6o/cd3bXgA+e+SSYF+6VlwHdT2e/kOkzr/BjB6XQjaI5q8a2pjkbP
tCRo7Dhqs4r6n47SdVuJJ5qHIcJGXDVQDSBuedigb38kErIPXmhGH9cgjTgR6CKb
qqaqdbDgvIzE5mV2jwFlK+Xk9/WGnPteFqfHcgqCe5xXxEnghaRlWJLlWvyEYj5L
S5MuvsptdWmWa7EiR7K1JJxfWY63N3rDr0Fx3yv7mjSxcxxZgAKTqWYn+79DcGHt
yZ6i3SBx9cIfNF7JRCy3KuhucO4Y5wiB3d1skzU+X2DP0d2lssK/UGqbD95HxMMW
EAhGcMszurZvl8lhSCQ6DPRTvclqh6mHnjqIEUSe21ZkBGXil5hBV1NxoRsnBBsg
bT9hSZif3pnAuA0Rxrbb3KI+cWxy2nYwVxvy7cfd8MEhTsOQSida2JyLg1r5wpK0
iNVXG/OD9ti6tPDLzP5aapPvtF6iISSv9cRjOZzLPjBfP+KNu/8=
=oBCI
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
