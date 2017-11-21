Received: from eggs.gnu.org ([2001:4830:134:3::10]:53960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHG55-0004Jl-Hb
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHG54-0007g6-OL
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:47 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:44105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHG54-0007fj-HT
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:46 -0500
Received: by mail-wm0-x244.google.com with SMTP id r68so6352420wmr.3
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:27:46 -0800 (PST)
Received: from cloudburst.twiddle.net
	(70.red-37-158-60.dynamicip.rima-tde.net. [37.158.60.70])
	by smtp.gmail.com with ESMTPSA id
	e124sm706517wmg.34.2017.11.21.13.27.44 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 Nov 2017 13:27:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 21 Nov 2017 22:25:15 +0100
Message-Id: <20171121212534.5177-8-richard.henderson@linaro.org>
In-Reply-To: <20171121212534.5177-1-richard.henderson@linaro.org>
References: <20171121212534.5177-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 07/26] tcg: Add tcg_signed_cond
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Complimenting the existing tcg_unsigned_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 2acebd387a..49d4c5fe05 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -517,6 +517,12 @@ static inline TCGCond tcg_unsigned_cond(TCGCond c)
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
2.13.6
