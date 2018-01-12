Received: from eggs.gnu.org ([2001:4830:134:3::10]:41781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzbv-0000DE-7p
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzbu-00056O-FX
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:43:07 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZzbu-00055E-Av
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:43:06 -0500
Received: by mail-ot0-x242.google.com with SMTP id r4so1235461oti.12
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 05:43:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-4-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 13:42:45 +0000
Message-ID: <CAFEAcA8VhgN8g94iZDC4Xu0TpERMAYAPo2Vp-UYRoGw46G_H-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/20] include/fpu/softfloat: implement
 float16_abs helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> This will be required when expanding the MINMAX() macro for 16
> bit/half-precision operations.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/fpu/softfloat.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 52af1412de..cfc615008d 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -347,6 +347,13 @@ static inline int float16_is_zero_or_denormal(float1=
6 a)
>      return (float16_val(a) & 0x7c00) =3D=3D 0;
>  }
>
> +static inline float16 float16_abs(float16 a)
> +{
> +    /* Note that abs does *not* handle NaN specially, nor does
> +     * it flush denormal inputs to zero.
> +     */
> +    return make_float16(float16_val(a) & 0x7fff);
> +}
>  /*----------------------------------------------------------------------=
------
>  | The pattern for a default generated half-precision NaN.
>  *-----------------------------------------------------------------------=
-----*/
> --
> 2.15.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
