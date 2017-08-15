Received: from eggs.gnu.org ([2001:4830:134:3::10]:46473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhaw9-0005N7-D0
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 08:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhaw8-0001Sk-HE
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 08:27:09 -0400
References: <20170815040454.4223-1-famz@redhat.com>
	<20170815040454.4223-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ebaff31-4480-576b-d14f-9e9e9a73ab0e@redhat.com>
Date: Tue, 15 Aug 2017 07:26:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170815040454.4223-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nOFrKooMr35Wx1chWN2tRqO1ek4n6Wfjl"
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/4] stubs: Add vm state change
 handler stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nOFrKooMr35Wx1chWN2tRqO1ek4n6Wfjl
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <4ebaff31-4480-576b-d14f-9e9e9a73ab0e@redhat.com>
Subject: Re: [PATCH for-2.10 1/4] stubs: Add vm state change handler stubs
References: <20170815040454.4223-1-famz@redhat.com>
 <20170815040454.4223-2-famz@redhat.com>
In-Reply-To: <20170815040454.4223-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/14/2017 11:04 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>

A bit sparse on the 'why' - presumably, upcoming patches will fail to
compile if the stub is not present, but mentioning what dependency this
solves never hurts.

> ---
>  stubs/Makefile.objs          |  1 +
>  stubs/change-state-handler.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>  create mode 100644 stubs/change-state-handler.c
>=20

> +++ b/stubs/change-state-handler.c
> @@ -0,0 +1,14 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "sysemu/sysemu.h"
> +
> +VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHand=
ler *cb,
> +                                                     void *opaque)
> +{
> +    return g_malloc0(1);
> +}

Hmm - this is NOT a VMChangeStateEntry; if it ever gets dereferenced,
the caller is (probably) accessing memory out of bounds.  Presumably,
since it is a stub, this should never be called - and if that's the
case, can we just get away with returning NULL instead (I'd rather have
the caller SEGFAULT than dereference out-of-bounds into the heap, if
this stub gets used inappropriately).

> +
> +void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
> +{
> +    g_free(e);

And of course, if you don't allocate anything, this can be a no-op.

> +}
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nOFrKooMr35Wx1chWN2tRqO1ek4n6Wfjl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmS6JEACgkQp6FrSiUn
Q2rbZgf8DTgXXsS1BttkVeyeYuP5mtWERNNjAbuO+zYQy4EBR7UdZYtW+AGh5sLa
OMiOhRcK7LkBfBcrRqL6ky2Imv4pXyEjUKDIf/pZ81k6ZPnpboyQkw9VGZFBQlxl
US2mfqk49f6/PAXFzXJ53ZNexaDFo70xAc6gBitWufeKQk+v4R6unmDtJ7rcVmZ+
00GXbkfUYbXyxuFrWs1SvkWIhUAQGQTLxOY5e6j3oTlcdSTqv4szhBG+5KOT5C+v
tWjX3Xd5MUhDLQeG+juSaP/s0b0obC/6axbCmSppan12AcWYSkX7cgfQqIQSSA6u
8jqMrT3Cmaj0u8/xg9oRUYdVsOFnNQ==
=BpBk
-----END PGP SIGNATURE-----

--nOFrKooMr35Wx1chWN2tRqO1ek4n6Wfjl--
