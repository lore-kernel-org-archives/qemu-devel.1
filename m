Received: from eggs.gnu.org ([209.51.188.92]:40834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSI-0005lr-QC
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSI-00045r-2s
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:10 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:41361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmRSH-00044I-PV
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:10 -0500
Received: by mail-pl1-x62d.google.com with SMTP id u6so1902489plm.8
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 14:57:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 23 Jan 2019 14:56:52 -0800
Message-Id: <20190123225705.28963-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/13] Dynamic TLB sizing, backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

This is Emilio's v7 unchanged, plus all of the backends updated.
Finally, remove the static tlb sizing so that we only support 
the one code path.

I have tested all of these, though riscv, s390 and mips were
done under qemu emulation itself.

I'll leave some time for comment, but otherwise will include
these in my next tcg pull request.


r~


Emilio G. Cota (3):
  cputlb: do not evict empty entries to the vtlb
  tcg: introduce dynamic TLB sizing
  tcg/i386: enable dynamic TLB sizing

Richard Henderson (10):
  tcg/aarch64: enable dynamic TLB sizing
  tcg/ppc: enable dynamic TLB sizing
  tcg/sparc: enable dynamic TLB sizing
  tcg/s390: enable dynamic TLB sizing
  tcg/riscv: enable dynamic TLB sizing
  tcg/arm: enable dynamic TLB sizing
  tcg/mips: Fix tcg_out_qemu_ld_slow_path
  tcg/mips: enable dynamic TLB sizing
  tcg/tci: enable dynamic TLB sizing
  cputlb: Remove static tlb sizing

 include/exec/cpu-defs.h      |  71 +++++++------
 include/exec/cpu_ldst.h      |   9 +-
 accel/tcg/cputlb.c           | 192 +++++++++++++++++++++++++++++++++--
 tcg/aarch64/tcg-target.inc.c | 100 ++++++++++--------
 tcg/arm/tcg-target.inc.c     | 143 +++++++++++++-------------
 tcg/i386/tcg-target.inc.c    |  28 ++---
 tcg/mips/tcg-target.inc.c    |  97 ++++++++++++------
 tcg/ppc/tcg-target.inc.c     |  91 +++++++++--------
 tcg/riscv/tcg-target.inc.c   | 126 ++++++++++-------------
 tcg/s390/tcg-target.inc.c    |  45 ++++----
 tcg/sparc/tcg-target.inc.c   |  82 +++++++++------
 11 files changed, 617 insertions(+), 367 deletions(-)

-- 
2.17.2
