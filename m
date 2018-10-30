Received: from eggs.gnu.org ([2001:4830:134:3::10]:44142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTnZ-00024o-Gl
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTnU-0004WT-Kn
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:11:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHTnU-0004Vt-DM
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:11:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so11239974wmd.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:11:04 -0700 (PDT)
References: <1540899411-16761-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540899411-16761-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dcf9f0c0-c077-89de-c209-d0a38c2e0319@redhat.com>
Date: Tue, 30 Oct 2018 14:11:01 +0100
MIME-Version: 1.0
In-Reply-To: <1540899411-16761-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target/mips: Rename MMI-related
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, pjovanovic@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 30/10/18 12:36, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Rename MMI-related functions.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   target/mips/translate.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 4b008d8..155331f 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -24681,7 +24681,7 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
>       }
>   }
>   
> -static void decode_tx79_mmi0(CPUMIPSState *env, DisasContext *ctx)
> +static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
>   {
>       uint32_t opc = MASK_MMI0(ctx->opcode);
>   
> @@ -24720,7 +24720,7 @@ static void decode_tx79_mmi0(CPUMIPSState *env, DisasContext *ctx)
>       }
>   }
>   
> -static void decode_tx79_mmi1(CPUMIPSState *env, DisasContext *ctx)
> +static void decode_mmi1(CPUMIPSState *env, DisasContext *ctx)
>   {
>       uint32_t opc = MASK_MMI1(ctx->opcode);
>   
> @@ -24752,7 +24752,7 @@ static void decode_tx79_mmi1(CPUMIPSState *env, DisasContext *ctx)
>       }
>   }
>   
> -static void decode_tx79_mmi2(CPUMIPSState *env, DisasContext *ctx)
> +static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
>   {
>       uint32_t opc = MASK_MMI2(ctx->opcode);
>   
> @@ -24788,7 +24788,7 @@ static void decode_tx79_mmi2(CPUMIPSState *env, DisasContext *ctx)
>       }
>   }
>   
> -static void decode_tx79_mmi3(CPUMIPSState *env, DisasContext *ctx)
> +static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
>   {
>       uint32_t opc = MASK_MMI3(ctx->opcode);
>   
> @@ -24815,7 +24815,7 @@ static void decode_tx79_mmi3(CPUMIPSState *env, DisasContext *ctx)
>       }
>   }
>   
> -static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
> +static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
>   {
>       uint32_t opc = MASK_MMI(ctx->opcode);
>       int rs = extract32(ctx->opcode, 21, 5);
> @@ -24824,16 +24824,16 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
>   
>       switch (opc) {
>       case MMI_OPC_CLASS_MMI0:
> -        decode_tx79_mmi0(env, ctx);
> +        decode_mmi0(env, ctx);
>           break;
>       case MMI_OPC_CLASS_MMI1:
> -        decode_tx79_mmi1(env, ctx);
> +        decode_mmi1(env, ctx);
>           break;
>       case MMI_OPC_CLASS_MMI2:
> -        decode_tx79_mmi2(env, ctx);
> +        decode_mmi2(env, ctx);
>           break;
>       case MMI_OPC_CLASS_MMI3:
> -        decode_tx79_mmi3(env, ctx);
> +        decode_mmi3(env, ctx);
>           break;
>       case MMI_OPC_MULT1:
>       case MMI_OPC_MULTU1:
> @@ -24873,12 +24873,12 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
>       }
>   }
>   
> -static void decode_tx79_lq(CPUMIPSState *env, DisasContext *ctx)
> +static void decode_mmi_lq(CPUMIPSState *env, DisasContext *ctx)
>   {
>       generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_LQ */
>   }
>   
> -static void gen_tx79_sq(DisasContext *ctx, int base, int rt, int offset)
> +static void gen_mmi_sq(DisasContext *ctx, int base, int rt, int offset)
>   {
>       generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_SQ */
>   }
> @@ -24904,7 +24904,7 @@ static void gen_tx79_sq(DisasContext *ctx, int base, int rt, int offset)
>    * In user mode, QEMU must verify the upper and lower 11 bits to distinguish
>    * between SQ and RDHWR, as the Linux kernel does.
>    */
> -static void decode_tx79_sq(CPUMIPSState *env, DisasContext *ctx)
> +static void decode_mmi_sq(CPUMIPSState *env, DisasContext *ctx)
>   {
>       int base = extract32(ctx->opcode, 21, 5);
>       int rt = extract32(ctx->opcode, 16, 5);
> @@ -24922,7 +24922,7 @@ static void decode_tx79_sq(CPUMIPSState *env, DisasContext *ctx)
>       }
>   #endif
>   
> -    gen_tx79_sq(ctx, base, rt, offset);
> +    gen_mmi_sq(ctx, base, rt, offset);
>   }
>   
>   static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
> @@ -26231,14 +26231,14 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
>           break;
>       case OPC_SPECIAL2:
>           if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI)) {
> -            decode_tx79_mmi(env, ctx);
> +            decode_mmi(env, ctx);
>           } else {
>               decode_opc_special2_legacy(env, ctx);
>           }
>           break;
>       case OPC_SPECIAL3:
>           if (ctx->insn_flags & INSN_R5900) {
> -            decode_tx79_sq(env, ctx);    /* MMI_SQ */
> +            decode_mmi_sq(env, ctx);    /* MMI_SQ */
>           } else {
>               decode_opc_special3(env, ctx);
>           }
> @@ -26902,7 +26902,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
>           break;
>       case OPC_MSA: /* OPC_MDMX */
>           if (ctx->insn_flags & INSN_R5900) {
> -            decode_tx79_lq(env, ctx);    /* MMI_LQ */
> +            decode_mmi_lq(env, ctx);    /* MMI_LQ */
>           } else {
>               /* MDMX: Not implemented. */
>               gen_msa(env, ctx);
> 
