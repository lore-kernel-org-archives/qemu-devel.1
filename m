Received: from eggs.gnu.org ([2001:4830:134:3::10]:50966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1efKKb-00080C-J7
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 01:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1efKKY-0007Dp-H2
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 01:51:17 -0500
Received: from ozlabs.org ([103.22.144.67]:56405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1efKKX-0007AM-N8
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 01:51:14 -0500
Date: Sat, 27 Jan 2018 17:26:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180127062616.GD2099@umbus>
References: <20180126092029.20737-1-mark.cave-ayland@ilande.co.uk>
	<20180126092029.20737-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20180126092029.20737-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 1/3] grackle: convert to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2018 at 09:20:27AM +0000, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.12.

> ---
>  hw/pci-host/grackle.c    | 13 ++-----------
>  hw/pci-host/trace-events |  3 +++
>  2 files changed, 5 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> index 3caf1ccb37..033588b7d2 100644
> --- a/hw/pci-host/grackle.c
> +++ b/hw/pci-host/grackle.c
> @@ -27,16 +27,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/ppc/mac.h"
>  #include "hw/pci/pci.h"
> -
> -/* debug Grackle */
> -//#define DEBUG_GRACKLE
> -
> -#ifdef DEBUG_GRACKLE
> -#define GRACKLE_DPRINTF(fmt, ...)                               \
> -    do { printf("GRACKLE: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define GRACKLE_DPRINTF(fmt, ...)
> -#endif
> +#include "trace.h"
> =20
>  #define GRACKLE_PCI_HOST_BRIDGE(obj) \
>      OBJECT_CHECK(GrackleState, (obj), TYPE_GRACKLE_PCI_HOST_BRIDGE)
> @@ -58,7 +49,7 @@ static void pci_grackle_set_irq(void *opaque, int irq_n=
um, int level)
>  {
>      qemu_irq *pic =3D opaque;
> =20
> -    GRACKLE_DPRINTF("set_irq num %d level %d\n", irq_num, level);
> +    trace_grackle_set_irq(irq_num, level);
>      qemu_set_irq(pic[irq_num + 0x15], level);
>  }
> =20
> diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
> index 32dfc84692..5b8fcc228b 100644
> --- a/hw/pci-host/trace-events
> +++ b/hw/pci-host/trace-events
> @@ -1,5 +1,8 @@
>  # See docs/devel/tracing.txt for syntax documentation.
> =20
> +# hw/pci-host/grackle.c
> +grackle_set_irq(int irq_num, int level) "set_irq num %d level %d"
> +
>  # hw/pci-host/sabre.c
>  sabre_set_request(int irq_num) "request irq %d"
>  sabre_clear_request(int irq_num) "clear request irq %d"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpsG4UACgkQbDjKyiDZ
s5KoVBAAo0uZFnarMtymY/5cmSYg/QS647+VQXXqivxH0nn52YUPgobNnE9UnPo1
htd5NjYGsDlxEkFXWsiube2iPhJfAv7uPBp/LkS9lmAkZUR+SNVZFkgSlrTM2Y31
8Ao7g1rYkCyNrm3acRZejbpn1kQSMW9ZwURM5EymNl2uVyTtupMO3Yo2wp11Z7Q/
8xRoAfPWiUURWFg3loOCm7xk0tXNEAxOjWlQg6ltxYfgz5oiXmqjk2MZpiWF9Uvc
gZ1+rAgqGxFImhi8u3ldC7Jz8Qem9RIue4Ma7irWtQrm/Je2r9TY8TczSXiihF7K
zRLRFP/70Y5o7Bh7y9rHrzu1XVSSxgqBVzfmqID/2bkN/x+vhqZzIy7bS82O2K2F
RAFqoKqvl8c7oTFiu8ReBFsqaS5NjKApmb39R02SA6L46w3EKyS0SHmiJjOs0z8k
QJb894kHhtT/pjGwVnQmHxMMIc5ExJTzxSlPqn/4eM9Vccw5d9ZHKuKroAVIaJpV
aaGZti1uhPaPkUp/3L/62msnQzKczVZD1hs2DcfydUcqHbS0+3hU19VOYbLac6bE
/NWo1M4jS0S0Ip+SehPZSXOFFNczAYZfo2y+wWRG4S6RMlufys9l/2UiYSHnm0Gd
DZR7nkQv4V6XZTBv5ndyqNpxMj62XvxiHrjaUEu5K5dUBN+i+DA=
=gKls
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
