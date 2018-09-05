Received: from eggs.gnu.org ([2001:4830:134:3::10]:57400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxfzu-0000m4-3u
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxfzo-0003Gi-Q0
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxfzk-00036Q-PJ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:09:55 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed,  5 Sep 2018 15:09:23 -0700
Message-Id: <20180905220932.6152-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/10] riscv-pullreq queue
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

  git@github.com:alistair23/qemu.git tags/pull-riscv-pullreq-20180905

for you to fetch changes up to 1ca79ece35a5bcdcefb5a2582bc6da91f0640bf2:

  riscv: remove define cpu_init() (2018-09-05 09:58:38 -0700)

----------------------------------------------------------------
A misc collection of RISC-V related patches for 3.1.

----------------------------------------------------------------
Alistair Francis (2):
      hw/riscv/virtio: Set the soc device tree node as a simple-bus
      hw/riscv/spike: Set the soc device tree node as a simple-bus

Emilio G. Cota (3):
      target/riscv: optimize cross-page direct jumps in softmmu
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
 target/riscv/translate.c       | 11 ++---
 8 files changed, 88 insertions(+), 86 deletions(-)
