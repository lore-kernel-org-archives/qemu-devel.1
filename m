Received: from eggs.gnu.org ([208.118.235.92]:51199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf0QY-0000So-Qg
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf0QU-0007cZ-0I
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:40:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf0QT-0007cB-Qc
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:40:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so33092295wrp.3
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 02:40:33 -0800 (PST)
References: <20190103091119.9367-1-stefanha@redhat.com>
	<20190103091119.9367-3-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51ac1e9a-6576-9a54-91f3-76bf66040cc7@redhat.com>
Date: Thu, 3 Jan 2019 11:40:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190103091119.9367-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/11] arm: Add header to host common
 definition for nRF51 SOC peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>

On 1/3/19 10:11 AM, Stefan Hajnoczi wrote:
> From: Steffen Görtz <contrib@steffen-goertz.de>
> 
> Adds a header that provides definitions that are used
> across nRF51 peripherals
> 
> Signed-off-by: Steffen Görtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/arm/nrf51.h       | 45 ++++++++++++++++++++++++++++++++++++
>  include/hw/char/nrf51_uart.h |  1 -
>  hw/arm/nrf51_soc.c           | 33 ++++++++++----------------
>  3 files changed, 57 insertions(+), 22 deletions(-)
>  create mode 100644 include/hw/arm/nrf51.h
> 
> diff --git a/include/hw/arm/nrf51.h b/include/hw/arm/nrf51.h
> new file mode 100644
> index 0000000000..175bb6c301
> --- /dev/null
> +++ b/include/hw/arm/nrf51.h
> @@ -0,0 +1,45 @@
> +/*
> + * Nordic Semiconductor nRF51 Series SOC Common Defines
> + *
> + * This file hosts generic defines used in various nRF51 peripheral devices.
> + *
> + * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
> + * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.pdf
> + *
> + * Copyright 2018 Steffen Görtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#ifndef NRF51_H
> +#define NRF51_H
> +
> +#define NRF51_FLASH_BASE      0x00000000
> +#define NRF51_FICR_BASE       0x10000000
> +#define NRF51_FICR_SIZE       0x00000100
> +#define NRF51_UICR_BASE       0x10001000
> +#define NRF51_SRAM_BASE       0x20000000
> +
> +#define NRF51_IOMEM_BASE      0x40000000
> +#define NRF51_IOMEM_SIZE      0x20000000
> +
> +#define NRF51_UART_BASE       0x40002000
> +#define NRF51_TIMER_BASE      0x40008000
> +#define NRF51_TIMER_SIZE      0x00001000
> +#define NRF51_RNG_BASE        0x4000D000
> +#define NRF51_NVMC_BASE       0x4001E000
> +#define NRF51_GPIO_BASE       0x50000000
> +
> +#define NRF51_PRIVATE_BASE    0xF0000000
> +#define NRF51_PRIVATE_SIZE    0x10000000
> +
> +#define NRF51_PAGE_SIZE       1024

I'd keep this file in hw/arm (not include/...).

> +
> +/* Trigger */
> +#define NRF51_TRIGGER_TASK 0x01
> +
> +/* Events */
> +#define NRF51_EVENT_CLEAR  0x00

These definitions might be the only one used out of hw/arm/.

> +
> +#endif
> diff --git a/include/hw/char/nrf51_uart.h b/include/hw/char/nrf51_uart.h
> index e3ecb7c81c..eb1c15b490 100644
> --- a/include/hw/char/nrf51_uart.h
> +++ b/include/hw/char/nrf51_uart.h
> @@ -16,7 +16,6 @@
>  #include "hw/registerfields.h"
>  
>  #define UART_FIFO_LENGTH 6
> -#define UART_BASE 0x40002000
>  #define UART_SIZE 0x1000
>  
>  #define TYPE_NRF51_UART "nrf51_soc.uart"
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index b89c1bdea0..55f8eaafcb 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -21,27 +21,16 @@
>  #include "qemu/log.h"
>  #include "cpu.h"
>  
> +#include "hw/arm/nrf51.h"
>  #include "hw/arm/nrf51_soc.h"
>  
> -#define IOMEM_BASE      0x40000000
> -#define IOMEM_SIZE      0x20000000
> -
> -#define FICR_BASE       0x10000000
> -#define FICR_SIZE       0x000000fc
> -
> -#define FLASH_BASE      0x00000000
> -#define SRAM_BASE       0x20000000
> -
> -#define PRIVATE_BASE    0xF0000000
> -#define PRIVATE_SIZE    0x10000000
> -
>  /*
>   * The size and base is for the NRF51822 part. If other parts
>   * are supported in the future, add a sub-class of NRF51SoC for
>   * the specific variants
>   */
> -#define NRF51822_FLASH_SIZE     (256 * 1024)
> -#define NRF51822_SRAM_SIZE      (16 * 1024)
> +#define NRF51822_FLASH_SIZE     (256 * NRF51_PAGE_SIZE)
> +#define NRF51822_SRAM_SIZE      (16 * NRF51_PAGE_SIZE)
>  
>  #define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
>  
> @@ -76,14 +65,14 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> -    memory_region_add_subregion(&s->container, FLASH_BASE, &s->flash);
> +    memory_region_add_subregion(&s->container, NRF51_FLASH_BASE, &s->flash);
>  
>      memory_region_init_ram(&s->sram, NULL, "nrf51.sram", s->sram_size, &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
>      }
> -    memory_region_add_subregion(&s->container, SRAM_BASE, &s->sram);
> +    memory_region_add_subregion(&s->container, NRF51_SRAM_BASE, &s->sram);
>  
>      /* UART */
>      object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
> @@ -92,15 +81,17 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>          return;
>      }
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
> -    memory_region_add_subregion_overlap(&s->container, UART_BASE, mr, 0);
> +    memory_region_add_subregion_overlap(&s->container, NRF51_UART_BASE, mr, 0);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
>                         qdev_get_gpio_in(DEVICE(&s->cpu),
> -                       BASE_TO_IRQ(UART_BASE)));
> +                       BASE_TO_IRQ(NRF51_UART_BASE)));
>  
> -    create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
> -    create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
> +    create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
> +                                NRF51_IOMEM_SIZE);
> +    create_unimplemented_device("nrf51_soc.ficr", NRF51_FICR_BASE,
> +                                NRF51_FICR_SIZE);
>      create_unimplemented_device("nrf51_soc.private",
> -                                PRIVATE_BASE, PRIVATE_SIZE);
> +                                NRF51_PRIVATE_BASE, NRF51_PRIVATE_SIZE);
>  }
>  
>  static void nrf51_soc_init(Object *obj)
> 
