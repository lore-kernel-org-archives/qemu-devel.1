Received: from eggs.gnu.org ([2001:4830:134:3::10]:41819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1em9rv-0007l9-Ev
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 22:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1em9rq-0004co-Gn
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 22:05:55 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1em9rq-0004b2-78
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 22:05:50 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 14 Feb 2018 22:05:46 -0500
Message-Id: <1518663946-2326-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] target/hppa: use tb_cflags() to access
 tb->cflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6499b39..b4b74a8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2075,7 +2075,7 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
         /* FIXME: Respect PSW_S bit.  */
         nullify_over(ctx);
         tmp = dest_gpr(ctx, rt);
-        if (ctx->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
             gen_helper_read_interval_timer(tmp);
             gen_io_end();
-- 
2.7.4
