Received: from eggs.gnu.org ([2001:4830:134:3::10]:44557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1egtHD-0007J3-3z
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1egtH8-0002S7-P1
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:22:15 -0500
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:45298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1egtH8-0002RY-HA
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:22:10 -0500
Received: by mail-pf0-x230.google.com with SMTP id a88so12745605pfe.12
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 06:22:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Jan 2018 06:22:05 -0800
Message-Id: <20180131142205.29422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v6 00/43] hppa-softmmu
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

Changes since v5:
  * Fix win32 build issues.


r~


The following changes since commit 6521130b0a7f699fdb82446d57df5627bfa7ed3c:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2018-01-26-2' into staging (2018-01-30 15:20:01 +0000)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-hppa-20180131

for you to fetch changes up to eed142195c95a6c50545fa7a28e725d780ab9636:

  target/hppa: Implement PROBE for system mode (2018-01-31 05:30:50 -0800)

----------------------------------------------------------------
Implement hppa-softmmu

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
      target/hppa: Increase number of temp regs
      target/hppa: Implement a pause instruction
      target/hppa: Implement STWA
      target/hppa: Enable MTTCG
      pc-bios: Add hppa-firmware.img and git submodule
      hw/hppa: Add MAINTAINERS entry
      target/hppa: Fix 32-bit operand masks for 0E FCVT
      target/hppa: Implement PROBE for system mode

 Makefile                         |    3 +-
 Makefile.objs                    |    1 +
 hw/hppa/hppa_hardware.h          |   40 +
 hw/hppa/hppa_sys.h               |   24 +
 include/sysemu/arch_init.h       |    1 +
 linux-user/hppa/target_cpu.h     |    2 +-
 target/hppa/cpu.h                |  284 ++++-
 target/hppa/helper.h             |   43 +-
 arch_init.c                      |    2 +
 hw/hppa/dino.c                   |  518 ++++++++++
 hw/hppa/machine.c                |  283 +++++
 hw/hppa/pci.c                    |   90 ++
 linux-user/main.c                |   28 +-
 linux-user/signal.c              |    4 +-
 target/hppa/cpu.c                |   56 +-
 target/hppa/gdbstub.c            |  187 +++-
 target/hppa/helper.c             |  120 +--
 target/hppa/int_helper.c         |  263 +++++
 target/hppa/machine.c            |  181 ++++
 target/hppa/mem_helper.c         |  348 +++++++
 target/hppa/op_helper.c          |  152 ++-
 target/hppa/translate.c          | 2108 ++++++++++++++++++++++++++++----------
 .gitmodules                      |    3 +
 MAINTAINERS                      |    1 +
 configure                        |    1 +
 default-configs/hppa-softmmu.mak |   14 +
 hw/hppa/Makefile.objs            |    1 +
 hw/hppa/trace-events             |    4 +
 pc-bios/hppa-firmware.img        |  Bin 0 -> 461352 bytes
 roms/seabios-hppa                |    1 +
 target/hppa/Makefile.objs        |    4 +-
 31 files changed, 4062 insertions(+), 705 deletions(-)
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
