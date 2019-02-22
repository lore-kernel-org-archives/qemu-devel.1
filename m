Received: from eggs.gnu.org ([209.51.188.92]:33476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gxGUy-0004Gc-Ot
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gxGUx-0001wY-PQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:28:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:55002 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gxGUx-0001TY-Fr
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:28:39 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 22 Feb 2019 20:26:17 +0100
Message-Id: <1550863578-30859-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550863578-30859-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550863578-30859-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 7/8] tests/tcg: target/mips: Add wrappers
 for MSA integer max/min instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add wrappers for MSA integer max/min instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 3280f9b..302f0ab 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -122,5 +122,35 @@ DO_MSA__WD__WS_WT(CLT_U_H, clt_u.h)
 DO_MSA__WD__WS_WT(CLT_U_W, clt_u.w)
 DO_MSA__WD__WS_WT(CLT_U_D, clt_u.d)
 
+DO_MSA__WD__WS_WT(MAX_A_B, max_a.b)
+DO_MSA__WD__WS_WT(MAX_A_H, max_a.h)
+DO_MSA__WD__WS_WT(MAX_A_W, max_a.w)
+DO_MSA__WD__WS_WT(MAX_A_D, max_a.d)
+
+DO_MSA__WD__WS_WT(MIN_A_B, min_a.b)
+DO_MSA__WD__WS_WT(MIN_A_H, min_a.h)
+DO_MSA__WD__WS_WT(MIN_A_W, min_a.w)
+DO_MSA__WD__WS_WT(MIN_A_D, min_a.d)
+
+DO_MSA__WD__WS_WT(MAX_S_B, max_s.b)
+DO_MSA__WD__WS_WT(MAX_S_H, max_s.h)
+DO_MSA__WD__WS_WT(MAX_S_W, max_s.w)
+DO_MSA__WD__WS_WT(MAX_S_D, max_s.d)
+
+DO_MSA__WD__WS_WT(MIN_S_B, min_s.b)
+DO_MSA__WD__WS_WT(MIN_S_H, min_s.h)
+DO_MSA__WD__WS_WT(MIN_S_W, min_s.w)
+DO_MSA__WD__WS_WT(MIN_S_D, min_s.d)
+
+DO_MSA__WD__WS_WT(MAX_U_B, max_u.b)
+DO_MSA__WD__WS_WT(MAX_U_H, max_u.h)
+DO_MSA__WD__WS_WT(MAX_U_W, max_u.w)
+DO_MSA__WD__WS_WT(MAX_U_D, max_u.d)
+
+DO_MSA__WD__WS_WT(MIN_U_B, min_u.b)
+DO_MSA__WD__WS_WT(MIN_U_H, min_u.h)
+DO_MSA__WD__WS_WT(MIN_U_W, min_u.w)
+DO_MSA__WD__WS_WT(MIN_U_D, min_u.d)
+
 
 #endif
-- 
2.7.4
