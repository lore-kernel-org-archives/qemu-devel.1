Received: from eggs.gnu.org ([2001:4830:134:3::10]:45106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dgEaD-00005i-Ho
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dgEaC-0007Pi-1P
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:22:53 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 11 Aug 2017 11:19:17 -0700
Message-ID: <cover.1502474835.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 0/3]  Fixup exclusive store logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, qemu-arm@nongnu.org

I found some issues with the way exclusive store was working. This patch
series seems to fix the test cases that were failing for me and also
seem to follow what the ARM ARM says.

The first patch is just a simple adjustment.

The second patch is just preparing for the third patch.

The third patch is where the big change is. It includes details of the
limited testing that I have done.

Alistair Francis (3):
  target/arm: Update the memops for exclusive load
  tcg/tcg-op: Expose the tcg_gen_ext_i* functions
  target/arm: Correct exclusive store return value

 target/arm/translate-a64.c | 24 +++++++++++++-----------
 tcg/tcg-op.c               |  4 ++--
 tcg/tcg-op.h               |  2 ++
 3 files changed, 17 insertions(+), 13 deletions(-)

-- 
2.11.0
