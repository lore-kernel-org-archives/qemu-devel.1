Received: from eggs.gnu.org ([209.51.188.92]:57286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm3it-0006EJ-Ig
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm3is-0003ML-M3
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:36:43 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gm3is-00036q-4M
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:36:42 -0500
Received: by mail-pg1-x542.google.com with SMTP id m1so9447pgq.8
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 13:36:27 -0800 (PST)
References: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
	<20190122092909.5341-25-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5ee17273-237a-8581-fe22-30aa667e770c@linaro.org>
Date: Tue, 22 Jan 2019 13:36:20 -0800
MIME-Version: 1.0
In-Reply-To: <20190122092909.5341-25-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 24/35] target/riscv: Move
 gen_arith_imm() decoding into trans_* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 1/22/19 1:28 AM, Bastian Koppelmann wrote:
> gen_arith_imm() does a lot of decoding manually, which was hard to read
> in case of the shift instructions and is not necessary anymore with
> decodetree.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +    if (a->shamt >= TARGET_LONG_BITS) {
> +            return false;
> +    }

Watch the funky indentation.

> +    if (a->rd != 0) {
> +        TCGv t = tcg_temp_new();
> +        gen_get_gpr(t, a->rs1);
> +
> +           tcg_gen_sari_tl(t, t, a->shamt);
> +        gen_set_gpr(a->rd, t);

Likewise.


r~
