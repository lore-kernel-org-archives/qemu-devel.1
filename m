Received: from eggs.gnu.org ([209.51.188.92]:51047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjni0-0005uv-7F
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjnho-0000Jp-38
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:06:22 -0500
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec72c055-4d91-8789-535f-bdc0548aef66@redhat.com>
Date: Wed, 16 Jan 2019 10:05:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180731173033.75467-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RsColzTw22Wm1xhrEDo2VzHpy8G8AtHMQ"
Subject: Re: [Qemu-devel] [PATCH v4 05/10] block/nbd-client: don't check ioc
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
--RsColzTw22Wm1xhrEDo2VzHpy8G8AtHMQ
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Message-ID: <ec72c055-4d91-8789-535f-bdc0548aef66@redhat.com>
Subject: Re: [PATCH v4 05/10] block/nbd-client: don't check ioc
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
 <20180731173033.75467-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/31/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> We have several paranoiac checks for ioc !=3D NULL. But ioc may become

s/paranoiac/paranoid/ sounds nicer, even if both forms are valid words.

> NULL only on close, which should not happen during requests handling.
> Also, we check ioc only sometimes, not after each yield, which is
> inconsistent. Let's drop these checks. However, for safety, lets leave

s/lets/let's/

> asserts instead.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--RsColzTw22Wm1xhrEDo2VzHpy8G8AtHMQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/Vl0ACgkQp6FrSiUn
Q2qpHwf+Om2qNq6sblPYowUTZqUNgtuZ2wAbEBQjnp5NnJP8ZtTxYfYqtZM5UU4S
Z51h86yxdWQHQoURCAqCDg2SEO82tNYIrn6oiyRpu+My7GUTSEafvXJg1cgZZocU
KQlpf9xm1bnMhANIqEpSKzjwXndPZ1G8suZAh6w374CvdtUGvp/yQhPMmWUGbaJ6
YcmD2O9aZFcr8+j3npLZa86Xg00pcMvUbEhOVM24xjxNJNi3f3ii95sdXhi6S2qQ
ImWIz2XehvubJqIaCBzRX44MH7B9BSeLfCfZrUVuXUoxdkKdR8HHBM4nNH3oPMW0
WTxyVaokWLK3NyCGmIIVrFv4kmRADQ==
=O0ai
-----END PGP SIGNATURE-----

--RsColzTw22Wm1xhrEDo2VzHpy8G8AtHMQ--
