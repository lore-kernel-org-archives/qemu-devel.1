Received: from eggs.gnu.org ([2001:4830:134:3::10]:46315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duJJs-0006wt-86
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duJJn-0006Lx-4i
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:16:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 19 Sep 2017 09:16:03 -0500
Message-Id: <20170919141603.27713-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] ppc/pnv: Improve macro parenthesization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:PowerPC" <qemu-ppc@nongnu.org>

Although none of the existing macro call-sites were broken,
it's always better to write macros that properly parenthesize
arguments that can be complex expressions, so that the intended
order of operations is not broken.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/hw/ppc/pnv_xscom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 3757b2cab9..38077b4796 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -54,7 +54,7 @@ typedef struct PnvXScomInterfaceClass {
  *   PCB SLAVE   0x110Fxxxx
  */

-#define PNV_XSCOM_EX_CORE_BASE(base, i) (base | (((uint64_t)i) << 24))
+#define PNV_XSCOM_EX_CORE_BASE(base, i) ((base) | ((uint64_t)(i) << 24))
 #define PNV_XSCOM_EX_CORE_SIZE    0x100000

 #define PNV_XSCOM_LPC_BASE        0xb0020
-- 
2.13.5
