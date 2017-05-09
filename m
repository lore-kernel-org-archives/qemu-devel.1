Received: from eggs.gnu.org ([2001:4830:134:3::10]:48343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84WU-0006hg-8w
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84WP-0006n9-CF
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:45:50 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84WP-0006mW-7d
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:45:45 -0400
Received: by mail-qt0-x242.google.com with SMTP id j13so13587185qta.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 05:45:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-12-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c7b6f4d9-2d8e-f282-07b2-9aa9fcd2ee81@amsat.org>
Date: Tue, 9 May 2017 09:45:40 -0300
MIME-Version: 1.0
In-Reply-To: <20170509113332.4987-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/13] Remove/replace chardev/char.h
 inclusion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Hi Marc-André Lureau,

Isn't clearer if the "remove" part of this commit goes before your patch 
6 "move headers to include/chardev"?

On 05/09/2017 08:33 AM, Marc-André Lureau wrote:
> Those are apparently unnecessary includes.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/arm/bcm2835_peripherals.c | 1 -
>  hw/char/imx_serial.c         | 1 -
>  hw/display/xenfb.c           | 1 -
>  hw/i386/xen/xen-hvm.c        | 1 -
>  hw/mips/mips_fulong2e.c      | 1 -
>  hw/mips/mips_malta.c         | 1 -
>  hw/net/xgmac.c               | 1 -
>  hw/ppc/spapr_events.c        | 1 -
>  hw/ppc/spapr_rtas.c          | 1 -
>  hw/sparc/leon3.c             | 1 -
>  hw/usb/ccid-card-emulated.c  | 2 +-
>  hw/xen/xen_backend.c         | 1 -
>  util/event_notifier-posix.c  | 1 -
>  13 files changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 091e14dc60..502f04c02a 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -13,7 +13,6 @@
>  #include "hw/arm/bcm2835_peripherals.h"
>  #include "hw/misc/bcm2835_mbox_defs.h"
>  #include "hw/arm/raspi_platform.h"
> -#include "chardev/char.h"
>  #include "sysemu/sysemu.h"
>
>  /* Peripheral base address on the VC (GPU) system bus */
> diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
> index 1d4f378a59..af250305be 100644
> --- a/hw/char/imx_serial.c
> +++ b/hw/char/imx_serial.c
> @@ -21,7 +21,6 @@
>  #include "qemu/osdep.h"
>  #include "hw/char/imx_serial.h"
>  #include "sysemu/sysemu.h"
> -#include "chardev/char.h"
>  #include "qemu/log.h"
>
>  #ifndef DEBUG_IMX_UART
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index 4a1a2a4d6e..e76c0d805c 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -28,7 +28,6 @@
>
>  #include "hw/hw.h"
>  #include "ui/console.h"
> -#include "chardev/char.h"
>  #include "hw/xen/xen_backend.h"
>
>  #include <xen/event_channel.h>
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 8dc57a31cf..321cf36b67 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -18,7 +18,6 @@
>  #include "hw/xen/xen_backend.h"
>  #include "qmp-commands.h"
>
> -#include "chardev/char.h"
>  #include "qemu/error-report.h"
>  #include "qemu/range.h"
>  #include "sysemu/xen-mapcache.h"
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 55eeb9227d..dbe2805acb 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -32,7 +32,6 @@
>  #include "hw/mips/mips.h"
>  #include "hw/mips/cpudevs.h"
>  #include "hw/pci/pci.h"
> -#include "chardev/char.h"
>  #include "sysemu/sysemu.h"
>  #include "audio/audio.h"
>  #include "qemu/log.h"
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 610e1e9085..6fcdd9c6c1 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -37,7 +37,6 @@
>  #include "hw/mips/mips.h"
>  #include "hw/mips/cpudevs.h"
>  #include "hw/pci/pci.h"
> -#include "chardev/char.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/arch_init.h"
>  #include "qemu/log.h"
> diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
> index 3d00e2868c..0843bf185c 100644
> --- a/hw/net/xgmac.c
> +++ b/hw/net/xgmac.c
> @@ -26,7 +26,6 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
> -#include "chardev/char.h"
>  #include "qemu/log.h"
>  #include "net/net.h"
>  #include "net/checksum.h"
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index b309f2f4b0..8a5f1d321a 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -28,7 +28,6 @@
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "sysemu/sysemu.h"
> -#include "chardev/char.h"
>  #include "hw/qdev.h"
>  #include "sysemu/device_tree.h"
>
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 9995b1a9f5..dd1633a104 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -29,7 +29,6 @@
>  #include "qemu/log.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/sysemu.h"
> -#include "chardev/char.h"
>  #include "hw/qdev.h"
>  #include "sysemu/device_tree.h"
>  #include "sysemu/cpus.h"
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index f3e62f5bd7..f415997649 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -28,7 +28,6 @@
>  #include "hw/hw.h"
>  #include "qemu/timer.h"
>  #include "hw/ptimer.h"
> -#include "chardev/char.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/qtest.h"
>  #include "hw/boards.h"
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index 690b6c3ab4..e646eb243b 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -33,7 +33,7 @@
>  #include <vcard_emul.h>
>
>  #include "qemu/thread.h"
> -#include "chardev/char.h"
> +#include "qemu/main-loop.h"
>  #include "ccid.h"
>
>  #define DPRINTF(card, lvl, fmt, ...) \
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index a252a7fd96..b6e1b8cf59 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -28,7 +28,6 @@
>  #include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "hw/boards.h"
> -#include "chardev/char.h"
>  #include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "hw/xen/xen_backend.h"
> diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
> index 8ab06f9b41..73c4046b58 100644
> --- a/util/event_notifier-posix.c
> +++ b/util/event_notifier-posix.c
> @@ -14,7 +14,6 @@
>  #include "qemu-common.h"
>  #include "qemu/cutils.h"
>  #include "qemu/event_notifier.h"
> -#include "chardev/char.h"
>  #include "qemu/main-loop.h"
>
>  #ifdef CONFIG_EVENTFD
>
