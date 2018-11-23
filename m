Received: from eggs.gnu.org ([2001:4830:134:3::10]:33551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQDXo-0004Ek-0w
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQDXk-0008In-Sv
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:38:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQDXj-000895-8s
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:38:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so12770375wrb.2
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 07:38:55 -0800 (PST)
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
	<20181123153040.18933-8-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2bb9f1cc-9a01-4a11-e196-1597f960b2b9@redhat.com>
Date: Fri, 23 Nov 2018 16:38:52 +0100
MIME-Version: 1.0
In-Reply-To: <20181123153040.18933-8-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/21] gpio/puv3_gpio: Convert sysbus
 init function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, gxt@mprc.pku.edu.cn, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 23/11/18 16:30, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> puv3_gpio_class_init().
> 
> Cc: gxt@mprc.pku.edu.cn
> Cc: peter.maydell@linaro.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/gpio/puv3_gpio.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
> index 445afccf9f..33241b8564 100644
> --- a/hw/gpio/puv3_gpio.c
> +++ b/hw/gpio/puv3_gpio.c
> @@ -99,36 +99,35 @@ static const MemoryRegionOps puv3_gpio_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> -static int puv3_gpio_init(SysBusDevice *dev)
> +static void puv3_gpio_realize(DeviceState *dev, Error **errp)
>  {
>      PUV3GPIOState *s = PUV3_GPIO(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>  
>      s->reg_GPLR = 0;
>      s->reg_GPDR = 0;
>  
>      /* FIXME: these irqs not handled yet */
> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW0]);
> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW1]);
> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW2]);
> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW3]);
> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW4]);
> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW5]);
> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW6]);
> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW7]);
> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOHIGH]);
> +    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW0]);
> +    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW1]);
> +    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW2]);
> +    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW3]);
> +    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW4]);
> +    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW5]);
> +    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW6]);
> +    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW7]);
> +    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOHIGH]);
>  
>      memory_region_init_io(&s->iomem, OBJECT(s), &puv3_gpio_ops, s, "puv3_gpio",
>              PUV3_REGS_OFFSET);
> -    sysbus_init_mmio(dev, &s->iomem);
> -
> -    return 0;
> +    sysbus_init_mmio(sbd, &s->iomem);
>  }
>  
>  static void puv3_gpio_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    sdc->init = puv3_gpio_init;
> +    dc->realize = puv3_gpio_realize;
>  }
>  
>  static const TypeInfo puv3_gpio_info = {
> 
