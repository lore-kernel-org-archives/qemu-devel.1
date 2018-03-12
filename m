Received: from eggs.gnu.org ([2001:4830:134:3::10]:41824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQXU-0000dV-7s
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQXT-0007Mx-HD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:43:08 -0400
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-3-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <88cae9b6-cf44-c52c-3dcd-52fe3c2e2fe0@redhat.com>
Date: Mon, 12 Mar 2018 17:42:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180309214611.19122-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aRHbZzfR85U8GyWHFpVmJoPPcWoYf9Izw"
Subject: Re: [Qemu-devel] [PATCH 2/7] qemu-iotests: Enable write tests for
 parallels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aRHbZzfR85U8GyWHFpVmJoPPcWoYf9Izw
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <88cae9b6-cf44-c52c-3dcd-52fe3c2e2fe0@redhat.com>
Subject: Re: [PATCH 2/7] qemu-iotests: Enable write tests for parallels
References: <20180309214611.19122-1-kwolf@redhat.com>
 <20180309214611.19122-3-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 22:46, Kevin Wolf wrote:
> Originally we added parallels as a read-only format to qemu-iotests
> where we did just some tests with a binary image. Since then, write and=

> image creation support has been added to the driver, so we can now
> enable it in _supported_fmt generic.
>=20
> The driver doesn't support migration yet, though, so we need to add it
> to the list of exceptions in 181.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/181   | 2 +-
>  tests/qemu-iotests/check | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--aRHbZzfR85U8GyWHFpVmJoPPcWoYf9Izw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmrhMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9APk4IALDXHMXmOqJnV1sz6XcjdP+eE+pnlYel
/9fIyYZJDthCo3Zddu1ZPmHoSgC50100+Mb3hXY35X+Cvi/ODupK6MTgffvdVZn5
vWq9c+eD54wIaZLOP3yk5KBVESATtSL9a4+7yT0/haJULYwotMWfuePiyKxdoUJO
v1fCOg4sfnwPRMkthp63tbr4/wkMXg8OIkVq0rMU24l/rzCgx+1rqtrFYy4YHQw/
sATk+05p187KWoDiQ16JEwlhSlGfwCVpJh51bN4duskm9CPKfXoElf5dLDkpbll6
JcAD0tYAUIihSt3N06CcZCCBTEaZcttGQ33nR8i1OSIZ998YJmjLLz8=
=fWhw
-----END PGP SIGNATURE-----

--aRHbZzfR85U8GyWHFpVmJoPPcWoYf9Izw--
