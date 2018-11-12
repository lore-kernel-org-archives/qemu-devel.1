Received: from eggs.gnu.org ([2001:4830:134:3::10]:33654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM8JG-0005IE-UD
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM8JC-0007z0-0W
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:15:06 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gM8JB-0007xC-Fo
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:15:01 -0500
Received: by mail-wm1-x341.google.com with SMTP id v70-v6so6932938wmd.1
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 01:15:01 -0800 (PST)
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-12-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c34eda41-8c27-6c61-a53f-eae06da63fd9@linaro.org>
Date: Mon, 12 Nov 2018 10:14:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181111233622.8976-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 11/11] target/mips: Port MIPS64
 DCL[Z/O] to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 11/12/18 12:36 AM, Philippe Mathieu-Daudé wrote:
> +dclz            011100 ..... ..... ..... ..... 100100   @rs_rt_rd   ?ctx->insn_flags&ISA_MIPS64
> +dclo            011100 ..... ..... ..... ..... 100101   @rs_rt_rd   ?ctx->insn_flags&ISA_MIPS64

This syntax I do not like.  I preferred your other form,

  >isa(ISA_MIPS64)

which, with a change to return false as I suggested, would
have the same effect.

As an aside, you could do

#define check_isa(ctx, which)  ((ctx)->insn_flags & ISA_##which)

to reduce the decode markup to

  >isa(MIPS64)


r~
