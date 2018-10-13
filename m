Received: from eggs.gnu.org ([2001:4830:134:3::10]:50810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPpm-0004Do-0d
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPpi-00011T-EE
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:44:21 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:39221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBPph-00010k-D5
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:44:18 -0400
Received: by mail-pf1-x431.google.com with SMTP id c25-v6so7779015pfe.6
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 12:44:17 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-21-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <79fbf03c-da2e-52f2-e653-15be519d1194@linaro.org>
Date: Sat, 13 Oct 2018 12:44:13 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-21-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/28] target/riscv: Replace gen_load()
 with trans_load()
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
> +static bool trans_load(DisasContext *ctx, arg_lb *a, int memop)

Again, gen_load.

>  {
> -    gen_load(ctx, OPC_RISC_LB, a->rd, a->rs1, a->imm);
> +    TCGv t0 = tcg_temp_new();
> +    TCGv t1 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +    tcg_gen_addi_tl(t0, t0, a->imm);
> +
> +    if (memop < 0) {
> +        return false;
> +    }

This can't happen anymore.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
