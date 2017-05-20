Received: from eggs.gnu.org ([2001:4830:134:3::10]:58933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dBsFF-00048x-Re
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dBsFF-0001Z6-11
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:27:45 -0400
From: Andrew Jeffery <andrew@aj.id.au>
Date: Sat, 20 May 2017 08:26:51 +0800
Message-Id: <20170520002653.20213-1-andrew@aj.id.au>
Subject: [Qemu-devel] [PATCH 0/2] hw/adc: Implement a basic Aspeed ADC model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Ryan Chen <ryan_chen@aspeedtech.com>

Hello,

This short series introduces a basic model for the Aspeed ADC and glues it into
the generic Aspeed SoC definition. The register interface is enhanced slightly
from the AST2400 to the AST2500, but in a backwards-compatible way by making
use of reserved bits. As such I haven't made any effort to differentiate the
two.

The addition of a basic ADC model allows the Aspeed SDK kernel to boot under
QEMU's ast2500-evb machine. The upstream kernel driver doesn't test the
initialisation bit before completing its probe(), and thus doesn't get stuck if
the bit is not set. This is in contrast to the SDK kernel which spins on the
initialisation bit, never making forward progress in the absence of the ADC
model.

Tested with both Aspeed's SDK kernel and upstream Linux.

Cheers,

Andrew

Andrew Jeffery (2):
  hw/adc: Add basic Aspeed ADC model
  hw/arm: Integrate ADC model into Aspeed SoC

 hw/adc/Makefile.objs        |   1 +
 hw/adc/aspeed_adc.c         | 246 ++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/aspeed_soc.c         |  15 +++
 include/hw/adc/aspeed_adc.h |  33 ++++++
 include/hw/arm/aspeed_soc.h |   2 +
 5 files changed, 297 insertions(+)
 create mode 100644 hw/adc/aspeed_adc.c
 create mode 100644 include/hw/adc/aspeed_adc.h

-- 
2.9.3
