Received: from eggs.gnu.org ([2001:4830:134:3::10]:41895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHUyl-0003K4-Kc
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHUyi-00036r-80
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:26:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHUyh-0002us-RQ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:26:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so12823432wru.9
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:26:26 -0700 (PDT)
References: <20181030114048.21527-1-philmd@redhat.com>
	<20181030114048.21527-2-philmd@redhat.com>
	<CAFEAcA-yrZY3QD7ecOkQHU18qnU2y=G-QP+=ZZMhhnKTWwoVVw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bb6a600f-861e-57dd-0bdb-108eccbaf7fa@redhat.com>
Date: Tue, 30 Oct 2018 15:26:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-yrZY3QD7ecOkQHU18qnU2y=G-QP+=ZZMhhnKTWwoVVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/arm/xilinx_zynq: Use the
 ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 30/10/18 15:07, Peter Maydell wrote:
> On 30 October 2018 at 11:40, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   hw/arm/xilinx_zynq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
>> index f1496d2927..57497b0c4d 100644
>> --- a/hw/arm/xilinx_zynq.c
>> +++ b/hw/arm/xilinx_zynq.c
>> @@ -294,7 +294,7 @@ static void zynq_init(MachineState *machine)
>>       busdev = SYS_BUS_DEVICE(dev);
>>       sysbus_mmio_map(busdev, 0, 0xF8003000);
>>       sysbus_connect_irq(busdev, 0, pic[45-IRQ_OFFSET]); /* abort irq line */
>> -    for (n = 0; n < 8; ++n) { /* event irqs */
>> +    for (n = 0; n < ARRAY_SIZE(dma_irqs); ++n) { /* event irqs */
>>           sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - IRQ_OFFSET]);
>>       }
>>
>> --
>> 2.17.2
> 
> Since this isn't related to the other patch, I'll just apply
> it to target-arm.next to save you carrying it around.

Thank you!
