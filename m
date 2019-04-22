Received: from eggs.gnu.org ([209.51.188.92]:45081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZwG-0007ul-7i
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgp-0005KX-Ml
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:00 -0400
Received: from m12-12.163.com ([220.181.12.12]:58409)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgo-0005Iv-PQ
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:12:59 -0400
From: Li Qiang <liq3ea@163.com>
Date: Mon, 22 Apr 2019 07:11:53 -0700
Message-Id: <20190422141156.15746-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v3 0/3] hw: edu: some fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jslaby@suse.cz, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, philmd@redhat.com, Li Qiang <liq3ea@163.com>

Recently I am considering write a driver for edu device.
After reading the spec, I found these three small issue.
Two first two related the MMIO access and the third is
related the DMA operation.

Change since v2:
Fix an error in patch 2
Fix some commit message and title.

Change since v1:
Fix format compile error

Li Qiang (3):
  edu: mmio: allow 64-bit access
  edu: mmio: allow 64-bit access in read dispatch
  edu: uses uint64_t in dma operation

 hw/misc/edu.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

-- 
2.17.1
