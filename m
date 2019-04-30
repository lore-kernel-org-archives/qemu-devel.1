Received: from eggs.gnu.org ([209.51.188.92]:60567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLKZc-0006bj-3c
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 00:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLKZb-0002by-93
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 00:40:56 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 30 Apr 2019 14:10:33 +0930
Message-Id: <20190430044036.1144-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/2] arm: aspeed: Add RTC Model
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

v3: Add some commit messages, resend as v2 didn't send properly
v2: Minor fixes, added vmstate and reset, and rebased on Cédric's series

Based-on: 20190411161013.4514-4-clg@kaod.org
[PATCH 3/3] aspeed: use sysbus_init_child_obj() to initialize children

A model for the ASPEED BMC real time clock (RTC). The model is sufficient
for running the guest Linux kernel driver, and ticks in time with the
host when programmed.

It does not implement the alarm functionality, which includes the
interrupt.

Joel Stanley (2):
  hw: timer: Add ASPEED RTC device
  hw/arm/aspeed: Add RTC to SoC

 hw/arm/aspeed_soc.c           |  13 +++
 hw/timer/Makefile.objs        |   2 +-
 hw/timer/aspeed_rtc.c         | 180 ++++++++++++++++++++++++++++++++++
 hw/timer/trace-events         |   4 +
 include/hw/arm/aspeed_soc.h   |   2 +
 include/hw/timer/aspeed_rtc.h |  31 ++++++
 6 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 hw/timer/aspeed_rtc.c
 create mode 100644 include/hw/timer/aspeed_rtc.h

-- 
2.20.1
