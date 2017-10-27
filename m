Received: from eggs.gnu.org ([2001:4830:134:3::10]:33766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Vc-0001yh-Dh
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85VZ-0007zT-7f
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85VY-0007yY-Vu
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:28 +0200
Message-Id: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/39] x86/cpu/numa queue, 2017-10-27
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

Change in v2:
* Include sh4-linux-user fixup sent by Igor
  (at: "sh4: simplify superh_cpu_class_by_name()")

The following changes since commit 74d7fc7f6385158b8a5c524c61baaef1b66f3d=
ac:

  tcg: Avoid setting tcg_initialize if !CONFIG_TCG (2017-10-26 17:47:36 +=
0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to 1a26f46692320f1981c95967e0d5af4443b5f0b1:

  x86: Skip check apic_id_limit for Xen (2017-10-27 16:04:28 +0200)

----------------------------------------------------------------
x86/cpu/numa queue, 2017-10-27

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
 linux-user/main.c              |   2 +-
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
 59 files changed, 397 insertions(+), 689 deletions(-)

--=20
2.13.6
