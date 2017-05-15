Received: from eggs.gnu.org ([2001:4830:134:3::10]:42709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAG4D-0004E8-VA
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAG4A-0002mp-On
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:29:41 -0400
Received: from mail-lf0-x231.google.com ([2a00:1450:4010:c07::231]:34850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAG4A-0002mh-HG
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:29:38 -0400
Received: by mail-lf0-x231.google.com with SMTP id j1so18729461lfh.2
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 06:29:38 -0700 (PDT)
Date: Mon, 15 May 2017 14:29:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515132934.GG1201@stefanha-x1.localdomain>
References: <20170512115135.17379-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Content-Disposition: inline
In-Reply-To: <20170512115135.17379-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/10] ui patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 01:51:25PM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> Here is the ui patch queue with some vnc cleanups, absolute event
> support for input linux, egl bugfixes and the new eg-headless ui.
>=20
> please pull,
>   Gerd
>=20
> The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:
>=20
>   Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)
>=20
> are available in the git repository at:
>=20
>   git://git.kraxel.org/qemu tags/pull-ui-20170512-1
>=20
> for you to fetch changes up to 7c9209e7bfb8c09ab5a4cadaa84928d146874a05:
>=20
>   vnc: replace hweight_long() with ctpopl() (2017-05-12 12:36:02 +0200)
>=20
> ----------------------------------------------------------------
> ui: add egl-headless
> ui: some vnc cleanups
> ui: absolute events for input-linux
>=20
> ----------------------------------------------------------------
> C=E9dric Le Goater (1):
>       vnc: replace hweight_long() with ctpopl()
>=20
> Gerd Hoffmann (6):
>       virtio-gpu: move virtio_gpu_gl_block
>       egl-helpers: drop support for gles and debug logging
>       egl-helpers: fix display init for x11
>       egl-helpers: add missing error check
>       egl: explicitly ask for core context
>       opengl: add egl-headless display
>=20
> Philippe Voinov (2):
>       ui: Support non-zero minimum values for absolute input axes
>       ui: input-linux: Add absolute event support
>=20
> Wei Qi (1):
>       vnc: simple clean up
>=20
>  include/hw/virtio/virtio-gpu.h |   1 +
>  include/qemu/bitops.h          |  10 ---
>  include/ui/console.h           |   3 +
>  include/ui/egl-helpers.h       |   3 +-
>  include/ui/input.h             |  11 +--
>  hw/display/virtio-gpu-3d.c     |  16 +++++
>  hw/display/virtio-gpu.c        |  18 +----
>  hw/input/virtio-input-hid.c    |   6 +-
>  ui/egl-context.c               |   7 +-
>  ui/egl-headless.c              | 158 +++++++++++++++++++++++++++++++++++=
++++++
>  ui/egl-helpers.c               |  88 +++++++++--------------
>  ui/gtk-egl.c                   |   2 +-
>  ui/gtk.c                       |   4 +-
>  ui/input-linux.c               |  25 ++++++-
>  ui/input.c                     |  31 +++++---
>  ui/sdl.c                       |   4 +-
>  ui/sdl2.c                      |   4 +-
>  ui/spice-input.c               |   4 +-
>  ui/vnc-enc-zrle.c              |   1 -
>  ui/vnc.c                       |  10 +--
>  vl.c                           |  16 +++++
>  ui/Makefile.objs               |   1 +
>  ui/cocoa.m                     |   4 +-
>  23 files changed, 311 insertions(+), 116 deletions(-)
>  create mode 100644 ui/egl-headless.c
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGa0+AAoJEJykq7OBq3PIaxgH/jUxekCsuksotBRy/ZIh85on
VKldJCzNXjW/ZqsuOx7Z0urVjT0tl7xA18lv1EX+97r3yYaq4iaVcACsvQ/XSVp/
GRcp/y4QI9UzfyHGHM6jC0ET4S3qmVWpi3jvtS0q+lKgjzkwxQzh3tlJmwnQL42L
TUNcftpEwntLPXiHCNRc6lLm8D0Nh6r1H2QVo5qdt/jjXArOaCCiFIhd6fPpowtk
Ui+c/e3IW4J5bLanifQdLrrtr+UBCfVSOMDTSIW227/UJbCe5JkwnPaGUmYtseZD
aYajyldiPCocc8cLkcmFsBzx/DhfE5Li/yXT3jkfnAhCv2TCwJISEog6m92V8b8=
=d6JW
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
