Received: from eggs.gnu.org ([208.118.235.92]:49416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtjv-0003dR-QO
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtjs-00065i-LD
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:55:47 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:43998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtjs-00064X-FT
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:55:44 -0500
Received: by mail-pf1-x42a.google.com with SMTP id w73so7067713pfk.10
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:55:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:54:47 +1100
Message-Id: <20181225205529.10874-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/42] tcg queued patches
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

The following changes since commit 9b2e891ec5ccdb4a7d583b77988848282606fdea:

  Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into staging (2018-12-22 11:25:31 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20181226

for you to fetch changes up to 4250da10923347c9ee907f8d72bd93dfa5ee8742:

  tcg: Improve call argument loading (2018-12-26 06:58:43 +1100)

----------------------------------------------------------------
Host support for riscv64.
Dead code elimination pass.
Register allocation improvements.

----------------------------------------------------------------
Alistair Francis (23):
      elf.h: Add the RISCV ELF magic numbers
      linux-user: Add host dependency for RISC-V 32-bit
      linux-user: Add host dependency for RISC-V 64-bit
      exec: Add RISC-V GCC poison macro
      tcg/riscv: Add the tcg-target.h file
      tcg/riscv: Add the tcg target registers
      tcg/riscv: Add support for the constraints
      tcg/riscv: Add the immediate encoders
      tcg/riscv: Add the instruction emitters
      tcg/riscv: Add the relocation functions
      tcg/riscv: Add the mov and movi instruction
      tcg/riscv: Add the extract instructions
      tcg/riscv: Add the out load and store instructions
      tcg/riscv: Add the add2 and sub2 instructions
      tcg/riscv: Add branch and jump instructions
      tcg/riscv: Add slowpath load and store instructions
      tcg/riscv: Add direct load and store instructions
      tcg/riscv: Add the out op decoder
      tcg/riscv: Add the prologue generation and register the JIT
      tcg/riscv: Add the target init code
      tcg: Add RISC-V cpu signal handler
      disas: Add RISC-V support
      configure: Add support for building RISC-V host

Richard Henderson (19):
      disas/microblaze: Remove unused REG_SP macro
      linux-user: Add safe_syscall for riscv64 host
      tcg: Renumber TCG_CALL_* flags
      tcg: Add TCG_CALL_NO_RETURN
      tcg: Reference count labels
      tcg: Add reachable_code_pass
      tcg: Add preferred_reg argument to tcg_reg_alloc
      tcg: Add preferred_reg argument to temp_load
      tcg: Add preferred_reg argument to temp_sync
      tcg: Add preferred_reg argument to tcg_reg_alloc_do_movi
      tcg: Add output_pref to TCGOp
      tcg: Improve register allocation for matching constraints
      tcg: Dump register preference info with liveness
      tcg: Reindent parts of liveness_pass_1
      tcg: Rename and adjust liveness_pass_1 helpers
      tcg: Split out more subroutines from liveness_pass_1
      tcg: Add TCG_OPF_BB_EXIT
      tcg: Record register preferences during liveness
      tcg: Improve call argument loading

 include/elf.h                              |   55 +
 include/exec/helper-head.h                 |   13 +
 include/exec/helper-tcg.h                  |   21 +-
 include/exec/poison.h                      |    1 +
 linux-user/host/riscv32/hostdep.h          |   11 +
 linux-user/host/riscv64/hostdep.h          |   34 +
 tcg/riscv/tcg-target.h                     |  177 +++
 tcg/tcg-op.h                               |    1 +
 tcg/tcg-opc.h                              |    7 +-
 tcg/tcg.h                                  |   31 +-
 accel/tcg/user-exec.c                      |   75 ++
 disas.c                                    |   10 +-
 disas/microblaze.c                         |    1 -
 tcg/riscv/tcg-target.inc.c                 | 1949 ++++++++++++++++++++++++++++
 tcg/tcg-op.c                               |    2 +
 tcg/tcg.c                                  |  626 +++++++--
 MAINTAINERS                                |   12 +-
 configure                                  |   12 +-
 linux-user/host/riscv64/safe-syscall.inc.S |   77 ++
 19 files changed, 2948 insertions(+), 167 deletions(-)
 create mode 100644 linux-user/host/riscv32/hostdep.h
 create mode 100644 linux-user/host/riscv64/hostdep.h
 create mode 100644 tcg/riscv/tcg-target.h
 create mode 100644 tcg/riscv/tcg-target.inc.c
 create mode 100644 linux-user/host/riscv64/safe-syscall.inc.S
