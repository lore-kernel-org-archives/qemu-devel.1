Received: from eggs.gnu.org ([2001:4830:134:3::10]:36920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd2R-0000e6-NZ
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd2O-0003Zo-KH
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:31:39 -0400
Date: Sat, 23 Sep 2017 15:31:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170923053127.GA12504@umbus>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20170922154014.29350-7-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 06/34] ppc: remove duplicated includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 12:39:46PM -0300, Philippe Mathieu-Daud=E9 wrote:
> applied using ./scripts/clean-includes
>=20
> not needed since 7ebaf795560
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_hcall.c | 1 -
>  target/ppc/kvm.c     | 3 ---
>  2 files changed, 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 57bb411394..2aeee28fe6 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -13,7 +13,6 @@
>  #include "trace.h"
>  #include "kvm_ppc.h"
>  #include "hw/ppc/spapr_ovec.h"
> -#include "qemu/error-report.h"
>  #include "mmu-book3s-v3.h"
> =20
>  struct SPRSyncState {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 1deaf106d2..c9105af393 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -47,9 +47,6 @@
>  #include "sysemu/hostmem.h"
>  #include "qemu/cutils.h"
>  #include "qemu/mmap-alloc.h"
> -#if defined(TARGET_PPC64)
> -#include "hw/ppc/spapr_cpu_core.h"
> -#endif
>  #include "elf.h"
>  #include "sysemu/kvm_int.h"
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnF8a8ACgkQbDjKyiDZ
s5KCqBAAiSKO4TjrW2Ipp83di9lFF0sBcVMp9Vu/YP2YtT8JOEe2xVyGSLft74Hw
Kc6mVgNg0xrLX1LjaK2yp4+FPgU1p+z9VAs+uPrZQarV19+lPWHRoskmGzCS9kFq
2WyRjkGimZMwDITQ72wjoufuFd5IkTWtM3D2H2XOs1uGEmlGqz9NLcThyqzbAsv5
gAB13mHLcfyGbgot2ZwYoSN146UtzMC5xLLa7VH6iXdXVIttvr6RkQ2n6Ht0dE9t
gj82BQxcq0MyE5+prhkXS/kBuz3D6M5Q0SXcD9zfuI6CCDwEpVeI6qxwbrGetpoi
h6o80R0r4ymiAE4ot4Gdy9Nxf/O6SoLDN6PGM1+ZBeyby80oaqFK/BtWbpyasmf2
uJ0EHwgRMnxoFIZ+yXKkuc6mbS5gLYJ7MBU0cxB9J116Jhf5IU2+jm4uZohtWuZM
LreTDT/6fQT9HnQytzGxo7E80yKUP6OSuWi39kuTKeAUqsF/WhqEcXh5mdXVPicp
6fSup7ww9iT6Y0do95vkF54s5O/fEd4EiR8mKwcrM+B23aXInTX76/w2cNiEQQA3
ansoSTzljRaoV4+pgx/Pk5yxBbBpDjuzkIzv++U5VqFNRXaj4bUL5YqoGDVvFtDK
Jt9Lrv/W/HgRf25cU54bVUL3PW+nra9TWAOONmJWD/+gWjejZUo=
=iCzI
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
