Received: from eggs.gnu.org ([2001:4830:134:3::10]:35036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEs6I-0002w8-MY
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEs6F-0001Of-CM
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:31:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEs6F-0001H0-2S
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:31:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id s18-v6so655924wrw.6
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 01:31:29 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-17-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2180857a-281a-0298-7486-9067f8ed5905@linaro.org>
Date: Tue, 23 Oct 2018 09:31:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-17-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/29] target/riscv: Convert quadrant 0
 of RVXC insns to decodetree
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
> v1 -> v2:
>     - Stack allocate arg_c_* structs
>     - ex_rvc_register returns int
>     - special case of trans_c_addi4spn() returns false
...
> +static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a,
> +        uint16_t insn)
> +{
> +    if (a->nzuimm == 0) {
> +        /* Reserved in ISA */
> +        gen_exception_illegal(ctx);
> +        return true;
> +    }

That doesn't seem to have actually happened.

But otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
