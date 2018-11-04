Received: from eggs.gnu.org ([2001:4830:134:3::10]:52081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gJFap-0005AK-NH
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gJFRk-0000qs-2D
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:15:59 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gJFRj-0000oH-Qk
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:15:55 -0500
Received: by mail-wr1-x434.google.com with SMTP id z16-v6so6271853wrv.2
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 02:15:55 -0800 (PST)
References: <cover.1541174426.git.noring@nocrew.org>
	<fa2941ee17c35fba2512ab530bde3a1807d5769e.1541174426.git.noring@nocrew.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1001e61e-b6c0-1a41-9e9f-e2fd5a51f7b5@linaro.org>
Date: Sun, 4 Nov 2018 10:15:51 +0000
MIME-Version: 1.0
In-Reply-To: <fa2941ee17c35fba2512ab530bde3a1807d5769e.1541174426.git.noring@nocrew.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Fix decoding mechanism of
 R5900 MFLO1, MFHI1, MTLO1 and MTHI1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org, "Maciej W. Rozycki" <macro@linux-mips.org>

On 11/2/18 4:08 PM, Fredrik Noring wrote:
> +    switch (opc) {
> +    case TX79_MMI_MFHI1:
> +#if defined(TARGET_MIPS64)
> +        tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[1]);
> +#else
> +        tcg_gen_mov_tl(cpu_gpr[reg], cpu_HI[1]);
> +#endif

You do not need this ifdef.  This is already done in tcg/tcg-op.h:

$ grep tcg_gen_ext32s_tl tcg/tcg-op.h
#define tcg_gen_ext32s_tl tcg_gen_ext32s_i64
#define tcg_gen_ext32s_tl tcg_gen_mov_i32


r~
