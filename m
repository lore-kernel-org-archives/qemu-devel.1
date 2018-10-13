Received: from eggs.gnu.org ([2001:4830:134:3::10]:54978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ9R-0002oA-4v
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ9O-00048N-GA
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:04:41 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBQ9O-00047n-9B
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:04:38 -0400
Received: by mail-pl1-x641.google.com with SMTP id u6-v6so4701319plz.4
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 13:04:38 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-29-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <15f31557-ec50-cb64-ef67-7d9f9f3745e8@linaro.org>
Date: Sat, 13 Oct 2018 13:04:33 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-29-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 28/28] target/riscv: Replace
 gen_exception_illegal with return false
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
> return false in trans_* instructions is no longer used as a fallback to
> the old decoder. We can therefore now use 'return false' to indicate an illegal
> instruction.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
>  .../riscv/insn_trans/trans_privileged.inc.c   |  6 ++----
>  target/riscv/insn_trans/trans_rvc.inc.c       | 21 +++++++------------
>  target/riscv/insn_trans/trans_rvd.inc.c       | 14 ++++++-------
>  target/riscv/insn_trans/trans_rvf.inc.c       | 10 ++++-----
>  target/riscv/insn_trans/trans_rvi.inc.c       | 18 ++++++----------
>  target/riscv/translate.c                      |  1 +
>  6 files changed, 28 insertions(+), 42 deletions(-)

I don't see the need to make this distinction in the early patches.
I think this should be folded back to the previous patches.


r~
