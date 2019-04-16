Received: from eggs.gnu.org ([209.51.188.92]:48374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hGMo4-0000Ws-4H
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hGMny-0000pf-S7
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:03:17 -0400
References: <20190401031155.21293-1-richard.henderson@linaro.org>
	<20190401031155.21293-4-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <c6b66db9-24d5-b55b-8b45-e73f3d7c3fba@mail.uni-paderborn.de>
Date: Tue, 16 Apr 2019 14:02:36 +0200
MIME-Version: 1.0
In-Reply-To: <20190401031155.21293-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/8] target/riscv: Merge argument
 sets for insn32 and insn16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: palmer@sifive.com, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org


On 4/1/19 5:11 AM, Richard Henderson wrote:
>   
>   # *** RV64C Standard Extension (Quadrant 0) ***
>   c_addi4spn        000    ........ ... 00 @ciw
> -c_fld             001  ... ... .. ... 00 @cl_d
> -c_lw              010  ... ... .. ... 00 @cl_w
> +fld               001  ... ... .. ... 00 @cl_d
> +lw                010  ... ... .. ... 00 @cl_w

This leads to a redefinition of arg_lw and arg_fld for which clang emits 
a warning as found by Peter as he wanted to merge the original pull 
request for RISC-V-dt. The same goes for all other merged args.

Cheers,

Bastian
