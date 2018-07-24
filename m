Received: from eggs.gnu.org ([2001:4830:134:3::10]:53435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi38t-0005NK-Pd
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi38s-0001WK-Ud
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:38:43 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fi38s-0001Vv-Mv
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:38:42 -0400
Received: by mail-pf1-x442.google.com with SMTP id y10-v6so1084942pfn.8
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 12:38:42 -0700 (PDT)
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532453527-22911-11-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <21db73e2-943a-45d6-d7b1-5e16ea3252c9@linaro.org>
Date: Tue, 24 Jul 2018 12:38:38 -0700
MIME-Version: 1.0
In-Reply-To: <1532453527-22911-11-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 10/55] target/mips: Add emulation of
 some common nanoMIPS 32-bit instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/24/2018 10:31 AM, Aleksandar Markovic wrote:
> +    case NM_ADDIUPC:
> +        if (rt != 0) {
> +            int32_t offset = sextract32(ctx->opcode, 0, 1) << 21
> +                            | extract32(ctx->opcode, 1, 20) << 1;
> +            target_long addr = addr_add(ctx, ctx->base.pc_next + 4, offset);
> +            tcg_gen_movi_tl(cpu_gpr[rt], addr);
> +            tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +        }

I really need you to address all of the comments from a round of review before
posting the next round.

I'm going to stop now, let you address all of the v3 review and then post a v5.


r~
