Received: from eggs.gnu.org ([2001:4830:134:3::10]:32929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHyfs-0000hd-B4
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHyfp-0005Hc-3p
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:09:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHyfo-0005HC-JF
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:09:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id i17-v6so18099402wre.7
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:09:12 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-23-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d4e842f-81b8-0eea-9e5a-f42d973d7d2b@linaro.org>
Date: Wed, 31 Oct 2018 22:09:09 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-23-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 22/35] target/riscv: Remove manual
 decoding from gen_load()
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

On 10/31/18 1:20 PM, Bastian Koppelmann wrote:
> With decodetree we don't need to convert RISC-V opcodes into to MemOps
> as the old gen_load() did.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de><Paste>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static bool gen_load(DisasContext *ctx, arg_lb *a, int memop)

Better with TCGMemOp instead of int.


r~
