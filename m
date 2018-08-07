Received: from eggs.gnu.org ([2001:4830:134:3::10]:40566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fn18k-0004Oi-Rw
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fn18h-00075l-OE
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:31:06 -0400
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:41822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fn18h-00075A-HV
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:31:03 -0400
Received: from player759.ha.ovh.net (unknown [10.109.146.173])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id ABFC6172D05
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 14:31:01 +0200 (CEST)
References: <20180807075757.7242-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fd6f2874-d73e-f0b4-83a2-cbac5c9b3f19@kaod.org>
Date: Tue, 7 Aug 2018 14:30:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180807075757.7242-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] arm: aspeed: Extend SDRAM controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/07/2018 09:57 AM, Joel Stanley wrote:
> This series allow us to run upstream u-boot on the ast2500-evb model.
> They have been tested with upstream u-boot, as well as openbmc's ast250=
0
> and ast2500 images.

For all patches,

Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

Patch [1-6] are good to merge.=20

I think patch 7 is a good start. It enables support for mainline=20
U-Boot that we can use to develop more U-Boot drivers (flash).=20
But the device reset model needs a little more work to take into=20
account the Reset Mask Register of the watchdog.=20

We don't have to support all of them, only the SoC and SDRAM to=20
start with.

Thanks,

C.

>=20
> C=C3=A9dric Le Goater (1):
>   aspeed: add a max_ram_size property to the memory controller
>=20
> Joel Stanley (6):
>   aspeed_sdmc: Extend number of valid registers
>   aspeed_sdmc: Fix saved values
>   aspeed_sdmc: Set 'cache initial sequence' always true
>   aspeed_sdmc: Init status alwlays idle
>   aspeed_sdmc: Handle ECC training
>   aspeed: Link SCU to the watchdog
>=20
>  hw/arm/aspeed.c                  | 31 ++++++++++++++++++
>  hw/arm/aspeed_soc.c              |  4 +++
>  hw/misc/aspeed_sdmc.c            | 55 +++++++++++++++++++++-----------
>  hw/watchdog/wdt_aspeed.c         | 20 ++++++++++++
>  include/hw/misc/aspeed_sdmc.h    |  4 ++-
>  include/hw/watchdog/wdt_aspeed.h |  1 +
>  6 files changed, 95 insertions(+), 20 deletions(-)
>=20
