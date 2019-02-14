Received: from eggs.gnu.org ([209.51.188.92]:35745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL7E-0004km-TP
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL7E-0004X7-1j
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:48:04 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52328 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1guL7D-0004Iq-Qm
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:48:03 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 14 Feb 2019 18:47:23 +0100
Message-Id: <1550166444-22882-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 14/15] tests/tcg: target/mips: Add wrappers for
 MSA logic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add wrappers for MSA logic instructions.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 3017ed5..7a77fb9 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -92,5 +92,10 @@ DO_MSA__WD__WS_WT(ILVR_H, ilvr.h)
 DO_MSA__WD__WS_WT(ILVR_W, ilvr.w)
 DO_MSA__WD__WS_WT(ILVR_D, ilvr.d)
 
+DO_MSA__WD__WS_WT(AND_V, and.v)
+DO_MSA__WD__WS_WT(NOR_V, nor.v)
+DO_MSA__WD__WS_WT(OR_V, or.v)
+DO_MSA__WD__WS_WT(XOR_V, xor.v)
+
 
 #endif
-- 
2.7.4
