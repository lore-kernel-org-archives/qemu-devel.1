Received: from eggs.gnu.org ([2001:4830:134:3::10]:47675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHnzV-0006KI-LR
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHnzR-0004Ni-3V
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:44:49 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:43180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gHnzQ-0004BR-OV
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:44:44 -0400
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-14-kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <53959ab8-6039-2c43-ccb0-8aafba74820c@mail.uni-paderborn.de>
Date: Wed, 31 Oct 2018 11:44:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-14-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v2 13/29] target/riscv: Convert RV32D insns
 to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org


On 10/20/18 9:14 AM, Bastian Koppelmann wrote:
[...]
> +static bool trans_fclass_d(DisasContext *ctx, arg_fclass_d *a, uint32_t insn)
> +{
> +#if defined(TARGET_RISCV64)
> +    REQUIRE_FPU;
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_helper_fclass_d(t0, cpu_fpr[a->rs1]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +#else
> +    gen_exception_illegal(ctx);
> +#endif
> +    return true;
> +}


I'm a bit confused here. According to the spec fclass_d is a RV32F 
instruction but according to the original qemu code it is not?

Cheers,

Bastian
