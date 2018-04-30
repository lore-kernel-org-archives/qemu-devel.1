Received: from eggs.gnu.org ([2001:4830:134:3::10]:35183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDCXi-0007ry-6M
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDCXh-0007MZ-9b
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:24:50 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:38716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDCXh-0007MT-3p
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:24:49 -0400
Received: by mail-ot0-x242.google.com with SMTP id j27-v6so10318007ota.5
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 10:24:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430170156.1860-1-laurent@vivier.eu>
References: <20180430170156.1860-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 18:24:27 +0100
Message-ID: <CAFEAcA_f_uFoQZf1T4f7K6nA-wEmHpUcs+9PQTd1cXd3xYnQKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] m68k: Fix floatx80_lognp1 (Coverity
 CID1390587)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 April 2018 at 18:01, Laurent Vivier <laurent@vivier.eu> wrote:
> return the result of packFloatx80() instead of
> dropping it.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/softfloat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
> index dffb371c71..2c069a5efb 100644
> --- a/target/m68k/softfloat.c
> +++ b/target/m68k/softfloat.c
> @@ -334,7 +334,8 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
>      if (aSign && aExp >= one_exp) {
>          if (aExp == one_exp && aSig == one_sig) {
>              float_raise(float_flag_divbyzero, status);
> -            packFloatx80(aSign, floatx80_infinity.high, floatx80_infinity.low);
> +            return packFloatx80(aSign, floatx80_infinity.high,
> +                                floatx80_infinity.low);
>          }
>          float_raise(float_flag_invalid, status);
>          return floatx80_default_nan(status);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
