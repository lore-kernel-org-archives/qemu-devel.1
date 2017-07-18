Received: from eggs.gnu.org ([2001:4830:134:3::10]:56692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLi8-0002Dq-AZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLi7-00038L-46
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:10:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:36 -0300
Message-Id: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/29] coccinelle script to enforce
 qemu/osdep.h macros usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi,

Another cocci script... Here the idea is to have the same script with all the
osdep.h macros related rules altogether.

First run with QEMU_IS_ALIGNED() and ARRAY_SIZE().

Regards,

Phil.

PD: I used the "enforce" word because I plan to have some continuous integration
job running such scripts (also the clang-tidy good stuff).

Philippe Mathieu-Daudé (29):
  coccinelle: add a script to enforce qemu/osdep.h macros usage
  pci: remove superfluous parenthesis
  qemu-img: use QEMU_IS_ALIGNED macro
  scsi-disk: use QEMU_IS_ALIGNED macro
  block: use QEMU_IS_ALIGNED macro
  migration/block: use QEMU_IS_ALIGNED macro
  ds1338: use QEMU_IS_ALIGNED macro
  ui: use QEMU_IS_ALIGNED macro
  net: use QEMU_IS_ALIGNED macro
  net/rocker: use QEMU_IS_ALIGNED macro
  s390x/sclp: use QEMU_IS_ALIGNED macro
  sm501: use QEMU_IS_ALIGNED macro
  tcg: use QEMU_IS_ALIGNED macro
  cris: use QEMU_IS_ALIGNED macro
  microblaze: use QEMU_IS_ALIGNED macro
  lm32: use QEMU_IS_ALIGNED macro
  sparc: use QEMU_IS_ALIGNED macro
  nios2: use QEMU_IS_ALIGNED macro
  disas: use QEMU_IS_ALIGNED macro
  disas: use ARRAY_SIZE macro
  qga: use ARRAY_SIZE macro
  vmsvga: use ARRAY_SIZE macro
  async: use ARRAY_SIZE macro
  tests/acpi: use ARRAY_SIZE macro
  tests/qos: use ARRAY_SIZE macro
  tests/tcg: use ARRAY_SIZE macro
  tests/hbitmap: use ARRAY_SIZE macro
  tests/qapi: use QEMU_IS_ALIGNED macro
  tests/qapi: use ARRAY_SIZE macro

 accel/tcg/translate-all.c           |  2 +-
 block/io.c                          |  4 +--
 block/qcow2-cache.c                 |  2 +-
 block/vhdx-log.c                    |  2 +-
 block/vvfat.c                       |  2 +-
 disas.c                             |  2 +-
 disas/ia64.c                        |  4 +--
 disas/m68k.c                        |  5 ++--
 disas/ppc.c                         | 12 +++-----
 disas/s390.c                        |  3 +-
 hw/display/sm501_template.h         |  2 +-
 hw/display/vmware_vga.c             |  5 ++--
 hw/misc/pci-testdev.c               |  4 +--
 hw/net/rocker/rocker.c              |  2 +-
 hw/s390x/sclp.c                     |  4 +--
 hw/scsi/scsi-disk.c                 |  4 +--
 hw/timer/ds1338.c                   |  4 +--
 migration/block.c                   |  2 +-
 net/eth.c                           |  2 +-
 qemu-img.c                          |  2 +-
 qga/commands-posix.c                |  2 +-
 scripts/coccinelle/use_osdep.cocci  | 60 +++++++++++++++++++++++++++++++++++++
 target/cris/translate.c             |  6 ++--
 target/lm32/translate.c             |  2 +-
 target/microblaze/op_helper.c       |  3 +-
 target/microblaze/translate.c       |  3 +-
 target/nios2/translate.c            |  2 +-
 target/sparc/cpu.c                  |  4 +--
 tests/acpi-utils.h                  |  2 +-
 tests/libqos/libqos.c               |  2 +-
 tests/tcg/alpha/test-cond.c         |  2 +-
 tests/tcg/alpha/test-ovf.c          |  2 +-
 tests/test-hbitmap.c                |  6 ++--
 tests/test-qobject-output-visitor.c |  2 +-
 tests/test-string-output-visitor.c  |  2 +-
 ui/console-gl.c                     |  2 +-
 util/aio-posix.c                    |  2 +-
 37 files changed, 114 insertions(+), 59 deletions(-)
 create mode 100644 scripts/coccinelle/use_osdep.cocci

-- 
2.13.2
