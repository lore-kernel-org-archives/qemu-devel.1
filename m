Received: from eggs.gnu.org ([2001:4830:134:3::10]:48266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOi08-0001o0-Uz
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOi07-0002Y2-Kx
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:13:44 -0400
References: <20180509182002.8044-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <794b8b52-9202-2bcf-68a7-aeba42cb5f4a@redhat.com>
Date: Fri, 1 Jun 2018 13:13:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180509182002.8044-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tUJbTGhbrvL5yFbHoqMsmo8QelK1JFQlh"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] qemu-img: Resolve relative backing
 paths in rebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tUJbTGhbrvL5yFbHoqMsmo8QelK1JFQlh
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <794b8b52-9202-2bcf-68a7-aeba42cb5f4a@redhat.com>
Subject: Re: [PATCH v2 0/2] qemu-img: Resolve relative backing paths in rebase
References: <20180509182002.8044-1-mreitz@redhat.com>
In-Reply-To: <20180509182002.8044-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 20:20, Max Reitz wrote:
> v1 of the cover letter here (no change necessary there):
> http://lists.nongnu.org/archive/html/qemu-block/2018-05/msg00243.html
>=20
> v2: Fixed a leaked buffer in an error path in patch 1 [Eric]
>=20
>=20
> git-backport-diff against v1:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/2:[0001] [FC] 'qemu-img: Resolve relative backing paths in rebase'
> 002/2:[----] [--] 'iotests: Add test for rebasing with relative paths'
>=20
>=20
> Max Reitz (2):
>   qemu-img: Resolve relative backing paths in rebase
>   iotests: Add test for rebasing with relative paths
>=20
>  qemu-img.c                 | 23 ++++++++++++-
>  tests/qemu-iotests/024     | 82 ++++++++++++++++++++++++++++++++++++++=
++++++--
>  tests/qemu-iotests/024.out | 30 +++++++++++++++++
>  3 files changed, 131 insertions(+), 4 deletions(-)

Applied to my block branch.

Max


--tUJbTGhbrvL5yFbHoqMsmo8QelK1JFQlh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsRKloACgkQ9AfbAGHV
z0D+tQgAr1t9C9U7ORSrqE7qXGxa7Pco0GC/+wFvk9LlW1Szloa7N2HMjOM3W3KA
z1HIQs+Y5mdYYyEyh9Wc55PQKe9e7fKauAYP42v/EIyQ2rMRIrZcq4/UOYGhd0RD
bRhgXz4nZ3PgPX1LrvFA2dqG00HknYSk1GJ5wTg3C+Za1rRzt9wb7nu1Bn3F0pjh
WX4q1ZxYoiP78x0pC1S3jIRFVBNiWhZ3NM1cZD9PGf7A5MGjTZNphkdCgMQdKlq2
M6kIXnxanptzPZQ/qB5EERqMmbWfTQm8dHyIG6TSGvDWKWuTpeKy9kADGRl3ANG9
4Qdc5b8N0PEvcPXWkAJGndY4VkU1jw==
=rFSp
-----END PGP SIGNATURE-----

--tUJbTGhbrvL5yFbHoqMsmo8QelK1JFQlh--
