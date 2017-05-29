Received: from eggs.gnu.org ([2001:4830:134:3::10]:33421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFNMP-0001j2-T0
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFNMO-00059w-W4
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:17:37 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-11-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e3a6e2d5-b33c-9282-69a9-14ee2e8541d8@redhat.com>
Date: Mon, 29 May 2017 18:17:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170503122539.282182-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="atIooREXg91sED9f4D332dCpqC6OcfWX0"
Subject: Re: [Qemu-devel] [PATCH 10/25] qcow2: autoloading dirty bitmaps
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
--atIooREXg91sED9f4D332dCpqC6OcfWX0
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <e3a6e2d5-b33c-9282-69a9-14ee2e8541d8@redhat.com>
Subject: Re: [PATCH 10/25] qcow2: autoloading dirty bitmaps
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-11-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They=

> are loaded when the image is opened and become BdrvDirtyBitmaps for the=

> corresponding drive.
>=20
> Extra data in bitmaps is not supported for now.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 387 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |  17 ++-
>  block/qcow2.h        |   2 +
>  3 files changed, 404 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index b8e472b3e8..a2522d7ccf 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c

[...]

> @@ -437,3 +602,225 @@ out:

[...]

> +/* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
> +static void set_readonly_helper(gpointer bitmap, gpointer unused)
> +{
> +    bdrv_dirty_bitmap_set_readonly(bitmap);
> +}
> +
> +/* qcow2_load_autoloading_dirty_bitmaps()
> + * Return value is a hint for caller: true means that Qcow2 header was=
 updated.

"...that the Qcow2 header..."

> + * (false doesn't mean that header should be updated by caller, it jus=
t means

"...that the header...", "...by the caller, ..."

> + * that updating was not needed or image can not be written).

"...or the image cannot be written [to]"

> + * On fail the function returns false.

"On failure..."

With these fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--atIooREXg91sED9f4D332dCpqC6OcfWX0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLEmQEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQDH+
CACoba7Kh92Zq5wYwC1ZuY3kacqYqLJ3p8vHzMd9PMmlT69gUQq46urpoMF/v4P8
+i0/8JXzHRYIeCA0ATzULnQjCV6ZwyUfYKzwJgqInTX6c2AW7JvStOsZ4+giv8qN
731kjJHr586Qq6dDNHTczGWSFracZTlA6dxCo8CN7rvVt6psBC5Tsz3y1stSg13O
Vp+IwYFnhglq7Aoj6DDvzCKGZfWmvZuPzDFUZXcIufdcu5JgCJMxspCAYS5+Ai3d
XU2fOdiTYDWgcxgGYLv92Thm8psGg7MjMLIYF/Lht0kY4dmyVr9uEhJCvOa9sKmI
zu2wZUtbXvRLbh1haviFB6/2
=QjMZ
-----END PGP SIGNATURE-----

--atIooREXg91sED9f4D332dCpqC6OcfWX0--
