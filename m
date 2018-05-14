Received: from eggs.gnu.org ([2001:4830:134:3::10]:35530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAZI-00071D-T4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAZI-0004h6-2V
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:19:00 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:39948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIAZH-0004gn-UN
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:19:00 -0400
Received: by mail-ot0-x241.google.com with SMTP id n1-v6so13600361otf.7
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:18:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-2-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:18:38 +0100
Message-ID: <CAFEAcA8z-YV6sybzKXs3GBYXpqo7FYa7oucwFAe_Vc01DgjhpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/27] fpu/softfloat: int_to_float
 ensure r fully initialised
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> w=
rote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Reported by Coverity (CID1390635). We ensure this for uint_to_float
> later on so we might as well mirror that.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 8401b37bd4..b39c0c6fbb 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1525,7 +1525,7 @@ FLOAT_TO_UINT(64, 64)
>
>  static FloatParts int_to_float(int64_t a, float_status *status)
>  {
> -    FloatParts r;
> +    FloatParts r =3D {};
>      if (a =3D=3D 0) {
>          r.cls =3D float_class_zero;
>          r.sign =3D false;
> --
> 2.17.0
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
