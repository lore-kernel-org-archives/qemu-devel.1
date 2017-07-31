Received: from eggs.gnu.org ([2001:4830:134:3::10]:38253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcAP1-0002ov-MB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcAOw-0000op-U1
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:06:31 -0400
References: <20170731125111.28052-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c81b100-89af-83ba-069c-88b962b8a472@redhat.com>
Date: Mon, 31 Jul 2017 08:06:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170731125111.28052-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Bhni5eKL2WrT2LWJeFaijNew2CKeGelG5"
Subject: Re: [Qemu-devel] [PATCH for-2.10] block/qapi: Remove redundat NULL
 check to silence Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bhni5eKL2WrT2LWJeFaijNew2CKeGelG5
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <0c81b100-89af-83ba-069c-88b962b8a472@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] block/qapi: Remove redundat NULL
 check to silence Coverity
References: <20170731125111.28052-1-kwolf@redhat.com>
In-Reply-To: <20170731125111.28052-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 07:51 AM, Kevin Wolf wrote:
> When skipping implicit nodes in bdrv_block_device_info(), we know that
> bs0 is always non-NULL; initially, because it's taken from a BdrvChild
> and a BdrvChild never has a NULL bs, and after the first iteration
> because implicit nodes always have a backing file.
>=20
> Remove the NULL check and add an assertion that the implicit node does
> indeed have a backing file.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qapi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/qapi.c b/block/qapi.c
> index d2b18ee9df..5f1a71f5d2 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -145,8 +145,9 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBacken=
d *blk,
> =20
>          /* Skip automatically inserted nodes that the user isn't aware=
 of for
>           * query-block (blk !=3D NULL), but not for query-named-block-=
nodes */
> -        while (blk && bs0 && bs0->drv && bs0->implicit) {
> +        while (blk && bs0->drv && bs0->implicit) {
>              bs0 =3D backing_bs(bs0);
> +            assert(bs0);
>          }
>      }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Bhni5eKL2WrT2LWJeFaijNew2CKeGelG5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/K0oACgkQp6FrSiUn
Q2oO4ggAq7efmSDBZki8aqHJ+DhqFGgqhnUZ83FvHxzjUMkpWwgFpRvKSHRGEVfa
cYM2+fjZTR4gfqfLXuYupgNNlidOLjqcGf8nk7Yu7qmhz5CrBH1llqBr47dj6Bkw
WPz1zmFuld/wsENitAfptekxm7Qq9N61po7cYlL/QT106jPME7z/c7RlHbxl6uon
6Kr0KwmxE8PMfpZkryDSzbkmkqw3EFn+xZRqJC4VHknK3piu3N48GprxvZS06oTT
yj9Aus6lhzjCoZ89y8mSMLsiuA+DCwXsXWN+FWcca/IX9FJHUF0VS6jtwrxZ7h3U
Xo4dnMSGGsZ1/iiVvvBD/Q9/yYamvw==
=fbaR
-----END PGP SIGNATURE-----

--Bhni5eKL2WrT2LWJeFaijNew2CKeGelG5--
