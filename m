Received: from eggs.gnu.org ([2001:4830:134:3::10]:58964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cQ90N-0004YV-D2
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 03:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cQ90K-0000Nh-BB
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 03:39:07 -0500
From: Marcin Krzeminski <mar.krzeminski@gmail.com>
Date: Sun,  8 Jan 2017 09:38:51 +0100
Message-Id: <20170108083854.5006-1-mar.krzeminski@gmail.com>
Subject: [Qemu-devel] [PATCH v3 0/3] block: m25p80: Improve mt25qu01g chip
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, clg@kaod.org, mar.krzeminski@gmail.com

This series introduce some improvememnt targeting mt25qu01g and adds
support for n25q00 device.

v3:
* Removed debug printf
v2:
* Rework die erase command functionality. Since the number of dies
is constant per chip, new field to flash description structure has
been added (instead of dynamic code from v1).
* Add definition for n25q00.

Marcin Krzeminski (3):
  block: m25p80: Add Quad Page Program 4byte
  block: m25p80: Introduce die erase command
  block: m25p80: Improve 1GiB Micron flash definition

 hw/block/m25p80.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

-- 
2.9.3
