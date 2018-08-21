Received: from eggs.gnu.org ([2001:4830:134:3::10]:49118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fs7ZN-0008Fr-8l
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fs7ZM-0006Rw-FX
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:23:41 -0400
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-4-contrib@steffen-goertz.de>
	<CAFEAcA-vtLpt-ScYpYPFqtQAnECuVqCW-DhKqVgoh6mAG=KfQw@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <df1b1627-47e4-bffd-e73c-ffa3eb037b2a@steffen-goertz.de>
Date: Tue, 21 Aug 2018 12:03:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-vtLpt-ScYpYPFqtQAnECuVqCW-DhKqVgoh6mAG=KfQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] arm: Add chip variant property to
 nRF51 SoC
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

object_property_set_bool(soc, true, "realized", &error_abort);>>
>> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
>> -            NRF51_SOC(soc)->flash_size);
>> +    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x00);
> 
> Hmm. Using 0x00 here doesn't seem ideal.

i agree. The actual sizes for RAM/ROM are calculated in the SOC at the moment.
I do not really know what impact max_sz has here. I could set the it to the
maximum code size defined in the memory map of the NRF51 series. Another way would be 
to lift the calculation of the ROM size from the SOC to the Board. What would you propose?
>> +#define PAGE_SIZE       1024
> 
> Page size isn't really an obvious concept for M profile.

Flash pages are referred to here, not MMU pages. This constant is moved and renamed to NRF51_PAGE_SIZE in the upcoming revision. Would you suggest another name or can with stick with this?

> Why have these lines been changed? (Rule of thumb: don't include code
> reformatting or style cleanups in the same patch as substantive changes.)

These lines where > 80 chars before. I should rather suggest a change of Joel's patch series.

Thank you for your remarks.

Steffen
