Received: from eggs.gnu.org ([2001:4830:134:3::10]:39037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmkVM-0005CS-1G
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmkVI-0000mG-4P
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:40:48 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:38303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmkVH-0000lI-Ov
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:40:44 -0400
Received: by mail-pg0-x22a.google.com with SMTP id b8so12729650pgn.5
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 10:40:43 -0700 (PDT)
References: <20170829172326.1131-1-bobby.prani@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c7d6fae-25c9-7fc5-9613-281539814509@linaro.org>
Date: Tue, 29 Aug 2017 10:40:39 -0700
MIME-Version: 1.0
In-Reply-To: <20170829172326.1131-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/softmmu: Increase size of TLB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org

On 08/29/2017 10:23 AM, Pranith Kumar wrote:
> This patch increases the number of entries cached in the TLB. I went
> over a few architectures to see if increasing it is problematic. Only
> armv6 seems to have a limitation that only 8 bits can be used for
> indexing these entries. For other architectures, the number of TLB
> entries is increased to a 4K-sized cache. The patch also doubles the
> number of victim TLB entries.
> 
> Some statistics collected from a build benchmark for various cache
> sizes is listed below:
> 
> | TLB bits\vTLB entires |             8 |            16  |            32 |
> |                     8 | 952.94(+0.0%) | 929.99(+2.4%)  | 919.02(+3.6%) |
> |                    10 | 898.92(+5.6%) | 886.13(+7.0%)  | 887.03(+6.9%) |
> |                    12 | 878.56(+7.8%) | 873.53(+8.3%)* | 875.34(+8.1%) |
> 
> The best combination for this workload came out to be 12 bits for the
> TLB and a 16 entry vTLB cache.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  include/exec/cpu-defs.h  | 6 +++---
>  tcg/aarch64/tcg-target.h | 1 +
>  tcg/arm/tcg-target.h     | 1 +
>  tcg/i386/tcg-target.h    | 2 ++
>  tcg/ia64/tcg-target.h    | 1 +
>  tcg/mips/tcg-target.h    | 2 ++
>  tcg/ppc/tcg-target.h     | 1 +
>  tcg/s390/tcg-target.h    | 1 +
>  tcg/sparc/tcg-target.h   | 1 +
>  tcg/tci/tcg-target.h     | 1 +
>  10 files changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
