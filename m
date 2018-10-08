Received: from eggs.gnu.org ([2001:4830:134:3::10]:59116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9Lw0-0003za-KE
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9LnB-0004N7-BE
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:01:13 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9Ln9-0004MU-A3
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:01:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id s4-v6so9366392plp.0
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 20:01:06 -0700 (PDT)
References: <20181006214508.5331-1-cota@braap.org>
	<20181006214508.5331-6-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4d70e50c-ebfa-6812-6815-8092ebf4f62f@linaro.org>
Date: Sun, 7 Oct 2018 20:01:03 -0700
MIME-Version: 1.0
In-Reply-To: <20181006214508.5331-6-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 5/6] cpu-defs: define MIN_CPU_TLB_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/6/18 2:45 PM, Emilio G. Cota wrote:
> @@ -89,7 +89,7 @@ typedef uint64_t target_ulong;
>   * 0x18 (the offset of the addend field in each TLB entry) plus the offset
>   * of tlb_table inside env (which is non-trivial but not huge).
>   */
> -#define CPU_TLB_BITS                                             \
> +#define MIN_CPU_TLB_BITS                                         \
>      MIN(8,                                                       \
>          TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
>          (NB_MMU_MODES <= 1 ? 0 :                                 \

There's no point in this either, since the original constraint was due to the
immediate offset into an add instruction.  Now we're loading the base address
from an array.  The actual size of the tlb is immaterial now, since the size of
the tlb does not affect the size of CPUArchState.


r~
