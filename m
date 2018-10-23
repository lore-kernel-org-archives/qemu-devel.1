Received: from eggs.gnu.org ([2001:4830:134:3::10]:51444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsTV-0004Wo-Ao
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsTR-0001rH-VT
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:55:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEsTR-0001oW-J8
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:55:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id d2-v6so735328wro.7
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 01:55:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-25-kbastian@mail.uni-paderborn.de>
	<31e0a3d9-7a9b-fc13-375d-cc81e7090a63@linaro.org>
Message-ID: <d13be9a5-6b0c-55da-0bc9-94a03e3eb953@linaro.org>
Date: Tue, 23 Oct 2018 09:55:33 +0100
MIME-Version: 1.0
In-Reply-To: <31e0a3d9-7a9b-fc13-375d-cc81e7090a63@linaro.org>
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

On 10/23/18 9:53 AM, Richard Henderson wrote:
> On 10/20/18 8:14 AM, Bastian Koppelmann wrote:
>> +static bool trans_arith(DisasContext *ctx, arg_arith *a,
>> +                        void(*func)(TCGv, TCGv, TCGv))
> 
> gen_arith.

Oh, right, last patch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
