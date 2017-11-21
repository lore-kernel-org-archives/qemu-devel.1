Received: from eggs.gnu.org ([2001:4830:134:3::10]:54172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHAyp-0000JJ-N9
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHAyj-0003F4-Vz
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:00:59 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1511276851-17680-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <67e3046b-a562-b1fd-d80d-ee31a1939517@amsat.org>
Date: Tue, 21 Nov 2017 13:00:43 -0300
MIME-Version: 1.0
In-Reply-To: <1511276851-17680-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] accel/tcg/cpu-exec-common.c: Remove
 unnecessary include of memory-internal.h
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

On 11/21/2017 12:07 PM, Peter Maydell wrote:
> The cpu-exec-common.c file includes memory-internal.h, but it doesn't
> actually use anything from that header. Remove the unnecessary include.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  accel/tcg/cpu-exec-common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> index 5b4ae54..dac5aac 100644
> --- a/accel/tcg/cpu-exec-common.c
> +++ b/accel/tcg/cpu-exec-common.c
> @@ -21,7 +21,6 @@
>  #include "cpu.h"
>  #include "sysemu/cpus.h"
>  #include "exec/exec-all.h"
> -#include "exec/memory-internal.h"
>  
>  bool tcg_allowed;
>  
> 
