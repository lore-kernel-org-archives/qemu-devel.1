Received: from eggs.gnu.org ([2001:4830:134:3::10]:50154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGYLi-0002bJ-1X
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGYLe-0004WF-Rx
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:13:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGYLe-0004Vv-IB
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:13:42 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-13-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <792dff03-de2c-8abb-9312-4699fd44eb65@redhat.com>
Date: Thu, 1 Jun 2017 17:13:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-13-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Mv8jJKGMCvFhoPTWrDq7ULxm2tw4t4fSr"
Subject: Re: [Qemu-devel] [PATCH 12/19] nbd/common: nbd_wr_syncv handle
 QIO_CHANNEL_ERR_EPIPE
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
--Mv8jJKGMCvFhoPTWrDq7ULxm2tw4t4fSr
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <792dff03-de2c-8abb-9312-4699fd44eb65@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/19] nbd/common: nbd_wr_syncv handle
 QIO_CHANNEL_ERR_EPIPE
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-13-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-13-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Return EPIPE in case of QIO_CHANNEL_ERR_EPIPE, we will need it to
> improve error path in nbd server.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I agree with Daniel's assessment that we probably aren't doing things
right in the previous patch, and therefore probably don't need this one.

>=20
> diff --git a/nbd/common.c b/nbd/common.c
> index e520aae741..88e0297fb2 100644
> --- a/nbd/common.c
> +++ b/nbd/common.c
> @@ -52,7 +52,7 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
>              continue;
>          }
>          if (len < 0) {
> -            done =3D -EIO;
> +            done =3D len =3D=3D QIO_CHANNEL_ERR_EPIPE ? -EPIPE : -EIO;=

>              goto cleanup;
>          }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Mv8jJKGMCvFhoPTWrDq7ULxm2tw4t4fSr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMJGTAAoJEKeha0olJ0NqoSAH/3K2Bh94KbvmV9GX08p5Ja+w
yiZe1sqczp0UYDcrxtsC8Rh6MdwQWSH7a1/Og6KKGvubbrFjgG766CO+jqCxNE8J
0QK2pwE5XIcxNX/FSTca3fEXQSGHsquvKhk3mxkwO3IRh7dtaS5sJrlq1Hk3SLDD
ptB+1wX3vHgNMstT/6ukrcE9CO9/uEqt75/UB2T3x8ZXKQRuq17RaerJWepV0nbD
tVCKT40vcv+p2l0wmfRsmZpUVFaDqKXuqGvJW5+4HGv2PT0WkTjEU7UB6mBnpl0c
Dt3NKE0osh7pcxm0iAYQu8y6O5NX3loQowcFYYnABD85CY859SN91Td+fm3AwzU=
=uO3/
-----END PGP SIGNATURE-----

--Mv8jJKGMCvFhoPTWrDq7ULxm2tw4t4fSr--
