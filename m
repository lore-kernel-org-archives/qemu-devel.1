Received: from eggs.gnu.org ([2001:4830:134:3::10]:55666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQf9m-0006U9-T0
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQf9i-0000SO-TN
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:31:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQf9i-0000S2-KS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:31:10 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da968d43-65c4-a224-bef6-016bde63fff6@redhat.com>
Date: Thu, 29 Jun 2017 14:31:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vtaJ4w7xfXANBDngRbWBgoATTQQn8nvF0"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] nbd/server: add errp to
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
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vtaJ4w7xfXANBDngRbWBgoATTQQn8nvF0
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <da968d43-65c4-a224-bef6-016bde63fff6@redhat.com>
Subject: Re: [PATCH v2 3/6] nbd/server: add errp to nbd_send_reply()
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20

> @@ -1266,8 +1267,8 @@ reply:
>          local_err =3D NULL;
>      }
> =20
> -    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0) {
> -        error_setg(&local_err, "Failed to send reply");
> +    if (nbd_co_send_reply(req, &reply, reply_data_len, &local_err) < 0=
) {
> +        error_prepend(&local_err, "Failed to send reply: ");
>          goto disconnect;

Again, I'm not sure if the error_prepend is necessary vs. just directly
reusing the error from earlier in the stack.  But it's not enough to
stop me from giving:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vtaJ4w7xfXANBDngRbWBgoATTQQn8nvF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVVV6AAoJEKeha0olJ0NqfsAIAKiiH/ynrryViOCid7/rUGq+
0nkI+rUWUoMczSXeWk0r5ac6ZahLee25l7moDOEXH6BGQTeQtKjaGJRkPw418UKt
m8Gu0eyUcrDl2h6h+o8XoexKRt/0aB1gMpoPKlc50qnVwdV2qomyWQYwYQKLfFu6
dPnaXX604e+lmGWAWvRLRzweGjpcOIYwvEfHG0u0wjdVUGI0Q4DG0SUgb3/K0YWm
f2gijTT9k0RBzO62Ft2fLgJXp34edVfx6oaisBnriKZQbr0Xi3SJuFGQCGh61F0F
06YZAFygQ6IejSTZhiQGVtvZ4rI8IjfVOTF0F619y2foLGjV5FqFgpVHgUuddug=
=UQoY
-----END PGP SIGNATURE-----

--vtaJ4w7xfXANBDngRbWBgoATTQQn8nvF0--
