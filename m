Received: from eggs.gnu.org ([209.51.188.92]:41859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDtS-0003ff-Az
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDtR-0002Aa-BF
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:57:14 -0400
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-6-mark.cave-ayland@ilande.co.uk>
	<784adbd2-0447-9d01-cff8-e7234f9d9679@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ca2255e7-79cd-2ef1-5ddf-89edac2ba959@ilande.co.uk>
Date: Sun, 5 May 2019 10:57:03 +0100
MIME-Version: 1.0
In-Reply-To: <784adbd2-0447-9d01-cff8-e7234f9d9679@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 30/04/2019 17:38, Richard Henderson wrote:
> On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>> +#define GEN_VSX_HELPER_X2(name, op1, op2, inval, type)                        \
>> +static void gen_##name(DisasContext *ctx)                                     \
>> +{                                                                             \
>> +    TCGv_i32 opc;                                                             \
>> +    TCGv_ptr xt, xb;                                                          \
>> +    if (unlikely(!ctx->vsx_enabled)) {                                        \
>> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
>> +        return;                                                               \
>> +    }                                                                         \
>> +    opc = tcg_const_i32(ctx->opcode);                                         \
>> +    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
>> +    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
>> +    gen_helper_##name(cpu_env, opc, xt, xb);                                  \
> 
> Similarly wrt opc.  However,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

For reference the culprits here is helper_xscvqpdp(). But again if you agree that it
makes sense to create separate gen/helper functions then I can remove the opcode
later on in the series.


ATB,

Mark.
