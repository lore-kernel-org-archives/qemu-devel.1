Received: from eggs.gnu.org ([2001:4830:134:3::10]:49449)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ps@pks.im>)
	id 1dg3nm-00007p-32
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 02:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ps@pks.im>) id 1dg3ni-0006NV-6M
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 02:52:10 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ps@pks.im>) id 1dg3nh-0006Md-Uq
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 02:52:06 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id EBC9E20AD6
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 02:52:03 -0400 (EDT)
Received: from localhost (x4e34acf4.dyn.telefonica.de [78.52.172.244])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7A7592486E
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 02:52:03 -0400 (EDT)
Date: Fri, 11 Aug 2017 08:52:02 +0200
From: Patrick Steinhardt <ps@pks.im>
Message-ID: <20170811065202.GA1592@pks-xps>
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 09:20:45PM +0200, Patrick Steinhardt wrote:
> The function `v9fs_xattrcreate` makes use of the define `XATTR_SIZE_MAX`
> to reject attempts of creating xattrs with an invalid size, which is
> defined in <linux/limits.h>. On glibc-based systems, this header is
> indirectly included via <limits.h>, <bits/posix1_lim.h>,
> <bitts/local_lim.h>, but on other platforms this is not guaranteed due
> to not being part of the POSIX standard. One examples are systems based
> on musl libc, which do not include the <linux/limits.h> indirectly,
> which leads to `XATTR_SIZE_MAX` being undefined.
>=20
> Fix this error by directly include <linux/limits.h>. As the 9P fs code
> is being Linux-based either way, we can simply do so without breaking
> other platforms. This enables building 9pfs on musl-based systems.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  hw/9pfs/9p.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 96d2683348..48cd558e96 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -13,6 +13,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include <glib/gprintf.h>
> +#include <linux/limits.h>
>  #include "hw/virtio/virtio.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> --=20
> 2.13.2
>=20

Another ping on this patch. I think in the end all agreed this
patch is sane, but the thread has been derailed by the
patchew-discussion. So any further comments regarding this patch
or can it be submitted as is?

Regards
Patrick

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAlmNVA8ACgkQEXxntp6r
8SzgGhAAi5tEw+EIUvTWjIMLozStLns73IykJLpVFxPq+dPn0HP6WCWslao46DyQ
roBP3c0FZfwWKvCD60WIicwTDufs1v7jkAe1dQsPEFiWIzTBWnmdgDKI6soABpPR
WuW75OFv+RfevnTlNkABug6WvklHXdaUT4AbpI94GK3xRqTKLb/jOthrutmyMSp4
0P9WVe6Y9WiQzglF5X7+hJ6ANHheX22MQVgxh3gq+QqM75KAkTLKD564/exGsG6x
j8/ctGxgNXhxToQuC3uqqXKrtvuOfZyYdcVXrE2hcwBWG37xaQffj4EBGWsUs1uW
+HR3xUcV+IgBi8oHJTp+xr6je9E/lHY4QqKuDFIgSxW+UNxV5fKdhSwB+ZAh9SXi
Wk86BhbEAo1OwpT4Hpz+qRPOy0t8EZqsciXRXV1utbLSiis27StWmkUOBazu2Qox
TDn9hZE7utW5KK+GkG51ejWpvLdb5wuV0I/htf/TBB++o3+1MjKRTwFxs/XufO7H
4UuYPQSfFjgMmjdUnvQGTnPS/ZVJoG2oOsBiue3sZVC1k2OSWJa1gusK+Vepm4YC
1NgETFxgwm+BdeJrsuMwNXong7m5HLz2qPwio4/srvB5Q7vjOJNBOeOhrGvxEH1c
x6vg0JfXOToy2d5aaJonjvv6Vgo/8hqqDp7Y/5HYknRMa2I9Iu0=
=VOzi
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
