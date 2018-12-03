Received: from eggs.gnu.org ([2001:4830:134:3::10]:52504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTp17-0003jr-99
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTp14-0005zt-0X
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:16:09 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTp13-0005zK-QK
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:16:05 -0500
Received: by mail-wr1-x442.google.com with SMTP id c14so12355228wrr.0
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:16:05 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-5-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-5-cota@braap.org>
Date: Mon, 03 Dec 2018 14:16:03 +0000
Message-ID: <87pnui3dcs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/13] softfloat: rename canonicalize to
 sf_canonicalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> glibc >=3D 2.25 defines canonicalize in commit eaf5ad0
> (Add canonicalize, canonicalizef, canonicalizel., 2016-10-26).
>
> Given that we'll be including <math.h> soon, prepare
> for this by prefixing our canonicalize() with sf_ to avoid
> clashing with the libc's canonicalize().
>
> Reported-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Tested-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index e1eef954e6..ecdc00c633 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -336,8 +336,8 @@ static inline float64 float64_pack_raw(FloatParts p)
>  #include "softfloat-specialize.h"
>
>  /* Canonicalize EXP and FRAC, setting CLS.  */
> -static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
> -                               float_status *status)
> +static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
> +                                  float_status *status)
>  {
>      if (part.exp =3D=3D parm->exp_max && !parm->arm_althp) {
>          if (part.frac =3D=3D 0) {
> @@ -513,7 +513,7 @@ static FloatParts round_canonical(FloatParts p, float=
_status *s,
>  static FloatParts float16a_unpack_canonical(float16 f, float_status *s,
>                                              const FloatFmt *params)
>  {
> -    return canonicalize(float16_unpack_raw(f), params, s);
> +    return sf_canonicalize(float16_unpack_raw(f), params, s);
>  }
>
>  static FloatParts float16_unpack_canonical(float16 f, float_status *s)
> @@ -534,7 +534,7 @@ static float16 float16_round_pack_canonical(FloatPart=
s p, float_status *s)
>
>  static FloatParts float32_unpack_canonical(float32 f, float_status *s)
>  {
> -    return canonicalize(float32_unpack_raw(f), &float32_params, s);
> +    return sf_canonicalize(float32_unpack_raw(f), &float32_params, s);
>  }
>
>  static float32 float32_round_pack_canonical(FloatParts p, float_status *=
s)
> @@ -544,7 +544,7 @@ static float32 float32_round_pack_canonical(FloatPart=
s p, float_status *s)
>
>  static FloatParts float64_unpack_canonical(float64 f, float_status *s)
>  {
> -    return canonicalize(float64_unpack_raw(f), &float64_params, s);
> +    return sf_canonicalize(float64_unpack_raw(f), &float64_params, s);
>  }
>
>  static float64 float64_round_pack_canonical(FloatParts p, float_status *=
s)


--
Alex Benn=C3=A9e
