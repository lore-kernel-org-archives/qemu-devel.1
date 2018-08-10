Received: from eggs.gnu.org ([2001:4830:134:3::10]:38434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foDSG-0008PX-Ur
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foDSC-0008DI-CN
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:52:12 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foDSC-0008BS-4B
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:52:08 -0400
Received: by mail-pg1-x543.google.com with SMTP id n7-v6so4861429pgq.4
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:52:07 -0700 (PDT)
References: <20180810173941.5301-1-cota@braap.org>
	<20180810173941.5301-4-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e94b4ac1-a00d-f67b-fea5-49fd50840c8a@linaro.org>
Date: Fri, 10 Aug 2018 12:52:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180810173941.5301-4-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] target/riscv: call gen_goto_tb on
 DISAS_TOO_MANY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 08/10/2018 10:39 AM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/riscv/translate.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 66a80ca772..18d7b6d147 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1868,12 +1868,7 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>  
>      switch (ctx->base.is_jmp) {
>      case DISAS_TOO_MANY:
> -        tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
> -        if (ctx->base.singlestep_enabled) {
> -            gen_exception_debug();
> -        } else {
> -            tcg_gen_exit_tb(NULL, 0);
> -        }
> +        gen_goto_tb(ctx, 0, ctx->base.pc_next);
>          break;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
