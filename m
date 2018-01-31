Received: from eggs.gnu.org ([2001:4830:134:3::10]:58213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egx6s-0002cH-F4
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egx6r-00083Q-Gy
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:27:50 -0500
References: <20180118103143.11780-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <23d13ff3-adfb-05ee-e09a-6ba072f1ff76@redhat.com>
Date: Wed, 31 Jan 2018 19:27:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180118103143.11780-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9kJAtokKuiUCCViANGTGFtLIyNRBm60dd"
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9kJAtokKuiUCCViANGTGFtLIyNRBm60dd
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <23d13ff3-adfb-05ee-e09a-6ba072f1ff76@redhat.com>
Subject: Re: [PATCH] block: implement the bdrv_reopen_prepare helper for LUKS
 driver
References: <20180118103143.11780-1-berrange@redhat.com>
In-Reply-To: <20180118103143.11780-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-18 11:31, Daniel P. Berrange wrote:
> If the bdrv_reopen_prepare helper isn't provided, the qemu-img commit
> command fails to re-open the base layer after committing changes into
> it. Provide a no-op implementation for the LUKS driver, since there
> is not any custom work that needs doing to re-open it.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 7 +++++++
>  1 file changed, 7 insertions(+)
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
> +    return 0;
> +}

Unfortunately I have to admit I'm not quite an expert on reopen
myself...  But generally it is used to change options, so in theory one
could provide a new key-secret here.  It's up to you whether you want to
support that or not (with this implementation the user will get an error
when they want to change the key-secret).

Apart from that, I think a no-op should be OK.

Max

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



--9kJAtokKuiUCCViANGTGFtLIyNRBm60dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyCpoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADowH+gKq1PKu9MUp5dzfHnZAQjgMK8c71hv/
UO4stX5APP4ye/UGTtjrRw6V116BRcAG132mAqv5Q/DbdqBH5yNE76oeFCq8OJz1
8dVSkmBO+bxUOxxAXQgzHEyr8cEDia1KsoNBoXQVwHXOkKieEmD3IbFwk9l8jOW9
UCWbKwAoyWzdZhT1QXxdRAX1vJEo2z3eEEync6I4I7sGgwVORwrTOvlvXQSCUW4W
NgcLYsRP8tOWa9E6WELCt9Q9/C/eug4bWStLLai+vjMeQab6u2PnzmyYvEu7xsmd
yLdf5mKGICLZStAlu88qbETuPeoFWQcnXaWlJDwxH7iOZCDRVNtTSkw=
=iwRB
-----END PGP SIGNATURE-----

--9kJAtokKuiUCCViANGTGFtLIyNRBm60dd--
