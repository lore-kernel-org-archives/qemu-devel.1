Received: from eggs.gnu.org ([209.51.188.92]:34808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gky37-0001Wz-GQ
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gky34-0001FT-Co
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:21:05 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:39362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gky33-0001AR-DP
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:21:02 -0500
Received: by mail-pl1-x634.google.com with SMTP id 101so7908869pld.6
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 13:21:01 -0800 (PST)
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-5-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2e06d480-63dd-e307-db67-9e6e086290fb@linaro.org>
Date: Sun, 20 Jan 2019 08:20:52 +1100
MIME-Version: 1.0
In-Reply-To: <20190118131456.32451-5-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 04/35] target/riscv: Convert RV32I
 load/store insns to decodetree
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
>     - removed accidental argument removal
> 
>  target/riscv/insn32.decode              | 10 ++++++
>  target/riscv/insn_trans/trans_rvi.inc.c | 48 +++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
