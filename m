Received: from eggs.gnu.org ([2001:4830:134:3::10]:39729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coHCG-00077v-HY
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 18:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coHCF-0000IT-M1
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 18:15:08 -0400
References: <20170315212811.15937-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <023c6458-07bb-8582-5452-b7d3eea70bee@redhat.com>
Date: Wed, 15 Mar 2017 17:14:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170315212811.15937-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dRwDsP7feKNrH9A8MUK6VQFtfBDTxiHBe"
Subject: Re: [Qemu-devel] [PATCH] blockdev: fix bitmap clear undo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dRwDsP7feKNrH9A8MUK6VQFtfBDTxiHBe
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com
Message-ID: <023c6458-07bb-8582-5452-b7d3eea70bee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blockdev: fix bitmap clear undo
References: <20170315212811.15937-1-jsnow@redhat.com>
In-Reply-To: <20170315212811.15937-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 04:28 PM, John Snow wrote:
> Only undo the action if we actually prepared the action.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/blockdev.c b/blockdev.c
> index f1f49bd..c5b2c2c 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2047,7 +2047,9 @@ static void block_dirty_bitmap_clear_abort(BlkAct=
ionState *common)
>      BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDirtyBitmapState,
>                                               common, common);
> =20
> -    bdrv_undo_clear_dirty_bitmap(state->bitmap, state->backup);
> +    if (state->backup) {
> +        bdrv_undo_clear_dirty_bitmap(state->bitmap, state->backup);
> +    }
>  }
> =20
>  static void block_dirty_bitmap_clear_commit(BlkActionState *common)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dRwDsP7feKNrH9A8MUK6VQFtfBDTxiHBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYybzhAAoJEKeha0olJ0Nq5GcH/25GiGZ9zxjMKIAEN5BenNzM
I53it7mInN8KfZwF4qIrv/I/q3xbi+PIHib6hYhShjiMkIzfJGZN9+zVvnGyKw1F
KpFFtst39Vt8qCp6GQE5w2r2Nxc6/3ztpZPGKYMMEQU3T0rTP5UL5265K67clTvh
wU1DvtB9WuGBh0riCMCyf7howxNf4nMUCd+SEtCDOoJq14556qs49wLyLfcN+6I0
spa2WRMWec+8AvaRxvxvkzoRPuCT5q301CELYOBx2Vco7vrkj0Ok0FupuHxuhi8p
n2HxuLcQKDmMyi/sICsimmGTdfXXiABexhe+EvZXs1qmgz7ECDw6a5/mds1eQg8=
=+2ly
-----END PGP SIGNATURE-----

--dRwDsP7feKNrH9A8MUK6VQFtfBDTxiHBe--
