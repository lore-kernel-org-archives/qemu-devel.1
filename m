Received: from eggs.gnu.org ([2001:4830:134:3::10]:50690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsRV-0003WF-WB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsRQ-00083z-QZ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:53:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:34341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEsRQ-00080z-3F
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:53:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id z25-v6so11079751wmf.1
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 01:53:31 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-25-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <31e0a3d9-7a9b-fc13-375d-cc81e7090a63@linaro.org>
Date: Tue, 23 Oct 2018 09:53:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-25-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 24/29] target/riscv: make
 ADD/SUB/OR/XOR/AND insn use arg lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/20/18 8:14 AM, Bastian Koppelmann wrote:
> +static bool trans_arith(DisasContext *ctx, arg_arith *a,
> +                        void(*func)(TCGv, TCGv, TCGv))

gen_arith.


r~
