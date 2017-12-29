Received: from eggs.gnu.org ([2001:4830:134:3::10]:42812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NK-0000lx-Jk
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NJ-0000K8-RS
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:26 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eV0NJ-0000Iq-MF
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:25 -0500
Received: by mail-pf0-x241.google.com with SMTP id n6so22426727pfa.4
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 11:31:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Dec 2017 11:31:11 -0800
Message-Id: <20171229193113.11753-7-richard.henderson@linaro.org>
In-Reply-To: <20171229193113.11753-1-richard.henderson@linaro.org>
References: <20171229193113.11753-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 6/8] tcg: Add tcg_signed_cond
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Complimenting the existing tcg_unsigned_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index f25efa9795..8c45f7edbc 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -488,6 +488,12 @@ static inline TCGCond tcg_unsigned_cond(TCGCond c)
     return c & 2 ? (TCGCond)(c ^ 6) : c;
 }
 
+/* Create a "signed" version of an "unsigned" comparison.  */
+static inline TCGCond tcg_signed_cond(TCGCond c)
+{
+    return c & 4 ? (TCGCond)(c ^ 6) : c;
+}
+
 /* Must a comparison be considered unsigned?  */
 static inline bool is_unsigned_cond(TCGCond c)
 {
-- 
2.14.3
