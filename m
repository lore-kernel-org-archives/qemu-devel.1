Received: from eggs.gnu.org ([2001:4830:134:3::10]:44041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWlps-000429-C2
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 11:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWlpp-0004vu-97
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 11:24:12 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 13:23:54 -0300
Message-Id: <20180103162400.10396-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/6] SDHCI: convert legacy devices to the SDBus
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Stefan Weil <sw@weilnetz.de>

Hi,

This series convert 3 devices using the legacy SDCard API to the SDBus API:
- milkymist-mmc
- pl181
- ssi-sd

Then move the legacy API to a separate header "sdcard_legacy.h".

Now the OMAP MMC is the last device using the legacy API, but need to get
QOM'ified first.

Regards,

Phil.

Philippe Mathieu-Daudé (6):
  hw/sd/milkymist-memcard: use qemu_log_mask()
  hw/sd/milkymist-memcard: split realize() out of SysBusDevice init()
  hw/sd/milkymist-memcard: expose a SDBus and connect the SDCard to it
  hw/sd/pl181: expose a SDBus and connect the SDCard to it
  hw/sd/ssi-sd: expose a SDBus and connect the SDCard to it
  hw/sd: move sdcard legacy API to "hw/sd/sdcard_legacy.h"

 include/hw/sd/sd.h            | 17 ----------
 include/hw/sd/sdcard_legacy.h | 51 ++++++++++++++++++++++++++++++
 hw/sd/milkymist-memcard.c     | 72 ++++++++++++++++++++++++++-----------------
 hw/sd/omap_mmc.c              |  2 +-
 hw/sd/pl181.c                 | 28 ++++++++++++-----
 hw/sd/sd.c                    |  1 +
 hw/sd/ssi-sd.c                | 27 +++++++++++-----
 7 files changed, 137 insertions(+), 61 deletions(-)
 create mode 100644 include/hw/sd/sdcard_legacy.h

-- 
2.15.1
