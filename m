Received: from eggs.gnu.org ([2001:4830:134:3::10]:34094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHu1a-000576-Ua
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHu1X-0003vU-Mh
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:11:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHu1X-0003rv-BU
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:11:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id x12-v6so17340686wrw.8
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 10:11:17 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ff860811-e5f6-54ea-d351-11e49b60f541@linaro.org>
Date: Wed, 31 Oct 2018 17:11:14 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/35] target/riscv: Convert RVXI branch
 insns to decodetree
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

On 10/31/18 1:19 PM, Bastian Koppelmann wrote:
> +static bool trans_jal(DisasContext *ctx, arg_jal *a, uint32_t insn)
> +{
> +    gen_jal(ctx->env, ctx, a->rd, a->imm);
> +    return true;
> +}

This patch didn't get updated properly.  It looks like the removal of the insn
parameter got squashed into patch 4 instead.


r~
