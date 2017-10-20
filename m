Received: from eggs.gnu.org ([2001:4830:134:3::10]:38196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fj8-0001Wl-Pt
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fj5-0000Fe-Hv
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:25:14 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:44413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fj5-00005T-D5
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:25:11 -0400
Received: by mail-qk0-x235.google.com with SMTP id r64so16098913qkc.1
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 15:25:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508417443-31849-1-git-send-email-gabriel291075@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <78733847-5a74-a234-3c6e-9562e916f114@amsat.org>
Date: Fri, 20 Oct 2017 19:25:05 -0300
MIME-Version: 1.0
In-Reply-To: <1508417443-31849-1-git-send-email-gabriel291075@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] arm: Adding new arm machine,
 Kinetis K64 MK64FN1M0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gabriel291075@gmail.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

> +/*    dev = sysbus_create_simple(TYPE_KINETIS_SPI, 0x4002C000,
> +            qdev_get_gpio_in(nvic, 31)); *SPI0*/
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_SPI, 0x4002D000,
> +            qdev_get_gpio_in(nvic, 33)); *SPI1*/
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_ADC, 0x4003B000,
> +            qdev_get_gpio_in(nvic, 31)); *ADC0*/
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_DAC, 0x4002F000,
> +            qdev_get_gpio_in(nvic, 33)); *DAC0*/
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_I2C, 0x40066000,
> +            qdev_get_gpio_in(nvic, 31)); *I2C0*/
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_I2C, 0x40067000,
> +            qdev_get_gpio_in(nvic, 33)); *I2C1*/
> +
> +//    sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006A000,
> +//            qdev_get_gpio_in(nvic, 31)); /*UART0*/
> +    kinetis_k64_uart_create(0x4006A000, qdev_get_gpio_in(nvic, 31),
> +            serial_hds[0]);    
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006B000,
> +            qdev_get_gpio_in(nvic, 33)); *UART1*/
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006C000,
> +            qdev_get_gpio_in(nvic, 35)); *UART2*/
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006D000,
> +            qdev_get_gpio_in(nvic, 37)); *UART3*/
> +
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_SPI, 0x400AC000,
> +            qdev_get_gpio_in(nvic, 65)); *SPI2*/
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_ADC, 0x400BB000,
> +            qdev_get_gpio_in(nvic, 73)); *ADC1*/
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_I2C, 0x400E6000,
> +            qdev_get_gpio_in(nvic, 74)); *I2C2*/
> +
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x400EA000,
> +            qdev_get_gpio_in(nvic, 66)); *UART4*/
> +/*    dev = sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x400EB000,
> +            qdev_get_gpio_in(nvic, 68)); *UART5*/

Just create those with create_unimplemented_device() instead...

> +   
> +    create_unimplemented_device("peripheral_bridge_0",  0x40000000, 0x1000);
> +    create_unimplemented_device("Crossbar_Switch",      0x40004000, 0x1000);
> +    create_unimplemented_device("DMA_Controller",       0x40008000, 0x1000);
> +    create_unimplemented_device("DMA_Controller_t",     0x40009000, 0x1000);
> +    create_unimplemented_device("FlexBus",              0x4000C000, 0x1000);
> +    create_unimplemented_device("MPU",                  0x4000D000, 0x1000);
> +    create_unimplemented_device("Flash_mem_ctrl",       0x4001F000, 0x1000);
> +    create_unimplemented_device("Flash_mem",            0x40020000, 0x1000);
> +    create_unimplemented_device("DMA_ch_multiplexer",   0x40021000, 0x1000);
> +}
