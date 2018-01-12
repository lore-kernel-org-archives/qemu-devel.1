Received: from eggs.gnu.org ([2001:4830:134:3::10]:42048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzcS-0000gC-ND
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzcR-0005uH-Uk
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:43:40 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZzcR-0005tu-PY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:43:39 -0500
Received: by mail-oi0-x242.google.com with SMTP id d124so3928301oib.13
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 05:43:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-5-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 13:43:18 +0000
Message-ID: <CAFEAcA_8MAUkLn7hOvJh9f0EC7MpNQYJUMmcJu3S62bDHpBc+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/20] include/fpu/softfloat: implement
 float16_chs helper
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
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/fpu/softfloat.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index cfc615008d..dc71b01dba 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -354,6 +354,15 @@ static inline float16 float16_abs(float16 a)
>       */
>      return make_float16(float16_val(a) & 0x7fff);
>  }
> +
> +static inline float16 float16_chs(float16 a)
> +{
> +    /* Note that chs does *not* handle NaN specially, nor does
> +     * it flush denormal inputs to zero.
> +     */
> +    return make_float16(float16_val(a) ^ 0x8000);
> +}
> +
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
