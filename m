Received: from eggs.gnu.org ([2001:4830:134:3::10]:50347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eu5u9-0003SU-Dk
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 19:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eu5u8-0006WM-Aq
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 19:29:01 -0500
Date: Fri, 9 Mar 2018 10:44:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180308234446.GQ3083@umbus.fritz.box>
References: <20180308111305.C9F56745707@zero.eik.bme.hu>
	<20180308144845.0D7647456CD@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v+Mbu5iuT/5Blw/K"
Content-Disposition: inline
In-Reply-To: <20180308144845.0D7647456CD@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2] ppc440_pcix: Change some error_report
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


--v+Mbu5iuT/5Blw/K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 12:08:08PM +0100, BALATON Zoltan wrote:
> Using log unimp is more appropriate for these messages and this also
> silences them by default so they won't clobber make check output when
> tests are added for this board.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
> v2: Use defined format string for printing hwaddr instead of casting.
> I guess this does not invalidate the R-b tag of v1 so I've added that too.
>=20
>  hw/ppc/ppc440_pcix.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index ab2626a..1dc5d7f 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -286,8 +286,9 @@ static void ppc440_pcix_reg_write4(void *opaque, hwad=
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
> @@ -377,8 +378,9 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, h=
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

--v+Mbu5iuT/5Blw/K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqhyuwACgkQbDjKyiDZ
s5IochAAuQmaIz08e4IJJ689FI2mIG5q8w6mnXFJDhe++bMgCuUCqe6VgQgfaTj3
DxOPc6u06F/JIyPlsYyV8rDfGqSYWl4USWZfm3+cImVM5KBO+rYce3XLnRJfsDHd
j6Tv92Imrs/IEgrUJ1uUrJQ/aU/qre8lH1tnMqSWHiGuy0i9Kw5oz1hLX2BCazR/
5cO/ebBV2/QFdP1hT0QEeHw++ZVgiF43Vki5TotyTUjtJ3C2fospfNXGTxhvPAVa
mOiouOXq8aL3bN9FD9R7L5Tgld5HXKG5gAuvtI/z81XKBRPCtxJ3HEtg3bbJl6YM
62CHPMKVFsbBazOzttsd4HTKadyTPFlEJ+QAxFtV3edJ+YcZTnmKqDoytZ1insMG
+6s6AU5BDVmNTETGQUZj4V8leYlsaDxPA8ne59915s69NA9o7lYCRkLIKCQsR18/
DlGIZEZU6sv4J6ghBoEBRobp1O2CjIkFdLuw52uzhNwaT17B+SsdzmC2EjqCKEuU
uhRiWKcr6e3/+ySBtSmHbms0EMNTsxNZl9eNUEuwRR+GVVMDiQj/rSbvcAuYWWDM
TjNfUz0N8y33kAlDZrFoU3Pu1rnqOly/iJO1LU0yABeh+Wnshqp7B1MPX1yEhaJ5
iiVtEqRI1uGejbk96kNldzyXyrYhc7L4SBYewg610X2XnAHMZ8o=
=Te97
-----END PGP SIGNATURE-----

--v+Mbu5iuT/5Blw/K--
