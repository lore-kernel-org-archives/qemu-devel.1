Received: from eggs.gnu.org ([2001:4830:134:3::10]:46471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNy2s-0006U4-2k
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNy2r-0007OW-5S
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:09:30 -0400
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180529203910.7615-11-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aa191739-b4dd-ffca-3b5b-1a289127ca60@redhat.com>
Date: Wed, 30 May 2018 12:09:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180529203910.7615-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tPXIK7l5oBOKksYshCJlUna7OP4Q4E5bF"
Subject: Re: [Qemu-devel] [PATCH v2 10/16] qemu-iotests: Rewrite 206 for
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
--tPXIK7l5oBOKksYshCJlUna7OP4Q4E5bF
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com,
 pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <aa191739-b4dd-ffca-3b5b-1a289127ca60@redhat.com>
Subject: Re: [PATCH v2 10/16] qemu-iotests: Rewrite 206 for blockdev-create
 job
References: <20180529203910.7615-1-kwolf@redhat.com>
 <20180529203910.7615-11-kwolf@redhat.com>
In-Reply-To: <20180529203910.7615-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 22:39, Kevin Wolf wrote:
> This rewrites the test case 206 to work with the new x-blockdev-create
> job rather than the old synchronous version of the command.
>=20
> All of the test cases stay the same as before, but in order to be able
> to implement proper job handling, the test case is rewritten in Python.=

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/206     | 680 ++++++++++++++++++-------------------=
--------
>  tests/qemu-iotests/206.out | 253 ++++++++++-------
>  tests/qemu-iotests/group   |   2 +-
>  3 files changed, 414 insertions(+), 521 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--tPXIK7l5oBOKksYshCJlUna7OP4Q4E5bF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOeE8ACgkQ9AfbAGHV
z0BaVwf7BZqYZuIMsOfCSG0tnxQER8GaBou3zZ4CYPlk0AW48R+icR/4bhEcVdo7
zcCh7y/QxjajTAXajhP0+HrfSWjjJsl1cci1fOV0MSeChMYBvocnpOj/+dYdIRHe
pPTZw1gZbdRHcmAvOsYvby3tL+G1V5zBhx9saCBWZwgfUoSwUzNytRKGHxIG2+iB
5L8QY4qK3bzrED99AbqIRonSaSqV9xWUyoD/NMpiqzGCOMeVaInThlUGqkq9ozy9
GFwdU237wD5Ve1YmnUgGe7qbPJyEUqJXJ6XKbTbH0/Nj4vesqya6yWQ25VXSc5Qp
1BhychQtjeWdDy0dZfzbr3J5D0LK1g==
=pQLF
-----END PGP SIGNATURE-----

--tPXIK7l5oBOKksYshCJlUna7OP4Q4E5bF--
