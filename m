Received: from eggs.gnu.org ([209.51.188.92]:33053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK5c1-0002BI-Vm
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK5c1-0004lk-5S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:30:17 -0400
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
	<20190415144948.78568-6-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4f5ed0c3-83d0-bcbe-5866-e0aab67f188f@redhat.com>
Date: Fri, 26 Apr 2019 20:30:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190415144948.78568-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="84f4rdOLh8MVB2HtcZP3aceBsIlfke8WX"
Subject: Re: [Qemu-devel] [PATCH v6 5/5] block/backup: refactor: split out
 backup_calculate_cluster_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--84f4rdOLh8MVB2HtcZP3aceBsIlfke8WX
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <4f5ed0c3-83d0-bcbe-5866-e0aab67f188f@redhat.com>
Subject: Re: [PATCH v6 5/5] block/backup: refactor: split out
 backup_calculate_cluster_size
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
 <20190415144948.78568-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190415144948.78568-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.04.19 16:49, Vladimir Sementsov-Ogievskiy wrote:
> Split out cluster_size calculation. Move copy-bitmap creation above
> block-job creation, as we are going to share it with upcoming
> backup-top filter, which also should be created before actual block job=

> creation.
>=20
> Also, while being here, drop unnecessary "goto error" from
> bdrv_getlength error path.

It isn=E2=80=99t unnecessary, though.  Before this, we invoke
bdrv_dirty_bitmap_create_successor(), so the error path has to clean
that up with bdrv_reclaim_dirty_bitmap().

Max


--84f4rdOLh8MVB2HtcZP3aceBsIlfke8WX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzDTjAACgkQ9AfbAGHV
z0AmcwgAiRFQzZf77Na1f7qbO2bTVzdshfKTPdsqSfWfzwk4G1sXGsbTI2oGnz3L
NUCWRWeLz4LHNgwd963vIlKoZ6TIsZ07L8mpXT2k4H71avjr9otgFJMOYZMGgmlF
r+yfKl5cYpbVEjp5zSM09DXSObGJrGFg8aSJmq5nZGlhakg6pM4F5o3J3CJhiIpo
McFNbZxQB8pk/hZL1R0xPfWzQKxTSVwKVqpa/rJ8qCHYzE0Y7M1yTFaBcZnVTRJt
ULijRAUjAyaR/4RPOy+W8ne5kQWRuSz5VJ/Jjt0tXyy2PAcSh49PtIVdNyUVjm+Z
hURPvfOX5TExOKWj+TUQmNfnuE4+Iw==
=JsZt
-----END PGP SIGNATURE-----

--84f4rdOLh8MVB2HtcZP3aceBsIlfke8WX--
