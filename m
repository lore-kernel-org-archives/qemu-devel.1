Received: from eggs.gnu.org ([2001:4830:134:3::10]:44976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72NN-0003et-8o
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72NJ-0005YI-8h
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:16:09 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72NJ-0005YA-4i
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:16:05 -0400
Received: by mail-qt0-x242.google.com with SMTP id j13so4572338qta.3
	for <qemu-devel@nongnu.org>; Sat, 06 May 2017 09:16:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-4-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e34024e-d544-78e5-7ade-a2eb49eb9fd7@amsat.org>
Date: Sat, 6 May 2017 13:16:00 -0300
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-4-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/14] target/sh4: do not include
 DELAY_SLOT_TRUE in the TB state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/06/2017 08:14 AM, Aurelien Jarno wrote:
> DELAY_SLOT_TRUE is used as a dynamic condition for the branch after the
> delay slot instruction. It is not used in code generation, so there is
> no need to including in the TB state.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/cpu.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index 9445cc779f..da8d15f1b9 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -382,8 +382,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
>  {
>      *pc = env->pc;
>      *cs_base = 0;
> -    *flags = (env->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL
> -                    | DELAY_SLOT_TRUE))                        /* Bits  0- 2 */
> +    *flags = (env->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) /* Bits 0-1 */
>              | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
>              | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
>              | (env->sr & (1u << SR_FD))                        /* Bit 15 */
>
