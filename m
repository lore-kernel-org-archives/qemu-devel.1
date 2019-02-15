Received: from eggs.gnu.org ([209.51.188.92]:57732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gucJb-0002uz-9n
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gucJa-0003Lu-9R
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:09:59 -0500
References: <20190213155414.22285-1-palmer@sifive.com>
	<20190213155414.22285-11-palmer@sifive.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <db2cbfcb-1087-eacb-9354-da5d78c55e8d@mail.uni-paderborn.de>
Date: Fri, 15 Feb 2019 13:09:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190213155414.22285-11-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v7 10/35] target/riscv: Convert RV32A insns
 to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
Cc: Peer Adelt <peer.adelt@hni.uni-paderborn.de>, qemu-devel@nongnu.org


On 2/13/19 4:53 PM, Palmer Dabbelt wrote:
> From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
>   target/riscv/insn32.decode              |  17 +++
>   target/riscv/insn_trans/trans_rva.inc.c | 149 ++++++++++++++++++++++++
>   target/riscv/translate.c                |   1 +
>   3 files changed, 167 insertions(+)
>   create mode 100644 target/riscv/insn_trans/trans_rva.inc.c
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index e53944bf0e40..00b9e2d9a508 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode


All translate_foo() functions are missing 'if (!has_ext(ctx, RVA)) 
return false'

Cheers,

Bastian
