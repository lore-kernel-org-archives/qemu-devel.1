Received: from eggs.gnu.org ([2001:4830:134:3::10]:60544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFjv8-0004z0-1B
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFjv6-0004SF-RI
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:22:58 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:51180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFjv6-0004Rs-K3
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:22:56 -0400
Date: Tue, 30 May 2017 18:21:40 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170530162140.hif4yejooxfdimcs@aurel32.net>
References: <20170529193016.6888-1-aurelien@aurel32.net>
	<20170529193016.6888-3-aurelien@aurel32.net>
	<20170530101746.GA25884@stefanha-x1.localdomain>
	<dc4c904d-c794-fd9f-66ec-141861cf0a33@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lneihknohj3sovcw"
Content-Disposition: inline
In-Reply-To: <dc4c904d-c794-fd9f-66ec-141861cf0a33@redhat.com>
Subject: Re: [Qemu-devel] [PULL 2/5] target/sh4: fix reset when using a
 kernel and an initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--lneihknohj3sovcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-05-30 10:02, Eric Blake wrote:
> On 05/30/2017 05:17 AM, Stefan Hajnoczi wrote:
> > On Mon, May 29, 2017 at 09:30:13PM +0200, Aurelien Jarno wrote:
> >> When a masked exception happens, the SH4 CPU generates a non-masked
> >> reset exception, which then jumps to the reset vector at address
> >> 0xA0000000. While this is emulated correctly in QEMU, this does not
> >> work when using a kernel and initrd as this address then contain an
> >> illegal instruction (and there is no guarantee the kernel and initrd
> >> haven't been overwritten).
> >>
>=20
> >> +            qemu_system_reset_request();
> >> +            return;
> >=20
> > The qemu_system_reset_request() prototype is changing.  There is a
> > conflict with another merged pull request.  Please rebase onto
> > https://github.com/stefanha/qemu.git staging.
> >=20
> > target/sh4/helper.c:102:39: error: too few arguments to function call, =
single argument 'reason' was not specified
> >             qemu_system_reset_request();
> >             ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
>=20
> You'll probably want SHUTDOWN_CAUSE_GUEST_RESET as the reason, based on
> the changes made to other target/ files.
=20
Indeed I confirm. This is the same as the triple fault on x86, which
uses SHUTDOWN_CAUSE_GUEST_RESET.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

--lneihknohj3sovcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEd0YmQqnvlP0Pdxltupx4Bh3djJsFAlktnBMACgkQupx4Bh3d
jJvy3Q//dnFf6aUY/PzRssVim47bn+3KLkpG2YE/x65XUFCswFUi8lt8vedaHdEx
s6nz4c6693LuC7nfRRPCnlDkt7UrMsxA2M4g6R6ESFjCRhxF3dZFt0ToE50N783J
9tv//5VFMJRypq8bsEZvO2HoOKxMU+UvaZSo3Nb9kpGWMa1aGK8VQ/vmoOz+J5zB
VCjcnxbkf/0WG+NMcaDhyrj8uy3+ELcBqugaJE49XYt0XodLI9dReClseSnRTVrL
XEwxipee+y8yXwFqvAx6zKcLa1hgvg3kTqfx29Ew0PxTGcRr3GTb/B501qM/aFga
fUU/n5ihB3pyzpTmQWv610yEmjhH68aftwCu9myCA/rEgJysRW6sIjmHuxX1bYkJ
0fyvtRsDPI4n15QxlnLLIwRAHnKY+1pGnZBH9+dmeQjcM8zvZ1VHTDNemdoHkPQh
CzVmaELwTFdTBWv9puA97wBno+JC/Z0re2ylcHikl6vObPGWZspny004Fj0I7lqP
IzilmeNKWWsLrIEkm83gImkcITGpq/R4ncyiU6CoZbUgdvW0WQOTY2ZsIKCRsdXJ
0Y798nJfLG/IbvmgTyc4m93NUghuVnbuBoJA+/n36KT054cqWEraZ0RQFr54BN7X
S4VLSJEUJjlW8I+alHH2gIKB/5rUkG00SZEBeAG5KHbd4P1IYXc=
=xp8w
-----END PGP SIGNATURE-----

--lneihknohj3sovcw--
