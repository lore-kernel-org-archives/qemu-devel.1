Received: from eggs.gnu.org ([2001:4830:134:3::10]:54147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ6V-0001Ci-Jv
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ6S-0002jD-Rh
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:01:39 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:42591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBQ6S-0002f9-4k
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:01:36 -0400
Received: by mail-pl1-x632.google.com with SMTP id c8-v6so7428869plo.9
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 13:01:29 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-28-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <93b09a1a-a3bf-81ab-d226-0fad44e7f242@linaro.org>
Date: Sat, 13 Oct 2018 13:01:25 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-28-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 27/28] target/riscv: Remove
 decode_RV32_64G()
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
>          if (!decode_insn32(ctx, ctx->opcode)) {
> -            /* fallback to old decoder */
> -            decode_RV32_64G(env, ctx);
>          }

Still need gen_exception_illegal.


r~
