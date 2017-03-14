Received: from eggs.gnu.org ([2001:4830:134:3::10]:55028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnq14-0002Si-SV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnq14-0001bg-3W
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:13:46 -0400
References: <1489507437-32301-1-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6e94897-0030-8f42-ae82-9743c8ee9a66@redhat.com>
Date: Tue, 14 Mar 2017 12:13:37 -0500
MIME-Version: 1.0
In-Reply-To: <1489507437-32301-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jwAaenLW9E5lEH6qJgjUgtJOSHl1qfAFt"
Subject: Re: [Qemu-devel] [PATCH] file-posix: Remove unnecessary includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jwAaenLW9E5lEH6qJgjUgtJOSHl1qfAFt
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <b6e94897-0030-8f42-ae82-9743c8ee9a66@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Remove unnecessary includes
References: <1489507437-32301-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489507437-32301-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 11:03 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 2cb2f64..a03a3e1 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -25,8 +25,6 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> -#include "qemu/timer.h"
> -#include "qemu/log.h"
>  #include "block/block_int.h"
>  #include "qemu/module.h"
>  #include "trace.h"
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jwAaenLW9E5lEH6qJgjUgtJOSHl1qfAFt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyCTBAAoJEKeha0olJ0Nq6sYIAIwIEdYpCdTYIUvzXd3MRUWr
wbq+OH+QFbZs7hbFUVkfdZKZdstnPrERaUDGzVVPsu8Jn8GFwqjlbs04GtfbQy+2
qnBFBuo0M0SMf4GH+b1HNmEQw0Eobr/ygkS0/C7IaOuUczjc5sHEFRuPD9FuhvKT
FmblsrH7V7gveT4ZtlFMXSBRA5KeE2aGIeXodzsi2qj9gKhI6zrUMOG/ot8Aa75I
u8kavfZFgiYWMfYk2/WBCk94rDDt43sj7bdKHfGlKaNedmDrS7L7ywB/F1QHYvao
WlrxuuBYuU6PyfLkJ3eblrnrK3TBLuOqKSWLllKfrFIJ4NdDjja51C9hTGXwD2I=
=XFt0
-----END PGP SIGNATURE-----

--jwAaenLW9E5lEH6qJgjUgtJOSHl1qfAFt--
