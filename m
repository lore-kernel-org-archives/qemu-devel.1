Received: from eggs.gnu.org ([2001:4830:134:3::10]:45008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhKS-0000WY-LB
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhKP-0007uM-Ds
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:16:24 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 19 Dec 2018 19:16:13 +0000
Message-ID: <cover.1545246859.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 00/23]  Add RISC-V TCG backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>

This patch set adds RISC-V backend support to QEMU. This is based on
Michael Clark's original work with extra work on top.

This has been somewhat tested and can run other architecture softmmu
code. It seems that any complex OS will eventually hang, but we can
run the BIOS and OS startup code for a number of different operating
systems.

I haven't tested linux user support at all yet. I think Michael had that
working reliably though and hopefully my changes haven't broken it.

There are still some todos in the code (there are missing instructions
and byte swapping) but these should assert instead of generating invalid
code.

This branch can be found here:
https://github.com/alistair23/qemu/tree/mainline/alistair/tcg-backend-upstr=
eam.next

v2:
 - define TCG_TARGET_HAS_MEMORY_BSWAP
 - Fix new TCG MAINTAINERS entry
 - Rebase ontop of Richard's patch_reloc() changes
v1:
 - Fix long jump with slowpath load/stores
RFC v3:
 - Update the MAINTAINERS file
 - Enusre that RISC-V 32-bit works
 - More changes based on Richard's feedback and contributions
RFC v2:
 - A large number of changes based on Richard's feedback

Alistair Francis (23):
  elf.h: Add the RISCV ELF magic numbers
  linux-user: Add host dependency for RISC-V 32-bit
  linux-user: Add host dependency for RISC-V 64-bit
  exec: Add RISC-V GCC poison macro
  riscv: Add the tcg-target header file
  riscv: Add the tcg target registers
  riscv: tcg-target: Add support for the constraints
  riscv: tcg-target: Add the immediate encoders
  riscv: tcg-target: Add the instruction emitters
  riscv: tcg-target: Add the relocation functions
  riscv: tcg-target: Add the mov and movi instruction
  riscv: tcg-target: Add the extract instructions
  riscv: tcg-target: Add the out load and store instructions
  riscv: tcg-target: Add the add2 and sub2 instructions
  riscv: tcg-target: Add branch and jump instructions
  riscv: tcg-target: Add slowpath load and store instructions
  riscv: tcg-target: Add direct load and store instructions
  riscv: tcg-target: Add the out op decoder
  riscv: tcg-target: Add the prologue generation and register the JIT
  riscv: tcg-target: Add the target init code
  tcg: Add RISC-V cpu signal handler
  dias: Add RISC-V support
  configure: Add support for building RISC-V host

 MAINTAINERS                       |   12 +-
 accel/tcg/user-exec.c             |   75 ++
 configure                         |   12 +-
 disas.c                           |   10 +-
 include/elf.h                     |   55 +
 include/exec/poison.h             |    1 +
 linux-user/host/riscv32/hostdep.h |   11 +
 linux-user/host/riscv64/hostdep.h |   11 +
 tcg/riscv/tcg-target.h            |  177 +++
 tcg/riscv/tcg-target.inc.c        | 1946 +++++++++++++++++++++++++++++
 10 files changed, 2305 insertions(+), 5 deletions(-)
 create mode 100644 linux-user/host/riscv32/hostdep.h
 create mode 100644 linux-user/host/riscv64/hostdep.h
 create mode 100644 tcg/riscv/tcg-target.h
 create mode 100644 tcg/riscv/tcg-target.inc.c

--=20
2.19.1
