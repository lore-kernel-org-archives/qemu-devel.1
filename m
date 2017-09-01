Received: from eggs.gnu.org ([2001:4830:134:3::10]:40664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTk-0007m9-GN
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTf-0002rJ-Fl
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnTf-0002r5-7m
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:02:48 -0300
Message-Id: <20170901150317.10380-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/29] x86 & cpu queue, 2017-09-01
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

The following changes since commit 223cd0e13f2e46078d7b573f0b8402bfbee339=
be:

  Merge remote-tracking branch 'remotes/elmarco/tags/tidy-pull-request' i=
nto staging (2017-08-31 15:52:43 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to 84efa64c6092232dec06583d2ce104587a70e7fc:

  ppc: replace cpu_ppc_init() with cpu_generic_init() (2017-09-01 11:54:2=
5 -0300)

----------------------------------------------------------------
x86, cpu queue, 2017-09-01

CPU creation refactor plus x86 patches.

----------------------------------------------------------------

Brijesh Singh (1):
  target-i386/cpu: Add new EPYC CPU model

Eduardo Habkost (2):
  qom: Remove unused errp parameter from can_be_deleted()
  cpu: cpu_by_arch_id() helper

Igor Mammedov (25):
  qom: cpu: fix parsed feature string length
  sparc: convert cpu models to SPARC cpu subclasses
  sparc: embed sparc_def_t into CPUSPARCState
  sparc: convert cpu features to qdev properties
  sparc: move adhoc CPUSPARCState initialization to realize time
  sparc: make cpu feature parsing property based
  sparc: replace cpu_sparc_init() with cpu_generic_init()
  s390x: replace cpu_s390x_init() with cpu_generic_init()
  alpha: replace cpu_alpha_init() with cpu_generic_init()
  hppa: replace cpu_hppa_init() with cpu_generic_init()
  m68k: replace cpu_m68k_init() with cpu_generic_init()
  microblaze: replace cpu_mb_init() with cpu_generic_init()
  nios2: replace cpu_nios2_init() with cpu_generic_init()
  tilegx: replace cpu_tilegx_init() with cpu_generic_init()
  xtensa: replace cpu_xtensa_init() with cpu_generic_init()
  tricore: replace cpu_tricore_init() with cpu_generic_init()
  sh4: replace cpu_sh4_init() with cpu_generic_init()
  arm: replace cpu_arm_init() with cpu_generic_init()
  cris: replace cpu_cris_init() with cpu_generic_init()
  x86: replace cpu_x86_init() with cpu_generic_init()
  lm32: replace cpu_lm32_init() with cpu_generic_init()
  moxie: replace cpu_moxie_init() with cpu_generic_init()
  openrisc: replace cpu_openrisc_init() with cpu_generic_init()
  unicore32: replace uc32_cpu_init() with cpu_generic_init()
  ppc: replace cpu_ppc_init() with cpu_generic_init()

Yi Wang (1):
  hmp: allow apic-id for "info lapic"

 include/qom/cpu.h                 |  10 +
 include/qom/object_interfaces.h   |   5 +-
 linux-user/sparc/target_syscall.h |   2 +-
 target/alpha/cpu.h                |   4 +-
 target/arm/cpu.h                  |   3 +-
 target/cris/cpu.h                 |   3 +-
 target/hppa/cpu.h                 |   4 +-
 target/i386/cpu.h                 |   3 +-
 target/lm32/cpu.h                 |   3 +-
 target/m68k/cpu.h                 |   3 +-
 target/microblaze/cpu.h           |   3 +-
 target/moxie/cpu.h                |   3 +-
 target/nios2/cpu.h                |   3 +-
 target/openrisc/cpu.h             |   4 +-
 target/ppc/cpu.h                  |   3 +-
 target/s390x/cpu.h                |   3 +-
 target/sh4/cpu.h                  |   3 +-
 target/sparc/cpu-qom.h            |   2 +
 target/sparc/cpu.h                |  11 +-
 target/tilegx/cpu.h               |   4 +-
 target/tricore/cpu.h              |   4 +-
 target/unicore32/cpu.h            |   4 +-
 target/xtensa/cpu.h               |   4 +-
 backends/cryptodev.c              |   2 +-
 backends/hostmem.c                |   2 +-
 hw/alpha/dp264.c                  |   8 +-
 hw/arm/musicpal.c                 |   2 +-
 hw/arm/omap1.c                    |   2 +-
 hw/arm/omap2.c                    |   2 +-
 hw/arm/pxa2xx.c                   |   4 +-
 hw/arm/strongarm.c                |   2 +-
 hw/cris/axis_dev88.c              |   2 +-
 hw/lm32/lm32_boards.c             |   4 +-
 hw/lm32/milkymist.c               |   2 +-
 hw/m68k/an5206.c                  |   2 +-
 hw/m68k/mcf5208.c                 |   2 +-
 hw/moxie/moxiesim.c               |   2 +-
 hw/nios2/10m50_devboard.c         |   2 +-
 hw/openrisc/openrisc_sim.c        |   2 +-
 hw/ppc/e500.c                     |   3 +-
 hw/ppc/mac_newworld.c             |   3 +-
 hw/ppc/mac_oldworld.c             |   3 +-
 hw/ppc/ppc440_bamboo.c            |   2 +-
 hw/ppc/ppc4xx_devs.c              |   2 +-
 hw/ppc/prep.c                     |   5 +-
 hw/ppc/virtex_ml507.c             |   2 +-
 hw/sh4/r2d.c                      |   2 +-
 hw/sh4/shix.c                     |   2 +-
 hw/sparc/leon3.c                  |   2 +-
 hw/sparc/sun4m.c                  |   2 +-
 hw/sparc64/sparc64.c              |   2 +-
 hw/tricore/tricore_testboard.c    |   2 +-
 hw/unicore32/puv3.c               |   2 +-
 hw/xtensa/sim.c                   |   2 +-
 hw/xtensa/xtfpga.c                |   2 +-
 qom/cpu.c                         |  25 +--
 qom/object_interfaces.c           |   6 +-
 target/alpha/cpu.c                |  20 +-
 target/arm/helper.c               |   5 -
 target/cris/cpu.c                 |   5 -
 target/hppa/cpu.c                 |  11 +-
 target/i386/cpu.c                 |  49 ++++-
 target/i386/monitor.c             |  10 +-
 target/lm32/helper.c              |   5 -
 target/m68k/cpu.c                 |   2 +
 target/m68k/helper.c              |  20 --
 target/microblaze/cpu.c           |   6 +
 target/microblaze/translate.c     |  11 --
 target/moxie/cpu.c                |   5 -
 target/nios2/cpu.c                |   9 +-
 target/openrisc/cpu.c             |   5 -
 target/ppc/translate_init.c       |   5 -
 target/s390x/cpu.c                |   7 +
 target/s390x/helper.c             |  14 --
 target/sh4/cpu.c                  |   5 -
 target/sparc/cpu.c                | 391 +++++++++++++++++++++-----------=
------
 target/sparc/int32_helper.c       |   2 +-
 target/sparc/int64_helper.c       |   2 +-
 target/sparc/ldst_helper.c        |  14 +-
 target/sparc/mmu_helper.c         |   2 +-
 target/sparc/translate.c          |   2 +-
 target/sparc/win_helper.c         |   4 +-
 target/tilegx/cpu.c               |  11 +-
 target/tricore/helper.c           |   5 -
 target/unicore32/helper.c         |   5 -
 target/xtensa/cpu.c               |   3 +
 target/xtensa/helper.c            |  22 ---
 hmp-commands-info.hx              |   7 +-
 88 files changed, 419 insertions(+), 447 deletions(-)

--=20
2.13.5
