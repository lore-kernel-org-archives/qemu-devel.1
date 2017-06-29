Received: from eggs.gnu.org ([2001:4830:134:3::10]:55898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQfAd-0006wl-Hu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQfAb-0000pJ-5l
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:32:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQfAa-0000oy-TJ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:32:05 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <852b0da5-6038-4605-5d6e-13e7453fa06d@redhat.com>
Date: Thu, 29 Jun 2017 14:32:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="63BQvpTbdpQjNFAWQW7rm765sfujOwkqF"
Subject: Re: [Qemu-devel] [PATCH v2 4/6] nbd/common: nbd_tls_handshake:
 remove extra TRACE
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
--63BQvpTbdpQjNFAWQW7rm765sfujOwkqF
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <852b0da5-6038-4605-5d6e-13e7453fa06d@redhat.com>
Subject: Re: [PATCH v2 4/6] nbd/common: nbd_tls_handshake: remove extra TRACE
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> Error is propagated to the caller, TRACE is not needed.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/nbd/common.c b/nbd/common.c
> index 6b5c1b7b02..4dab41e2c0 100644
> --- a/nbd/common.c
> +++ b/nbd/common.c
> @@ -97,9 +97,7 @@ void nbd_tls_handshake(QIOTask *task,
>  {
>      struct NBDTLSHandshakeData *data =3D opaque;
> =20
> -    if (qio_task_propagate_error(task, &data->error)) {
> -        TRACE("TLS failed %s", error_get_pretty(data->error));
> -    }
> +    qio_task_propagate_error(task, &data->error);
>      data->complete =3D true;
>      g_main_loop_quit(data->loop);
>  }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--63BQvpTbdpQjNFAWQW7rm765sfujOwkqF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVVWwAAoJEKeha0olJ0NqnksH/1VN56LN6lesY92AQW+cPNDZ
vw53U0xTszPQx9YwG7Nkop+l0CWoaRAT8UJQtuwJ18rtqSvdK+SSXMTa4Sk4Wz0p
k/jK2C3L6NicKKs1BazWStAP1rBXnqEAV30J0wRLyq8Ykml8nXZ9xy69Djxt6ho6
vzTg9Av05LThBjWuSqgDaVj2ksEsGFdxgCYyAAlX6mfbM8L+Z3JTjZWFfzHwK2c9
eDp2cdVhIfGzutCnCy4DeNbdfiqlkmhJyJ3jcx5P0Tu8xwk84zbojFlFWsUS6Upq
/XJWq6/sQTagXQp5+FCxedWFc5T10Cf+abZhjzqBiB8J+BBwZDPBiMV//HYClIY=
=zMc7
-----END PGP SIGNATURE-----

--63BQvpTbdpQjNFAWQW7rm765sfujOwkqF--
