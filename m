Received: from eggs.gnu.org ([2001:4830:134:3::10]:43457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHck-0001XO-4J
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHch-0005KB-6H
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:15:18 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:14:46 +0300
Message-Id: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/22] Trivial patches for 2018-05-20
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

Hello!

This is a next trivial-patches pull request. It's been a while
since the last pull, and quite some changes has been accumulated.

Please consider pulling/applying.

Thanks,

/mjt

The following changes since commit 5bcf917ee37a5efbef99f091a96db54a5276be=
cb:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80518' into staging (2018-05-18 18:25:29 +0100)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to 9a232487aab8a7640ff8853d7d8d7c27106b44f8:

  acpi: fix a comment about aml_call0() (2018-05-20 08:58:58 +0300)

----------------------------------------------------------------
trivial patches for 2018-05-20

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      slirp/debug: Print IP addresses in human readable form

Daniel P. Berrang=C3=A9 (1):
      misc, ide: remove use of HWADDR_PRIx in trace events

Emilio G. Cota (1):
      tcg: fix s/compliment/complement/ typos

John Snow (5):
      qemu-img-commands.hx: argument ordering fixups
      qemu-img.texi: fix command ordering
      qemu-img: remove references to GEN_DOCS
      qemu-img: Make documentation between .texi and .hx consistent
      qemu-img-cmds.hx: add passive-aggressive note

Laurent Vivier (1):
      Remove unnecessary variables for function return value

Marc-Andr=C3=A9 Lureau (2):
      tests: fix tpm-crb tpm-tis tests race
      acpi: fix a comment about aml_call0()

Michael Tokarev (1):
      qemu-option-trace: -trace enable=3D is a pattern, not a file

Michal Privoznik (1):
      qemu-options: Allow -no-user-config again

Murilo Opsfelder Araujo (1):
      HACKING: document preference for g_new instead of g_malloc

Olaf Hering (1):
      replace functions which are only available in glib-2.24

Peter Maydell (2):
      gdbstub: Use qemu_set_cloexec()
      gdbstub: Handle errors in gdb_accept()

Philippe Mathieu-Daud=C3=A9 (2):
      hw/ide/ahci: Keep ALLWINNER_AHCI() macro internal
      typedefs: Remove PcGuestInfo from qemu/typedefs.h

Thomas Huth (3):
      trivial: Do not include pci.h if it is not necessary
      hw/timer/mt48t59: Fix bit-rotten NVRAM_PRINTF format strings
      qapi/net.json: Fix the version number of the "vlan" removal

 HACKING                                            |  9 +++
 accel/tcg/translate-all.c                          |  5 +-
 block/quorum.c                                     |  6 +-
 gdbstub.c                                          | 24 ++++---
 hw/acpi/aml-build.c                                |  2 +-
 hw/arm/exynos4210.c                                |  6 +-
 hw/block/vhost-user-blk.c                          |  5 +-
 hw/hppa/dino.c                                     |  5 +-
 hw/ide/ahci-allwinner.c                            |  3 +
 hw/ide/ahci_internal.h                             |  3 -
 hw/ide/trace-events                                |  4 +-
 hw/misc/mos6522.c                                  |  8 +--
 hw/misc/trace-events                               |  8 +--
 hw/net/ftgmac100.c                                 |  5 +-
 hw/ppc/pnv_lpc.c                                   | 16 ++---
 hw/timer/m48t59-internal.h                         |  9 +--
 hw/timer/m48t59.c                                  |  4 +-
 include/hw/ppc/ppc4xx.h                            |  2 -
 include/hw/virtio/virtio-balloon.h                 |  1 -
 include/hw/virtio/virtio-gpu.h                     |  1 -
 include/qemu/typedefs.h                            |  1 -
 io/net-listener.c                                  |  6 +-
 qapi/net.json                                      |  4 +-
 qemu-img-cmds.hx                                   | 13 ++--
 qemu-img.c                                         |  2 -
 qemu-img.texi                                      | 78 +++++++++++-----=
------
 qemu-option-trace.texi                             |  5 +-
 qemu-options-wrapper.h                             |  1 -
 slirp/arp_table.c                                  |  4 +-
 slirp/socket.c                                     |  8 +--
 slirp/udp.c                                        |  4 +-
 target/i386/hax-darwin.c                           | 10 +--
 target/i386/translate.c                            |  2 +-
 target/m68k/translate.c                            |  2 +-
 target/mips/dsp_helper.c                           | 15 +----
 target/xtensa/core-dc232b/xtensa-modules.inc.c     | 56 ++++------------
 target/xtensa/core-dc233c/xtensa-modules.inc.c     | 56 ++++------------
 target/xtensa/core-de212/xtensa-modules.inc.c      | 48 ++++---------
 target/xtensa/core-fsf/xtensa-modules.inc.c        | 32 +++------
 .../core-sample_controller/xtensa-modules.inc.c    | 24 ++-----
 target/xtensa/translate.c                          |  7 +-
 tcg/README                                         |  2 +-
 tests/m48t59-test.c                                |  6 +-
 tests/test-thread-pool.c                           |  6 +-
 tests/tpm-emu.c                                    |  2 +-
 util/uri.c                                         |  5 +-
 util/vfio-helpers.c                                |  6 +-
 vl.c                                               |  4 ++
 48 files changed, 187 insertions(+), 348 deletions(-)
