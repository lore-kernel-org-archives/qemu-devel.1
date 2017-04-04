Received: from eggs.gnu.org ([2001:4830:134:3::10]:35721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cvYcc-0002zd-3g
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cvYcZ-00038K-0f
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:16:26 -0400
Received: from mail-dm3nam03on0085.outbound.protection.outlook.com
	([104.47.41.85]:16256
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cvYcY-00037D-M9
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:16:22 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 4 Apr 2017 16:40:02 -0700
Message-ID: <cover.1491349058.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/5] Improve the Cadence GEM multi-queue
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Improve the Cadence GEM multi-queue support. This fixes a few bugs
which were hanging around from the initial implementation.

Alistair Francis (5):
  cadence_gem: Read the correct queue descriptor
  cadence_gem: Correct the multi-queue can rx logic
  cadence_gem: Only trigger interrupts if the status register is set
  cadence_gem: Make the revision a property
  xlnx-zynqmp: Set the Cadence GEM revision

 hw/arm/xlnx-zynqmp.c         |  6 +++++-
 hw/net/cadence_gem.c         | 30 +++++++++++++++++++-----------
 include/hw/net/cadence_gem.h |  1 +
 3 files changed, 25 insertions(+), 12 deletions(-)

-- 
2.9.3
