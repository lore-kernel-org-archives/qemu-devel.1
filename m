Received: from eggs.gnu.org ([2001:4830:134:3::10]:45979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1foXVu-0002sr-9j
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1foXVt-0005OB-4A
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:17:18 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:44354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1foXVs-0005N8-Vf
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:17:17 -0400
Received: by mail-qt0-x242.google.com with SMTP id b15-v6so13474155qtp.11
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 10:17:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180810193129.1556-6-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
	<20180810193129.1556-6-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Sat, 11 Aug 2018 19:17:15 +0200
Message-ID: <CABoDooO-kKP2ee6==0XOJMkPrrOQ7ufcz86XJGqAH=e6Jd9wTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/6] target/arm: Fix aa64 FCADD and FCMLA
 decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Fri, Aug 10, 2018 at 9:31 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> These insns require u=1; failed to include that in the switch
> cases.  This probably happened during one of the rebases just
> before final commit.
>
> Fixes: d17b7cdcf4e
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Laurent

> ---
>  target/arm/translate-a64.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 4a0ca8c906..8a24278d79 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11427,12 +11427,12 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
>          }
>          feature = ARM_FEATURE_V8_DOTPROD;
>          break;
> -    case 0x8: /* FCMLA, #0 */
> -    case 0x9: /* FCMLA, #90 */
> -    case 0xa: /* FCMLA, #180 */
> -    case 0xb: /* FCMLA, #270 */
> -    case 0xc: /* FCADD, #90 */
> -    case 0xe: /* FCADD, #270 */
> +    case 0x18: /* FCMLA, #0 */
> +    case 0x19: /* FCMLA, #90 */
> +    case 0x1a: /* FCMLA, #180 */
> +    case 0x1b: /* FCMLA, #270 */
> +    case 0x1c: /* FCADD, #90 */
> +    case 0x1e: /* FCADD, #270 */
>          if (size == 0
>              || (size == 1 && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))
>              || (size == 3 && !is_q)) {
> --
> 2.17.1
>
