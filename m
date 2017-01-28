Received: from eggs.gnu.org ([2001:4830:134:3::10]:54673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXbYg-0004Zd-6f
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 17:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXbYf-0004jY-5u
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 17:33:22 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-16-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7c1c947a-aa66-800c-9cc1-af90f70a41f2@redhat.com>
Date: Sat, 28 Jan 2017 23:33:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-16-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oACneCA5mdEm0tkN3qawSSvKDPfvLvcTK"
Subject: Re: [Qemu-devel] [PATCH 15/24] qcow2: add
 .bdrv_can_store_new_dirty_bitmap
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
--oACneCA5mdEm0tkN3qawSSvKDPfvLvcTK
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <7c1c947a-aa66-800c-9cc1-af90f70a41f2@redhat.com>
Subject: Re: [PATCH 15/24] qcow2: add .bdrv_can_store_new_dirty_bitmap
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-16-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Realize .bdrv_can_store_new_dirty_bitmap interface.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c        |  1 +
>  block/qcow2.h        |  4 ++++
>  3 files changed, 45 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--oACneCA5mdEm0tkN3qawSSvKDPfvLvcTK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliNHCQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AOyMIALJTfVRk9f8EfOLxBmzvpUp7blcZY368
ojm2RrMp9MMboN/3niBxz3wk6V8EghsqA0+yoYJK8Rr27MJmyoerQT/L6CAqcWps
7R5FK1W8onIpbCz6KnRy6HNO+qWvbVDMoWufkjhoLhxKkH9tXkrop0Wy4+hZXbMt
oe77u27Qb+RFo36SY3FSDdseiInxojBjuR2RarkuC+2owTURdkP/NWVypuB2GbeD
nvHUUxQaGeYTPn6PxDx4IH73ZRvdtmCyyzpeq9lJIuU9vt7omJgDvITk057NkbMm
9/S0Y+RdqX/7SknbeC1ewffqm0sF6W0x9jp1H/ET7sBjPis7wzZCDWs=
=1/Aa
-----END PGP SIGNATURE-----

--oACneCA5mdEm0tkN3qawSSvKDPfvLvcTK--
