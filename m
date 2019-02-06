Received: from eggs.gnu.org ([209.51.188.92]:45397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKpw-0003k8-Fl
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKpv-00006p-K8
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:48 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grKpv-000063-AA
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:47 -0500
Received: by mail-wr1-x42e.google.com with SMTP id l9so6940826wrt.13
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 02:53:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 10:53:35 +0000
Message-Id: <20190206105337.11559-2-richard.henderson@linaro.org>
In-Reply-To: <20190206105337.11559-1-richard.henderson@linaro.org>
References: <20190206105337.11559-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/3] target/hppa: use tb_cflags() to access
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1518663946-2326-1-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ce05d5619d..51bfd9849d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2059,7 +2059,7 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
         /* FIXME: Respect PSW_S bit.  */
         nullify_over(ctx);
         tmp = dest_gpr(ctx, rt);
-        if (ctx->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
             gen_helper_read_interval_timer(tmp);
             gen_io_end();
-- 
2.17.2
