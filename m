Received: from eggs.gnu.org ([209.51.188.92]:59053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glqH3-0006Rk-Ew
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glqH1-0001sI-I0
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:15:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glqGz-0001qp-RK
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:15:03 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 22 Jan 2019 08:08:33 +0100
Message-Id: <1548140916-6923-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v4 00/26] qtests, typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

 Hi Peter!
=20
The following changes since commit 166609e6070fab3424510ac7292ecb585f8b80=
fb:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-january=
-17-2019-v2' into staging (2019-01-21 17:53:28 +0000)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-22

for you to fetch changes up to f48a79da78eb605bb0977f930ca137e9b8bdede8:

  tests: remove rule for nonexisting qdev-monitor-test (2019-01-22 06:26:=
33 +0100)

----------------------------------------------------------------
- Use more CONFIG Makefile switches for qtests
- Get rid of global_qtests in some more qtests
- typedef cleanups
- Fixes for compiling with Clang
- Force C standard to gnu99
- Don't use -nographic in qtests
----------------------------------------------------------------

Paolo Bonzini (1):
      tests: remove rule for nonexisting qdev-monitor-test

Peter Maydell (1):
      tests/hexloader-test: Don't pass -nographic to the QEMU under test

Philippe Mathieu-Daud=C3=A9 (13):
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
      virtio-net: Fix VirtIONet typedef redefinition

Thomas Huth (11):
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

 audio/audio_int.h              |   4 +-
 block/iscsi.c                  |   2 +
 configure                      |   5 +-
 hw/intc/xics_kvm.c             |   1 +
 hw/intc/xics_spapr.c           |   1 +
 hw/ppc/spapr_irq.c             |   1 +
 include/hw/arm/pxa.h           |   1 +
 include/hw/char/serial.h       |   4 +-
 include/hw/devices.h           |   1 +
 include/hw/i2c/smbus.h         |   2 +
 include/hw/i386/pc.h           |   4 +-
 include/hw/ide/ahci.h          |   4 +-
 include/hw/input/ps2.h         |   2 +
 include/hw/pcmcia.h            |   4 +-
 include/hw/ppc/spapr.h         |   5 +-
 include/hw/ppc/spapr_xive.h    |   2 -
 include/hw/ppc/xics.h          |   7 -
 include/hw/ppc/xics_spapr.h    |  37 +++++
 include/hw/virtio/virtio-net.h |   5 +-
 include/qemu/compiler.h        |   4 +
 include/qemu/typedefs.h        |  13 --
 include/sysemu/bt.h            |   4 +-
 include/ui/console.h           |  24 +--
 include/ui/qemu-pixman.h       |  10 ++
 linux-user/qemu.h              |   6 +-
 qemu-seccomp.c                 |   3 +-
 target/ppc/cpu.h               |   9 +-
 tests/Makefile.include         |  23 ++-
 tests/boot-order-test.c        |  59 ++++----
 tests/endianness-test.c        | 329 +++++++++++++++++++++--------------=
------
 tests/hexloader-test.c         |   2 +-
 tests/pnv-xscom-test.c         |  29 ++--
 32 files changed, 321 insertions(+), 286 deletions(-)
 create mode 100644 include/hw/ppc/xics_spapr.h

 v4:
 - Rebased patches to current master (to fix conflict in the first patch)
 - Added "virtio-net: Fix VirtIONet typedef redefinition" patch
 - Added "tests: remove rule for nonexisting qdev-monitor-test"
