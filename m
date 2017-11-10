Received: from eggs.gnu.org ([2001:4830:134:3::10]:49447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHgD-0001Zi-SO
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHgC-0000zb-UN
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:21:41 -0500
References: <cover.1510339534.git.berto@igalia.com>
	<071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d725567e-787d-bdea-36aa-d20877d8d288@redhat.com>
Date: Fri, 10 Nov 2017 23:21:27 +0100
MIME-Version: 1.0
In-Reply-To: <071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nWjJ6M0qSFKKjJqIEI6ossgt65Rro3pxg"
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
--nWjJ6M0qSFKKjJqIEI6ossgt65Rro3pxg
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, sochin jiang <sochin.jiang@huawei.com>
Message-ID: <d725567e-787d-bdea-36aa-d20877d8d288@redhat.com>
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

By the way, I just noticed that this test tests that
x-blockdev-remove-medium and x-blockdev-insert-medium do not destroy
throttling information -- which is exactly why those commands had been
declared experimental in the first place.  So I guess this means we can
drop the x- now. :-)

Max


--nWjJ6M0qSFKKjJqIEI6ossgt65Rro3pxg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloGJmcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHsAH/R/fRgbTJHQAVnpqXVGqIhq+k4QJwLU6
qcdb2ijv+bnEAYQbaSuuwijMDOpz74h3w9jAtQUXwIrhLYOYHfgEkWRrgslyekFY
7wL0Z+MSkM2vKg0l4FKkhS2wPFaKsgXIGq44l68nRSL+yaNrQS3hJs62HnhmgiJM
5rB6D3xdxPaCJOfcVO0+zA9QqmmC3tpfDhQ53EdF8qnkbYLqe94PAQvRFxLQdwFr
YmQjzwAJZ+5mHR52xNbCyKee3RyLkUsCjkK5dL7vWyuPgqaSmX9ziopVIwDan2Gj
msSpjFpdHQf7233HG+jJTiqg9EAtLbsVDpkQJu7xPxZ/PuZcKbYmA+Y=
=Hsbr
-----END PGP SIGNATURE-----

--nWjJ6M0qSFKKjJqIEI6ossgt65Rro3pxg--
