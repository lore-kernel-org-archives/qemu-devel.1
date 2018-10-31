Received: from eggs.gnu.org ([2001:4830:134:3::10]:35154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHu4N-0000ij-1u
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHu4K-0005yt-Di
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:14:15 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHu4J-0005yI-UV
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:14:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id v24-v6so6063360wmh.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 10:14:11 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-6-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f8f8a627-80eb-5516-d4b7-01672ef7b635@linaro.org>
Date: Wed, 31 Oct 2018 17:14:08 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-6-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/35] target/riscv: Convert RV64I
 load/store insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On 10/31/18 1:19 PM, Bastian Koppelmann wrote:
> this splits the 64-bit only instructions into its own decode file such
> that we generate the decoder for these instructions only for the RISC-V
> 64 bit target.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
>  target/riscv/Makefile.objs              |  8 +++++---
>  target/riscv/insn64.decode              | 25 +++++++++++++++++++++++++
>  target/riscv/insn_trans/trans_rvi.inc.c | 20 ++++++++++++++++++++
>  target/riscv/translate.c                |  7 -------
>  4 files changed, 50 insertions(+), 10 deletions(-)
>  create mode 100644 target/riscv/insn64.decode

I did suggest using insn32-64.decode, so that insn64.decode is available for an
actual 64-bit instruction word, which is mentioned in the "Extensions" section
of the ISA manual.

However,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
