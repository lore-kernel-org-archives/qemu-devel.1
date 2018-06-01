Received: from eggs.gnu.org ([2001:4830:134:3::10]:48002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOhxr-0000za-Pt
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOhxq-0001Pm-O2
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:11:23 -0400
References: <20180509194302.21585-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c41462d8-95ca-a89c-d42a-552663bbe61a@redhat.com>
Date: Fri, 1 Jun 2018 13:11:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180509194302.21585-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7ebv1eYDhBJFqjAhDyWToVLHXgWGSnGMX"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] qemu-io: Exit with error when a
 command failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ebv1eYDhBJFqjAhDyWToVLHXgWGSnGMX
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <c41462d8-95ca-a89c-d42a-552663bbe61a@redhat.com>
Subject: Re: [PATCH v2 0/5] qemu-io: Exit with error when a command failed
References: <20180509194302.21585-1-mreitz@redhat.com>
In-Reply-To: <20180509194302.21585-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 21:42, Max Reitz wrote:
> Right now, qemu-io's exit code is rather useless as it is usually 0.
> Except sometimes, then it's 1 in case of an error (mostly when you
> specify a filename as an argument and it cannot open that).
>=20
> At the same time, most command functions' return values are rather
> useless as they are usually 0 (meaning "continue execution").  There is=

> only a single function that breaks that pattern, which is "quit".  On
> one hand, this is pointless because "quit" is in qemu-io.c, so it can
> easily signal that fact through a global (yet static) variable.  On the=

> other, it breaks the usual pattern of I/O functions returning error
> codes.
>=20
> This series resolves the overlap between both issues by making the
> command functions' return error values instead of whether to continue
> execution or not, and thus makes qemu-io return 1 if any of the command=
s
> executed has failed and 0 only if all of them have succeeded.
>=20
> Patch 5 showcases how that may be useful for iotests.
>=20
>=20
> See also: https://bugzilla.redhat.com/show_bug.cgi?id=3D1519617
>=20
>=20
> v2:
> - Patch 2: Added a comment on the interface of command functions (their=

>            parameters and their return value) [Eric]
> - (Decided against replacing 0/1 by EXIT_SUCCESS/EXIT_FAILURE, because
>    although I personally would prefer them slightly, neither are ever
>    used in qemu-io so far.)
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
> 001/5:[----] [-C] 'qemu-io: Drop command functions' return values'
> 002/5:[0005] [FC] 'qemu-io: Let command functions return error code'
> 003/5:[----] [--] 'qemu-io: Exit with error when a command failed'
> 004/5:[----] [--] 'iotests.py: Add qemu_io_silent'
> 005/5:[----] [-C] 'iotests: Let 216 make use of qemu-io's exit code'
>=20
>=20
> Max Reitz (5):
>   qemu-io: Drop command functions' return values
>   qemu-io: Let command functions return error code
>   qemu-io: Exit with error when a command failed
>   iotests.py: Add qemu_io_silent
>   iotests: Let 216 make use of qemu-io's exit code
>=20
>  include/qemu-io.h             |   9 +-
>  qemu-io-cmds.c                | 276 ++++++++++++++++++++++++----------=
--------
>  qemu-io.c                     |  62 +++++++---
>  tests/qemu-iotests/216        |  23 ++--
>  tests/qemu-iotests/216.out    |  17 +--
>  tests/qemu-iotests/iotests.py |   9 ++
>  6 files changed, 231 insertions(+), 165 deletions(-)

Applied to my block branch.

Max


--7ebv1eYDhBJFqjAhDyWToVLHXgWGSnGMX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsRKdAACgkQ9AfbAGHV
z0CZFAf9E+cGicZZBHr+8JXZz6xF09MnYmPGLM5n5ybIBvpeVjHBICogXYumn/kM
EW09VIZE/+YNKO3a2dsLohVlm82p/9L+H0PQTBU5MGBROGsCtlkJUmGJAiN/txEO
YKc+wC0ijrjyl3UMQRkGXVJBlQlunYjCAf76EJk6D3BSkypKMSguvqQ7qjbEYL7G
L9PpLP1fBSXE6/BlzqqlJf5h3ZBGx4Nt3RBtkUOKKd7hQAgIICZM/yYuStPZ6MaX
SfHmCB0dNeR0XU7drDASKCZJ7MBsfABdA7RFaSKVk0zvzHZfLoH9KyL9/uK4YMr+
XemXlN89Hiiu4Q7awjM1MNbPa/PzKg==
=Nhec
-----END PGP SIGNATURE-----

--7ebv1eYDhBJFqjAhDyWToVLHXgWGSnGMX--
