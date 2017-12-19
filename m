Received: from eggs.gnu.org ([2001:4830:134:3::10]:40857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR6O9-0002ZI-1g
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR6O7-00081d-Ot
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:08:09 -0500
Date: Tue, 19 Dec 2017 11:38:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171219003805.GG4786@umbus.fritz.box>
References: <151361268274.29357.7778552806095274865.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline
In-Reply-To: <151361268274.29357.7778552806095274865.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: use warn_report()
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


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 04:58:02PM +0100, Greg Kurz wrote:
> These two are definitely warnings. Let's use the appropriate API.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.12, thanks.

> ---
>  hw/ppc/spapr_pci.c      |    6 +++---
>  hw/ppc/spapr_pci_vfio.c |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 88797b3d3622..695c82091140 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1696,9 +1696,9 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      /* DMA setup */
>      if (((sphb->page_size_mask & qemu_getrampagesize()) =3D=3D 0)
>          && kvm_enabled()) {
> -        error_report("System page size 0x%lx is not enabled in page_size=
_mask "
> -                     "(0x%"PRIx64"). Performance may be slow",
> -                     qemu_getrampagesize(), sphb->page_size_mask);
> +        warn_report("System page size 0x%lx is not enabled in page_size_=
mask "
> +                    "(0x%"PRIx64"). Performance may be slow",
> +                    qemu_getrampagesize(), sphb->page_size_mask);
>      }
> =20
>      for (i =3D 0; i < windows_supported; ++i) {
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index 8448e0b0247d..1f775ea93dc6 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -50,7 +50,7 @@ static Property spapr_phb_vfio_properties[] =3D {
>  static void spapr_phb_vfio_instance_init(Object *obj)
>  {
>      if (!qtest_enabled()) {
> -        error_report("spapr-pci-vfio-host-bridge is deprecated");
> +        warn_report("spapr-pci-vfio-host-bridge is deprecated");
>      }
>  }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo4X20ACgkQbDjKyiDZ
s5I6Xw/+JK1VU1CA9uIuAXmTGPWIFAZT7V/kLkL8eE2gktYDUmcdNanvUSDCEfhh
E4SMZMLoSJsOOF1tg8ZOS62QWeq6A1mxQNBmfEEusfveanAZ/f6LBuElxQlL/CpP
Eak8FpbkCtPBVI6u6jYkmLdqBuAD8/ZPNSaDZ5AqV4JyOuC9ozKmGb7w0v0v9kZO
jL1omVs3EBqZNHZy4jQu0Q8zhIpaA3yQpToWROs47ZRe+uY62O4TSC8mknpN8Ozb
rmnUGCqFqhXIaC6JsuKAksV9kobkH8ys28C0usBXU9E29gQANX88SSvtU7AeTj+n
1EKsMa+5BiqAgFIZds9ChQ+WfRPb9rKd+MZNmSabZFNjhVdyE701XDN9CR6oEqPV
lnUuRs01/bxgovFuMcqP/pENL2rRYCidN0trPD0+EH9cpEfzr0J1xWK7rnFQD8+d
8Y3mCKh5ezAmGxPSn+jilO27OTH/d6/jBdj29GR4OCx7Twwqpulemeyolggh5YN5
x2EGx2/9hY2yYVE3/DbyyBOtl9/RgY6evEtS9b9SkkKa+pRndvx3CtoMCH0yH97c
AgfB2l7q6EeMWn99tCnlj4/3a6bWYlRixx3anH9Q5vKvsjtHw2GFj7ufBOEoeIe+
ynREbf8iLqREcr/6CdHx4/jgeIV8QSaaFNd7zpP2eTLDrQ3hj+c=
=AtzZ
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
