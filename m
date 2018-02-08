Received: from eggs.gnu.org ([2001:4830:134:3::10]:60057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejtIR-0006cm-3n
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejtIQ-0004Nh-AD
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:59:55 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:38308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejtIQ-0004NX-6d
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:59:54 -0500
Received: by mail-io0-x244.google.com with SMTP id d13so7285017iog.5
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 12:59:54 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bfbbc7e6-48cb-9ff5-aa27-8226527ad4db@linaro.org>
Date: Thu, 8 Feb 2018 12:59:49 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/32] arm/translate-a64: add FP16
 FR[ECP/SQRT]S to simd_three_reg_same_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/helper-a64.c    | 34 ++++++++++++++++++++++++++++++++++
>  target/arm/helper-a64.h    |  2 ++
>  target/arm/translate-a64.c |  6 ++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index bdfcac111f..6358b42472 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -192,6 +192,10 @@ uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, void *fpstp)
>   * versions, these do a fully fused multiply-add or
>   * multiply-add-and-halve.
>   */
> +#define float16_two make_float16(0x4000)
> +#define float16_three make_float16(0x4200)
> +#define float16_one_point_five make_float16(0x3e00)
> +
>  #define float32_two make_float32(0x40000000)
>  #define float32_three make_float32(0x40400000)
>  #define float32_one_point_five make_float32(0x3fc00000)

I think we should move these somewhere else, some header
where we don't have to keep re-defining them in various
files within target/arm.

I know, for instance, that I need floatN_two in translate-sve.c.

Just putting them in softfloat.h is probably best.

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
