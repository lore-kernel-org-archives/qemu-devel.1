Received: from eggs.gnu.org ([2001:4830:134:3::10]:55722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDG0O-0003hQ-Oa
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDG0N-0005O3-To
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:34:24 -0500
References: <cover.1510339534.git.berto@igalia.com>
	<071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1d448457-afaa-a772-b140-2bcf37e0ff3e@redhat.com>
Date: Fri, 10 Nov 2017 21:34:12 +0100
MIME-Version: 1.0
In-Reply-To: <071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="79JqkKIx5HiG7001el3c5GgBj4PokOI0A"
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test I/O limits with
 removable media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, sochin jiang <sochin.jiang@huawei.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--79JqkKIx5HiG7001el3c5GgBj4PokOI0A
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, sochin jiang <sochin.jiang@huawei.com>
Message-ID: <1d448457-afaa-a772-b140-2bcf37e0ff3e@redhat.com>
Subject: Re: [PATCH 3/3] qemu-iotests: Test I/O limits with removable media
References: <cover.1510339534.git.berto@igalia.com>
 <071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com>
In-Reply-To: <071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 19:54, Alberto Garcia wrote:
> This test hotplugs a CD drive to a VM and checks that I/O limits can
> be set only when the drive has media inserted and that they are kept
> when the media is replaced.
>=20
> This also tests the removal of a device with valid I/O limits set but
> no media inserted. This involves deleting and disabling the limits
> of a BlockBackend without BlockDriverState, a scenario that has been
> crashing until the fixes from the last couple of patches.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/093     | 62 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/093.out |  4 +--
>  2 files changed, 64 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--79JqkKIx5HiG7001el3c5GgBj4PokOI0A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloGDUQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADrUIAMSwep/27iAkZnYJWskDPEKjMbquhjTH
SOKG4dNCiD1UN9a7RVQup1OnyMlItEGOn8Y+WH4IW7dlEpqSUlJwD9VPjg7/odZA
8xXcG6F0zQ72ATqwS4w/3muzz/nQEsw6z4b9xiLnWfWtjviKuCMmoVHLGIbI81KO
PIIovJLZieg44NTz5VLpKZMVl3c9Ff9zB+jdaxb3pyAXa2V5csw6n/LaIh1UcIBz
ECDluYgLhTJMjurmMur0NzdLnLmojaN14o0MhYwriYVH3xUhH0qLi6teCnRDo1oT
I717C7BgvUIaxftXTAgny0QrpuopkE/uWCkmusu6f3b65wg9g03TVQk=
=jBb9
-----END PGP SIGNATURE-----

--79JqkKIx5HiG7001el3c5GgBj4PokOI0A--
