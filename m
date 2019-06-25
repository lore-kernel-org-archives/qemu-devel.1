Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2301C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4B2215EA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4B2215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hflDh-0002AO-IK
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49485)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hfl3t-0006Iw-Ol
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hfl3i-0003Zw-AG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:00:37 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60129 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hfl3e-0003VP-N1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:00:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 62F9B1A2054;
 Tue, 25 Jun 2019 15:00:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id E19DB1A476B;
 Tue, 25 Jun 2019 15:00:13 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 15:00:05 +0200
Message-Id: <1561467605-31065-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561467605-31065-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561467605-31065-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v5 6/6] tests/tcg: target/mips: Add support for
 MSA MIPS32R6 testings
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add files for MSA MIPS32R6 target testings (copiling and running).

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   | 627 +++++++++++++++++++++
 .../mips/user/ase/msa/test_msa_compile_32r6el.sh   | 627 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh | 363 ++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh | 363 ++++++++++++
 4 files changed, 1980 insertions(+)
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh

diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
new file mode 100755
index 0000000..7a88ca2
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
@@ -0,0 +1,627 @@
+
+#
+# Bit Count
+# ---------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nloc_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nloc_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nloc_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nloc_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nlzc_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nlzc_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nlzc_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nlzc_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pcnt_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pcnt_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pcnt_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pcnt_d_32r6eb
+
+#
+# Bit move
+# --------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsl_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsl_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsl_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsl_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsr_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsr_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsr_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsr_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bmnz_v.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_bmnz_v_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bmz_v.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_bmz_v_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bsel_v.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_bsel_v_32r6eb
+
+#
+# Bit Set
+# -------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bclr_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bclr_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bclr_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bclr_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bneg_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bneg_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bneg_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bneg_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bset_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bset_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bset_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bset_d_32r6eb
+
+#
+# Fixed Multiply
+# --------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mul_q_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mul_q_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulr_q_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulr_q_w_32r6eb
+
+#
+# Float Max Min
+# -------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_a_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmax_a_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_a_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmax_a_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmax_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmax_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_a_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmin_a_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_a_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmin_a_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmin_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmin_d_32r6eb
+
+#
+# Int Add
+# -------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_add_a_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_add_a_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_add_a_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_add_a_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_a_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_a_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_a_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_a_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_addv_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_addv_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_addv_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_addv_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_u_d_32r6eb
+
+#
+# Int Average
+# -----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_u_d_32r6eb
+
+#
+# Int Compare
+# -----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_b.c           \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ceq_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_h.c           \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ceq_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_w.c           \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ceq_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_d.c           \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ceq_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_u_d_32r6eb
+
+#
+# Int Divide
+# ----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_u_d_32r6eb
+
+#
+# Int Dot Product
+# ---------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_h.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_w.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_d.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_h.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_w.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_d.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_h.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_w.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_d.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_h.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_w.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_d.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_u_d_32r6eb
+
+#
+# Int Max Min
+# -----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_a_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_a_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_a_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_a_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_a_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_a_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_a_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_a_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_u_d_32r6eb
+
+#
+# Int Modulo
+# ----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_u_d_32r6eb
+
+#
+# Int Multiply
+# ------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddv_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddv_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddv_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddv_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubv_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubv_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubv_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubv_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulv_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulv_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulv_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulv_d_32r6eb
+
+#
+# Int Subtract
+# ------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_b.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_w.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subv_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subv_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subv_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subv_d_32r6eb
+
+#
+# Interleave
+# ----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvev_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvev_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvev_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvev_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvod_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvod_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvod_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvod_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvl_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvl_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvl_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvl_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvr_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvr_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvr_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvr_d_32r6eb
+
+#
+# Logic
+# -----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_and_v.c           \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_and_v_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_nor_v.c           \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nor_v_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_or_v.c            \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_or_v_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_xor_v.c           \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_xor_v_32r6eb
+
+#
+# Move
+# ----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc            move/test_msa_move_v.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_move_v_32r6eb
+
+#
+# Pack
+# ----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckev_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckev_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckev_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckev_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckod_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckod_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckod_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckod_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_vshf_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_vshf_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_vshf_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_vshf_d_32r6eb
+
+#
+# Shift
+# -----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sll_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sll_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sll_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sll_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sra_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sra_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sra_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sra_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srar_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srar_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srar_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srar_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_b.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srl_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_h.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srl_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_w.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srl_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_d.c          \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srl_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_b.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srlr_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_h.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srlr_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_w.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srlr_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_d.c         \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srlr_d_32r6eb
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
new file mode 100755
index 0000000..dbe04dc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
@@ -0,0 +1,627 @@
+
+#
+# Bit Count
+# ---------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nloc_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nloc_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nloc_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nloc_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nlzc_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nlzc_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nlzc_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nlzc_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pcnt_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pcnt_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pcnt_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pcnt_d_32r6el
+
+#
+# Bit move
+# --------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsl_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsl_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsl_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsl_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsr_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsr_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsr_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_binsr_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bmnz_v.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_bmnz_v_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bmz_v.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_bmz_v_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bsel_v.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_bsel_v_32r6el
+
+#
+# Bit Set
+# -------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bclr_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bclr_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bclr_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bclr_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bneg_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bneg_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bneg_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bneg_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bset_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bset_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bset_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_bset_d_32r6el
+
+#
+# Fixed Multiply
+# --------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mul_q_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mul_q_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulr_q_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulr_q_w_32r6el
+
+#
+# Float Max Min
+# -------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_a_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmax_a_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_a_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmax_a_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmax_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmax_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_a_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmin_a_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_a_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmin_a_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmin_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_fmin_d_32r6el
+
+#
+# Int Add
+# -------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_add_a_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_add_a_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_add_a_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_add_a_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_a_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_a_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_a_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_a_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_adds_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_addv_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_addv_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_addv_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_addv_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hadd_u_d_32r6el
+
+#
+# Int Average
+# -----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ave_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_aver_u_d_32r6el
+
+#
+# Int Compare
+# -----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_b.c           \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ceq_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_h.c           \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ceq_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_w.c           \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ceq_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_d.c           \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ceq_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_cle_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_clt_u_d_32r6el
+
+#
+# Int Divide
+# ----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_div_u_d_32r6el
+
+#
+# Int Dot Product
+# ---------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dotp_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_h.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_w.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_d.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_h.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_w.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_d.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpadd_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_h.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_w.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_d.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_h.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_w.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_d.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_dpsub_u_d_32r6el
+
+#
+# Int Max Min
+# -----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_a_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_a_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_a_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_a_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_max_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_a_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_a_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_a_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_a_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_min_u_d_32r6el
+
+#
+# Int Modulo
+# ----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mod_u_d_32r6el
+
+#
+# Int Multiply
+# ------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddv_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddv_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddv_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddv_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubv_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubv_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubv_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubv_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulv_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulv_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulv_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mulv_d_32r6el
+
+#
+# Int Subtract
+# ------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_asub_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_hsub_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_b.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_w.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subv_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subv_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subv_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subv_d_32r6el
+
+#
+# Interleave
+# ----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvev_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvev_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvev_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvev_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvod_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvod_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvod_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvod_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvl_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvl_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvl_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvl_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvr_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvr_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvr_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_ilvr_d_32r6el
+
+#
+# Logic
+# -----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_and_v.c           \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_and_v_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_nor_v.c           \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_nor_v_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_or_v.c            \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_or_v_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_xor_v.c           \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_xor_v_32r6el
+
+#
+# Move
+# ----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc            move/test_msa_move_v.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_move_v_32r6el
+
+#
+# Pack
+# ----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckev_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckev_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckev_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckev_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckod_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckod_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckod_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_pckod_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_vshf_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_vshf_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_vshf_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_vshf_d_32r6el
+
+#
+# Shift
+# -----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sll_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sll_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sll_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sll_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sra_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sra_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sra_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_sra_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srar_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srar_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srar_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srar_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_b.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srl_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_h.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srl_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_w.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srl_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_d.c          \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srl_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_b.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srlr_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_h.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srlr_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_w.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srlr_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_d.c         \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o   /tmp/test_msa_srlr_d_32r6el
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
new file mode 100644
index 0000000..70b2549
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
@@ -0,0 +1,363 @@
+PATH_TO_QEMU="../../../../../../mips64-linux-user/qemu-mips64"
+
+
+#
+# Bit Count
+# ---------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_d_32r6eb
+
+#
+# Bit move
+# --------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bmnz_v_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bmz_v_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bsel_v_32r6eb
+
+#
+# Bit Set
+# -------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_d_32r6eb
+
+#
+# Fixed Multiply
+# --------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_w_32r6eb
+
+#
+# Float Max Min
+# -------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_a_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_a_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_a_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_a_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_d_32r6eb
+
+#
+# Int Add
+# -------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_d_32r6eb
+
+#
+# Int Average
+# -----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_d_32r6eb
+
+#
+# Int Compare
+# -----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_d_32r6eb
+
+#
+# Int Divide
+# ----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_d_32r6eb
+
+#
+# Int Dot Product
+# ---------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_d_32r6eb
+
+#
+# Int Max Min
+# -----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_d_32r6eb
+
+#
+# Int Modulo
+# ----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_d_32r6eb
+
+#
+# Int Multiply
+# ------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_d_32r6eb
+
+#
+# Int Subtract
+# ------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_d_32r6eb
+
+#
+# Interleave
+# ----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_d_32r6eb
+
+#
+# Logic
+# -----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_and_v_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nor_v_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_or_v_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_xor_v_32r6eb
+
+#
+# Move
+# ----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_move_v_32r6eb
+
+#
+# Pack
+# ----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_d_32r6eb
+
+#
+# Shift
+# -----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_d_32r6eb
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
new file mode 100755
index 0000000..4e07930
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
@@ -0,0 +1,363 @@
+PATH_TO_QEMU="../../../../../../mips64el-linux-user/qemu-mips64el"
+
+
+#
+# Bit Count
+# ---------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_d_32r6el
+
+#
+# Bit move
+# --------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bmnz_v_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bmz_v_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bsel_v_32r6el
+
+#
+# Bit Set
+# -------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_d_32r6el
+
+#
+# Fixed Multiply
+# --------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_w_32r6el
+
+#
+# Float Max Min
+# -------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_a_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_a_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_a_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_a_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_d_32r6el
+
+#
+# Int Add
+# -------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_d_32r6el
+
+#
+# Int Average
+# -----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_d_32r6el
+
+#
+# Int Compare
+# -----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_d_32r6el
+
+#
+# Int Divide
+# ----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_d_32r6el
+
+#
+# Int Dot Product
+# ---------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_d_32r6el
+
+#
+# Int Max Min
+# -----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_d_32r6el
+
+#
+# Int Modulo
+# ----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_d_32r6el
+
+#
+# Int Multiply
+# ------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_d_32r6el
+
+#
+# Int Subtract
+# ------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_d_32r6el
+
+#
+# Interleave
+# ----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_d_32r6el
+
+#
+# Logic
+# -----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_and_v_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nor_v_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_or_v_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_xor_v_32r6el
+
+#
+# Move
+# ----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_move_v_32r6el
+
+#
+# Pack
+# ----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_d_32r6el
+
+#
+# Shift
+# -----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_d_32r6el
-- 
2.7.4


