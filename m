Received: from eggs.gnu.org ([2001:4830:134:3::10]:43875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epDkk-0001dr-DL
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epDkj-0006V7-BY
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:51:10 -0500
References: <20180205162745.23650-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3ed4d8fa-8461-084a-acff-30dc631911a9@redhat.com>
Date: Fri, 23 Feb 2018 14:50:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180205162745.23650-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5jgl3HMceQQrDooFGUB7zocyqVELALDem"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Make resize error message more
 general
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5jgl3HMceQQrDooFGUB7zocyqVELALDem
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3ed4d8fa-8461-084a-acff-30dc631911a9@redhat.com>
Subject: Re: [PATCH] qemu-img: Make resize error message more general
References: <20180205162745.23650-1-mreitz@redhat.com>
In-Reply-To: <20180205162745.23650-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-05 17:27, Max Reitz wrote:
> The issue:
>=20
>   $ qemu-img resize -f qcow2 foo.qcow2
>   qemu-img: Expecting one image file name
>   Try 'qemu-img --help' for more information
>=20
> So we gave an image file name, but we omitted the length.  qemu-img
> thinks the last argument is always the size and removes it immediately
> from argv (by decrementing argc), and tries to verify that it is a vali=
d
> size only at a later point.
>=20
> So we do not actually know whether that last argument we called "size"
> is indeed a size or whether the user instead forgot to specify that siz=
e
> but did give a file name.
>=20
> Therefore, the error message should be more general.
>=20
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1523458
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to my block branch.

Max


--5jgl3HMceQQrDooFGUB7zocyqVELALDem
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqQHD0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0LcH/iC3F5Pa1HkKpkQqicfHOiJneZH52sdU
lfHw/hZyBWKGXlUBlhNItabLzlIt5NyqiHKEaHCgwU/byxe6a1z6uRlrDOx/+PVm
dxK9rvGIkgRwVC6IxOYaBOq5qMERx3eZRFUyfeqMx6cjVkXN27HyTzGk8aOSSS86
Nd5B6/Zs9GasG58F/KyCSl4kAfHRd++lyen1W37NOdY/0S00Nj3iMYrf/GFOUGRc
Y0k72GKtgh4LTbnve2hoLKaciGS6YpszYcZdxY/RO1JF/uoK70VCUTSfys9ir8GM
oj346+nV8hD8B4PAh1LnHstanuexyg8o7cefEzgRUaoykY2t5lrpCkw=
=CBMZ
-----END PGP SIGNATURE-----

--5jgl3HMceQQrDooFGUB7zocyqVELALDem--
