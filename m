Received: from eggs.gnu.org ([2001:4830:134:3::10]:43443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1g3C-0001jU-7y
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1g3B-0000eA-Cw
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:57:26 -0400
References: <20171009215533.12530-1-mreitz@redhat.com>
	<20171009215533.12530-2-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <93d2aa5d-ca7e-d838-d042-18a31d378db4@redhat.com>
Date: Mon, 9 Oct 2017 23:57:14 +0200
MIME-Version: 1.0
In-Reply-To: <20171009215533.12530-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4unJIM8rnqcEG0CVWNoAaJ20ATRAUguBs"
Subject: Re: [Qemu-devel] [PATCH 1/3] qcow2: Fix unaligned preallocated
 truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4unJIM8rnqcEG0CVWNoAaJ20ATRAUguBs
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <93d2aa5d-ca7e-d838-d042-18a31d378db4@redhat.com>
Subject: Re: [PATCH 1/3] qcow2: Fix unaligned preallocated truncation
References: <20171009215533.12530-1-mreitz@redhat.com>
 <20171009215533.12530-2-mreitz@redhat.com>
In-Reply-To: <20171009215533.12530-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-09 23:55, Max Reitz wrote:
> A qcow2 image file's length is not required to have a length that is a
> multiple of the cluster size.  However, qcow2_refcount_area() expects a=
n
> aligned value for its @start_offset parameter, so we need to round
> @old_file_size up to the next cluster boundary.
>=20
> Reported-by: pingl <pingl@redhat.com>
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1414049
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 1 +
>  1 file changed, 1 insertion(+)

Oops, forgot:

Cc: qemu-stable@nongnu.org

(2.10.1 is out by now, but you never know.)


--4unJIM8rnqcEG0CVWNoAaJ20ATRAUguBs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnb8LoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANj0H/2ZSSzW4s/xjG3SV0LDGAJgKKcdPY7Gb
HrrVNKmulvaYiUJfObU8p0oXsu4tj4JZk1NAJDhGE+rqnha+y/C8KLugy1T1y6Ry
8lgKQ1bxn4qFwXtXqbUSW0W4TkCm+2PVGHqqOq9tKT17F2y3dHkAKcpvwG2xTSjR
H0bNb8qsS9G+VvRY7vgDWJ8KrbPVeLt2DAeiXPc6IZOOfUTYUpZDpdI98eRgAhPN
2dnIiWDL11CjBzkSDPjqcQ2sX3KnX0BjtqjDiz4lJVsNOhxq9lpFC7zGqVgPDKg4
dzTnc8DXxvfs/NF2F/hOFQCuGlVQIc9iO4Pqf1ILdbCDdM/Nvxv9Z1I=
=l9qX
-----END PGP SIGNATURE-----

--4unJIM8rnqcEG0CVWNoAaJ20ATRAUguBs--
