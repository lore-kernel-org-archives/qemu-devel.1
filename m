Received: from eggs.gnu.org ([208.118.235.92]:40928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfQSa-0008W4-IK
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfQSV-0000hX-Jr
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:28:28 -0500
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri,  4 Jan 2019 15:28:10 +0100
Message-Id: <20190104142812.20444-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/2] target/microblaze: Add properties to
 enable exceptions on failed bus accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, luc.michel@greensocs.com, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This adds the necessary properties to MicroBlaze cores to enable exceptions
on failed bus accesses. There's no board that acutally uses this yet.

This also adds an unimplemented device to the s3adsp1800 board since I used
that board to test this feature. The s3adsp1800 does not enable the exceptions
by default though, so they remain off.

Cheers,
Edgar

Edgar E. Iglesias (2):
  hw/microblaze: s3adsp1800: Create an unimplemented GPIO area
  target/microblaze: Add props enabling exceptions on failed bus
    accesses

 hw/microblaze/petalogix_s3adsp1800_mmu.c |  4 ++++
 target/microblaze/cpu.c                  | 12 +++++++++++-
 target/microblaze/cpu.h                  |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.17.1
