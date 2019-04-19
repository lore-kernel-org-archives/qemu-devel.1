Received: from eggs.gnu.org ([209.51.188.92]:51191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hHYQ1-0006Sj-IT
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hHYPx-0003zP-9i
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:25 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57140 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hHYPv-0003xP-8N
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:20 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Apr 2019 20:38:01 +0200
Message-Id: <1555699081-24577-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1555699081-24577-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1555699081-24577-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 5/5] tests/tcg: target/mips: Add README for MSA
 tests
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

Add README for MSA tests. This is just to explain how to run tests even
without Makefile. Makefile will be provided later on.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/user/ase/msa/README | 639 +++++++++++++++++++++++++++++++++++++
 1 file changed, 639 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/README

diff --git a/tests/tcg/mips/user/ase/msa/README b/tests/tcg/mips/user/ase/msa/README
new file mode 100644
index 0000000..3df0fd0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/README
@@ -0,0 +1,639 @@
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
+This is an example of a shell script that will compile and execute tests for
+206 MSA instructions:
+
+
+cd <QEMU root directory>
+cd tests/tcg/mips/user/ase/msa
+
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
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mul_q_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mul_q_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mul_q_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mul_q_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulr_q_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulr_q_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulr_q_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulr_q_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulv_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulv_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulv_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulv_d
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_b.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subv_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_h.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subv_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_w.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subv_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_d.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subv_d
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
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_and_v.c           \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_and_v
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_nor_v.c           \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_nor_v
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_or_v.c            \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_or_v
+/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_xor_v.c           \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_xor_v
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
+cd -
+
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_nloc_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_nloc_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_nloc_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_nloc_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_nlzc_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_nlzc_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_nlzc_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_nlzc_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pcnt_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pcnt_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pcnt_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pcnt_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bclr_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bclr_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bclr_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bclr_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bneg_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bneg_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bneg_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bneg_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bset_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bset_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bset_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_bset_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_add_a_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_add_a_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_add_a_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_add_a_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_a_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_a_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_a_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_a_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_adds_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_addv_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_addv_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_addv_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_addv_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hadd_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hadd_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hadd_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hadd_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hadd_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hadd_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_aver_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_aver_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_aver_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_aver_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_aver_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_aver_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_aver_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_aver_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ave_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ave_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ave_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ave_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ave_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ave_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ave_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ave_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ceq_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ceq_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ceq_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ceq_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_cle_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_cle_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_cle_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_cle_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_cle_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_cle_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_cle_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_cle_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_clt_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_clt_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_clt_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_clt_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_clt_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_clt_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_clt_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_clt_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_div_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_div_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_div_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_div_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_div_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_div_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_div_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_div_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_dotp_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_dotp_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_dotp_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_dotp_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_dotp_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_dotp_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_a_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_a_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_a_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_a_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_max_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_a_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_a_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_a_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_a_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_min_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mod_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mod_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mod_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mod_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mod_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mod_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mod_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mod_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mul_q_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mul_q_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mulr_q_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mulr_q_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mulv_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mulv_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mulv_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_mulv_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subv_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subv_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subv_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subv_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subs_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subs_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subs_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subs_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subs_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subs_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subs_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subs_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_asub_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_asub_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_asub_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_asub_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_asub_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_asub_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_asub_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_asub_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subsuu_s_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subsuu_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subsuu_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subsuu_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subsus_u_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subsus_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subsus_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_subsus_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hsub_s_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hsub_s_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hsub_s_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hsub_u_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hsub_u_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_hsub_u_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvev_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvev_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvev_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvev_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvod_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvod_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvod_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvod_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvl_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvl_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvl_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvl_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvr_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvr_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvr_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_ilvr_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_and_v
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_nor_v
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_or_v
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_xor_v
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pckev_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pckev_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pckev_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pckev_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pckod_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pckod_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pckod_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_pckod_d
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_vshf_b
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_vshf_h
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_vshf_w
+mips64el-linux-user/qemu-mips64el -cpu I6400  /tmp/test_msa_vshf_d
-- 
2.7.4
