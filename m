Received: from eggs.gnu.org ([2001:4830:134:3::10]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYZVz-0000ds-1A
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYZVy-0007F2-8z
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:11:22 -0400
References: <20180628153937.26097-1-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b247d3da-72f0-f1ae-3642-c42c2150ce8d@redhat.com>
Date: Thu, 28 Jun 2018 18:11:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180628153937.26097-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E4TWz5EobV7RP6F4pqxpMT4i6FLBkCp8M"
Subject: Re: [Qemu-devel] [PATCH 0/3] qcow2: Fix cluster leaks on write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: berto@igalia.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E4TWz5EobV7RP6F4pqxpMT4i6FLBkCp8M
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: berto@igalia.com, qemu-devel@nongnu.org
Message-ID: <b247d3da-72f0-f1ae-3642-c42c2150ce8d@redhat.com>
Subject: Re: [PATCH 0/3] qcow2: Fix cluster leaks on write error
References: <20180628153937.26097-1-kwolf@redhat.com>
In-Reply-To: <20180628153937.26097-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-28 17:39, Kevin Wolf wrote:
> Kevin Wolf (3):
>   qemu-iotests: Update 026.out.nocache reference output
>   qcow2: Free allocated clusters on write error
>   qemu-iotests: Test qcow2 not leaking clusters on write error
>=20
>  block/qcow2.h                      |  1 +
>  block/qcow2-cluster.c              | 11 +++++++++++
>  block/qcow2.c                      |  2 ++
>  tests/qemu-iotests/026             | 17 +++++++++++++++++
>  tests/qemu-iotests/026.out         |  8 ++++++++
>  tests/qemu-iotests/026.out.nocache | 14 +++++++++++---
>  6 files changed, 50 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--E4TWz5EobV7RP6F4pqxpMT4i6FLBkCp8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAls1CKIACgkQ9AfbAGHV
z0AVSwf/aVtgLosF1m+nNjshZukvvZe3jhYi0VopWUdYVORLohtWHEUBE4CH5Ucl
dFob3G9czTQJugsNXVGHsL0k8/AMpmnfAtfQ7KXQfdKY7Py1IvI+QvFpXaOfk/Uv
qS1ScAQGdvmJFhv4iJnnje1+PvvHAyTiThM5cqmVv49RR/+WTj9g2ui9Ilp3OT5o
j9kCt4Iud1aU0C9JNrqK8gecE7sku9xb+Exrv/hosJExYvjBlnpxOIh6loiEJli0
ghUTFW6iX2FYkn/Gf5VevDgq9ynwZSa0+v4d0rBeC4rgsZkcLQl3SfDr5P5RkB/L
YHM2ageaXFZ/LnnloHd63jC37Nut2w==
=MZRC
-----END PGP SIGNATURE-----

--E4TWz5EobV7RP6F4pqxpMT4i6FLBkCp8M--
