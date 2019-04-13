Received: from eggs.gnu.org ([209.51.188.92]:53800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLUB-0007HQ-3Z
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLU9-0004sN-6u
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:26:35 -0400
References: <20190225190828.17726-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <81125c59-c2c8-6774-2daa-2a56ef204dbf@redhat.com>
Date: Sat, 13 Apr 2019 18:26:23 +0200
MIME-Version: 1.0
In-Reply-To: <20190225190828.17726-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O573Ha1YQuJYFFPA3vsiOdyvNYwJ5ntUs"
Subject: Re: [Qemu-devel] [PATCH v3 0/2] block/ssh: Implement
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
--O573Ha1YQuJYFFPA3vsiOdyvNYwJ5ntUs
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <81125c59-c2c8-6774-2daa-2a56ef204dbf@redhat.com>
Subject: Re: [PATCH v3 0/2] block/ssh: Implement .bdrv_refresh_filename()
References: <20190225190828.17726-1-mreitz@redhat.com>
In-Reply-To: <20190225190828.17726-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.02.19 20:08, Max Reitz wrote:
> This series implements .bdrv_refresh_filename() for the ssh block
> driver, along with an appropriate .bdrv_dirname() so we don't chop off
> query strings for backing files with relative filenames.
>=20
>=20
> v3:
> - Keep iotests 104 and 207 working
>=20
>=20
> Max Reitz (2):
>   block/ssh: Implement .bdrv_refresh_filename()
>   block/ssh: Implement .bdrv_dirname()
>=20
>  block/ssh.c                   | 73 ++++++++++++++++++++++++++++++++---=

>  tests/qemu-iotests/207        | 10 ++---
>  tests/qemu-iotests/207.out    | 10 ++---
>  tests/qemu-iotests/common.rc  |  2 +-
>  tests/qemu-iotests/iotests.py |  2 +-
>  5 files changed, 80 insertions(+), 17 deletions(-)
Applied to my block-next branch.

Max


--O573Ha1YQuJYFFPA3vsiOdyvNYwJ5ntUs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyyDa8ACgkQ9AfbAGHV
z0Db/Qf/ZmNJdDWgoofwmBxSbLl8T6bO7vemx3HnSMwOdWnqK71xC9bGd6HN6Qu5
eO5q5Ddvm7MT7X0EZLzVK76EBzl7WfEa6ROgtSjaEkC74/ItTj8MTGZeZkgRpXZt
U7wgaDll7eCDQT0jpfFjU+LPZMtSLEbOt8mcv+pSeARTXXwne0m+w/sIGZPka2os
QjuQ+GwSjUXmIjdvOA46UfTvFg50DxX1US+SJ7UyjyseO7GzhzS9I27ELb8pgCVa
IDCznO3SoTP8wMesAATsIlGrmhb/rkF8sgo+gKetTzJ095LnTEScmcOCzQKmoGRA
gi8KLeRGxOObatqWEyyZ/uXixxCdvQ==
=DH5A
-----END PGP SIGNATURE-----

--O573Ha1YQuJYFFPA3vsiOdyvNYwJ5ntUs--
