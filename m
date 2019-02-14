Received: from eggs.gnu.org ([209.51.188.92]:33859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guHSF-0004Pc-Sy
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guHS8-0004Sr-Ja
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:53:28 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guHS8-0004Re-8m
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:53:24 -0500
Received: by mail-ot1-x344.google.com with SMTP id i20so10618328otl.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 05:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20190206052857.5077-1-richard.henderson@linaro.org>
In-Reply-To: <20190206052857.5077-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 13:53:12 +0000
Message-ID: <CAFEAcA9oyJ5RxTqJdptK6bmMwFe++NLn15XTxdBkZbsfOUT_NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 6 Feb 2019 at 05:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes since v1:
>   * Typo fixed in patch 2, which had scrogged FMOV
>   * Return 0 for NaN, as for any other ARM fp conversion.
>
>
> r~
>
>
> Richard Henderson (3):
>   target/arm: Force result size into dp after operation
>   target/arm: Restructure disas_fp_int_conv
>   target/arm: Implement ARMv8.3-JSConv

I've applied patches 1 and 2 to target-arm.next; 3 has a bug in it,
I think.

thanks
-- PMM
