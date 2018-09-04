Received: from eggs.gnu.org ([2001:4830:134:3::10]:57759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXY-0008Vn-Pv
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXT-0001pS-Om
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:20 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXR-0001cF-Qh
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:15 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue,  4 Sep 2018 16:14:33 -0700
Message-Id: <20180904231442.18932-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/9] riscv-pullreq queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd241557452:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-pullreq-20180904

for you to fetch changes up to 3b18c3fa870f11b8a1841bb7537e5bc11100160c:

  riscv: remove define cpu_init() (2018-09-04 13:24:39 -0700)

----------------------------------------------------------------
A misc collection of RISC-V related patches for 3.1.

----------------------------------------------------------------
Alistair Francis (2):
      hw/riscv/virtio: Set the soc device tree node as a simple-bus
      hw/riscv/spike: Set the soc device tree node as a simple-bus

Emilio G. Cota (2):
      target/riscv: optimize indirect branches
      target/riscv: call gen_goto_tb on DISAS_TOO_MANY

Igor Mammedov (1):
      riscv: remove define cpu_init()

Michael Clark (4):
      RISC-V: Update address bits to support sv39 and sv48
      RISC-V: Improve page table walker spec compliance
      RISC-V: Use atomic_cmpxchg to update PLIC bitmaps
      RISC-V: Simplify riscv_cpu_local_irqs_pending

 hw/riscv/sifive_plic.c         | 49 ++++++++++-----------
 hw/riscv/spike.c               |  2 +-
 hw/riscv/virt.c                |  2 +-
 include/hw/riscv/sifive_plic.h |  1 -
 target/riscv/cpu.h             |  9 ++--
 target/riscv/cpu_bits.h        |  2 -
 target/riscv/helper.c          | 98 ++++++++++++++++++++++++------------------
 target/riscv/translate.c       |  9 +---
 8 files changed, 87 insertions(+), 85 deletions(-)
