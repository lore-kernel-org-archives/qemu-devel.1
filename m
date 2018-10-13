Received: from eggs.gnu.org ([2001:4830:134:3::10]:53832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ5K-0000RG-Ln
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ5H-0002FB-FK
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:00:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:44595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBQ5G-0002EO-SM
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:00:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id p25-v6so7426727pli.11
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 13:00:22 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-26-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cab3a644-43e2-fc8d-8e1d-ff20aedaa891@linaro.org>
Date: Sat, 13 Oct 2018 13:00:18 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-26-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 25/28] target/riscv: Remove manual decoding
 of RV32/64M insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
>  static bool trans_mulw(DisasContext *ctx, arg_mulw *a, uint32_t insn)
>  {
> -    gen_arith(ctx, OPC_RISC_MULW, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith(ctx, a, &tcg_gen_mul_tl);
>  }
>  static bool trans_divw(DisasContext *ctx, arg_divw *a, uint32_t insn)
>  {
> -    gen_arith(ctx, OPC_RISC_DIVW, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith_w(ctx, a, &gen_div);
>  }
>  static bool trans_divuw(DisasContext *ctx, arg_divuw *a, uint32_t insn)
>  {
> -    gen_arith(ctx, OPC_RISC_DIVUW, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith_w(ctx, a, &gen_divu);
>  }
>  static bool trans_remw(DisasContext *ctx, arg_remw *a, uint32_t insn)
>  {
> -    gen_arith(ctx, OPC_RISC_REMW, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith_w(ctx, a, &gen_rem);
>  }
>  static bool trans_remuw(DisasContext *ctx, arg_remuw *a, uint32_t insn)
>  {
> -    gen_arith(ctx, OPC_RISC_REMUW, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith_w(ctx, a, &gen_remu);
>  }

Missing TARGET_RISCV64 checks.


r~
