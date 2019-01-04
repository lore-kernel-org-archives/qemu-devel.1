Received: from eggsout.gnu.org ([209.51.188.92]:39176 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=90010c98c=Alistair.Francis@wdc.com>)
	id 1gfYol-0001jG-DF
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=90010c98c=Alistair.Francis@wdc.com>)
	id 1gfYoi-0003iH-A1
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:23:55 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Fri, 4 Jan 2019 23:23:46 +0000
Message-ID: <cover.1546644177.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 0/3]  Upstream more RISC-V fork patches
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

This is one of the big patches that the RISC-V fork has that we don't.
After this it should be straight forward to upstream the remaining
patches.

Michael Clark (3):
  RISC-V: Implement modular CSR helper interface
  RISC-V: Implement atomic mip/sip CSR updates
  RISC-V: Implement existential predicates for CSRs

 target/riscv/Makefile.objs |   2 +-
 target/riscv/cpu.c         |   6 +
 target/riscv/cpu.h         |  41 +-
 target/riscv/cpu_helper.c  |   7 +-
 target/riscv/csr.c         | 863 +++++++++++++++++++++++++++++++++++++
 target/riscv/gdbstub.c     |  10 +-
 target/riscv/op_helper.c   | 613 +-------------------------
 7 files changed, 933 insertions(+), 609 deletions(-)
 create mode 100644 target/riscv/csr.c

--=20
2.19.1
