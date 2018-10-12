Received: from eggs.gnu.org ([2001:4830:134:3::10]:49539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB1mw-0000Gg-BE
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB1ms-00026O-7r
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:03:50 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gB1mq-00024x-K1
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:03:46 -0400
Received: by mail-pl1-x643.google.com with SMTP id p25-v6so6273036pli.11
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 11:03:43 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-2-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <efdacea0-e1d0-ca5a-505f-8497bacb3cf1@linaro.org>
Date: Fri, 12 Oct 2018 11:03:39 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-2-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/28] targer/riscv: Activate decodetree
 and implemnt LUI & AUIPC
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
> +#define EX_SH(amount) \
> +    static int64_t ex_shift_##amount(int imm) \
> +    {                                         \
> +        return imm << amount;                 \
> +    }

The int64_t return doesn't help, because it'll be stored back into a struct
that uses just "int".  If you have a shift that goes outside that, you'd have
to handle it in the trans_* function.  Which is not the case here, at least.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
