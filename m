Received: from eggs.gnu.org ([2001:4830:134:3::10]:55587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dH8UV-00045I-Cd
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 08:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dH8UU-0007HM-4e
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 08:49:15 -0400
Date: Sat, 3 Jun 2017 21:54:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170603115444.GT13397@umbus.fritz.box>
References: <1496303518-25638-1-git-send-email-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HtRZva1Vzv8iP5ye"
Content-Disposition: inline
In-Reply-To: <1496303518-25638-1-git-send-email-felipe@nutanix.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Allow boot from vhost-*-scsi
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mike Cui <cui@nutanix.com>


--HtRZva1Vzv8iP5ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 08:51:58AM +0100, Felipe Franciosi wrote:
> This makes VMs bootable on spapr when using vhost-*-scsi.

This commit message needs more information: what previously prevented
vhost-*-scsi from working?

> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Mike Cui <cui@nutanix.com>
> ---
>  hw/ppc/spapr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ab3aab1..1c87886 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -57,6 +57,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/scsi/scsi.h"
>  #include "hw/virtio/virtio-scsi.h"
> +#include "hw/virtio/vhost-scsi-common.h"
> =20
>  #include "exec/address-spaces.h"
>  #include "hw/usb.h"
> @@ -2388,6 +2389,7 @@ static char *spapr_get_fw_dev_path(FWPathProvider *=
p, BusState *bus,
>      ((type *)object_dynamic_cast(OBJECT(obj), (name)))
>      SCSIDevice *d =3D CAST(SCSIDevice,  dev, TYPE_SCSI_DEVICE);
>      sPAPRPHBState *phb =3D CAST(sPAPRPHBState, dev, TYPE_SPAPR_PCI_HOST_=
BRIDGE);
> +    VHostSCSICommon *vsc =3D CAST(VHostSCSICommon, dev, TYPE_VHOST_SCSI_=
COMMON);
> =20
>      if (d) {
>          void *spapr =3D CAST(void, bus->parent, "spapr-vscsi");
> @@ -2444,6 +2446,12 @@ static char *spapr_get_fw_dev_path(FWPathProvider =
*p, BusState *bus,
>          return g_strdup_printf("pci@%"PRIX64, phb->buid);
>      }
> =20
> +    if (vsc) {
> +        /* Same logic as virtio above */
> +        unsigned id =3D 0x1000000 | (vsc->target << 16) | vsc->lun;
> +        return g_strdup_printf("disk@%"PRIX64, (uint64_t)id << 32);
> +    }
> +
>      return NULL;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HtRZva1Vzv8iP5ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMqOEAAoJEGw4ysog2bOSiUMP/iBmCJSDdE1jd+gFwGcBedJT
gEnrsxwz4H4TkTaws6SmoqlRdjBAQ47UuB0vVmHYnUGAxCKNWzsNtTVDVvroMDuh
Q7NwvnD3un+0VgUImsQilHvrZ201XskT1lpf0tKg9ivVNeyOITZ35RIucP5T7w4Z
b1irq+iFOlP/aVqitDiukBLrWjk483IJjesiblcvlnZ907N4R6VK9+4Cizw7qI2h
noMaB7zxw+Nxfy+zGRDYpjE6kCzat26Eg6SxBxeIk/Peg1+VZvSp8Qen5wgUcviG
aew7qAEN4+S5iS8pwIq3Iey33mXJGJQJVRt4JcLulsGxjUjH7yGKuG20dxUuBUaE
NYPYLpnUKj2wzNQz3cn7K8TOtK64ErJFHNGvsFpxETSL9NAl9dXLS+eDyS+fcs2S
DGg3Hq+LfrsmThT2Fwq11+Y2nwIuWjYwj7snnSOHl65y+eP5XkT0wcfM5Eb9izrr
ob/V9ioCY7jODkDkst9zSDD8VbLGuRAIyBlLAjuUsSEER0Fu8D3eJtmdC1DAze0a
0Z9NwZAMcz7iWC3qamrcLH+JhFACpWX4DO51ju+2PG2s8JSbDivUX1dUrpiXPr1R
j9uRYt0G/9U368y4dbEgFJ8Rl64MbrAQdjKyEaX+dnJgtgliTYfCBws2Q30j0nmB
xEQ0xU5nSRrNeTpbY052
=2nQl
-----END PGP SIGNATURE-----

--HtRZva1Vzv8iP5ye--
