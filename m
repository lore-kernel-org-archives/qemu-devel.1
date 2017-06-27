Received: from eggs.gnu.org ([2001:4830:134:3::10]:56062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dPwtz-0000zO-OS
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dPwtx-00041O-U8
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:15:59 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:51314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dPwtx-0003wP-Nq
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:15:57 -0400
Date: Tue, 27 Jun 2017 22:15:44 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170627201544.5rwmwnyd7wlbdozh@aurel32.net>
References: <20170627191221.31650-1-laurent@vivier.eu>
	<20170627191221.31650-5-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627191221.31650-5-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] softfloat: define floatx80_round()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>

On 2017-06-27 21:12, Laurent Vivier wrote:
> Add a function to round a floatx80 to the defined precision
> (floatx80_rounding_precision)
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
>  fpu/softfloat.c         | 15 +++++++++++++++
>  include/fpu/softfloat.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 7af14e2..e9bf359 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -5086,6 +5086,21 @@ float128 floatx80_to_float128(floatx80 a, float_status *status)
>  }
>  
>  /*----------------------------------------------------------------------------
> +| Rounds the extended double-precision floating-point value `a'

Maybe it is worth mentioning the precision to which the value is rounded
(floatx80_rounding_precision) ?

Otherwise looks all fine to me.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
