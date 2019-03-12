Received: from eggs.gnu.org ([209.51.188.92]:56674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3Y7N-0008MU-DQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3XsL-0004mJ-NL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:14:47 -0400
References: <20190311185147.52309-1-vsementsov@virtuozzo.com>
	<20190311185147.52309-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ac23c13-aef6-40ae-a99c-f6f1a6521318@redhat.com>
Date: Mon, 11 Mar 2019 22:09:35 -0500
MIME-Version: 1.0
In-Reply-To: <20190311185147.52309-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m15jCVEnuYQvYZAvRGcNvp0zWapki3kKH"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] block/qcow2-bitmap: Don't check
 size for IN_USE bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m15jCVEnuYQvYZAvRGcNvp0zWapki3kKH
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com
Message-ID: <2ac23c13-aef6-40ae-a99c-f6f1a6521318@redhat.com>
Subject: Re: [PATCH v2 2/4] block/qcow2-bitmap: Don't check size for IN_USE
 bitmap
References: <20190311185147.52309-1-vsementsov@virtuozzo.com>
 <20190311185147.52309-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190311185147.52309-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/19 1:51 PM, Vladimir Sementsov-Ogievskiy wrote:
> We are going to allow image resize when there are persistent bitmaps.
> It may lead to appearing of inconsistent bitmaps (IN_USE=3D1) with
> inconsistent size. But we still want to load them as inconsistent.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

> +    {
> +        /*
> +         * We've loaded valid bitmap (IN_USE not set) or we are going =
to store
> +         * valid bitmap. But allocated bitmap table size is not enough=
 to store
> +         * such bitmap.
> +         *
> +         * Note, that it's OK to have invalid bitmap with invalid size=
 during to

s/during/due/

> +         * bitmap was not correctly saved after image resize.

s/bitmap/a bitmap that/

> +         */
> +        return -EINVAL;
> +    }
> +
> +    return 0;
>  }
> =20
>  static inline void bitmap_directory_to_be(uint8_t *dir, size_t size)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--m15jCVEnuYQvYZAvRGcNvp0zWapki3kKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyHIu8ACgkQp6FrSiUn
Q2rxXggAnp0gu2G8Ps0Qr2VLIHKCxqfcWxibZbjDwXYoD2gljaJLI/N1Yj/yn5Qc
tEQGhX4OqVh09h5q+0wYta69hZ6y56pY9JWJdHujKc1ouWutZ1trhOCAOV5M7cK+
4be5xhfKA6jvT/zD49+GkjtgCLZU99OTzqX/AlF9haAhoEjnWIGJrYPsHjGVJosp
rEq1bcaGBN8zziwWqH8YDxaV4e1bEfvPxzJ1Yo/sODXkS9e3CVjDCVvGu0a/elet
KEId5HLu/doSnfupsmLR8MKnxNxtRdHOrt7EjTwhfcFzBf//XyXFn76VCizHnsZD
pVqW3eSdfZqA32DWQDmfQRJNr7EZTw==
=gS8X
-----END PGP SIGNATURE-----

--m15jCVEnuYQvYZAvRGcNvp0zWapki3kKH--
