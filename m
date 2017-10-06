Received: from eggs.gnu.org ([2001:4830:134:3::10]:38684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0UKU-0002SG-2T
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0UKT-0006za-8j
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:14:22 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:45121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0UKT-0006yN-2B
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:14:21 -0400
Received: by mail-wm0-x22c.google.com with SMTP id q124so8251533wmb.0
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 08:14:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170920070135.31379-1-clg@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 16:13:59 +0100
Message-ID: <CAFEAcA9Avqgbm7sZTKuex9dOp-1wzw0Moa8XVvXw5GZjSeC5Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] aspeed: add a witherspoon-bmc
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 20 September 2017 at 08:01, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello,
>
> This series adds a new Aspeed machine to emulate the BMC of a
> Witherspoon system. It also extends the other Aspeed machines with I2C
> devices and adds a simple model for the pca9552 LED blinker present on
> the witherspoon board.
>
> Thanks,
>
> C.
>
> Changes since v1:
>
>  - introduced smbus_eeprom_init_one()
>
> C=C3=A9dric Le Goater (6):
>   aspeed: add support for the witherspoon-bmc board
>   aspeed: add an I2C RTC device to all machines
>   smbus: add a smbus_eeprom_init_one() routine
>   aspeed: Add EEPROM I2C devices
>   misc: add pca9552 LED blinker model
>   aspeed: add the pc9552 chips to the witherspoon machine

Hi -- I've made a couple of review comments and nothing else
leapt out as obviously wrong, but I'm hoping that somebody more
familiar with the aspeed devices will do review...

thanks
-- PMM
