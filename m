Received: from eggs.gnu.org ([2001:4830:134:3::10]:53313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB21T-0004Tu-Dx
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB21Q-00037y-0p
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:18:51 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:45538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gB21P-00037T-FH
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:18:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id y15-v6so6293799plr.12
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 11:18:47 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-3-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <69bf432c-0fdc-15de-f382-760f73013947@linaro.org>
Date: Fri, 12 Oct 2018 11:18:42 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-3-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/28] target/riscv: Convert RVXI branch
 insns to decodetree
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
> +static bool trans_jal(DisasContext *ctx, arg_jal *a, uint32_t insn)
> +{
> +    CPURISCVState *env = current_cpu->env_ptr;
> +    gen_jal(env, ctx, a->rd, a->imm);

I think you should go ahead and put env into ctx, which is probably where it
should have been in the first place for gen_jal et al to examine features.

Reading from current_cpu is definitely suspect.


r~
