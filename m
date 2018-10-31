Received: from eggs.gnu.org ([2001:4830:134:3::10]:48801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpV5-0000Wp-PS
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpUw-00017S-Gb
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:21:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHpUw-00016Y-9h
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:21:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id w5-v6so16263260wrt.2
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:21:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 12:21:09 +0000
Message-Id: <20181031122119.1669-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 00/10] cputlb: track dirty tlbs and general
 cleanup
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

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20181031

for you to fetch changes up to ab6511053015b9cc636915e2c2b97305cbf044f0:

  cputlb: Remove tlb_c.pending_flushes (2018-10-31 12:16:39 +0000)

----------------------------------------------------------------
Track mmu_idx for which the TLB is clean and need not be flushed again.

----------------------------------------------------------------
Richard Henderson (10):
      cputlb: Move tlb_lock to CPUTLBCommon
      cputlb: Remove tcg_enabled hack from tlb_flush_nocheck
      cputlb: Move cpu->pending_tlb_flush to env->tlb_c.pending_flush
      cputlb: Split large page tracking per mmu_idx
      cputlb: Move env->vtlb_index to env->tlb_d.vindex
      cputlb: Merge tlb_flush_nocheck into tlb_flush_by_mmuidx_async_work
      cputlb: Merge tlb_flush_page into tlb_flush_page_by_mmuidx
      cputlb: Count "partial" and "elided" tlb flushes
      cputlb: Filter flushes on already clean tlbs
      cputlb: Remove tlb_c.pending_flushes

 include/exec/cpu-defs.h   |  51 +++++--
 include/exec/cputlb.h     |   2 +-
 include/qom/cpu.h         |   6 -
 accel/tcg/cputlb.c        | 353 +++++++++++++++++-----------------------------
 accel/tcg/translate-all.c |   8 +-
 5 files changed, 183 insertions(+), 237 deletions(-)
