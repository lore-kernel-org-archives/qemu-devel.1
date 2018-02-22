Received: from eggs.gnu.org ([2001:4830:134:3::10]:34233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0Tk-0007ep-0n
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0Sg-00008C-61
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:40:43 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-25-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <da395f56-16bf-8145-e6bb-a99be8fcb18d@redhat.com>
Date: Fri, 23 Feb 2018 00:37:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-25-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5WZGtWftTvIkf4ThXodHBQY5PJW3P9VSW"
Subject: Re: [Qemu-devel] [PATCH v2 24/36] rbd: Use qemu_rbd_connect() in
 qemu_rbd_do_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5WZGtWftTvIkf4ThXodHBQY5PJW3P9VSW
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <da395f56-16bf-8145-e6bb-a99be8fcb18d@redhat.com>
Subject: Re: [PATCH v2 24/36] rbd: Use qemu_rbd_connect() in
 qemu_rbd_do_create()
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-25-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-25-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> This is almost exactly the same code. The differences are that
> qemu_rbd_connect() supports BlockdevOptionsRbd.server and that the cach=
e
> mode is set explicitly.
>=20
> Supporting 'server' is a welcome new feature for image creation.
> Caching is disabled by default, so leave it that way.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 54 ++++++++++-------------------------------------------=
-
>  1 file changed, 10 insertions(+), 44 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index a34bf0be46..af8e186106 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c

[...]

> @@ -370,54 +369,21 @@ static int qemu_rbd_do_create(BlockdevCreateOptio=
ns *options,
>          obj_order =3D ctz32(objsize);
>      }
> =20
> -    ret =3D rados_create(&cluster, opts->location->user);
> +    ret =3D qemu_rbd_connect(&cluster, &io_ctx, opts->location, false,=
 keypairs,
> +                           NULL, errp);

s/NULL/password_secret/?

Max


--5WZGtWftTvIkf4ThXodHBQY5PJW3P9VSW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPVDcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AN30IAJE+EhnoYS2qor5+IAupCoYdZTogW8rV
d8U7ksOOkSq+IC3GKxns5XiJduibEIdfCNJoxBeW7w4MoB71FtBD9eYSK+gMLTpd
aISyva2R5cZyazOylPWtwIY8kUqFfEM5349IVYo3JhYzJk1yOMHjBLlsNEB4k03j
b5y5MxaU57BVOv9P2EhlyQPHtgAwQj8MYHBw3nmJvDypgLXIi8fzX+Bxhna7d9Av
H4fFFSQO3WgJIOSlrKgQ2oW707zPpA1Y90n7lR/8Vx4tbpO+K3q8I2p7W6ShqKNE
Saj0o+5CL7lY5+xeTwlNr9tujGBQsTXqvqBnyDE2NcBBieIa2zoMfX0=
=c+GE
-----END PGP SIGNATURE-----

--5WZGtWftTvIkf4ThXodHBQY5PJW3P9VSW--
