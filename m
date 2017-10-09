Received: from eggs.gnu.org ([2001:4830:134:3::10]:43531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1g3Q-0001uW-70
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1g3P-0000hb-IE
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:57:40 -0400
References: <20171009215533.12530-1-mreitz@redhat.com>
	<20171009215533.12530-3-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0440b278-f453-d992-d90a-7bfa48c9329b@redhat.com>
Date: Mon, 9 Oct 2017 23:57:29 +0200
MIME-Version: 1.0
In-Reply-To: <20171009215533.12530-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qPmEQfB3WkV6qj8XcXiOCpw0hwtC6iR9t"
Subject: Re: [Qemu-devel] [PATCH 2/3] qcow2: Always execute preallocate() in
 a coroutine
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
--qPmEQfB3WkV6qj8XcXiOCpw0hwtC6iR9t
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <0440b278-f453-d992-d90a-7bfa48c9329b@redhat.com>
Subject: Re: [PATCH 2/3] qcow2: Always execute preallocate() in a coroutine
References: <20171009215533.12530-1-mreitz@redhat.com>
 <20171009215533.12530-3-mreitz@redhat.com>
In-Reply-To: <20171009215533.12530-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-09 23:55, Max Reitz wrote:
> Some qcow2 functions (at least perform_cow()) expect s->lock to be
> taken.  Therefore, if we want to make use of them, we should execute
> preallocate() (as "preallocate_co") in a coroutine so that we can use
> the qemu_co_mutex_* functions.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)

Cc: qemu-stable@nongnu.org


--qPmEQfB3WkV6qj8XcXiOCpw0hwtC6iR9t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnb8MkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUd0H/iUXxQ3QLTTQb0TU0qSpDDi5t5ZxigTL
FS2MszQJatj4RU5bp0rzpV/OpywdsjliIWqwOBshGU1ekTMdyAWaECcxoWvdoxVH
vIlPXj49aiTfg2M2FdnTxlUYHp52f5MS0mnie/42CHW2rFXPgTO4MBURDzQvtcs1
6NpRAs9SQf/ArxNs9x9P81rPbuOc3GYFbZWHbVqsa4LZwSkIMXgXCCjkZMi6Xor4
29/q2qQV7RyrvT6T+hPUkhuIfeSpmBnKfQR4uimRosmsSeakuVQD39gcARJCmvZn
ARnWV8IzgfiwF13x4NAyywgA04h2/+rAl/WaGgGBaiq00gLTE7toSlY=
=6Mm6
-----END PGP SIGNATURE-----

--qPmEQfB3WkV6qj8XcXiOCpw0hwtC6iR9t--
