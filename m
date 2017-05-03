Received: from eggs.gnu.org ([2001:4830:134:3::10]:53244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d5uPO-0003Qr-8N
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d5uPN-0005Nf-1R
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:33:34 -0400
Date: Wed, 3 May 2017 14:33:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170503133324.GD14647@stefanha-x1.localdomain>
References: <1492614962-20946-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <1492614962-20946-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] migration: Call
 blk_resume_after_migration() for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, lvivier@redhat.com


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:15:59PM +0200, Kevin Wolf wrote:
> This fixes one of the bugs that made us disable the op blocker
> assertions for the 2.9 release.
>=20
> v2:
> - Filter HMP output not only for common.qemu users, but for all test
>   cases that had an escape character in their reference output. This
>   required matching also lines that don't begin with the (qemu) prompt
>   because other messages (from stderr) are interleaved. [Eric]
> - Use bash $'\e' instead of sed \o for better portability [Eric]
> - Added driver=3D$IMGFMT to test 181 [Eric]
>=20
> Kevin Wolf (3):
>   migration: Call blk_resume_after_migration() for postcopy
>   qemu-iotests: Filter HMP readline escape characters
>   qemu-iotests: Test postcopy migration
>=20
>  migration/savevm.c               |   8 +++
>  tests/qemu-iotests/028.out       |   2 +-
>  tests/qemu-iotests/051           |   3 +-
>  tests/qemu-iotests/051.out       | 106 +++++++++++++++----------------
>  tests/qemu-iotests/051.pc.out    | 132 +++++++++++++++++++--------------=
------
>  tests/qemu-iotests/068           |   4 +-
>  tests/qemu-iotests/068.out       |   6 +-
>  tests/qemu-iotests/130.out       |   4 +-
>  tests/qemu-iotests/142           |   2 +-
>  tests/qemu-iotests/142.out       |  10 +--
>  tests/qemu-iotests/145           |   3 +-
>  tests/qemu-iotests/145.out       |   2 +-
>  tests/qemu-iotests/181           | 119 +++++++++++++++++++++++++++++++++=
++
>  tests/qemu-iotests/181.out       |  38 +++++++++++
>  tests/qemu-iotests/common.filter |   7 +++
>  tests/qemu-iotests/common.qemu   |   4 +-
>  tests/qemu-iotests/group         |   1 +
>  17 files changed, 313 insertions(+), 138 deletions(-)
>  create mode 100755 tests/qemu-iotests/181
>  create mode 100644 tests/qemu-iotests/181.out
>=20
> --=20
> 1.8.3.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCdwkAAoJEJykq7OBq3PIf2gIAMBjnTjHwtPSy//jFS6CPBqo
Gf1JoKYfvDezFbee7k9u/tJ+qPQONLVzeQXxjX1nzD8DzvjtjBtVaIvCYhVTU2/u
2mk5kVGwSDXQAB9WpUQgyRzWVHO7I+rhshnM24dsddups9V1T7GXAo+M51Mn+Xz6
F0PRzyB4cyy3Zez7XutN1HoLnt0IjTGrvsTXUA0aRPWYN4RacVRwd9J06VKdC0eo
kU9apg7sVmtTk3mzVvFvclr1qkIMWYEE0LtSEMitTRErhVG9mm+V8R8hB8oFg1aG
oM7gJErZFdeB/7gsJq35IDH0KJYwAPGXJScS2AzGBKhAVnm3L4IQuD12QCfxDbI=
=RKQj
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
