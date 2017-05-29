Received: from eggs.gnu.org ([2001:4830:134:3::10]:39459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFNr9-0002O0-Vq
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFNr9-0005nx-5L
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:49:24 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-14-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4ed6c1e1-e746-e809-8b71-f78e91145f47@redhat.com>
Date: Mon, 29 May 2017 18:49:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170503122539.282182-14-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lP2JCPWQd37i22PDU6uPEdV1bw0PedAs1"
Subject: Re: [Qemu-devel] [PATCH 13/25] block: introduce persistent dirty
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lP2JCPWQd37i22PDU6uPEdV1bw0PedAs1
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <4ed6c1e1-e746-e809-8b71-f78e91145f47@redhat.com>
Subject: Re: [PATCH 13/25] block: introduce persistent dirty bitmaps
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-14-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
> New field BdrvDirtyBitmap.persistent means, that bitmap should be saved=

> by format driver in .bdrv_close and .bdrv_inactivate. No format driver
> supports it for now.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 26 ++++++++++++++++++++++++++
>  block/qcow2-bitmap.c         |  1 +
>  include/block/dirty-bitmap.h |  5 +++++
>  3 files changed, 32 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--lP2JCPWQd37i22PDU6uPEdV1bw0PedAs1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLFEAEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQO3J
CACtC1LJLZQl9iZVwTAcRuUpqyp3pVz/kQGOI8Z61dKsiZmUHcQWue9hIOa9vsGw
/iSRr5uWZFCtxNvrT9bXzcaULuU/pyCWxVbMkEybI9z9bXDw+98QFdCPy8A3o/Ct
6ZogKZMorCiYK85NMrOV7QQkdb0ExKfgopZS5Q8KMO5psdgMGDhhSF67UT7u3ZUO
Se5MGpoVvHw9mFXhcXUEdEDuqEf9pxYxSMtAjGyrTW0vxaV/nBUvJrMdS6IQARBN
F5pz1gp6sP7uXtEEfYtikhKYN+uNNXsC3tjkHA3HtvxRW4SvmW2KEXYtHPZPnkyr
R03X2+9quHLLcQ0YL0Sj7jci
=GQ7t
-----END PGP SIGNATURE-----

--lP2JCPWQd37i22PDU6uPEdV1bw0PedAs1--
