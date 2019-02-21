Received: from eggs.gnu.org ([209.51.188.92]:57887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=948ed6046=Alistair.Francis@wdc.com>)
	id 1gwcSx-0003ux-FY
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=948ed6046=Alistair.Francis@wdc.com>)
	id 1gwcSt-0002I7-IW
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:43:54 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 21 Feb 2019 00:43:10 +0000
Message-ID: <cover.1550709660.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 00/11]  Upstream RISC-V fork patches, part 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>

v2:
 - Add a patch for SiFive U SMP support
 - Rebase on master

Alistair Francis (2):
  riscv: pmp: Log pmp access errors as guest errors
  riscv: sifive_u: Allow up to 4 CPUs to be created

Kito Cheng (1):
  RISC-V: linux-user support for RVE ABI

Michael Clark (8):
  RISC-V: Replace __builtin_popcount with ctpop8 in PLIC
  RISC-V: Allow interrupt controllers to claim interrupts
  RISC-V: Remove unnecessary disassembler constraints
  elf: Add RISC-V PSABI ELF header defines
  RISC-V: Change local interrupts from edge to level
  RISC-V: Add support for vectored interrupts
  RISC-V: Convert trap debugging to trace events
  RISC-V: Update load reservation comment in do_interrupt

 Makefile.objs               |   1 +
 disas/riscv.c               | 138 -----------------------------
 hw/riscv/sifive_plic.c      |  19 +++-
 hw/riscv/sifive_u.c         |   5 +-
 include/elf.h               |  10 +++
 linux-user/riscv/cpu_loop.c |  15 +++-
 target/riscv/cpu.h          |   6 ++
 target/riscv/cpu_helper.c   | 168 +++++++++++++++---------------------
 target/riscv/cpu_user.h     |   3 +-
 target/riscv/csr.c          |  22 ++---
 target/riscv/pmp.c          |  20 +++--
 target/riscv/trace-events   |   2 +
 12 files changed, 148 insertions(+), 261 deletions(-)
 create mode 100644 target/riscv/trace-events

--=20
2.20.1
