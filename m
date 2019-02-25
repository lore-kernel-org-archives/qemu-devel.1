Received: from eggs.gnu.org ([209.51.188.92]:42858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyGTf-0005tL-NI
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyGTd-0001Us-Ou
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:39:27 -0500
References: <20190206152919.5532-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5940858f-5eca-3c47-3757-cc700d1743f0@redhat.com>
Date: Mon, 25 Feb 2019 14:39:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190206152919.5532-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yz9ZOUOL3XPGzm6yFxUmEiizaYp3bAmGz"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yz9ZOUOL3XPGzm6yFxUmEiizaYp3bAmGz
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <5940858f-5eca-3c47-3757-cc700d1743f0@redhat.com>
Subject: Re: [PATCH v2 0/2] block/ssh: Implement .bdrv_refresh_filename()
References: <20190206152919.5532-1-mreitz@redhat.com>
In-Reply-To: <20190206152919.5532-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.02.19 16:29, Max Reitz wrote:
> This series implements .bdrv_refresh_filename() for the ssh block
> driver, along with an appropriate .bdrv_dirname() so we don't chop off
> query strings for backing files with relative filenames.
>=20
> This series depends on my "block: Fix some filename generation issues"
> series.
>=20
> Based-on: 20190201192935.18394-1-mreitz@redhat.com
>=20
>=20
> v2:
> - No longer based on the libssh2 -> libssh patches
> - Put /* and */ on their own lines to make checkpatch happy
>=20
>=20
> Max Reitz (2):
>   block/ssh: Implement .bdrv_refresh_filename()
>   block/ssh: Implement .bdrv_dirname()
>=20
>  block/ssh.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++----=

>  1 file changed, 68 insertions(+), 5 deletions(-)

Thanks for having had a look at this series, Rich; I've applied it to my
block branch.

Max


--yz9ZOUOL3XPGzm6yFxUmEiizaYp3bAmGz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxz8AQACgkQ9AfbAGHV
z0Ahzgf/bor7GPDtRsUzXfVadalu6YA9pjS1ILL0aJlK6IK6WyAm3lDULWvaylBJ
1yKNo49SUStXoxBqzEp7Fp4HUnukLJdqivRdmSYmPGQcYpoE9M7lVl+WHv2CmrX+
5KwXzUXmw/hYWt6EghtyD8whYbfq8U3KBRH3/fuyHXG0k5DrrD88AemDiLAz3V3P
NnrGisMF5lIuco/8XGxwTabwKLFDNonkwfdMWFdwuaNJDyJdsKY7ZrwOioHWzMbt
HeVbQEWrInJZOVE0TPIWzOLF0f3tP7h+EkF9zSZ4FARnJ02bDJkBIXeHwUPHNnXE
xTx9zIynmBkgl/aFBGj4LUSa6aPqqg==
=6A9h
-----END PGP SIGNATURE-----

--yz9ZOUOL3XPGzm6yFxUmEiizaYp3bAmGz--
