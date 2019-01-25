Received: from eggs.gnu.org ([209.51.188.92]:59718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gmpd2-0008Tr-Am
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 19:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gmpUU-0000BY-DZ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 19:37:03 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gmpUU-0000Ap-8d
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 19:37:02 -0500
Received: by mail-pg1-x542.google.com with SMTP id s198so3435210pgs.2
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 16:37:01 -0800 (PST)
Date: Thu, 24 Jan 2019 16:36:59 -0800 (PST)
In-Reply-To: <CAKmqyKOgQLX3Feh=g2ytdiSbFaedWdExpVVjMt6v+SUqxRYhzQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-8ea8314c-74f3-485d-a128-9fe9418ba593@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 5/8] RISC-V: Add priv_ver to DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: richard.henderson@linaro.org, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org

On Tue, 15 Jan 2019 14:25:44 PST (-0800), alistair23@gmail.com wrote:
> On Tue, Jan 15, 2019 at 2:24 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 1/15/19 10:58 AM, Alistair Francis wrote:
>> > -static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>> > +static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
>>
>> Why change this?  I know there is variation in the naming, but my
>> preferred default mapping is CPUState *cs, RISCVCPU *cpu.
>
> Good point, I have changed it back to cs.

I don't see a v2, so I'm just going to go ahead and squash in

    diff --git a/target/riscv/translate.c b/target/riscv/translate.c
    index 8593c2170af4..b7176cbf98e1 100644
    --- a/target/riscv/translate.c
    +++ b/target/riscv/translate.c
    @@ -2015,10 +2015,10 @@ static void decode_opc(DisasContext *ctx)
         }
     }
    
    -static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
    +static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     {
         DisasContext *ctx = container_of(dcbase, DisasContext, base);
    -    CPURISCVState *env = cpu->env_ptr;
    +    CPURISCVState *env = cs->env_ptr;
    
         ctx->pc_succ_insn = ctx->base.pc_first;
         ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;

and add Richard's tag.

>
> Alistair
>
>>
>> Otherwise,
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
