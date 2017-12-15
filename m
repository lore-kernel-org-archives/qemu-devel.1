Received: from eggs.gnu.org ([2001:4830:134:3::10]:60319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePtSg-0001XX-LF
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePtSd-0002z2-Kn
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:50 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:40225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ePtSd-0002yY-Et
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:47 -0500
Received: by mail-it0-x241.google.com with SMTP id f190so20452322ita.5
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 09:07:47 -0800 (PST)
Received: from cloudburst.twiddle.net (141-126-166-226.dhcp.chtrptr.net.
	[141.126.166.226]) by smtp.gmail.com with ESMTPSA id
	k23sm4012974iti.22.2017.12.15.09.07.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 15 Dec 2017 09:07:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Dec 2017 11:07:31 -0600
Message-Id: <20171215170732.31125-7-richard.henderson@linaro.org>
In-Reply-To: <20171215170732.31125-1-richard.henderson@linaro.org>
References: <20171215170732.31125-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/7] tcg: Add tcg_signed_cond
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
