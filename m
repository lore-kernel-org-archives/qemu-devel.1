Received: from eggs.gnu.org ([2001:4830:134:3::10]:48450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLnAu-0008Il-Dg
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLnAs-0002BM-8s
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:04:16 -0400
Date: Fri, 16 Jun 2017 10:04:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170616090410.GC31462@stefanha-x1.localdomain>
References: <20170614092930.11234-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <20170614092930.11234-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] virtio-blk: trace vdev so
 devices can be distinguished
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 10:29:30AM +0100, Stefan Hajnoczi wrote:
> It is hard to analyze trace logs with multiple virtio-blk devices
> because none of the trace events include the VirtIODevice *vdev.
>=20
> This patch adds vdev so it's clear which device a request is associated
> with.
>=20
> I considered using VirtIOBlock *s instead but VirtIODevice *vdev is more
> general and may be correlated with generic virtio trace events like
> virtio_set_status.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/virtio-blk.c | 12 +++++++-----
>  hw/block/trace-events | 10 +++++-----
>  2 files changed, 12 insertions(+), 10 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQ58KAAoJEJykq7OBq3PIfnYIALn2OrfRqgx3qMmbRU14vXpP
2DUY02634pu73FLwrviSkdHz/Gnwbts2c/BGa3fpnQ2b8RWZLXfD9zJI28ck5/qn
JrHOwAQwEe8Xs2PccxgPxD28cmsYdKw/x5duGipI6AoQPyAe69sjOBVGGkm4uTPj
53jW3IrxgmmFu7T76W4ZZSt8ynYfSZh4QPfhHMtA5+b6fxxF81OpeUTGXy+0yyFx
i26q6k/GA6Qn+9CwMvr4nSJ9Y7YjXfBvSDbt4c/S12757qQZsdM1TU0fB5Z3/8R0
LiUXpYgg5Mxl5T05NI/EfQfYGC9yTybb9Kj+8je27hOhOdCqRIuZeX2IBvDrzak=
=NRCV
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
