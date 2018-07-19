Received: from eggs.gnu.org ([2001:4830:134:3::10]:53445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgED7-00010Y-8N
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgED2-0000oF-WD
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:03:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgED2-0000nx-Jk
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:03:28 -0400
Received: by mail-pg1-x544.google.com with SMTP id y4-v6so4575465pgp.9
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:03:28 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-13-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca8aae27-73fa-741e-688a-5e294ad0d3a0@linaro.org>
Date: Thu, 19 Jul 2018 12:03:24 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-13-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/40] target/mips: Add emulation of
 nanoMIPS FP instructions
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
> +static void gen_pool32f_nanomips_insn(DisasContext *ctx)
> +{
> +    int rt, rs, rd;
> +
> +    rt = (ctx->opcode >> 21) & 0x1f;
> +    rs = (ctx->opcode >> 16) & 0x1f;
> +    rd = (ctx->opcode >> 11) & 0x1f;

extract32?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
