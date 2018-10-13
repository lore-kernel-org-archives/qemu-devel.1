Received: from eggs.gnu.org ([2001:4830:134:3::10]:52895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ2T-0007li-Gg
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ2S-0008S0-KE
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:57:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:45531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBQ2S-0008R2-C1
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:57:28 -0400
Received: by mail-pl1-x630.google.com with SMTP id y15-v6so7428081plr.12
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 12:57:28 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-25-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8987c74a-3692-cfbc-1a81-87a055847575@linaro.org>
Date: Sat, 13 Oct 2018 12:57:24 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-25-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 24/28] target/riscv: Remove shift and slt
 insn manual decoding
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
> +static bool trans_shift(DisasContext *ctx, arg_arith *a,
> +                        void(*func)(TCGv, TCGv, TCGv))

gen_shift.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
