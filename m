Received: from eggs.gnu.org ([209.51.188.92]:58494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfFs-0005kW-Dn
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmezy-00028Z-1y
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:24:52 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmezr-0001vS-UG
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:24:46 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so5149777ota.12
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20190121154928.32065-1-clg@kaod.org>
In-Reply-To: <20190121154928.32065-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 13:24:21 +0000
Message-ID: <CAFEAcA-n-5GVpnKn_w03bJUR2Wxf=vCtyeXt1GK=PKEzvahTMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] aspeed/smc: snoop SPI transfers to fake
 dummy cycles
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Francisco Iglesias <frasse.iglesias@gmail.com>

On Mon, 21 Jan 2019 at 15:49, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The m25p80 models dummy cycles using byte transfers. This works well
> when the transfers are initiated by the QEMU model of a SPI controller
> but when these are initiated by the OS, it breaks emulation.
>
> Snoop the SPI transfer to catch commands requiring dummy cycles and
> replace them with byte transfers compatible with the m25p80 model.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

This fails to compile:

/home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c: In
function =E2=80=98aspeed_smc_do_snoop=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c:646:42:
error: =E2=80=98R_DUMMY_DATA=E2=80=99 undeclared (first use in this functio=
n)
             ssi_transfer(s->spi, s->regs[R_DUMMY_DATA] & 0xff);
                                          ^
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c:646:42:
note: each undeclared identifier is reported only once for each
function it appears in
/home/petmay01/linaro/qemu-from-laptop/qemu/rules.mak:69: recipe for
target 'hw/ssi/aspeed_smc.o' failed

Is it dependent on some other patch ?

thanks
-- PMM
