Received: from eggs.gnu.org ([209.51.188.92]:44761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1goyhZ-00022f-Mj
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1goyhX-0001IO-Ug
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:51:25 -0500
Date: Thu, 31 Jan 2019 09:40:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190130224020.GD1771@umbus.fritz.box>
References: <1548865345-2638-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <1548865345-2638-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Merge the two e500 sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 05:22:25PM +0100, Thomas Huth wrote:
> There is currently a "e500" machine section and a "ppce500" device
> section in the maintainers file - with some oddities: The wildcard
> in the device section also covers the files from the machine section.
> And hw/pci-host/ppce500.c is in the device section, while its header
> is in the machine section.
> This is really quite confusing, and I don't see a reason why we really
> need two sections here, so let's simply merge them.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-4.0, thanks.

> ---
>  MAINTAINERS | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eac36b6..30dbe37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -957,9 +957,10 @@ e500
>  M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
> -F: hw/ppc/e500.[hc]
> -F: hw/ppc/e500plat.c
> +F: hw/ppc/e500*
>  F: hw/gpio/mpc8xxx.c
> +F: hw/net/fsl_etsec/
> +F: hw/pci-host/ppce500.c
>  F: include/hw/ppc/ppc_e500.h
>  F: include/hw/pci-host/ppce500.h
>  F: pc-bios/u-boot.e500
> @@ -1316,14 +1317,6 @@ F: hw/i2c/ppc4xx_i2c.c
>  F: include/hw/ppc/ppc4xx.h
>  F: include/hw/i2c/ppc4xx_i2c.h
> =20
> -ppce500
> -M: David Gibson <david@gibson.dropbear.id.au>
> -L: qemu-ppc@nongnu.org
> -S: Odd Fixes
> -F: hw/ppc/e500*
> -F: hw/pci-host/ppce500.c
> -F: hw/net/fsl_etsec/
> -
>  Character devices
>  M: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>  R: Paolo Bonzini <pbonzini@redhat.com>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxSJ9QACgkQbDjKyiDZ
s5L3QQ//UvvHHp/zqda6WF33izlPzU5YpKIBcxEMgVPV4sFGK7+grVc+Ra44J16+
mbvasMTHz4xuawS9EM5vuFNUnuEBpctKo7Foz7EpUqJZud21bqYlPGTE+t+IJz3T
cj/OC7N10tgJ/84K829HgrKiIbX9XOuxZm9+pPEqcZq3tQiiqLmdlmfIm5jawO9W
brlv/Ed0uXfumqG2s1KXyj+zPvDH7C1YM0hkKCUzYr7u+SJw/WCb9PC6SzBkEWTa
mMimFSpvYZe/kDmfvvBYoerXsXossavC4/Cuw/vs0kXC6dNor4g2GYC7X0bx6bEE
ymGSspgFzjgM3+OrtzejQ587r1bXMC/X5OWsC2dqnx1sP2WYgKvWsJJ/Ho2Cyn3Y
UDjEJMXKsmyVOZuXr/qdMd+GybPft1CFDDp/qq/BOYV08vLZqPXTOG3BnXfE7t1l
q6QHNR17zP2rwK4V2I0Y6O9tHXDQrQH3cLxnPICyx8YrIPdrZFpAvkE22ReFdsyZ
9/X8QrwCE5vPcGVLCDCfjNM4lu4Jyr9V7oKXcgmXxPW3wpNLHo42TJ0izjqFnyFz
tgOBUaViZ7+l92Ffhv+v0BaLCGL07ycDBhMmfgE8i+BSOTmLv/QFqzeVzd2MINe3
7UT+usOShymyAZBgOFdXtA2vC6x6cuRXnt13v1imEgrlEvjbjwI=
=XzrW
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
