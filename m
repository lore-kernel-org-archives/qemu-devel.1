Received: from eggs.gnu.org ([209.51.188.92]:49401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1uDD-0006gT-S7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1uDD-0003Qm-2L
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:31 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1uDC-0003Pg-Oi
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:31 -0500
Received: by mail-pg1-x541.google.com with SMTP id m2so11414345pgl.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:41:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 06:41:17 -0800
Message-Id: <20190307144126.31847-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/9] tcg: Add tcg_gen_extract2_{i32,i64}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

The primary motivator here is usage within s390x,
but (as with any good primitive) the opcode has
applications outside that.


r~


David Hildenbrand (1):
  tcg: Implement tcg_gen_extract2_{i32,i64}

Richard Henderson (8):
  tcg: Add INDEX_op_extract2_{i32,i64}
  tcg: Use extract2 in tcg_gen_shifti_i64
  tcg: Use extract2 in tcg_gen_deposit_{i32,i64}
  tcg/i386: Support INDEX_op_extract2_{i32,i64}
  tcg/arm: Support INDEX_op_extract2_i32
  tcg/aarch64: Support INDEX_op_extract2_{i32,i64}
  target/arm: Use extract2 for EXTR
  target/arm: Simplify BFXIL expansion

 tcg/aarch64/tcg-target.h     |   2 +
 tcg/arm/tcg-target.h         |   1 +
 tcg/i386/tcg-target.h        |   2 +
 tcg/mips/tcg-target.h        |   2 +
 tcg/ppc/tcg-target.h         |   2 +
 tcg/riscv/tcg-target.h       |   2 +
 tcg/s390/tcg-target.h        |   2 +
 tcg/sparc/tcg-target.h       |   2 +
 tcg/tcg-op.h                 |   6 ++
 tcg/tcg-opc.h                |   2 +
 tcg/tcg.h                    |   1 +
 tcg/tci/tcg-target.h         |   2 +
 target/arm/translate-a64.c   |  44 +++++++------
 tcg/aarch64/tcg-target.inc.c |  11 ++++
 tcg/arm/tcg-target.inc.c     |  25 +++++++
 tcg/i386/tcg-target.inc.c    |  11 ++++
 tcg/optimize.c               |  10 +++
 tcg/tcg-op.c                 | 123 ++++++++++++++++++++++++++++-------
 tcg/tcg.c                    |   4 ++
 tcg/README                   |   5 ++
 20 files changed, 213 insertions(+), 46 deletions(-)

-- 
2.17.2
