Received: from eggs.gnu.org ([2001:4830:134:3::10]:44293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIxVp-0005w6-5F
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIxVj-0000ai-DQ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:30:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dIxVj-0000aF-4E
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:30:03 -0400
References: <20170608115939.30985-1-marcandre.lureau@redhat.com>
	<20170608115939.30985-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <765f4687-52ac-ff9d-ef82-037c319e23ec@redhat.com>
Date: Thu, 8 Jun 2017 08:29:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170608115939.30985-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EIGSDVLh79bOFtUI4QWpr3juKCJT98mj0"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] test-char: start a /char/serial test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EIGSDVLh79bOFtUI4QWpr3juKCJT98mj0
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, pbonzini@redhat.com
Message-ID: <765f4687-52ac-ff9d-ef82-037c319e23ec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] test-char: start a /char/serial test
References: <20170608115939.30985-1-marcandre.lureau@redhat.com>
 <20170608115939.30985-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170608115939.30985-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 06:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> Quite limited test, to check that the chardev can be created with a
> path and with the tty alias.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/test-char.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/tests/test-char.c b/tests/test-char.c
> index dfe856cb85..ecc3fec194 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -5,6 +5,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/sockets.h"
>  #include "chardev/char-fe.h"
> +#include "chardev/char-serial.h" /* for HAVE_CHARDEV_SERIAL */

Either the comment or the entire #include is now spurious, given the new
1/3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EIGSDVLh79bOFtUI4QWpr3juKCJT98mj0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOVFWAAoJEKeha0olJ0Nqh6IH/AiYSKhLysqEm2QuC2iO866B
bNuDwQ08LK/KgtTQx4NRW6gnR8hCVRgvGTesiL/xB24ZbDPkoTG5o7sOrFrLA0mv
S0yuCyEEqVUITKpMCeWqBnn3aTOTjpK6nsTjXJD7/dLxBNvNBG4u5UqBRDYOEdto
oy8xPm0H4h7rBRVFFdrjCi2mLVXmaAiBqTkT3/ZzIea2l1EGJczXqj1yMsg5g5ef
VS8cfDHbiA9wmlG5/G7WkhUQ4u/aXd5EqcZcKfQNoJNg1AqSlPVIYFSRFSbwyzDK
QkruCGoYMXaGWfj09hWfxJ/gEVOFUj/6G0m/r6toLpoeGKMsUSLu59cgzcqfpCM=
=zi4p
-----END PGP SIGNATURE-----

--EIGSDVLh79bOFtUI4QWpr3juKCJT98mj0--
