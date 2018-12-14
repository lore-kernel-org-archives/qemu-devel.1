Received: from eggs.gnu.org ([2001:4830:134:3::10]:55612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxW-0004Oo-C2
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxP-0005J7-LP
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:21 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:40157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxP-0005In-40
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:15 -0500
Received: by mail-oi1-x232.google.com with SMTP id t204so3623784oie.7
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:23:43 -0600
Message-Id: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 00/27] target/arm: Implement ARMv8.3-PAuth
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

Lots of little changes since v1, but many of which are noted
within each patch.  This version works in system mode, using

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/core


r~

Richard Henderson (27):
  target/arm: Add state for the ARMv8.3-PAuth extension
  target/arm: Add SCTLR bits through ARMv8.5
  target/arm: Add PAuth active bit to tbflags
  target/arm: Add PAuth helpers
  target/arm: Decode PAuth within system hint space
  target/arm: Rearrange decode in disas_data_proc_1src
  target/arm: Decode PAuth within disas_data_proc_1src
  target/arm: Decode PAuth within disas_data_proc_2src
  target/arm: Move helper_exception_return to helper-a64.c
  target/arm: Add new_pc argument to helper_exception_return
  target/arm: Rearrange decode in disas_uncond_b_reg
  target/arm: Decode PAuth within disas_uncond_b_reg
  target/arm: Decode Load/store register (pac)
  target/arm: Move cpu_mmu_index out of line
  target/arm: Introduce arm_mmu_idx
  target/arm: Introduce arm_stage1_mmu_idx
  target/arm: Create ARMVAParameters and helpers
  target/arm: Reuse aa64_va_parameters for setting tbflags
  target/arm: Export aa64_va_parameters to internals.h
  target/arm: Implement pauth_strip
  target/arm: Implement pauth_auth
  target/arm: Implement pauth_addpac
  target/arm: Implement pauth_computepac
  target/arm: Add PAuth system registers
  target/arm: Enable PAuth for -cpu max
  target/arm: Enable PAuth for user-only, part 2
  target/arm: Tidy TBI handling in gen_a64_set_pc

 target/arm/cpu.h           | 171 +++++-----
 target/arm/helper-a64.h    |  14 +
 target/arm/helper.h        |   1 -
 target/arm/internals.h     |  62 ++++
 target/arm/translate.h     |   2 +
 target/arm/cpu.c           |   6 +
 target/arm/cpu64.c         |   4 +
 target/arm/helper-a64.c    | 629 +++++++++++++++++++++++++++++++++++++
 target/arm/helper.c        | 500 ++++++++++++++++++-----------
 target/arm/op_helper.c     | 155 ---------
 target/arm/translate-a64.c | 534 ++++++++++++++++++++++++++-----
 11 files changed, 1581 insertions(+), 497 deletions(-)

-- 
2.17.2
