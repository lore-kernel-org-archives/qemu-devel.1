Received: from eggs.gnu.org ([2001:4830:134:3::10]:38938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDNwB-0003y4-8R
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDNwA-0001w5-0h
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:07:07 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:43667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDNw9-0001sT-M4
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:07:05 -0400
Received: by mail-pg1-x52b.google.com with SMTP id d8-v6so4085495pgv.10
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 23:07:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Oct 2018 23:06:39 -0700
Message-Id: <20181019060656.7968-5-richard.henderson@linaro.org>
In-Reply-To: <20181019060656.7968-1-richard.henderson@linaro.org>
References: <20181019060656.7968-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 04/21] tcg: plug holes in struct TCGProfile
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

This plugs two 4-byte holes in 64-bit.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20181010144853.13005-4-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.2
