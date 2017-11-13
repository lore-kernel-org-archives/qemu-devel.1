Received: from eggs.gnu.org ([2001:4830:134:3::10]:41014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1eE99N-0006ny-Pc
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1eE99K-00009o-L8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:27:21 -0500
From: Stefan Weil <sw@weilnetz.de>
Date: Mon, 13 Nov 2017 08:27:15 +0100
Message-Id: <20171113072715.3443-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH for 2.12] disas/hppa: Fix compiler errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

gcc (Debian 6.3.0-18) 6.3.0 20170516 reports these errors:

disas/hppa.c:2702:20: error:
 left shift of negative value [-Werror=shift-negative-value]
disas/hppa.c:2718:20: error:
 left shift of negative value [-Werror=shift-negative-value]

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

This patch fails with checkpatch.pl because the code uses
tab indention.

 disas/hppa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index a2d371fdb1..0d1e99eab3 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -2699,7 +2699,7 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 		    int disp;
 
 		    if (sign)
-		      disp = (-1 << 10) | imm10;
+		      disp = (UINT_MAX << 10) | imm10;
 		    else
 		      disp = imm10;
 
@@ -2715,7 +2715,7 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 		    int disp;
 
 		    if (sign)
-		      disp = (-1 << 11) | imm11;
+		      disp = (UINT_MAX << 11) | imm11;
 		    else
 		      disp = imm11;
 
-- 
2.11.0
