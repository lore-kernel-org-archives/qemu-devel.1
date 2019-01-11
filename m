Received: from eggs.gnu.org ([209.51.188.92]:58453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpb-0005aG-Id
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpZ-0003SA-4o
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:50 -0500
Date: Fri, 11 Jan 2019 11:16:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190111001609.GJ6682@umbus.fritz.box>
References: <154713023826.379171.4010754027183178230.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bgQAstJ9X1Eg13Dy"
Content-Disposition: inline
In-Reply-To: <154713023826.379171.4010754027183178230.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] target/ppc/kvm: Drop useless include
 directive
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


--bgQAstJ9X1Eg13Dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 03:23:58PM +0100, Greg Kurz wrote:
> It has been there since the enablement of PR KVM for PAPR, ie, commit
> f61b4bedaf35 in 2011. Not sure why at that time, but it is definitely
> not needed with the current code.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.0, thanks.

> ---
>  target/ppc/kvm.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index ebbb48c42f25..d01852fe3112 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -36,7 +36,6 @@
> =20
>  #include "hw/sysbus.h"
>  #include "hw/ppc/spapr.h"
> -#include "hw/ppc/spapr_vio.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/ppc.h"
>  #include "sysemu/watchdog.h"
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bgQAstJ9X1Eg13Dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw34EcACgkQbDjKyiDZ
s5LNfhAA0oCD7hZTtCDm5flzClNgqbYlmZ9Apu0Rqmy1c+UcIfE0D/OgrQ1T/wJE
wdirgLTQ1Uqs1mC6JZoKm/Jn3PDDOAqVbpzReEokpGzbDH53zx5y6DsaZnX+12Qx
WrxGClEK38YJC9juFi0DMs/VUH7sgqLCf0JQcT+Qm6N/fnLOEi0cF9b1Yp+aWbH4
YBlwcxFTJtRt8OQZiYI+V1XP8UFJ6ORH/qRM/LJ7wCavC5oIGaex6uOigtQrcZ3i
XhtSIsGBZ9P5Y6Cthss4Sdto9k1P0GZ/LLmB9Sag5TwxybyBqn2maL2H1fEkLKze
2wy652LvPAQSGL9kRQBbBDZCscxjcmGMx9oybIr4SjFWqXJOIwM3KRPWaA5KKSZW
LrAlO5vVPBvfkIfeGi4O7F+2KROX0hjNERjVR/r3j6DOKN1iSHRw3cnl1zvPfpKD
maOYYo0V4F3flhZpcWRXTm8efXGRdnS9xhiV72bri6BSKIO22Xztx5RaN475B0wc
LKXv9I1U2OZfshEsAPO6mQV49CKPDhFIboXehy6oMKbtX6PSr7Xih3yedHTszOIY
dOnuyg9cl0p8ZVhLIi+qQHRMpl3g+/Axj0fGU2uosxNYwfDS6b45lyZxI2dvt5BE
IPqeh4szYiPcq4U52LtDwD0FZkLk3v4pc9NVg8jba1TCi2tABq0=
=FYa3
-----END PGP SIGNATURE-----

--bgQAstJ9X1Eg13Dy--
