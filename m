Received: from eggs.gnu.org ([2001:4830:134:3::10]:35633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0msb-0005Z9-B0
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0msW-0007FU-Nf
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:05 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f0msW-0007Ep-Gz
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:00 -0400
Received: by mail-wr0-x241.google.com with SMTP id u46so22052347wrc.11
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 04:35:00 -0700 (PDT)
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-6-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1521663109-32262-6-git-send-email-cota@braap.org>
Date: Tue, 27 Mar 2018 12:34:57 +0100
Message-ID: <87tvt192fy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 05/14] softfloat: add float32_is_normal
 and float64_is_normal
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
> index 36626a5..7b9d31c 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -402,6 +402,11 @@ static inline int float32_is_zero(float32 a)
>      return (float32_val(a) & 0x7fffffff) =3D=3D 0;
>  }
>
> +static inline bool float32_is_normal(float32 a)
> +{
> +    return ((float32_val(a) + 0x00800000) & 0x7fffffff) >=3D 0x01000000;
> +}
> +
>  static inline int float32_is_any_nan(float32 a)
>  {
>      return ((float32_val(a) & ~(1 << 31)) > 0x7f800000UL);
> @@ -531,6 +536,11 @@ static inline int float64_is_zero(float64 a)
>      return (float64_val(a) & 0x7fffffffffffffffLL) =3D=3D 0;
>  }
>
> +static inline bool float64_is_normal(float64 a)
> +{
> +    return ((float64_val(a) + (1ULL << 52)) & -1ULL >> 1) >=3D 1ULL << 5=
3;
> +}
> +
>  static inline int float64_is_any_nan(float64 a)
>  {
>      return ((float64_val(a) & ~(1ULL << 63)) > 0x7ff0000000000000ULL);


--
Alex Benn=C3=A9e
