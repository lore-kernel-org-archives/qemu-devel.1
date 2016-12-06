Received: from eggs.gnu.org ([2001:4830:134:3::10]:40779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEJfY-00076f-Ti
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEJfY-0002Ng-2B
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:36:44 -0500
Date: Tue, 6 Dec 2016 17:35:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206173534.GC30363@stefanha-x1.localdomain>
References: <1481037418-10239-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <1481037418-10239-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PULL] Block layer patches for 2.8.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 04:16:57PM +0100, Kevin Wolf wrote:
> The following changes since commit bc66cedb4141fb7588f2462c74310d8fb5dd4c=
f1:
>=20
>   Merge remote-tracking branch 'yongbok/tags/mips-20161204' into staging =
(2016-12-05 10:56:45 +0000)
>=20
> are available in the git repository at:
>=20
>=20
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>=20
> for you to fetch changes up to a3e1505daec31ef56f0489f8c8fff1b8e4ca92bd:
>=20
>   qcow2: Don't strand clusters near 2G intervals during commit (2016-12-0=
6 15:37:02 +0100)
>=20
> ----------------------------------------------------------------
> Block layer patches for 2.8.0-rc3
>=20
> ----------------------------------------------------------------
> Eric Blake (1):
>       qcow2: Don't strand clusters near 2G intervals during commit
>=20
>  block/qcow2.c              |   3 +-
>  tests/qemu-iotests/097     |  41 +++++---
>  tests/qemu-iotests/097.out | 249 +++++++++++++++++++++++++++++++++------=
------
>  3 files changed, 210 insertions(+), 83 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRvbmAAoJEJykq7OBq3PIGvgH/3xjGx98lSBao5EuW31WE8Hf
So1blgP332S5BIhNwvAVRPiAwcC3Kd0G25eQJJUVJFRHdCwcVFAflq46c+CMv5c+
geQKk3SmbyoxPeZq2oplA/cbtQRCkyCZ8OU1N+7EEnEGeHe++CPKLLzVP6aCtCeJ
hzdPGqzlO7aQjeLrDgnnraahynn5wEjR2bLdid2UrY/7h2faHT7yHc3Tc9dpmlTo
mk0DHeXuQY3bWqwJ2RV7Te2uPDKROSAXUXxT93L7GhcBFxP5ggj87ALF3241vxb4
E0DPAbHGqIo0Cwp5P3BlV2N17+BulGF15zj//2jy447MxvLJwVH2q7kNbHFJbyc=
=5/+O
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
