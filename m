Received: from eggs.gnu.org ([2001:4830:134:3::10]:37309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHywp-0000Qk-ML
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHywk-0005i6-2k
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:26:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHywj-0005hF-Au
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:26:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id a8-v6so15874948wmf.1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:26:40 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-26-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75754b54-6527-7cdb-b387-5917e00ad086@linaro.org>
Date: Wed, 31 Oct 2018 22:26:37 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-26-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 25/35] target/riscv: make
 ADD/SUB/OR/XOR/AND insn use arg lists
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
>  static bool trans_addw(DisasContext *ctx, arg_addw *a)
>  {
> -    gen_arith(ctx, OPC_RISC_ADDW, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith(ctx, a, &tcg_gen_add_tl);
>  }

This should be using gen_addw.


r~
