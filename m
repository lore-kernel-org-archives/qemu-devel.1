Received: from eggs.gnu.org ([2001:4830:134:3::10]:59225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cckmy-0006kq-7p
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 22:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cckmx-0004hb-8j
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 22:25:24 -0500
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
	<20170203094018.15493-23-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e4a2e185-4da1-415a-ab3d-78150acab279@redhat.com>
Date: Sun, 12 Feb 2017 04:25:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170203094018.15493-23-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VBpvrGdPErOE4NnvaspnXagKK8vNsHHLj"
Subject: Re: [Qemu-devel] [PATCH 22/24] block/dirty-bitmap: add
 bdrv_remove_persistent_dirty_bitmap
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
--VBpvrGdPErOE4NnvaspnXagKK8vNsHHLj
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <e4a2e185-4da1-415a-ab3d-78150acab279@redhat.com>
Subject: Re: [PATCH 22/24] block/dirty-bitmap: add
 bdrv_remove_persistent_dirty_bitmap
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
 <20170203094018.15493-23-vsementsov@virtuozzo.com>
In-Reply-To: <20170203094018.15493-23-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 10:40, Vladimir Sementsov-Ogievskiy wrote:
> Interface for removing persistent bitmap from its storage.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 18 ++++++++++++++++++
>  include/block/block_int.h    |  3 +++
>  include/block/dirty-bitmap.h |  3 +++
>  3 files changed, 24 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--VBpvrGdPErOE4NnvaspnXagKK8vNsHHLj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlif1ZgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATFkH/RowSg9E2C99x63S1hFfeeMOn2OnGQrN
FEVbIEFjqchoWC+XHnhXXPicc1SVRD/trLoUk3t/3NuBOW/+50frXB3D+GUDm5jo
plXfxEztypYBPn53stnmfamv5J6guc8SUZjMfVxqrrVIT8TEuaxLLOylTI9IrhCm
fTJEjz2WMjE3pGJK8R5zR2sa99RgfyuFMfXZfG8wTCm3VEL6jEaGip9IcrtstCFd
RTD9AjB3xfvEEqhmMBhhRS2sMqZ0UzSuoA11hR0NSirunsOAEmOlErjEMM37IdqG
zoFGqExickh2WyuTqYfq1pYaiLhdYd5RS/yrLTto/85THhEYFy1B5OQ=
=wMib
-----END PGP SIGNATURE-----

--VBpvrGdPErOE4NnvaspnXagKK8vNsHHLj--
