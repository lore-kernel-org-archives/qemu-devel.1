Received: from eggs.gnu.org ([2001:4830:134:3::10]:47221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy2d-0002qO-L5
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy2c-0005Yd-QP
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:27:31 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<bf5887438d46eec45729adb4d05ee06e58b8d40b.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <90afb45b-3456-cdca-8b1d-6b5dc1d10acd@redhat.com>
Date: Wed, 31 Jan 2018 20:27:21 +0100
MIME-Version: 1.0
In-Reply-To: <bf5887438d46eec45729adb4d05ee06e58b8d40b.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xcgblj96pR7yzt7RVg4q9gEXniBxSPQiY"
Subject: Re: [Qemu-devel] [PATCH v3 04/39] qcow2: Remove BDS parameter from
 qcow2_cache_get_table_idx()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xcgblj96pR7yzt7RVg4q9gEXniBxSPQiY
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <90afb45b-3456-cdca-8b1d-6b5dc1d10acd@redhat.com>
Subject: Re: [PATCH v3 04/39] qcow2: Remove BDS parameter from
 qcow2_cache_get_table_idx()
References: <cover.1516978645.git.berto@igalia.com>
 <bf5887438d46eec45729adb4d05ee06e58b8d40b.1516978645.git.berto@igalia.com>
In-Reply-To: <bf5887438d46eec45729adb4d05ee06e58b8d40b.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to get the
> cache table size (since it was equal to the cluster size). This is no
> longer necessary so this parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cache.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Xcgblj96pR7yzt7RVg4q9gEXniBxSPQiY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyGJkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANRUH/2pcOlwPFbOQfUgupIzHvPHmHhsz15uF
Gmyc2LMqtPCz6x/LSmKPp9foo8/6x5OoiTNumUok0Hz86CAw9mGqMTck6ahVdurN
iZ/X8KmS3XA6lTEiyM+NkNH4+s/YUbqwRY4O7m8JHUP/ADxsdJEnc1LWXiV2m8j3
pMYujnt3MNupSuGD0tE0IsGpodggNmmIcEfkZuNVjKHQiZhOg/8OBlK8peXfM8tk
z/fM6OqYDLpDPHTu7+SdC4ZLVw21ATwq1dYFe2MpOxtfl14M5a5GEDqZE9UEw48j
DOKoxq40GzHsvc+bhyK4SMw9iu+E0aTZnHlomyAAIfpZFIEM3ziPnaM=
=P6lV
-----END PGP SIGNATURE-----

--Xcgblj96pR7yzt7RVg4q9gEXniBxSPQiY--
