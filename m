Received: from eggs.gnu.org ([2001:4830:134:3::10]:45915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjr-0002no-5w
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjq-0006MI-4E
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:39 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:21 +1100
Message-Id: <20170112020327.24882-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/67] disas/ppc: Fix indefinite articles in
 comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Stefan Weil <sw@weilnetz.de>, David Gibson <david@gibson.dropbear.id.au>

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 disas/ppc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/disas/ppc.c b/disas/ppc.c
index bd05623..9b5a0e7 100644
--- a/disas/ppc.c
+++ b/disas/ppc.c
@@ -1653,11 +1653,11 @@ extract_tbr (unsigned long insn,
 #define BBOYBI_MASK (BBOYCB_MASK | BI_MASK)
 #define BBOATBI_MASK (BBOAT2CB_MASK | BI_MASK)
 
-/* An Context form instruction.  */
+/* A Context form instruction.  */
 #define CTX(op, xop)   (OP (op) | (((unsigned long)(xop)) & 0x7))
 #define CTX_MASK CTX(0x3f, 0x7)
 
-/* An User Context form instruction.  */
+/* A User Context form instruction.  */
 #define UCTX(op, xop)  (OP (op) | (((unsigned long)(xop)) & 0x1f))
 #define UCTX_MASK UCTX(0x3f, 0x1f)
 
@@ -1710,19 +1710,19 @@ extract_tbr (unsigned long insn,
 #define SC(op, sa, lk) (OP (op) | ((((unsigned long)(sa)) & 1) << 1) | ((lk) & 1))
 #define SC_MASK (OP_MASK | (((unsigned long)0x3ff) << 16) | (((unsigned long)1) << 1) | 1)
 
-/* An VX form instruction.  */
+/* A VX form instruction.  */
 #define VX(op, xop) (OP (op) | (((unsigned long)(xop)) & 0x7ff))
 
 /* The mask for an VX form instruction.  */
 #define VX_MASK	VX(0x3f, 0x7ff)
 
-/* An VA form instruction.  */
+/* A VA form instruction.  */
 #define VXA(op, xop) (OP (op) | (((unsigned long)(xop)) & 0x03f))
 
-/* The mask for an VA form instruction.  */
+/* The mask for a VA form instruction.  */
 #define VXA_MASK VXA(0x3f, 0x3f)
 
-/* An VXR form instruction.  */
+/* A VXR form instruction.  */
 #define VXR(op, xop, rc) (OP (op) | (((rc) & 1) << 10) | (((unsigned long)(xop)) & 0x3ff))
 
 /* The mask for a VXR form instruction.  */
-- 
2.9.3
