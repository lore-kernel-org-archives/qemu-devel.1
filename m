Received: from eggs.gnu.org ([2001:4830:134:3::10]:41521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVIBf-0003nN-4V
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVIBZ-0002vo-8I
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:00:19 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Wed, 12 Jul 2017 17:00:11 +0300
Message-Id: <cover.1499867930.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/11] Trivial patches for 2017-07-12 (#2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

The same but without two patches from Eric Blake.
Not resending all the patches, only the cover letter.

The following changes since commit 6b06e3e49eb8c91cc286c16d6bf3181ac296f3=
3d:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-10-v2=
' into staging (2017-07-10 16:12:47 +0100)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to a7a305aee1e9a74a3f4b263aa98babed795b1f0a:

  include/hw/ptimer.h: Add documentation comments (2017-07-11 17:44:27 +0=
300)

----------------------------------------------------------------
trivial patches for 2017-07-12

----------------------------------------------------------------
Li Ping (1):
      qga-win32: Fix memory leak of device information set

Mao Zhongyi (1):
      util/qemu-sockets: Drop unused helper socket_address_to_string()

Max Filippov (1):
      target/xtensa: gdbstub: drop dead return statement

Paolo Bonzini (1):
      hxtool: remove dead -q option

Peter Maydell (2):
      configure: Handle having no c++ compiler in FORTIFY_SOURCE check
      include/hw/ptimer.h: Add documentation comments

Philippe Mathieu-Daud=C3=A9 (4):
      hw/misc: add missing includes
      hw/pci: define msi_nonbroken in pci-stub
      elf-loader: warn about invalid endianness
      hw/core: fix missing return value in load_image_targphys_as()

Thomas Huth (1):
      configure: Fix build with pkg-config and --static --enable-sdl

 configure               |   8 +++-
 hw/core/loader.c        |   5 +-
 hw/pci/pci-stub.c       |   3 ++
 include/hw/misc/unimp.h |   2 +
 include/hw/ptimer.h     | 120 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/qemu/sockets.h  |  15 ------
 qga/commands-win32.c    |   5 +-
 scripts/hxtool          |  46 +------------------
 target/xtensa/gdbstub.c |   1 -
 util/qemu-sockets.c     |  34 --------------
 10 files changed, 140 insertions(+), 99 deletions(-)
