Received: from eggs.gnu.org ([2001:4830:134:3::10]:51845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEaN-0003zV-Hq
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEaM-0002VB-M3
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:36:23 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:32905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIEaM-0002V7-Hn
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:36:22 -0400
Received: by mail-oi0-x243.google.com with SMTP id k5-v6so10888311oiw.0
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:36:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-19-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 15:36:01 +0100
Message-ID: <CAFEAcA86RJxC5qu4=uZbvCz7qKueYWPvP8LN2bxj2QHSS17YMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 18/27] target/m68k: Use
 floatX_silence_nan when we have already checked for SNaN
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

On 12 May 2018 at 01:43, Richard Henderson <richard.henderson@linaro.org> wrote:
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/m68k/softfloat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
> index e41b07d042..6ec227e20f 100644
> --- a/target/m68k/softfloat.c
> +++ b/target/m68k/softfloat.c
> @@ -31,13 +31,14 @@ static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
>  {
>      if (floatx80_is_signaling_nan(a, status)) {
>          float_raise(float_flag_invalid, status);
> +        a = floatx80_silence_nan(a, status);
>      }
>
>      if (status->default_nan_mode) {
>          return floatx80_default_nan(status);
>      }
>
> -    return floatx80_maybe_silence_nan(a, status);
> +    return a;
>  }
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
