Received: from eggs.gnu.org ([2001:4830:134:3::10]:52714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTp1V-0003yE-VF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTp1S-0006Hi-Li
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:16:33 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTp1S-0006H7-Fp
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:16:30 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so12356853wrr.0
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:16:30 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-6-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-6-cota@braap.org>
Date: Mon, 03 Dec 2018 14:16:28 +0000
Message-ID: <87o9a23dc3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/13] softfloat: add float{32,
 64}_is_zero_or_normal
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

> These will gain some users very soon.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/fpu/softfloat.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 9eeccd88a5..38a5e99cf3 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -474,6 +474,11 @@ static inline bool float32_is_denormal(float32 a)
>      return float32_is_zero_or_denormal(a) && !float32_is_zero(a);
>  }
>
> +static inline bool float32_is_zero_or_normal(float32 a)
> +{
> +    return float32_is_normal(a) || float32_is_zero(a);
> +}
> +
>  static inline float32 float32_set_sign(float32 a, int sign)
>  {
>      return make_float32((float32_val(a) & 0x7fffffff) | (sign << 31));
> @@ -625,6 +630,11 @@ static inline bool float64_is_denormal(float64 a)
>      return float64_is_zero_or_denormal(a) && !float64_is_zero(a);
>  }
>
> +static inline bool float64_is_zero_or_normal(float64 a)
> +{
> +    return float64_is_normal(a) || float64_is_zero(a);
> +}
> +
>  static inline float64 float64_set_sign(float64 a, int sign)
>  {
>      return make_float64((float64_val(a) & 0x7fffffffffffffffULL)


--
Alex Benn=C3=A9e
