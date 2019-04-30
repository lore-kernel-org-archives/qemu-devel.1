Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2P-00048d-MF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVvH-0005vd-0N
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:48:03 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:32982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVvG-0005vN-Pu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:48:02 -0400
Received: by mail-pf1-x441.google.com with SMTP id z28so2039567pfk.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:48:02 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-9-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4c8b7939-cd48-fd3f-8f3d-3f6fd18b6be2@linaro.org>
Date: Tue, 30 Apr 2019 09:47:51 -0700
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/14] target/ppc: introduce
 GEN_VSX_HELPER_R3 macro to fpu_helper.c
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
> +#define GEN_VSX_HELPER_R3(name, op1, op2, inval, type)                        \
> +static void gen_##name(DisasContext *ctx)                                     \
> +{                                                                             \
> +    TCGv_i32 opc;                                                             \
> +    TCGv_ptr xt, xa, xb;                                                      \
> +    if (unlikely(!ctx->vsx_enabled)) {                                        \
> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
> +        return;                                                               \
> +    }                                                                         \
> +    opc = tcg_const_i32(ctx->opcode);                                         \
> +    xt = gen_vsr_ptr(rD(ctx->opcode) + 32);                                   \
> +    xa = gen_vsr_ptr(rA(ctx->opcode) + 32);                                   \
> +    xb = gen_vsr_ptr(rB(ctx->opcode) + 32);                                   \
> +    gen_helper_##name(cpu_env, opc, xt, xa, xb);                              \

Is opc still used here?  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
