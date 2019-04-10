Received: from eggs.gnu.org ([209.51.188.92]:46609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEGGa-0007iX-0h
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEGGZ-0006Xv-6V
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:40:03 -0400
References: <20190410162918.9343-1-mreitz@redhat.com>
	<aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3620d581-c849-f768-b9d4-239ff09f174f@redhat.com>
Date: Wed, 10 Apr 2019 18:39:56 +0200
MIME-Version: 1.0
In-Reply-To: <aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Xzr4c9HRwJtAye50aRY2gVKvSONxqsgU"
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotests: Let 245 pass on tmpfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Xzr4c9HRwJtAye50aRY2gVKvSONxqsgU
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <3620d581-c849-f768-b9d4-239ff09f174f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotests: Let 245 pass on tmpfs
References: <20190410162918.9343-1-mreitz@redhat.com>
 <aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
In-Reply-To: <aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.04.19 18:39, Eric Blake wrote:
> On 4/10/19 11:29 AM, Max Reitz wrote:
>> tmpfs does not support O_DIRECT.  Detect this case, and skip flipping
>> @direct if the filesystem does not support it.
>>
>> Fixes: bf3e50f6239090e63a8ffaaec971671e66d88e07
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/245 | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> Are you trying to get this in 4.0-rc3? (As a test, it has no bearing on=

> the actual binaries; fewer testsuite failures are nice if we squeeze it=

> in, but at the same time it is not enough to delay the release if it
> does not get fixed until 4.1).
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

If there are other patches for rc3, we could take this as well.  But
there is no point in making a pull request just for this.

Max


--2Xzr4c9HRwJtAye50aRY2gVKvSONxqsgU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyuHFwACgkQ9AfbAGHV
z0AkXggAheRZgXSdvLICfULz40QOJIP5bTCvfzgDC5AMNwLKNpL1ySskYZHxgbta
Qlo2Ils0mbVOmxOTuQokhMNX+Uw9j3KFra/SPUp6tYIYXHzQSckHqq3jrwHmsHM8
UqQcXGlhaBc/6MonHOKntord5f4/mXCOahkHya/dx+/vHVLkd2gQy1wq/o8OuRPB
ktYtIt/O2ceGCyTzOzG+d41GXpSCMUB7WaMPym7l+ll83BSbAFgLyYd+8oAleJaz
lA1IOye5QbbJS8Kj1drYP1U7ORnV8nDaAw+Pbf0AhXqQ0/DTfaV5wf8XenamXY1I
yU8l8iB/es7RecFutGHZWhVjX0Y/hg==
=q7Nr
-----END PGP SIGNATURE-----

--2Xzr4c9HRwJtAye50aRY2gVKvSONxqsgU--
