Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1caRAD-0004BS-T6
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 13:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1caRAA-0001Wu-RQ
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 13:03:49 -0500
References: <1486148371-11692-1-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <88a3c26a-31e3-9a7f-c676-3e279ab2cdc6@vivier.eu>
Date: Sun, 5 Feb 2017 19:03:42 +0100
MIME-Version: 1.0
In-Reply-To: <1486148371-11692-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] softfloat: Use correct type
 in float64_to_uint64_round_to_zero()
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

Le 03/02/2017 à 19:59, Peter Maydell a écrit :
> In float64_to_uint64_round_to_zero() a typo meant that we were
> taking the uint64_t return value from float64_to_uint64() and
> putting it into an int64_t variable before returning it as
> uint64_t again. Use uint64_t instead of pointlessly casting it
> back and forth to int64_t.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

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
