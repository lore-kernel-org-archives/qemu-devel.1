Received: from eggs.gnu.org ([209.51.188.92]:51049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC72-0003Ie-LL
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC71-0008S8-RT
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:57:48 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 14 Jan 2019 23:57:41 +0000
Message-ID: <cover.1547510220.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 0/8]  Upstream RISC-V fork patches, part 3
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


Alistair Francis (1):
  RISC-V: Add priv_ver to DisasContext

Michael Clark (5):
  RISC-V: Implement mstatus.TSR/TW/TVM
  RISC-V: Use riscv prefix consistently on cpu helpers
  RISC-V: Add misa to DisasContext
  RISC-V: Add misa.MAFD checks to translate
  RISC-V: Add misa runtime write support

Richard Henderson (2):
  RISC-V: Split out mstatus_fs from tb_flags
  RISC-V: Mark mstatus.fs dirty

 linux-user/riscv/signal.c |   4 +-
 target/riscv/cpu.c        |   2 +-
 target/riscv/cpu.h        |  31 ++--
 target/riscv/cpu_bits.h   |  11 ++
 target/riscv/cpu_helper.c |  10 +-
 target/riscv/csr.c        |  91 +++++++++---
 target/riscv/fpu_helper.c |   6 +-
 target/riscv/op_helper.c  |  47 ++++--
 target/riscv/translate.c  | 292 ++++++++++++++++++++++++++++++++------
 9 files changed, 388 insertions(+), 106 deletions(-)

--=20
2.19.1
