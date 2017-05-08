Received: from eggs.gnu.org ([2001:4830:134:3::10]:57996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7sYM-0003R0-9p
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7sYL-0001zk-7f
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:58:58 -0400
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-5-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <56387911-b587-adf0-c65b-ed12374d604d@redhat.com>
Date: Mon, 8 May 2017 18:58:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170508233918.9043-5-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KW7SIcisNcrGPAvwQestLe73ANH5MJxpA"
Subject: Re: [Qemu-devel] [PATCH 04/11] ide/ahci: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KW7SIcisNcrGPAvwQestLe73ANH5MJxpA
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, John Snow
 <jsnow@redhat.com>, qemu-block@nongnu.org
Message-ID: <56387911-b587-adf0-c65b-ed12374d604d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/11] ide/ahci: add missing includes
References: <20170508233918.9043-1-f4bug@amsat.org>
 <20170508233918.9043-5-f4bug@amsat.org>
In-Reply-To: <20170508233918.9043-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 06:39 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> qemu/include/hw/ide/ahci.h:260:16: error: field =E2=80=98sglist=E2=80=99=
 has incomplete type
>      QEMUSGList sglist;
>                 ^~~~~~

What are you doing to get this compilation error (configure options,
platform, compiler, etc)?  I can't reproduce it. Is it something that
pops up later when you remove includes from somewhere else, and you're
just pre-emptively adding includes here to allow removal of includes late=
r?

> /qemu/include/hw/ide/ahci.h:272:5: error: unknown type name =E2=80=98ID=
EDMA=E2=80=99
>      IDEDMA dma;
>      ^~~~~~
> qemu/include/hw/ide/ahci.h:273:5: error: unknown type name =E2=80=98IDE=
Bus=E2=80=99
>      IDEBus port;
>      ^~~~~~
> qemu/include/hw/ide/ahci.h:305:15: error: field =E2=80=98parent_obj=E2=80=
=99 has incomplete type
>      PCIDevice parent_obj;
>                ^~~~~~~~~~
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/ide/ahci.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
> index 0ca7c65820..293f9ebcd0 100644
> --- a/include/hw/ide/ahci.h
> +++ b/include/hw/ide/ahci.h
> @@ -25,6 +25,8 @@
>  #define HW_IDE_AHCI_H
> =20
>  #include "hw/sysbus.h"
> +#include "hw/ide/internal.h"
> +#include "sysemu/dma.h"
> =20
>  #define AHCI_MEM_BAR_SIZE         0x1000
>  #define AHCI_MAX_PORTS            32
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KW7SIcisNcrGPAvwQestLe73ANH5MJxpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEQY3AAoJEKeha0olJ0NqoL8IALDMIPnOD8FbdQ0LqOICKHTu
hCKRKBS4zpGarbKt6NbRxtAc50kmMFUJCvmYj1UDiRNBhnk3eKF6tPD8Io3TbAME
acknbw5FANxP0zZDlo7niwWPC0oQ8lGGS1+ktcGFGkT0t6Vvu/E48BrG5bLGMAJp
HebvncGTMMtLzhaJ/dDnKg7QG1DNm6ILryysIvjRpIQYgJPhRNZEdUXe/t7mOWqC
CwJKzeUBfhg/ZLVgYgVpLtWG99x0R5UQQygVtVC2nd29mk9gGTUkTpRTkOjugGfr
BqtWCxJbycF8vDduqKcFiDXO96L9EBvVmb04r0YXWU4JDW7FCSsokyUYuM01uBY=
=wYxQ
-----END PGP SIGNATURE-----

--KW7SIcisNcrGPAvwQestLe73ANH5MJxpA--
