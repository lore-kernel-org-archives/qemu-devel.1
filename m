Received: from eggs.gnu.org ([2001:4830:134:3::10]:52539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFa-0004sq-3j
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFX-00028k-17
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 20:39:07 -0300
Message-Id: <20170508233918.9043-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/11] various easy cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

various easy patchs added while coding around:
- remove old comments
- add/remove includes
- use TYPE_ names when available
- use ARRAY_SIZE() macro

Philippe Mathieu-Daudé (11):
  hw/net: removed obsolete comments
  hw/pci: define msi_nonbroken in pci-stub
  hw/misc: add missing includes
  ide/ahci: add missing includes
  hw/mips: add missing include
  hw/arm: removed unnecessary include
  hw/arm: use defined type name instead of hard-coded string.
  hw/sparc: use ARRAY_SIZE() macro
  target/sparc: fix DEBUG_MMU DPRINTF() arguments
  register: display register prefix (name) since it is available
  MAINTAINERS: self-appoint me as reviewer of the Register API

 MAINTAINERS                |  1 +
 hw/arm/armv7m.c            |  4 ++--
 hw/arm/exynos4210.c        |  4 ++--
 hw/arm/highbank.c          | 11 +++++++----
 hw/arm/realview.c          |  6 ++++--
 hw/arm/vexpress.c          |  6 ++++--
 hw/arm/xilinx_zynq.c       | 14 ++++++++------
 hw/core/register.c         |  8 ++++----
 hw/net/pcnet-pci.c         | 10 ----------
 hw/pci/pci-stub.c          |  3 +++
 hw/sparc64/sun4u.c         |  2 +-
 include/hw/arm/arm.h       |  1 -
 include/hw/ide/ahci.h      |  2 ++
 include/hw/mips/mips.h     |  1 +
 include/hw/misc/unimp.h    |  3 +++
 target/sparc/ldst_helper.c |  4 ++--
 16 files changed, 44 insertions(+), 36 deletions(-)

-- 
2.11.0
