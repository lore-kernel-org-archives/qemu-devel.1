Received: from eggs.gnu.org ([2001:4830:134:3::10]:60545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVdMP-0001ln-4u
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVdMO-0002go-EH
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:41:21 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVdMO-0002gV-9H
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:41:20 -0400
Received: by mail-ot0-x242.google.com with SMTP id h6-v6so3763065otj.0
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:41:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612065716.10587-1-clg@kaod.org>
References: <20180612065716.10587-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:40:59 +0100
Message-ID: <CAFEAcA9KJVw0fuuXY_Ya_F6ELrp-MmgTit4oHU_e0xM+VTdnWA@mail.gmail.com>
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

Is there anybody familiar with the aspeed SoC who'd like to
review? The patches don't look particularly wrong, but I'm
not really in a position to be able to review...

thanks
-- PMM
