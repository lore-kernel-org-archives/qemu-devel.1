Received: from eggs.gnu.org ([209.51.188.92]:54869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsPL-0005wJ-1c
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsPK-0008HT-0I
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:00:02 -0400
Received: from m12-11.163.com ([220.181.12.11]:33734)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsPI-0008Dq-Pw
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:00:01 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 20 Apr 2019 08:59:46 -0700
Message-Id: <20190420155949.130968-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 0/3] hw: edu: some fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jslaby@suse.cz, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

Recently I am considering write a driver for edu device.
After reading the spec, I found these three small issue.
Two first two related the MMIO access and the third is
related the DMA operation.

Change since v1:
Fix format compile error on Windows

Li Qiang (3):
  tests: fw_cfg: add splash time test case
  edu: mmio: set 'max_access_size' to 8
  edu: mmio: allow mmio read dispatch accept 8 bytes

 hw/misc/edu.c       | 13 +++++++++++++
 tests/fw_cfg-test.c | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.17.1
