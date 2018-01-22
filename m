Received: from eggs.gnu.org ([2001:4830:134:3::10]:60014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT06-0005Fd-J5
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT02-0005yy-7i
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:26 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:35149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT01-0005yb-VH
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:22 -0500
Received: by mail-pg0-x22f.google.com with SMTP id o13so953376pgs.2
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:42:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:41:34 -0800
Message-Id: <20180122034217.19593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/43] Add hppa-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This has some improvements to the patch set posted on Dec 28.

  * Change cpu init as requested by Igor Mammedov.
  * Add SMP support
  * Add firmware image
  * Implement qemu-specific pause and system reset insns.


r~


The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc78f:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-01-19 16:35:25 +0000)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-hppa-20180121

for you to fetch changes up to 350e2a714ac8db559b255f9e8fe91c574f45df53:

  hw/hppa: Add MAINTAINERS entry (2018-01-21 14:05:03 -0800)

----------------------------------------------------------------
Add hppa-softmmu

----------------------------------------------------------------
Helge Deller (5):
      target/hppa: Skeleton support for hppa-softmmu
      target/hppa: Implement halt and reset instructions
      target/hppa: Fix comment
      target/hppa: Implement LDSID for system mode
      hw/hppa: Implement DINO system board

Richard Henderson (38):
      target/hppa: Define the rest of the PSW
      target/hppa: Disable gateway page emulation for system mode
      target/hppa: Define hardware exception types
      target/hppa: Split address size from register size
      target/hppa: Implement mmu_idx from IA privilege level
      target/hppa: Implement the system mask instructions
      target/hppa: Add space registers
      target/hppa: Add control registers
      target/hppa: Adjust insn mask for mfctl,w
      target/hppa: Implement rfi
      target/hppa: Fill in hppa_cpu_do_interrupt/hppa_cpu_exec_interrupt
      target/hppa: Implement unaligned access trap
      target/hppa: Use space registers in data operations
      target/hppa: Avoid privilege level decrease during branches
      target/hppa: Implement IASQ
      target/hppa: Implement tlb_fill
      target/hppa: Implement external interrupts
      target/hppa: Implement the interval timer
      target/hppa: Log unimplemented instructions
      target/hppa: Implement I*TLBA and I*TLBP insns
      target/hppa: Implement P*TLB and P*TLBE insns
      target/hppa: Implement LDWA
      target/hppa: Implement LPA
      target/hppa: Implement LCI
      target/hppa: Implement SYNCDMA insn
      target/hppa: Optimize for flat addressing space
      target/hppa: Add system registers to gdbstub
      target/hppa: Add migration for the cpu
      target/hppa: Implement B,GATE insn
      target/hppa: Only use EXCP_DTLB_MISS
      qom: Add MMU_DEBUG_LOAD
      target/hppa: Use MMU_DEBUG_LOAD when reloading for CR[IIR]
      target/hppa: Increase number of temp regs
      target/hppa: Implement a pause instruction
      target/hppa: Implement STWA
      target/hppa: Enable MTTCG
      pc-bios: Add hppa-firmware.img and git submodule
      hw/hppa: Add MAINTAINERS entry

 Makefile                         |    3 +-
 Makefile.objs                    |    1 +
 hw/hppa/hppa_hardware.h          |   65 ++
 hw/hppa/hppa_sys.h               |   24 +
 include/qom/cpu.h                |    3 +-
 include/sysemu/arch_init.h       |    1 +
 linux-user/hppa/target_cpu.h     |    2 +-
 target/hppa/cpu.h                |  282 +++++-
 target/hppa/helper.h             |   44 +-
 arch_init.c                      |    2 +
 hw/hppa/dino.c                   |  519 ++++++++++
 hw/hppa/machine.c                |  282 ++++++
 hw/hppa/pci.c                    |   90 ++
 linux-user/main.c                |   28 +-
 linux-user/signal.c              |    4 +-
 target/hppa/cpu.c                |   54 +-
 target/hppa/gdbstub.c            |  187 +++-
 target/hppa/helper.c             |  120 +--
 target/hppa/int_helper.c         |  263 +++++
 target/hppa/machine.c            |  181 ++++
 target/hppa/mem_helper.c         |  340 +++++++
 target/hppa/op_helper.c          |  132 ++-
 target/hppa/translate.c          | 2061 ++++++++++++++++++++++++++++----------
 .gitmodules                      |    3 +
 MAINTAINERS                      |    1 +
 configure                        |    1 +
 default-configs/hppa-softmmu.mak |   14 +
 hw/hppa/Makefile.objs            |    1 +
 hw/hppa/trace-events             |    4 +
 pc-bios/hppa-firmware.img        |  Bin 0 -> 461352 bytes
 roms/seabios-hppa                |    1 +
 target/hppa/Makefile.objs        |    4 +-
 32 files changed, 4028 insertions(+), 689 deletions(-)
 create mode 100644 hw/hppa/hppa_hardware.h
 create mode 100644 hw/hppa/hppa_sys.h
 create mode 100644 hw/hppa/dino.c
 create mode 100644 hw/hppa/machine.c
 create mode 100644 hw/hppa/pci.c
 create mode 100644 target/hppa/int_helper.c
 create mode 100644 target/hppa/machine.c
 create mode 100644 target/hppa/mem_helper.c
 create mode 100644 default-configs/hppa-softmmu.mak
 create mode 100644 hw/hppa/Makefile.objs
 create mode 100644 hw/hppa/trace-events
 create mode 100755 pc-bios/hppa-firmware.img
 create mode 160000 roms/seabios-hppa
