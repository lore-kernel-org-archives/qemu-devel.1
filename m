Received: from eggs.gnu.org ([2001:4830:134:3::10]:57116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uke-0006D6-Ur
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uka-0001a8-To
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:31:57 -0400
Date: Thu, 11 May 2017 16:31:49 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511203149.GP24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-14-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tZCmRiovzb4sxAVa"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-14-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 13/16] blk: fix aio context
 loss on media change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--tZCmRiovzb4sxAVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:53PM +0800, Fam Zheng wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> If we have separate iothread for cdrom, we lose connection to it on
> qmp_blockdev_change_medium, as aio_context is on bds which is dropped
> and switched with new one.
>=20
> As an example result, after such media change we have crash on
> virtio_scsi_ctx_check: Assertion `blk_get_aio_context(d->conf.blk) =3D=3D=
 s->ctx' failed.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tZCmRiovzb4sxAVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMo1AAoJEJykq7OBq3PIFpAH/iT09qHXqq5UKoco33xI+W3R
nSWuSqgnCh+9pBEnJtfrLP4syQMOxaq7iq0MpLqKU+IgorlR17duC8aCY3PkYQ61
SFoP9Y1e/J6EdgREugj1kAJD7bb2yBo5JqQeqKNdn4MoojOEvIcKfdSMIEFriDmM
EjtKSxQVUwC90vM0KaAzTDs0IbpT4kKyEXF+ifKnwkq6nWPJtX5VqPGPlggL2JVy
2m6kS79dV4T8hLVvkolIvDdeW0MkKHSM3gcCD8ZXQ4zlP4KJGQFlcdhWYLFqjJFx
sRFcwAz0aJcyDdB7qfMcY0oZJjQSp1W2GO6e8rZCq12RHT0JTebdMhb9rinCJD4=
=lo3v
-----END PGP SIGNATURE-----

--tZCmRiovzb4sxAVa--
