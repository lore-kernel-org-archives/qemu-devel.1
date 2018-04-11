Received: from eggs.gnu.org ([2001:4830:134:3::10]:49133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f6HRr-0003aX-7P
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f6HRo-0004vH-3J
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:14:11 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f6HRn-0004vD-UT
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:14:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id w23so2283440qtn.3
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 08:14:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-17-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <62609687-9906-4bcd-c57a-b7c881433009@amsat.org>
Date: Wed, 11 Apr 2018 12:14:04 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 16/24] tests/tcg/i386: fix
 test-i386-fprem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> Remove dependencies on QEMU's source tree and build directly.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/i386/test-i386-fprem.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/tcg/i386/test-i386-fprem.c b/tests/tcg/i386/test-i386-fprem.c
> index 1a71623204..771dc07433 100644
> --- a/tests/tcg/i386/test-i386-fprem.c
> +++ b/tests/tcg/i386/test-i386-fprem.c
> @@ -23,7 +23,10 @@
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#include "qemu/osdep.h"
> +#include <stdio.h>
> +#include <stdint.h>
> +
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  
>  /*
>   * Inspired by <ieee754.h>'s union ieee854_long_double, but with single
> @@ -39,7 +42,7 @@ union float80u {
>          unsigned int exponent:15;
>          unsigned int negative:1;
>          unsigned int empty:16;
> -    } QEMU_PACKED ieee;
> +    } __attribute__((packed)) ieee;
>  
>      /* This is for NaNs in the IEEE 854 double-extended-precision format.  */
>      struct {
> @@ -49,7 +52,7 @@ union float80u {
>          unsigned int exponent:15;
>          unsigned int negative:1;
>          unsigned int empty:16;
> -    } QEMU_PACKED ieee_nan;
> +    } __attribute__((packed)) ieee_nan;
>  };
>  
>  #define IEEE854_LONG_DOUBLE_BIAS 0x3fff
> 
