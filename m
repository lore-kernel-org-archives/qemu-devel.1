Received: from eggs.gnu.org ([209.51.188.92]:56657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK5Dg-0007Po-5Z
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK5De-0000FO-4y
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:05:08 -0400
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
	<20190415144948.78568-4-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6445f4e0-a547-2119-2a1a-db5e5cb8de26@redhat.com>
Date: Fri, 26 Apr 2019 20:04:52 +0200
MIME-Version: 1.0
In-Reply-To: <20190415144948.78568-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6jpEkXVsm50U3d0pWYJiuhpdIEyHdq95a"
Subject: Re: [Qemu-devel] [PATCH v6 3/5] block/backup: refactor and tolerate
 unallocated cluster skipping
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
--6jpEkXVsm50U3d0pWYJiuhpdIEyHdq95a
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <6445f4e0-a547-2119-2a1a-db5e5cb8de26@redhat.com>
Subject: Re: [PATCH v6 3/5] block/backup: refactor and tolerate unallocated
 cluster skipping
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
 <20190415144948.78568-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190415144948.78568-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.04.19 16:49, Vladimir Sementsov-Ogievskiy wrote:
> Split allocation checking to separate function and reduce nesting.
> Consider bdrv_is_allocated() fail as allocated area, as copying more
> than needed is not wrong (and we do it anyway) and seems better than
> fail the whole job. And, most probably we will fail on the next read,
> if there are real problem with source.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 60 +++++++++++++++++++-------------------------------=

>  1 file changed, 23 insertions(+), 37 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6jpEkXVsm50U3d0pWYJiuhpdIEyHdq95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzDSEQACgkQ9AfbAGHV
z0B6Ugf9H6dQBk8pOO9GveBUJtNnWWLcSd90zoGWv132fYUrxURNTEBWKtg1kVCb
J738Q6Po3iT0ZXBvB5yd6Jv42dRycju04SEfIDixENbYrlH8ny6NtsBGFgORqgjV
ZChX0ecSPY0MCHEAclKh5lk3otF7Nn4KfhBCaQ+MPZ2K4oHYKTzixAPhrYeaCWSY
cYf2L7R1jADXOyUNdFVZ4YWy/lKZMvgNk9kH8QIlcv2XXZW08yxjqP6Xdi22HaFB
PlOxW/23xT+jWUM3+YoGS5DZZUWFs7urBPbfCngWq2nomdfCpp8mlhK6Z7wfXM7g
t8G1iwyxIg2P5bjKcK9OB5G4i1tZ9w==
=SCwb
-----END PGP SIGNATURE-----

--6jpEkXVsm50U3d0pWYJiuhpdIEyHdq95a--
