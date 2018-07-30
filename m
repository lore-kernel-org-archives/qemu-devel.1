Received: from eggs.gnu.org ([2001:4830:134:3::10]:38330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkFKL-0005I1-NY
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkFKI-0008VM-KD
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:03:37 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:40002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkFKI-0008V5-Em
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:03:34 -0400
Received: by mail-ua0-x244.google.com with SMTP id p22-v6so8820650uao.7
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 14:03:34 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-24-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d4a35847-b376-a30b-edc9-5b697fd4ebe5@linaro.org>
Date: Mon, 30 Jul 2018 17:03:29 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-24-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 23/76] target/mips: Add emulation of
 nanoMIPS 16-bit load and store instructions
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

On 07/30/2018 12:11 PM, Aleksandar Markovic wrote:
>      case NM_P16_LB:
> +        rd = extract32(ctx->opcode, 0, 2);
> +        switch (extract32(ctx->opcode, 2, 2)) {
...
>      case NM_P16_LH:
> +        rd = extract32(ctx->opcode, 1, 2) << 1;
> +        switch ((extract32(ctx->opcode, 3, 1) << 1) | (ctx->opcode & 1)) {
...
>      case NM_LW16:
> +        rd = extract32(ctx->opcode, 0, 4) << 2;
> +        gen_ld(ctx, OPC_LW, rt, rs, rd);

Again, do not use RD to hold anything other than a register.
In these cases and more through this patch, RD being set to
the immediate offset to the memory operation.


r~
