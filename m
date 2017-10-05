Received: from eggs.gnu.org ([2001:4830:134:3::10]:48714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0Csw-0001TH-Fu
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0Csr-0008Vf-TB
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:36:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0Csr-0008Uy-K4
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:36:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  5 Oct 2017 17:36:29 -0300
Message-Id: <20171005203638.19255-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

The following changes since commit d8f932cc696250cb740240d668b39df5fbb2d5=
a0:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2017-10-05 16:54:29 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to 7d7e9c4fd6873d9624956cbe0a5cbfae59b7f8af:

  x86: Correct translation of some rdgsbase and wrgsbase encodings (2017-=
10-05 17:30:06 -0300)

----------------------------------------------------------------
x86 and machine queue, 2017-10-05

Includes x86, NUMA, ACPI, QOM, CPU, and option/config parsing
patches.

Highlights:
* Deprecation of -nodefconfig option;
* MachineClass::valid_cpu_types field.

----------------------------------------------------------------

Alistair Francis (1):
  machine: Add a valid_cpu_types property

Dou Liyang (2):
  hw/acpi-build: Make assignment statement of next_base easy to read
  ACPI/unit-test: Add a new testcase for RAM allocation in numa node

Eduardo Habkost (3):
  vl: Eliminate defconfig variable
  qemu-options: Deprecate -nodefconfig
  config: qemu_config_parse() return number of config groups

Igor Mammedov (1):
  qom: update doc comment for type_register[_static]()

Philippe Mathieu-Daud=C3=A9 (1):
  qom/cpu: move cpu_model null check to cpu_class_by_name()

Todd Eisenberger (1):
  x86: Correct translation of some rdgsbase and wrgsbase encodings

 include/hw/boards.h                   |   1 +
 include/qom/object.h                  |   4 ++--
 block/blkdebug.c                      |   1 -
 hw/core/machine.c                     |  32 ++++++++++++++++++++++++++++=
++++
 hw/i386/acpi-build.c                  |   2 +-
 qom/cpu.c                             |   7 ++++++-
 target/alpha/cpu.c                    |   6 +-----
 target/arm/cpu.c                      |   4 ----
 target/cris/cpu.c                     |   4 ----
 target/i386/translate.c               |   4 ++--
 target/lm32/cpu.c                     |   4 ----
 target/m68k/cpu.c                     |   4 ----
 target/mips/cpu.c                     |   4 ----
 target/moxie/cpu.c                    |   8 +-------
 target/openrisc/cpu.c                 |   4 ----
 target/sh4/cpu.c                      |   3 ---
 target/sparc/cpu.c                    |   4 ----
 target/tricore/cpu.c                  |   4 ----
 target/unicore32/cpu.c                |   4 ----
 target/xtensa/cpu.c                   |   4 ----
 tests/bios-tables-test.c              |  24 ++++++++++++++++++++++++
 util/qemu-config.c                    |  15 +++++++--------
 vl.c                                  |   5 +----
 qemu-doc.texi                         |   4 ++++
 qemu-options.hx                       |  17 ++++-------------
 tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 5104 bytes
 tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 7788 bytes
 tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 224 bytes
 29 files changed, 86 insertions(+), 87 deletions(-)
 create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
 create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
 create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
 create mode 100644 tests/acpi-test-data/q35/SRAT.numamem

--=20
2.13.6
