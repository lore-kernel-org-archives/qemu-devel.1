Received: from eggs.gnu.org ([2001:4830:134:3::10]:37313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHywp-0000Qn-Nh
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHywk-0005iE-3C
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:26:47 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHywj-0005g4-At
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:26:41 -0400
Received: by mail-wr1-x42d.google.com with SMTP id g9-v6so18176268wrq.4
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:26:31 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-25-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e92bb9c-443e-7801-7165-1b19126ce578@linaro.org>
Date: Wed, 31 Oct 2018 22:26:28 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-25-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 24/35] target/riscv: Move
 gen_arith_imm() decoding into trans_* functions
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
> +
> +#ifdef TARGET_RISCV64
> +static void gen_addiw(TCGv ret, TCGv arg1, TCGv arg2)
> +{
> +    tcg_gen_add_tl(ret, arg1, arg2);
> +    tcg_gen_ext32s_tl(ret, ret);
> +}
> +#endif

This should have been called gen_addw.  It takes no immediate.


r~
