Received: from eggs.gnu.org ([2001:4830:134:3::10]:35868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkZJ-0002x2-3m
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkZF-0003Ya-Uc
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:06:53 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 27 Nov 2018 21:06:36 +0000
Message-ID: <cover.1543352682.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v2 00/24]  Add RISC-V TCG backend support
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


Alistair Francis (24):
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
  riscv: tcg-target: Add branch and jump instructions
  riscv: tcg-target: Add slowpath load and store instructions
  riscv: tcg-target: Add direct load and store instructions
  riscv: tcg-target: Add the out op decoder
  riscv: tcg-target: Add the prologue generation and register the JIT
  riscv: tcg-target: Add the target init code
  tcg: Add RISC-V cpu signal handler
  dias: Add RISC-V support
  configure: Add support for building RISC-V host
  WIP: Add missing instructions
  WIP: Try to patch longer branches

 accel/tcg/user-exec.c             |   75 ++
 configure                         |   12 +-
 disas.c                           |   10 +-
 include/elf.h                     |   55 +
 include/exec/poison.h             |    1 +
 linux-user/host/riscv32/hostdep.h |   11 +
 linux-user/host/riscv64/hostdep.h |   11 +
 tcg/riscv/tcg-target.h            |  173 +++
 tcg/riscv/tcg-target.inc.c        | 1890 +++++++++++++++++++++++++++++
 9 files changed, 2234 insertions(+), 4 deletions(-)
 create mode 100644 linux-user/host/riscv32/hostdep.h
 create mode 100644 linux-user/host/riscv64/hostdep.h
 create mode 100644 tcg/riscv/tcg-target.h
 create mode 100644 tcg/riscv/tcg-target.inc.c

--=20
2.19.1
