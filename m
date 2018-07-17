Received: from eggs.gnu.org ([2001:4830:134:3::10]:49256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7295ac877=Alistair.Francis@wdc.com>)
	id 1ffWZg-00089H-EJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7295ac877=Alistair.Francis@wdc.com>)
	id 1ffWZd-0005R0-8D
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:27:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7295ac877=Alistair.Francis@wdc.com>)
	id 1ffWZc-0005Py-Ma
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:27:53 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue, 17 Jul 2018 13:27:37 -0700
Message-Id: <cover.1531859179.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/5]  riscv: Fix introspection problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, thuth@redhat.com, mjc@sifive.com

This is based on Thomas's work fixing introspection problems [1] and
applied to the RISC-V port.

1: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03261.html

Alistair Francis (5):
  sifive_e: Fix crash when introspecting the device
  sifive_u: Fix crash when introspecting the device
  virt: Fix crash when introspecting the device
  riscv_hart: Fix crash when introspecting the device
  spike: Fix crash when introspecting the device

 hw/riscv/riscv_hart.c |  7 +++----
 hw/riscv/sifive_e.c   | 12 ++++++------
 hw/riscv/sifive_u.c   | 15 +++++++--------
 hw/riscv/spike.c      | 10 ++++------
 hw/riscv/virt.c       |  5 ++---
 5 files changed, 22 insertions(+), 27 deletions(-)

-- 
2.17.1
