Received: from eggs.gnu.org ([2001:4830:134:3::10]:56128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXlgr-0008SQ-IP
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXlgq-0007mh-OU
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:59:17 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXlgq-0007ma-HE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:59:16 -0400
Received: by mail-ot0-x241.google.com with SMTP id c15-v6so18553694otl.3
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 03:59:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-25-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 11:58:55 +0100
Message-ID: <CAFEAcA83Bz+zyugMj10=Fd2n7hTY=ei+PJeb_ZY46-ajiGHS5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 24/35] target/arm: Implement SVE
 floating-point convert to integer
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


>  DO_ZPZ_FP(sve_fcvt_sh, uint32_t, H1_4, sve_f32_to_f16)
>  DO_ZPZ_FP(sve_fcvt_hs, uint32_t, H1_4, sve_f16_to_f32)
>  DO_ZPZ_FP(sve_fcvt_dh, uint64_t,     , sve_f64_to_f16)
> @@ -3174,6 +3246,22 @@ DO_ZPZ_FP(sve_fcvt_hd, uint64_t,     , sve_f16_to_f64)
>  DO_ZPZ_FP(sve_fcvt_ds, uint64_t,     , float64_to_float32)
>  DO_ZPZ_FP(sve_fcvt_sd, uint64_t,     , float32_to_float64)
>
> +DO_ZPZ_FP(sve_fcvtzs_hh, uint16_t, H1_2, vfp_float16_to_int16_rtz)
> +DO_ZPZ_FP(sve_fcvtzs_hs, uint32_t, H1_4, helper_vfp_tosizh)
> +DO_ZPZ_FP(sve_fcvtzs_ss, uint32_t, H1_4, helper_vfp_tosizs)
> +DO_ZPZ_FP(sve_fcvtzs_hd, uint64_t,     , vfp_float16_to_int64_rtz)
> +DO_ZPZ_FP(sve_fcvtzs_sd, uint64_t,     , vfp_float32_to_int64_rtz)
> +DO_ZPZ_FP(sve_fcvtzs_ds, uint64_t,     , helper_vfp_tosizd)
> +DO_ZPZ_FP(sve_fcvtzs_dd, uint64_t,     , vfp_float64_to_int64_rtz)
> +
> +DO_ZPZ_FP(sve_fcvtzu_hh, uint16_t, H1_2, vfp_float16_to_uint16_rtz)
> +DO_ZPZ_FP(sve_fcvtzu_hs, uint32_t, H1_4, helper_vfp_touizh)
> +DO_ZPZ_FP(sve_fcvtzu_ss, uint32_t, H1_4, helper_vfp_touizs)
> +DO_ZPZ_FP(sve_fcvtzu_hd, uint64_t,     , vfp_float16_to_uint64_rtz)
> +DO_ZPZ_FP(sve_fcvtzu_sd, uint64_t,     , vfp_float32_to_uint64_rtz)
> +DO_ZPZ_FP(sve_fcvtzu_ds, uint64_t,     , helper_vfp_touizd)
> +DO_ZPZ_FP(sve_fcvtzu_dd, uint64_t,     , vfp_float64_to_uint64_rtz)
> +

This kind of demonstrates that we've got a bit of an inconsistent
mess of naming with a lot of our fp related helper functions;
maybe we should regularize that someday.

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
