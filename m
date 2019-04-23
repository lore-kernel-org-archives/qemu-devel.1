Received: from eggs.gnu.org ([209.51.188.92]:59173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIvId-00047w-6M
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIv8C-0006Ng-Kj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:06:41 -0400
Date: Tue, 23 Apr 2019 14:06:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190423130629.GH32465@stefanha-x1.localdomain>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/9] block: buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 05:58:29PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> We often need to do read/write with buffer, not qiov. Instead of
> creating qiov in such cases, let's introduce corresponding helpers.
>=20
> Vladimir Sementsov-Ogievskiy (9):
>   block: introduce byte-based io helpers
>   block/qcow2: use buffer-based io
>   block/qcow: use buffer-based io
>   block/qed: use buffer-based io
>   block/parallels: use buffer-based io
>   block/backup: use buffer-based io
>   block/commit: use buffer-based io
>   block/stream: use buffer-based io
>   qemu-img: use buffer-based io
>=20
>  include/block/block_int.h      | 16 ++++++++++++++++
>  include/sysemu/block-backend.h | 19 +++++++++++++++++++
>  block/backup.c                 | 14 ++++++--------
>  block/commit.c                 |  5 ++---
>  block/parallels.c              | 14 ++++++--------
>  block/qcow.c                   | 19 ++++++-------------
>  block/qcow2.c                  |  9 ++-------
>  block/qed-table.c              | 12 +++++-------
>  block/qed.c                    |  6 ++----
>  block/stream.c                 |  4 +---
>  qemu-img.c                     | 13 ++++---------
>  11 files changed, 69 insertions(+), 62 deletions(-)
>=20
> --=20
> 2.18.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvw3VAAoJEJykq7OBq3PIFY8H/A73AZiHbd62zm2MUtDfXHM3
iotFiJjIactAxvbDCxS8gcWJMsfOheqlluqPLw86zTExcGVhfCSoYm1oZSPYp1d6
b/4SnO9JcNjbNQg+JzuLbBD2FnQNQUcjZMnfZtEUORHqfykxxLRwZ3kRqnw1SkTD
NCZxT4knowSzgpPYR42bGRT91poDGCEshXLKi3DsKVdZxLpfxsgh2suF8VptKjim
YTUMkrxPGZKYILwBRK/SLQyQaa53P2xTDRde/SfGObcovZGPX720D4cb8g/OAYd7
eM4cIzxpBhQi4iUvOws5J3rE1wMUcRJRa2Ev6AOZ1NMQcv+Lm/15zUCIi/aAEE4=
=hXVO
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
