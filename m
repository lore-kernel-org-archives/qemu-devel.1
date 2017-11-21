Received: from eggs.gnu.org ([2001:4830:134:3::10]:59346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH9xX-0006pD-Ja
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH9xR-00065F-Le
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:55:35 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:39380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eH9xR-00064r-EL
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:55:29 -0500
Received: by mail-oi0-x22e.google.com with SMTP id r190so8690500oie.6
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 06:55:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509107055-21978-5-git-send-email-costa@advantech.ca>
References: <1509107055-21978-1-git-send-email-costa@advantech.ca>
	<1509107055-21978-5-git-send-email-costa@advantech.ca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 14:55:08 +0000
Message-ID: <CAFEAcA_jzTqKFVmCu2uiSjr5UCd+53=TGmnWM9+uY=iAFC7AgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 4/5] arm: kinetis_k64_system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriel Costa <gabriel291075@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 27 October 2017 at 13:24, Gabriel Costa <gabriel291075@gmail.com> wrote:
> This Patch include kinetis_k64_system.c/.h and Makefile.objs
> sim means System Integration Module (SIM)
> More information about this peripheral can be found at:
> pag 291, K64P144M120SF5RM.pdf.
>
> Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
> ---
>  hw/misc/Makefile.objs                |   3 +
>  hw/misc/kinetis_k64_system.c         | 274 +++++++++++++++++++++++++++++++++++
>  include/hw/misc/kinetis_k64_system.h |  52 +++++++
>  3 files changed, 329 insertions(+)
>  create mode 100644 hw/misc/kinetis_k64_system.c
>  create mode 100644 include/hw/misc/kinetis_k64_system.h
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 19202d9..c5c8589 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -61,3 +61,6 @@ obj-$(CONFIG_AUX) += auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
>  obj-y += mmio_interface.o
>  obj-$(CONFIG_MSF2) += msf2-sysreg.o
> +obj-$(CONFIG_KINETIS_K64) += kinetis_k64_mcg.o
> +obj-$(CONFIG_KINETIS_K64) += kinetis_k64_pmux.o
> +obj-$(CONFIG_KINETIS_K64) += kinetis_k64_system.o
> diff --git a/hw/misc/kinetis_k64_system.c b/hw/misc/kinetis_k64_system.c
> new file mode 100644
> index 0000000..e547fe8
> --- /dev/null
> +++ b/hw/misc/kinetis_k64_system.c
> @@ -0,0 +1,274 @@
> +/*
> + * Kinetis K64 peripheral microcontroller emulation.
> + *
> + * Copyright (c) 2017 Advantech Wireless
> + * Written by Gabriel Costa <gabriel291075@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  (at your option) any later version.
> + */

Looks like the same comments apply here as for the other devices:
 * coding conventions
 * read-only registers
 * read-only bits in registers

thanks
-- PMM
