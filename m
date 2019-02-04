Received: from eggs.gnu.org ([209.51.188.92]:50517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqfjD-0005Uq-Np
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqfjB-0003BK-NK
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:00:07 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqfj9-0002wp-LP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:00:03 -0500
Received: by mail-ot1-x342.google.com with SMTP id t5so268977otk.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20190204052712.30833-1-richard.henderson@linaro.org>
In-Reply-To: <20190204052712.30833-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 14:59:37 +0000
Message-ID: <CAFEAcA9bkZGpNNdZstt9dGj_yAywuGEzKn2a0r6E6Jdq5pyKTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Mon, 4 Feb 2019 at 05:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Two cleanups to surrounding code preceed the actual implementation.
>
> I did not find the ARM FPToFixedJS pseudo-function particularly helpful,
> so I mostly cribed off of the Alpha cvttq implementation.  But I think
> it all makes sense -- convert, produce the mod 2^32 result with NaN
> getting INT32_MAX, set ZF iff the conversion is exact.
>
> I've tested the aa64 version vs FVP with RISU.  I need to adjust my
> FVP configuration in order to test aa32.

I've reviewed patch 1; I'll leave 2 and 3 til you post v2.

thanks
-- PMM
