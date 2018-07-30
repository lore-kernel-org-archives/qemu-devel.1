Received: from eggs.gnu.org ([2001:4830:134:3::10]:54890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fk8lc-0000xN-VU
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fk8lY-00083W-S8
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:03:21 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <94bc2d11-7916-bc4e-02d8-da62e3ed303b@mail.ru>
References: <20180726023645.13927-1-joel@jms.id.au>
	<20180726023645.13927-3-joel@jms.id.au>
	<94bc2d11-7916-bc4e-02d8-da62e3ed303b@mail.ru>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 30 Jul 2018 23:32:55 +0930
Message-ID: <CACPK8XfYvU8+0s+FBGe7NuAst38ska0vpS8HVPWkM8OHyLFpdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] arm: Add Nordic Semiconductor nRF51
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>

On 26 July 2018 at 20:31, Julia Suvorova <jusual@mail.ru> wrote:

>> +++ b/hw/arm/nrf51_soc.c

>> +static void nrf51_soc_init(Object *obj)
>> +{
>> +    NRF51State *s = NRF51_SOC(obj);
>> +
>> +    memory_region_init(&s->container, obj, "nrf51-container",
>> UINT64_MAX);
>> +
>> +    object_initialize(&s->cpu, sizeof(s->cpu), TYPE_ARM_M_PROFILE);
>> +    object_property_add_child(OBJECT(s), "armv6m", OBJECT(&s->cpu),
>> &error_abort);
>> +    qdev_set_parent_bus(DEVICE(&s->cpu), sysbus_get_default());
>> +    qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type",
>> ARM_CPU_TYPE_NAME("cortex-m0"));
>> +    qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 96);
>
>
> Where did this number come from? ARMv6-M NVIC supports only 32 interrupts.

I think this was left over from when I was first creating a m0 based
system (efm32hg) over a year ago. Good catch.

I couldn't see a table of valid interrupts in the nrf51 datasheet. Are
you able to find this information?

If not, I will re-spin with the number of irqs set to 32.

Cheers,

Joel
