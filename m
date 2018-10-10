Received: from eggs.gnu.org ([2001:4830:134:3::10]:58921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gAFnU-0002nx-Mj
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gAFnP-0004bf-MV
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gAFnP-0004aZ-F1
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 10 Oct 2018 10:48:52 -0400
Message-Id: <20181010144853.13005-4-cota@braap.org>
In-Reply-To: <20181010144853.13005-1-cota@braap.org>
References: <20181010144853.13005-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/4] tcg: plug holes in struct TCGProfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

This plugs two 4-byte holes in 64-bit.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index f9f12378e9..d80ef2a883 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -633,8 +633,8 @@ typedef struct TCGProfile {
     int64_t tb_count;
     int64_t op_count; /* total insn count */
     int op_count_max; /* max insn per TB */
-    int64_t temp_count;
     int temp_count_max;
+    int64_t temp_count;
     int64_t del_op_count;
     int64_t code_in_len;
     int64_t code_out_len;
-- 
2.17.1
