Received: from eggs.gnu.org ([209.51.188.92]:50176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gw9vx-0003D0-Tt
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gw9vk-0005Ra-IZ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:15:51 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53520 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gw9vg-0004uw-3c
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:15:40 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 19 Feb 2019 19:14:14 +0100
Message-Id: <1550600059-5789-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550600059-5789-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550600059-5789-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 4/9] tests/tcg: target/mips: Add wrappers
 for MSA integer compare instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, peter.maydell@linaro.org, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add wrappers for MSA integer compare instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 7a77fb9..3280f9b 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -97,5 +97,30 @@ DO_MSA__WD__WS_WT(NOR_V, nor.v)
 DO_MSA__WD__WS_WT(OR_V, or.v)
 DO_MSA__WD__WS_WT(XOR_V, xor.v)
 
+DO_MSA__WD__WS_WT(CEQ_B, ceq.b)
+DO_MSA__WD__WS_WT(CEQ_H, ceq.h)
+DO_MSA__WD__WS_WT(CEQ_W, ceq.w)
+DO_MSA__WD__WS_WT(CEQ_D, ceq.d)
+
+DO_MSA__WD__WS_WT(CLE_S_B, cle_s.b)
+DO_MSA__WD__WS_WT(CLE_S_H, cle_s.h)
+DO_MSA__WD__WS_WT(CLE_S_W, cle_s.w)
+DO_MSA__WD__WS_WT(CLE_S_D, cle_s.d)
+
+DO_MSA__WD__WS_WT(CLE_U_B, cle_u.b)
+DO_MSA__WD__WS_WT(CLE_U_H, cle_u.h)
+DO_MSA__WD__WS_WT(CLE_U_W, cle_u.w)
+DO_MSA__WD__WS_WT(CLE_U_D, cle_u.d)
+
+DO_MSA__WD__WS_WT(CLT_S_B, clt_s.b)
+DO_MSA__WD__WS_WT(CLT_S_H, clt_s.h)
+DO_MSA__WD__WS_WT(CLT_S_W, clt_s.w)
+DO_MSA__WD__WS_WT(CLT_S_D, clt_s.d)
+
+DO_MSA__WD__WS_WT(CLT_U_B, clt_u.b)
+DO_MSA__WD__WS_WT(CLT_U_H, clt_u.h)
+DO_MSA__WD__WS_WT(CLT_U_W, clt_u.w)
+DO_MSA__WD__WS_WT(CLT_U_D, clt_u.d)
+
 
 #endif
-- 
2.7.4
