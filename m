Received: from eggs.gnu.org ([2001:4830:134:3::10]:45702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvW-0003va-Tc
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvS-00070t-SU
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:47 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:59221)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvS-00070a-Mx
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:42 -0400
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
	by Forcepoint Email with ESMTPS id 5E9DE64595B23
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 13:00:38 +0000 (GMT)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Mar 2017 13:00:22 +0000
Message-ID: <1490014826-4472-7-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
References: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL for v2.9 06/10] target/mips: fix delay slot
 detection in gen_msa_branch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

It is unnecessary to test R6 from delay/forbidden slot check
in gen_msa_branch().

https://bugs.launchpad.net/qemu/+bug/1663287

Reported-by: Brian Campbell <bacam@z273.org.uk>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 78b7264..3022f34 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -18162,7 +18162,7 @@ static void gen_msa_branch(CPUMIPSState *env, DisasContext *ctx, uint32_t op1)
 
     check_msa_access(ctx);
 
-    if (ctx->insn_flags & ISA_MIPS32R6 && ctx->hflags & MIPS_HFLAG_BMASK) {
+    if (ctx->hflags & MIPS_HFLAG_BMASK) {
         generate_exception_end(ctx, EXCP_RI);
         return;
     }
-- 
2.7.4
