Received: from eggs.gnu.org ([2001:4830:134:3::10]:39223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1er169-0002jn-2N
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1er168-0006bH-AZ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:44:41 -0500
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:38194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1er168-0006aQ-4i
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:44:40 -0500
Received: by mail-it0-x22d.google.com with SMTP id j7so3350649ita.3
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 04:44:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9h9VjyS7QjHiRkYwThGyK0NErWSPxMGD=iRT82qECi8Q@mail.gmail.com>
References: <20180227104903.21353-1-linus.walleij@linaro.org>
	<CAFEAcA9h9VjyS7QjHiRkYwThGyK0NErWSPxMGD=iRT82qECi8Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 28 Feb 2018 13:44:38 +0100
Message-ID: <CACRpkdatS-+MF1+sv3i+DhgCaVwepvc2jntwqe64D8DPEpho_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/5] Versatile Express SiI9022 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Corey Minyard <cminyard@mvista.com>

On Tue, Feb 27, 2018 at 6:26 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 27 February 2018 at 10:48, Linus Walleij <linus.walleij@linaro.org> wrote:
>> This series adds proper display bridge/connector emulation
>> for the Versatile Express, implementing a simple Silicon
>> Image 9022 emulation spawning a DDC I2C child.
>>
>> After the series the Versatile Express is successfully
>> presented the "QEMU monitor" through DDC I2C.
>>
>> The series includes two refactorings from Corey and a
>> minor bug fix for the i2c-ddc so that everything is smoothly
>> integrated.
>>
>> Corey Minyard (2):
>>   i2c: Fix some brace style issues
>>   i2c: Move the bus class to i2c.h
>>
>> Linus Walleij (3):
>>   hw/i2c-ddc: Do not fail writes
>>   hw/sii9022: Add support for Silicon Image SII9022
>>   arm/vexpress: Add proper display connector emulation
>
> Hi; I've applied this to target-arm.next with the tweak to
> the commit message of patch 5 and the reset function in patch 4.
> Let me know if you think those are wrong or you'd prefer to
> respin the series yourself.

I am certain you did it better than I could, thanks a lot.

I forgot about the reset business, sorry :(

I will test it once it hits the trunk!

Yours,
Linus Walleij
