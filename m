Received: from eggs.gnu.org ([2001:4830:134:3::10]:51179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fnL3Y-00046m-Sv
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fnL3U-00026n-1e
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:47:04 -0400
Received: from smtp43.i.mail.ru ([94.100.177.103]:60282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fnL3T-00024q-M1
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:46:59 -0400
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-4-contrib@steffen-goertz.de>
	<CAJSP0QVrWiKtuRW+-EjFSJxrvWLtXWxsDHuvAuEe6yXOLWb72A@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <79c59408-f40a-e6e0-2165-cad353ba9030@mail.ru>
Date: Wed, 8 Aug 2018 12:46:40 +0300
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVrWiKtuRW+-EjFSJxrvWLtXWxsDHuvAuEe6yXOLWb72A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/7] tests: Add bbc:microbit / nRF51 test
 suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 08.08.2018 12:09, Stefan Hajnoczi wrote:
> On Mon, Aug 6, 2018 at 11:01 AM, Steffen Görtz
> <contrib@steffen-goertz.de> wrote:
>> +#define PAGE_SIZE           1024
>> +#define FLASH_SIZE          (256 * PAGE_SIZE)
>> +#define FLASH_BASE          0x00000000
>> +#define UICR_BASE           0x10001000
>> +#define UICR_SIZE           0x100
>> +#define NVMC_BASE           0x4001E000UL
>> +#define NVMC_READY          0x400
>> +#define NVMC_CONFIG         0x504
>> +#define NVMC_ERASEPAGE      0x508
>> +#define NVMC_ERASEPCR1      0x508
>> +#define NVMC_ERASEALL       0x50C
>> +#define NVMC_ERASEPCR0      0x510
>> +#define NVMC_ERASEUICR      0x514
> 
> All these constants could live in include/hw/arm/nrf51.h.  That way
> tests do not need to duplicate them.  As more devices are implemented
> we can expect this list to grow.

Maybe it's better to move them to device headers?
include/hw/arm/nrf51.h has to include them in any case to use device
types.

Best regards, Julia Suvorova.
