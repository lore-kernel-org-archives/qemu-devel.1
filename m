Received: from eggs.gnu.org ([2001:4830:134:3::10]:42986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eRxvw-0003H1-IM
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eRxvv-0003gO-Fs
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:18:36 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:44658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eRxvv-0003g1-Ay
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:18:35 -0500
Received: by mail-io0-x243.google.com with SMTP id w127so20514108iow.11
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 02:18:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221082045.14022-17-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
	<20171221082045.14022-17-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 21 Dec 2017 11:18:13 +0100
Message-ID: <CACXAS8AEpHQy=61J=3AREcbXbBksm40y4A0qHpiWDvA57oj20w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 16/16] sun4u: switch from EBUS_DPRINTF()
 macro to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Thu, Dec 21, 2017 at 9:20 AM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/sparc64/sun4u.c      | 12 ++----------
>  hw/sparc64/trace-events |  3 +++
>  2 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 1456c3370d..5d802bdfde 100644
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
> @@ -218,7 +210,7 @@ static void ebus_isa_irq_handler(void *opaque, int n,=
 int level)
>      qemu_irq irq =3D s->isa_bus_irqs[n];
>
>      /* Pass ISA bus IRQs onto their gpio equivalent */
> -    EBUS_DPRINTF("Set ISA IRQ %d level %d\n", n, level);
> +    trace_ebus_isa_irq_handler(n, level);
>      if (irq) {
>          qemu_set_irq(irq, level);
>      }
> diff --git a/hw/sparc64/trace-events b/hw/sparc64/trace-events
> index 9284b1fbad..04d80b7f70 100644
> --- a/hw/sparc64/trace-events
> +++ b/hw/sparc64/trace-events
> @@ -1 +1,4 @@
>  # See docs/devel/tracing.txt for syntax documentation.
> +
> +# hw/sparc64/sun4u.c
> +ebus_isa_irq_handler(int n, int level) "Set ISA IRQ %d level %d"
> --
> 2.11.0
>



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
