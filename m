Received: from eggs.gnu.org ([2001:4830:134:3::10]:60620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwsf-0002TA-B4
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwse-0005Sd-JN
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:13 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Aug 2018 17:27:50 +0930
Message-Id: <20180807075757.7242-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/7] arm: aspeed: Extend SDRAM controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

This series allow us to run upstream u-boot on the ast2500-evb model.
They have been tested with upstream u-boot, as well as openbmc's ast2500
and ast2500 images.

Cédric Le Goater (1):
  aspeed: add a max_ram_size property to the memory controller

Joel Stanley (6):
  aspeed_sdmc: Extend number of valid registers
  aspeed_sdmc: Fix saved values
  aspeed_sdmc: Set 'cache initial sequence' always true
  aspeed_sdmc: Init status alwlays idle
  aspeed_sdmc: Handle ECC training
  aspeed: Link SCU to the watchdog

 hw/arm/aspeed.c                  | 31 ++++++++++++++++++
 hw/arm/aspeed_soc.c              |  4 +++
 hw/misc/aspeed_sdmc.c            | 55 +++++++++++++++++++++-----------
 hw/watchdog/wdt_aspeed.c         | 20 ++++++++++++
 include/hw/misc/aspeed_sdmc.h    |  4 ++-
 include/hw/watchdog/wdt_aspeed.h |  1 +
 6 files changed, 95 insertions(+), 20 deletions(-)

-- 
2.17.1
