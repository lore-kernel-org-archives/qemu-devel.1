Received: from eggs.gnu.org ([209.51.188.92]:38234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gznhl-0005me-3l
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gznhe-0004Rx-Fs
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:16 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42029 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gznhY-00041g-Br
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:10 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  1 Mar 2019 20:18:30 +0100
Message-Id: <1551467914-11209-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551467914-11209-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551467914-11209-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 06/10] tests/tcg: target/mips: Add wrappers
 for MSA FP max/min instructions
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

Add wrappers for MSA FP max/min instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 61ab3b9..c650ed2 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -210,5 +210,17 @@ DO_MSA__WD__WS_WT(SRLR_D, srlr.d)
 DO_MSA__WD__WS_WT(BMNZ_V, bmnz.v)
 DO_MSA__WD__WS_WT(BMZ_V, bmz.v)
 
+DO_MSA__WD__WS_WT(FMAX_W, fmax.w)
+DO_MSA__WD__WS_WT(FMAX_D, fmax.d)
+
+DO_MSA__WD__WS_WT(FMAX_A_W, fmax_a.w)
+DO_MSA__WD__WS_WT(FMAX_A_D, fmax_a.d)
+
+DO_MSA__WD__WS_WT(FMIN_W, fmin.w)
+DO_MSA__WD__WS_WT(FMIN_D, fmin.d)
+
+DO_MSA__WD__WS_WT(FMIN_A_W, fmin_a.w)
+DO_MSA__WD__WS_WT(FMIN_A_D, fmin_a.d)
+
 
 #endif
-- 
2.7.4
