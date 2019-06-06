Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35178C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900AF20652
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900AF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvMg-00017v-Oo
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 12:35:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYvF3-0003cJ-M9
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYvEy-0003d7-KW
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:27:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43522 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hYvEu-0003Ud-0C
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:27:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 87D2A1A21DE;
	Thu,  6 Jun 2019 18:27:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 3F9571A21B0;
	Thu,  6 Jun 2019 18:27:40 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:27:20 +0200
Message-Id: <1559838440-9866-11-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559838440-9866-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559838440-9866-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v4 10/10] tests/tcg: target/mips: Add README
 for MSA tests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add README for MSA tests. This is just to explain how to run tests even
without Makefile. Makefile will be provided later on.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1555699081-24577-6-git-send-email-aleksandar.markovic@rt-rk.com>
---
 tests/tcg/mips/user/ase/msa/README              |  20 +
 tests/tcg/mips/user/ase/msa/test_msa_compile.sh | 558 ++++++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run.sh     | 329 ++++++++++++++
 3 files changed, 907 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/README
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run.sh

diff --git a/tests/tcg/mips/user/ase/msa/README b/tests/tcg/mips/user/ase/msa/README
new file mode 100644
index 0000000..ca4f070
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/README
@@ -0,0 +1,20 @@
+The tests in subdirectories of this directory are supposed to be compiled for
+mips64el MSA-enabled CPU (I6400, I6500), using an appropriate MIPS toolchain.
+For example:
+
+/opt/img/bin/mips-img-linux-gnu-gcc <source file>                  \
+-EL -static -mabi=64 -march=mips64r6 -mmsa  -o <executable file>
+
+They are to be executed using QEMU user mode, using command line:
+
+mips64el-linux-user/qemu-mips64el -cpu I6400 <executable file>
+
+Helper scripts test_msa_compile.sh and test_msa_run.sh are also
+provided. This is an example of compilation and execution of all
+MSA tests:
+
+cd <QEMU root directory>
+cd tests/tcg/mips/user/ase/msa
+
+./test_msa_compile.sh
+./test_msa_run.sh
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile.sh
new file mode 100755
index 0000000..2a39d89
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile.sh
@@ -0,0 +1,558 @@
+
+#
+# Bit Count
+# ---------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_nloc_b
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_nloc_h
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_nloc_w
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_nloc_d
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_nlzc_b
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_nlzc_h
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_nlzc_w
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_nlzc_d
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pcnt_b
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pcnt_h
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pcnt_w
+/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pcnt_d
+
+#
+# Bit move
+# --------
+#
+
+#
+# Bit Set
+# -------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bclr_b
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bclr_h
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bclr_w
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bclr_d
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bneg_b
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bneg_h
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bneg_w
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bneg_d
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bset_b
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bset_h
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bset_w
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_bset_d
+
+#
+# Fixed Multiply
+# --------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc    fixed-multiply/test_msa_mul_q_h.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mul_q_h
+/opt/img/bin/mips-img-linux-gnu-gcc    fixed-multiply/test_msa_mul_q_w.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mul_q_w
+/opt/img/bin/mips-img-linux-gnu-gcc    fixed-multiply/test_msa_mulr_q_h.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulr_q_h
+/opt/img/bin/mips-img-linux-gnu-gcc    fixed-multiply/test_msa_mulr_q_w.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulr_q_w
+
+#
+# Float Max Min
+# -------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc         float-max-min/test_msa_fmax_a_w.c  \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o        /tmp/test_msa_fmax_a_w
+/opt/img/bin/mips-img-linux-gnu-gcc         float-max-min/test_msa_fmax_a_d.c  \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o        /tmp/test_msa_fmax_a_d
+/opt/img/bin/mips-img-linux-gnu-gcc         float-max-min/test_msa_fmax_w.c    \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o        /tmp/test_msa_fmax_w
+/opt/img/bin/mips-img-linux-gnu-gcc         float-max-min/test_msa_fmax_d.c    \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o        /tmp/test_msa_fmax_d
+/opt/img/bin/mips-img-linux-gnu-gcc         float-max-min/test_msa_fmin_a_w.c  \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o        /tmp/test_msa_fmin_a_w
+/opt/img/bin/mips-img-linux-gnu-gcc         float-max-min/test_msa_fmin_a_d.c  \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o        /tmp/test_msa_fmin_a_d
+/opt/img/bin/mips-img-linux-gnu-gcc         float-max-min/test_msa_fmin_w.c    \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o        /tmp/test_msa_fmin_w
+/opt/img/bin/mips-img-linux-gnu-gcc         float-max-min/test_msa_fmin_d.c    \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o        /tmp/test_msa_fmin_d
+
+#
+# Int Add
+# -------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_add_a_b
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_add_a_h
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_add_a_w
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_add_a_d
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_a_b
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_a_h
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_a_w
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_a_d
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_adds_u_d
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_addv_b
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_addv_h
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_addv_w
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_addv_d
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hadd_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hadd_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hadd_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hadd_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hadd_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hadd_u_d
+
+#
+# Int Average
+# -----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ave_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ave_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ave_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ave_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ave_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ave_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ave_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ave_u_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_aver_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_aver_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_aver_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_aver_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_aver_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_aver_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_aver_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_aver_u_d
+
+#
+# Int Compare
+# -----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_b.c           \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ceq_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_h.c           \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ceq_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_w.c           \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ceq_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_d.c           \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ceq_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_cle_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_cle_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_cle_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_cle_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_cle_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_cle_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_cle_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_cle_u_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_clt_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_clt_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_clt_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_clt_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_clt_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_clt_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_clt_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_clt_u_d
+
+#
+# Int Divide
+# ----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_div_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_div_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_div_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_div_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_div_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_div_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_div_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_div_u_d
+
+#
+# Int Dot Product
+# ---------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dotp_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dotp_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dotp_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dotp_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dotp_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dotp_u_d
+
+#
+# Int Max Min
+# -----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_a_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_a_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_a_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_a_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_max_u_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_a_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_a_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_a_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_a_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_min_u_d
+
+#
+# Int Modulo
+# ----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mod_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mod_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mod_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mod_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mod_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mod_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mod_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mod_u_d
+
+#
+# Int Multiply
+# ------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulv_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulv_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulv_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulv_d
+
+#
+# Int Subtract
+# ------------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_asub_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_asub_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_asub_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_asub_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_asub_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_asub_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_asub_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_asub_u_d
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hsub_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hsub_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hsub_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hsub_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hsub_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_hsub_u_d
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_u_d
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsus_u_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsus_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_w.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsus_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsus_u_d
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subv_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subv_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subv_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subv_d
+
+#
+# Interleave
+# ----------
+#
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvev_b
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvev_h
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvev_w
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvev_d
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvod_b
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvod_h
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvod_w
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvod_d
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvl_b
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvl_h
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvl_w
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvl_d
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvr_b
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvr_h
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvr_w
+/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_ilvr_d
+
+#
+# Logic
+# -----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_and_v.c           \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_and_v
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_nor_v.c           \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_nor_v
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_or_v.c            \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_or_v
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_xor_v.c           \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_xor_v
+
+#
+# Pack
+# ----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pckev_b
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pckev_h
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pckev_w
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pckev_d
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pckod_b
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pckod_h
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pckod_w
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_pckod_d
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_vshf_b
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_vshf_h
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_vshf_w
+/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_vshf_d
+
+#
+# Shift
+# -----
+#
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_sll_b
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_sll_h
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_sll_w
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_sll_d
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_sra_b
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_sra_h
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_sra_w
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_sra_d
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srar_b
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srar_h
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srar_w
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srar_d
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srl_b
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srl_h
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srl_w
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srl_d
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srlr_b
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srlr_h
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srlr_w
+/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_srlr_d
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run.sh b/tests/tcg/mips/user/ase/msa/test_msa_run.sh
new file mode 100755
index 0000000..5001bca
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run.sh
@@ -0,0 +1,329 @@
+PATH_TO_QEMU="../../../../../../mips64el-linux-user/qemu-mips64el"
+
+
+#
+# Bit Count
+# ---------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_d
+
+#
+# Bit move
+# --------
+#
+
+#
+# Bit Set
+# -------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_d
+
+#
+# Fixed Multiply
+# --------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_w
+
+#
+# Float Max Min
+# -------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_a_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_a_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_a_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_a_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_d
+
+#
+# Int Add
+# -------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_d
+
+#
+# Int Average
+# -----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_d
+
+#
+# Int Compare
+# -----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_d
+
+#
+# Int Divide
+# ----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_d
+
+#
+# Int Dot Product
+# ---------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_d
+
+#
+# Int Max Min
+# -----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_d
+
+#
+# Int Modulo
+# ----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_d
+
+#
+# Int Multiply
+# ------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_d
+
+#
+# Int Subtract
+# ------------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_d
+
+#
+# Interleave
+# ----------
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_d
+
+#
+# Logic
+# -----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_and_v
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nor_v
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_or_v
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_xor_v
+
+#
+# Pack
+# ----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_d
+
+#
+# Shift
+# -----
+#
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_d
+
+
+
-- 
2.7.4


