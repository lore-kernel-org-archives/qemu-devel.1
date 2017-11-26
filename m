Received: from eggs.gnu.org ([2001:4830:134:3::10]:58039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWH-0004Ts-Dt
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWE-00055z-7X
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:01 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWE-00055K-39
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:10:58 -0500
Received: by mail-qk0-x243.google.com with SMTP id o6so29595185qkh.3
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 08:10:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1511703326-25325-4-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3e110ced-a076-9463-3651-59bd8bff5d96@amsat.org>
Date: Sun, 26 Nov 2017 12:13:32 -0300
MIME-Version: 1.0
In-Reply-To: <1511703326-25325-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/8] sun4m: remove include/hw/sparc/sun4m.h
 and all references to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/26/2017 10:35 AM, Mark Cave-Ayland wrote:
> With the previous commit there is now nothing left in sun4m.h so it can be
> removed, along with all remaining references to it.

Nice!

> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/sparc32_dma.c     |    1 -
>  hw/intc/slavio_intctl.c  |    1 -
>  hw/net/lance.c           |    2 +-
>  hw/sparc/sun4m.c         |    1 -
>  hw/sparc/sun4m_iommu.c   |    1 -
>  hw/timer/slavio_timer.c  |    1 -
>  include/hw/sparc/sun4m.h |   14 --------------
>  7 files changed, 1 insertion(+), 20 deletions(-)
>  delete mode 100644 include/hw/sparc/sun4m.h
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index c04ad79..7b00a27 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -28,7 +28,6 @@
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
>  #include "hw/sparc/sparc32_dma.h"
> -#include "hw/sparc/sun4m.h"
>  #include "hw/sparc/sun4m_iommu.h"
>  #include "hw/sysbus.h"
>  #include "sysemu/dma.h"
> diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
> index 84e0bee..817e026 100644
> --- a/hw/intc/slavio_intctl.c
> +++ b/hw/intc/slavio_intctl.c
> @@ -23,7 +23,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "hw/sparc/sun4m.h"
>  #include "monitor/monitor.h"
>  #include "hw/sysbus.h"
>  #include "hw/intc/intc.h"
> diff --git a/hw/net/lance.c b/hw/net/lance.c
> index 23929fd..0028bc5 100644
> --- a/hw/net/lance.c
> +++ b/hw/net/lance.c
> @@ -40,7 +40,7 @@
>  #include "net/net.h"
>  #include "qemu/timer.h"
>  #include "qemu/sockets.h"
> -#include "hw/sparc/sun4m.h"
> +#include "hw/sparc/sparc32_dma.h"
>  #include "hw/net/lance.h"
>  #include "trace.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index a3ba92f..9723d6f 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -28,7 +28,6 @@
>  #include "hw/sysbus.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> -#include "hw/sparc/sun4m.h"
>  #include "hw/sparc/sun4m_iommu.h"
>  #include "hw/timer/m48t59.h"
>  #include "hw/sparc/sparc32_dma.h"
> diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
> index 311c82d..b677601 100644
> --- a/hw/sparc/sun4m_iommu.c
> +++ b/hw/sparc/sun4m_iommu.c
> @@ -23,7 +23,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "hw/sparc/sun4m.h"
>  #include "hw/sparc/sun4m_iommu.h"
>  #include "hw/sysbus.h"
>  #include "exec/address-spaces.h"
> diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
> index a8cc9c0..4694b65 100644
> --- a/hw/timer/slavio_timer.c
> +++ b/hw/timer/slavio_timer.c
> @@ -23,7 +23,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "hw/sparc/sun4m.h"
>  #include "qemu/timer.h"
>  #include "hw/ptimer.h"
>  #include "hw/sysbus.h"
> diff --git a/include/hw/sparc/sun4m.h b/include/hw/sparc/sun4m.h
> deleted file mode 100644
> index 9e06467..0000000
> --- a/include/hw/sparc/sun4m.h
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -#ifndef SUN4M_H
> -#define SUN4M_H
> -
> -#include "qemu-common.h"
> -#include "exec/hwaddr.h"
> -#include "qapi/qmp/types.h"
> -#include "hw/sysbus.h"
> -
> -/* Devices used by sparc32 system.  */
> -
> -/* sparc32_dma.c */
> -#include "hw/sparc/sparc32_dma.h"
> -
> -#endif
> 
