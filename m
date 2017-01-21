Received: from eggs.gnu.org ([2001:4830:134:3::10]:46724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV1Q5-0006wq-VA
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV1Q4-0000Tv-CH
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:33:49 -0500
References: <20170119130759.28319-1-famz@redhat.com>
	<20170119130759.28319-2-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <90f814f3-20a5-9e4e-a045-76efbde8d455@redhat.com>
Date: Sat, 21 Jan 2017 20:33:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170119130759.28319-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nLgVUIUOLFKuMoDvmj6K0DBGIsMake2uO"
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: Tweak error message of
 bdrv_query_image_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nLgVUIUOLFKuMoDvmj6K0DBGIsMake2uO
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <90f814f3-20a5-9e4e-a045-76efbde8d455@redhat.com>
Subject: Re: [PATCH 1/2] qapi: Tweak error message of bdrv_query_image_info
References: <20170119130759.28319-1-famz@redhat.com>
 <20170119130759.28319-2-famz@redhat.com>
In-Reply-To: <20170119130759.28319-2-famz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 19.01.2017 14:07, Fam Zheng wrote:
> @bs doesn't always have a device name, such as when it comes from
> "qemu-img info". Report file name instead.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/qapi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Yes, I had a discussion with Kevin whether we should add some function
like bdrv_error_setg() which automatically prepends some description=E2=84=
=A2 of
a BDS (e.g. node name if user-set, or device name if meaningful, or
filename if not JSON). Spoiler: We probably should.

This is fine for now, though, because this function specifically deals
with images.

Max

> diff --git a/block/qapi.c b/block/qapi.c
> index a62e862..6329735 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -237,8 +237,8 @@ void bdrv_query_image_info(BlockDriverState *bs,
> =20
>      size =3D bdrv_getlength(bs);
>      if (size < 0) {
> -        error_setg_errno(errp, -size, "Can't get size of device '%s'",=

> -                         bdrv_get_device_name(bs));
> +        error_setg_errno(errp, -size, "Can't get image size '%s'",
> +                         bs->exact_filename);
>          goto out;
>      }
> =20
>=20



--nLgVUIUOLFKuMoDvmj6K0DBGIsMake2uO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliDt5ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A01EH/iWFWi96/28APTmFdqaSSJVFhPH0uLBq
dSlLScurEuRyocpT79i8DR4e62BdfCNVoOSE5gJHhzJwGl7C7rIFhN7zgh+2pcFB
NH+U/ZHyae8PVeW2MVNcdDSOpnhwKSqT/dLi7bXkaT03sclQNYky0iky+39enx4h
w1KStxo8Vq3z8+qOYY/ic1YxPL7xaEEph+tJefMrStjjGkbg2yYBvYbuXiLY9dP7
kuKwC8nYqz4ddDRJXNSzhUEZWQbGv7qxhCseHeSgi8ZIHtx9G9pruEyLAzdCzt1B
wDktp71erdu+hzwPy+sD+I8zcTkV0tfbQzkYjjlyYlOuJRhvq4Ex4kM=
=UV+2
-----END PGP SIGNATURE-----

--nLgVUIUOLFKuMoDvmj6K0DBGIsMake2uO--
