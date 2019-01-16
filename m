Received: from eggs.gnu.org ([209.51.188.92]:33120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjoAY-0007C9-GH
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjoAW-0005ty-Ii
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:35:58 -0500
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e91a280-95af-52e2-2673-29a1544cb9ff@redhat.com>
Date: Wed, 16 Jan 2019 10:35:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180731173033.75467-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i5MWNhDYX7FK9O8fqchjD1AegZJEXZggm"
Subject: Re: [Qemu-devel] [PATCH v4 07/10] block/nbd-client: rename
 read_reply_co to connection_co
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i5MWNhDYX7FK9O8fqchjD1AegZJEXZggm
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Message-ID: <3e91a280-95af-52e2-2673-29a1544cb9ff@redhat.com>
Subject: Re: [PATCH v4 07/10] block/nbd-client: rename read_reply_co to
 connection_co
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
 <20180731173033.75467-8-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/31/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> This coroutine will serve nbd reconnects, so, rename it to be something=

> more generic.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.h |  4 ++--
>  block/nbd-client.c | 24 ++++++++++++------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>=20

> @@ -503,7 +503,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk=
(
>  }
> =20
>  /* nbd_co_receive_one_chunk
> - * Read reply, wake up read_reply_co and set s->quit if needed.
> + * Read reply, wake up connection_co and set s->quit if needed.

Comment is stale; should have been fixed in 6/10 to mention s->state now
that s->quit does not exist.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--i5MWNhDYX7FK9O8fqchjD1AegZJEXZggm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/XV8ACgkQp6FrSiUn
Q2okKAf+LrGxpUb+WS+k/3WOjsiP22oVaCbvB1XMRgZYNzkKWNYzuJWSP0CFaWk8
1Ong8UGLfMhK46Wb+dJuiK56Gt0BDtA7G3E3m6e6NPwlzvVpnM3yjOXL9IdnPtsQ
CgMmiAP4yiUyIGnkTSWuarcVokYZPxza0Y7zSQi6dLefTQHu6sVgzA4LhMXtFy4v
rYnW3yzfmRWaLqCPnGC8NdBAal1D6m5YFgtpV2mc02udVHwM1YRa1/hh0tUkz48m
sTQYGKVLk4kP7mz/IfIFpBMtDnwT3vNPsMmFR+bC3Ipu68FZt+ZuwDW7cNTljeXC
NK6pTwchzd284u1YDa66XQ0KA6lkgA==
=j9hd
-----END PGP SIGNATURE-----

--i5MWNhDYX7FK9O8fqchjD1AegZJEXZggm--
