Received: from eggs.gnu.org ([2001:4830:134:3::10]:51984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccBLr-0004qm-9t
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccBLq-0006q4-6c
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:35:03 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170210092724.6470-1-lvivier@redhat.com>
	<20170210092724.6470-2-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cc618750-13dd-f673-05c6-a8b9fc45c058@amsat.org>
Date: Fri, 10 Feb 2017 10:34:45 -0300
MIME-Version: 1.0
In-Reply-To: <20170210092724.6470-2-lvivier@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] mac99: replace debug printf with trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 02/10/2017 06:27 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/mac_newworld.c | 15 +++------------
>  hw/ppc/trace-events   |  4 ++++
>  2 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 2bfdb64..3702dd1 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -72,6 +72,7 @@
>  #include "exec/address-spaces.h"
>  #include "hw/sysbus.h"
>  #include "qemu/cutils.h"
> +#include "trace.h"
>
>  #define MAX_IDE_BUS 2
>  #define CFG_ADDR 0xf0000510
> @@ -79,21 +80,11 @@
>  #define CLOCKFREQ (266UL * 1000UL * 1000UL)
>  #define BUSFREQ (100UL * 1000UL * 1000UL)
>
> -/* debug UniNorth */
> -//#define DEBUG_UNIN
> -
> -#ifdef DEBUG_UNIN
> -#define UNIN_DPRINTF(fmt, ...)                                  \
> -    do { printf("UNIN: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define UNIN_DPRINTF(fmt, ...)
> -#endif
> -
>  /* UniN device */
>  static void unin_write(void *opaque, hwaddr addr, uint64_t value,
>                         unsigned size)
>  {
> -    UNIN_DPRINTF("write addr " TARGET_FMT_plx " val %"PRIx64"\n", addr, value);
> +    trace_mac99_uninorth_write(addr, value);
>      if (addr == 0x0) {
>          *(int*)opaque = value;
>      }
> @@ -109,7 +100,7 @@ static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
>          value = *(int*)opaque;
>      }
>
> -    UNIN_DPRINTF("readl addr " TARGET_FMT_plx " val %x\n", addr, value);
> +    trace_mac99_uninorth_read(addr, value);
>
>      return value;
>  }
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index f46995c..6122a12 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -85,3 +85,7 @@ rs6000mc_presence_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
>  rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
>  rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=%x val=%x"
>  rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
> +
> +# hw/ppc/mac_newworld.c
> +mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
> +mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
>
