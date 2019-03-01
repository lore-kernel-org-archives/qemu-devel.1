Received: from eggs.gnu.org ([209.51.188.92]:37970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gznhY-0005VD-2c
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gznhW-00043x-Ao
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:06 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:38455 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gznhH-0002SM-Ec
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:00 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  1 Mar 2019 20:18:28 +0100
Message-Id: <1551467914-11209-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551467914-11209-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551467914-11209-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 04/10] tests/tcg: target/mips: Add wrappers
 for MSA shift instructions
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

Add wrappers for MSA shift instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 7057ffb..171a547 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -182,5 +182,30 @@ DO_MSA__WD__WS_WT(VSHF_H, vshf.h)
 DO_MSA__WD__WS_WT(VSHF_W, vshf.w)
 DO_MSA__WD__WS_WT(VSHF_D, vshf.d)
 
+DO_MSA__WD__WS_WT(SLL_B, sll.b)
+DO_MSA__WD__WS_WT(SLL_H, sll.h)
+DO_MSA__WD__WS_WT(SLL_W, sll.w)
+DO_MSA__WD__WS_WT(SLL_D, sll.d)
+
+DO_MSA__WD__WS_WT(SRA_B, sra.b)
+DO_MSA__WD__WS_WT(SRA_H, sra.h)
+DO_MSA__WD__WS_WT(SRA_W, sra.w)
+DO_MSA__WD__WS_WT(SRA_D, sra.d)
+
+DO_MSA__WD__WS_WT(SRAR_B, srar.b)
+DO_MSA__WD__WS_WT(SRAR_H, srar.h)
+DO_MSA__WD__WS_WT(SRAR_W, srar.w)
+DO_MSA__WD__WS_WT(SRAR_D, srar.d)
+
+DO_MSA__WD__WS_WT(SRL_B, srl.b)
+DO_MSA__WD__WS_WT(SRL_H, srl.h)
+DO_MSA__WD__WS_WT(SRL_W, srl.w)
+DO_MSA__WD__WS_WT(SRL_D, srl.d)
+
+DO_MSA__WD__WS_WT(SRLR_B, srlr.b)
+DO_MSA__WD__WS_WT(SRLR_H, srlr.h)
+DO_MSA__WD__WS_WT(SRLR_W, srlr.w)
+DO_MSA__WD__WS_WT(SRLR_D, srlr.d)
+
 
 #endif
-- 
2.7.4
