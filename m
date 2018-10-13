Received: from eggs.gnu.org ([2001:4830:134:3::10]:53183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBNv0-0005II-QM
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBNux-0004Tn-Ji
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:41:38 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:43965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBNux-0004TF-98
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:41:35 -0400
Received: by mail-pg1-x52d.google.com with SMTP id 80-v6so7255528pgh.10
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 10:41:32 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-11-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2425df57-ecb1-d6d9-9b91-032bd8fd4eaf@linaro.org>
Date: Sat, 13 Oct 2018 10:41:29 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-11-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/28] target/riscv: Convert RV32F insns to
 decodetree
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
> +static bool trans_fmadd_s(DisasContext *ctx, arg_fmadd_s *a, uint32_t insn)
> +{
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
> +                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
> +    return true;
> +}

Missing REQUIRE_FPU at the beginning of all of the arithmetic helpers.


r~
