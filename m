Received: from eggs.gnu.org ([2001:4830:134:3::10]:55447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKQy-0000wS-Ne
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKQx-00045G-SW
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:39:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-8-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <661fd49b-03df-8084-e633-0e28eb2ac42d@amsat.org>
Date: Fri, 25 May 2018 18:39:26 -0300
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-8-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/20] ide: use local path for local
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
Cc: John Snow <jsnow@redhat.com>, peter.maydell@linaro.org, qemu-block@nongnu.org

On 05/25/2018 01:47 PM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ide/ahci-allwinner.c | 2 +-
>  hw/ide/ahci.c           | 2 +-
>  hw/ide/ich.c            | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
> index 2fd9507..f98e6cb 100644
> --- a/hw/ide/ahci-allwinner.c
> +++ b/hw/ide/ahci-allwinner.c
> @@ -20,7 +20,7 @@
>  #include "qemu/error-report.h"
>  #include "sysemu/dma.h"
>  #include "hw/ide/internal.h"
> -#include "hw/ide/ahci_internal.h"
> +#include "ahci_internal.h"
>  
>  #include "trace.h"
>  
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index e22d7be..24dbad5 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -31,7 +31,7 @@
>  #include "sysemu/dma.h"
>  #include "hw/ide/internal.h"
>  #include "hw/ide/pci.h"
> -#include "hw/ide/ahci_internal.h"
> +#include "ahci_internal.h"
>  
>  #include "trace.h"
>  
> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
> index 134478e..51c935a 100644
> --- a/hw/ide/ich.c
> +++ b/hw/ide/ich.c
> @@ -67,7 +67,7 @@
>  #include "hw/isa/isa.h"
>  #include "sysemu/dma.h"
>  #include "hw/ide/pci.h"
> -#include "hw/ide/ahci_internal.h"
> +#include "ahci_internal.h"
>  
>  #define ICH9_MSI_CAP_OFFSET     0x80
>  #define ICH9_SATA_CAP_OFFSET    0xA8
> 
