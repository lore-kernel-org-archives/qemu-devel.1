Received: from eggs.gnu.org ([209.51.188.92]:33602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghgDY-0000Np-GG
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghgDX-0002gN-HM
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:42:16 -0500
References: <20190110191901.5082-1-eblake@redhat.com>
	<20190110191901.5082-4-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <81f7d9fa-93ad-ccaa-b85c-466274ae79e2@redhat.com>
Date: Thu, 10 Jan 2019 13:42:09 -0600
MIME-Version: 1.0
In-Reply-To: <20190110191901.5082-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BhSAloGok5RvicsJ8ZjjQ7T8bok3qZ6sp"
Subject: Re: [Qemu-devel] [PATCH v3 3/6] Revert "vdi: Use a literal number
 of bytes for DEFAULT_CLUSTER_SIZE"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, lbloch@janustech.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BhSAloGok5RvicsJ8ZjjQ7T8bok3qZ6sp
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 armbru@redhat.com, Max Reitz <mreitz@redhat.com>, lbloch@janustech.com
Message-ID: <81f7d9fa-93ad-ccaa-b85c-466274ae79e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/6] Revert "vdi: Use a literal number of
 bytes for DEFAULT_CLUSTER_SIZE"
References: <20190110191901.5082-1-eblake@redhat.com>
 <20190110191901.5082-4-eblake@redhat.com>
In-Reply-To: <20190110191901.5082-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 1:18 PM, Eric Blake wrote:
> This reverts commit 3dd5b8f4718c6ca1eadb16dd67a8cad76455ddb0.
>=20
> Now that we can express QemuOpts values as an integer, we don't have
> to be careful about how we spell our macro.

Signed-off-by: Eric Blake <eblake@redhat.com>

> ---
>  block/vdi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/vdi.c b/block/vdi.c
> index 65659c9b179..180a45b70f6 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -85,7 +85,7 @@
>  #define BLOCK_OPT_STATIC "static"
>=20
>  #define SECTOR_SIZE 512
> -#define DEFAULT_CLUSTER_SIZE S_1MiB
> +#define DEFAULT_CLUSTER_SIZE (1 * MiB)
>=20
>  #if defined(CONFIG_VDI_DEBUG)
>  #define VDI_DEBUG 1
> @@ -432,7 +432,7 @@ static int vdi_open(BlockDriverState *bs, QDict *op=
tions, int flags,
>          goto fail;
>      } else if (header.block_size !=3D DEFAULT_CLUSTER_SIZE) {
>          error_setg(errp, "unsupported VDI image (block size %" PRIu32
> -                         " is not %" PRIu32 ")",
> +                         " is not %" PRIu64 ")",
>                     header.block_size, DEFAULT_CLUSTER_SIZE);
>          ret =3D -ENOTSUP;
>          goto fail;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--BhSAloGok5RvicsJ8ZjjQ7T8bok3qZ6sp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw3oBEACgkQp6FrSiUn
Q2qxYwgArjwhGyK9DC8ijxkWdNxAxbLS4qeOGcrjuoF6P2cQpq+fNjAObBeXLmUU
ao3556/Tgql9HLB1HwKFf6QhG0XmfYahqYrccqw4c7xfodE0xxpfqk7VeqOZ/MM9
+xbTBrh46dI9Lf5pEtyFSBAJPPmGuxfHC+8jQuigFDHlmW1u/bTv3I1xe5tbLIkP
ro8NzpkRc0IDrX29qUsearFl7xuOYstCztosXuhoGXN1ByJTS9n2nbNlzpalaF4h
w0bHwhGe9jf7tWybO8V6iTM/rTBLBpnUZEbEJAgkR3E7ku7pvMkpIywQC9WF1Slj
yh65Al9YXTgfbnKD55OA+OCIYO52vw==
=9MOc
-----END PGP SIGNATURE-----

--BhSAloGok5RvicsJ8ZjjQ7T8bok3qZ6sp--
