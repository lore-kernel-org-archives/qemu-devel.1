Received: from eggs.gnu.org ([2001:4830:134:3::10]:47468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnnbw-0005Rq-GD
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnnbv-0006BA-Iy
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:16:28 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:51782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fnnbv-0006AC-Cb
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:16:27 -0400
Received: by mail-wm0-x244.google.com with SMTP id y2-v6so783001wma.1
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 09:16:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <79c59408-f40a-e6e0-2165-cad353ba9030@mail.ru>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-4-contrib@steffen-goertz.de>
	<CAJSP0QVrWiKtuRW+-EjFSJxrvWLtXWxsDHuvAuEe6yXOLWb72A@mail.gmail.com>
	<79c59408-f40a-e6e0-2165-cad353ba9030@mail.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Aug 2018 17:16:25 +0100
Message-ID: <CAJSP0QV51O+vB6hwWOxn4xx65Vq09JyRGNjxGEfN4zb1mxCQGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Julia Suvorova <jusual@mail.ru>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Wed, Aug 8, 2018 at 10:46 AM, Julia Suvorova <jusual@mail.ru> wrote:
> On 08.08.2018 12:09, Stefan Hajnoczi wrote:
>>
>> On Mon, Aug 6, 2018 at 11:01 AM, Steffen G=C3=B6rtz
>> <contrib@steffen-goertz.de> wrote:
>>>
>>> +#define PAGE_SIZE           1024
>>> +#define FLASH_SIZE          (256 * PAGE_SIZE)
>>> +#define FLASH_BASE          0x00000000
>>> +#define UICR_BASE           0x10001000
>>> +#define UICR_SIZE           0x100
>>> +#define NVMC_BASE           0x4001E000UL
>>> +#define NVMC_READY          0x400
>>> +#define NVMC_CONFIG         0x504
>>> +#define NVMC_ERASEPAGE      0x508
>>> +#define NVMC_ERASEPCR1      0x508
>>> +#define NVMC_ERASEALL       0x50C
>>> +#define NVMC_ERASEPCR0      0x510
>>> +#define NVMC_ERASEUICR      0x514
>>
>>
>> All these constants could live in include/hw/arm/nrf51.h.  That way
>> tests do not need to duplicate them.  As more devices are implemented
>> we can expect this list to grow.
>
>
> Maybe it's better to move them to device headers?
> include/hw/arm/nrf51.h has to include them in any case to use device
> types.

That would be fine.  Each device (uart, rng, etc) would have it's own
include/hw/... header file and test cases can include that file to get
the constants/structs.

Stefan
