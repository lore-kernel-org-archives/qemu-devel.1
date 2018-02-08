Received: from eggs.gnu.org ([2001:4830:134:3::10]:57213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejqBL-0002it-2I
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejqBK-0000Ms-BD
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:23 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180208172202.9984-1-f4bug@amsat.org>
	<20180208172202.9984-2-f4bug@amsat.org>
	<CAFEAcA_0rt7cCJs43BjW3OcQh=oeby+4j2dtFPSzgCn9tqW1qQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5562bd02-5399-b1af-f183-d9a16b0a1c62@amsat.org>
Date: Thu, 8 Feb 2018 14:40:12 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0rt7cCJs43BjW3OcQh=oeby+4j2dtFPSzgCn9tqW1qQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/arm/aspeed: directly map the serial
 device to the system address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/08/2018 02:30 PM, Peter Maydell wrote:
> On 8 February 2018 at 17:22, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/arm/aspeed_soc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index c83b7e207b..a786750e14 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -257,7 +257,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>>      /* UART - attach an 8250 to the IO space as our UART5 */
>>      if (serial_hds[0]) {
>>          qemu_irq uart5 = qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4]);
>> -        serial_mm_init(&s->iomem, ASPEED_SOC_UART_5_BASE, 2,
>> +        serial_mm_init(get_system_memory(), ASPEED_SOC_UART_5_BASE, 2,
>>                         uart5, 38400, serial_hds[0], DEVICE_LITTLE_ENDIAN);
>>      }
> 
> Is this a bug fix? It certainly changes behaviour, which
> suggests that a fuller commit message would be useful.

This patch is buggy indeed, using system_memory the serial address
should be ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE.

Thanks!

Phil.
