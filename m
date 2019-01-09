Received: from eggs.gnu.org ([209.51.188.92]:60102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAos-0002zU-P8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAos-0002gt-0w
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:10:42 -0500
References: <20181226003722.31257-1-plaes@plaes.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ead8c68c-66af-f7a4-fd92-fb0db785b226@vivier.eu>
Date: Wed, 9 Jan 2019 11:10:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181226003722.31257-1-plaes@plaes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] qom: Include
 qemu/fprintf-fn.h in cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Priit Laes <plaes@plaes.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 26/12/2018 01:37, Priit Laes wrote:
> QOM cpu.h uses fprintf_function which requires Qemu's
> qemu/fprintf-fn.h header. Include it.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  include/qom/cpu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 1396f53e5b..6d1ba53d72 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -26,6 +26,7 @@
>  #include "exec/memattrs.h"
>  #include "qapi/qapi-types-run-state.h"
>  #include "qemu/bitmap.h"
> +#include "qemu/fprintf-fn.h"
>  #include "qemu/rcu_queue.h"
>  #include "qemu/queue.h"
>  #include "qemu/thread.h"
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
