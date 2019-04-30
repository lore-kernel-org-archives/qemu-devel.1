Received: from eggs.gnu.org ([209.51.188.92]:37484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUBN-0005Bv-FJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUBK-0007zg-QF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:56:32 -0400
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd8e89d4-b9eb-da1f-5afa-52c3399cf7e5@redhat.com>
Date: Tue, 30 Apr 2019 09:56:20 -0500
MIME-Version: 1.0
In-Reply-To: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KM2JIEuPxsez22lvFycvPTytsdfFe6E95"
Subject: Re: [Qemu-devel] [PATCH] [RFC] qcow2: add compression type feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KM2JIEuPxsez22lvFycvPTytsdfFe6E95
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com
Message-ID: <dd8e89d4-b9eb-da1f-5afa-52c3399cf7e5@redhat.com>
Subject: Re: [PATCH] [RFC] qcow2: add compression type feature
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/5/19 3:08 AM, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type=

> feature into QCOW2 header that indicates that *all* compressed clusters=

> must be (de)compressed using a certain compression type.
>=20
> It is implied that the compression type is set on the image creation an=
d
> can be changed only later by image convertion, thus the only compressio=
n

s/convertion/conversion/

> algorithm is used for the image.
>=20
> The plan is to add support for ZSTD and then may be something more effe=
ctive
> in the future.
>=20
> ZSDT compression algorithm consumes 3-5 times less CPU power with a

s/ZSDT/ZSTD/

> comparable comression ratio with zlib. It would be wise to use it for

s/comression/compression/

> data compression f.e. for backups.
>=20
> The default compression is ZLIB.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c | 25 +++++++++++++++++++++++++
>  block/qcow2.h | 26 ++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8c91b92865..cb3d6cc1c0 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -73,6 +73,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
>  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
>  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
> +#define  QCOW2_EXT_MAGIC_COMPRESSION_TYPE 0x434D5052

This appears to be adding a new header extension magic number, but
didn't actually modify the specification. I'd expect this patch to touch
docs/interop/qcow2.txt before it can be considered complete.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KM2JIEuPxsez22lvFycvPTytsdfFe6E95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIYhQACgkQp6FrSiUn
Q2rmiggAqzP0L8JnSkfqyUKjaopPtS+F8W2w+RmzssZuAkJifk0yLOkVwtcW4EVH
St15IHLsPTlhyuYo89v4Jno530E0Lnu8EX9MAXhkisZ9aGT6k3T5b2GBQxQCmXyy
Enq+XHR5+ookoNywn51l+xDb5wZq87eKxJZOMi9jOmN+TE3HU9RwI66V6VMYw1tu
7vK9yUYIPGccbulSuSDcY3wBzfHC7HZem2nGymbj/Zc6/cVgB19PQiVR9+UTUXR2
hmqN0F+pqcBO5WxbGnuUOaL8LfG8XKKgpZRYmijQjOEeL6KkHULvzHJPH7Vg0970
1BtLk+5d3OosZkBwyXlNTSs6Ot990w==
=x0uO
-----END PGP SIGNATURE-----

--KM2JIEuPxsez22lvFycvPTytsdfFe6E95--
