Received: from eggs.gnu.org ([2001:4830:134:3::10]:47734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNy8n-0001bQ-10
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNy8m-0001mD-66
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:15:37 -0400
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180529203910.7615-12-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b9a55908-5e9d-ce07-7a81-39b936f73ccf@redhat.com>
Date: Wed, 30 May 2018 12:15:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180529203910.7615-12-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Z0Vvh2p9o8RW4j6IPhJH6xZVvPUuIC6vy"
Subject: Re: [Qemu-devel] [PATCH v2 11/16] qemu-iotests: Rewrite 207 for
 blockdev-create job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z0Vvh2p9o8RW4j6IPhJH6xZVvPUuIC6vy
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com,
 pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <b9a55908-5e9d-ce07-7a81-39b936f73ccf@redhat.com>
Subject: Re: [PATCH v2 11/16] qemu-iotests: Rewrite 207 for blockdev-create
 job
References: <20180529203910.7615-1-kwolf@redhat.com>
 <20180529203910.7615-12-kwolf@redhat.com>
In-Reply-To: <20180529203910.7615-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 22:39, Kevin Wolf wrote:
> This rewrites the test case 207 to work with the new x-blockdev-create
> job rather than the old synchronous version of the command.
>=20
> Most of the test cases stay the same as before (the exception being som=
e
> improved 'size' options that allow distinguishing which command created=

> the image), but in order to be able to implement proper job handling,
> the test case is rewritten in Python.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/207     | 440 ++++++++++++++++++++-----------------=
--------
>  tests/qemu-iotests/207.out | 107 +++++------
>  tests/qemu-iotests/group   |   6 +-
>  3 files changed, 257 insertions(+), 296 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Z0Vvh2p9o8RW4j6IPhJH6xZVvPUuIC6vy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOecAACgkQ9AfbAGHV
z0DkZQf/fmz+YgkmWU5ARr2a7sEaLBW6hfxDkTQhNU5L4iI/XFiY6mon628jUhr2
dKVyj5yIJacWkHFDKUM3KutEDPbmOwh93ufWklZ81yu8Um03ZEhROH9ZghUGqt4F
dQ7WGCLPHtbjRFJo9XjsNwhaASRhR3Q+HIGUwvscY5r7O5PMO4aFD6xLgMsyiyMc
COhn0eNFfKwVcJ+tJefu39+rgwkE0A01FpQrQ2siaCnsOQ/QajXs7DqidQhIs339
QgGn6b2LVbab0/WFzQ2rIg/ofvdSsgOVUXwwhx0Gc7JWdpUSq+/S7BQbUMhoJLK6
GBDYUNMERemexZvUqa8nxx/xF70q2w==
=oipu
-----END PGP SIGNATURE-----

--Z0Vvh2p9o8RW4j6IPhJH6xZVvPUuIC6vy--
