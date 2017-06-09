Received: from eggs.gnu.org ([2001:4830:134:3::10]:56663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJRcF-0001Kb-Tp
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 17:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJRcC-0004eJ-P2
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 17:38:47 -0400
References: <20170609150622.4720-1-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64263ec6-5e92-2a4a-c690-a5129eb71333@redhat.com>
Date: Fri, 9 Jun 2017 16:38:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170609150622.4720-1-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oEnidHMCO5bS7QbgOdndMkCHPKbONKa1h"
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc: add missing includes
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
--oEnidHMCO5bS7QbgOdndMkCHPKbONKa1h
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <64263ec6-5e92-2a4a-c690-a5129eb71333@redhat.com>
Subject: Re: [PATCH v2] hw/misc: add missing includes
References: <20170609150622.4720-1-f4bug@amsat.org>
In-Reply-To: <20170609150622.4720-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 10:06 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> inlined create_unimplemented_device() calls sysbus_mmio_map_overlap().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>=20
> v2: Addressed review feedback from Eric Blake
>=20
>  include/hw/misc/unimp.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
> index 3462d85836..52e068ec3e 100644
> --- a/include/hw/misc/unimp.h
> +++ b/include/hw/misc/unimp.h
> @@ -8,6 +8,8 @@
>  #ifndef HW_MISC_UNIMP_H
>  #define HW_MISC_UNIMP_H
> =20
> +#include "hw/sysbus.h"
> +
>  #define TYPE_UNIMPLEMENTED_DEVICE "unimplemented-device"
> =20
>  /**
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oEnidHMCO5bS7QbgOdndMkCHPKbONKa1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOxVgAAoJEKeha0olJ0NqqSMIAI0zvUqlnnMFmLSKUaXXshj0
nNCmEL7B4rAn2i1eapG05KfJMMOp3W88orsEJIDTYvtx8/30EfXlseZ/t1/ZF5gk
KQfZIfjhZzyfyJnAULcdTdJgg7Oynu8oqyEIJeZRC7UDMdFVe8J/nZNefuwq114P
ulnZGOPDTUWkwEMQ96iwK3ulcssBhLUqYRn/0gfwbaYCSR6Nc1BiWYBq6AlH8FoG
QZNa+2UxRpUYmoT9jYI1hB+8tJGR5Etkf4n8/zj22fUkltSe8qtcKOZ9qBoj8YkE
X6UPmBU41SUNYUTIrAxj7+mivj2RZvYpO7pS2lTeN9HbDG1xjwC7gCQ/tu+ALuA=
=Qd4a
-----END PGP SIGNATURE-----

--oEnidHMCO5bS7QbgOdndMkCHPKbONKa1h--
