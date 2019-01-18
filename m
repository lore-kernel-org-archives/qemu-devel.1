Received: from eggs.gnu.org ([209.51.188.92]:51693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkW4Y-0002ia-5u
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkW4X-0006oi-4N
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:28:42 -0500
References: <20190118101114.11759-1-rjones@redhat.com>
	<20190118101114.11759-2-rjones@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d8c5057-3c9b-4406-ac43-ca5891f65511@redhat.com>
Date: Fri, 18 Jan 2019 09:28:19 -0600
MIME-Version: 1.0
In-Reply-To: <20190118101114.11759-2-rjones@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NfVH0vVAU0VXkfnWf7RhSw5U4T8dPrKKS"
Subject: Re: [Qemu-devel] [PATCH v4] qemu-io: Add generic function for
 reinitializing optind.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, kwolf@redhat.com
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NfVH0vVAU0VXkfnWf7RhSw5U4T8dPrKKS
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>, kwolf@redhat.com
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com
Message-ID: <9d8c5057-3c9b-4406-ac43-ca5891f65511@redhat.com>
Subject: Re: [PATCH v4] qemu-io: Add generic function for reinitializing
 optind.
References: <20190118101114.11759-1-rjones@redhat.com>
 <20190118101114.11759-2-rjones@redhat.com>
In-Reply-To: <20190118101114.11759-2-rjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 4:11 AM, Richard W.M. Jones wrote:
> On FreeBSD 11.2:
>=20
>   $ nbdkit memory size=3D1M --run './qemu-io -f raw -c "aio_write 0 512=
" $nbd'
>   Parsing error: non-numeric argument, or extraneous/unrecognized suffi=
x -- aio_write
>=20
> After main option parsing, we reinitialize optind so we can parse each
> command.  However reinitializing optind to 0 does not work on FreeBSD.
> What happens when you do this is optind remains 0 after the option

> This commit introduces an OS-portability function called
> qemu_reset_optind which provides a way of resetting optind that works
> on FreeBSD and platforms that use optreset, while keeping it the same
> as now on other platforms.
>=20
> Note that the qemu codebase sets optind in many other places, but in
> those other places it's setting a local variable and not using getopt.
> This change is only needed in places where we are using getopt and the
> associated global variable optind.
>=20
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  configure            | 14 ++++++++++++++
>  include/qemu/osdep.h | 16 ++++++++++++++++
>  qemu-img.c           |  2 +-
>  qemu-io-cmds.c       |  2 +-
>  4 files changed, 32 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--NfVH0vVAU0VXkfnWf7RhSw5U4T8dPrKKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxB8JMACgkQp6FrSiUn
Q2rIBAf9HG1TC4M223AROf+2hjpQtR4pyUYpiGhEU9AvOEakpMAUO6pn7vRoRoaP
LvNmSWCdKH+rPZ4qQGz5+oY2PggM2TPmIw54UiWfT8E7C0/PtXQsM01thXj2tUHC
x2XHfya8fvLJ5JeVUaIBJLqrRmuK7u46qoXba7eIIWUPLbxxZpRbqdbHbJDWZOgL
fSTIGnLiJs08j8f7Na1TOtPDoEUOFkpluHW0dHI6nGhpAVFldpqHE1hb6ZzNdzRA
P1v2B5S7Io9iKfU8Hg3nQiJcGeG/x6G43BRS1+x1t6eE+O+eKQKi+xd6wX4lkuxu
GF37liNDTg8l2tanaC24xesLYVgM+g==
=D/Vn
-----END PGP SIGNATURE-----

--NfVH0vVAU0VXkfnWf7RhSw5U4T8dPrKKS--
