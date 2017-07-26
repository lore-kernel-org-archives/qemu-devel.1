Received: from eggs.gnu.org ([2001:4830:134:3::10]:60294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr7-0002VX-BX
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr6-0005ld-Du
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:29 -0400
Date: Wed, 26 Jul 2017 14:01:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726040141.GS8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100555881.27487.6700589734222986048.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p2u4WfPhYOuYlOsk"
Content-Disposition: inline
In-Reply-To: <150100555881.27487.6700589734222986048.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 06/26] spapr_pci: parent the MSI
 memory region to the PHB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--p2u4WfPhYOuYlOsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 07:59:18PM +0200, Greg Kurz wrote:
> This memory region should be owned by the PHB. This ensures the PHB
> cannot be finalized as long as the the region is guest visible, or
> used by a CPU or a device.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 3fe7f3145467..4e4165b44b9a 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1703,7 +1703,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      }
>  #endif
> =20
> -    memory_region_init_io(&sphb->msiwindow, NULL, &spapr_msi_ops, spapr,
> +    memory_region_init_io(&sphb->msiwindow, OBJECT(sphb), &spapr_msi_ops=
, spapr,
>                            "msi", msi_window_size);
>      memory_region_add_subregion(&sphb->iommu_root, SPAPR_PCI_MSI_WINDOW,
>                                  &sphb->msiwindow);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p2u4WfPhYOuYlOsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4FCUACgkQbDjKyiDZ
s5KN2RAAyrjF8ABXcTp5TPyXk8iZI9bqwKgbSVHJ1nkVbByNvnpCIT9SsOfP2/sX
HqBdFnebqHz0WVz54rEZZWTCDSL5QrvTtUrCqiemgTjA7klSiY+S2mdeP0oRlLSF
sJD9fIIXU4naRF2R13sQaRr8KOnmytjoV/NGNW6PZVtw4LofOtHOhqpPi8fV+Y3u
zPmvw0kMNGknJR9Suj+yStlYG1905ICEM/sL3r8J4G+9Ga49SxGq2F1x/XpQTloK
w3KaYT5oimFt0NSEeMtUq3bgn3PIsM4CMd0GeNZn6vI0M9ZKPhmv1FYIK03FKSwP
Ja27+tomPbE1cTdb/XR1f6RrNTmmMXG+pfhvcODrDIWyEUnRs9iLuDuCjkoaUZ/a
MdUGbOj2QTsQenX5z9jG2zCDgkHvbuFftn0lBvgXT1YcYH1ve8QQ32dNJC41kAXa
lYBNyvpfjAmXff7LoQq4nlzWGltcycxon6L+Uuq/93WF3IH89+5paM65Ia30XJX1
q/qV8C4nZHrp5sXSWDUBEMUR26phYy1MrOpHbByW118sPtpAjL6xvtoShHWotbxl
UeknHGWuOeNzHBZOSzpBEdRnRfQsBY/vwf2+0cuFlsbRi46zu2zyt0qrMlisiYUE
D4X48ga1lXmO1uAB8nEU5w5BGaa85OPf0sHve5cCRaN7e3z0SVY=
=vmON
-----END PGP SIGNATURE-----

--p2u4WfPhYOuYlOsk--
