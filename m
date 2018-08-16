Received: from eggs.gnu.org ([2001:4830:134:3::10]:60235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLKU-0007W4-Ce
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLKK-0007xp-Oq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:40:54 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqLKJ-0007xI-Jy
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:40:48 -0400
Received: by mail-pg1-x544.google.com with SMTP id f14-v6so2296823pgv.13
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:40:47 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-43-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c2070917-1151-f72f-4c21-d95674a161fc@linaro.org>
Date: Thu, 16 Aug 2018 09:40:43 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-43-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 42/84] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> +    case NM_REPL_PH:
> +        check_dsp(ctx);
> +        {
> +            int16_t imm;
> +            imm = extract32(ctx->opcode, 11, 11);
> +            imm = (int16_t)(imm << 6) >> 6;

sextract32 instead.

> +            if (rt != 0) {
> +                tcg_gen_movi_tl(cpu_gpr[rt], \
> +                                (target_long)((int32_t)imm << 16 | \
> +                                (uint16_t)imm));

dup_const(MO_16, imm).

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
