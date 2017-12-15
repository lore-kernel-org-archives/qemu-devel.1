Received: from eggs.gnu.org ([2001:4830:134:3::10]:48186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePe16-0007l7-3k
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePe15-00044N-AC
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:38:20 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:44219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePe15-00043q-51
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:38:19 -0500
Received: by mail-it0-x243.google.com with SMTP id b5so15715144itc.3
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 16:38:19 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAKmqyKMAvNeSherLS=NT5TDxV0tJRkaPLAF3vkL+CixDTQ1Rfg@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-4-f4bug@amsat.org>
	<CAKmqyKMSwraSQ1XBuWYi1A2zfcgCKEqRC_PvKkpcH=f=ynDnXA@mail.gmail.com>
	<CAAdtpL5izShurORQ1vpRQQxT6L2QGCwjeQqRhzb+_DYoGrrL3g@mail.gmail.com>
	<CAKmqyKMAvNeSherLS=NT5TDxV0tJRkaPLAF3vkL+CixDTQ1Rfg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 21:38:17 -0300
Message-ID: <CAAdtpL4UnVtKD=z6Ai3D7YutUyAPU8Xn56x4PDXp-DqxQD=Hcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/14] sdhci: use the ldst_le_dma() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Sai Pavan Boddu <saipava@xilinx.com>, Andrey Yurovsky <yurovsky@gmail.com>

> This is rewritten later, why bother setting this here?
>
>>
>>
>>  -        dma_memory_read(&address_space_memory, entry_addr + 2,
>>  -                        (uint8_t *)(&dscr->length), 2);
>>  -        dscr->length = le16_to_cpu(dscr->length);
>>  +        dscr->length = lduw_le_dma(&address_space_memory, entry_addr + 2);
>>
>>
>>  -        dma_memory_read(&address_space_memory, entry_addr + 4,
>>  -                        (uint8_t *)(&dscr->addr), 8);
>
> What about dscr->addr which is set here?

Oops. I'll drop this patch.

>>  -        dscr->attr = le64_to_cpu(dscr->attr);
>>  +        dscr->attr = ldq_le_dma(&address_space_memory, entry_addr + 4);
>>
>> The API is detailled in this file: docs/devel/loads-stores.rst
