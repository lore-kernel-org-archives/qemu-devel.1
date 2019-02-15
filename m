Received: from eggs.gnu.org ([209.51.188.92]:58005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gucLB-0003km-5y
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gucL9-0004au-2t
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:11:37 -0500
References: <20190213155414.22285-1-palmer@sifive.com>
	<20190213155414.22285-13-palmer@sifive.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <04988556-ea52-3859-8d86-ef7c1b50be80@mail.uni-paderborn.de>
Date: Fri, 15 Feb 2019 13:11:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190213155414.22285-13-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v7 12/35] target/riscv: Convert RV32F insns
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
>   target/riscv/insn32.decode              |  35 +++
>   target/riscv/insn_trans/trans_rvf.inc.c | 353 ++++++++++++++++++++++++
>   target/riscv/translate.c                |   1 +
>   3 files changed, 389 insertions(+)
>   create mode 100644 target/riscv/insn_trans/trans_rvf.inc.c


All translate_foo() functions are missing 'if (!has_ext(ctx, RVF)' checks.

Cheers,

Bastian
