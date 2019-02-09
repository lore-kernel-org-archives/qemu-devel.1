Received: from eggs.gnu.org ([209.51.188.92]:42394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJTi-0006dv-9g
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJTh-0000RL-Hx
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:38:54 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsJTh-0000Qx-CP
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:38:53 -0500
Received: by mail-pf1-x441.google.com with SMTP id u6so2564324pfh.11
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 19:38:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 19:38:35 -0800
Message-Id: <20190209033847.9014-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 00/12] target/arm: tcg vector cleanups
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

Changes since v2:
  * Fix some representational issues with FPSCR.
  * Use host vector saturation for SQADD/UQADD.
    This requires changing the internal representation of FPSR.QC.
  * Fix a latent vector bug, noticed during the rest.

Correct RISU results depend on Mark C-A's patch from today,
"tcg/i386: fix unsigned vector saturating arithmetic",
which will be in my next tcg pull.


r~


Richard Henderson (12):
  target/arm: Rely on optimization within tcg_gen_gvec_or
  target/arm: Use vector minmax expanders for aarch64
  target/arm: Use vector minmax expanders for aarch32
  target/arm: Use tcg integer min/max primitives for neon
  target/arm: Remove neon min/max helpers
  target/arm: Fix vfp_gdb_get/set_reg vs FPSCR
  target/arm: Fix arm_cpu_dump_state vs FPSCR
  target/arm: Split out flags setting from vfp compares
  target/arm: Fix set of bits kept in xregs[ARM_VFP_FPSCR]
  target/arm: Split out FPSCR.QC to a vector field
  target/arm: Use vector operations for saturation
  target/arm: Add missing clear_tail calls

 target/arm/cpu.h           |   5 +-
 target/arm/helper.h        |  45 ++++++--
 target/arm/translate.h     |   4 +
 target/arm/helper.c        |  81 +++++++++-----
 target/arm/neon_helper.c   |  14 +--
 target/arm/translate-a64.c |  77 ++++++-------
 target/arm/translate-sve.c |   6 +-
 target/arm/translate.c     | 219 +++++++++++++++++++++++++++++--------
 target/arm/vec_helper.c    | 134 ++++++++++++++++++++++-
 9 files changed, 433 insertions(+), 152 deletions(-)

-- 
2.17.2
