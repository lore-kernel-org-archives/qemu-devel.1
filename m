Received: from eggs.gnu.org ([2001:4830:134:3::10]:54271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqivJ-0001wm-VH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqivG-0003Nm-6z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:20:17 -0500
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:35313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqivG-0003NL-1K
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:20:14 -0500
Received: by mail-ot0-x22e.google.com with SMTP id w2so1924053otg.2
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:20:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227104903.21353-5-linus.walleij@linaro.org>
References: <20180227104903.21353-1-linus.walleij@linaro.org>
	<20180227104903.21353-5-linus.walleij@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 17:19:52 +0000
Message-ID: <CAFEAcA9YnM9uKvdce8PrDLBYVaSiW07_9z0E0Moe0RZnxpeRrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5] hw/sii9022: Add support for Silicon
 Image SII9022
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
> This adds support for emulating the Silicon Image SII9022 DVI/HDMI
> bridge. It's not very clever right now, it just acknowledges
> the switch into DDC I2C mode and back. Combining this with the
> existing DDC I2C emulation gives the right behavior on the Versatile
> Express emulation passing through the QEMU EDID to the emulated
> platform.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

> +typedef struct sii9022_state {
> +    I2CSlave parent_obj;
> +    uint8_t ptr;
> +    bool addr_byte;
> +    bool ddc_req;
> +    bool ddc_skip_finish;
> +    bool ddc;
> +} sii9022_state;

> +static void sii9022_reset(DeviceState *dev)
> +{
> +    sii9022_state *s = SII9022(dev);
> +
> +    s->ptr = 0;
> +    s->addr_byte = false;

I asked about reset before -- can we just add
     s->ddc_req = false;
     s->ddc_skip_finish = false;
     s->ddc = false;

?

thanks
-- PMM
