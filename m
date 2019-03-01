Received: from eggs.gnu.org ([209.51.188.92]:37904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gznhW-0005U9-Rm
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gznhU-00043Y-NM
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:05 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:38445 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gznhH-0002Rx-8T
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:00 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  1 Mar 2019 20:18:26 +0100
Message-Id: <1551467914-11209-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551467914-11209-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551467914-11209-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 02/10] tests/tcg: target/mips: Add wrappers
 for MSA bit set instructions
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

Add wrappers for MSA integer bit set instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 302f0ab..2e57268 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -152,5 +152,20 @@ DO_MSA__WD__WS_WT(MIN_U_H, min_u.h)
 DO_MSA__WD__WS_WT(MIN_U_W, min_u.w)
 DO_MSA__WD__WS_WT(MIN_U_D, min_u.d)
 
+DO_MSA__WD__WS_WT(BCLR_B, bclr.b)
+DO_MSA__WD__WS_WT(BCLR_H, bclr.h)
+DO_MSA__WD__WS_WT(BCLR_W, bclr.w)
+DO_MSA__WD__WS_WT(BCLR_D, bclr.d)
+
+DO_MSA__WD__WS_WT(BSET_B, bset.b)
+DO_MSA__WD__WS_WT(BSET_H, bset.h)
+DO_MSA__WD__WS_WT(BSET_W, bset.w)
+DO_MSA__WD__WS_WT(BSET_D, bset.d)
+
+DO_MSA__WD__WS_WT(BNEG_B, bneg.b)
+DO_MSA__WD__WS_WT(BNEG_H, bneg.h)
+DO_MSA__WD__WS_WT(BNEG_W, bneg.w)
+DO_MSA__WD__WS_WT(BNEG_D, bneg.d)
+
 
 #endif
-- 
2.7.4
