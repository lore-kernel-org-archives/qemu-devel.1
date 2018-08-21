Received: from eggs.gnu.org ([208.118.235.92]:39643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fs7oU-0001wh-Nu
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fs7oU-0003xv-4P
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:39:18 -0400
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-7-contrib@steffen-goertz.de>
	<CAFEAcA_=8r_X_rLfwJovEkusBb6hmaG5Ns8YQxQMLL4z0KpHXw@mail.gmail.com>
	<6c13fca2-6f16-adb0-1072-7601abefd18d@steffen-goertz.de>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <156619bb-c1c8-3338-b327-6dd298aa16cf@mail.ru>
Date: Tue, 21 Aug 2018 17:39:03 +0300
MIME-Version: 1.0
In-Reply-To: <6c13fca2-6f16-adb0-1072-7601abefd18d@steffen-goertz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/7] arm: Instantiate nRF51 peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>

On 21.08.2018 14:43, Steffen Görtz wrote:
> Hi Peter,
>>> +
>>> +static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int size)
>>> +{
>>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
>>> +                  __func__, addr, size);
>>> +    return 1;
>>> +}
>>> +
>>> +static void clock_write(void *opaque, hwaddr addr, uint64_t data,
>>> +                        unsigned int size)
>>> +{
>>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%u]\n",
>>> +                  __func__, addr, data, size);
>>> +}
>>> +
>>> +static const MemoryRegionOps clock_ops = {
>>> +    .read = clock_read,
>>> +    .write = clock_write
>>> +};
>>
>> You don't need to roll your own "do nothing but log" device:
>> you can use the TYPE_UNIMPLEMENTED_DEVICE to do this.
>
> Until we have a more proper STUB for POWER/CLOCK/MPU peripherals we actually need this,
> because the unimplemented device will return 0 on reads which will cause guest code to stall.

Do you need this stub to run micropython code? Could you delete this,
please, so that I can post the correct stub structures for js
directly on Joel's code?

Best regards, Julia Suvorova.
