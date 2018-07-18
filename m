Received: from eggs.gnu.org ([2001:4830:134:3::10]:52645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=730c0c5bd=Alistair.Francis@wdc.com>)
	id 1ffuvf-0001lx-Po
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=730c0c5bd=Alistair.Francis@wdc.com>)
	id 1ffuva-0002Ee-RD
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:28:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=730c0c5bd=Alistair.Francis@wdc.com>)
	id 1ffuva-0002Du-5t
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:28:10 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 18 Jul 2018 15:27:50 -0700
Message-Id: <20180718222755.9014-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/5] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>

The following changes since commit ea6abffa8a08d832feb759d359d5b935e3087cf7:

  Update version for v3.0.0-rc1 release (2018-07-17 18:15:19 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180718-2

for you to fetch changes up to 451ea962be0cbb6710737eeb90c2a801b979cad3:

  spike: Fix crash when introspecting the device (2018-07-18 14:33:40 -0700)

----------------------------------------------------------------
riscv: Fix introspection problems

This is based on Thomas's work fixing introspection problems [1] and
applied to the RISC-V port.

1: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03261.html

----------------------------------------------------------------
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
