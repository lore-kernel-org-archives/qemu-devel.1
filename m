Received: from eggs.gnu.org ([2001:4830:134:3::10]:56520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqj25-0007HG-07
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqj24-00076V-4T
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:27:17 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:44721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqj23-00076I-V1
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:27:16 -0500
Received: by mail-ot0-x233.google.com with SMTP id 79so4493078oth.11
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:27:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227104903.21353-1-linus.walleij@linaro.org>
References: <20180227104903.21353-1-linus.walleij@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 17:26:54 +0000
Message-ID: <CAFEAcA9h9VjyS7QjHiRkYwThGyK0NErWSPxMGD=iRT82qECi8Q@mail.gmail.com>
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
To: Linus Walleij <linus.walleij@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Corey Minyard <cminyard@mvista.com>

On 27 February 2018 at 10:48, Linus Walleij <linus.walleij@linaro.org> wrote:
> This series adds proper display bridge/connector emulation
> for the Versatile Express, implementing a simple Silicon
> Image 9022 emulation spawning a DDC I2C child.
>
> After the series the Versatile Express is successfully
> presented the "QEMU monitor" through DDC I2C.
>
> The series includes two refactorings from Corey and a
> minor bug fix for the i2c-ddc so that everything is smoothly
> integrated.
>
> Corey Minyard (2):
>   i2c: Fix some brace style issues
>   i2c: Move the bus class to i2c.h
>
> Linus Walleij (3):
>   hw/i2c-ddc: Do not fail writes
>   hw/sii9022: Add support for Silicon Image SII9022
>   arm/vexpress: Add proper display connector emulation

Hi; I've applied this to target-arm.next with the tweak to
the commit message of patch 5 and the reset function in patch 4.
Let me know if you think those are wrong or you'd prefer to
respin the series yourself.

thanks
-- PMM
