Received: from eggs.gnu.org ([2001:4830:134:3::10]:53311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e6jUs-0001We-Lf
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 16:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e6jUr-0004cI-CV
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 16:38:54 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:55503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gabriel291075@gmail.com>)
	id 1e6jUr-0004bw-3r
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 16:38:53 -0400
Received: by mail-pf0-x22f.google.com with SMTP id 17so17959163pfn.12
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 13:38:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <78733847-5a74-a234-3c6e-9562e916f114@amsat.org>
References: <1508417443-31849-1-git-send-email-gabriel291075@gmail.com>
	<78733847-5a74-a234-3c6e-9562e916f114@amsat.org>
From: Gabriel Costa <gabriel291075@gmail.com>
Date: Mon, 23 Oct 2017 16:38:51 -0400
Message-ID: <CAG+oHk-9VpKkYQQQDaD76ZpvmFtFWr=nfi+f8dicWwVUk=edig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hi Philippe,

Thanks for all your comments!
I will put all this corrections for the next patch, also I removed the
FlexTimer, it is not necessary to do this basic emulation.

Thanks,

Gabriel


On Fri, Oct 20, 2017 at 6:25 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_SPI, 0x4002C000,
> > +            qdev_get_gpio_in(nvic, 31)); *SPI0*/
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_SPI, 0x4002D000,
> > +            qdev_get_gpio_in(nvic, 33)); *SPI1*/
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_ADC, 0x4003B000,
> > +            qdev_get_gpio_in(nvic, 31)); *ADC0*/
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_DAC, 0x4002F000,
> > +            qdev_get_gpio_in(nvic, 33)); *DAC0*/
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_I2C, 0x40066000,
> > +            qdev_get_gpio_in(nvic, 31)); *I2C0*/
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_I2C, 0x40067000,
> > +            qdev_get_gpio_in(nvic, 33)); *I2C1*/
> > +
> > +//    sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006A000,
> > +//            qdev_get_gpio_in(nvic, 31)); /*UART0*/
> > +    kinetis_k64_uart_create(0x4006A000, qdev_get_gpio_in(nvic, 31),
> > +            serial_hds[0]);
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006B000,
> > +            qdev_get_gpio_in(nvic, 33)); *UART1*/
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006C000,
> > +            qdev_get_gpio_in(nvic, 35)); *UART2*/
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006D000,
> > +            qdev_get_gpio_in(nvic, 37)); *UART3*/
> > +
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_SPI, 0x400AC000,
> > +            qdev_get_gpio_in(nvic, 65)); *SPI2*/
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_ADC, 0x400BB000,
> > +            qdev_get_gpio_in(nvic, 73)); *ADC1*/
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_I2C, 0x400E6000,
> > +            qdev_get_gpio_in(nvic, 74)); *I2C2*/
> > +
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x400EA000,
> > +            qdev_get_gpio_in(nvic, 66)); *UART4*/
> > +/*    dev =3D sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x400EB000,
> > +            qdev_get_gpio_in(nvic, 68)); *UART5*/
>
> Just create those with create_unimplemented_device() instead...
>
> > +
> > +    create_unimplemented_device("peripheral_bridge_0",  0x40000000,
> 0x1000);
> > +    create_unimplemented_device("Crossbar_Switch",      0x40004000,
> 0x1000);
> > +    create_unimplemented_device("DMA_Controller",       0x40008000,
> 0x1000);
> > +    create_unimplemented_device("DMA_Controller_t",     0x40009000,
> 0x1000);
> > +    create_unimplemented_device("FlexBus",              0x4000C000,
> 0x1000);
> > +    create_unimplemented_device("MPU",                  0x4000D000,
> 0x1000);
> > +    create_unimplemented_device("Flash_mem_ctrl",       0x4001F000,
> 0x1000);
> > +    create_unimplemented_device("Flash_mem",            0x40020000,
> 0x1000);
> > +    create_unimplemented_device("DMA_ch_multiplexer",   0x40021000,
> 0x1000);
> > +}
>
