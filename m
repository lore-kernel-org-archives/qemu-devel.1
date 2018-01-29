Received: from eggs.gnu.org ([2001:4830:134:3::10]:48536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egF0J-00036b-5J
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egF0I-00041e-E0
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:22:07 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
Date: Mon, 29 Jan 2018 20:21:54 +0100
MIME-Version: 1.0
In-Reply-To: <1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fhj2B7b1a7VqdWcTZZtIpQ9f2O0lguBcH"
Subject: Re: [Qemu-devel] [PATCH v7 1/9] mirror: inherit supported
 write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fhj2B7b1a7VqdWcTZZtIpQ9f2O0lguBcH
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
Subject: Re: [PATCH v7 1/9] mirror: inherit supported write/zero flags
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-18 18:48, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/mirror.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index c9badc1..d18ec65 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1064,6 +1064,11 @@ static void bdrv_mirror_top_refresh_filename(Blo=
ckDriverState *bs, QDict *opts)
>      bdrv_refresh_filename(bs->backing->bs);
>      pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
>              bs->backing->bs->filename);
> +    bs->supported_write_flags =3D BDRV_REQ_FUA &
> +        bs->backing->bs->supported_write_flags;
> +    bs->supported_zero_flags =3D
> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
> +        bs->backing->bs->supported_zero_flags;
>  }
> =20
>  static void bdrv_mirror_top_close(BlockDriverState *bs)

Fundamentally OK, but why is this in *_refresh_filename()?

Max


--fhj2B7b1a7VqdWcTZZtIpQ9f2O0lguBcH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvdFISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Am0QH/iZGmq+92xGScFe1XET+WRW6XX+5z+A4
sFxWWSvPIWkPiGSb7Ue2rk/Swztkvzy9ljofiVBuA6YjO9/Akwu0LTMpnvYLBjUT
si/SjiVS20LZXx6s926OMwnOdvT03AEfPb8QfHTmEMUBG6ToJZL6AYcBUZk6aud4
fMyST2bZ9bCDtXGQwnMCcq/NpYRIyW5uIAmPEF2+W9IM+Xg+CB9LXXAJUKvWtM5v
Ka+6kfa0tcE1bNVuhF1C1X03LyJ0GvoZj1qDzMSRi5HyVcRe7aSjwS+K3ufOC7t1
GxgOjeiRMYnE6cG4uzUEG4gwWfnvb3hkTyS58zBjlQHIt3x3yoKp/5A=
=iqX6
-----END PGP SIGNATURE-----

--fhj2B7b1a7VqdWcTZZtIpQ9f2O0lguBcH--
