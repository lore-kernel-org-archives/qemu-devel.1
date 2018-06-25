Received: from eggs.gnu.org ([2001:4830:134:3::10]:50211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXP7Q-00027c-Uq
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXP7Q-0006K3-4k
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:53:13 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXP7P-0006Ji-NR
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:53:12 -0400
Received: by mail-oi0-x243.google.com with SMTP id e8-v6so12043032oii.2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 03:53:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612065716.10587-1-clg@kaod.org>
References: <20180612065716.10587-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 11:52:49 +0100
Message-ID: <CAFEAcA9=kJ0PDoGMkyVGiPMVp-R-G=kxFGkXCWjWaOmwjE75hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] aspeed/smc: small fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>

On 12 June 2018 at 07:57, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello,
>
> Here is a short series of cleanups and fixes for issues in the Aspeed
> SMC controller model discovered when experimenting with the MMIO exec
> feature and also from tests under a QEMU PowerNV machine.
>
> Indeed, the OPAL/skiboot firmware accesses the Aspeed SoC address
> space using the iLPC->AHB bridge of the SuperIO controller and drives
> the SPI controller to access the PNOR.
>
> Thanks,
>
> C.
>
> C=C3=A9dric Le Goater (3):
>   aspeed/smc: fix dummy cycles count when in dual IO mode
>   aspeed/smc: fix HW strapping
>   aspeed/smc: rename aspeed_smc_flash_send_addr() to aspeed_smc_flash_set=
up()



Applied to target-arm.next, thanks.

-- PMM
