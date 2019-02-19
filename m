Received: from eggs.gnu.org ([209.51.188.92]:57145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw8qw-000888-9k
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw8qq-0008JE-AT
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:06:42 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw8qq-0008HR-4S
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:06:36 -0500
Received: by mail-ot1-x341.google.com with SMTP id n71so35360516ota.10
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20190215192302.27855-1-richard.henderson@linaro.org>
	<20190215192302.27855-5-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 17:06:19 +0000
Message-ID: <CAFEAcA8Y4U2xPsar4GbEqMJ717Rm0GXkpfP9T3jo6q=fJrdLBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 4/8] target/arm: Implement ARMv8.3-JSConv
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

On Fri, 15 Feb 2019 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Return 0 for NaN
> v3: Return aa32 flags in FPSCR.NZCV.


> +            /* The number is so large we must shift the fraction left.  */
> +            if (shift >= 64) {
> +                /* The the fraction is shifted out entirely.  */

Stil "The the".

> +                frac = 0;
> +            } else {
> +                frac <<= shift;
> +            }

> +uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
> +{
> +    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status);
> +    uint32_t result = pair;
> +    uint32_t z = (pair >> 32) == 0;
> +
> +    /* Store Z, clear NCV, in FPSCR.NZCF.  */

"NZCV".

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

If these are the only issues in the series I'll fix them as
I apply it.

thanks
-- PMM
