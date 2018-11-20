Received: from eggs.gnu.org ([2001:4830:134:3::10]:53726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOula-0005iI-Hm
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOulX-0000mG-EY
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:23:50 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:36683)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOulW-0000dp-Mt
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:23:47 -0500
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-8-maozhongyi@cmss.chinamobile.com>
	<CAFEAcA8JvzXjt4DACyz2jYwdNn=coAKZO+HBdQt+1eYKBBf2nQ@mail.gmail.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <cb3249f6-1acd-ef3f-25ea-8138b8f319c2@cmss.chinamobile.com>
Date: Tue, 20 Nov 2018 09:23:35 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8JvzXjt4DACyz2jYwdNn=coAKZO+HBdQt+1eYKBBf2nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/22] gpio/puv3_gpio: Convert sysbus
 initfunction to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>



On 11/19/18 10:31 PM, Peter Maydell wrote:
> On 19 November 2018 at 12:08, Mao Zhongyi
> <maozhongyi@cmss.chinamobile.com> wrote:
>> Use DeviceClass rather than SysBusDeviceClass in
>> puv3_gpio_class_init().
>>
>> Cc: gxt@mprc.pku.edu.cn
>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> ---
>>   hw/gpio/puv3_gpio.c | 28 +++++++++++++---------------
>>   1 file changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
>> index 445afccf9f..bd6fc43aae 100644
>> --- a/hw/gpio/puv3_gpio.c
>> +++ b/hw/gpio/puv3_gpio.c
>> @@ -99,7 +99,7 @@ static const MemoryRegionOps puv3_gpio_ops = {
>>       .endianness = DEVICE_NATIVE_ENDIAN,
>>   };
>>
>> -static int puv3_gpio_init(SysBusDevice *dev)
>> +static void puv3_gpio_realize(DeviceState *dev, Error **errp)
>>   {
>>       PUV3GPIOState *s = PUV3_GPIO(dev);
>>
>> @@ -107,28 +107,26 @@ static int puv3_gpio_init(SysBusDevice *dev)
>>       s->reg_GPDR = 0;
>>
>>       /* FIXME: these irqs not handled yet */
>> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW0]);
>> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW1]);
>> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW2]);
>> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW3]);
>> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW4]);
>> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW5]);
>> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW6]);
>> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW7]);
>> -    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOHIGH]);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW0]);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW1]);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW2]);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW3]);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW4]);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW5]);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW6]);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW7]);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOHIGH]);
>>
>>       memory_region_init_io(&s->iomem, OBJECT(s), &puv3_gpio_ops, s, "puv3_gpio",
>>               PUV3_REGS_OFFSET);
>> -    sysbus_init_mmio(dev, &s->iomem);
>> -
>> -    return 0;
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>>   }
> 
> The SYS_BUS_DEVICE() cast is not free (it does type
> checking). It's better to do it once, ie
>     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> and use the variable, if we're going to be using
> it several times.

Wow, sure，thanks a lot, will fix it in the next.

mao

> 
> thanks
> -- PMM
> 
