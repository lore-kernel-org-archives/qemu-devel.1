Received: from eggs.gnu.org ([2001:4830:134:3::10]:41760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOyz-0004ps-CU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOyu-000465-VB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOyu-00044Y-NU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:18:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:38 -0300
Message-Id: <20170919201850.14772-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/12] Machine/CPU/NUMA queue, 2017-09-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The following changes since commit a9158a5cba955b79d580a252cc58ff44d154e3=
70:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20170918-pull-r=
equest' into staging (2017-09-18 12:40:54 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to e3d038b89f1bf3f09da4d59aa16b16e8305e1a05:

  MAINTAINERS: Update git URLs for my trees (2017-09-19 16:53:13 -0300)

----------------------------------------------------------------
Machine/CPU/NUMA queue, 2017-09-19

----------------------------------------------------------------

Dou Liyang (1):
  NUMA: Replace MAX_NODES with nb_numa_nodes in for loop

Eduardo Habkost (5):
  vl: Clean up user-creatable objects when exiting
  osdep: Define QEMU_MADV_REMOVE
  hostmem-file: Add "discard-data" option
  hw/acpi-build: Fix SRAT memory building in case of node 0 without RAM
  MAINTAINERS: Update git URLs for my trees

Igor Mammedov (6):
  qom: cpus: split cpu_generic_init() on feature parsing and cpu
    creation parts
  cpu: make cpu_generic_init() abort QEMU on error
  vl.c: convert cpu_model to cpu type and set of global properties
    before machine_init()
  pc: use generic cpu_model parsing
  arm: drop intermediate cpu_model -> cpu type parsing and use cpu type
    directly
  numa: cpu: calculate/set default node-ids after all -numa CLI options
    are parsed

 include/hw/arm/armv7m.h         |  4 +--
 include/hw/arm/aspeed_soc.h     |  2 +-
 include/hw/arm/stm32f205_soc.h  |  2 +-
 include/hw/boards.h             | 10 +++++++
 include/qemu/osdep.h            |  7 +++++
 include/qom/cpu.h               | 22 +++++++++++++++
 include/qom/object_interfaces.h |  8 ++++++
 target/arm/cpu.h                |  3 ++
 target/i386/cpu.h               |  9 ++++++
 backends/hostmem-file.c         | 29 ++++++++++++++++++++
 bsd-user/main.c                 |  4 ---
 hw/alpha/dp264.c                |  4 ---
 hw/arm/armv7m.c                 | 40 ++++-----------------------
 hw/arm/aspeed_soc.c             | 13 ++++-----
 hw/arm/collie.c                 | 10 ++-----
 hw/arm/exynos4210.c             |  6 +---
 hw/arm/gumstix.c                |  5 ++--
 hw/arm/highbank.c               | 10 +++----
 hw/arm/integratorcp.c           | 30 ++------------------
 hw/arm/mainstone.c              |  9 +++---
 hw/arm/mps2.c                   | 17 +++++-------
 hw/arm/musicpal.c               | 11 ++------
 hw/arm/netduino2.c              |  2 +-
 hw/arm/nseries.c                |  4 ++-
 hw/arm/omap1.c                  | 11 ++------
 hw/arm/omap2.c                  |  8 ++----
 hw/arm/omap_sx1.c               |  5 +++-
 hw/arm/palm.c                   |  5 ++--
 hw/arm/pxa2xx.c                 | 18 +++---------
 hw/arm/realview.c               | 25 ++++-------------
 hw/arm/spitz.c                  | 12 ++++----
 hw/arm/stellaris.c              | 16 +++++------
 hw/arm/stm32f205_soc.c          |  4 +--
 hw/arm/strongarm.c              | 15 ++--------
 hw/arm/tosa.c                   |  4 ---
 hw/arm/versatilepb.c            | 15 ++--------
 hw/arm/vexpress.c               | 32 +++++++--------------
 hw/arm/virt.c                   | 60 ++++++++++-------------------------=
-----
 hw/arm/xilinx_zynq.c            | 10 ++-----
 hw/arm/z2.c                     |  9 ++----
 hw/core/machine.c               |  1 +
 hw/i386/acpi-build.c            | 28 +++++++++++++++----
 hw/i386/pc.c                    | 61 +++++++++++------------------------=
------
 hw/i386/pc_piix.c               |  4 +--
 hw/lm32/lm32_boards.c           |  8 ------
 hw/lm32/milkymist.c             |  4 ---
 hw/m68k/an5206.c                |  4 ---
 hw/m68k/mcf5208.c               |  4 ---
 hw/mips/cps.c                   |  4 ---
 hw/mips/mips_fulong2e.c         |  4 ---
 hw/mips/mips_jazz.c             |  4 ---
 hw/mips/mips_malta.c            |  4 ---
 hw/mips/mips_mipssim.c          |  4 ---
 hw/mips/mips_r4k.c              |  4 ---
 hw/moxie/moxiesim.c             |  4 ---
 hw/openrisc/openrisc_sim.c      |  4 ---
 hw/ppc/e500.c                   |  4 ---
 hw/ppc/mac_newworld.c           |  4 ---
 hw/ppc/mac_oldworld.c           |  4 ---
 hw/ppc/ppc440_bamboo.c          |  4 ---
 hw/ppc/ppc4xx_devs.c            |  5 ----
 hw/ppc/prep.c                   |  9 ------
 hw/ppc/spapr.c                  | 15 ++++------
 hw/ppc/virtex_ml507.c           |  4 ---
 hw/sh4/r2d.c                    |  4 ---
 hw/sh4/shix.c                   |  4 ---
 hw/sparc/leon3.c                |  4 ---
 hw/sparc/sun4m.c                |  4 ---
 hw/sparc64/sparc64.c            |  4 ---
 hw/tricore/tricore_testboard.c  |  4 ---
 hw/unicore32/puv3.c             |  4 ---
 hw/xtensa/sim.c                 |  5 ----
 hw/xtensa/xtfpga.c              |  5 ----
 linux-user/main.c               |  4 ---
 numa.c                          |  2 +-
 qom/cpu.c                       | 49 ++++++++++++++++++---------------
 qom/object_interfaces.c         |  5 ++++
 target/arm/cpu.c                |  2 +-
 target/i386/cpu.c               |  3 --
 vl.c                            | 11 ++++++++
 MAINTAINERS                     |  5 +++-
 qemu-options.hx                 |  8 +++++-
 82 files changed, 307 insertions(+), 525 deletions(-)

--=20
2.13.5
