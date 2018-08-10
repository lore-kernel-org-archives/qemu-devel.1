Received: from eggs.gnu.org ([2001:4830:134:3::10]:52934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fo909-0002GI-Vm
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fo909-0005ia-2m
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:06:53 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fo908-0005h1-Rs
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:06:52 -0400
Received: by mail-pl0-x242.google.com with SMTP id b90-v6so4174901plb.0
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 08:06:52 -0700 (PDT)
References: <20180809214356.27690-1-cota@braap.org>
	<20180809214356.27690-3-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b580d269-4a05-eaa1-004d-230163306d79@linaro.org>
Date: Fri, 10 Aug 2018 08:06:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180809214356.27690-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] target/riscv: optimize indirect
 branches
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

On 08/09/2018 02:43 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/riscv/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index ec2988b4f6..66a80ca772 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -548,7 +548,7 @@ static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
>          if (rd != 0) {
>              tcg_gen_movi_tl(cpu_gpr[rd], ctx->pc_succ_insn);
>          }
> -        tcg_gen_exit_tb(NULL, 0);
> +        tcg_gen_lookup_and_goto_ptr();
>  
>          if (misaligned) {
>              gen_set_label(misaligned);
> 


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
