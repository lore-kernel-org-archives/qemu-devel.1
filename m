Received: from eggs.gnu.org ([2001:4830:134:3::10]:50096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnn-0000MK-PX
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnm-0001Ur-Qq
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:44:51 -0500
Date: Tue, 31 Jan 2017 11:20:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131112049.GF18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-6-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-6-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 05/21] hbitmap: improve dirty iter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:48PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Make dirty iter resistant to resetting bits in corresponding HBitmap.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qemu/hbitmap.h | 24 ++----------------------
>  util/hbitmap.c         | 23 ++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 23 deletions(-)

Please add a test case to tests/test-hbitmap.c.

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkHMRAAoJEJykq7OBq3PIX+gIALmh+qW1Gwin68PmiD2fgWZe
NJJ0GPW5mVf8xpXq08gvKLsdNpovIgJsOogdVeXkZcY+q3m8vkat6Gnsy8QxNf0R
L9xa4FxqAk9D+tLLoFEPRMNM5TsqcveaDqyXKNe6u4C+uKF19ItInUxYz4yoD9OJ
f7CYh6XqhrdYlL/+d+FmdL3NG5L4P8KTlKsAbzZkLwy+ApmqBDhnTyV4a8+SNHIQ
hPrd3Sh3PmRdgFdMvNkgwmlpZ5isNw3FJObNHkin+a4m4GfaFgwvr8CtB7R8nF3O
kOubVJpDS0S3ED1p1Da8l0/ea21AkRbFTRJjqu0IiFSCE1ie7lS0qq9qoky2OsY=
=xlfe
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--
