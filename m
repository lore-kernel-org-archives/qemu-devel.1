Received: from eggs.gnu.org ([2001:4830:134:3::10]:54134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqL0a-0000p3-TT
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqL0X-0005c2-Ks
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:20:24 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqL0X-0005bZ-1u
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:20:21 -0400
Received: by mail-pl0-x243.google.com with SMTP id g6-v6so2322510plq.9
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:20:21 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-39-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <126acee7-57af-691e-c5b2-cd0689f9be98@linaro.org>
Date: Thu, 16 Aug 2018 09:20:17 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-39-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 38/84] target/mips: Implement emulation
 of nanoMIPS LLWP/SCWP pair
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
> Implement support for nanoMIPS LLWP/SCWP instructions. Beside
> adding core functionality of these instructions, this patch adds
> support for availability control via configuration bit XNP.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Dimitrije Nikolic <dnikolic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  linux-user/mips/cpu_loop.c | 25 +++++++++++---
>  target/mips/cpu.h          |  5 ++-
>  target/mips/internal.h     |  5 ++-
>  target/mips/translate.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+), 7 deletions(-)

Probably all of the linux-user/ changes are moot.
But we should simply clean that up all at once when
converting the whole mips target to tcg_gen_atomic_*.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
