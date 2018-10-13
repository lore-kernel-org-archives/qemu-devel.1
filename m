Received: from eggs.gnu.org ([2001:4830:134:3::10]:50941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPqd-0004et-Nn
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPqa-0001Sa-DO
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:45:15 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:39216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBPqa-0001S9-5l
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:45:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id c25-v6so7779509pfe.6
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 12:45:12 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-22-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <af15eae9-c2a6-68dd-3570-0e41edd8bf1f@linaro.org>
Date: Sat, 13 Oct 2018 12:45:08 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-22-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/28] target/riscv: Replace gen_store()
 with trans_store()
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
> +static bool trans_store(DisasContext *ctx, arg_sb *a, int memop)

gen_store.

>  {
> -    gen_store(ctx, OPC_RISC_SB, a->rs1, a->rs2, a->imm);
> +    TCGv t0 = tcg_temp_new();
> +    TCGv dat = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +    tcg_gen_addi_tl(t0, t0, a->imm);
> +    gen_get_gpr(dat, a->rs2);
> +
> +    if (memop < 0) {
> +        return false;
> +    }

Can't happen.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
