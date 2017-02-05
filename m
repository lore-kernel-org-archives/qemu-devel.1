Received: from eggs.gnu.org ([2001:4830:134:3::10]:56532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUj5-0004w0-AR
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUj4-0007j5-Jj
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:52:03 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-3-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c95f2df8-e6e1-03a7-81e4-8de398a0e841@redhat.com>
Date: Sun, 5 Feb 2017 22:51:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sGvsdLsj9f0E00wXQ9xf8hCoPE4jl4dlS"
Subject: Re: [Qemu-devel] [PATCH v12 02/16] block: Define BDRV_O_SHARE_RW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sGvsdLsj9f0E00wXQ9xf8hCoPE4jl4dlS
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <c95f2df8-e6e1-03a7-81e4-8de398a0e841@redhat.com>
Subject: Re: [PATCH v12 02/16] block: Define BDRV_O_SHARE_RW
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-3-famz@redhat.com>
In-Reply-To: <20170123123056.30383-3-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/block/block.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index 8b0dcda..243839d 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -97,6 +97,8 @@ typedef struct HDGeometry {
>                                        select an appropriate protocol d=
river,
>                                        ignoring the format layer */
>  #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
> +#define BDRV_O_SHARE_RW    0x20000 /* accept shared read-write from ot=
her users
> +                                      of the image */
> =20
>  #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--sGvsdLsj9f0E00wXQ9xf8hCoPE4jl4dlS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliXnnkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AtN4IAJ05ye724QND0B5qL/T4g5UgktEEFp25
TA3CC/860z5IWjHDeBL8zD3JfvaNcbQAHXQ5vzWI+oejPVBkwE2lg44GMBae5qlt
v5gjvtGl65dhbt6BxU4F6oFfnwjNSiE49bibohDxZ2fyWqUkc73stloTkUe6EGX2
koGQmPY1YdlHbvk/MzOBnk+FeZ7zd0vBCU5sVDF9GlljY6SGHnZAFVnSVdzGY292
pTuUQ/94n5w33wugN69jN5VvWv/5mTVZfTylwmYCL665Hq3l5l1UK1V7FMpqPUTQ
/UI7FooSnHWVBukcVBK+9Dh9ax8r7qOZyL86hHiujoikjdcUmxuAczU=
=2SJT
-----END PGP SIGNATURE-----

--sGvsdLsj9f0E00wXQ9xf8hCoPE4jl4dlS--
