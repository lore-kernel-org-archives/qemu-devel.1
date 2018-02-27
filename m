Received: from eggs.gnu.org ([2001:4830:134:3::10]:42270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfev-0004mk-Aq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfet-0004EV-D2
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:51:09 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqfet-0004EI-8j
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:51:07 -0500
Received: by mail-oi0-x242.google.com with SMTP id x10so10337233oig.2
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 05:51:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-49-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-49-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 13:50:46 +0000
Message-ID: <CAFEAcA-gMG-V0dudD-9B2msPYMC7NmkU3Xsz9GimxMhVwQtPBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 48/67] target/arm: Implement SVE
 floating-point arithmetic (predicated)
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

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  77 ++++++++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 107 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  47 ++++++++++++++++++++
>  target/arm/sve.decode      |  17 +++++++
>  4 files changed, 248 insertions(+)

> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index a1e0ceb5fb..d80babfae7 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2789,6 +2789,113 @@ uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
>      return predtest_ones(d, oprsz, esz_mask);
>  }
>
> +/* Fully general three-operand expander, controlled by a predicate,
> + * With the extra float_status parameter.

lower-case "w"

> @@ -3181,6 +3227,7 @@ static void do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
>                         vec_full_reg_offset(s, rn),
>                         pred_full_reg_offset(s, pg),
>                         status, vsz, vsz, 0, fn);
> +    tcg_temp_free_ptr(status);
>  }

Shouldn't this be squashed into an earlier patch?

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
