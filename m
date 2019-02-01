Received: from eggs.gnu.org ([209.51.188.92]:59061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpg9N-0006Nz-Um
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 16:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpg9M-0008Ev-Ua
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 16:15:01 -0500
References: <20190201130138.94525-1-vsementsov@virtuozzo.com>
	<20190201130138.94525-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5dafc1fa-111d-21ec-4762-55574e0da05c@redhat.com>
Date: Fri, 1 Feb 2019 15:14:55 -0600
MIME-Version: 1.0
In-Reply-To: <20190201130138.94525-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K4DRxjIrkMovW87aAHDogpGIZy2hxhWY2"
Subject: Re: [Qemu-devel] [PATCH v5 2/6] block/nbd: move connection code
 from block/nbd to block/nbd-client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K4DRxjIrkMovW87aAHDogpGIZy2hxhWY2
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com
Message-ID: <5dafc1fa-111d-21ec-4762-55574e0da05c@redhat.com>
Subject: Re: [PATCH v5 2/6] block/nbd: move connection code from block/nbd to
 block/nbd-client
References: <20190201130138.94525-1-vsementsov@virtuozzo.com>
 <20190201130138.94525-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190201130138.94525-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/1/19 7:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> Keep all connection code in one file, to be able to implement reconnect=

> in further patches.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20

> +static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr=
,
> +                                                  Error **errp)
> +{
> +    QIOChannelSocket *sioc;
> +    Error *local_err =3D NULL;
> +
> +    sioc =3D qio_channel_socket_new();
> +    qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
> +
> +    qio_channel_socket_connect_sync(sioc,
> +                                    saddr,
> +                                    &local_err);

I know it was code motion, but this fits on one line.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--K4DRxjIrkMovW87aAHDogpGIZy2hxhWY2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUts8ACgkQp6FrSiUn
Q2ozRQgAizQKgsmlvO7Ps6n9HC098QD0J6XxX9plwe7c4gnmbYbG6bP6Eza3ycgv
uG7PUfr9ltxbb1gBOaotHtbCNB3sXkeKswf7hpLxe+5XfbBCpNhOlpplLK521sSs
fM7yBXGus0b8/COgmWRJTe92WKf4WWfR7zc5f7J7ROxZGwzWTAE43o5tKQz/ou/V
WBb7/S8+ma/oegdJHcnNT/WKWZZjyutIErOgvrKGKmJ+p4ge+C9bn5UQBC9iZ7si
CvgMkYPxEk/GNSa6nxAzScbUAIHyl20iP1YVIRboFmRMlWOgQ9Bya/IBohCEjCk2
Ga2RlfpvfMLwNGWDhcVFDgq3C1x1BQ==
=1OiS
-----END PGP SIGNATURE-----

--K4DRxjIrkMovW87aAHDogpGIZy2hxhWY2--
