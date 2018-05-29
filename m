Received: from eggs.gnu.org ([2001:4830:134:3::10]:36742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcCq-0001A6-FQ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcCl-0003gN-IM
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:20 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:40597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcCl-0003fv-7v
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:15 -0400
Received: by mail-wr0-x232.google.com with SMTP id l41-v6so24720311wre.7
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:14 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:33 +0200
Message-Id: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 00/38] Xilinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The following changes since commit 5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.13-pull-request' into staging (2018-05-25 10:04:36 +0100)

are available in the git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2018-05-29-v1.for-upstream

for you to fetch changes up to d10367e035eab12c77b83b5985915ff7f003de1f:

  target-microblaze: Consolidate MMU enabled checks (2018-05-29 09:35:15 +0200)

----------------------------------------------------------------
Tag edgar/xilinx-next-2018-05-29-v1.for-upstream

----------------------------------------------------------------
Edgar E. Iglesias (38):
      target-microblaze: dec_load: Use bool instead of unsigned int
      target-microblaze: dec_store: Use bool instead of unsigned int
      target-microblaze: compute_ldst_addr: Use bool instead of int
      target-microblaze: Fallback to our latest CPU version
      target-microblaze: Correct special register array sizes
      target-microblaze: Correct the PVR array size
      target-microblaze: Tighten up TCGv_i32 vs TCGv type usage
      target-microblaze: Remove USE_MMU PVR checks
      target-microblaze: Conditionalize setting of PVR11_USE_MMU
      target-microblaze: Bypass MMU with MMU_NOMMU_IDX
      target-microblaze: Make compute_ldst_addr always use a temp
      target-microblaze: Remove pointer indirection for ld/st addresses
      target-microblaze: Use TCGv for load/store addresses
      target-microblaze: Name special registers we support
      target-microblaze: Break out trap_userspace()
      target-microblaze: Break out trap_illegal()
      target-microblaze: dec_msr: Use bool and extract32
      target-microblaze: dec_msr: Reuse more code when reg-decoding
      target-microblaze: dec_msr: Fix MTS to FSR
      target-microblaze: Make special registers 64-bit
      target-microblaze: Setup for 64bit addressing
      target-microblaze: Add Extended Addressing
      target-microblaze: Implement MFSE EAR
      target-microblaze: mmu: Add R_TBLX_MISS macros
      target-microblaze: mmu: Remove unused register state
      target-microblaze: mmu: Prepare for 64-bit addresses
      target-microblaze: mmu: Add a configurable output address mask
      target-microblaze: dec_msr: Plug a temp leak
      target-microblaze: Add support for extended access to TLBLO
      target-microblaze: Allow address sizes between 32 and 64 bits
      target-microblaze: Simplify address computation using tcg_gen_addi_i32()
      target-microblaze: mmu: Cleanup debug log messages
      target-microblaze: Use table based condition-codes conversion
      target-microblaze: Remove argument b in eval_cc()
      target-microblaze: Convert env_btarget to i64
      target-microblaze: Use tcg_gen_movcond in eval_cond_jmp
      target-microblaze: cpu_mmu_index: Fixup indentation
      target-microblaze: Consolidate MMU enabled checks

 configure                        |   1 +
 linux-user/microblaze/cpu_loop.c |   4 +-
 target/microblaze/cpu.c          |  30 +-
 target/microblaze/cpu.h          |  34 +-
 target/microblaze/helper.c       |  32 +-
 target/microblaze/helper.h       |   8 +-
 target/microblaze/mmu.c          |  81 ++--
 target/microblaze/mmu.h          |  17 +-
 target/microblaze/op_helper.c    |  30 +-
 target/microblaze/translate.c    | 930 +++++++++++++++++++--------------------
 10 files changed, 598 insertions(+), 569 deletions(-)

Edgar E. Iglesias (38):
  target-microblaze: dec_load: Use bool instead of unsigned int
  target-microblaze: dec_store: Use bool instead of unsigned int
  target-microblaze: compute_ldst_addr: Use bool instead of int
  target-microblaze: Fallback to our latest CPU version
  target-microblaze: Correct special register array sizes
  target-microblaze: Correct the PVR array size
  target-microblaze: Tighten up TCGv_i32 vs TCGv type usage
  target-microblaze: Remove USE_MMU PVR checks
  target-microblaze: Conditionalize setting of PVR11_USE_MMU
  target-microblaze: Bypass MMU with MMU_NOMMU_IDX
  target-microblaze: Make compute_ldst_addr always use a temp
  target-microblaze: Remove pointer indirection for ld/st addresses
  target-microblaze: Use TCGv for load/store addresses
  target-microblaze: Name special registers we support
  target-microblaze: Break out trap_userspace()
  target-microblaze: Break out trap_illegal()
  target-microblaze: dec_msr: Use bool and extract32
  target-microblaze: dec_msr: Reuse more code when reg-decoding
  target-microblaze: dec_msr: Fix MTS to FSR
  target-microblaze: Make special registers 64-bit
  target-microblaze: Setup for 64bit addressing
  target-microblaze: Add Extended Addressing
  target-microblaze: Implement MFSE EAR
  target-microblaze: mmu: Add R_TBLX_MISS macros
  target-microblaze: mmu: Remove unused register state
  target-microblaze: mmu: Prepare for 64-bit addresses
  target-microblaze: mmu: Add a configurable output address mask
  target-microblaze: dec_msr: Plug a temp leak
  target-microblaze: Add support for extended access to TLBLO
  target-microblaze: Allow address sizes between 32 and 64 bits
  target-microblaze: Simplify address computation using
    tcg_gen_addi_i32()
  target-microblaze: mmu: Cleanup debug log messages
  target-microblaze: Use table based condition-codes conversion
  target-microblaze: Remove argument b in eval_cc()
  target-microblaze: Convert env_btarget to i64
  target-microblaze: Use tcg_gen_movcond in eval_cond_jmp
  target-microblaze: cpu_mmu_index: Fixup indentation
  target-microblaze: Consolidate MMU enabled checks

 configure                        |   1 +
 linux-user/microblaze/cpu_loop.c |   4 +-
 target/microblaze/cpu.c          |  30 +-
 target/microblaze/cpu.h          |  34 +-
 target/microblaze/helper.c       |  32 +-
 target/microblaze/helper.h       |   8 +-
 target/microblaze/mmu.c          |  81 ++--
 target/microblaze/mmu.h          |  17 +-
 target/microblaze/op_helper.c    |  30 +-
 target/microblaze/translate.c    | 930 +++++++++++++++++++--------------------
 10 files changed, 598 insertions(+), 569 deletions(-)

-- 
2.14.1
