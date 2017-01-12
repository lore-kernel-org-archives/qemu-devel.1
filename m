Received: from eggs.gnu.org ([2001:4830:134:3::10]:47983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRo6O-0001Wg-GK
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 17:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRo6J-0001Yc-ML
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 17:44:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRo6J-0001YO-DH
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 17:44:07 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85AE8129212
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 22:44:07 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-23-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d7e1156-b560-f2e0-802e-35fa41816317@redhat.com>
Date: Thu, 12 Jan 2017 16:44:05 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-23-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KcN6oOv6snpSifGKEnHcAhuI8bruiRmXa"
Subject: Re: [Qemu-devel] [PATCH 22/40] char: move null chardev to its own
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KcN6oOv6snpSifGKEnHcAhuI8bruiRmXa
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <6d7e1156-b560-f2e0-802e-35fa41816317@redhat.com>
Subject: Re: [PATCH 22/40] char: move null chardev to its own file
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-23-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-null.c   | 31 +++++++++++++++++++++++++++++++
>  chardev/char.c        | 23 -----------------------
>  chardev/Makefile.objs |  1 +
>  3 files changed, 32 insertions(+), 23 deletions(-)
>  create mode 100644 chardev/char-null.c
>=20
> diff --git a/chardev/char-null.c b/chardev/char-null.c
> new file mode 100644
> index 0000000000..18a49f5802
> --- /dev/null
> +++ b/chardev/char-null.c
> @@ -0,0 +1,31 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/char.h"

No copyright blurb? You should copy the header of chardev/char.c (since
that's what you're splitting off of).

Otherwise looks okay.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KcN6oOv6snpSifGKEnHcAhuI8bruiRmXa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeAa1AAoJEKeha0olJ0NqotwH/3THbP5276io+GQNWSUO8uBW
vqOKKheTVgid1Ov15vgL2BYN5/InCuYoly0yi+R9Pv02PrGNQBmrdRaSugx9oPJx
bpSm/YpeP85FE0mNh8D7OxyodzKS7AZS+0yMFrbRIrmt/byCE+VJN6aRBg4HMMPW
uyPR2FDSw5wHYIcBH40Z6UrflK17DZDfCyFLnVZ5s/sGDkvD0dG39a5vV6yPWvku
aDmSyy8+dndpgGk79cFjshxQR86kz8SlleM8N1vkoSP7vUfCw7iKzmjYdGjMJV2Z
nASVuw3tD9dd8lRtXpHXCkXaI/5O/JwB6bEtfq3tAtvXntK+5AlMynyJ7Mj63ac=
=buQY
-----END PGP SIGNATURE-----

--KcN6oOv6snpSifGKEnHcAhuI8bruiRmXa--
