Received: from eggs.gnu.org ([2001:4830:134:3::10]:40674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBMu1-0001gQ-DV
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBMtx-0007GK-L5
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:36:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBMtu-0007Cv-6X
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:36:28 -0400
Received: by mail-pg1-x544.google.com with SMTP id t70-v6so7216961pgd.12
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 09:36:25 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-7-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <445f4443-abfb-dc55-ef97-63f5e2429f85@linaro.org>
Date: Sat, 13 Oct 2018 09:36:20 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-7-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/28] target/riscv: Convert RVXI csr insns
 to decodetree
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
>  target/riscv/insn32.decode              |  8 +++
>  target/riscv/insn_trans/trans_rvi.inc.c | 79 +++++++++++++++++++++++++
>  target/riscv/translate.c                | 43 +-------------
>  3 files changed, 88 insertions(+), 42 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
