Received: from eggs.gnu.org ([209.51.188.92]:46975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go65n-0003KN-2x
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go65l-0006m8-0z
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:32:46 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go65i-0006gg-Bq
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:32:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id u16so14442056otk.8
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20190124140519.13838-1-clg@kaod.org>
In-Reply-To: <20190124140519.13838-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 12:32:26 +0000
Message-ID: <CAFEAcA8jkXJNGrhm7W8-n3SzJRcAuHRENN_gSsuEyBwCZ53dJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] aspeed/smc: add fast read support
 under User command mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Thu, 24 Jan 2019 at 14:08, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> When in the User command mode, the Aspeed SMC controller driver
> performs the dummy cycles of a fast read command using byte transfers,
> that is ony byte for eight cycles. But, the QEMU m25p80 models one
> dummy cycle with one byte transfer.
>
> To restore the correct number of cycles, this series adds a function
> snooping the SPI transfers to catch commands requiring dummy cycles
> and replaces them with byte transfers compatible with the m25p80 model.
>
> Thanks,
>
> C.
>
> C=C3=A9dric Le Goater (4):
>   aspeed/smc: fix default read value
>   aspeed/smc: define registers for all possible CS
>   aspeed/smc: Add dummy data register
>   aspeed/smc: snoop transfers to fake dummy cycles


Applied to target-arm.next, thanks.

-- PMM
