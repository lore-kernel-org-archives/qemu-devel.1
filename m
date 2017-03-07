Received: from eggs.gnu.org ([2001:4830:134:3::10]:59550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1clHtf-0001c3-Mt
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 11:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1clHtb-0006aB-La
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 11:23:35 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:3620)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1clHtb-0006Wl-FZ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 11:23:31 -0500
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Tue, 7 Mar 2017 16:23:14 +0000
Message-ID: <1488903794-10789-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] target/mips: fix delay slot detection in
 gen_msa_branch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Brian Campbell <bacam@z273.org.uk>

It is unnecessary to test R6 from delay/forbidden slot check
in gen_msa_branch().

https://bugs.launchpad.net/qemu/+bug/1663287

Reported-by: Brian Campbell <bacam@z273.org.uk>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8b4a072..756a9b7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -18169,7 +18169,7 @@ static void gen_msa_branch(CPUMIPSState *env, DisasContext *ctx, uint32_t op1)
 
     check_msa_access(ctx);
 
-    if (ctx->insn_flags & ISA_MIPS32R6 && ctx->hflags & MIPS_HFLAG_BMASK) {
+    if (ctx->hflags & MIPS_HFLAG_BMASK) {
         generate_exception_end(ctx, EXCP_RI);
         return;
     }
-- 
2.7.4
