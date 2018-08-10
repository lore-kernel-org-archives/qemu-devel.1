Received: from eggs.gnu.org ([2001:4830:134:3::10]:51900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo3LD-0000vH-Nd
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo3LC-0008KN-85
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:04:15 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fo3LC-0008Jq-2I
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:04:14 -0400
Received: by mail-oi0-x242.google.com with SMTP id q11-v6so14583920oic.12
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 02:04:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fd82c9db-1ecd-a833-8eab-0060647c2220@amsat.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-11-peter.maydell@linaro.org>
	<b16ded66-e814-43f4-389f-65e697660740@amsat.org>
	<fd82c9db-1ecd-a833-8eab-0060647c2220@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Aug 2018 10:03:52 +0100
Message-ID: <CAFEAcA_tVngNnDEgbeg4wobzJLsHHMKyv8=yDRb_TQSBUOg9_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 10/16] hw/dma/pl080: Allow use
 as embedded-struct device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 10 August 2018 at 06:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 08/10/2018 02:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 08/09/2018 10:01 AM, Peter Maydell wrote:
>>> Create a new include file for the pl081's device struct,
>>> type macros, etc, so that it can be instantiated using
>>> the "embedded struct" coding style.
> [...]
>>> +#ifndef HW_DMA_PL080_H
>>> +#define HW_DMA_PL080_H
>>> +
>>> +#include "hw/sysbus.h"
>>> +
>>> +#define PL080_MAX_CHANNELS 8
>>> +
>>> +typedef struct {
>>> +    uint32_t src;
>>> +    uint32_t dest;
>>> +    uint32_t lli;
>>> +    uint32_t ctrl;
>>> +    uint32_t conf;
>>> +} pl080_channel;
>>> +
>>> +#define TYPE_PL080 "pl080"
>>> +#define TYPE_PL081 "pl081"
>>> +#define PL080(obj) OBJECT_CHECK(PL080State, (obj), TYPE_PL080)
>>
>> The PL080() macro can stay in the source.
>
> Oh this respect the "coding style" indeed.

Yes.

> Can you add the PL081() companion? Thanks.

No, because the PL081 has no separate data structure
and there is no PL081State* for a PL081() macro to
be casting to.

thanks
-- PMM
