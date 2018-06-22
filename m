Received: from eggs.gnu.org ([2001:4830:134:3::10]:35306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWAIk-000065-9i
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWAIj-0003aj-BO
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:51:46 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:32813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fWAIi-0003Xt-R4
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:51:45 -0400
Date: Fri, 22 Jun 2018 10:51:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180622005134.GC612@umbus.fritz.box>
References: <cover.1529568501.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <cover.1529568501.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 0/5] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 10:08:21AM +0200, BALATON Zoltan wrote:
> These are fixes to sm501 emulation that were found while testing with
> AmigaOS 4.1FE (AmigaOS 4 is known to work on real hardware but we have
> no way to verify it against hardware). While this is mainly to improve
> sam460ex emulation this is now a separate series with the sm501
> specific patches because that's also used on SH emulation. I hope
> someone can review and merge this.

I'm not really familiar with the sm501 hardware, so I can't speak to
these technically, beyond the fact that there's nothing obviously
bogus.

I can say that BALATON Zoltan is the only person who's made
non-trivial changes to sm501 lately, and there don't seem to have been
any screams, so I'm pretty happy to assume he knows what he's doing.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlssSBUACgkQbDjKyiDZ
s5LCWRAAgGaFk7eqoFszn4h6zm+HPb1LN8M5peQbPhYZx6alAK5q6adnSophPpyL
nHVpVkI5mik6aNEJkgDrcFtUvu35cfGHMYnueVV4M4iGDlVeqFgkUkhUeV5ZGHuS
n+fKzlHEbB08mUtTclOwhQYFw/w9tlGWW7CYCjb0TdBdLbtWFffYRVtE4Vd3dZtc
uKDFKC/ljoxeG4z/pGl/fxwG98NomhaewKUfuaTT+f1V1T2ifEsIsd+voKSQaUIT
4tCQ+esB0nBM0x1RfGOChaiVmyYi3qhfNpVzjs22d9x63PthmgNNBnG689Gy6c0T
YVgl3PYIzvdeprGJPd8UFIZVGu1IIisBKzuOUK4xn0xINXU8TAd0wzaI0xTc3s5O
WDQyJ8ytx8Cp+ZBptoJKtX8Gi3giHSfnD0/Zwsb2LjDbNpAmM9AbnAqC85t8w+8m
E8nLgsk2sRaddDNTBz++zbSWX/JghRLxpcsjcvUcdwHdzUdmQlUjwCVyf4F40c27
ZG7PQ7jUMe70M2I3+b1hn6UtYYNMpgEwPO1e+TKX51nERAkW+5q/DtvlkhWDrOfu
m72ZzKhkPoAoHu4CvWIahJbEVsg9CrjNJwXm+mUXLuQA+NKADY7TNHoewz+sUerB
PyraCRCSE4DjM1T6KRvdV0B4imril4oCUiRoqtwsDDToYvlQ2ZY=
=KTi5
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
