Received: from eggs.gnu.org ([2001:4830:134:3::10]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dW317-0002nd-4F
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dW316-0006K5-Cm
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:00:33 -0400
References: <20170714123341.373857-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b9f574d1-91b5-c5dc-46b2-1a8976c5539f@redhat.com>
Date: Fri, 14 Jul 2017 18:00:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170714123341.373857-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pHLOlxW5IEFt53RnXaaA3FemESfvTKMJa"
Subject: Re: [Qemu-devel] [PATCH] qcow2-bitmap: fix bitmap_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pHLOlxW5IEFt53RnXaaA3FemESfvTKMJa
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org,
 peter.maydell@linaro.org
Message-ID: <b9f574d1-91b5-c5dc-46b2-1a8976c5539f@redhat.com>
Subject: Re: [PATCH] qcow2-bitmap: fix bitmap_free
References: <20170714123341.373857-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170714123341.373857-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-14 14:33, Vladimir Sementsov-Ogievskiy wrote:
> Fix possible crash on error path in
> qcow2_remove_persistent_dirty_bitmap. Although bitmap_free was added in=

> 88ddffae8fc the bug was introduced later in commit 469c71edc72 (when
> qcow2_remove_persistent_dirty_bitmap was added).
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-bitmap.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--pHLOlxW5IEFt53RnXaaA3FemESfvTKMJa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZaOqZEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMbl
B/99kTYpdZ/gOGHbGMm5lH6JDmjf4jo+jJwqiI9p2qZpze245SEuHwfgSnkn0iQT
PhnArCDwYKcgc9hQj5wvVbOdrd1Z5DXUSc7BP0gwHd4dTYtG0Z2R0XW1ezF2ST3d
SowrLhECABxpXVpiotx8yobu+xWYAixXLyWCv96wuOXUm8r1EaB54k/Yx0IYX9QH
naA/TJXSrcQ8WkUOaXOtQoTCIdfMTMaZ/Q05Yqou5RPKuM7p0NWi0oeLMLlrRD6t
xkCUlOuTB7u8l1ZWk7iAwET/Qs8DyOetFL0rXLHTlHE+WmGdRfEXFX8bKDTI2h2k
tAPwvb8jBvWXz9+8ME13q1B7
=4S0L
-----END PGP SIGNATURE-----

--pHLOlxW5IEFt53RnXaaA3FemESfvTKMJa--
