Received: from eggs.gnu.org ([2001:4830:134:3::10]:53191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7mUX-00005G-PA
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7mUU-0002ic-IA
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:30:37 -0400
Date: Mon, 8 May 2017 13:30:31 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508173031.GK22428@stefanha-x1.localdomain>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] [PULL 00/23] Trivial patches for 2017-05-07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 07, 2017 at 10:02:03AM +0300, Michael Tokarev wrote:
> The following changes since commit 12a95f320a36ef66f724a49bb05e4fb553ac5d=
be:
>=20
>   Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (20=
17-05-04 13:44:32 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.corpit.ru/qemu.git tags/trivial-patches-fetch
>=20
> for you to fetch changes up to 311875781e549af91a3216d34c6ef40420bab435:
>=20
>   tests: Remove redundant assignment (2017-05-07 09:57:51 +0300)
>=20
> ----------------------------------------------------------------
> trivial patches for 2017-05-07
>=20
> ----------------------------------------------------------------
> Andreas Grapentin (1):
>       use _Static_assert in QEMU_BUILD_BUG_ON
>=20
> Chris Webb (1):
>       virtfs: allow a device id to be specified in the -virtfs option
>=20
> Craig Jellick (1):
>       Add 'none' as type for drive's if option
>=20
> Eric Blake (2):
>       tests: Ignore more test executables
>       tests: Ignore another built executable (test-hmp)
>=20
> Fam Zheng (3):
>       block: Make 'replication_state' an enum
>       virtio-blk: Remove useless condition around g_free()
>       tests: Remove redundant assignment
>=20
> Ishani Chugh (1):
>       Remove reduntant qemu: from error functions
>=20
> KONRAD Frederic (1):
>       ppc_booke: drop useless assignment
>=20
> Kamil Rytarowski (2):
>       scripts/qemu-binfmt-conf.sh: Fix shell portability issue
>       scripts: Switch to more portable Perl shebang
>=20
> Marc-Andr=E9 Lureau (1):
>       doc: fix function spelling
>=20
> Paolo Bonzini (3):
>       jazz_led: fix bad snprintf
>       MAINTAINERS: Update paths for main loop
>       MAINTAINERS: Update paths for AioContext implementation
>=20
> Philippe Mathieu-Daud=E9 (3):
>       usb-ccid: make ccid_write_data_block() cope with null buffers
>       device_tree: fix compiler warnings (clang 5)
>       qga: fix compiler warnings (clang 5)
>=20
> Saurav Sachidanand (1):
>       util: Use g_malloc/g_free in envlist.c
>=20
> Thomas Huth (2):
>       qemu-doc: Fix broken URLs of amnhltm.zip and dosidle210.zip
>       hw/core/generic-loader: Fix crash when running without CPU
>=20
> sochin.jiang fix wrong parameter comments in channel-file.h (1):
>       channel-file: fix wrong parameter comments
>=20
>  MAINTAINERS                     |  8 +++----
>  block/replication.c             | 44 +++++++++++++++++++----------------=
---
>  bsd-user/main.c                 | 14 ++++--------
>  configure                       | 18 ++++++++++++++++
>  device_tree.c                   |  1 +
>  hw/block/virtio-blk.c           |  4 +---
>  hw/core/generic-loader.c        |  9 ++++----
>  hw/display/jazz_led.c           |  4 ++--
>  hw/microblaze/boot.c            |  2 +-
>  hw/nios2/boot.c                 |  2 +-
>  hw/ppc/pnv.c                    |  2 +-
>  hw/ppc/ppc_booke.c              |  1 -
>  hw/s390x/sclp.c                 |  4 ++--
>  hw/tricore/tricore_testboard.c  |  2 +-
>  hw/usb/dev-smartcard-reader.c   |  5 ++++-
>  include/io/channel-file.h       |  2 +-
>  include/io/channel.h            |  2 +-
>  include/qemu/compiler.h         |  4 +++-
>  linux-user/main.c               |  9 +++-----
>  numa.c                          |  4 ++--
>  qemu-doc.texi                   | 10 ++++-----
>  qemu-options.hx                 |  4 ++--
>  qga/commands-posix.c            |  8 ++++---
>  scripts/checkpatch.pl           |  3 ++-
>  scripts/clean-header-guards.pl  |  3 ++-
>  scripts/cleanup-trace-events.pl |  2 +-
>  scripts/disas-objdump.pl        |  4 +++-
>  scripts/get_maintainer.pl       |  3 ++-
>  scripts/qemu-binfmt-conf.sh     |  4 ++--
>  scripts/shaderinclude.pl        |  2 +-
>  scripts/switch-timer-api        |  2 +-
>  scripts/texi2pod.pl             |  4 +++-
>  tests/.gitignore                |  4 ++++
>  tests/postcopy-test.c           |  2 +-
>  util/envlist.c                  | 47 +++++++++++++++++------------------=
------
>  vl.c                            |  5 +++--
>  36 files changed, 133 insertions(+), 115 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEKs3AAoJEJykq7OBq3PIHuUIAIYvcrcbY2VFJTI14Iu/+/HF
LmzNhvMWNXAACx18aeAoAopNmyW2VK0xh7PoNI+0ViDECrBtKe0YuHvrBhk5lfHt
s9Wq3cZhSL4tNYCQA09qW38OQEsp9lxlNP2J/aCfmaZrr0CEgwmLnzKzVTaqbfV6
sZaVnmthaj/0Z0UEODV6dzQZn5QaW4t0cxQbKSJFK/+aJRLMm6SBFpt1EfSIeWfi
IaZbD6+LLxSo9EWNlgdl+//koUZb06bAIDdC8tjgB1+DQQ1y9R7yldstFLNXYbY7
WZR/V011REsjfbhbeNclUfjuZ46JkQFEHWzYzWSI4aoO+hxWAGUbLMMrIyldxLs=
=SKG0
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
