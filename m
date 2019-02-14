Received: from eggs.gnu.org ([209.51.188.92]:58695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guF43-0003EO-AZ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guF3r-00028o-Sr
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:20:20 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:55239 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1guF3h-0001a9-Q5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:20:04 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 14 Feb 2019 12:18:22 +0100
Message-Id: <1550143103-20133-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550143103-20133-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550143103-20133-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 8/9] tests/tcg: target/mips: Add wrappers
 for MSA logic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, alex.bennee@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add wrappers for MSA logic instructions.

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
