Received: from eggs.gnu.org ([2001:4830:134:3::10]:59340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLH1-0008M7-A8
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLH0-0006YT-EQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:37:23 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqLH0-0006YN-7A
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:37:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id y5-v6so2318727pgv.1
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:37:22 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-41-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <97501a9d-c00f-7aba-1af2-256629f9abf5@linaro.org>
Date: Thu, 16 Aug 2018 09:37:18 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-41-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 40/84] target/mips: Fix pre-nanoMIPS MT
 ASE instructions availability control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Use bits from configuration registers for availability control
> of MT ASE instructions, rather than only ISA_MT bit in insn_flags.
> This is done by adding a field in hflags for MT bit, and adding
> functions check_mt() and check_cp0_mt().
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h       |  3 ++-
>  target/mips/internal.h  |  6 +++++-
>  target/mips/translate.c | 45 +++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 44 insertions(+), 10 deletions(-)

What was wrong with using insn_flags?

I'll note that hflags should be reserved for things that can change at runtime.
 I thought all of these configuration registers were read-only.

Anyway, with this plus the XNP patch from earlier, you now only have one
remaining bit within hflags and then that resource is exhausted.


r~
