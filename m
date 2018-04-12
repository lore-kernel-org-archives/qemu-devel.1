Received: from eggs.gnu.org ([2001:4830:134:3::10]:50797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6SAc-0004hA-CL
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6SAb-00041k-5z
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:41:06 -0400
Date: Thu, 12 Apr 2018 12:23:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180412022306.GE9425@umbus.fritz.box>
References: <152345888086.82965.6686500865958674552.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Content-Disposition: inline
In-Reply-To: <152345888086.82965.6686500865958674552.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.13] spapr: drop useless dynamic
 sysbus device sanity check
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


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 05:01:20PM +0200, Greg Kurz wrote:
> Since commit 7da79a167aa11, the machine class init function registers
> dynamic sysbus device types it supports. Passing an unsupported device
> type on the command line causes QEMU to exit with an error message
> just after machine init.
>=20
> It is hence not needed to do the same sanity check at machine reset.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.13, thanks.

> ---
>  hw/ppc/spapr.c |   18 ------------------
>  1 file changed, 18 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3ffadd6ac7ce..637e50e6d10b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1440,21 +1440,6 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *s=
papr)
>      }
>  }
> =20
> -static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
> -{
> -    bool matched =3D false;
> -
> -    if (object_dynamic_cast(OBJECT(sbdev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
> -        matched =3D true;
> -    }
> -
> -    if (!matched) {
> -        error_report("Device %s is not supported by this machine yet.",
> -                     qdev_fw_name(DEVICE(sbdev)));
> -        exit(1);
> -    }
> -}
> -
>  static int spapr_reset_drcs(Object *child, void *opaque)
>  {
>      sPAPRDRConnector *drc =3D
> @@ -1478,9 +1463,6 @@ static void spapr_machine_reset(void)
>      void *fdt;
>      int rc;
> =20
> -    /* Check for unknown sysbus devices */
> -    foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
> -
>      spapr_caps_reset(spapr);
> =20
>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrOwwoACgkQbDjKyiDZ
s5ISbg//UaPDyMjuAek/7K6B83Vn9T9Qtm2srsVwRSngBznLXAa5Ib2gI6F76nME
u8qAEQwelJj7kw9a+lkQbUGNH4dI7ppPNPkl/17nB7H9MVs5UH7+I7tVmAZNCmx2
uac8ZrOx0sAv78Pme7f2jLbGO5l0u0KaLv6hJGa0OBgnHjmPl9J3uGKQDCidClFv
fiCDbWMewIhjU71NirfRfTe/ZEDSc0w74ZPJW/I0Z32zvhSUbcI4YjBV9Xe8v23Y
dP8UqPfDQ5p4C9IpyTz5AFMm68KukxevsqN/f1Bxhva0/fuYGrSk0nnV7Pv1ueQV
sBxxgV+cuLUb7HOyzPfwgjvB6Zlv6gE4PjmrzQsjVL/uB+1CbetuXT11KhrEWoAJ
N5WZPwDZZyRpdrXnpJuk40urIkv1BL7TlYBnytz0Yn/E6WLfbAI1ZmjYhyz7Zlvt
rmtwsTZEhxAcfXqrlEOkIMxm0cfEbo6RE2l0ety4oEEjMuiQV5tC8cFvptNDgw9M
cJpMz7mpRLdJp9t5WrRDa2gfFj1umBSUlsw8aFKsRGoBAHo0vrSddToBDBNZnf3c
dJ6vOvw0/grXfi0lhUpSClnWoztz+ClM0H7+Bo61fsHL6DGKS1MAxEkCuw/C1xqj
xOCQ34Kg7LPIhCv17aznzilt7zB3maR1bdsgaVIjHy3GjUytNHQ=
=FDzN
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
