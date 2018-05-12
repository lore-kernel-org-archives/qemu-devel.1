Received: from eggs.gnu.org ([2001:4830:134:3::10]:53705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fHcnQ-0004hI-Ew
	for qemu-devel@nongnu.org; Sat, 12 May 2018 18:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fHcnP-0001d0-0M
	for qemu-devel@nongnu.org; Sat, 12 May 2018 18:15:20 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fHcnO-0001cU-P6
	for qemu-devel@nongnu.org; Sat, 12 May 2018 18:15:18 -0400
Received: by mail-oi0-x243.google.com with SMTP id c203-v6so7660487oib.7
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 15:15:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-21-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-21-richard.henderson@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Sun, 13 May 2018 10:15:17 +1200
Message-ID: <CAHNT7NsuuFADjZDKY+0p81mnAqJG+WSgsOjzdR0bJMdyXaPzKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 20/27] target/riscv: Remove
 floatX_maybe_silence_nan from conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Sat, May 12, 2018 at 12:43 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> This is now handled properly by the generic softfloat code.
>
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Michael Clark <mjc@sifive.com>

---
>  target/riscv/fpu_helper.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index abbadead5c..fdb87d8d82 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -279,14 +279,12 @@ uint64_t helper_fmax_d(CPURISCVState *env, uint64_t
> frs1, uint64_t frs2)
>
>  uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1)
>  {
> -    rs1 = float64_to_float32(rs1, &env->fp_status);
> -    return float32_maybe_silence_nan(rs1, &env->fp_status);
> +    return float64_to_float32(rs1, &env->fp_status);
>  }
>
>  uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)
>  {
> -    rs1 = float32_to_float64(rs1, &env->fp_status);
> -    return float64_maybe_silence_nan(rs1, &env->fp_status);
> +    return float32_to_float64(rs1, &env->fp_status);
>  }
>
>  uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1)
> --
> 2.17.0
>
>
