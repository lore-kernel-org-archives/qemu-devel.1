Received: from eggs.gnu.org ([2001:4830:134:3::10]:44450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNSiR-0006hA-6I
	for qemu-devel@nongnu.org; Mon, 28 May 2018 20:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNSiQ-0007Fr-9L
	for qemu-devel@nongnu.org; Mon, 28 May 2018 20:42:19 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-16-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a03e3c6d-52fc-b37c-c4f7-612c5af711a2@amsat.org>
Date: Mon, 28 May 2018 21:42:05 -0300
MIME-Version: 1.0
In-Reply-To: <20180528232719.4721-16-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 15/21] hw/block/nvme: Include
 "qemu/cutils.h" directly in the source file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:nvme" <qemu-block@nongnu.org>

On 05/28/2018 08:27 PM, Philippe Mathieu-Daudé wrote:

I forgot to add this commit description:

  "block/nvme.h" does not require any declaration of "qemu/cutils.h".
  Simplify dependencies by directly include it in the source file
  where the declarations are used.

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/block/nvme.h | 1 -
>  hw/block/nvme.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 8f3981121d..cabcf20c32 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -1,6 +1,5 @@
>  #ifndef HW_NVME_H
>  #define HW_NVME_H
> -#include "qemu/cutils.h"
>  #include "block/nvme.h"
>  
>  typedef struct NvmeAsyncEvent {
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 85d2406400..811084b6a7 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -35,6 +35,7 @@
>  #include "sysemu/block-backend.h"
>  
>  #include "qemu/log.h"
> +#include "qemu/cutils.h"
>  #include "trace.h"
>  #include "nvme.h"
>  
> 
