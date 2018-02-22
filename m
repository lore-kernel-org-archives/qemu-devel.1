Received: from eggs.gnu.org ([2001:4830:134:3::10]:43705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eovF2-0007Qv-1P
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eovF1-0003pT-7i
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:05:12 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eovF1-0003on-32
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:05:11 -0500
Received: by mail-oi0-x244.google.com with SMTP id 123so1909146oig.5
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:05:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-5-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 18:04:50 +0000
Message-ID: <CAFEAcA9Xy8z85KRuVUFLJtEwpUgu+cHGYe_A6ymxurWZL-N+RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 04/67] target/arm: Implement
 SVE Bitwise Logical - Unpredicated Group
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
> These were the instructions that were stubbed out when
> introducing the decode skeleton.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 50 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 2c9e4733cb..50cf2a1fdd 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -32,6 +32,10 @@
>  #include "trace-tcg.h"
>  #include "translate-a64.h"
>
> +typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
> +typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
> +                        uint32_t, uint32_t, uint32_t);

I see we already have these in translate-a64.c -- put them in
translate-a64.h ?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
