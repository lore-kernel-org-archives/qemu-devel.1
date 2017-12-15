Received: from eggs.gnu.org ([2001:4830:134:3::10]:33472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePoHZ-0000Hv-Ex
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePoHV-00023Q-Hn
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:36:01 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:42785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePoHV-00022O-BM
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:35:57 -0500
Received: by mail-qk0-x241.google.com with SMTP id a193so1234309qkc.9
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 03:35:57 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a6d51948-d82e-f3c5-98cd-372d38aaa7c6@amsat.org>
Date: Fri, 15 Dec 2017 08:35:52 -0300
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 02/19] include/fpu/softfloat: implement
 float16_abs helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/11/2017 09:56 AM, Alex Bennée wrote:
> This will be required when expanding the MINMAX() macro for 16
> bit/half-precision operations.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/fpu/softfloat.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index d5e99667b6..edf402d422 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -374,6 +374,13 @@ static inline int float16_is_zero_or_denormal(float16 a)
>      return (float16_val(a) & 0x7c00) == 0;
>  }
>  
> +static inline float16 float16_abs(float16 a)
> +{
> +    /* Note that abs does *not* handle NaN specially, nor does
> +     * it flush denormal inputs to zero.
> +     */
> +    return make_float16(float16_val(a) & 0x7fff);
> +}
>  /*----------------------------------------------------------------------------
>  | The pattern for a default generated half-precision NaN.
>  *----------------------------------------------------------------------------*/
> 
