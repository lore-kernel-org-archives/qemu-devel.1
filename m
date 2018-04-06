Received: from eggs.gnu.org ([2001:4830:134:3::10]:56228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4VQ5-0003Ep-TR
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4VQ2-0003Ka-M9
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:45:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f4VQ2-0003KA-G0
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:44:58 -0400
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
	<1523034681-33787-2-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32d5bc55-45cc-1a7e-3e8a-91a3d6688aa3@redhat.com>
Date: Fri, 6 Apr 2018 12:44:49 -0500
MIME-Version: 1.0
In-Reply-To: <1523034681-33787-2-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MTjTmwDnhJl8OEPJjwzUZYHzqWis7HqMJ"
Subject: Re: [Qemu-devel] [PULL 01/20] sys_membarrier: fix up include
 directives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Bruce Rogers <brogers@suse.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MTjTmwDnhJl8OEPJjwzUZYHzqWis7HqMJ
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Bruce Rogers <brogers@suse.com>
Message-ID: <32d5bc55-45cc-1a7e-3e8a-91a3d6688aa3@redhat.com>
Subject: Re: [Qemu-devel] [PULL 01/20] sys_membarrier: fix up include
 directives
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
 <1523034681-33787-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2018 12:11 PM, Paolo Bonzini wrote:
> From: Bruce Rogers <brogers@suse.com>
>=20
> Our rule right now is to use <> for external headers only.
> util/sys_membarrier.c violates that. Fix it up.
>=20
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> Message-Id: <20180329151018.15319-1-brogers@suse.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/sys_membarrier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Keeping this one as-is is fine, since it is already part of a pull
request, but...

>=20
> diff --git a/util/sys_membarrier.c b/util/sys_membarrier.c
> index 8dcb53e..1362c0c 100644
> --- a/util/sys_membarrier.c
> +++ b/util/sys_membarrier.c
> @@ -6,9 +6,9 @@
>   * Author: Paolo Bonzini <pbonzini@redhat.com>
>   */
> =20
> -#include <qemu/osdep.h>
> -#include <qemu/sys_membarrier.h>
> -#include <qemu/error-report.h>
> +#include "qemu/osdep.h"
> +#include "qemu/sys_membarrier.h"
> +#include "qemu/error-report.h"
> =20
>  #ifdef CONFIG_LINUX
>  #include <linux/membarrier.h>

Our style also recommends ordering things as:

"qemu/osdep.h"
all <system.h>
"any other qemu.h"

to minimize chances of collisions from something in a qemu header
causing a system header to go wrong (that is, osdep.h has to go first,
because it might influence a system header, but nothing else should risk
influencing a system header).  So if you wanted, you could also sink the
"qemu/sys_membarrier.h" and "qemu/error-report.h" includes after the
<linux/membarrier.h> and any other system headers not shown in the
context of the patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MTjTmwDnhJl8OEPJjwzUZYHzqWis7HqMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrHshEACgkQp6FrSiUn
Q2os8gf/dKMvQFjscwdnK+4ccEy689RAk8CUS2AvjVC+3P3fsX1j7rHJ0lvjC/8x
pd3aamUttG7oNm/fcrX5EdGXkjobdn9cvjXGxpnBqPD/OCXHxloLv1er0KtVsl42
KlUJH0lnIkfWTp7GPz/KISoPQaMjI2YoW0iZ4q33Hg86mQaUDWfO+0ijRKG/fLGc
ejJpaZS+8UUE7zdPkMGG0lYWHSw7nV6sYbg/4Wse7E8LpC+W4Ot3KE7e3CJtjqIK
HP58NBu7cUwDOUNUq7KFCHzzL+5chIKPubCp9UolGFegnxZOE8rD4CaH8v3kodin
DnmJ3JKm+wqKIk8qDwCMJ8/xEJPzDw==
=WbzF
-----END PGP SIGNATURE-----

--MTjTmwDnhJl8OEPJjwzUZYHzqWis7HqMJ--
