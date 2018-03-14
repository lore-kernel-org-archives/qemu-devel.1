Received: from eggs.gnu.org ([2001:4830:134:3::10]:53353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew02q-0004Fk-9V
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew02m-0002Cu-CS
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:37:52 -0400
Date: Wed, 14 Mar 2018 16:43:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180314054316.GK4182@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-6-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Q2l3mYpK16UQ/iv"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-6-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 05/19] uninorth: move uninorth definitions
 into uninorth.h
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


--9Q2l3mYpK16UQ/iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:30:49PM +0000, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.13.

> ---
>  hw/pci-host/uninorth.c         | 22 +------------------
>  include/hw/pci-host/uninorth.h | 49 ++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 50 insertions(+), 21 deletions(-)
>  create mode 100644 include/hw/pci-host/uninorth.h
>=20
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 1d4d3f5705..600d675573 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -26,31 +26,11 @@
>  #include "hw/ppc/mac.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_host.h"
> +#include "hw/pci-host/uninorth.h"
>  #include "trace.h"
> =20
>  static const int unin_irq_line[] =3D { 0x1b, 0x1c, 0x1d, 0x1e };
> =20
> -#define TYPE_UNI_NORTH_PCI_HOST_BRIDGE "uni-north-pci-pcihost"
> -#define TYPE_UNI_NORTH_AGP_HOST_BRIDGE "uni-north-agp-pcihost"
> -#define TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE "uni-north-internal-pci-=
pcihost"
> -#define TYPE_U3_AGP_HOST_BRIDGE "u3-agp-pcihost"
> -
> -#define UNI_NORTH_PCI_HOST_BRIDGE(obj) \
> -    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_PCI_HOST_BRIDGE)
> -#define UNI_NORTH_AGP_HOST_BRIDGE(obj) \
> -    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_AGP_HOST_BRIDGE)
> -#define UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj) \
> -    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRID=
GE)
> -#define U3_AGP_HOST_BRIDGE(obj) \
> -    OBJECT_CHECK(UNINState, (obj), TYPE_U3_AGP_HOST_BRIDGE)
> -
> -typedef struct UNINState {
> -    PCIHostState parent_obj;
> -
> -    MemoryRegion pci_mmio;
> -    MemoryRegion pci_hole;
> -} UNINState;
> -
>  static int pci_unin_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
>      return (irq_num + (pci_dev->devfn >> 3)) & 3;
> diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
> new file mode 100644
> index 0000000000..9364c14bdd
> --- /dev/null
> +++ b/include/hw/pci-host/uninorth.h
> @@ -0,0 +1,49 @@
> +/*
> + * QEMU Uninorth PCI host (for all Mac99 and newer machines)
> + *
> + * Copyright (c) 2006 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef UNINORTH_H
> +#define UNINORTH_H
> +
> +#define TYPE_UNI_NORTH_PCI_HOST_BRIDGE "uni-north-pci-pcihost"
> +#define TYPE_UNI_NORTH_AGP_HOST_BRIDGE "uni-north-agp-pcihost"
> +#define TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE "uni-north-internal-pci-=
pcihost"
> +#define TYPE_U3_AGP_HOST_BRIDGE "u3-agp-pcihost"
> +
> +#define UNI_NORTH_PCI_HOST_BRIDGE(obj) \
> +    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_PCI_HOST_BRIDGE)
> +#define UNI_NORTH_AGP_HOST_BRIDGE(obj) \
> +    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_AGP_HOST_BRIDGE)
> +#define UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj) \
> +    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRID=
GE)
> +#define U3_AGP_HOST_BRIDGE(obj) \
> +    OBJECT_CHECK(UNINState, (obj), TYPE_U3_AGP_HOST_BRIDGE)
> +
> +typedef struct UNINState {
> +    PCIHostState parent_obj;
> +
> +    MemoryRegion pci_mmio;
> +    MemoryRegion pci_hole;
> +} UNINState;
> +
> +#endif /* UNINORTH_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9Q2l3mYpK16UQ/iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqotnQACgkQbDjKyiDZ
s5JJ9Q//ekiV2z21Oib5bUSLTxoqAyFdf3s+dunWsp2CxkxatOG5mzvlwN6r7itt
tArSPvOOVA/L0QVujpo/IK+SSPNdrtWhXNoLJbBug4XwTNFDCt+s4TJVEOrpwYGd
Kc3U54TLjGjwHVqSPAM+13Co4DP7sP5+KWG7617Xju8ky+o8TM2Umq5CV+/bn/jN
3B6lZYiIqEyTIKf5U6X9HL7e5kekeEg11ZY9ktCEmUBAw4QFlVt0fRL2OYinJHqA
xnEF8ApAzx2XlqHEZceJ4xmhUVv7AOnfmsvpvO4ZtKWFFpk2F6rc7sr8pjJHvht9
k83+qnQWyDB7tuOjgOzAcivOi8fr+FZpDwLJGC6jnI9LxXahu/tBCR4DdnbH4gUQ
A1KY/QWSIcIUI7jKok9bA3uLfa7lZHMpNSooDTSUxALZCy9HwSomBq7ofIy8jfMz
yGGpEUP7g9kVnWxDXX2OEGs+ZEMMjiQfvCJEFYCGlS2JdRD5NTeaRYBkd1GnzIR8
qUG0bpgdQc7Zg5VRqGLZNiJvpjQH/2GtJmETbu43nMgj2bHwncCdSmzXOyrAJ/jW
H8HOj1rVdmLfaUpeUCXbDngdDFs/SDiBNZD5yIzf2A7c3b6JsNY041MLX9wgGgVI
3//6enG0/jTDA9Abw7dTdt40GyYLp8AvXB8ca+1mibmiAIpjKFA=
=99I+
-----END PGP SIGNATURE-----

--9Q2l3mYpK16UQ/iv--
