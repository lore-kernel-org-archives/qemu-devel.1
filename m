Received: from eggs.gnu.org ([2001:4830:134:3::10]:36123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0H-0007Jb-EF
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0E-00029a-AS
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:25 -0400
Date: Sat, 23 Sep 2017 15:08:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170923050824.GW4998@umbus.fritz.box>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HKOZ/JADkehwFk9I"
Content-Disposition: inline
In-Reply-To: <20170922154014.29350-2-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 01/34] hw: use "qemu/osdep.h" as first
 #include in source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org


--HKOZ/JADkehwFk9I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 12:39:41PM -0300, Philippe Mathieu-Daud=E9 wrote:
> applied using ./scripts/clean-includes
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc portion

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/acpi/ipmi-stub.c             | 1 +
>  hw/audio/fmopl.c                | 1 -
>  hw/cpu/core.c                   | 1 +
>  hw/ppc/spapr_cpu_core.c         | 1 +
>  hw/smbios/smbios_type_38-stub.c | 1 +
>  hw/vfio/ccw.c                   | 2 +-
>  hw/virtio/vhost-vsock.c         | 2 +-
>  7 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/acpi/ipmi-stub.c b/hw/acpi/ipmi-stub.c
> index 98b6dcee0d..f525f71c2d 100644
> --- a/hw/acpi/ipmi-stub.c
> +++ b/hw/acpi/ipmi-stub.c
> @@ -7,6 +7,7 @@
>   * See the COPYING file in the top-level directory.
>   */
> =20
> +#include "qemu/osdep.h"
>  #include "hw/acpi/ipmi.h"
> =20
>  void build_acpi_ipmi_devices(Aml *table, BusState *bus)
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index 5cfb6a96dd..9f50a89b4a 100644
> --- a/hw/audio/fmopl.c
> +++ b/hw/audio/fmopl.c
> @@ -34,7 +34,6 @@
>  #include <math.h>
>  //#include "driver.h"		/* use M.A.M.E. */
>  #include "fmopl.h"
> -#include "qemu/osdep.h"
>  #ifndef PI
>  #define PI 3.14159265358979323846
>  #endif
> diff --git a/hw/cpu/core.c b/hw/cpu/core.c
> index bd578ab80c..7e42e2c87a 100644
> --- a/hw/cpu/core.c
> +++ b/hw/cpu/core.c
> @@ -6,6 +6,7 @@
>   * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   * See the COPYING file in the top-level directory.
>   */
> +#include "qemu/osdep.h"
>  #include "hw/cpu/core.h"
>  #include "qapi/visitor.h"
>  #include "qapi/error.h"
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c08ee7571a..4a4f0c60fe 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -6,6 +6,7 @@
>   * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   * See the COPYING file in the top-level directory.
>   */
> +#include "qemu/osdep.h"
>  #include "hw/cpu/core.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "target/ppc/cpu.h"
> diff --git a/hw/smbios/smbios_type_38-stub.c b/hw/smbios/smbios_type_38-s=
tub.c
> index 9528c2c28e..5b83c9b1f1 100644
> --- a/hw/smbios/smbios_type_38-stub.c
> +++ b/hw/smbios/smbios_type_38-stub.c
> @@ -7,6 +7,7 @@
>   * See the COPYING file in the top-level directory.
>   */
> =20
> +#include "qemu/osdep.h"
>  #include "hw/smbios/ipmi.h"
> =20
>  void smbios_build_type_38_table(void)
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index a8baadf57a..4810fa0b50 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -11,11 +11,11 @@
>   * directory.
>   */
> =20
> +#include "qemu/osdep.h"
>  #include <linux/vfio.h>
>  #include <linux/vfio_ccw.h>
>  #include <sys/ioctl.h>
> =20
> -#include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "hw/vfio/vfio.h"
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index 49e0022533..c11c1eb83e 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -11,8 +11,8 @@
>   * top-level directory.
>   */
> =20
> -#include <sys/ioctl.h>
>  #include "qemu/osdep.h"
> +#include <sys/ioctl.h>
>  #include "standard-headers/linux/virtio_vsock.h"
>  #include "qapi/error.h"
>  #include "hw/virtio/virtio-bus.h"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HKOZ/JADkehwFk9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnF7EYACgkQbDjKyiDZ
s5Klqg/+KXzJ/Px0WQLiAd81GJ3ZXbVbQPpv1ZfRwxzZIG3e6UfNfinpBiW3W/+F
DnrGfTrj+N26J5EyFdTlo9GRLL0A2L0Hn8odVHiP32AsUN/dRNCeEQ0l50GVubWd
Wow41uxIJv4oOW7ZxKlDNcKdKl9nObQKYC42Kbr+WwhZ/rpHzZXNvGU2FCe+ItFx
tWU3ZRDTmDws55KpjZzsLLurhKSvOVsc0I72T4XuzZniE8p6g/YTbvSL+OP+W68J
P2bMJsct/tbtDAtPzYTuvikCkSVWndfX0osa0HbDBraa0It651m/A4c3zEktfrrI
4oJQ2ptFQKVgCsVguN9oMUNd+HCOLWlEwGEElf7sltxc3Ob6tNsGC0is8vH8gltX
KU5BkogI6SIe9sIzn0L3nbZAwTykIXfNx2SQ6LGBQw6sM1na3+4OLz86c23aC6Jp
fMA0tocMXEJ9bqZSEvjGUW2t8ofbcUmke+p3ofSuXC6Gii4ZwHytrtohEBOLzeqJ
nUdW7onL+2pLjn0diqOs+tSKww+GOaR977zIttPc6heBdHUF8X/7Lk6YAkqoS3Xk
I3XdxLDQVzB+tMiKraictYDHRDxONzBdOx/FyJPA5rG4Kk99/z8F/E06neRBKSTZ
eQOzhUibhAz40f31dio8yQtVHl9tgFW0wWvZLuLJCtHQk8grmak=
=Gm9o
-----END PGP SIGNATURE-----

--HKOZ/JADkehwFk9I--
