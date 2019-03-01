Received: from eggs.gnu.org ([209.51.188.92]:44570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzoPF-00047J-9i
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzoP5-0001cu-TL
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:10 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:44473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzoP3-0001XY-HN
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:07 -0500
Received: by mail-pg1-x52e.google.com with SMTP id j3so11905593pgm.11
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 12:05:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Mar 2019 12:04:51 -0800
Message-Id: <20190301200501.16533-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 00/10] target/arm: SB, PredInv, CondM,
 FRINT extensions
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

These 5 extensions are small, and all previous editions have
minor patch conflicts with master.  Therefore, rebase them all
together for simplicity.


r~


Richard Henderson (10):
  target/arm: Split out arm_sctlr
  target/arm: Implement ARMv8.0-SB
  target/arm: Implement ARMv8.0-PredInv
  target/arm: Split helper_msr_i_pstate into 3
  target/arm: Add set/clear_pstate_bits, share gen_ss_advance
  target/arm: Rearrange disas_data_proc_reg
  target/arm: Implement ARMv8.4-CondM
  target/arm: Implement ARMv8.5-CondM
  target/arm: Restructure handle_fp_1src_{single,double}
  target/arm: Implement ARMv8.5-FRINT

 target/arm/cpu.h           |  64 ++++-
 target/arm/helper-a64.h    |   3 +
 target/arm/helper.h        |   8 +-
 target/arm/internals.h     |  15 ++
 target/arm/translate.h     |  34 +++
 linux-user/elfload.c       |   2 +
 target/arm/cpu.c           |   2 +
 target/arm/cpu64.c         |   6 +
 target/arm/helper-a64.c    |  30 +++
 target/arm/helper.c        |  63 ++++-
 target/arm/op_helper.c     |  47 ----
 target/arm/translate-a64.c | 476 ++++++++++++++++++++++++++++---------
 target/arm/translate.c     |  33 ++-
 target/arm/vfp_helper.c    |  96 ++++++++
 14 files changed, 688 insertions(+), 191 deletions(-)

-- 
2.17.2
