Received: from eggs.gnu.org ([2001:4830:134:3::10]:39108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfAgQ-0000Hy-Du
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfAgP-0003rC-8l
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:00:54 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0250626-4c3a-fa61-a749-387fbabd6934@redhat.com>
Date: Tue, 8 Aug 2017 15:00:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170808183306.27474-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wTglCITBF39focD0NCdH9cIpxN5I9MmAb"
Subject: Re: [Qemu-devel] [PATCH 1/9] IDE: replace DEBUG_IDE with tracing
 system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wTglCITBF39focD0NCdH9cIpxN5I9MmAb
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <c0250626-4c3a-fa61-a749-387fbabd6934@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] IDE: replace DEBUG_IDE with tracing
 system
References: <20170808183306.27474-1-jsnow@redhat.com>
 <20170808183306.27474-2-jsnow@redhat.com>
In-Reply-To: <20170808183306.27474-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 01:32 PM, John Snow wrote:
> Out with the old, in with the new.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

>  hw/ide/piix.c             | 11 ++++----
>  hw/ide/trace-events       | 33 ++++++++++++++++++++++++
>  hw/ide/via.c              | 10 +++-----

Hmm - should we tweak scripts/git.orderfile to prioritize trace-events
over .c files? Then again, right now it prioritizes all .c files before
anything that didn't match, so that things like trace-events will at
least avoid falling in the middle of a patch if you use the project's
orderfile.

> +++ b/hw/ide/cmd646.c
> @@ -32,6 +32,7 @@
>  #include "sysemu/dma.h"
> =20
>  #include "hw/ide/pci.h"
> +#include "trace.h"
> =20
>  /* CMD646 specific */
>  #define CFR		0x50
> @@ -195,9 +196,8 @@ static uint64_t bmdma_read(void *opaque, hwaddr add=
r,
>          val =3D 0xff;
>          break;
>      }
> -#ifdef DEBUG_IDE
> -    printf("bmdma: readb " TARGET_FMT_plx " : 0x%02x\n", addr, val);
> -#endif

Yay for killing code prone to bitrot.

> +++ b/hw/ide/core.c

> @@ -2054,18 +2044,18 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
>      }

>      hob =3D 0;
> -    switch(addr) {
> +    switch(reg_num) {

Worth fixing the style to put space after switch while touching this?

> +++ b/hw/ide/trace-events
> @@ -0,0 +1,33 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# hw/ide/core.c

> +
> +# hw/ide/pci.c
> +bmdma_reset(void) ""

An empty trace? Do all the backends support it?

> +# hw/ide/cmd646.c

Worth sorting the sections by filename?

Whether or not you tweak based on my nits,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wTglCITBF39focD0NCdH9cIpxN5I9MmAb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKGGgACgkQp6FrSiUn
Q2qYiwf9E72zzEmce4Hjwj7Yj5OhtPi4NXGhS+a0T2I0qYKgowzL24RdVpAyDi7F
uJ5MPgaSwubHyTo96WcLo2PpGcgSj0wVwkdSFsBAImTEN9vSam89EKWsvWv6J5lw
54D2a6qa75QZ2nwgT+QDdPKL9gB9k7EKxZQaCCrnax7AgKc26smqfDfd7VC8V1xO
sJuQCf1POlz4Xi6BEbMavJ6RsuOxc1+etdUbXj9OtbXgwR6zMmpP7OOqZR8vsOUz
GfOzO5eZVO5bHUztPEz5ZdXLR3+8cyO70EiFVSN+azikpeRDpo8A22q49wvcbtoD
nedLgUPCUSNzqcXOk39dIx35uCSALQ==
=eMUU
-----END PGP SIGNATURE-----

--wTglCITBF39focD0NCdH9cIpxN5I9MmAb--
