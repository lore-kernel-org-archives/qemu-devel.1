Received: from eggs.gnu.org ([2001:4830:134:3::10]:54115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzzW-0007ni-8n
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzzQ-0003UW-Ic
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:07:30 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZzzQ-0003UH-E8
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:07:24 -0500
Received: by mail-ot0-x244.google.com with SMTP id w4so5118875otg.3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 06:07:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-9-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-9-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 14:07:03 +0000
Message-ID: <CAFEAcA_=1eAZ2U0HY6SAk727pLWRqv+CBoG7e0VAKJrWb_s7+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/20] fpu/softfloat: improve comments
 on ARM NaN propagation
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
> Mention the pseudo-code fragment from which this is based and correct
> the spelling of signalling.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
> index de2c5d5702..3d507d8c77 100644
> --- a/fpu/softfloat-specialize.h
> +++ b/fpu/softfloat-specialize.h
> @@ -445,14 +445,15 @@ static float32 commonNaNToFloat32(commonNaNT a, flo=
at_status *status)
>
>  #if defined(TARGET_ARM)
>  static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNa=
N,
> -                    flag aIsLargerSignificand)
> +                   flag aIsLargerSignificand)
>  {
> -    /* ARM mandated NaN propagation rules: take the first of:
> -     *  1. A if it is signaling
> -     *  2. B if it is signaling
> +    /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take
> +     * the first of:
> +     *  1. A if it is signalling
> +     *  2. B if it is signalling
>       *  3. A (quiet)
>       *  4. B (quiet)
> -     * A signaling NaN is always quietened before returning it.
> +     * A signalling NaN is always quietened before returning it.
>       */
>      if (aIsSNaN) {
>          return 0;

The correct spelling here is "signaling" with one "l". The IEEE spec
uses that, and the Arm ARM follows it. (I think I mentioned this last
time around too.)

thanks
-- PMM
