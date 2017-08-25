Received: from eggs.gnu.org ([2001:4830:134:3::10]:39666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlJaN-0007l8-G0
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlJaM-00005s-1H
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:44:03 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a5cac2fe-5c00-e924-b38d-d34769df6a76@redhat.com>
Date: Fri, 25 Aug 2017 13:43:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VaQgEuORCSLbEIjxv7qonwW0JHLM3OXkq"
Subject: Re: [Qemu-devel] [PATCH 08/17] block/nbd-client: rename
 nbd_recv_coroutines_enter_all
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
--VaQgEuORCSLbEIjxv7qonwW0JHLM3OXkq
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <a5cac2fe-5c00-e924-b38d-d34769df6a76@redhat.com>
Subject: Re: [PATCH 08/17] block/nbd-client: rename
 nbd_recv_coroutines_enter_all
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Rename nbd_recv_coroutines_enter_all to nbd_recv_coroutines_wake_all,
> as it most probably just add all recv coroutines into co_queue_wakeup,
> not directly enter them.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index c9ade9b517..8ad2264a40 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -34,7 +34,7 @@
>  #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ ((uint64_t)(intptr_t)b=
s))
>  #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ ((uint64_t)(intptr_t)b=
s))
> =20
> -static void nbd_recv_coroutines_enter_all(NBDClientSession *s)
> +static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
>  {
>      int i;
> =20
> @@ -108,7 +108,7 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>      }
> =20
>      s->reply.handle =3D 0;
> -    nbd_recv_coroutines_enter_all(s);
> +    nbd_recv_coroutines_wake_all(s);
>      s->read_reply_co =3D NULL;
>  }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VaQgEuORCSLbEIjxv7qonwW0JHLM3OXkq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgb+gACgkQp6FrSiUn
Q2pPeggAj8DjBi5XeVooipcJAHB2To484jfv7GEC4+OBhIjBmpdoTcrsw1jUQx7m
gYemApgZbwHXip3UrqHR4+AtQ97VeobItgdru7SnSpnP0vvQ7BNk1MOeOwN0UXEh
6iYSIZXchiAxi3zrEU3cUIQyM8d+ZGvacgFol9AH9soHNewgR56sV+ixu9Ex86Vb
8LZj8lMbVh6VRzhGWOP0lORmsPESleVMhE2RiKd7XX6nB8YNdDYR11K1mWxoPDxY
hQn4IEP8tn5lcT2ij7QiVBq1wbzMW8oyjeuLaxhS9mU5MGzivsH12+9LiVs0Io+3
G4xOZJs8hSkNmcbBS1XS+Yka5ZT7YA==
=tpQd
-----END PGP SIGNATURE-----

--VaQgEuORCSLbEIjxv7qonwW0JHLM3OXkq--
