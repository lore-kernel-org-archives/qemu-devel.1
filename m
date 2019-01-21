Received: from eggs.gnu.org ([209.51.188.92]:51933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glVbR-0002rt-4M
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glVbQ-0008Al-A4
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:10:45 -0500
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-27-kbastian@mail.uni-paderborn.de>
	<235a7ee4-8f5e-1b2a-09fd-e4809c674065@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <5ad14b08-7db1-279a-a702-9ce2e981397e@mail.uni-paderborn.de>
Date: Mon, 21 Jan 2019 10:10:19 +0100
MIME-Version: 1.0
In-Reply-To: <235a7ee4-8f5e-1b2a-09fd-e4809c674065@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
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
To: Richard Henderson <richard.henderson@linaro.org>, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org


On 1/20/19 2:43 AM, Richard Henderson wrote:
> On 1/19/19 12:14 AM, Bastian Koppelmann wrote:
>> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
>> ---
>> v3 -> v4:
>>      - refactor tcg_gen_set_cond_tl(TCG_COND_LT,..) into gen_slt function
>>        and reuse gen_arith(..., &gen_slt) for all trans_slt functions.
>>      - Add missing sign extension to trans_srlw/sllw
>>      - Made rs2 == 0 a special case of srlw/sllw
> Why?  It's not like it is a likely case, and it works without.


Because you suggested it :) (see 
https://patchwork.kernel.org/patch/10662699/). Maybe I misunderstood 
your comment. If you like I can remove it in the respin.


Cheers,

Bastian
