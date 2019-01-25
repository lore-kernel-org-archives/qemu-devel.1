Received: from eggs.gnu.org ([209.51.188.92]:42698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gn9yE-0003Hf-0N
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gn9yC-0006di-4K
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:29:05 -0500
References: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
	<20190123092538.8004-29-kbastian@mail.uni-paderborn.de>
From: Alistair <alistair23@gmail.com>
Message-ID: <4dd52d4c-5c17-bf31-553d-1368494a63aa@gmail.com>
Date: Fri, 25 Jan 2019 14:28:56 -0800
MIME-Version: 1.0
In-Reply-To: <20190123092538.8004-29-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 28/35] target/riscv: Rename trans_arith
 to gen_arith
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 1/23/19 1:25 AM, Bastian Koppelmann wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/insn_trans/trans_rvi.inc.c | 18 +++++++++---------
>   target/riscv/insn_trans/trans_rvm.inc.c | 14 +++++++-------
>   target/riscv/translate.c                |  4 ++--
>   3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index eac79f076f..904ae44968 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -307,12 +307,12 @@ static bool trans_srai(DisasContext *ctx, arg_srai *a)
>   
>   static bool trans_add(DisasContext *ctx, arg_add *a)
>   {
> -    return trans_arith(ctx, a, &tcg_gen_add_tl);
> +    return gen_arith(ctx, a, &tcg_gen_add_tl);
>   }
>   
>   static bool trans_sub(DisasContext *ctx, arg_sub *a)
>   {
> -    return trans_arith(ctx, a, &tcg_gen_sub_tl);
> +    return gen_arith(ctx, a, &tcg_gen_sub_tl);
>   }
>   
>   static bool trans_sll(DisasContext *ctx, arg_sll *a)
> @@ -322,17 +322,17 @@ static bool trans_sll(DisasContext *ctx, arg_sll *a)
>   
>   static bool trans_slt(DisasContext *ctx, arg_slt *a)
>   {
> -    return trans_arith(ctx, a, &gen_slt);
> +    return gen_arith(ctx, a, &gen_slt);
>   }
>   
>   static bool trans_sltu(DisasContext *ctx, arg_sltu *a)
>   {
> -    return trans_arith(ctx, a, &gen_sltu);
> +    return gen_arith(ctx, a, &gen_sltu);
>   }
>   
>   static bool trans_xor(DisasContext *ctx, arg_xor *a)
>   {
> -    return trans_arith(ctx, a, &tcg_gen_xor_tl);
> +    return gen_arith(ctx, a, &tcg_gen_xor_tl);
>   }
>   
>   static bool trans_srl(DisasContext *ctx, arg_srl *a)
> @@ -347,12 +347,12 @@ static bool trans_sra(DisasContext *ctx, arg_sra *a)
>   
>   static bool trans_or(DisasContext *ctx, arg_or *a)
>   {
> -    return trans_arith(ctx, a, &tcg_gen_or_tl);
> +    return gen_arith(ctx, a, &tcg_gen_or_tl);
>   }
>   
>   static bool trans_and(DisasContext *ctx, arg_and *a)
>   {
> -    return trans_arith(ctx, a, &tcg_gen_and_tl);
> +    return gen_arith(ctx, a, &tcg_gen_and_tl);
>   }
>   
>   #ifdef TARGET_RISCV64
> @@ -399,12 +399,12 @@ static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
>   
>   static bool trans_addw(DisasContext *ctx, arg_addw *a)
>   {
> -    return trans_arith(ctx, a, &gen_addw);
> +    return gen_arith(ctx, a, &gen_addw);
>   }
>   
>   static bool trans_subw(DisasContext *ctx, arg_subw *a)
>   {
> -    return trans_arith(ctx, a, &gen_subw);
> +    return gen_arith(ctx, a, &gen_subw);
>   }
>   
>   static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
> diff --git a/target/riscv/insn_trans/trans_rvm.inc.c b/target/riscv/insn_trans/trans_rvm.inc.c
> index 949f59ddb2..5844d6f5be 100644
> --- a/target/riscv/insn_trans/trans_rvm.inc.c
> +++ b/target/riscv/insn_trans/trans_rvm.inc.c
> @@ -21,7 +21,7 @@
>   
>   static bool trans_mul(DisasContext *ctx, arg_mul *a)
>   {
> -    return trans_arith(ctx, a, &tcg_gen_mul_tl);
> +    return gen_arith(ctx, a, &tcg_gen_mul_tl);
>   }
>   
>   static bool trans_mulh(DisasContext *ctx, arg_mulh *a)
> @@ -41,7 +41,7 @@ static bool trans_mulh(DisasContext *ctx, arg_mulh *a)
>   
>   static bool trans_mulhsu(DisasContext *ctx, arg_mulhsu *a)
>   {
> -    return trans_arith(ctx, a, &gen_mulhsu);
> +    return gen_arith(ctx, a, &gen_mulhsu);
>   }
>   
>   static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a)
> @@ -61,28 +61,28 @@ static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a)
>   
>   static bool trans_div(DisasContext *ctx, arg_div *a)
>   {
> -    return trans_arith(ctx, a, &gen_div);
> +    return gen_arith(ctx, a, &gen_div);
>   }
>   
>   static bool trans_divu(DisasContext *ctx, arg_divu *a)
>   {
> -    return trans_arith(ctx, a, &gen_divu);
> +    return gen_arith(ctx, a, &gen_divu);
>   }
>   
>   static bool trans_rem(DisasContext *ctx, arg_rem *a)
>   {
> -    return trans_arith(ctx, a, &gen_rem);
> +    return gen_arith(ctx, a, &gen_rem);
>   }
>   
>   static bool trans_remu(DisasContext *ctx, arg_remu *a)
>   {
> -    return trans_arith(ctx, a, &gen_remu);
> +    return gen_arith(ctx, a, &gen_remu);
>   }
>   
>   #ifdef TARGET_RISCV64
>   static bool trans_mulw(DisasContext *ctx, arg_mulw *a)
>   {
> -    return trans_arith(ctx, a, &gen_mulw);
> +    return gen_arith(ctx, a, &gen_mulw);
>   }
>   
>   static bool trans_divw(DisasContext *ctx, arg_divw *a)
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 6a722a0045..d0b0fca12b 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -577,8 +577,8 @@ static bool gen_arith_div_w(DisasContext *ctx, arg_r *a,
>   
>   #endif
>   
> -static bool trans_arith(DisasContext *ctx, arg_r *a,
> -                        void(*func)(TCGv, TCGv, TCGv))
> +static bool gen_arith(DisasContext *ctx, arg_r *a,
> +                      void(*func)(TCGv, TCGv, TCGv))
>   {
>       TCGv source1, source2;
>       source1 = tcg_temp_new();
> 
