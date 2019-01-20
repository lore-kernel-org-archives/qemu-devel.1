Received: from eggs.gnu.org ([209.51.188.92]:47294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gl28w-0003A8-BW
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 20:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gl28u-0001qa-2S
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 20:43:22 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gl28q-0001od-SU
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 20:43:18 -0500
Received: by mail-pg1-x541.google.com with SMTP id d72so7841885pga.9
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 17:43:15 -0800 (PST)
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-27-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <235a7ee4-8f5e-1b2a-09fd-e4809c674065@linaro.org>
Date: Sun, 20 Jan 2019 12:43:07 +1100
MIME-Version: 1.0
In-Reply-To: <20190118131456.32451-27-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org

On 1/19/19 12:14 AM, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
> v3 -> v4:
>     - refactor tcg_gen_set_cond_tl(TCG_COND_LT,..) into gen_slt function
>       and reuse gen_arith(..., &gen_slt) for all trans_slt functions.
>     - Add missing sign extension to trans_srlw/sllw
>     - Made rs2 == 0 a special case of srlw/sllw

Why?  It's not like it is a likely case, and it works without.

That said,

> 
>  target/riscv/insn_trans/trans_rvi.inc.c | 98 +++++++++++++++++--------
>  target/riscv/translate.c                | 59 +++++----------
>  2 files changed, 86 insertions(+), 71 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
