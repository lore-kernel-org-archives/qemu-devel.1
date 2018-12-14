Received: from eggs.gnu.org ([2001:4830:134:3::10]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=879e7201e=Alistair.Francis@wdc.com>)
	id 1gXbBX-0000KE-GL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=879e7201e=Alistair.Francis@wdc.com>)
	id 1gXbBU-0001yr-BM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:18:31 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Fri, 14 Dec 2018 00:18:21 +0000
Message-ID: <cover.1544746653.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 0/5]  Misc RISC-V fixes
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

This series is another go at reducing the diff between the RISC-V fork
(https://github.com/riscv/riscv-qemu/) and mainline QEMU.

This is a small series with only a handful of changes as I don't want to
have to deal with too many conflicts all at once and I don't want to
create too much conflict with the ongoing decode tree work.

Once the decode tree work goes in we can look at rebasing the changes in
the RISC-V fork that touch translate.c.

Michael Clark (4):
  RISC-V: Add hartid and \n to interrupt logging
  RISC-V: Fix CLINT timecmp low 32-bit writes
  RISC-V: Fix PLIC pending bitfield reads
  RISC-V: Enable second UART on sifive_e and sifive_u

Nathaniel Graff (1):
  sifive_uart: Implement interrupt pending register

 hw/riscv/sifive_clint.c        |  8 ++++----
 hw/riscv/sifive_e.c            |  5 ++---
 hw/riscv/sifive_plic.c         |  2 +-
 hw/riscv/sifive_u.c            |  5 ++---
 hw/riscv/sifive_uart.c         | 24 +++++++++++++++++++-----
 include/hw/riscv/sifive_uart.h |  3 +++
 target/riscv/cpu_helper.c      | 18 ++++++++++--------
 7 files changed, 41 insertions(+), 24 deletions(-)

--=20
2.19.1
