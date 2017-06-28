Received: from eggs.gnu.org ([2001:4830:134:3::10]:49584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQCWt-0001ur-NF
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQCWr-0005WR-IA
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:57:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dQCWr-0005W4-Bl
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:57:09 -0400
Date: Wed, 28 Jun 2017 14:57:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628125704.GF5378@noname.redhat.com>
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-4-stefanha@redhat.com>
	<b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 27.06.2017 um 13:40 hat Eric Blake geschrieben:
> On 06/15/2017 11:38 AM, Stefan Hajnoczi wrote:
> > Avoid duplicating the QEMU command-line.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/qemu-iotests/068 | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >=20
>=20
> > +# Give qemu some time to boot before saving the VM state
> > +bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu
>=20
> Are we sure that 'bash' on PATH is the same as the /bin/bash running the
> script?

Do we even need to explicitly call bash here? Doesn't this do the same
as far as this test case is concerned?

    ( sleep 1; echo "..." ) | _qemu

Kevin

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZU6egAAoJEH8JsnLIjy/WdOkQAIfPsjSKMtsg/tBjQKm/H0bL
txOOs3DJiXHbJ2JRUA3ZfB8vodM7FklivaPaLVlTzkynZ02dDeuVHoncTiBDJ0Bn
s+OORvTeIkLww5MZCZFWsET/NAC0vUcW60V+LbAXCkMLScYAkrfwQYFQP0/z2vxN
cnEsxSFEQFET7n0Zhzn3ZbFrTUSk/z4NT20LPipgh9PW7kYqNwSNRPKLs6XUbtUX
NPR4Unm5j1CstXZvN+eIaG1i8cnEnfRBtbmCxThO6ZWdADGupRkU8Zsm60IiTgvw
KoNRJdohIychyPi1daPz8AmWPiGQfycRrrByfTPtjy9rFOA1/3n95213FwAnmUlF
Ev76xRwD54k640imdBm7awy3z/U+GN4Tqr/sc9+jQcyjF2ZTH6bZMEnCvtI+HYWD
pVfXP8cnFKo0AUhEhIqsaqWavSdYvU8TgOsQnlqXek1ZfH490ajWWOtaOYXuCW3P
iNjX2fXfLotcQFM5um5XdYCdj9oDZOd9AkAFti42/oF8Rxch7kycmHEzDRNI8PCo
wKrAf3ZwA4pEK65hPb9Mn8VLexqtrX/gA83U1GFZBxa9M/+dAD+Pd/AYgUiDtcno
SHFPSYBgbSV2W8u1tJBxICXnQ9FIw8b58lTKCFZBKzc2x2fsX70GiwiSrHdgnfH0
Tcv4HQqpa0A4/U8m7QWw
=vJWI
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
