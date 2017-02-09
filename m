Received: from eggs.gnu.org ([2001:4830:134:3::10]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbx07-0006cQ-1E
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbx06-0000Sy-59
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:15:38 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486148371-11692-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb35aa71-69ca-71cc-c988-24174809ec51@amsat.org>
Date: Thu, 9 Feb 2017 19:15:29 -0300
MIME-Version: 1.0
In-Reply-To: <1486148371-11692-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] softfloat: Use correct type in
 float64_to_uint64_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

On 02/03/2017 03:59 PM, Peter Maydell wrote:
> In float64_to_uint64_round_to_zero() a typo meant that we were
> taking the uint64_t return value from float64_to_uint64() and
> putting it into an int64_t variable before returning it as
> uint64_t again. Use uint64_t instead of pointlessly casting it
> back and forth to int64_t.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Spotted while reading the code...
>
>  fpu/softfloat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index c295f31..218b375 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -7386,7 +7386,7 @@ uint64_t float64_to_uint64_round_to_zero(float64 a, float_status *status)
>  {
>      signed char current_rounding_mode = status->float_rounding_mode;
>      set_float_rounding_mode(float_round_to_zero, status);
> -    int64_t v = float64_to_uint64(a, status);
> +    uint64_t v = float64_to_uint64(a, status);
>      set_float_rounding_mode(current_rounding_mode, status);
>      return v;
>  }
>
