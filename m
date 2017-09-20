Received: from eggs.gnu.org ([2001:4830:134:3::10]:39360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duh6E-0007XF-Qg
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duh6D-0008Oc-Sa
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:39:42 -0400
References: <20170920124507.18841-1-vsementsov@virtuozzo.com>
	<20170920124507.18841-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66ae5c45-476f-2fcc-4014-6b575d41fc89@redhat.com>
Date: Wed, 20 Sep 2017 10:39:33 -0500
MIME-Version: 1.0
In-Reply-To: <20170920124507.18841-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3rJDA7tv1EQCaftgqhnf7qrhIGOqx0BVj"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] block/nbd-client: simplify check in
 nbd_co_receive_reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3rJDA7tv1EQCaftgqhnf7qrhIGOqx0BVj
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <66ae5c45-476f-2fcc-4014-6b575d41fc89@redhat.com>
Subject: Re: [PATCH v3 2/3] block/nbd-client: simplify check in
 nbd_co_receive_reply
References: <20170920124507.18841-1-vsementsov@virtuozzo.com>
 <20170920124507.18841-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170920124507.18841-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 07:45 AM, Vladimir Sementsov-Ogievskiy wrote:
> If we are woken up from while() loop in nbd_read_reply_entry
> handles must be equal. If we are woken up from
> nbd_recv_coroutines_wake_all s->quit must be true, so we do
> not need checking handles equality.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index acd8e5d007..486bfff9f7 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -189,9 +189,10 @@ static int nbd_co_receive_reply(NBDClientSession *=
s,
>      s->requests[i].receiving =3D true;
>      qemu_coroutine_yield();
>      s->requests[i].receiving =3D false;
> -    if (s->reply.handle !=3D request->handle || !s->ioc || s->quit) {
> +    if (!s->ioc || s->quit) {
>          ret =3D -EIO;
>      } else {
> +        assert(s->reply.handle =3D=3D request->handle);
>          ret =3D -s->reply.error;
>          if (qiov && s->reply.error =3D=3D 0) {
>              assert(request->len =3D=3D iov_size(qiov->iov, qiov->niov)=
);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3rJDA7tv1EQCaftgqhnf7qrhIGOqx0BVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCi7UACgkQp6FrSiUn
Q2qOJgf/XtCsfG/m1kkNlj6Y23aZFaJvPFZvAqartOfFR7iOYOB3DU/Dxfs72KJI
u+fnAhtK+Pm2AGxOgAcVggq5mKgfHBAcp31SApr28ZYzwZunf072GNNLLz9ayKB6
K0GE3doCBYiQwfC3stiGw3GE1DlLZ6V5pixoVJRFqK26/dTbIEhxpSqUgxwQjkgx
1yiCpw25bu3FmRL2EjdnOQC0CKKcOFBEZ42ZjBhs+QX+lbP0zVlkGD+oMb0idL6V
2FZ51MwURTq6jF1U2MQgMNzkZb01D3XQ9q9qTuOxnt+8Y7d8ra5y8StrKH1iuAd4
zyEYiloRH3LC+B6UlUOwHWh65ySqKg==
=800m
-----END PGP SIGNATURE-----

--3rJDA7tv1EQCaftgqhnf7qrhIGOqx0BVj--
