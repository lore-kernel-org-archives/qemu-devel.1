Received: from eggs.gnu.org ([2001:4830:134:3::10]:39305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMLQz-0005fS-8R
	for qemu-devel@nongnu.org; Fri, 25 May 2018 18:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMLQy-0003RA-7b
	for qemu-devel@nongnu.org; Fri, 25 May 2018 18:43:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-12-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f988860c-98b5-529c-59b9-971eb9fd0ef1@amsat.org>
Date: Fri, 25 May 2018 19:43:28 -0300
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-12-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/20] ppc: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 05/25/2018 01:47 PM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/ppc440_uc.c | 2 +-
>  hw/ppc/sam460ex.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index e312fdb..123f4ac 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -20,7 +20,7 @@
>  #include "hw/ppc/ppc.h"
>  #include "hw/pci/pci.h"
>  #include "sysemu/block-backend.h"
> -#include "hw/ppc/ppc440.h"
> +#include "ppc440.h"
>  
>  /*****************************************************************************/
>  /* L2 Cache as SRAM */
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index a48e6e6..cb2ab1d 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -27,8 +27,8 @@
>  #include "elf.h"
>  #include "exec/address-spaces.h"
>  #include "exec/memory.h"
> -#include "hw/ppc/ppc440.h"
> -#include "hw/ppc/ppc405.h"
> +#include "ppc440.h"
> +#include "ppc405.h"
>  #include "hw/block/flash.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/qtest.h"
> 
