Received: from eggs.gnu.org ([2001:4830:134:3::10]:54433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsdr-00037r-Jn
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsdm-00006g-MO
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:31:35 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsdm-00006D-IE
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:31:30 -0400
Received: by mail-qt0-x243.google.com with SMTP id c20so7848844qte.0
	for <qemu-devel@nongnu.org>; Sat, 08 Jul 2017 09:31:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-6-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e7ed0c03-85f2-915d-718c-afdd1ad5a071@amsat.org>
Date: Sat, 8 Jul 2017 13:31:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170707022111.21836-6-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/27] target/sh4: Adjust
 TB_FLAG_PENDING_MOVCA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: bruno@clisp.org, laurent@vivier.eu, aurelien@aurel32.net, glaubitz@debian.org

On 07/06/2017 11:20 PM, Richard Henderson wrote:
> Don't leave an unused bit after DELAY_SLOT_MASK.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/sh4/cpu.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index 6d179a7..da31805 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -96,6 +96,8 @@
>   #define DELAY_SLOT_CONDITIONAL (1 << 1)
>   #define DELAY_SLOT_RTE         (1 << 2)
>   
> +#define TB_FLAG_PENDING_MOVCA  (1 << 3)
> +
>   #define TB_FLAG_ENVFLAGS_MASK  DELAY_SLOT_MASK
>   
>   typedef struct tlb_t {
> @@ -369,8 +371,6 @@ static inline int cpu_ptel_pr (uint32_t ptel)
>   #define PTEA_TC        (1 << 3)
>   #define cpu_ptea_tc(ptea) (((ptea) & PTEA_TC) >> 3)
>   
> -#define TB_FLAG_PENDING_MOVCA  (1 << 4)
> -
>   static inline target_ulong cpu_read_sr(CPUSH4State *env)
>   {
>       return env->sr | (env->sr_m << SR_M) |
> @@ -395,7 +395,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
>               | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
>               | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
>               | (env->sr & (1u << SR_FD))                        /* Bit 15 */
> -            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 4 */
> +            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 3 */
>   }
>   
>   #endif /* SH4_CPU_H */
> 
