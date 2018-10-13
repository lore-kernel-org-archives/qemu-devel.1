Received: from eggs.gnu.org ([2001:4830:134:3::10]:52609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ12-00072R-QC
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBQ10-0007Th-35
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:56:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:46794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBQ0z-0007TO-Sl
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:55:58 -0400
Received: by mail-pl1-x633.google.com with SMTP id v5-v6so7422587plz.13
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 12:55:57 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-24-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <483346e6-d32d-f428-b911-c35946f74496@linaro.org>
Date: Sat, 13 Oct 2018 12:55:53 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-24-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/28] target/riscv: make
 ADD/SUB/OR/XOR/AND insn use arg lists
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
> +static bool trans_arith(DisasContext *ctx, arg_arith *a,
> +                        void(*func)(TCGv, TCGv, TCGv))

gen_arith.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
