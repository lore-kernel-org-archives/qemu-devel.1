Received: from eggs.gnu.org ([2001:4830:134:3::10]:55088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnq1J-0002gC-ED
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnq1I-0001dm-K1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:14:01 -0400
References: <1489507451-32356-1-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <144bd71d-24ad-8521-835a-30a1bbc66c1f@redhat.com>
Date: Tue, 14 Mar 2017 12:13:51 -0500
MIME-Version: 1.0
In-Reply-To: <1489507451-32356-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WSvXoCADNWm2Sr9a1Kwwwg7mb5ijolI3V"
Subject: Re: [Qemu-devel] [PATCH] file-win32: Remove unnecessary include
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
--WSvXoCADNWm2Sr9a1Kwwwg7mb5ijolI3V
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <144bd71d-24ad-8521-835a-30a1bbc66c1f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-win32: Remove unnecessary include
References: <1489507451-32356-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489507451-32356-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 11:04 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-win32.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/file-win32.c b/block/file-win32.c
> index 800fabd..e132ba1 100644
> --- a/block/file-win32.c
> +++ b/block/file-win32.c
> @@ -24,7 +24,6 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
> -#include "qemu/timer.h"
>  #include "block/block_int.h"
>  #include "qemu/module.h"
>  #include "block/raw-aio.h"
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--WSvXoCADNWm2Sr9a1Kwwwg7mb5ijolI3V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyCTPAAoJEKeha0olJ0Nq5fYIAJXTW1A7rmf1R+wumMbCsx3K
ZQKpJksjcBHisGB2WZ/pLe9khsD1Dn889i7r58eZnMf/x0HRvRPpxkzRLd7LVkDy
BKtRFM267IGXs5iPC9Vh6dDjsJtu88sMSohaovnPVP/eFJwn1k/3nbNKvaHd6m0W
3BoFcKFInSzg0n3fWaCu2+67rIrJMEHcK3aD1J6m5ev9tvum7RoSCiQ0tzSeEM4G
tmffT6AHazEQDh1kelyfGyslvlbW7bIPJj95lrIQ9w1Dleq4RZT3M4fmicPJTJ6H
0bRwiF5VfR3uurNUZb3uo7i+blYX1C9WEfLPBwECrCplLWJYuWitcuoNJ+8YgkM=
=xwiH
-----END PGP SIGNATURE-----

--WSvXoCADNWm2Sr9a1Kwwwg7mb5ijolI3V--
