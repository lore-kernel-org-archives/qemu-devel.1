Received: from eggs.gnu.org ([2001:4830:134:3::10]:36239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGksn-00083w-H0
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGksm-0007Mk-MD
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:41:17 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGksm-0007Mc-HV
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:41:16 -0400
Received: by mail-oi0-x243.google.com with SMTP id n65-v6so1612091oig.6
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 05:41:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510094206.15354-2-alex.bennee@linaro.org>
References: <20180510094206.15354-1-alex.bennee@linaro.org>
	<20180510094206.15354-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 13:40:55 +0100
Message-ID: <CAFEAcA8jg2MR7hcdu2Fhb+GYKaS=2O+qv6LQGgdoGzTjwcuAmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] fpu/softfloat: int_to_float ensure
 r fully initialised
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 10 May 2018 at 10:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Reported by Coverity (CID1390635). We ensure this for uint_to_float
> later on so we might as well mirror that.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 70e0c40a1c..3adf6a06e4 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1517,7 +1517,7 @@ FLOAT_TO_UINT(64, 64)
>
>  static FloatParts int_to_float(int64_t a, float_status *status)
>  {
> -    FloatParts r;
> +    FloatParts r =3D {};
>      if (a =3D=3D 0) {
>          r.cls =3D float_class_zero;
>          r.sign =3D false;
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
