Received: from eggs.gnu.org ([209.51.188.92]:33998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk7sS-0006GZ-7o
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk7sQ-00064W-Fh
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:38:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gk7sO-0005tP-5T
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:38:34 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Jan 2019 14:38:09 +0100
Message-Id: <1547732292-14021-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 00/28] ivshmem deprecation, qtests,
 typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>, groug@kaod.org, clg@kaod.org, mst@redhat.com

 Hi Peter!

The following changes since commit 6f2f34177a25bffd6fd92a05e6e66c8d22d970=
94:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' in=
to staging (2019-01-15 18:32:57 +0000)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-17

for you to fetch changes up to 3f0832c85380321ef697d64342b389648f8abb1c:

  tests/hexloader-test: Don't pass -nographic to the QEMU under test (201=
9-01-17 14:25:12 +0100)

----------------------------------------------------------------
- Remove deprecated "ivshmem" legacy device
- Bug fix for vhost-user-test
- Use more CONFIG Makefile switches for qtests
- Get rid of global_qtests in some more qtests
- typedef cleanups
- Fixes for compiling with Clang
- Force C standard to gnu99
----------------------------------------------------------------

Li Qiang (3):
      tests: vhost-user-test: initialize 'fd' in chr_read
      vhost-user: fix ioeventfd_enabled
      util: check the return value of fcntl in qemu_set_{block, nonblock}

Peter Maydell (1):
      tests/hexloader-test: Don't pass -nographic to the QEMU under test

Philippe Mathieu-Daud=C3=A9 (12):
      hw/input/ps2: Remove PS2State from "qemu/typedefs.h"
      hw/pcmcia: Remove PCMCIACardState from "qemu/typedefs.h"
      hw/ide/ahci: Remove AllwinnerAHCIState from "qemu/typedefs.h"
      hw/i2c/smbus: Remove SMBusDevice from "qemu/typedefs.h"
      hw/bt: Remove HCIInfo from "qemu/typedefs.h"
      hw/char/serial: Remove SerialState from "qemu/typedefs.h"
      hw/i386: Remove PCMachineClass from "qemu/typedefs.h"
      audio: Remove AudioState from "qemu/typedefs.h"
      ui/console: Remove QemuDmaBuf from "qemu/typedefs.h"
      ui/console: Remove DisplayState/DisplaySurface from "qemu/typedefs.=
h"
      ui/console: Remove MouseTransformInfo from qemu/typedefs.h
      ui/console: Remove PixelFormat from qemu/typedefs.h

Thomas Huth (12):
      hw/misc/ivshmem: Remove deprecated "ivshmem" legacy device
      tests/Makefile: Use some more CONFIG switches for x86 tests
      tests/Makefile: Use some more CONFIG switches for ppc tests
      tests/endianesss: Make test independent of global_qtest
      tests/boot-order: Make test independent of global_qtest
      tests/pnv-xscom: Make test independent of global_qtest
      ppc: Move spapr-related prototypes from xics.h into a seperate head=
er file
      ppc: Fix duplicated typedefs to be able to compile with Clang in gn=
u99 mode
      linux-user: Fix compilation with clang 3.4
      block: Work-around a bug in libiscsi 1.9.0 when used in gnu99 mode
      seccomp: Work-around GCC 4.x bug in gnu99 mode
      configure: Force the C standard to gnu99

 audio/audio_int.h           |   4 +-
 block/iscsi.c               |   2 +
 configure                   |   5 +-
 docs/specs/ivshmem-spec.txt |   8 +-
 hw/i386/pc_piix.c           |   1 -
 hw/intc/xics_kvm.c          |   1 +
 hw/intc/xics_spapr.c        |   1 +
 hw/misc/ivshmem.c           | 210 +---------------------------
 hw/ppc/spapr_irq.c          |   1 +
 hw/virtio/vhost-user.c      |   2 +-
 include/hw/arm/pxa.h        |   1 +
 include/hw/char/serial.h    |   4 +-
 include/hw/devices.h        |   1 +
 include/hw/i2c/smbus.h      |   2 +
 include/hw/i386/pc.h        |   4 +-
 include/hw/ide/ahci.h       |   4 +-
 include/hw/input/ps2.h      |   2 +
 include/hw/pcmcia.h         |   4 +-
 include/hw/ppc/spapr.h      |   5 +-
 include/hw/ppc/spapr_xive.h |   2 -
 include/hw/ppc/xics.h       |   7 -
 include/hw/ppc/xics_spapr.h |  37 +++++
 include/qemu/compiler.h     |   4 +
 include/qemu/typedefs.h     |  13 --
 include/sysemu/bt.h         |   4 +-
 include/ui/console.h        |  24 ++--
 include/ui/qemu-pixman.h    |  10 ++
 linux-user/qemu.h           |   6 +-
 qemu-deprecated.texi        |   5 -
 qemu-seccomp.c              |   3 +-
 scripts/device-crash-test   |   1 -
 target/ppc/cpu.h            |   9 +-
 tests/Makefile.include      |  22 +--
 tests/boot-order-test.c     |  59 ++++----
 tests/endianness-test.c     | 329 ++++++++++++++++++++++----------------=
------
 tests/hexloader-test.c      |   2 +-
 tests/ivshmem-test.c        |  67 ++++-----
 tests/pnv-xscom-test.c      |  29 ++--
 tests/vhost-user-test.c     |   2 +-
 util/oslib-posix.c          |   8 +-
 40 files changed, 361 insertions(+), 544 deletions(-)
 create mode 100644 include/hw/ppc/xics_spapr.h
