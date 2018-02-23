Received: from eggs.gnu.org ([2001:4830:134:3::10]:33425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGzV-0004zu-4g
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGzU-0003uo-8s
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:18:37 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:46695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epGzU-0003tk-2b
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:18:36 -0500
Received: by mail-pl0-x243.google.com with SMTP id x19so5241250plr.13
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:18:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-43-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-43-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 17:18:14 +0000
Message-ID: <CAFEAcA-pu6a=WPoRYATp=W8afMjB4TtYpmLr0x_zuuS7_cH25w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 42/67] target/arm: Implement
 SVE Integer Wide Immediate - Unpredicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  25 +++++++++
>  target/arm/sve_helper.c    |  41 ++++++++++++++
>  target/arm/translate-sve.c | 135 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  26 +++++++++
>  4 files changed, 227 insertions(+)


>
> +# SVE integer add/subtract immediate (unpredicated)
> +ADD_zzi                00100101 .. 100 000 11 . ........ .....         @rdn_sh_i8u
> +SUB_zzi                00100101 .. 100 001 11 . ........ .....         @rdn_sh_i8u
> +SUBR_zzi       00100101 .. 100 011 11 . ........ .....         @rdn_sh_i8u
> +SQADD_zzi      00100101 .. 100 100 11 . ........ .....         @rdn_sh_i8u
> +UQADD_zzi      00100101 .. 100 101 11 . ........ .....         @rdn_sh_i8u
> +SQSUB_zzi      00100101 .. 100 110 11 . ........ .....         @rdn_sh_i8u
> +UQSUB_zzi      00100101 .. 100 111 11 . ........ .....         @rdn_sh_i8u
> +
> +# SVE integer min/max immediate (unpredicated)
> +SMAX_zzi       00100101 .. 101 000 110 ........ .....          @rdn_i8s
> +UMAX_zzi       00100101 .. 101 001 110 ........ .....          @rdn_i8u
> +SMIN_zzi       00100101 .. 101 010 110 ........ .....          @rdn_i8s
> +UMIN_zzi       00100101 .. 101 011 110 ........ .....          @rdn_i8u
> +
> +# SVE integer multiply immediate (unpredicated)
> +MUL_zzi                00100101 .. 110 000 110 ........ .....          @rdn_i8s

ADD, SUB, MUL out of line with the others.

> +
>  ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
>
>  # SVE load predicate register

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
