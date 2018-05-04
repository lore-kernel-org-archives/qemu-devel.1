Received: from eggs.gnu.org ([2001:4830:134:3::10]:53896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUY-00023E-O8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUX-0004F5-Pt
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:34 -0400
Date: Fri, 4 May 2018 10:17:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504001701.GL13229@umbus.fritz.box>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-63-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/pvEKOcHgREgBce"
Content-Disposition: inline
In-Reply-To: <1525376963-79623-63-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 62/67] kvm: use include "kvm_ppc.h"
 consistently
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


--J/pvEKOcHgREgBce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 10:51:42PM +0300, Michael S. Tsirkin wrote:
> Some places include kvm_ppc.h, others target/ppc/kvm_ppc.h.
> Let's be consistent.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

One of your earlier patches in this series moved to using a full
target/ppc/whatever.h for includers outside target/ppc itself.  So I'm
not sure why you're standardizing on the short form here.

> ---
>  hw/ppc/spapr_cpu_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 94afeb3..312d6ed 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -15,7 +15,7 @@
>  #include "qapi/error.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/kvm.h"
> -#include "target/ppc/kvm_ppc.h"
> +#include "kvm_ppc.h"
>  #include "hw/ppc/ppc.h"
>  #include "target/ppc/mmu-hash64.h"
>  #include "sysemu/numa.h"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J/pvEKOcHgREgBce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrrpn0ACgkQbDjKyiDZ
s5IynxAAsB8NZ3NvTpAMzWm7pMeVzc8mxnNbgkOtHXwX7iX/iXEuGvjK25DotVUV
pV2He5Vu8I0ghw90fIhYqwYByelMmCD3GRmU7ktIBSuCZlsFSRcg10oFBpMB42G0
prweIV2jT6C6LZbUJDmSDmfW67YcsDrP7+Zx0edXsskDhbt5KEZTOBvDjMCjPiGn
WxTZx0YI99BEKPYTqLPi6AQDXOJXwBWsmDpH4nGQQYqvYZuQk7twPzIBdXVLY77V
CKgTkD91FEuNwzYYszz0DEwFdW/FJD/SDgk3nVZiBDYo7hiO+hy0kwxfDdAmAGTt
pvoxDwIOBwqQwsleHLGpPXYO4Cbz4sIwy6RgLcUhxxJTYpkYl9Y7kQfkz8fMRDf+
asTvi2rGVue+0uDXbmOuRz3mG7wFAQPN99O9PkrXvM0af9eAG4BnheUFDElRHKEN
t/56nvor4yXwvYYR1rQ5QKS0Vi2QMJ8G2RkdbCBlJND3pVWGn9QVy93V6pduBjg7
uea0+rk59b8MEsgs0SvTn5Hn5TywTxZRRf+XI4JHtWk7hT1YeYFhHxJF96JCiLbZ
mXcX1uNLVy7C3ul8RHp1IpdecMUm4htsxGQbYABani7zvE76QqrS++54dBB9bzEW
1jp0Rz6B5H/8L1Lm4FW6+DsSO3OiBWQDdT6vcudzsKtK21JfKLk=
=mlAH
-----END PGP SIGNATURE-----

--J/pvEKOcHgREgBce--
