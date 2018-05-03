Received: from eggs.gnu.org ([2001:4830:134:3::10]:47871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEDRW-0000VG-B1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEDRV-0000MI-Ik
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:38 -0400
Date: Thu, 3 May 2018 11:28:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180503102819.GE5301@stefanha-x1.localdomain>
References: <20180418030424.28980-1-famz@redhat.com>
	<20180418030424.28980-7-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <20180418030424.28980-7-famz@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 6/7] block-backend: Add
 blk_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 11:04:23AM +0800, Fam Zheng wrote:
> It's a BlockBackend wrapper of the BDS interface.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c          | 9 +++++++++
>  include/sysemu/block-backend.h | 4 ++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 681b240b12..2a984b1864 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2217,3 +2217,12 @@ void blk_unregister_buf(BlockBackend *blk, void *h=
ost)
>  {
>      bdrv_unregister_buf(blk_bs(blk), host);
>  }
> +
> +int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
> +                                   BlockBackend *blk_out, int64_t off_ou=
t,
> +                                   int bytes, BdrvRequestFlags flags)
> +{
> +    return bdrv_co_copy_range(blk_in->root, off_in,
> +                              blk_out->root, off_out,
> +                              bytes, flags);
> +}

What happens if either ->root field is NULL?

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa6uRDAAoJEJykq7OBq3PIf78IAI8t2ZPTawTPApwnx9yWEFw0
bTKtEWaKudnErpTIL3PVD9p72VcBeUNyVwaGp/AfG5z6h0hmlTt8aifbOF7atAxa
eRjsjL7Yx7lIyGr+RCLFl62sIcBy7ArygrjwCMT3U1wCvPQEMnFgaK1nILyRPP7+
nvqbgnB+KtyCROPnbwubzj0/n9Zs0TmgPl91BhP2zfXg6xesCDHBbszl9/M/gLod
IMqLSWidn5T2NKJt6H+A1CIJ3sdRHgQFfy5radsDGp6YNap+o/Ae/FafhAn10X/a
vdKIzi6njYy81bTY4rJwS6XXUHixltylkIAmj14KHpES0pFfOHfWhtmb5+k8dnM=
=cWjl
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
