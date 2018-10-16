Received: from eggs.gnu.org ([2001:4830:134:3::10]:36254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gCQsU-0001XE-Iv
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gCQsI-0003pq-LO
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:03:17 -0400
Received: from m12-16.163.com ([220.181.12.16]:48680)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gCQsH-0003XQ-On
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:03:10 -0400
From: Li Qiang <liq3ea@163.com>
Date: Tue, 16 Oct 2018 08:03:00 -0700
Message-Id: <20181016150300.65172-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] pc_init1: fix a typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dc09466b3e..0133668ce2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -111,7 +111,7 @@ static void pc_init1(MachineState *machine,
      *    so legacy non-PAE guests can get as much memory as possible in
      *    the 32bit address space below 4G.
      *
-     *  - Note that Xen has its own ram setp code in xen_ram_init(),
+     *  - Note that Xen has its own ram setup code in xen_ram_init(),
      *    called via xen_hvm_init().
      *
      * Examples:
-- 
2.17.1
