Received: from eggs.gnu.org ([2001:4830:134:3::10]:41055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cy4LJ-0000Cw-OY
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cy4LF-0005cd-P5
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:32:57 -0400
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com
	([104.47.32.63]:27392
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cy4LF-0005cE-F6
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:32:53 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 11 Apr 2017 15:30:15 -0700
Message-ID: <cover.1491947224.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/5] Improve the Cadence GEM multi-queue
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
Cc: f4bug@amsat.org, alistair.francis@xilinx.com, alistair23@gmail.com

Improve the Cadence GEM multi-queue support. This fixes a few bugs
which were hanging around from the initial implementation.

V3:
 - Remove unessecary call of gem_update_int_status()
V2:
 - Fix up the interrupt updating logic and consolidate all the updates
   to a single function.
 - Improve the debug print information

Alistair Francis (5):
  cadence_gem: Read the correct queue descriptor
  cadence_gem: Correct the multi-queue can rx logic
  cadence_gem: Correct the interupt logic
  cadence_gem: Make the revision a property
  xlnx-zynqmp: Set the Cadence GEM revision

 hw/arm/xlnx-zynqmp.c         |  6 +++++-
 hw/net/cadence_gem.c         | 45 +++++++++++++++++++++++++++++-----------=
----
 include/hw/net/cadence_gem.h |  1 +
 3 files changed, 36 insertions(+), 16 deletions(-)

--=20
2.9.3
