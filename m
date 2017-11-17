Received: from eggs.gnu.org ([2001:4830:134:3::10]:36503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eFm2c-000120-MJ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eFm2Z-0007Zl-GQ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:11:06 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:40230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eFm2Z-0007Z7-Bm
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:11:03 -0500
Received: by mail-qk0-x244.google.com with SMTP id p7so601192qkd.7
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 11:11:03 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-16-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d7b93f2b-60bd-7adb-c318-9deb93ff505d@amsat.org>
Date: Fri, 17 Nov 2017 16:10:39 -0300
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-16-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 15/15] sun4u: switch from EBUS_DPRINTF()
 macro to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org

On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sparc64/sun4u.c      |   12 ++----------
>  hw/sparc64/trace-events |    3 +++
>  2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index da386d3..50ccf75 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -47,17 +47,9 @@
>  #include "hw/ide/pci.h"
>  #include "hw/loader.h"
>  #include "elf.h"
> +#include "trace.h"
>  #include "qemu/cutils.h"
>  
> -//#define DEBUG_EBUS
> -
> -#ifdef DEBUG_EBUS
> -#define EBUS_DPRINTF(fmt, ...)                                  \
> -    do { printf("EBUS: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define EBUS_DPRINTF(fmt, ...)
> -#endif
> -
>  #define KERNEL_LOAD_ADDR     0x00404000
>  #define CMDLINE_ADDR         0x003ff000
>  #define PROM_SIZE_MAX        (4 * 1024 * 1024)
> @@ -218,7 +210,7 @@ static void ebus_isa_irq_handler(void *opaque, int n, int level)
>      qemu_irq irq = s->isa_bus_irqs[n];
>  
>      /* Pass ISA bus IRQs onto their gpio equivalent */
> -    EBUS_DPRINTF("Set ISA IRQ %d level %d\n", n, level);
> +    trace_ebus_isa_irq_handler(n, level);
>      if (irq) {
>          qemu_set_irq(irq, level);
>      }
> diff --git a/hw/sparc64/trace-events b/hw/sparc64/trace-events
> index 9284b1f..04d80b7 100644
> --- a/hw/sparc64/trace-events
> +++ b/hw/sparc64/trace-events
> @@ -1 +1,4 @@
>  # See docs/devel/tracing.txt for syntax documentation.
> +
> +# hw/sparc64/sun4u.c
> +ebus_isa_irq_handler(int n, int level) "Set ISA IRQ %d level %d"
> 
