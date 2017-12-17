Received: from eggs.gnu.org ([2001:4830:134:3::10]:58235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQn8p-00089y-Vg
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQn8l-0003e1-OR
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:35:03 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:08 +0300
Message-Id: <4f0fca592e44cdfa50afcb93e9a14dfcb7c2c425.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 03/61] disas/arm: fix 'instuction' typo in
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 disas/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/arm.c b/disas/arm.c
index 9967c45990..dda7b2a943 100644
--- a/disas/arm.c
+++ b/disas/arm.c
@@ -1662,7 +1662,7 @@ print_insn_coprocessor (bfd_vma pc, struct disassemble_info *info, long given,
 	}
       else
 	{
-	  /* Only match unconditional instuctions against unconditional
+          /* Only match unconditional instructions against unconditional
 	     patterns.  */
 	  if ((given & 0xf0000000) == 0xf0000000)
 	    {
-- 
2.11.0
