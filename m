Received: from eggs.gnu.org ([209.51.188.92]:58471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gucNQ-0004a8-N2
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gucNQ-0007NM-6C
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:13:56 -0500
References: <20190213155414.22285-1-palmer@sifive.com>
	<20190213155414.22285-17-palmer@sifive.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <64f366dc-b2f1-020e-30e2-8a657398d369@mail.uni-paderborn.de>
Date: Fri, 15 Feb 2019 13:13:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190213155414.22285-17-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v7 16/35] target/riscv: Convert RV priv
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
Cc: Peer Adelt <peer.adelt@hni.uni-paderborn.de>, qemu-devel@nongnu.org


On 2/13/19 4:53 PM, Palmer Dabbelt wrote:
> +}
> +
> +static bool trans_sret(DisasContext *ctx, arg_sret *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
> +
> +    if (riscv_has_ext(ctx->env, RVS)) {


This should use has_ext()

Cheers,

Bastian
