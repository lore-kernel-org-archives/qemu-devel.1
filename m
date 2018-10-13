Received: from eggs.gnu.org ([2001:4830:134:3::10]:53310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBNvw-0005lu-Ez
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBNvt-0004m1-82
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:42:36 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:43981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBNvo-0004ig-38
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:42:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id 30-v6so7348773plb.10
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 10:42:22 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-13-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d497d2ab-6cfe-805e-fcce-b244ac9f7807@linaro.org>
Date: Sat, 13 Oct 2018 10:42:19 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-13-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/28] target/riscv: Convert RV32D insns to
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
> +static bool trans_fmadd_d(DisasContext *ctx, arg_fmadd_d *a, uint32_t insn)
> +{
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fmadd_d(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
> +                       cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
> +    return true;
> +}

Missing REQUIRE_FPU in all of the arith helpers.


r~
