Received: from eggs.gnu.org ([2001:4830:134:3::10]:49116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fs7ZN-0008Fp-8C
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fs7ZM-0006Rr-Ei
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:23:41 -0400
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-7-contrib@steffen-goertz.de>
	<CAFEAcA_=8r_X_rLfwJovEkusBb6hmaG5Ns8YQxQMLL4z0KpHXw@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <6c13fca2-6f16-adb0-1072-7601abefd18d@steffen-goertz.de>
Date: Tue, 21 Aug 2018 13:43:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_=8r_X_rLfwJovEkusBb6hmaG5Ns8YQxQMLL4z0KpHXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] arm: Instantiate nRF51 peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

Hi Peter,
>> +
>> +static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int size)
>> +{
>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
>> +                  __func__, addr, size);
>> +    return 1;
>> +}
>> +
>> +static void clock_write(void *opaque, hwaddr addr, uint64_t data,
>> +                        unsigned int size)
>> +{
>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%u]\n",
>> +                  __func__, addr, data, size);
>> +}
>> +
>> +static const MemoryRegionOps clock_ops = {
>> +    .read = clock_read,
>> +    .write = clock_write
>> +};
> 
> You don't need to roll your own "do nothing but log" device:
> you can use the TYPE_UNIMPLEMENTED_DEVICE to do this.
> 
Until we have a more proper STUB for POWER/CLOCK/MPU peripherals we actually need this,
because the unimplemented device will return 0 on reads which will cause guest code to stall.

Agree to and regarded the rest of your remarks.

Steffen
