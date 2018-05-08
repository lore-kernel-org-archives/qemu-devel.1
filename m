Received: from eggs.gnu.org ([2001:4830:134:3::10]:50209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG2IL-00071G-1B
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG2IH-0004nF-9K
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:04:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180427110137.19304-1-peter.maydell@linaro.org>
	<CAFEAcA-X1-D4G4KLmXrTpQ_Yz6O3Pyzj63ir3MjiR4ZkqOF=kw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f01b4c93-efe1-572a-5e14-7d0ca3d40ac2@amsat.org>
Date: Tue, 8 May 2018 10:04:33 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-X1-D4G4KLmXrTpQ_Yz6O3Pyzj63ir3MjiR4ZkqOF=kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/iotkit.c: fix minor
 memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 05/08/2018 06:16 AM, Peter Maydell wrote:
> ping for review?
> 
> thanks
> -- PMM
> 
> On 27 April 2018 at 12:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Coverity (CID1390573) spots that we forgot to free the
>> gpioname strings in a loop in the iotkit realize function.
>> Correct the error.
>>
>> This isn't a significant leak, because this function
>> only ever runs once.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> ---
>>  hw/arm/iotkit.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
>> index c5f0a5b98a..234185e8f7 100644
>> --- a/hw/arm/iotkit.c
>> +++ b/hw/arm/iotkit.c
>> @@ -517,6 +517,7 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
>>                                qdev_get_gpio_in(DEVICE(&s->ppc_irq_orgate), i));
>>          qdev_connect_gpio_out_named(DEVICE(ppc), "irq", 0,
>>                                      qdev_get_gpio_in(devs, 0));
>> +        g_free(gpioname);
>>      }
>>
>>      iotkit_forward_sec_resp_cfg(s);
>> --
>> 2.17.0
> 
