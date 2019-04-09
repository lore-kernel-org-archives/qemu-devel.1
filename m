Received: from eggs.gnu.org ([209.51.188.92]:42058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDuCj-0001Iw-8E
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDuCi-000659-6x
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:06:37 -0400
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fbe81e69-01f1-4755-49a8-e25df108a196@redhat.com>
Date: Tue, 9 Apr 2019 19:06:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] Header cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 09/04/2019 17.56, Aruna Jayasena wrote:
> Removed unwanted includes from cpu-common.h
> This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> 
> Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> 
> ---
>  include/exec/cpu-common.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index cef8b88a2a..a3594f3f50 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -7,8 +7,6 @@
>  #include "exec/hwaddr.h"
>  #endif
>  
> -#include "qemu/bswap.h"
> -#include "qemu/queue.h"
>  #include "qemu/fprintf-fn.h"
>  
>  /**
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
