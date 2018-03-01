Received: from eggs.gnu.org ([2001:4830:134:3::10]:33636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJp-0003fd-RA
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJo-00084N-KF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:13 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJo-00082m-AT
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:12 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJg-0000X7-Hc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:21 +0000
Message-Id: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/42] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Arm queue -- I have more stuff pending but I prefer to push
this first lot out and keep the pull below 50 patches.
Most of this is Alex's FP16 support work.

-- PMM


The following changes since commit 6697439794f72b3501ee16bb95d16854f9981421:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180227-pull-request' into staging (2018-02-27 17:50:46 +0000)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180301

for you to fetch changes up to c22e580c2ad1cccef582e1490e732f254d4ac064:

  MAINTAINERS: Update my email address (2018-03-01 11:13:59 +0000)

----------------------------------------------------------------
target-arm queue:
 * update MAINTAINERS for Alistair's new email address
 * add Arm v8.2 FP16 arithmetic extension for linux-user
 * implement display connector emulation for vexpress board
 * xilinx_spips: Enable only two slaves when reading/writing with stripe
 * xilinx_spips: Use 8 dummy cycles with the QIOR/QIOR4 commands
 * hw: register: Run post_write hook on reset

----------------------------------------------------------------
Alex Bennée (31):
      include/exec/helper-head.h: support f16 in helper calls
      target/arm/cpu64: introduce ARM_V8_FP16 feature bit
      target/arm/cpu.h: update comment for half-precision values
      target/arm/cpu.h: add additional float_status flags
      target/arm/helper: pass explicit fpst to set_rmode
      arm/translate-a64: implement half-precision F(MIN|MAX)(V|NMV)
      arm/translate-a64: handle_3same_64 comment fix
      arm/translate-a64: initial decode for simd_three_reg_same_fp16
      arm/translate-a64: add FP16 FADD/FABD/FSUB/FMUL/FDIV to simd_three_reg_same_fp16
      arm/translate-a64: add FP16 F[A]C[EQ/GE/GT] to simd_three_reg_same_fp16
      arm/translate-a64: add FP16 FMULA/X/S to simd_three_reg_same_fp16
      arm/translate-a64: add FP16 FR[ECP/SQRT]S to simd_three_reg_same_fp16
      arm/translate-a64: add FP16 pairwise ops simd_three_reg_same_fp16
      arm/translate-a64: add FP16 FMULX/MLS/FMLA to simd_indexed
      arm/translate-a64: add FP16 x2 ops for simd_indexed
      arm/translate-a64: initial decode for simd_two_reg_misc_fp16
      arm/translate-a64: add FP16 FPRINTx to simd_two_reg_misc_fp16
      arm/translate-a64: add FCVTxx to simd_two_reg_misc_fp16
      arm/translate-a64: add FP16 FCMxx (zero) to simd_two_reg_misc_fp16
      arm/translate-a64: add FP16 SCVTF/UCVFT to simd_two_reg_misc_fp16
      arm/translate-a64: add FP16 FNEG/FABS to simd_two_reg_misc_fp16
      arm/helper.c: re-factor recpe and add recepe_f16
      arm/translate-a64: add FP16 FRECPE
      arm/translate-a64: add FP16 FRCPX to simd_two_reg_misc_fp16
      arm/translate-a64: add FP16 FSQRT to simd_two_reg_misc_fp16
      arm/helper.c: re-factor rsqrte and add rsqrte_f16
      arm/translate-a64: add FP16 FRSQRTE to simd_two_reg_misc_fp16
      arm/translate-a64: add FP16 FMOV to simd_mod_imm
      arm/translate-a64: add all FP16 ops in simd_scalar_pairwise
      arm/translate-a64: implement simd_scalar_three_reg_same_fp16
      arm/translate-a64: add all single op FP16 to handle_fp_1src_half

Alistair Francis (2):
      hw: register: Run post_write hook on reset
      MAINTAINERS: Update my email address

Corey Minyard (2):
      i2c: Fix some brace style issues
      i2c: Move the bus class to i2c.h

Francisco Iglesias (2):
      xilinx_spips: Enable only two slaves when reading/writing with stripe
      xilinx_spips: Use 8 dummy cycles with the QIOR/QIOR4 commands

Linus Walleij (3):
      hw/i2c-ddc: Do not fail writes
      hw/sii9022: Add support for Silicon Image SII9022
      arm/vexpress: Add proper display connector emulation

Peter Maydell (2):
      target/arm: Enable ARM_V8_FP16 feature bit for the AArch64 "any" CPU
      linux-user: Report AArch64 FP16 support via hwcap bits

 hw/display/Makefile.objs        |    1 +
 include/exec/helper-head.h      |    3 +
 include/fpu/softfloat.h         |   18 +-
 include/hw/i2c/i2c.h            |   23 +-
 include/hw/register.h           |    6 +-
 target/arm/cpu.h                |   34 +-
 target/arm/helper-a64.h         |   33 +
 target/arm/helper.h             |   14 +-
 hw/arm/vexpress.c               |    6 +-
 hw/core/register.c              |    8 +
 hw/display/sii9022.c            |  191 ++++++
 hw/i2c/core.c                   |   18 -
 hw/i2c/i2c-ddc.c                |    4 +-
 hw/ssi/xilinx_spips.c           |   43 +-
 linux-user/elfload.c            |    2 +
 target/arm/cpu64.c              |    1 +
 target/arm/helper-a64.c         |  269 +++++++++
 target/arm/helper.c             |  481 ++++++++-------
 target/arm/translate-a64.c      | 1266 +++++++++++++++++++++++++++++++++------
 target/arm/translate.c          |   12 +-
 MAINTAINERS                     |   12 +-
 default-configs/arm-softmmu.mak |    2 +
 hw/display/trace-events         |    5 +
 23 files changed, 1981 insertions(+), 471 deletions(-)
 create mode 100644 hw/display/sii9022.c
