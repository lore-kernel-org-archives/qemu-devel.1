Received: from eggs.gnu.org ([209.51.188.92]:33318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9Jb-0004jS-2u
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9JZ-0007gs-IK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:43262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9JZ-0007gO-CD
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:13 -0500
Received: by mail-pl1-x634.google.com with SMTP id gn14so7902280plb.10
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:59:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 07:58:44 -0800
Message-Id: <20190128155907.20607-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/23] tcg queued patches
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

The following changes since commit ad7a21e81231ae64540310384fb0f87ac8758b02:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-01-25 17:22:20 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190128

for you to fetch changes up to e77c89fb086a9bf09dd11f72e4cb2093b426f32b:

  cputlb: Remove static tlb sizing (2019-01-28 07:04:35 -0800)

----------------------------------------------------------------
Backend vector enhancements
Dynamic tlb resizing

----------------------------------------------------------------
Emilio G. Cota (3):
      cputlb: do not evict empty entries to the vtlb
      tcg: introduce dynamic TLB sizing
      tcg/i386: enable dynamic TLB sizing

Richard Henderson (20):
      tcg: Add logical simplifications during gvec expand
      tcg: Add gvec expanders for nand, nor, eqv
      tcg: Add write_aofs to GVecGen4
      tcg: Add opcodes for vector saturated arithmetic
      tcg: Add opcodes for vector minmax arithmetic
      tcg/i386: Split subroutines out of tcg_expand_vec_op
      tcg/i386: Implement vector saturating arithmetic
      tcg/i386: Implement vector minmax arithmetic
      tcg/aarch64: Implement vector saturating arithmetic
      tcg/aarch64: Implement vector minmax arithmetic
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

 accel/tcg/tcg-runtime.h      |  23 ++
 include/exec/cpu-defs.h      |  71 ++---
 include/exec/cpu_ldst.h      |   9 +-
 tcg/aarch64/tcg-target.h     |   2 +
 tcg/i386/tcg-target.h        |   2 +
 tcg/tcg-op-gvec.h            |  18 ++
 tcg/tcg-op.h                 |  11 +
 tcg/tcg-opc.h                |   8 +
 tcg/tcg.h                    |   2 +
 accel/tcg/cputlb.c           | 192 +++++++++++++-
 accel/tcg/tcg-runtime-gvec.c | 257 ++++++++++++++++++
 tcg/aarch64/tcg-target.inc.c | 148 ++++++++---
 tcg/arm/tcg-target.inc.c     | 143 +++++-----
 tcg/i386/tcg-target.inc.c    | 608 ++++++++++++++++++++++++++-----------------
 tcg/mips/tcg-target.inc.c    |  97 ++++---
 tcg/ppc/tcg-target.inc.c     |  91 ++++---
 tcg/riscv/tcg-target.inc.c   | 126 ++++-----
 tcg/s390/tcg-target.inc.c    |  45 ++--
 tcg/sparc/tcg-target.inc.c   |  82 +++---
 tcg/tcg-op-gvec.c            | 305 +++++++++++++++++++---
 tcg/tcg-op-vec.c             |  75 +++++-
 tcg/tcg.c                    |  10 +
 tcg/README                   |  19 ++
 23 files changed, 1714 insertions(+), 630 deletions(-)
