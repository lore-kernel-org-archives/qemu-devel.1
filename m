Received: from eggs.gnu.org ([2001:4830:134:3::10]:42209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duh8A-0000mt-Fx
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duh87-0002AF-RL
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:41:42 -0400
References: <20170920124507.18841-1-vsementsov@virtuozzo.com>
	<20170920124507.18841-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <34298944-031c-a19a-fd69-c28441a357a2@redhat.com>
Date: Wed, 20 Sep 2017 10:41:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170920124507.18841-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ia8C7UBGooRotXTwRpR68kjjqdUkwGqWu"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] block/nbd-client:
 nbd_co_send_request: fix return code
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
--Ia8C7UBGooRotXTwRpR68kjjqdUkwGqWu
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <34298944-031c-a19a-fd69-c28441a357a2@redhat.com>
Subject: Re: [PATCH v3 3/3] block/nbd-client: nbd_co_send_request: fix return
 code
References: <20170920124507.18841-1-vsementsov@virtuozzo.com>
 <20170920124507.18841-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170920124507.18841-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 07:45 AM, Vladimir Sementsov-Ogievskiy wrote:
> It's incorrect to return success rc >=3D 0 if we skip qio_channel_write=
v_all()
> call due to s->quit.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 486bfff9f7..9d1e154feb 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -161,6 +161,8 @@ static int nbd_co_send_request(BlockDriverState *bs=
,
>                                         NULL) < 0) {
>                  rc =3D -EIO;
>              }
> +        } else if (rc >=3D 0) {
> +            rc =3D -EIO;
>          }
>          qio_channel_set_cork(s->ioc, false);
>      } else {
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ia8C7UBGooRotXTwRpR68kjjqdUkwGqWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCjCYACgkQp6FrSiUn
Q2o5eAgAi7I9XvQQCOSLAukrd5wvDCsyoNqefcosSc5QROM4zQ+Gy6GEYIL+ACg9
lHf8UvtIpt6TGs5Bq1FULGpARjBnAexjVZR0TITRkmdhq3PNRups5u68AGmFpYx2
ePKCjL++W6nt3yDwYnw7r3Ofs4WCPBIcRB6i+8lsiD1RkshPn9tvjVKvQI2ZrXf1
WBJu4/hTNavnd2+J+wuwDVaR6oE09+FGegAPJ0Uue4eL8xtIFPp0tzYYnnp/kRwa
flC92tUwOFO/ntmxrBD2g35lEPbC8tzoIYSb9//FK9xwu3JkG8EAFrBzlvrX6gTL
NcnrEqLnibwQvOaXGDufZhjKriK9Kw==
=UfBQ
-----END PGP SIGNATURE-----

--Ia8C7UBGooRotXTwRpR68kjjqdUkwGqWu--
