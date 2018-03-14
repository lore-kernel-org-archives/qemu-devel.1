Received: from eggs.gnu.org ([2001:4830:134:3::10]:60840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1evuxq-00071F-ES
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1evuxp-0001na-92
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:12:22 -0400
Date: Wed, 14 Mar 2018 12:11:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180314011103.GD4182@umbus.fritz.box>
References: <20180313113114.DBFF174569F@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <20180313113114.DBFF174569F@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3] ppc440_pcix: Change some error_report
 to qemu_log_mask(LOG_UNIMP, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 12:26:56PM +0100, BALATON Zoltan wrote:
1;5002;0c> Using log unimp is more appropriate for these messages and this =
also
> silences them by default so they won't clobber make check output when
> tests are added for this board.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
> v3: Include qemu/log.h to avoid undeclared function warning
> v2: Use defined format string for printing hwaddr instead of casting.
> I guess this does not invalidate the R-b tag of v1 so I've added that too.
>=20
>  hw/ppc/ppc440_pcix.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index ab2626a..b1307e6 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -21,6 +21,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "hw/ppc/ppc.h"
>  #include "hw/ppc/ppc4xx.h"
> @@ -286,8 +287,9 @@ static void ppc440_pcix_reg_write4(void *opaque, hwad=
dr addr,
>          break;
> =20
>      default:
> -        error_report("%s: unhandled PCI internal register 0x%lx", __func=
__,
> -                     (unsigned long)addr);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: unhandled PCI internal register 0x%"HWADDR_PR=
Ix"\n",
> +                      __func__, addr);
>          break;
>      }
>  }
> @@ -377,8 +379,9 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, h=
waddr addr,
>          break;
> =20
>      default:
> -        error_report("%s: invalid PCI internal register 0x%lx", __func__,
> -                     (unsigned long)addr);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: invalid PCI internal register 0x%" HWADDR_PRI=
x "\n",
> +                      __func__, addr);
>          val =3D 0;
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqodqQACgkQbDjKyiDZ
s5Je/g/7BIBf02ik1b9wqlpQrdaU1p6ILYw+LrFbRlbo2rhWZ5TpQQ0sQQI2hfkk
Rr+tMak/hzvqLVxFKfH+5uXPNxxvvaWL97Sf50vvomdrg9zuBM0e8rTw5awbbPZA
nZ9foDd0wdKm6pyBEl/Lx2aCmL1owCKXllztrLeqfeCLcyGcs022YxOICER+CRLj
KO/IKB5hGod6xWrKsi4hrpoWF5Z9R9k0V0XY69ljgwCiPNtECPOZWdnNyCk/3gRn
o1ND60fdI9cRtlAGOU7O1HRDBvPtlPy2xZsohzfme29FjDy3xE4AoO9WBOAcK38b
yAyy9e/d6+tKZc1XjPSQIjkhHShi5b6M7xFEv/HFVouQN9j8yN12rMXnCpBKZxAh
Jt4ZQ6rM/axqN0fB4NNC+YqEroDh8+JwVP+Tdh7jJUgbrt22GAEbQdvLV9Z/kIYv
Fz5QZJMIM60SumvteKypWCrWPnUzlcVFCOKOBomgJQF0pe0rjrb1CooMbJ1PPlvF
j1+eAyl93qf2h7pOXQRuLOTyS9LElT/NkvaViaIuNLv18VNmQP1PGieUXc4nlvbJ
tJVroti+1rzE4hJWDN9HjGrR2Iw60cYCc2bP9rw79MiHt8om2jC3ODVA10amDAts
o5Ny6MKvNDBWS46LShefnkQwjXmjwFOu6J6RLRy8eImzJqIqu7k=
=bn7P
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
