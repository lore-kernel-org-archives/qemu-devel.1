Received: from eggs.gnu.org ([2001:4830:134:3::10]:54595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fmH-0007S5-R6
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fmE-0000hM-EH
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:08:21 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6fmE-0000h0-7N
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:08:18 -0400
Received: by mail-wm0-x241.google.com with SMTP id u65so2223122wmu.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 09:08:18 -0700 (PDT)
Date: Fri, 5 May 2017 17:08:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505160814.GK14316@stefanha-x1.localdomain>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYjDATHXTWnytHRU"
Content-Disposition: inline
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/21] Chr tests patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org


--zYjDATHXTWnytHRU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 03:42:11PM +0400, Marc-Andr=E9 Lureau wrote:
> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:
>=20
>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)
>=20
> are available in the git repository at:
>=20
>   https://github.com/elmarco/qemu.git tags/chr-tests-pull-request
>=20
> for you to fetch changes up to 79c8db5a13c0f4b73f930be0fcff9bbc1237c258:
>=20
>   tests: add /char/console test (2017-05-04 15:34:42 +0400)
>=20
> ----------------------------------------------------------------
>=20
> ----------------------------------------------------------------
>=20
> Marc-Andr=E9 Lureau (21):
>   char: remove qemu_chr_be_generic_open
>   mux: simplfy muxes_realize_done
>   xen: use a better chardev type check
>   container: don't leak container reference
>   char: add a /chardevs container
>   vl: add todo note about root container cleanup
>   char: use /chardevs container instead of chardevs list
>   char: remove qemu_chardev_add
>   char: remove chardevs list
>   char: useless NULL check
>   char-socket: introduce update_disconnected_filename()
>   char-socket: update local address after listen
>   char-socket: add 'addr' property
>   char-socket: add 'connected' property
>   char-udp: flush as much buffer as possible
>   tests: add alias check in /char/ringbuf
>   tests: add /char/pipe test
>   tests: add /char/file test
>   tests: add /char/socket test
>   tests: add /char/udp test
>   tests: add /char/console test
>=20
>  chardev/char-mux.h          |   2 +-
>  include/sysemu/char.h       |  10 --
>  chardev/char-mux.c          |  11 +-
>  chardev/char-pty.c          |   2 +-
>  chardev/char-socket.c       |  46 +++++-
>  chardev/char-udp.c          |  26 ++--
>  chardev/char.c              | 148 ++++++++----------
>  gdbstub.c                   |   4 +-
>  hw/usb/ccid-card-passthru.c |   2 +-
>  hw/usb/redirect.c           |   2 +-
>  hw/xen/xen-common.c         |   2 +-
>  net/vhost-user.c            |   2 +-
>  qom/container.c             |   1 +
>  tests/test-char.c           | 366 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  tests/vhost-user-test.c     |   2 +-
>  ui/console.c                |   2 +-
>  ui/gtk.c                    |   2 +-
>  vl.c                        |   1 +
>  18 files changed, 504 insertions(+), 127 deletions(-)
>=20
> --=20
> 2.12.0.191.gc5d8de91d
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--zYjDATHXTWnytHRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDKNuAAoJEJykq7OBq3PI5JgIALUNE8AOmnXEZUkMgwwX3BN4
zJtJ28ylLJdQqnqAb79pD2tAKXOBkshWaUsBTBZUNJhTPBA/aBbj8h1/z1GPcAJN
dxGrGZAGQQJWJdqBjdkno09Nhd8lElC7lp5GZR1JzuX1QZKnv08a4gck6ORy5zgz
gWXfqJ/1Ce0h8oL2D5mnc63fb3vBWGdFodHfl25osAlR/X0e31+YINmCAYTnDl6k
WgRwQwi0Xf8kaj1OYpb3aRn1VWaGq5RkYZ84eLB/j1VqbPHtCj43n5AibbTm7x3m
jsxwDWScbGRqQ/DsDpOvqkXH7sL4e750NmjK87d2QKS5itiRja7oJXovgm/APIY=
=lvjp
-----END PGP SIGNATURE-----

--zYjDATHXTWnytHRU--
