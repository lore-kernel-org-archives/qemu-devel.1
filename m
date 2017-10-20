Received: from eggs.gnu.org ([2001:4830:134:3::10]:60058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5f5h-0001Fp-DS
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 17:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5f5e-0000p3-A9
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 17:44:29 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:46064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5f5e-0000oI-4F
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 17:44:26 -0400
Received: by mail-qt0-x244.google.com with SMTP id p1so20167658qtg.2
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 14:44:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508513911-15630-1-git-send-email-gabriel291075@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f83abc45-ac10-303a-1b23-6cef2995e096@amsat.org>
Date: Fri, 20 Oct 2017 18:44:15 -0300
MIME-Version: 1.0
In-Reply-To: <1508513911-15630-1-git-send-email-gabriel291075@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/11] kinetis_k64_pmux.h has been added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriel Augusto Costa <gabriel291075@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 10/20/2017 12:38 PM, Gabriel Augusto Costa wrote:
> I made a new arm machine with some peripherals. The machine is mk64fn1m0, a
> cortex-m4 microcontroller from NXP Kinetis family. The machine can run a
> simple arm binary file using UART0 in polling mode.
> I have prepared a series of patchs to include this machine:
> PATCH v3 n/11: It adds the machine and peripherals devices;
> PATCH v4 n/2: It changes the Make files to compile this machine.
> 
> Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
> ---
>  include/hw/misc/kinetis_k64_pmux.h | 73 ++++++++++++++++++++++++++++++++++++++

Please send this with hw/misc/kinetis_k64_pmux.c (your patch 8)

>  1 file changed, 73 insertions(+)
>  create mode 100644 include/hw/misc/kinetis_k64_pmux.h
> 
> diff --git a/include/hw/misc/kinetis_k64_pmux.h b/include/hw/misc/kinetis_k64_pmux.h
> new file mode 100644
> index 0000000..fb6a6d5
> --- /dev/null
> +++ b/include/hw/misc/kinetis_k64_pmux.h
> @@ -0,0 +1,73 @@
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
> +
> +/* Kinetis K64 series PMUX controller.  */
> +
> +#ifndef KINETIS_PMUX_H
> +#define KINETIS_PMUX_H
> +
> +#include "hw/sysbus.h"
> +#include "chardev/char-fe.h"

not used

> +#include "chardev/char-mux.h"

not used

> +#include "hw/hw.h"
> +
> +#define TYPE_KINETIS_K64_PMUX "kinetis_k64_pmux"
> +#define KINETIS_K64_PMUX(obj) \
> +    OBJECT_CHECK(kinetis_k64_pmux_state, (obj), TYPE_KINETIS_K64_PMUX)
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +
> +    uint32_t PCR00;/**< Pin Control Register n, offset: 0x0, array step: 0x4 */

       uint32_t PCR[32];

> +    uint32_t PCR01;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR02;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR03;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR04;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR05;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR06;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR07;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR08;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR09;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR10;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR11;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR12;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR13;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR14;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR15;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR16;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR17;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR18;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR19;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR20;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR21;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR22;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR23;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR24;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR25;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR26;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR27;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR28;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR29;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR30;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
> +    uint32_t PCR31;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */

wrong/unuseful comments

> +    uint32_t GPCLR;     /**< Global Pin Control Low Register, offset: 0x80 */
> +    uint32_t GPCHR;     /**< Global Pin Control High Register, offset: 0x84 */
> +    uint32_t ISFR;      /**< Interrupt Status Flag Register, offset: 0xA0 */
> +    uint32_t DFER;      /**< Digital Filter Enable Register, offset: 0xC0 */
> +    uint32_t DFCR;      /**< Digital Filter Clock Register, offset: 0xC4 */
> +    uint32_t DFWR;      /**< Digital Filter Width Register, offset: 0xC8 */
> +
> +    qemu_irq irq;
> +} kinetis_k64_pmux_state;
> +
> +#endif
> 
