Received: from eggs.gnu.org ([209.51.188.92]:35364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1C64-0002No-7x
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1C62-0002l4-Ve
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:12 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54202 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1C62-0002C8-KP
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:10 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue,  5 Mar 2019 16:34:25 +0100
Message-Id: <1551800076-8104-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551800076-8104-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551800076-8104-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 03/14] tests/tcg: target/mips: Add wrappers
 for various MSA instructions
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

Add wrappers for various MSA integer instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h | 70 +++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 302f0ab..c650ed2 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -152,5 +152,75 @@ DO_MSA__WD__WS_WT(MIN_U_H, min_u.h)
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
+DO_MSA__WD__WS_WT(PCKEV_B, pckev.b)
+DO_MSA__WD__WS_WT(PCKEV_H, pckev.h)
+DO_MSA__WD__WS_WT(PCKEV_W, pckev.w)
+DO_MSA__WD__WS_WT(PCKEV_D, pckev.d)
+
+DO_MSA__WD__WS_WT(PCKOD_B, pckod.b)
+DO_MSA__WD__WS_WT(PCKOD_H, pckod.h)
+DO_MSA__WD__WS_WT(PCKOD_W, pckod.w)
+DO_MSA__WD__WS_WT(PCKOD_D, pckod.d)
+
+DO_MSA__WD__WS_WT(VSHF_B, vshf.b)
+DO_MSA__WD__WS_WT(VSHF_H, vshf.h)
+DO_MSA__WD__WS_WT(VSHF_W, vshf.w)
+DO_MSA__WD__WS_WT(VSHF_D, vshf.d)
+
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
+DO_MSA__WD__WS_WT(BMNZ_V, bmnz.v)
+DO_MSA__WD__WS_WT(BMZ_V, bmz.v)
+
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
