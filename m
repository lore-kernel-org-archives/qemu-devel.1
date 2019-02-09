Received: from eggs.gnu.org ([209.51.188.92]:49331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsGzh-0004zg-E3
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 19:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsGzd-00060o-Im
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 19:59:44 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 9 Feb 2019 00:59:19 +0000
Message-ID: <cover.1549673900.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 00/11]  Upstream RISC-V fork patches, part 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

Based-on: <20190130173601.3268-1-palmer@sifive.com>

Alistair Francis (2):
  riscv: Ensure the kernel start address is correctly cast
  riscv: pmp: Log pmp access errors as guest errors

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
 hw/riscv/sifive_e.c         |   2 +-
 hw/riscv/sifive_plic.c      |  19 +++-
 hw/riscv/sifive_u.c         |   2 +-
 hw/riscv/spike.c            |   2 +-
 hw/riscv/virt.c             |   2 +-
 include/elf.h               |  10 +++
 linux-user/riscv/cpu_loop.c |  15 +++-
 target/riscv/cpu.h          |   6 ++
 target/riscv/cpu_helper.c   | 168 +++++++++++++++---------------------
 target/riscv/cpu_user.h     |   3 +-
 target/riscv/csr.c          |  22 ++---
 target/riscv/pmp.c          |  20 +++--
 target/riscv/trace-events   |   2 +
 15 files changed, 148 insertions(+), 264 deletions(-)
 create mode 100644 target/riscv/trace-events

--=20
2.20.1
