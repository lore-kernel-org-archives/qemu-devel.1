Received: from eggs.gnu.org ([2001:4830:134:3::10]:44778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHGw7-0001go-48
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 17:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHGw3-00007R-07
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 17:50:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHGw2-00006J-N4
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 17:50:14 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-17-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3033e9e6-b190-5255-979c-5646da5eb4bd@redhat.com>
Date: Sat, 3 Jun 2017 16:50:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-17-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ufSc3MAVQE1hDKjNoUIuuWGKnARND1gt3"
Subject: Re: [Qemu-devel] [PATCH 16/19] nbd/server: add errp to
 nbd_send_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ufSc3MAVQE1hDKjNoUIuuWGKnARND1gt3
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <3033e9e6-b190-5255-979c-5646da5eb4bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/19] nbd/server: add errp to
 nbd_send_reply()
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-17-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-17-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20

> =20
> -    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0) {
> -        error_setg(&local_err, "Failed to send reply");
> +    if (nbd_co_send_reply(req, &reply, reply_data_len, &local_err) < 0=
) {
> +        error_prepend(&local_err, "Failed to send reply");

In the previous patch, you had a lot of conversions from LOG("message")
to error_prepend(..., "message: ") (note the addition of the ': '
suffix).  Is this addition of error_prepend going to come out right?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ufSc3MAVQE1hDKjNoUIuuWGKnARND1gt3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMy8UAAoJEKeha0olJ0NqnkgH/i6TN8o2x873CJBrbgG/Bki8
4Rv7aQRADdbUIk154L7ptgDfQ8AFYrJO59gJrGUTI0G/NNEDHZ5zRnwsE9v/2eDf
SkMhfIoVvJAfnhVgc2zafaVsh0nKVZosQ4SRncCpJrsNyKzDtIhoFWgTMhobKBRD
qfxg1y2QvN3Sy0am3ph9g7/k6WzuyDUz0yZvYjo8UiTZGCZngow5kST3vWRhYOAh
fjyCH6jldJvoKjf14cziheH4GEcoz5uCkOump8lNGvWE0GM2e9b0JUxaJFbOMDtl
jmXXzqD3lL4+/KqY0jerlkOsb06u0OZ0ZdUJJ9asYWb5EgTiyb2s++1ftl5uAXg=
=f90/
-----END PGP SIGNATURE-----

--ufSc3MAVQE1hDKjNoUIuuWGKnARND1gt3--
