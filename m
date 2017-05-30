Received: from eggs.gnu.org ([2001:4830:134:3::10]:56978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFoRC-0000Yt-EP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFoR9-0008Rp-9P
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:12:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFoR9-0008Rc-0X
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:12:19 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6d07598-2fa7-7a97-75aa-61138e748ad2@redhat.com>
Date: Tue, 30 May 2017 16:12:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1TAJ1qxKNkdFBG5l05c0pRKcQUnnF1omv"
Subject: Re: [Qemu-devel] [PATCH 07/19] nbd/server: nbd_negotiate: fix error
 path
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
--1TAJ1qxKNkdFBG5l05c0pRKcQUnnF1omv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <e6d07598-2fa7-7a97-75aa-61138e748ad2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/19] nbd/server: nbd_negotiate: fix error
 path
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Current code will return 0 on this write_sync fail, as rc is 0
> after successful nbd_negotiate_options. Fix this.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/nbd/server.c b/nbd/server.c
> index 3d4cd3d21c..984fad4bdb 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -607,7 +607,8 @@ static coroutine_fn int nbd_negotiate(NBDClient *cl=
ient)
>          stq_be_p(buf + 18, client->exp->size);
>          stw_be_p(buf + 26, client->exp->nbdflags | myflags);
>          len =3D client->no_zeroes ? 10 : sizeof(buf) - 18;
> -        if (write_sync(client->ioc, buf + 18, len, NULL) < 0) {
> +        rc =3D write_sync(client->ioc, buf + 18, len, NULL);
> +        if (rc < 0) {
>              LOG("write failed");
>              goto fail;
>          }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1TAJ1qxKNkdFBG5l05c0pRKcQUnnF1omv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLeAuAAoJEKeha0olJ0Nq9kkH/iHdMDSLz7kb/QNCAkj6lvrh
E0zZE/28C+KAs+fafbnLnOacoIaTtEEOmfvALVJI8lJGa8iFBpkJfM1lqJwb1Vvk
t/gDhAVmodfUgRa8U86MadC0VEh6snW0f7Mht0n8yQ1ZAt7IVD892V+xEoHj5yB3
4LyADxOF2HTAjTJwCDoafpARKswHBcid+rjf/zgi0fXX88piYRuRYM53Mixbu/pu
XlY/X76EIFMYE5434rJOeQbaUHWvB6bKnkYx9BJXeL3fFVsXmCdy8cnn77UBgXFX
fNIAi8iXu51Gbe4kQhMTUwCfCenXY9c1LyKHvbltozV0A7YAGkxFejn0jU+2yg4=
=C9Ze
-----END PGP SIGNATURE-----

--1TAJ1qxKNkdFBG5l05c0pRKcQUnnF1omv--
