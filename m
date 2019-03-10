Received: from eggs.gnu.org ([209.51.188.92]:45933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2qEE-0002vH-Uq
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 23:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2qEE-0000kq-3N
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 23:38:26 -0500
Date: Sun, 10 Mar 2019 14:37:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190310033710.GC15851@umbus.fritz.box>
References: <20190309214255.9952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <20190309214255.9952-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] target/ppc: Optimize VSX instructions
 using deposit_i64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 09, 2019 at 10:42:53PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi David, Richard.
>=20
> I found these two patches while cleaning dangling branches on my
> previous laptop... Original commits date is 2017-07-21 05:24:05...
> I simply rebased them.
>=20
> It doesn't have to be merged for soft freeze, but since I'm doing
> housekeeping I rather send it to keep archived by the ML.

Applied, thanks.

>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (2):
>   target/ppc: Optimize xviexpdp() using deposit_i64()
>   target/ppc: Optimize x[sv]xsigdp using deposit_i64()
>=20
>  target/ppc/translate/vsx-impl.inc.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyEhmUACgkQbDjKyiDZ
s5LqcRAAvl5kif5HetIHMk0z+h2ssUSxynVRcCr2lEKeoNJDcPZMDFb1Vc520DkR
gC5K44z+cKpnTH2FTXqMoTNrH4HjB74+zS0jeJS135WhgjIx2xvcoCDDj6doHkph
qkid5I0qGnBcX/B0see7vHOEBO0VL5DtL1VNbICm4wKLFdF3dHZdOLj0YVXtT3zM
4viFSoxmEWejgOBySsFyJneahlhvFp0ccIilZeNwJyMSoffXXrzTWJn9M9Y7YIDO
m9SqmKglyxwkPBkHMM7GNod8A8LayEekT50B5AfahLUI0NYDEWVU94meB9QbqEBR
MQzBl4mobwFIdlieU1P7sbok6Z19P0u9iXnm+5VamLsG+OV86P09ju1rWJiMEBbd
2B0wLAY0V4QK/yIRukaYHfOp2XzqkktwMwv79uST7RujCjzMxZxBbEzCAM6wqzBc
KgRqqZJZOZ8+WdAzXKRF4S/wFXCehMzc903v0ap9fUBD4n3O38ILFRciBiKIMsge
EFg5kGWiG5Yr2ulHnmaSTWRZ5q2v8YS//BqWvOj/SSU6fdUVsR3BdUqPECeO41Z3
w11QISi1EWlNyIe0lbs2r7Ceg4Ds6cS8RnRSCg+ggMxIabf/Ns8YEfDvyUQuJnCw
WmgV+TArvQnG3yxBKWuul17dnQkBPkkBCBI0O7i5WVFSjnVkPAE=
=PP8J
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
