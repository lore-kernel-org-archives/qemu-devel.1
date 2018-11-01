Received: from eggs.gnu.org ([2001:4830:134:3::10]:51932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIFu3-0000DF-5O
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIFu2-0003b4-6P
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:33:03 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:44375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIFu0-0003Zc-I3
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:33:00 -0400
Received: by mail-oi1-x22d.google.com with SMTP id k19-v6so17100954oic.11
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 09:33:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181031122119.1669-1-richard.henderson@linaro.org>
References: <20181031122119.1669-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 16:32:39 +0000
Message-ID: <CAFEAcA-3X46a1NxLwOsLkB1s+qcrsphkjcgvDqwPFKiVy9pFhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] cputlb: track dirty tlbs and general
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 October 2018 at 12:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20181031
>
> for you to fetch changes up to ab6511053015b9cc636915e2c2b97305cbf044f0:
>
>   cputlb: Remove tlb_c.pending_flushes (2018-10-31 12:16:39 +0000)
>
> ----------------------------------------------------------------
> Track mmu_idx for which the TLB is clean and need not be flushed again.
>
> ----------------------------------------------------------------
> Richard Henderson (10):
>       cputlb: Move tlb_lock to CPUTLBCommon
>       cputlb: Remove tcg_enabled hack from tlb_flush_nocheck
>       cputlb: Move cpu->pending_tlb_flush to env->tlb_c.pending_flush
>       cputlb: Split large page tracking per mmu_idx
>       cputlb: Move env->vtlb_index to env->tlb_d.vindex
>       cputlb: Merge tlb_flush_nocheck into tlb_flush_by_mmuidx_async_work
>       cputlb: Merge tlb_flush_page into tlb_flush_page_by_mmuidx
>       cputlb: Count "partial" and "elided" tlb flushes
>       cputlb: Filter flushes on already clean tlbs
>       cputlb: Remove tlb_c.pending_flushes
>

Applied, thanks.

-- PMM
