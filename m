Received: from eggs.gnu.org ([209.51.188.92]:56907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROj-0002aL-Jw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRB4-0002Qt-Eq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:44:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRB2-0002P2-P8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:44:01 -0400
Received: by mail-oi1-x241.google.com with SMTP id l203so10971028oia.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-10-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:43:47 +0100
Message-ID: <CAFEAcA-WRtet-ww==U4F6hxjJ9pRWVbqPAGHFPaMazyaUgTDGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/26] target/m68k: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Wed, 3 Apr 2019 at 04:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/m68k/cpu.h       |  5 ++-
>  target/m68k/cpu.c       |  2 +-
>  target/m68k/helper.c    | 87 ++++++++++++++++++++++-------------------
>  target/m68k/op_helper.c | 15 -------
>  4 files changed, 50 insertions(+), 59 deletions(-)

> @@ -804,11 +791,36 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      return phys_addr;
>  }
>
> -int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> -                              int mmu_idx)
> +/*
> + * Notify CPU of a pending interrupt.  Prioritization and vectoring should
> + * be handled by the interrupt controller.  Real hardware only requests
> + * the vector when the interrupt is acknowledged by the CPU.  For
> + * simplicitly we calculate it when the interrupt is signalled.
> + */

I know this is just code motion, but perhaps we could fix the typo
in passing ("simplicity").

In any case
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
