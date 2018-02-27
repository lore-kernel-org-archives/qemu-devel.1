Received: from eggs.gnu.org ([2001:4830:134:3::10]:51896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqing-0005It-VQ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqinf-0006Ga-W8
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:12:24 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqinf-0006GB-RJ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:12:23 -0500
Received: by mail-ot0-x242.google.com with SMTP id 108so4468919otv.3
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:12:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227104903.21353-6-linus.walleij@linaro.org>
References: <20180227104903.21353-1-linus.walleij@linaro.org>
	<20180227104903.21353-6-linus.walleij@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 17:12:02 +0000
Message-ID: <CAFEAcA88tabmji-pa6HNBAyx8aXV7cX3z=S0iw-GTW2rBBgMDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/5] arm/vexpress: Add proper display
 connector emulation
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

On 27 February 2018 at 10:49, Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds the SiI9022 and EDID I2C devices to the ARM Versatile
> Express machine, and selects the two I2C devices necessary in the
> arm-softmmy.mak configuration so everything will build smoothly.
>
> I am implementing proper handling of the graphics in the Linux
> kernel and adding proper emulation of SiI9022 and EDID makes the
> driver probe as nicely as before, retrieveing the resolutions
> supported by the "QEMU monitor" and overall just working nice.
>
> The assignment of the SiI9022 at address 0x39 and the EDID
> DDC I2C at address 0x50 is not strictly correct: the DDC I2C
> is there all the time but in the actual component it only
> appears once activated inside the SiI9022, so ideally it should
> be added and removed to the bus by the SiI9022. However for this
> purpose it works fine to just have it around.

This last paragraph in the commit message can just be
removed now the DDC I2C isn't created here, right?

> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Only add the SII9022 now that it will by itself realize
>   the DDCI2C as part of the bridge.
> ---
>  default-configs/arm-softmmu.mak | 2 ++
>  hw/arm/vexpress.c               | 6 +++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

(if this is the only problem with the patchset I'll just fix
it up in my tree)

thanks
-- PMM
