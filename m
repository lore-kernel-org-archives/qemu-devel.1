Received: from eggs.gnu.org ([2001:4830:134:3::10]:41063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHz9Z-0001Ed-BW
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHz9V-0004LU-8h
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:39:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHz9U-0004L7-UH
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:39:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id h2-v6so12776013wmb.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:39:52 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-28-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f6e90c2c-739f-a02c-c280-002f224eb089@linaro.org>
Date: Wed, 31 Oct 2018 22:39:49 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-28-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 27/35] target/riscv: Remove manual
 decoding of RV32/64M insn
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
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
> v2 -> v3:
>     - trans_mulw now uses gen_mulw which properly sign extends the result
>     - gen_arith_w -> gen_arith_div_w
>     - gen_arith_div_w properly sign extends the resul

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
