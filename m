Received: from eggs.gnu.org ([209.51.188.92]:36674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVmF-0001Dh-Pm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVmE-0002MF-Ub
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:38:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:41681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVmE-0002Lt-PC
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:38:42 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 188so7323719pfd.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:38:42 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-6-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <784adbd2-0447-9d01-cff8-e7234f9d9679@linaro.org>
Date: Tue, 30 Apr 2019 09:38:35 -0700
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/14] target/ppc: introduce
 GEN_VSX_HELPER_X2 macro to fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> +#define GEN_VSX_HELPER_X2(name, op1, op2, inval, type)                        \
> +static void gen_##name(DisasContext *ctx)                                     \
> +{                                                                             \
> +    TCGv_i32 opc;                                                             \
> +    TCGv_ptr xt, xb;                                                          \
> +    if (unlikely(!ctx->vsx_enabled)) {                                        \
> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
> +        return;                                                               \
> +    }                                                                         \
> +    opc = tcg_const_i32(ctx->opcode);                                         \
> +    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
> +    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
> +    gen_helper_##name(cpu_env, opc, xt, xb);                                  \

Similarly wrt opc.  However,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
