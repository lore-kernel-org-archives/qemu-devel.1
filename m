Received: from eggs.gnu.org ([2001:4830:134:3::10]:33245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4u1-0000Qs-0p
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4tw-0004zO-Ue
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43571)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4tw-0004wi-MA
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:04 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:23 -0500
Message-Id: <20181209193749.12277-13-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 12/38] tcg: add MO_HADDR to TCGMemOp
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

We will use this from plugins to mark mem accesses so that
we can later obtain their host address.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6fd525023b..a376f83ab6 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -359,6 +359,13 @@ typedef enum TCGMemOp {
     MO_ALIGN_32 = 5 << MO_ASHIFT,
     MO_ALIGN_64 = 6 << MO_ASHIFT,
 
+    /*
+     * SoftMMU-only: if set, the TCG backend puts the corresponding host address
+     * in CPUArchState.hostaddr.
+     */
+    MO_HSHIFT = MO_ASHIFT + 3,
+    MO_HADDR = 1 << MO_HSHIFT,
+
     /* Combinations of the above, for ease of use.  */
     MO_UB    = MO_8,
     MO_UW    = MO_16,
-- 
2.17.1
