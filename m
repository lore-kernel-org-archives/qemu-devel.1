Received: from eggs.gnu.org ([2001:4830:134:3::10]:47657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSv3-0003gk-Ks
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSv2-0006YL-MU
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:27:53 -0400
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-3-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <80d36f5d-9bff-4b35-c4a0-7a063da3d7da@redhat.com>
Date: Wed, 12 Jul 2017 20:27:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170711163748.17817-3-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Bh9VOEa0REKGU4empg1FrOQxqS6HV5V1C"
Subject: Re: [Qemu-devel] [PATCH v4 2/4] block: remove bdrv_media_changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bh9VOEa0REKGU4empg1FrOQxqS6HV5V1C
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block <qemu-block@nongnu.org>
Message-ID: <80d36f5d-9bff-4b35-c4a0-7a063da3d7da@redhat.com>
Subject: Re: [PATCH v4 2/4] block: remove bdrv_media_changed
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
 <20170711163748.17817-3-el13635@mail.ntua.gr>
In-Reply-To: <20170711163748.17817-3-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2017 11:37 AM, Manos Pitsidianakis wrote:
> This function is not used anywhere, so remove it.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c                   | 14 --------------
>  block/raw-format.c        |  6 ------
>  include/block/block.h     |  1 -
>  include/block/block_int.h |  1 -
>  4 files changed, 22 deletions(-)
>=20

> +++ b/block/raw-format.c
> @@ -346,11 +346,6 @@ static int raw_truncate(BlockDriverState *bs, int6=
4_t offset, Error **errp)
>      return bdrv_truncate(bs->file, offset, errp);
>  }
> =20
> -static int raw_media_changed(BlockDriverState *bs)
> -{
> -    return bdrv_media_changed(bs->file->bs);
> -}
> -

There's a merge conflict here if this lands after Max's pending block
pull request, but should be trivial to resolve.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Bh9VOEa0REKGU4empg1FrOQxqS6HV5V1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZsyOAAoJEKeha0olJ0NqgT8IAJUnodiTJvbHexzgQyYHVwSk
nvu0wKOY/2cGGEJW6YxylwJKrrjw2jNn2TZpoCufAtp3E+sCU+BGMc+X0+OuzdGK
R+CKvlwM+Z5HQRpmxscgb28J6sNDJDRVGvPC11/bifyUTUjk0mqpY9Us5riXSE+q
gHEvb0LuGNHSILCRq5I4qrXO5pf55X6t52AWjW4Yv7EoY2VerV6m38MlLNKSnAo8
MwOU70DDHFa4Dv3qSBDApHxES74Vyck1MTx34Og24KY/0y4pYkfAgxp0dopdF/Yl
ZubgTlsmjvXfHT5YATsyaVIE0UMmZU41C5hNysMi9GnVJZxtiXNIIrknizHX/JQ=
=1HDo
-----END PGP SIGNATURE-----

--Bh9VOEa0REKGU4empg1FrOQxqS6HV5V1C--
