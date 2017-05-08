Received: from eggs.gnu.org ([2001:4830:134:3::10]:57484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7sVk-0000el-JZ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7sVg-0000mp-DN
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:56:16 -0400
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-4-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ad7eaf6-3691-f9f1-4d09-204444adbd19@redhat.com>
Date: Mon, 8 May 2017 18:56:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170508233918.9043-4-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="luLuHpJJNqhrSjDVCHef8wXx0erkQ5qJE"
Subject: Re: [Qemu-devel] [PATCH 03/11] hw/misc: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--luLuHpJJNqhrSjDVCHef8wXx0erkQ5qJE
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <2ad7eaf6-3691-f9f1-4d09-204444adbd19@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] hw/misc: add missing includes
References: <20170508233918.9043-1-f4bug@amsat.org>
 <20170508233918.9043-4-f4bug@amsat.org>
In-Reply-To: <20170508233918.9043-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 06:39 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/misc/unimp.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
> index 3462d85836..353ee19abf 100644
> --- a/include/hw/misc/unimp.h
> +++ b/include/hw/misc/unimp.h
> @@ -8,6 +8,9 @@
>  #ifndef HW_MISC_UNIMP_H
>  #define HW_MISC_UNIMP_H
> =20
> +#include "qemu/osdep.h"

NACK. .h files should not include osdep.h, because the .c file that is
using the .h file should have already done so.  This is mentioned in
HACKING.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--luLuHpJJNqhrSjDVCHef8wXx0erkQ5qJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEQWZAAoJEKeha0olJ0NqUS0H/jp4fE4izBwNT0OV4RM6PQlT
S+CrgBGmvB48HVe5RU0sKCzhITCHrXVcKHK8Pg3x+L1oo5MPm/aB8qgZMhu0nojV
+fITWXb5m88Fv70CFZikkwgTxz7za7Sf/4gBQ7hoxU5ruY296hIB9glBJ3QG+mnQ
K2erUVQhnxy47twI4ajPV8wE0cW8+OM9L1SEb55FLb32L1UDvI30Q5o5Wa7ZQfwC
mGgSaX4LoHNJvSh7lOKjY0DY5LWeB2KsEUlqT/QAfIwgb0WS5WsVtd8Zl6+3j9cX
1zFrCc85YeQavvxy1csBwDPqwxB5jDlT2pgGaH9qpGW3yiXLQ4m4ncUIvrXpE9M=
=JM/0
-----END PGP SIGNATURE-----

--luLuHpJJNqhrSjDVCHef8wXx0erkQ5qJE--
