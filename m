Received: from eggs.gnu.org ([2001:4830:134:3::10]:32949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecGDw-0004vn-EK
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecGDv-0001ss-Eh
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:51:44 -0500
References: <20180118103143.11780-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11124de8-ece3-cad5-7e43-0b10ce5c097d@redhat.com>
Date: Thu, 18 Jan 2018 13:51:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180118103143.11780-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QpXLe7yLppc898ayvJYG3H9Ac3ioU8ECN"
Subject: Re: [Qemu-devel] [PATCH] block: implement the bdrv_reopen_prepare
 helper for LUKS driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QpXLe7yLppc898ayvJYG3H9Ac3ioU8ECN
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <11124de8-ece3-cad5-7e43-0b10ce5c097d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: implement the bdrv_reopen_prepare
 helper for LUKS driver
References: <20180118103143.11780-1-berrange@redhat.com>
In-Reply-To: <20180118103143.11780-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 04:31 AM, Daniel P. Berrange wrote:
> If the bdrv_reopen_prepare helper isn't provided, the qemu-img commit
> command fails to re-open the base layer after committing changes into
> it. Provide a no-op implementation for the LUKS driver, since there
> is not any custom work that needs doing to re-open it.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 7 +++++++
>  1 file changed, 7 insertions(+)

I'm hoping another block-layer expert chimes in, as I'm not quite sure
what the full reopen rules are; but the idea makes sense to me.

>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 60ddf8623e..bb9a8f5376 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -382,6 +382,12 @@ static void block_crypto_close(BlockDriverState *b=
s)
>      qcrypto_block_free(crypto->block);
>  }
> =20
> +static int block_crypto_reopen_prepare(BDRVReopenState *state,
> +                                       BlockReopenQueue *queue, Error =
**errp)
> +{
> +    /* nothing needs checking */

Are we sure that even changes such as moving from read-only to
read-write need no checking?

> +    return 0;
> +}
> =20
>  /*
>   * 1 MB bounce buffer gives good performance / memory tradeoff
> @@ -620,6 +626,7 @@ BlockDriver bdrv_crypto_luks =3D {
>      .bdrv_truncate      =3D block_crypto_truncate,
>      .create_opts        =3D &block_crypto_create_opts_luks,
> =20
> +    .bdrv_reopen_prepare =3D block_crypto_reopen_prepare,
>      .bdrv_refresh_limits =3D block_crypto_refresh_limits,
>      .bdrv_co_preadv     =3D block_crypto_co_preadv,
>      .bdrv_co_pwritev    =3D block_crypto_co_pwritev,
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QpXLe7yLppc898ayvJYG3H9Ac3ioU8ECN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpg+sgACgkQp6FrSiUn
Q2odPwgAmG76IEF5Vwq98eTGOw+C2bP6Vub4kqfI7GrPfDbeBAg0laADJ79qVyK5
HGf3uMYhw7Z/b20zpllwxLIyq6FfaRuVYcWXt6eDgZuEcduKsXTz5PCMAJIkE8r8
DnLe6ynLxageVmIGA5QGqGTUOAwt6blziJPCT4zei7uJqeag60n2q8gsxGROi97l
tncZajQQykdL2sInCyxOD3MVUBku5/p5YwL6wM20ApYp9nOiUrZcPiJSFcJIEMmf
qohirIlBGoRuP4jcUPGLBLjSfT4FqFfoKkG02cEEIQ/5oqCRkqSzmCN81eROQzYa
oIxMWpBmiVi9dkTWq7eRMDpmP8dHMQ==
=O2NB
-----END PGP SIGNATURE-----

--QpXLe7yLppc898ayvJYG3H9Ac3ioU8ECN--
