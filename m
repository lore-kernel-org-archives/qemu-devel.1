Received: from eggs.gnu.org ([2001:4830:134:3::10]:52570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBNrH-0004Uz-Ev
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBNrE-00032N-6j
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:37:47 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:39766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBNrD-00031m-Va
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:37:44 -0400
Received: by mail-pg1-x52f.google.com with SMTP id r9-v6so7267627pgv.6
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 10:37:43 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-12-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fad24bca-6421-11ee-1e5f-7279380691fb@linaro.org>
Date: Sat, 13 Oct 2018 10:37:39 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-12-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/28] target/riscv: Convert RV64F insns to
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
> +static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a, uint32_t insn)
> +{
> +#if defined(TARGET_RISCV64)
> +    REQUIRE_FPU;
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[a->rs1]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +#else
> +    gen_exception_illegal(ctx);
> +#endif
> +
> +    return true;
> +}
> +

Inconsistency among the patches with respect to return false or raising the
exception directly.  You should probably standardize on one method.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
