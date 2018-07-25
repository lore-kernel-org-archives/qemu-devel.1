Received: from eggs.gnu.org ([2001:4830:134:3::10]:56599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSp0-0002AM-1c
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSox-00041Y-1p
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:03:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSow-00041I-CH
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:03:50 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 25 Jul 2018 16:03:35 -0700
Message-Id: <cover.1532559484.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/4]  RISC-V: Populate mtval and stval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair.francis@wdc.com, alistair23@gmail.com

Populate mtval and stval when taking an illegal instruction exception if
the features are set for the CPU.

Alistair Francis (4):
  target/riscv: Rename mbadaddr and sbadaddr
  target/riscv: Implement the mtval illegal instruction
  target/riscv: Implement the stval illegal instruction
  target/riscv: set mtval and stval support

 target/riscv/cpu.c       |  4 ++++
 target/riscv/cpu.h       |  8 +++++---
 target/riscv/cpu_bits.h  |  4 ++--
 target/riscv/helper.c    | 34 ++++++++++++++++++++++++++--------
 target/riscv/op_helper.c | 16 ++++++++--------
 target/riscv/translate.c | 12 ++++++++++++
 6 files changed, 57 insertions(+), 21 deletions(-)

-- 
2.17.1
