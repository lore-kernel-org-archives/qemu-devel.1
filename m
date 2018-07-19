Received: from eggs.gnu.org ([2001:4830:134:3::10]:55130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgEMR-00056X-IG
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgEMO-0003ws-4x
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:13:11 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgEMN-0003wf-S5
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:13:08 -0400
Received: by mail-pg1-x543.google.com with SMTP id v13-v6so4599756pgr.10
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:13:07 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-15-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c9a8b3f6-39da-94af-32f5-3af812f3d7d8@linaro.org>
Date: Thu, 19 Jul 2018 12:13:04 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-15-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 14/40] target/mips: Add emulation of
 misc nanoMIPS instructions (pool32axf)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> +static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
> +{
> +    int rt = (ctx->opcode >> 21) & 0x1f;
> +    int rs = (ctx->opcode >> 16) & 0x1f;
> +
> +    switch ((ctx->opcode >> 6) & 0x07) {

extract32.

>          case NM_POOL32A7:
> +        {
> +            switch ((ctx->opcode >> 3) & 0x07) {
> +            case NM_POOL32AXF:
> +                gen_pool32axf_nanomips_insn(env, ctx);
> +                break;
> +            }
> +        }

Bad indentation of a block that need not exist anyway.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
