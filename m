Received: from eggs.gnu.org ([2001:4830:134:3::10]:52686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXVHm-0004wz-Bz
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXVHl-0006EL-JE
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:28:18 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:43098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXVHl-0006Do-C9
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:28:17 -0400
Received: by mail-ot0-x242.google.com with SMTP id i19-v6so15931058otk.10
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 10:28:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-18-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 18:27:56 +0100
Message-ID: <CAFEAcA-OvmzYZjA_o0OvJX8J5CTp3QfwapSB5WX_-TTYMmUKpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 17/35] target/arm: Implement SVE
 floating-point arithmetic with immediate
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

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 56 ++++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 69 +++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 75 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 14 +++++++
>  4 files changed, 214 insertions(+)

> +
> +#define float16_two  make_float16(0x4000)
> +#define float32_two  make_float32(0x40000000)
> +#define float64_two  make_float64(0x4000000000000000ULL)

We seem to have these already in include/fpu/softfloat.h.

> +DO_FP_IMM(FADD, fadds, half, one)
> +DO_FP_IMM(FSUB, fsubs, half, one)
> +DO_FP_IMM(FMUL, fmuls, half, two)
> +DO_FP_IMM(FSUBR, fsubrs, half, one)
> +DO_FP_IMM(FMAXNM, fmaxnms, zero, one)
> +DO_FP_IMM(FMINNM, fminnms, zero, one)
> +DO_FP_IMM(FMAX, fmaxs, zero, one)
> +DO_FP_IMM(FMIN, fmins, zero, one)
> +
> +#undef DO_FP_IMM

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
