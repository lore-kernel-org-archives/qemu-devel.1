Received: from eggs.gnu.org ([2001:4830:134:3::10]:41182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBMwt-0002gQ-1j
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBMwm-0000Ry-Dr
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:39:28 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:40810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBMwi-0000Q9-3w
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:39:21 -0400
Received: by mail-pg1-x52a.google.com with SMTP id n31-v6so7228091pgm.7
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 09:39:19 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-8-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <14e1d4ee-0f15-5466-d537-9cd43b3bf097@linaro.org>
Date: Sat, 13 Oct 2018 09:39:15 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-8-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/28] target/riscv: Convert RVXM insns to
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
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
>  target/riscv/insn32.decode              | 17 +++++
>  target/riscv/insn_trans/trans_rvm.inc.c | 87 +++++++++++++++++++++++++
>  target/riscv/translate.c                | 10 +--
>  3 files changed, 105 insertions(+), 9 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvm.inc.c


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +}
> +static bool trans_mulh(DisasContext *ctx, arg_mulh *a, uint32_t insn)

Spacing.


r~
