Received: from eggs.gnu.org ([2001:4830:134:3::10]:59078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkY4i-0007W6-Ld
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkY4g-0008Tv-2j
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:04:44 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:45653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkY4f-0008TY-SX
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:04:41 -0400
Received: by mail-ua0-x242.google.com with SMTP id k8-v6so10762215uaq.12
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 10:04:41 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-36-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e71c1d80-e820-b776-4e1a-b5e151664f12@linaro.org>
Date: Tue, 31 Jul 2018 13:04:36 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-36-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 35/76] target/mips: Add emulation of
 nanoMIPS 32-bit load and store instructions
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

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
>      case NM_P_GP_BH:
> +        {
> +            uint32_t u = extract32(ctx->opcode, 0, 18);
> +            switch (extract32(ctx->opcode, 18, 3)) {
> +            case NM_LBGP:
> +                gen_ld(ctx, OPC_LB, rt, 28, u);
> +                break;
> +            case NM_SBGP:
> +                gen_st(ctx, OPC_SB, rt, 28, u);
> +                break;
> +            case NM_LBUGP:
> +                gen_ld(ctx, OPC_LBU, rt, 28, u);
> +                break;
> +            case NM_ADDIUGP_B:
> +                if (rt != 0) {
> +                    uint32_t offset = extract32(ctx->opcode, 0, 18);

Duplicate extract of U.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
