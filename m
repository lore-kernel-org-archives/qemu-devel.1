Received: from eggs.gnu.org ([209.51.188.92]:57527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdo-0004qO-3h
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdj-0001rC-PX
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:14:59 -0400
Received: from m12-13.163.com ([220.181.12.13]:43288)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdj-0001n1-5r
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:14:55 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 20 Apr 2019 09:14:43 -0700
Message-Id: <20190420161446.2274-1-liq3ea@163.com>
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
  edu: mmio: set 'max_access_size' to 8
  edu: mmio: allow mmio read dispatch accept 8 bytes
  edu: uses uint64_t in dma operation

 hw/misc/edu.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

-- 
2.17.1
