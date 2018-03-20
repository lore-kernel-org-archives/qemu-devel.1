Received: from eggs.gnu.org ([2001:4830:134:3::10]:41148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eyHqR-0000R8-S4
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eyHqM-0001U8-C0
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:02:31 -0400
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
	<20180319090223.23336-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b9a057b4-4808-1b61-27be-571e0c807bf0@redhat.com>
Date: Tue, 20 Mar 2018 15:02:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180319090223.23336-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zB2JdTHNPiux8Do9cpQFWYr3zeAI0LFtQ"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qcow2-bitmap: add
 qcow2_reopen_bitmaps_rw_hint()
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
--zB2JdTHNPiux8Do9cpQFWYr3zeAI0LFtQ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <b9a057b4-4808-1b61-27be-571e0c807bf0@redhat.com>
Subject: Re: [PATCH v3 1/3] qcow2-bitmap: add qcow2_reopen_bitmaps_rw_hint()
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
 <20180319090223.23336-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180319090223.23336-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-19 10:02, Vladimir Sementsov-Ogievskiy wrote:
> Add version of qcow2_reopen_bitmaps_rw, which do the same work but
> also return a hint about was header updated or not. This will be
> used in the following fix for bitmaps reloading after migration.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block/qcow2.h        |  2 ++
>  block/qcow2-bitmap.c | 15 ++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--zB2JdTHNPiux8Do9cpQFWYr3zeAI0LFtQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqxFGISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A98YH/34LuF7Y4TMwchlCWIuKWFNYCZyRxDZN
hX26pwESVZkUSFGSOUKovICrrigKtO0EVtlfC8AwyWCO+IoR4EEx3OVCyyD9y1OH
QnadqG28BUi4lkn9ZBcW6M5czeTjIW4XAyY0hs7AeOKJLFUwM4Kj3eboiJ00ZgV0
8zSz8PxhW4qnOoQ357eOILhhZXRttiNu1Ef0oU/WOFjq9vOIQWX/EZpN+336qfhO
rSLrE67UV4L8T6uJ0BAW2Ihe8/FShaA80+2PEzc4gMlMeii8T7J2L+O0MhsS8FSG
q8r4LTIgjygC2qN4RG0z1u/qy2OFOZjyiv0i6nu2TBSgjgQKn0s6haw=
=46wV
-----END PGP SIGNATURE-----

--zB2JdTHNPiux8Do9cpQFWYr3zeAI0LFtQ--
