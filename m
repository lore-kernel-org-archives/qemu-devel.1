Received: from eggs.gnu.org ([2001:4830:134:3::10]:54352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5AYC-0001vf-Dy
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 09:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5AYB-0002ty-Cf
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 09:40:08 -0400
Date: Sun, 8 Apr 2018 23:34:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180408133415.GC20816@umbus.fritz.box>
References: <20180408104108.158997456D8@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20180408104108.158997456D8@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12] roms/u-boot-sam460ex: Change
 to qemu git mirror and update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 12:31:24PM +0200, BALATON Zoltan wrote:
> Now that we have a mirror of this repo on git.qemu.org change the
> submodule to use that and update it to latest commit which fixes a
> dangling symlink and removes two big binaries that are not needed.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> David, you can drop previous version of this patch and replace it with
> this one which updates to the latest commit. Thank you.

Done.

>=20
> .gitmodules          | 2 +-
>  roms/u-boot-sam460ex | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.gitmodules b/.gitmodules
> index c613722..49e9c2e 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -45,4 +45,4 @@
>  	url =3D git://github.com/hdeller/seabios-hppa.git
>  [submodule "roms/u-boot-sam460ex"]
>  	path =3D roms/u-boot-sam460ex
> -	url =3D git://github.com/zbalaton/u-boot-sam460ex
> +	url =3D git://git.qemu.org/u-boot-sam460ex.git
> diff --git a/roms/u-boot-sam460ex b/roms/u-boot-sam460ex
> index 119aa27..8ee007c 160000
> --- a/roms/u-boot-sam460ex
> +++ b/roms/u-boot-sam460ex
> @@ -1 +1 @@
> -Subproject commit 119aa277f74a4a2d3f7ab6c9471292308eba14e4
> +Subproject commit 8ee007c4216fd6a0d760589e8405ce4494497aa0

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrKGlQACgkQbDjKyiDZ
s5J9mQ//YlP25NzuiNOVME3oYrHKSWtTrjkIbus9DSXvTVDKt4Yv83UieSQ2HSPo
GCSIHkpuBBeMnFpQugEqcmcb83kGZ2NTbUg2lxT75+pWFQzco1qNmMzmijxsXric
TQXox6/BRP4vWFe4vmOMJ9ksO+brhFf9CEj3R2pC2jsOhT3E2ClrULNh8mTac/L0
k1cUMbF9aMMyKomjzztezpN2K9Ps9uWS3Px6Y3TPHULisAji3qEQhna+3XM8FYap
NBdy8Z5gKn0dzQDYQlq5V8r5+0DBW6AXOL+lJxqsB8P/mfU96qdgTV2NLEf50ZuK
2yYKDvKXAi3HOS80bljsH3COB1xPe2JxrzwVId5+/uq6yuypNUpuqaq0KmGGWTX9
JVIQ66erWEQVjFSUiN/MXQ9xgvwMrfFiAYtNkymmJ49W4OdqVngiGgtFItnh830V
newXAkMuxymYPBV5hP8JsgMUtEzh8PB/MAfQz+GbSRZPFbIWowdVohlKx5crDdJP
WhiqxZUoECs1vYGp+F/4UNK9MoRLvXaL0YshWxArX6pH1Zo3JhVEeIp3gtCwY991
IbycLNPgySWDJi5ekfPnc+gDGMNYPjHyZxt9SP2tzDpLwSHHhcVzVqPoH5xTeQxX
t3l3YFSj10XEnTyiBbpfsEMdTeFQkyhUBooQCq/BOy7RYH+MPHQ=
=uO9v
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
