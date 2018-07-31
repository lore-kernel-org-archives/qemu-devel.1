Received: from eggs.gnu.org ([2001:4830:134:3::10]:34738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkYLz-0006YD-9D
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkYLv-0008UI-5c
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:22:35 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:42135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkYLu-0008U6-VU
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:22:31 -0400
Received: by mail-vk0-x243.google.com with SMTP id t4-v6so7901727vke.9
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 10:22:30 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-40-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04fc1a98-130f-f66e-9e32-fecfd77060ed@linaro.org>
Date: Tue, 31 Jul 2018 13:22:26 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-40-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 39/76] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 2
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

> +                case NM_BPOSGE32C:
> +                    check_dsp(ctx);
> +                    {
> +                        int32_t imm = ctx->opcode;
> +                        imm >>= 1;
> +                        imm &= 0x1fff;
> +                        imm |= (ctx->opcode & 1) << 13;

extract32.

> +
> +                        gen_compute_branch(ctx, OPC_BPOSGE32, 4, -1, -2,
> +                                           (int32_t)imm, 4);

Useless cast.  And see my other response re gen_compute_branch.


r~
