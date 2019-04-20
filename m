Received: from eggs.gnu.org ([209.51.188.92]:43599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrNi-000254-KZ
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL7-0001AM-5k
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:37 -0400
Received: from m12-13.163.com ([220.181.12.13]:58199)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL4-00015s-SS
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:37 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 20 Apr 2019 07:51:17 -0700
Message-Id: <20190420145120.122847-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 0/3] hw: edu: some fixes
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

Li Qiang (3):
  edu: mmio: set 'max_access_size' to 8
  edu: mmio: allow mmio read dispatch accept 8 bytes
  edu: uses uint64_t in dma operation

 hw/misc/edu.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.17.1
