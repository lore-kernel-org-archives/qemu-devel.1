Received: from eggs.gnu.org ([2001:4830:134:3::10]:33240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4u0-0000QY-VT
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4tw-0004zC-Rt
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4tw-0004wY-KO
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:04 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:22 -0500
Message-Id: <20181209193749.12277-12-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 11/38] tcg: add tcg_gen_st_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg-op.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index e2948b10a2..d3c79a6cb2 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1219,6 +1219,11 @@ static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
     glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
 }
 
+static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
+}
+
 static inline void tcg_gen_discard_ptr(TCGv_ptr a)
 {
     glue(tcg_gen_discard_,PTR)((NAT)a);
-- 
2.17.1
