Received: from eggs.gnu.org ([2001:4830:134:3::10]:46569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skintigh@gmail.com>) id 1gWCQ1-00022u-SF
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 22:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skintigh@gmail.com>) id 1gWCQ1-000375-5n
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 22:39:41 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:46326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <skintigh@gmail.com>) id 1gWCQ0-00036X-Vd
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 22:39:41 -0500
Received: by mail-oi1-x22a.google.com with SMTP id x202so7857252oif.13
	for <qemu-devel@nongnu.org>; Sun, 09 Dec 2018 19:39:40 -0800 (PST)
MIME-Version: 1.0
From: Seth K <skintigh@gmail.com>
Date: Sun, 9 Dec 2018 22:39:08 -0500
Message-ID: <CAErn8fQO8cwNC8KjkczGwh6L3sTgxyzPX48fVkUdihXW9gHBSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel]  possible bug hw/adc/stm32f2xx_adc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: f4bug@amsat.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Thank you all for help with my last patch. I found one more entry in my
notes that could be a bug, or could be a misunderstanding on my part.

The memory map in DocID15818 (Rev 15) datasheet says:
    ADC1 - ADC2 - ADC3:  0x40012000-0x400123FF

That suggests a size of 0x400 (they share that range?)

Line 279/280 of hw/adc/stm32f2xx_adc.c seems to use 0xFF
memory_region_init_io(&s->mmio, obj, &stm32f2xx_adc_ops, s,
TYPE_STM32F2XX_ADC, 0xFF); Probably just confusion on my part, but thought
I would mention it just in case.
Thanks,
Seth

PS: Sorry if you are all the wrong people to email about this ADC...
