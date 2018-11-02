Received: from eggs.gnu.org ([2001:4830:134:3::10]:59082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIcL5-0004h3-Cb
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIcL1-0005t9-E8
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:30:27 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33152)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIcL1-0005st-6W
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:30:23 -0400
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-9-contrib@steffen-goertz.de>
	<CAFEAcA_0GzLviMx_ExqwFUkW5PPFvOCTbZhw4tOJKU4pU1qMSg@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <09580573-3d0d-13d6-80d0-7b5d3a2961f4@steffen-goertz.de>
Date: Fri, 2 Nov 2018 12:30:21 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0GzLviMx_ExqwFUkW5PPFvOCTbZhw4tOJKU4pU1qMSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/13] hw/gpio/nrf51_gpio: Add nRF51
 GPIO peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

Hi Peter,

> 
> 
>> +static void reflect_dir_bit_in_cnf(NRF51GPIOState *s)
>> +{
>> +    uint32_t value = s->dir;
>> +    for (size_t i = 0; i < NRF51_GPIO_PINS; i++) {
> 
> Similarly here, and I think I saw another use somewhere else
> in this patchset too.

I have removed the c99 style declarations from the gpio device and also from the tests in microbit-tests.
Thank you for your review!

Steffen
