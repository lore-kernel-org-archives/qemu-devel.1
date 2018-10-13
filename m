Received: from eggs.gnu.org ([2001:4830:134:3::10]:49852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPir-0002AM-WA
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPin-0003D1-Un
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:37:13 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:38865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBPin-00035C-N5
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:37:09 -0400
Received: by mail-pg1-x52b.google.com with SMTP id f8-v6so7330436pgq.5
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 12:37:09 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-19-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df07d370-bd49-ac33-98ad-19e9f6827ae0@linaro.org>
Date: Sat, 13 Oct 2018 12:37:05 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-19-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/28] target/riscv: Remove gen_jalr()
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
> trans_jalr() is the only caller, so move the code into
> trans_jalr().
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
>  target/riscv/insn_trans/trans_rvi.inc.c | 27 +++++++++++++++++-
>  target/riscv/translate.c                | 38 -------------------------
>  2 files changed, 26 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
