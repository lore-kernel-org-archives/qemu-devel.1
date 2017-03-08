Received: from eggs.gnu.org ([2001:4830:134:3::10]:57959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clgH3-0005tX-9m
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clgH2-0005bG-3f
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:25:21 -0500
References: <20170308181833.32110-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
Date: Wed, 8 Mar 2017 12:25:04 -0600
MIME-Version: 1.0
In-Reply-To: <20170308181833.32110-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8jFeDA7SmOGemAqW5HpfdMX7qwQ7sMLX5"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8jFeDA7SmOGemAqW5HpfdMX7qwQ7sMLX5
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>
Message-ID: <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
References: <20170308181833.32110-1-mreitz@redhat.com>
In-Reply-To: <20170308181833.32110-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/08/2017 12:18 PM, Max Reitz wrote:
> In order to use error_setg() and similar functions, we need to include
> qapi/error.h.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/archipelago.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

Does this mean our automated buildbots aren't building archipelago by
default?

>=20
> diff --git a/block/archipelago.c b/block/archipelago.c
> index 2449cfc702..01c4ff2f7d 100644
> --- a/block/archipelago.c
> +++ b/block/archipelago.c
> @@ -55,6 +55,7 @@
>  #include "block/block_int.h"
>  #include "qemu/error-report.h"
>  #include "qemu/thread.h"
> +#include "qapi/error.h"
>  #include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/qmp/qjson.h"
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8jFeDA7SmOGemAqW5HpfdMX7qwQ7sMLX5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYwEyAAAoJEKeha0olJ0NqlQgIAKCc/QGj+h16qUmMFyQATj3d
8W1TCaGNp7i9CKONp9FYMewzLh+nw/yq4hfrm6i07xmMGYkbIQ7unJ+yOeMvTAaq
uqVPXeX0usDbJKi4eKWU69CH84K2Ovn3iMn9VLqk6nDKDN4mKhOMZnZwJRrhltrO
PwsRcpe8O7C1aivhm05zc6f1Thn2C7nCNJSGOVbSZ5kB4eGLh/6hQ3LmToQUT7k/
jezdgc64fedW1yqcGlGV3/eukwTG0tH1/AtJng143Zh6FLLb8corFuoJRZEfnf6I
/UXfpR/6FVT/FyNEF7hPp9STvutnia/qOlSO+OJ0l+wnn0yQKb80sBmqtFdmHNY=
=ADp9
-----END PGP SIGNATURE-----

--8jFeDA7SmOGemAqW5HpfdMX7qwQ7sMLX5--
