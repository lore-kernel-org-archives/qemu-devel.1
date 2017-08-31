Received: from eggs.gnu.org ([2001:4830:134:3::10]:40564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMo5-00015L-Nr
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMo2-0005Aq-MP
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:34:41 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 Aug 2017 12:34:03 +0200
Message-Id: <20170831103432.6007-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/29] Code cleanup patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit 1201d308519f1e915866d7583d5136d03cc1d3=
84:

  slirp: fix clearing ifq_so from pending packets (2017-08-30 23:14:34 +0=
100)

are available in the git repository at:

  https://github.com/elmarco/qemu.git tags/tidy-pull-request

for you to fetch changes up to e4d67e4f2e06128bc7f07263afe9acc2e2242fdc:

  eepro100: replace g_malloc()+memcpy() with g_memdup() (2017-08-31 12:29=
:07 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (29):
  i386: use ROUND_UP macro
  vnc: use QEMU_ALIGN_DOWN
  vhdx: use QEMU_ALIGN_DOWN
  vhost: use QEMU_ALIGN_DOWN
  i8254: use QEMU_ALIGN_DOWN
  pcspk: use QEMU_ALIGN_DOWN
  dmg: use DIV_ROUND_UP
  qcow2: use DIV_ROUND_UP
  vpc: use DIV_ROUND_UP
  vvfat: use DIV_ROUND_UP
  vnc: use DIV_ROUND_UP
  ui: use DIV_ROUND_UP
  vga: use DIV_ROUND_UP
  virtio-gpu: use DIV_ROUND_UP
  monitor: use DIV_ROUND_UP
  console: use DIV_ROUND_UP
  virtio-serial: use DIV_ROUND_UP
  piix: use DIV_ROUND_UP
  q35: use DIV_ROUND_UP
  usb-hub: use DIV_ROUND_UP
  msix: use DIV_ROUND_UP
  ppc: use DIV_ROUND_UP
  i386/dump: use DIV_ROUND_UP
  kvm: use DIV_ROUND_UP
  decnumber: use DIV_ROUND_UP
  i386: introduce ELF_NOTE_SIZE macro
  i386: replace g_malloc()+memcpy() with g_memdup()
  test-iov: replace g_malloc()+memcpy() with g_memdup()
  eepro100: replace g_malloc()+memcpy() with g_memdup()

 include/ui/console.h        |  2 +-
 linux-headers/asm-x86/kvm.h |  2 +-
 block/dmg.c                 |  2 +-
 block/qcow2-cluster.c       |  2 +-
 block/vhdx-log.c            |  2 +-
 block/vpc.c                 |  4 ++--
 block/vvfat.c               |  4 ++--
 hw/audio/pcspk.c            |  2 +-
 hw/char/virtio-serial-bus.c |  8 ++++----
 hw/display/vga.c            |  2 +-
 hw/display/virtio-gpu.c     |  4 ++--
 hw/i386/multiboot.c         |  3 +--
 hw/net/eepro100.c           |  3 +--
 hw/pci-host/piix.c          |  2 +-
 hw/pci-host/q35.c           |  2 +-
 hw/pci/msix.c               |  4 ++--
 hw/timer/i8254_common.c     |  4 ++--
 hw/usb/dev-hub.c            |  8 ++++----
 hw/virtio/vhost.c           |  2 +-
 libdecnumber/decNumber.c    |  2 +-
 monitor.c                   |  4 ++--
 target/i386/arch_dump.c     | 40 ++++++++++++++++++++-------------------=
-
 target/ppc/mem_helper.c     |  2 +-
 target/ppc/translate.c      |  2 +-
 tests/test-iov.c            |  3 +--
 ui/cursor.c                 |  2 +-
 ui/vnc-enc-tight.c          |  2 +-
 ui/vnc.c                    | 10 +++++-----
 28 files changed, 63 insertions(+), 66 deletions(-)

--=20
2.14.1.146.gd35faa819
