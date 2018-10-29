Received: from eggs.gnu.org ([2001:4830:134:3::10]:34198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9LR-0008JE-IY
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9LJ-0003G3-AI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38671 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH9LI-0003Cd-TR
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:37 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 16:19:51 +0100
Message-Id: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 00/27] MIPS queue for October 2018, part 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 03f400883a1dd92fac5b0d9127b38e34c9a722d7:

  target/mips: Add MXU decoding engine (2018-10-29 14:13:47 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-october-2018-part-4

for you to fetch changes up to 64ea3d676d9447ecdb987deab5a1542ea088bd31:

  linux-user: Add prctl() PR_SET_FP_MODE and PR_GET_FP_MODE implementations (2018-10-29 15:50:31 +0100)

----------------------------------------------------------------
MIPS queue for October 2018, part 4

  - fix for two missing break statements 
  - series on Ingenic's MXU ASE support
  - series on MIPS-specific prctl()
----------------------------------------------------------------

Aleksandar Markovic (9):
  target/mips: Add two missing breaks for NM_LLWPE and NM_SCWPE decoder
    cases
  target/mips: Amend MXU instruction opcodes
  target/mips: Add and integrate MXU decoding engine placeholder
  target/mips: Add MXU decoding engine
  target/mips: Add bit encoding for MXU accumulate add/sub 1-bit pattern
    'aptn1'
  target/mips: Add bit encoding for MXU execute add/sub pattern 'eptn2'
  target/mips: Move MUL, S32M2I, S32I2M handling out of main MXU switch
  target/mips: Move MXU_EN check one level higher
  target/mips: Amend MXU ASE overview note

Craig Janeczek (12):
  target/mips: Introduce MXU registers
  target/mips: Define a bit for MXU in insn_flags
  target/mips: Add bit encoding for MXU accumulate add/sub 2-bit pattern
    'aptn2'
  target/mips: Add bit encoding for MXU operand getting pattern 'optn2'
  target/mips: Add bit encoding for MXU operand getting pattern 'optn3'
  target/mips: Add emulation of non-MXU MULL within MXU decoding engine
  target/mips: Add emulation of MXU instructions S32I2M and S32M2I
  target/mips: Add emulation of MXU instruction S8LDD
  target/mips: Add emulation of MXU instruction D16MUL
  target/mips: Add emulation of MXU instruction D16MAC
  target/mips: Add emulation of MXU instructions Q8MUL and Q8MULSU
  target/mips: Add emulation of MXU instructions S32LDD and S32LDDR

Stefan Markovic (6):
  elf: Define MIPS_ABI_FP_UNKNOWN macro
  linux-user: Extend image_info struct with MIPS fp_abi and
    interp_fp_abi fields
  linux-user: Extract MIPS abiflags from ELF file
  linux-user: Read and set FP ABI value from MIPS abiflags
  linux-user: Determine the desired FPU mode from MIPS.abiflags
  linux-user: Add prctl() PR_SET_FP_MODE and PR_GET_FP_MODE
    implementations

 include/elf.h                      |    2 +
 linux-user/elfload.c               |   37 +
 linux-user/mips/cpu_loop.c         |   75 ++
 linux-user/mips/target_syscall.h   |    2 +
 linux-user/mips64/target_syscall.h |    2 +
 linux-user/qemu.h                  |    4 +
 linux-user/syscall.c               |   62 +-
 target/mips/cpu.h                  |   10 +
 target/mips/mips-defs.h            |    1 +
 target/mips/translate.c            | 2102 ++++++++++++++++++++++++++++++++----
 10 files changed, 2076 insertions(+), 221 deletions(-)

-- 
2.7.4
