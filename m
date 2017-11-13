Received: from eggs.gnu.org ([2001:4830:134:3::10]:50266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEGzx-00083p-Nk
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEGzs-00030L-77
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:50:09 -0500
Date: Mon, 13 Nov 2017 15:49:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171113154952.GF27765@stefanha-x1.localdomain>
References: <cover.1510339534.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline
In-Reply-To: <cover.1510339534.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix throttling crashes in BlockBackend
 with no BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, sochin jiang <sochin.jiang@huawei.com>


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 08:54:45PM +0200, Alberto Garcia wrote:
> Hi,
>=20
> this series fixes the problems reported by Sochin Jiang in
> BlockBackend when there's a valid throttling configuration but the BDS
> has been removed.
>=20
> The patches apply on top of Li Zhengui's "all I/O should be completed
> before removing throttle timers" and I tested this on top of Stefan's
> block branch (commit 900276cf24589596296d3d099fe609ad5c182ac9).
>=20
> Regards,
>=20
> Berto
>=20
> Alberto Garcia (3):
>   block: Check for inserted BlockDriverState in blk_io_limits_disable()
>   block: Leave valid throttle timers when removing a BDS from a backend
>   qemu-iotests: Test I/O limits with removable media
>=20
>  block/block-backend.c      | 30 +++++++++++++---------
>  tests/qemu-iotests/093     | 62 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/qemu-iotests/093.out |  4 +--
>  3 files changed, 82 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.11.0
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaCb8gAAoJEJykq7OBq3PI9R0H/3Z/3N66Dtta77sOmNUCvY01
yU8N+dwDWTo9OLQ9Cz3oSB0Uie7mDXLMMARWNCjaRjE2IKvhfYhz1nLDerLU3ISw
9eYmdb+KB7mJoqpQAr5LggajPWaFamLX9rupdk4RZJqOyh+T9PP1Q/LDZXtQkN3q
WtWVmaRAeihTeNRNf3oagCMirZPGxyBJMmazzjBhXWlkxvo3LPcVgv/2Sj7TT5eC
KXjmRxjJWw6BonXuSL2eq1tGBDWSsLDVaEBUo2MIS01Z2atZM1udv+JrtVU3EdaY
O9VePd38HtYRTN4IAdRFQuJXVq8IEa9Z3FkbDZRkKejwwL6u2hN1dUsS5VVRJrU=
=RU8x
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
