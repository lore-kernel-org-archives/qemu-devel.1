Received: from eggs.gnu.org ([2001:4830:134:3::10]:51163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpgf-0005nw-13
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpge-0000L5-BJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:09 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cjpge-0000Jj-61
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:08 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Mar 2017 15:50:28 +0000
Message-Id: <1488556233-31246-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9 1/6] disas/hppa: Remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>

Coverity complains (CID 1302705) that the "fr0" part of the ?: in
fput_fp_reg_r() is dead.  This looks like cut-n-paste error from
fput_fp_reg(); delete the dead code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 disas/hppa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index 43facdc..a2d371f 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -1788,8 +1788,7 @@ fput_fp_reg_r (unsigned reg, disassemble_info *info)
   if (reg < 4)
     (*info->fprintf_func) (info->stream, "fpe%d", reg * 2 + 1);
   else
-    (*info->fprintf_func) (info->stream, "%sR",
-			   reg ? fp_reg_names[reg] : "fr0");
+    (*info->fprintf_func) (info->stream, "%sR", fp_reg_names[reg]);
 }
 
 static void
-- 
2.7.4
