Received: from eggs.gnu.org ([2001:4830:134:3::10]:46411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zK-0004RD-Mz
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zF-00031X-B9
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:42 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-000300-P1
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:10 -0400
Message-Id: <1499586614-20507-19-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 18/22] tcg: define TCG_HIGHWATER
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

Will come in handy very soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c19c473..2f003a0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -115,6 +115,8 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 static void tcg_out_tb_init(TCGContext *s);
 static bool tcg_out_tb_finalize(TCGContext *s);
 
+#define TCG_HIGHWATER 1024
+
 static QemuMutex tcg_lock;
 
 /*
@@ -453,7 +455,7 @@ void tcg_prologue_init(TCGContext *s)
     /* Compute a high-water mark, at which we voluntarily flush the buffer
        and start over.  The size here is arbitrary, significantly larger
        than we expect the code generation for any one opcode to require.  */
-    s->code_gen_highwater = s->code_gen_buffer + (total_size - 1024);
+    s->code_gen_highwater = s->code_gen_buffer + (total_size - TCG_HIGHWATER);
 
     tcg_register_jit(s->code_gen_buffer, total_size);
 
-- 
2.7.4
