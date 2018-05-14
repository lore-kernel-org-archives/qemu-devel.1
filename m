Received: from eggs.gnu.org ([2001:4830:134:3::10]:36956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAeJ-0004Pl-6I
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAeG-0007tx-OK
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:24:09 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:44504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIAeG-0007td-Is
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:24:08 -0400
Received: by mail-ot0-x241.google.com with SMTP id g7-v6so13626080otj.11
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:24:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-6-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:23:47 +0100
Message-ID: <CAFEAcA8EYY7gkLPntSUYBK3Q=_34cesKrZe-YS4d_evg=4RfXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/27] fpu/softfloat: Move
 softfloat-specialize.h below FloatParts definition
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

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> w=
rote:
> We want to be able to specialize on the canonical representation.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index bc0f52fa54..353893aaea 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -95,16 +95,6 @@ this code that are retained.
>  *-----------------------------------------------------------------------=
-----*/
>  #include "fpu/softfloat-macros.h"
>
> -/*----------------------------------------------------------------------=
------
> -| Functions and definitions to determine:  (1) whether tininess for unde=
rflow
> -| is detected before or after rounding by default, (2) what (if anything=
)
> -| happens when exceptions are raised, (3) how signaling NaNs are disting=
uished
> -| from quiet NaNs, (4) the default generated quiet NaNs, and (5) how NaN=
s
> -| are propagated from function inputs to output.  These details are targ=
et-
> -| specific.
> -*-----------------------------------------------------------------------=
-----*/
> -#include "softfloat-specialize.h"
> -
>  /*----------------------------------------------------------------------=
------
>  | Returns the fraction bits of the half-precision floating-point value `=
a'.
>  *-----------------------------------------------------------------------=
-----*/
> @@ -247,6 +237,16 @@ typedef struct {
>      uint64_t roundeven_mask;
>  } FloatFmt;
>
> +/*----------------------------------------------------------------------=
------
> +| Functions and definitions to determine:  (1) whether tininess for unde=
rflow
> +| is detected before or after rounding by default, (2) what (if anything=
)
> +| happens when exceptions are raised, (3) how signaling NaNs are disting=
uished
> +| from quiet NaNs, (4) the default generated quiet NaNs, and (5) how NaN=
s
> +| are propagated from function inputs to output.  These details are targ=
et-
> +| specific.
> +*-----------------------------------------------------------------------=
-----*/
> +#include "softfloat-specialize.h"
> +
>  /* Expand fields based on the size of exponent and fraction */
>  #define FLOAT_PARAMS(E, F)                                           \
>      .exp_size       =3D E,                                             \
> --
> 2.17.0
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
