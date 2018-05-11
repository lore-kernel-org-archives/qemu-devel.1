Received: from eggs.gnu.org ([2001:4830:134:3::10]:60299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fH2me-0003QK-5B
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fH2ma-0004uS-5Y
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:48:08 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fH2mZ-0004uC-V5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:48:04 -0400
Received: by mail-wm0-x242.google.com with SMTP id t11-v6so1259662wmt.0
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 00:48:03 -0700 (PDT)
References: <20180511004345.26708-1-richard.henderson@linaro.org>
	<20180511004345.26708-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180511004345.26708-4-richard.henderson@linaro.org>
Date: Fri, 11 May 2018 08:48:01 +0100
Message-ID: <87efiivdji.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/19] fpu/softfloat: Move
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> We want to be able to specialize on the canonical representation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index e7c8213a5e..5e4982b035 100644
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
> -| is detected before or after rounding by default, (2) what (if anything)
> -| happens when exceptions are raised, (3) how signaling NaNs are disting=
uished
> -| from quiet NaNs, (4) the default generated quiet NaNs, and (5) how NaNs
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
> @@ -241,6 +231,16 @@ typedef struct {
>      bool arm_althp;
>  } FloatFmt;
>
> +/*----------------------------------------------------------------------=
------
> +| Functions and definitions to determine:  (1) whether tininess for unde=
rflow
> +| is detected before or after rounding by default, (2) what (if anything)
> +| happens when exceptions are raised, (3) how signaling NaNs are disting=
uished
> +| from quiet NaNs, (4) the default generated quiet NaNs, and (5) how NaNs
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


--
Alex Benn=C3=A9e
