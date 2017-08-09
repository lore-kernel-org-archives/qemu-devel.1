Received: from eggs.gnu.org ([2001:4830:134:3::10]:37055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dfKUU-00063U-9c
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dfKUT-00075H-6b
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:29:14 -0400
From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed,  9 Aug 2017 15:58:25 +0930
Message-Id: <20170809062828.3673-1-andrew@aj.id.au>
Subject: [Qemu-devel] [PATCH for 2.11 v2 0/2] wdt_aspeed: Support reset
 width patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org, joel@jms.id.au, f4bug@amsat.org, ryan_chen@aspeedtech.com, openbmc@lists.ozlabs.org

Hello,

These two patches add support for the reset width configuration register in the
Aspeed watchdog. Initially this was just one patch[1], but I've reworked it as
two to explicitly support the varying capabilities between Aspeed SoC versions.

Andrew

[1] http://patchwork.ozlabs.org/patch/796039/

Andrew Jeffery (2):
  watchdog: wdt_aspeed: Add support for the reset width register
  aspeed_soc: Propagate silicon-rev to watchdog

 hw/arm/aspeed_soc.c              |  2 +
 hw/watchdog/wdt_aspeed.c         | 93 +++++++++++++++++++++++++++++++++++-----
 include/hw/watchdog/wdt_aspeed.h |  2 +
 3 files changed, 86 insertions(+), 11 deletions(-)

-- 
2.11.0
