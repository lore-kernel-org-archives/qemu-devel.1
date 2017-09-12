Received: from eggs.gnu.org ([2001:4830:134:3::10]:60643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqIU-00076p-Hd
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqIR-0008Ks-9w
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:52:34 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqIR-0008KO-50
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:52:31 -0400
Received: by mail-qk0-x241.google.com with SMTP id o77so7705387qke.2
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 11:52:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7e503b73-717a-d874-2610-de0697e68158@amsat.org>
Date: Tue, 12 Sep 2017 15:52:27 -0300
MIME-Version: 1.0
In-Reply-To: <20170912162513.21694-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/16] tcg: Remove tcg_regset_clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

On 09/12/2017 01:25 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tcg/tcg.h                    | 1 -
>   tcg/aarch64/tcg-target.inc.c | 2 +-
>   tcg/arm/tcg-target.inc.c     | 2 +-
>   tcg/i386/tcg-target.inc.c    | 4 ++--
>   tcg/mips/tcg-target.inc.c    | 2 +-
>   tcg/ppc/tcg-target.inc.c     | 2 +-
>   tcg/s390/tcg-target.inc.c    | 8 ++++----
>   tcg/sparc/tcg-target.inc.c   | 2 +-
>   tcg/tcg.c                    | 5 ++---
>   tcg/tci/tcg-target.inc.c     | 2 +-
>   10 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 37ad9fddab..7226727ee4 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -210,7 +210,6 @@ typedef enum TCGOpcode {
>       NB_OPS,
>   } TCGOpcode;
>   
> -#define tcg_regset_clear(d) (d) = 0
>   #define tcg_regset_set(d, s) (d) = (s)
>   #define tcg_regset_set32(d, reg, val32) (d) |= (val32) << (reg)
>   #define tcg_regset_set_reg(d, r) (d) |= 1L << (r)
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 1ff32e43f5..141a86a57d 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1960,7 +1960,7 @@ static void tcg_target_init(TCGContext *s)
>                        (1 << TCG_REG_X16) | (1 << TCG_REG_X17) |
>                        (1 << TCG_REG_X18) | (1 << TCG_REG_X30));
>   
> -    tcg_regset_clear(s->reserved_regs);
> +    s->reserved_regs = 0;
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_FP);
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index db46aea38c..f0c176554b 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -2173,7 +2173,7 @@ static void tcg_target_init(TCGContext *s)
>                        (1 << TCG_REG_R12) |
>                        (1 << TCG_REG_R14));
>   
> -    tcg_regset_clear(s->reserved_regs);
> +    s->reserved_regs = 0;
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_PC);
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index fbb41c3b7a..e9766f6686 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -2999,7 +2999,7 @@ static void tcg_target_init(TCGContext *s)
>           tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_V256], 0, 0xff0000);
>       }
>   
> -    tcg_regset_clear(tcg_target_call_clobber_regs);
> +    tcg_target_call_clobber_regs = 0;
>       tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_EAX);
>       tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_EDX);
>       tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_ECX);
> @@ -3014,7 +3014,7 @@ static void tcg_target_init(TCGContext *s)
>           tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R11);
>       }
>   
> -    tcg_regset_clear(s->reserved_regs);
> +    s->reserved_regs = 0;
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
>   }
>   
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 750baadf37..85c1abd14b 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -2629,7 +2629,7 @@ static void tcg_target_init(TCGContext *s)
>                      (1 << TCG_REG_T8) |
>                      (1 << TCG_REG_T9));
>   
> -    tcg_regset_clear(s->reserved_regs);
> +    s->reserved_regs = 0;
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_ZERO); /* zero register */
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_K0);   /* kernel use only */
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_K1);   /* kernel use only */
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 21d764c102..b1df1e146a 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -2786,7 +2786,7 @@ static void tcg_target_init(TCGContext *s)
>                        (1 << TCG_REG_R11) |
>                        (1 << TCG_REG_R12));
>   
> -    tcg_regset_clear(s->reserved_regs);
> +    s->reserved_regs = 0;
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_R0); /* tcg temp */
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_R1); /* stack pointer */
>   #if defined(_CALL_SYSV)
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index e7ab8e4df3..01baa33673 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -413,12 +413,12 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
>           break;
>       case 'a':                  /* force R2 for division */
>           ct->ct |= TCG_CT_REG;
> -        tcg_regset_clear(ct->u.regs);
> +        ct->u.regs = 0;
>           tcg_regset_set_reg(ct->u.regs, TCG_REG_R2);
>           break;
>       case 'b':                  /* force R3 for division */
>           ct->ct |= TCG_CT_REG;
> -        tcg_regset_clear(ct->u.regs);
> +        ct->u.regs = 0;
>           tcg_regset_set_reg(ct->u.regs, TCG_REG_R3);
>           break;
>       case 'A':
> @@ -2522,7 +2522,7 @@ static void tcg_target_init(TCGContext *s)
>       tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffff);
>       tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I64], 0, 0xffff);
>   
> -    tcg_regset_clear(tcg_target_call_clobber_regs);
> +    tcg_target_call_clobber_regs = 0;
>       tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
>       tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R1);
>       tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R2);
> @@ -2535,7 +2535,7 @@ static void tcg_target_init(TCGContext *s)
>       /* The return register can be considered call-clobbered.  */
>       tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R14);
>   
> -    tcg_regset_clear(s->reserved_regs);
> +    s->reserved_regs = 0;
>       tcg_regset_set_reg(s->reserved_regs, TCG_TMP0);
>       /* XXX many insns can't be used with R0, so we better avoid it for now */
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_R0);
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index bd7c1461c6..ccd83205d5 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -1771,7 +1771,7 @@ static void tcg_target_init(TCGContext *s)
>                        (1 << TCG_REG_O5) |
>                        (1 << TCG_REG_O7));
>   
> -    tcg_regset_clear(s->reserved_regs);
> +    s->reserved_regs = 0;
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_G0); /* zero */
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_G6); /* reserved for os */
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_G7); /* thread pointer */
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 240bcaa8d5..f40cce3364 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1590,7 +1590,7 @@ static void process_op_defs(TCGContext *s)
>               /* Incomplete TCGTargetOpDef entry. */
>               tcg_debug_assert(ct_str != NULL);
>   
> -            tcg_regset_clear(def->args_ct[i].u.regs);
> +            def->args_ct[i].u.regs = 0;
>               def->args_ct[i].ct = 0;
>               while (*ct_str != '\0') {
>                   switch(*ct_str) {
> @@ -2754,9 +2754,8 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
>                       tcg_out_mov(s, ts->type, reg, ts->reg);
>                   }
>               } else {
> -                TCGRegSet arg_set;
> +                TCGRegSet arg_set = 0;
>   
> -                tcg_regset_clear(arg_set);
>                   tcg_regset_set_reg(arg_set, reg);
>                   temp_load(s, ts, arg_set, allocated_regs);
>               }
> diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
> index 94461b2baf..f9644334cc 100644
> --- a/tcg/tci/tcg-target.inc.c
> +++ b/tcg/tci/tcg-target.inc.c
> @@ -879,7 +879,7 @@ static void tcg_target_init(TCGContext *s)
>       tcg_regset_set32(tcg_target_call_clobber_regs, 0,
>                        BIT(TCG_TARGET_NB_REGS) - 1);
>   
> -    tcg_regset_clear(s->reserved_regs);
> +    s->reserved_regs = 0;
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
>   
>       /* We use negative offsets from "sp" so that we can distinguish
> 
