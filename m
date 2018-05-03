Received: from eggs.gnu.org ([2001:4830:134:3::10]:47823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEO5K-0001nr-0J
	for qemu-devel@nongnu.org; Thu, 03 May 2018 19:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEO5F-0000dB-Rz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 19:56:26 -0400
Date: Fri, 4 May 2018 09:36:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503233609.GE13229@umbus.fritz.box>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-60-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gqO6s7S91gFL8ZIQ"
Content-Disposition: inline
In-Reply-To: <1525376963-79623-60-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 59/67] hw/ppc: add target headers explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--gqO6s7S91gFL8ZIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 10:51:39PM +0300, Michael S. Tsirkin wrote:
> This way they are easier to find.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c       | 6 +++---
>  hw/ppc/spapr_caps.c  | 2 +-
>  hw/ppc/spapr_hcall.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a81570e..62d625c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -42,9 +42,9 @@
>  #include "migration/misc.h"
>  #include "migration/global_state.h"
>  #include "migration/register.h"
> -#include "mmu-hash64.h"
> -#include "mmu-book3s-v3.h"
> -#include "cpu-models.h"
> +#include "target/ppc/mmu-hash64.h"
> +#include "target/ppc/mmu-book3s-v3.h"
> +#include "target/ppc/cpu-models.h"
>  #include "qom/cpu.h"
> =20
>  #include "hw/boards.h"
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 531e145..b950a0a 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -27,7 +27,7 @@
>  #include "qapi/visitor.h"
>  #include "sysemu/hw_accel.h"
>  #include "target/ppc/cpu.h"
> -#include "cpu-models.h"
> +#include "target/ppc/cpu-models.h"
>  #include "kvm_ppc.h"
> =20
>  #include "hw/ppc/spapr.h"
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 16bccdd..f011fa9 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -6,14 +6,14 @@
>  #include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> -#include "helper_regs.h"
> +#include "target/ppc/helper_regs.h"
>  #include "hw/ppc/spapr.h"
>  #include "mmu-hash64.h"
>  #include "cpu-models.h"
>  #include "trace.h"
>  #include "kvm_ppc.h"
>  #include "hw/ppc/spapr_ovec.h"
> -#include "mmu-book3s-v3.h"
> +#include "target/ppc/mmu-book3s-v3.h"
> =20
>  struct SPRSyncState {
>      int spr;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gqO6s7S91gFL8ZIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrrnOkACgkQbDjKyiDZ
s5Jx0BAAvfyRdOBP6I2ci9G7skY+qxhBl00OKc7VNi0q2XZXCdH5k7WEyIl8EwQa
zNtk39y323oBHLCsBexz7k32hS+Wj8mMr/sBqR80l+31LdBd1BqzmUVSDwxPKUFo
LFnF870oDH7IST+Fif872+AeSy930zldd8yMRjxrQ/3EiaSz/9CFw72OzyhZGkIm
qhBXVeB6ofARrFcTyiVlJtxDuG8psLY3KcEd2HS9H4UXs2wwRsgmobBu2fUxfMYz
sKZQHvEMvyaH6zzjq8UgfgxLjVMwJINQm7ycVNZc7eNreVLr8QlyWJY13sak+pmV
yA4vFPNpNIUx6hF15G3+zluMfR8739ljF93dXNbGgxgONwEP/l5WmiXU7izg2MNh
U/QLFzvbqMiR4UWZxJ65x7Z8wzrjnahD5XlJKhhEq7Pq4T3CHJyu+47Gjf06TCP5
wo7DZCnEL3XrgomeEP5/wiEWHGglpNjsqRiiAYQk5WAk2YvjYDiewkLF0xoZDkLa
x2S+43he+2NpzFiUpk9oRCH912ehu6rD9Vmoe7g4kqw204rGwckFqHrLhLgy/ci0
jKv5j8V2bxHlywNuAy8VEf46YuBdJwR4rklx5+ZVLRoiMO4mdnkcIkgpB7Z8CuhW
JALkVUl+yYVK8i3Y7eCSiWWFwPQHNnNBwAAvbk+2mFPmqnxe0js=
=sqPA
-----END PGP SIGNATURE-----

--gqO6s7S91gFL8ZIQ--
