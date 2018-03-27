Received: from eggs.gnu.org ([2001:4830:134:3::10]:35682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0msg-0005cE-I1
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0msf-0007Ne-Lz
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:10 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f0msf-0007Mk-CO
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:09 -0400
Received: by mail-wr0-x243.google.com with SMTP id d1so10032613wrj.13
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 04:35:09 -0700 (PDT)
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-7-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1521663109-32262-7-git-send-email-cota@braap.org>
Date: Tue, 27 Mar 2018 12:35:07 +0100
Message-ID: <87sh8l92fo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 06/14] softfloat: add
 float32_is_denormal and float64_is_denormal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Emilio G. Cota <cota@braap.org> writes:

> This paves the way for upcoming work.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/fpu/softfloat.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 7b9d31c..8fb44a8 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -417,6 +417,11 @@ static inline int float32_is_zero_or_denormal(float3=
2 a)
>      return (float32_val(a) & 0x7f800000) =3D=3D 0;
>  }
>
> +static inline bool float32_is_denormal(float32 a)
> +{
> +    return float32_is_zero_or_denormal(a) && !float32_is_zero(a);
> +}
> +
>  static inline float32 float32_set_sign(float32 a, int sign)
>  {
>      return make_float32((float32_val(a) & 0x7fffffff) | (sign << 31));
> @@ -551,6 +556,11 @@ static inline int float64_is_zero_or_denormal(float6=
4 a)
>      return (float64_val(a) & 0x7ff0000000000000LL) =3D=3D 0;
>  }
>
> +static inline bool float64_is_denormal(float64 a)
> +{
> +    return float64_is_zero_or_denormal(a) && !float64_is_zero(a);
> +}
> +
>  static inline float64 float64_set_sign(float64 a, int sign)
>  {
>      return make_float64((float64_val(a) & 0x7fffffffffffffffULL)


--
Alex Benn=C3=A9e
