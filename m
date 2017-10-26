Received: from eggs.gnu.org ([2001:4830:134:3::10]:43687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ilc-0003Lo-0c
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ilW-0006Zp-4j
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7ilV-0006Xm-SC
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:25 +0200
Message-Id: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/39] x86/cpu/numa queue, 2017-10-26
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

(Note that master is currently broken with --disable-tcg, but I
don't want to hold the queue until this is fixed.)

The following changes since commit ae49fbbcd8e4e9d8bf7131add34773f579e1af=
f7:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20171025' into =
staging (2017-10-25 16:38:57 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to ba2975aa134fdb0208f0a54c544402fed1890217:

  x86: Skip check apic_id_limit for Xen (2017-10-26 15:29:38 +0200)

----------------------------------------------------------------
x86/machine/numa queue, 2017-10-26

----------------------------------------------------------------

Igor Mammedov (38):
  alpha: cleanup cpu type name composition
  alpha: use generic cpu_model parsing
  cris: cleanup cpu type name composition
  cris: use generic cpu_model parsing
  lm32: cleanup cpu type name composition
  lm32: milkymist: use generic cpu_model parsing
  lm32: lm32_boards: use generic cpu_model parsing
  m68k: cleanup cpu type name composition
  m68k: an5206: use generic cpu_model parsing
  m68k: mcf5208: use generic cpu_model parsing
  moxie: fix qemu-system-moxie failing to start with CLI "-cpu
    MoxieLite"
  moxie: cleanup cpu type name composition
  moxie: use generic cpu_model parsing
  openrisc: cleanup cpu type name composition
  openrisc: use generic cpu_model parsing
  sh4: r2d: use generic cpu_model parsing
  sh4: shix: use generic cpu_model parsing
  sh4: cleanup cpu type name composition
  sh4: simplify superh_cpu_class_by_name()
  sh4: remove SuperHCPUClass::name field
  xtensa: cleanup cpu type name composition
  xtensa: sim: use generic cpu_model parsing
  xtensa: lx60/lx200/ml605/kc705: use generic cpu_model parsing
  unicore32: cleanup cpu type name composition
  unicore32: use generic cpu_model parsing
  tricore: cleanup cpu type name composition
  tricore: use generic cpu_model parsing
  sparc: cleanup cpu type name composition
  sparc: sun4u/sun4v/niagara: use generic cpu_model parsing
  sparc: sparc: use generic cpu_model parsing
  sparc: leon3: use generic cpu_model parsing
  mips: use object_new() instead of gnew()+object_initialize()
  mips: malta/boston: replace cpu_model with cpu_type
  mips: fulong2e: replace cpu_model with cpu_type
  mips: Magnum/Acer Pica 61: replace cpu_model with cpu_type
  mips: mipssim: replace cpu_model with cpu_type
  mips: r4k: replace cpu_model with cpu_type
  numa: fixup parsed NumaNodeOptions earlier

Lan Tianyu (1):
  x86: Skip check apic_id_limit for Xen

 include/hw/mips/cps.h          |   2 +-
 include/hw/sparc/sparc64.h     |   3 +-
 target/alpha/cpu.h             |   3 ++
 target/cris/cpu.h              |   3 ++
 target/lm32/cpu.h              |   3 ++
 target/m68k/cpu.h              |   3 ++
 target/mips/cpu.h              |   8 ++-
 target/moxie/cpu.h             |   3 ++
 target/openrisc/cpu.h          |   3 ++
 target/sh4/cpu-qom.h           |   8 ++-
 target/sh4/cpu.h               |   3 ++
 target/sparc/cpu.h             |   3 ++
 target/tricore/cpu.h           |   2 +
 target/unicore32/cpu.h         |   3 ++
 target/xtensa/cpu.h            |   4 ++
 hw/alpha/dp264.c               |   4 +-
 hw/cris/axis_dev88.c           |   7 +--
 hw/i386/pc.c                   |   2 +-
 hw/lm32/lm32_boards.c          |  14 ++----
 hw/lm32/milkymist.c            |   7 +--
 hw/m68k/an5206.c               |   7 +--
 hw/m68k/mcf5208.c              |   7 +--
 hw/mips/boston.c               |  14 +++---
 hw/mips/cps.c                  |   4 +-
 hw/mips/mips_fulong2e.c        |   7 +--
 hw/mips/mips_jazz.c            |   8 ++-
 hw/mips/mips_malta.c           |  36 ++++++--------
 hw/mips/mips_mipssim.c         |  15 +++---
 hw/mips/mips_r4k.c             |  16 +++---
 hw/moxie/moxiesim.c            |   7 +--
 hw/openrisc/openrisc_sim.c     |   8 +--
 hw/sh4/r2d.c                   |   8 +--
 hw/sh4/shix.c                  |   7 +--
 hw/sparc/leon3.c               |   8 +--
 hw/sparc/sun4m.c               |  29 +++++------
 hw/sparc64/niagara.c           |   4 +-
 hw/sparc64/sparc64.c           |   8 +--
 hw/sparc64/sun4u.c             |   8 ++-
 hw/tricore/tricore_testboard.c |   6 +--
 hw/unicore32/puv3.c            |   8 +--
 hw/xtensa/sim.c                |   8 +--
 hw/xtensa/xtfpga.c             |  11 ++---
 numa.c                         |  19 ++++----
 target/alpha/cpu.c             | 107 +++++++++++++----------------------=
------
 target/cris/cpu.c              |  81 +++++++++++--------------------
 target/lm32/cpu.c              |  74 +++++++++-------------------
 target/m68k/cpu.c              |  75 +++++++++++------------------
 target/mips/cpu.c              |   2 +-
 target/mips/translate.c        |  20 +++-----
 target/mips/translate_init.c   |  12 -----
 target/moxie/cpu.c             |  61 +++++++++--------------
 target/openrisc/cpu.c          |  69 +++++++++-----------------
 target/sh4/cpu.c               | 107 +++++++++++++++--------------------=
------
 target/sparc/cpu.c             |   2 +-
 target/tricore/cpu.c           |  68 ++++++++------------------
 target/unicore32/cpu.c         |  61 ++++++++---------------
 target/xtensa/cpu.c            |   2 +-
 target/xtensa/helper.c         |   2 +-
 58 files changed, 396 insertions(+), 688 deletions(-)

--=20
2.13.6
