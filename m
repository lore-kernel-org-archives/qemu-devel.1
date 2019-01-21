Received: from eggs.gnu.org ([209.51.188.92]:47230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1glitc-0004n2-Ne
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 18:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1glita-00034s-CE
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 18:22:24 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1glitZ-00033j-Sg
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 18:22:22 -0500
Received: by mail-pf1-x444.google.com with SMTP id i12so10780691pfo.7
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 15:22:19 -0800 (PST)
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-27-kbastian@mail.uni-paderborn.de>
	<235a7ee4-8f5e-1b2a-09fd-e4809c674065@linaro.org>
	<5ad14b08-7db1-279a-a702-9ce2e981397e@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3da52a06-911a-5459-021c-526b23d9a928@linaro.org>
Date: Mon, 21 Jan 2019 15:22:14 -0800
MIME-Version: 1.0
In-Reply-To: <5ad14b08-7db1-279a-a702-9ce2e981397e@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 26/35] target/riscv: Remove shift and
 slt insn manual decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 1/21/19 1:10 AM, Bastian Koppelmann wrote:
> 
> On 1/20/19 2:43 AM, Richard Henderson wrote:
>> On 1/19/19 12:14 AM, Bastian Koppelmann wrote:
>>> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>>> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
>>> ---
>>> v3 -> v4:
>>>      - refactor tcg_gen_set_cond_tl(TCG_COND_LT,..) into gen_slt function
>>>        and reuse gen_arith(..., &gen_slt) for all trans_slt functions.
>>>      - Add missing sign extension to trans_srlw/sllw
>>>      - Made rs2 == 0 a special case of srlw/sllw
>> Why?  It's not like it is a likely case, and it works without.
> 
> 
> Because you suggested it :) (see https://patchwork.kernel.org/patch/10662699/).
> Maybe I misunderstood your comment. If you like I can remove it in the respin.

I meant the register indicated by rs2 containing the value 0,
which you have fixed with the extension.


r~
