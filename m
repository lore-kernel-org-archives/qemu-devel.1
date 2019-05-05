Received: from eggs.gnu.org ([209.51.188.92]:45532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNE3o-0008Bw-Np
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNE3n-00032x-T7
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:07:56 -0400
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-9-mark.cave-ayland@ilande.co.uk>
	<4c8b7939-cd48-fd3f-8f3d-3f6fd18b6be2@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <443b8459-8ad8-275f-225f-84c78d5fd7cc@ilande.co.uk>
Date: Sun, 5 May 2019 11:07:46 +0100
MIME-Version: 1.0
In-Reply-To: <4c8b7939-cd48-fd3f-8f3d-3f6fd18b6be2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 30/04/2019 17:47, Richard Henderson wrote:

> On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>> +#define GEN_VSX_HELPER_R3(name, op1, op2, inval, type)                        \
>> +static void gen_##name(DisasContext *ctx)                                     \
>> +{                                                                             \
>> +    TCGv_i32 opc;                                                             \
>> +    TCGv_ptr xt, xa, xb;                                                      \
>> +    if (unlikely(!ctx->vsx_enabled)) {                                        \
>> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
>> +        return;                                                               \
>> +    }                                                                         \
>> +    opc = tcg_const_i32(ctx->opcode);                                         \
>> +    xt = gen_vsr_ptr(rD(ctx->opcode) + 32);                                   \
>> +    xa = gen_vsr_ptr(rA(ctx->opcode) + 32);                                   \
>> +    xb = gen_vsr_ptr(rB(ctx->opcode) + 32);                                   \
>> +    gen_helper_##name(cpu_env, opc, xt, xa, xb);                              \
> 
> Is opc still used here?  Otherwise,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Yeah, looks like it's used for the rounding mode. I'll have a look and see how this
compares with the previous case.


ATB,

Mark.
