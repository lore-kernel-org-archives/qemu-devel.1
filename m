Received: from eggs.gnu.org ([2001:4830:134:3::10]:42210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzco-0001Fr-Ig
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzcn-0006XB-IR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:44:02 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZzcn-0006W3-Dg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:44:01 -0500
Received: by mail-oi0-x243.google.com with SMTP id u83so3935723oie.7
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 05:44:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-6-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 13:43:40 +0000
Message-ID: <CAFEAcA88JBtRC2B5nUuqYdpuWVYd-nAHYvXwmGp4ZCmmq7W=+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/20] include/fpu/softfloat: implement
 float16_set_sign helper
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
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  include/fpu/softfloat.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index dc71b01dba..8ab5d0df47 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -363,6 +363,11 @@ static inline float16 float16_chs(float16 a)
>      return make_float16(float16_val(a) ^ 0x8000);
>  }
>
> +static inline float16 float16_set_sign(float16 a, int sign)
> +{
> +    return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
> +}
> +
>  /*----------------------------------------------------------------------=
------
>  | The pattern for a default generated half-precision NaN.
>  *-----------------------------------------------------------------------=
-----*/
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
