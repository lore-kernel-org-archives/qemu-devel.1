Received: from eggs.gnu.org ([2001:4830:134:3::10]:44994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQsQ8-0007lR-1A
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQsQ7-0007he-34
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:45:31 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQsQ6-0007gW-Oo
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:45:30 -0400
Received: by mail-ot0-x244.google.com with SMTP id n3-v6so10953428ota.5
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 03:45:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-19-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 11:45:09 +0100
Message-ID: <CAFEAcA-ZOrn0dHX9qhrsMsBVPLTVJp_EMjQi4q4JfgTABPXkzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 18/18] target/arm: Implement SVE
 Floating Point Arithmetic - Unpredicated Group
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

On 30 May 2018 at 19:01, Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 14 ++++++++
>  target/arm/helper.h        | 19 +++++++++++
>  target/arm/translate-sve.c | 42 +++++++++++++++++++++++
>  target/arm/vec_helper.c    | 69 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 10 ++++++
>  5 files changed, 154 insertions(+)
>

> +DO_3OP(gvec_fadd_h, float16_add, float16)
> +DO_3OP(gvec_fadd_s, float32_add, float32)
> +DO_3OP(gvec_fadd_d, float64_add, float64)
> +
> +DO_3OP(gvec_fsub_h, float16_sub, float16)
> +DO_3OP(gvec_fsub_s, float32_sub, float32)
> +DO_3OP(gvec_fsub_d, float64_sub, float64)
> +
> +DO_3OP(gvec_fmul_h, float16_mul, float16)
> +DO_3OP(gvec_fmul_s, float32_mul, float32)
> +DO_3OP(gvec_fmul_d, float64_mul, float64)
> +
> +DO_3OP(gvec_ftsmul_h, float16_ftsmul, float16)
> +DO_3OP(gvec_ftsmul_s, float32_ftsmul, float32)
> +DO_3OP(gvec_ftsmul_d, float64_ftsmul, float64)
> +
> +#ifdef TARGET_AARCH64
> +
> +DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
> +DO_3OP(gvec_recps_s, helper_recpsf_f32, float32)
> +DO_3OP(gvec_recps_d, helper_recpsf_f64, float64)
> +
> +DO_3OP(gvec_rsqrts_h, helper_rsqrtsf_f16, float16)
> +DO_3OP(gvec_rsqrts_s, helper_rsqrtsf_f32, float32)
> +DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
> +
> +#endif
> +#undef DO_3OP

Why do only these ones need to be guarded by the TARGET_AARCH64 ifdef?


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
