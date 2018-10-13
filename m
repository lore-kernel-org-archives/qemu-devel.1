Received: from eggs.gnu.org ([2001:4830:134:3::10]:50159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPlf-00031F-A4
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPlb-00076P-Q2
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:40:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:33983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBPlb-00075U-CK
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:40:03 -0400
Received: by mail-pf1-x42b.google.com with SMTP id f78-v6so2011840pfe.1
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 12:40:03 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-20-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b3a18b03-7ff9-eb2c-a86a-d8c2b3d94a18@linaro.org>
Date: Sat, 13 Oct 2018 12:39:58 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-20-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/28] target/riscv: Replace gen_branch()
 with trans_branch()
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
> +static bool trans_branch(DisasContext *ctx, arg_branch *a, TCGCond cond)

I think you should still call it gen_branch.
Reserve the trans_ prefix for things called from the decoder.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
