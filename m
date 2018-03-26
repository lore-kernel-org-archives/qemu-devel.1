Received: from eggs.gnu.org ([2001:4830:134:3::10]:54509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0Ylk-0002PV-9F
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0Ylj-0007SS-Fk
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:31:04 -0400
References: <20180228131315.30194-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1e7d7cbe-0e38-39ee-2ba0-8223e3c64095@redhat.com>
Date: Mon, 26 Mar 2018 22:30:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180228131315.30194-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t8DIFkr2tL1ca5TDrvOTUHEjak6cOgeMk"
Subject: Re: [Qemu-devel] [PATCH 0/2] block/file-posix: Fix fully
 preallocated truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t8DIFkr2tL1ca5TDrvOTUHEjak6cOgeMk
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-stable@nongnu.org
Message-ID: <1e7d7cbe-0e38-39ee-2ba0-8223e3c64095@redhat.com>
Subject: Re: [PATCH 0/2] block/file-posix: Fix fully preallocated truncate
References: <20180228131315.30194-1-mreitz@redhat.com>
In-Reply-To: <20180228131315.30194-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-28 14:13, Max Reitz wrote:
> Fully preallocated truncation has a 50 % chance of working on images
> files over file-posix.  It works if $SIZE % 4G < 2G, and it fails
> otherwise.  To make things even more interesting, often you would not
> even notice because qemu reported success even though it did nothing
> (because after the successful lseek(), errno was still 0, so when the
> file-posix driver tried to return a negative error code, it actually
> reported success).
>=20
> This issue is fixed by patch 1 in this series.  Thanks to Daniel for
> reporting!
>=20
>=20
> Max Reitz (2):
>   block/file-posix: Fix fully preallocated truncate
>   iotests: Test preallocated truncate of 2G image
>=20
>  block/file-posix.c         |  5 +++--
>  tests/qemu-iotests/106     | 24 ++++++++++++++++++++++++
>  tests/qemu-iotests/106.out | 10 ++++++++++
>  3 files changed, 37 insertions(+), 2 deletions(-)

Applied to my block tree...  (*cough* *cough* -- I'm the worst when it
comes to keeping track of my own patches.)

Max


--t8DIFkr2tL1ca5TDrvOTUHEjak6cOgeMk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlq5WH4ACgkQ9AfbAGHV
z0Df/Qf/QrmFf9ZfDq5xEl11OjMLscdbs/kQnD2OtGcK04ton44Vm/16YUILRTcL
XwUqy4sCtdHiuQQ4eX1U2sZe90bJ9gwQrcjfc/zAR0W5enU8Y5tUn9zvXCO+pxT6
rLl9nh8BXc+eUOMMno0RfOGWuxR50nh0Xtmm2d/KIw4oGd77VFQQ/vA5WartHAZM
vxQUUVRDAYkOylZDYzZPbRIFzNERbCDXlrWYMLM/8U4W7nQ4mk3zOsuQ81563jnN
rDC4fpxl4Z1Ov1enatnnBsqN9mWMAAgNKrzoSZsmY6zdBxOUC4gusW8bn2D0yfGs
Dxy9jPNtmjcUs9HyCC97+IPt6cFUcA==
=lpd6
-----END PGP SIGNATURE-----

--t8DIFkr2tL1ca5TDrvOTUHEjak6cOgeMk--
