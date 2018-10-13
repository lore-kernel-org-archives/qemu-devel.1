Received: from eggs.gnu.org ([2001:4830:134:3::10]:52038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBNnS-0003W4-9o
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBNnO-0001WI-Aq
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:33:50 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:43431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBNnN-0001VU-SD
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:33:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id p24-v6so7691339pff.10
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 10:33:45 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-11-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <128e8207-faeb-68b1-0cba-a71392a216c1@linaro.org>
Date: Sat, 13 Oct 2018 10:33:40 -0700
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
> +#define REQUIRE_FPU \
> +if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) \
> +    gen_exception_illegal(ctx)

Should wrap this in do { } while (0).  And simply return true after the
exception; no need to generate the dead code that follows.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
