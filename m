Received: from eggs.gnu.org ([2001:4830:134:3::10]:43731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBN8v-0005yd-17
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBN8u-0004mX-9x
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:51:56 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBN8u-0004lY-0q
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:51:56 -0400
Received: by mail-pf1-x443.google.com with SMTP id m77-v6so7673681pfi.8
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 09:51:55 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-10-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4099048c-c805-acf2-7cc3-1c66fd7de7be@linaro.org>
Date: Sat, 13 Oct 2018 09:51:51 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-10-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/28] target/riscv: Convert RV64A insns to
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
>  target/riscv/insn32.decode              |  13 +++
>  target/riscv/insn_trans/trans_rva.inc.c |  99 +++++++++++++++++
>  target/riscv/translate.c                | 140 ------------------------
>  3 files changed, 112 insertions(+), 140 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
