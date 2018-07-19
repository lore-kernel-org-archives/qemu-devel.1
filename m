Received: from eggs.gnu.org ([2001:4830:134:3::10]:38844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSx-0008DU-Ih
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSw-0001HY-3n
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSv-0001Fb-M6
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:42 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 19 Jul 2018 09:07:16 -0700
Message-Id: <20180719160721.18430-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 for 3.0 0/5] riscv-pull queue
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

The following changes since commit e1ea55668ffe6ce558a063f3a9621b761738e1f2:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-07-19 15:38:06 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180719

for you to fetch changes up to 8ff62f6aa067edd5455d60202041b4ae08a65b17:

  spike: Fix crash when introspecting the device (2018-07-19 09:05:48 -0700)

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
