Received: from eggs.gnu.org ([2001:4830:134:3::10]:50213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjspB-0004HR-7L
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjsp8-0000HL-44
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:25:09 -0500
References: <20170303191805.1204-1-shah.suramya@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11661735-41ac-1830-6664-216af7cd317e@redhat.com>
Date: Fri, 3 Mar 2017 13:25:03 -0600
MIME-Version: 1.0
In-Reply-To: <20170303191805.1204-1-shah.suramya@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cfxf2G9cjSjXHbWIRlp4VEq5gHIteOJL8"
Subject: Re: [Qemu-devel] [PATCH] Removed header qemu-common.h from path.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suramya Shah <shah.suramya@gmail.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, armbru@redhat.com, qemu-trivial <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cfxf2G9cjSjXHbWIRlp4VEq5gHIteOJL8
From: Eric Blake <eblake@redhat.com>
To: Suramya Shah <shah.suramya@gmail.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, armbru@redhat.com,
 qemu-trivial <qemu-trivial@nongnu.org>
Message-ID: <11661735-41ac-1830-6664-216af7cd317e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Removed header qemu-common.h from path.c
References: <20170303191805.1204-1-shah.suramya@gmail.com>
In-Reply-To: <20170303191805.1204-1-shah.suramya@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding qemu-trivial in cc]

On 03/03/2017 01:18 PM, Suramya Shah wrote:
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---

It would have been nice to mention in the subject that this is v2 (v1
was here
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00110.html),
and then mention here after the --- that the difference was a fix of a
typo that broke compilation.

Also, the subject line doesn't follow the usual conventions of "topic:
Description", a topic of 'util: ' may be appropriate.

>  util/path.c | 1 -
>  1 file changed, 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/util/path.c b/util/path.c
> index 5479f76..7f9fc27 100644
> --- a/util/path.c
> +++ b/util/path.c
> @@ -6,7 +6,6 @@
>  #include "qemu/osdep.h"
>  #include <sys/param.h>
>  #include <dirent.h>
> -#include "qemu-common.h"
>  #include "qemu/cutils.h"
>  #include "qemu/path.h"
> =20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Cfxf2G9cjSjXHbWIRlp4VEq5gHIteOJL8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYucMPAAoJEKeha0olJ0NqmywH/R4EJXqf+KEN1tMdPoUjKP5+
jlwR/EWB1kuNEyu9Cax/TI5o05wi72DOf48c3g3X0i+ygoNEDSYbgVgIzRopWy+T
ibN6LPWgGs+M+x4dEqn8iAzYxgguxLMCYt73cMpTpdI2W1XeiAy/nLvuXeBtL9/M
gd3P2bOmmkC6uwFQ0dyPWIXiKWXVtRjWhKgfXjq2oZVmUdhyL+5/BrrpUA6hhLWf
z8XtQqaYJuGiB1fruSdCeVP2oNLKuqrNPaa4Lp039Uykw0tdjEdguminb8Euqgu0
jXGpJGCwQgyPm1SMAhBHfO4itAOpKnSGaN0ZYc1Vct6EiA0N079LSNoW2r7RHLI=
=l6tR
-----END PGP SIGNATURE-----

--Cfxf2G9cjSjXHbWIRlp4VEq5gHIteOJL8--
