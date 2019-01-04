Received: from eggs.gnu.org ([208.118.235.92]:60457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gfSdW-0002S4-6j
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gfSdT-0005tc-0B
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:47:54 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42516 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gfSdS-00052x-Fd
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:47:50 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  4 Jan 2019 17:46:34 +0100
Message-Id: <1546620394-24958-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546620394-24958-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546620394-24958-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/2] tests: tcg: mips: Remove old directories
 after moving source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, arikalo@wavecomp.com, smarkovic@wavecomp.com, alex.bennee@linaro.org, noring@nocrew.org, aurelien@aurel32.net

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove old directories after reorganization of MIPS TCG tests.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mips32-dsp/Makefile        | 136 -------------
 tests/tcg/mips/mips32-dspr2/Makefile      |  71 -------
 tests/tcg/mips/mips64-dsp/Makefile        | 306 ------------------------------
 tests/tcg/mips/mips64-dsp/head.S          |  16 --
 tests/tcg/mips/mips64-dsp/io.h            |  22 ---
 tests/tcg/mips/mips64-dsp/mips_boot.lds   |  31 ---
 tests/tcg/mips/mips64-dspr2/.directory    |   2 -
 tests/tcg/mips/mips64-dspr2/Makefile      | 116 -----------
 tests/tcg/mips/mips64-dspr2/head.S        |  16 --
 tests/tcg/mips/mips64-dspr2/io.h          |  22 ---
 tests/tcg/mips/mips64-dspr2/mips_boot.lds |  31 ---
 tests/tcg/mips/mipsr5900/Makefile         |  32 ----
 12 files changed, 801 deletions(-)
 delete mode 100644 tests/tcg/mips/mips32-dsp/Makefile
 delete mode 100644 tests/tcg/mips/mips32-dspr2/Makefile
 delete mode 100644 tests/tcg/mips/mips64-dsp/Makefile
 delete mode 100644 tests/tcg/mips/mips64-dsp/head.S
 delete mode 100644 tests/tcg/mips/mips64-dsp/io.h
 delete mode 100644 tests/tcg/mips/mips64-dsp/mips_boot.lds
 delete mode 100644 tests/tcg/mips/mips64-dspr2/.directory
 delete mode 100644 tests/tcg/mips/mips64-dspr2/Makefile
 delete mode 100644 tests/tcg/mips/mips64-dspr2/head.S
 delete mode 100644 tests/tcg/mips/mips64-dspr2/io.h
 delete mode 100644 tests/tcg/mips/mips64-dspr2/mips_boot.lds
 delete mode 100644 tests/tcg/mips/mipsr5900/Makefile

diff --git a/tests/tcg/mips/mips32-dsp/Makefile b/tests/tcg/mips/mips32-dsp/Makefile
deleted file mode 100644
index c3a0a00..0000000
--- a/tests/tcg/mips/mips32-dsp/Makefile
+++ /dev/null
@@ -1,136 +0,0 @@
--include ../../config-host.mak
-
-CROSS=mips64el-unknown-linux-gnu-
-
-SIM=qemu-mipsel
-SIM_FLAGS=-cpu 74Kf
-
-CC      = $(CROSS)gcc
-CFLAGS  = -mabi=32 -march=mips32r2 -mgp32 -mdsp -static
-
-TESTCASES = absq_s_ph.tst
-TESTCASES += absq_s_w.tst
-TESTCASES += addq_ph.tst
-TESTCASES += addq_s_ph.tst
-TESTCASES += addq_s_w.tst
-TESTCASES += addsc.tst
-TESTCASES += addu_qb.tst
-TESTCASES += addu_s_qb.tst
-TESTCASES += addwc.tst
-TESTCASES += bitrev.tst
-TESTCASES += bposge32.tst
-TESTCASES += cmp_eq_ph.tst
-TESTCASES += cmpgu_eq_qb.tst
-TESTCASES += cmpgu_le_qb.tst
-TESTCASES += cmpgu_lt_qb.tst
-TESTCASES += cmp_le_ph.tst
-TESTCASES += cmp_lt_ph.tst
-TESTCASES += cmpu_eq_qb.tst
-TESTCASES += cmpu_le_qb.tst
-TESTCASES += cmpu_lt_qb.tst
-TESTCASES += dpaq_sa_l_w.tst
-TESTCASES += dpaq_s_w_ph.tst
-TESTCASES += dpau_h_qbl.tst
-TESTCASES += dpau_h_qbr.tst
-TESTCASES += dpsq_sa_l_w.tst
-TESTCASES += dpsq_s_w_ph.tst
-TESTCASES += dpsu_h_qbl.tst
-TESTCASES += dpsu_h_qbr.tst
-TESTCASES += extp.tst
-TESTCASES += extpdp.tst
-TESTCASES += extpdpv.tst
-TESTCASES += extpv.tst
-TESTCASES += extr_rs_w.tst
-TESTCASES += extr_r_w.tst
-TESTCASES += extr_s_h.tst
-TESTCASES += extrv_rs_w.tst
-TESTCASES += extrv_r_w.tst
-TESTCASES += extrv_s_h.tst
-TESTCASES += extrv_w.tst
-TESTCASES += extr_w.tst
-TESTCASES += insv.tst
-TESTCASES += lbux.tst
-TESTCASES += lhx.tst
-TESTCASES += lwx.tst
-TESTCASES += madd.tst
-TESTCASES += maddu.tst
-TESTCASES += maq_sa_w_phl.tst
-TESTCASES += maq_sa_w_phr.tst
-TESTCASES += maq_s_w_phl.tst
-TESTCASES += maq_s_w_phr.tst
-TESTCASES += mfhi.tst
-TESTCASES += mflo.tst
-TESTCASES += modsub.tst
-TESTCASES += msub.tst
-TESTCASES += msubu.tst
-TESTCASES += mthi.tst
-TESTCASES += mthlip.tst
-TESTCASES += mtlo.tst
-TESTCASES += muleq_s_w_phl.tst
-TESTCASES += muleq_s_w_phr.tst
-TESTCASES += muleu_s_ph_qbl.tst
-TESTCASES += muleu_s_ph_qbr.tst
-TESTCASES += mulq_rs_ph.tst
-TESTCASES += mult.tst
-TESTCASES += multu.tst
-TESTCASES += packrl_ph.tst
-TESTCASES += pick_ph.tst
-TESTCASES += pick_qb.tst
-TESTCASES += precequ_ph_qbla.tst
-TESTCASES += precequ_ph_qbl.tst
-TESTCASES += precequ_ph_qbra.tst
-TESTCASES += precequ_ph_qbr.tst
-TESTCASES += preceq_w_phl.tst
-TESTCASES += preceq_w_phr.tst
-TESTCASES += preceu_ph_qbla.tst
-TESTCASES += preceu_ph_qbl.tst
-TESTCASES += preceu_ph_qbra.tst
-TESTCASES += preceu_ph_qbr.tst
-TESTCASES += precrq_ph_w.tst
-TESTCASES += precrq_qb_ph.tst
-TESTCASES += precrq_rs_ph_w.tst
-TESTCASES += precrqu_s_qb_ph.tst
-TESTCASES += raddu_w_qb.tst
-TESTCASES += rddsp.tst
-TESTCASES += repl_ph.tst
-TESTCASES += repl_qb.tst
-TESTCASES += replv_ph.tst
-TESTCASES += replv_qb.tst
-TESTCASES += shilo.tst
-TESTCASES += shilov.tst
-TESTCASES += shll_ph.tst
-TESTCASES += shll_qb.tst
-TESTCASES += shll_s_ph.tst
-TESTCASES += shll_s_w.tst
-TESTCASES += shllv_ph.tst
-TESTCASES += shllv_qb.tst
-TESTCASES += shllv_s_ph.tst
-TESTCASES += shllv_s_w.tst
-TESTCASES += shra_ph.tst
-TESTCASES += shra_r_ph.tst
-TESTCASES += shra_r_w.tst
-TESTCASES += shrav_ph.tst
-TESTCASES += shrav_r_ph.tst
-TESTCASES += shrav_r_w.tst
-TESTCASES += shrl_qb.tst
-TESTCASES += shrlv_qb.tst
-TESTCASES += subq_ph.tst
-TESTCASES += subq_s_ph.tst
-TESTCASES += subq_s_w.tst
-TESTCASES += subu_qb.tst
-TESTCASES += subu_s_qb.tst
-TESTCASES += wrdsp.tst
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) $(CFLAGS) $< -o $@
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-        echo $(SIM) $(SIM_FLAGS) ./$$case;\
-        $(SIM) $(SIM_FLAGS) ./$$case; \
-	done
-
-clean:
-	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/mips/mips32-dspr2/Makefile b/tests/tcg/mips/mips32-dspr2/Makefile
deleted file mode 100644
index ed19581..0000000
--- a/tests/tcg/mips/mips32-dspr2/Makefile
+++ /dev/null
@@ -1,71 +0,0 @@
--include ../../config-host.mak
-
-CROSS=mips64el-unknown-linux-gnu-
-
-SIM=qemu-mipsel
-SIM_FLAGS=-cpu 74Kf
-
-CC      = $(CROSS)gcc
-CFLAGS  = -mabi=32 -march=mips32r2 -mgp32 -mdspr2 -static
-
-TESTCASES = absq_s_qb.tst
-TESTCASES += addqh_ph.tst
-TESTCASES += addqh_r_ph.tst
-TESTCASES += addqh_r_w.tst
-TESTCASES += addqh_w.tst
-TESTCASES += adduh_qb.tst
-TESTCASES += adduh_r_qb.tst
-TESTCASES += addu_ph.tst
-TESTCASES += addu_s_ph.tst
-TESTCASES += append.tst
-TESTCASES += balign.tst
-TESTCASES += cmpgdu_eq_qb.tst
-TESTCASES += cmpgdu_le_qb.tst
-TESTCASES += cmpgdu_lt_qb.tst
-TESTCASES += dpaqx_sa_w_ph.tst
-TESTCASES += dpa_w_ph.tst
-TESTCASES += dpax_w_ph.tst
-TESTCASES += dpaqx_s_w_ph.tst
-TESTCASES += dpsqx_sa_w_ph.tst
-TESTCASES += dpsqx_s_w_ph.tst
-TESTCASES += dps_w_ph.tst
-TESTCASES += dpsx_w_ph.tst
-TESTCASES += mul_ph.tst
-TESTCASES += mulq_rs_w.tst
-TESTCASES += mulq_s_ph.tst
-TESTCASES += mulq_s_w.tst
-TESTCASES += mulsaq_s_w_ph.tst
-TESTCASES += mulsa_w_ph.tst
-TESTCASES += mul_s_ph.tst
-TESTCASES += precr_qb_ph.tst
-TESTCASES += precr_sra_ph_w.tst
-TESTCASES += precr_sra_r_ph_w.tst
-TESTCASES += prepend.tst
-TESTCASES += shra_qb.tst
-TESTCASES += shra_r_qb.tst
-TESTCASES += shrav_qb.tst
-TESTCASES += shrav_r_qb.tst
-TESTCASES += shrl_ph.tst
-TESTCASES += shrlv_ph.tst
-TESTCASES += subqh_ph.tst
-TESTCASES += subqh_r_ph.tst
-TESTCASES += subqh_r_w.tst
-TESTCASES += subqh_w.tst
-TESTCASES += subuh_qb.tst
-TESTCASES += subuh_r_qb.tst
-TESTCASES += subu_ph.tst
-TESTCASES += subu_s_ph.tst
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) $(CFLAGS) $< -o $@
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-        echo $(SIM) $(SIM_FLAGS) ./$$case;\
-		$(SIM) $(SIM_FLAGS) ./$$case; \
-	done
-
-clean:
-	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/mips/mips64-dsp/Makefile b/tests/tcg/mips/mips64-dsp/Makefile
deleted file mode 100644
index b2ac6b3..0000000
--- a/tests/tcg/mips/mips64-dsp/Makefile
+++ /dev/null
@@ -1,306 +0,0 @@
-
-CROSS_COMPILE	?= mips64el-unknown-linux-gnu-
-
-SIM = qemu-system-mips64el
-SIMFLAGS = -nographic -cpu mips64dspr2 -kernel
-
-AS      = $(CROSS_COMPILE)as
-LD      = $(CROSS_COMPILE)ld
-CC      = $(CROSS_COMPILE)gcc
-AR      = $(CROSS_COMPILE)ar
-NM      = $(CROSS_COMPILE)nm
-STRIP       = $(CROSS_COMPILE)strip
-RANLIB      = $(CROSS_COMPILE)ranlib
-OBJCOPY     = $(CROSS_COMPILE)objcopy
-OBJDUMP     = $(CROSS_COMPILE)objdump
-
-VECTORS_OBJ ?= ./head.o ./printf.o
-
-HEAD_FLAGS ?= -nostdinc -mabi=64 -G 0 -mno-abicalls -fno-pic -pipe \
-              -msoft-float -march=mips64 -Wa,-mips64 -Wa,--trap \
-              -msym32 -DKBUILD_64BIT_SYM32 -I./
-
-CFLAGS ?= -nostdinc -mabi=64 -G 0 -mno-abicalls -fno-pic -fno-builtin  \
-          -pipe -march=mips64r2 -mgp64 -mdsp -static -Wa,--trap -msym32 \
-          -DKBUILD_64BIT_SYM32 -I./
-
-LDFLAGS = -T./mips_boot.lds -L./
-FLAGS = -nostdlib -mabi=64 -march=mips64r2 -mgp64 -mdsp
-
-
-#TESTCASES = absq_s_ob.tst
-TESTCASES = absq_s_ph.tst
-TESTCASES += absq_s_pw.tst
-TESTCASES += absq_s_qh.tst
-TESTCASES += absq_s_w.tst
-TESTCASES += addq_ph.tst
-TESTCASES += addq_pw.tst
-TESTCASES += addq_qh.tst
-TESTCASES += addq_s_ph.tst
-TESTCASES += addq_s_pw.tst
-TESTCASES += addq_s_qh.tst
-TESTCASES += addq_s_w.tst
-TESTCASES += addsc.tst
-TESTCASES += addu_ob.tst
-TESTCASES += addu_qb.tst
-TESTCASES += addu_s_ob.tst
-TESTCASES += addu_s_qb.tst
-TESTCASES += addwc.tst
-TESTCASES += bitrev.tst
-TESTCASES += bposge32.tst
-TESTCASES += bposge64.tst
-TESTCASES += cmp_eq_ph.tst
-TESTCASES += cmp_eq_pw.tst
-TESTCASES += cmp_eq_qh.tst
-TESTCASES += cmpgu_eq_ob.tst
-TESTCASES += cmpgu_eq_qb.tst
-TESTCASES += cmpgu_le_ob.tst
-TESTCASES += cmpgu_le_qb.tst
-TESTCASES += cmpgu_lt_ob.tst
-TESTCASES += cmpgu_lt_qb.tst
-TESTCASES += cmp_le_ph.tst
-TESTCASES += cmp_le_pw.tst
-TESTCASES += cmp_le_qh.tst
-TESTCASES += cmp_lt_ph.tst
-TESTCASES += cmp_lt_pw.tst
-TESTCASES += cmp_lt_qh.tst
-TESTCASES += cmpu_eq_ob.tst
-TESTCASES += cmpu_eq_qb.tst
-TESTCASES += cmpu_le_ob.tst
-TESTCASES += cmpu_le_qb.tst
-TESTCASES += cmpu_lt_ob.tst
-TESTCASES += cmpu_lt_qb.tst
-#TESTCASES += dappend.tst
-TESTCASES += dextp.tst
-TESTCASES += dextpdp.tst
-TESTCASES += dextpdpv.tst
-TESTCASES += dextpv.tst
-TESTCASES += dextr_l.tst
-TESTCASES += dextr_r_l.tst
-TESTCASES += dextr_rs_l.tst
-TESTCASES += dextr_rs_w.tst
-TESTCASES += dextr_r_w.tst
-TESTCASES += dextr_s_h.tst
-TESTCASES += dextrv_l.tst
-TESTCASES += dextrv_r_l.tst
-TESTCASES += dextrv_rs_l.tst
-TESTCASES += dextrv_rs_w.tst
-TESTCASES += dextrv_r_w.tst
-TESTCASES += dextrv_s_h.tst
-TESTCASES += dextrv_w.tst
-TESTCASES += dextr_w.tst
-TESTCASES += dinsv.tst
-TESTCASES += dmadd.tst
-TESTCASES += dmaddu.tst
-TESTCASES += dmsub.tst
-TESTCASES += dmsubu.tst
-TESTCASES += dmthlip.tst
-TESTCASES += dpaq_sa_l_pw.tst
-TESTCASES += dpaq_sa_l_w.tst
-TESTCASES += dpaq_s_w_ph.tst
-TESTCASES += dpaq_s_w_qh.tst
-TESTCASES += dpau_h_obl.tst
-TESTCASES += dpau_h_obr.tst
-TESTCASES += dpau_h_qbl.tst
-TESTCASES += dpau_h_qbr.tst
-TESTCASES += dpsq_sa_l_pw.tst
-TESTCASES += dpsq_sa_l_w.tst
-TESTCASES += dpsq_s_w_ph.tst
-TESTCASES += dpsq_s_w_qh.tst
-TESTCASES += dpsu_h_obl.tst
-TESTCASES += dpsu_h_obr.tst
-TESTCASES += dpsu_h_qbl.tst
-TESTCASES += dpsu_h_qbr.tst
-TESTCASES += dshilo.tst
-TESTCASES += dshilov.tst
-TESTCASES += extp.tst
-TESTCASES += extpdp.tst
-TESTCASES += extpdpv.tst
-TESTCASES += extpv.tst
-TESTCASES += extr_rs_w.tst
-TESTCASES += extr_r_w.tst
-TESTCASES += extr_s_h.tst
-TESTCASES += extrv_rs_w.tst
-TESTCASES += extrv_r_w.tst
-TESTCASES += extrv_s_h.tst
-TESTCASES += extrv_w.tst
-TESTCASES += extr_w.tst
-TESTCASES += insv.tst
-TESTCASES += lbux.tst
-TESTCASES += lhx.tst
-TESTCASES += lwx.tst
-TESTCASES += ldx.tst
-TESTCASES += madd.tst
-TESTCASES += maddu.tst
-TESTCASES += maq_sa_w_phl.tst
-TESTCASES += maq_sa_w_phr.tst
-TESTCASES += maq_sa_w_qhll.tst
-TESTCASES += maq_sa_w_qhlr.tst
-TESTCASES += maq_sa_w_qhrl.tst
-TESTCASES += maq_sa_w_qhrr.tst
-TESTCASES += maq_s_l_pwl.tst
-TESTCASES += maq_s_l_pwr.tst
-TESTCASES += maq_s_w_phl.tst
-TESTCASES += maq_s_w_phr.tst
-TESTCASES += maq_s_w_qhll.tst
-TESTCASES += maq_s_w_qhlr.tst
-TESTCASES += maq_s_w_qhrl.tst
-TESTCASES += maq_s_w_qhrr.tst
-TESTCASES += mfhi.tst
-TESTCASES += mflo.tst
-TESTCASES += modsub.tst
-TESTCASES += msub.tst
-TESTCASES += msubu.tst
-TESTCASES += mthi.tst
-TESTCASES += mthlip.tst
-TESTCASES += mtlo.tst
-TESTCASES += muleq_s_pw_qhl.tst
-TESTCASES += muleq_s_pw_qhr.tst
-TESTCASES += muleq_s_w_phl.tst
-TESTCASES += muleq_s_w_phr.tst
-TESTCASES += muleu_s_ph_qbl.tst
-TESTCASES += muleu_s_ph_qbr.tst
-TESTCASES += muleu_s_qh_obl.tst
-TESTCASES += muleu_s_qh_obr.tst
-TESTCASES += mulq_rs_ph.tst
-TESTCASES += mulq_rs_qh.tst
-TESTCASES += mulsaq_s_l_pw.tst
-TESTCASES += mulsaq_s_w_qh.tst
-TESTCASES += mult.tst
-TESTCASES += multu.tst
-TESTCASES += packrl_ph.tst
-TESTCASES += packrl_pw.tst
-TESTCASES += pick_ob.tst
-TESTCASES += pick_ph.tst
-TESTCASES += pick_pw.tst
-TESTCASES += pick_qb.tst
-TESTCASES += pick_qh.tst
-#TESTCASES += preceq_l_pwl.tst
-#TESTCASES += preceq_l_pwr.tst
-TESTCASES += preceq_pw_qhla.tst
-TESTCASES += preceq_pw_qhl.tst
-TESTCASES += preceq_pw_qhra.tst
-TESTCASES += preceq_pw_qhr.tst
-TESTCASES += precequ_ph_qbla.tst
-TESTCASES += precequ_ph_qbl.tst
-TESTCASES += precequ_ph_qbra.tst
-TESTCASES += precequ_ph_qbr.tst
-#TESTCASES += precequ_qh_obla.tst
-#TESTCASES += precequ_qh_obl.tst
-#TESTCASES += precequ_qh_obra.tst
-#TESTCASES += precequ_qh_obr.tst
-TESTCASES += preceq_w_phl.tst
-TESTCASES += preceq_w_phr.tst
-TESTCASES += preceu_ph_qbla.tst
-TESTCASES += preceu_ph_qbl.tst
-TESTCASES += preceu_ph_qbra.tst
-TESTCASES += preceu_ph_qbr.tst
-TESTCASES += preceu_qh_obla.tst
-TESTCASES += preceu_qh_obl.tst
-TESTCASES += preceu_qh_obra.tst
-TESTCASES += preceu_qh_obr.tst
-#TESTCASES += precr_ob_qh.tst
-TESTCASES += precrq_ob_qh.tst
-TESTCASES += precrq_ph_w.tst
-TESTCASES += precrq_pw_l.tst
-TESTCASES += precrq_qb_ph.tst
-TESTCASES += precrq_qh_pw.tst
-TESTCASES += precrq_rs_ph_w.tst
-TESTCASES += precrq_rs_qh_pw.tst
-TESTCASES += precrqu_s_ob_qh.tst
-TESTCASES += precrqu_s_qb_ph.tst
-#TESTCASES += precr_sra_qh_pw.tst
-#TESTCASES += precr_sra_r_qh_pw.tst
-#TESTCASES += prependd.tst
-#TESTCASES += prependw.tst
-#TESTCASES += raddu_l_ob.tst
-TESTCASES += raddu_w_qb.tst
-TESTCASES += rddsp.tst
-TESTCASES += repl_ob.tst
-TESTCASES += repl_ph.tst
-TESTCASES += repl_pw.tst
-TESTCASES += repl_qb.tst
-TESTCASES += repl_qh.tst
-TESTCASES += replv_ob.tst
-TESTCASES += replv_ph.tst
-TESTCASES += replv_pw.tst
-TESTCASES += replv_qb.tst
-TESTCASES += shilo.tst
-TESTCASES += shilov.tst
-TESTCASES += shll_ob.tst
-TESTCASES += shll_ph.tst
-TESTCASES += shll_pw.tst
-TESTCASES += shll_qb.tst
-TESTCASES += shll_qh.tst
-TESTCASES += shll_s_ph.tst
-TESTCASES += shll_s_pw.tst
-TESTCASES += shll_s_qh.tst
-TESTCASES += shll_s_w.tst
-TESTCASES += shllv_ob.tst
-TESTCASES += shllv_ph.tst
-TESTCASES += shllv_pw.tst
-TESTCASES += shllv_qb.tst
-TESTCASES += shllv_qh.tst
-TESTCASES += shllv_s_ph.tst
-TESTCASES += shllv_s_pw.tst
-TESTCASES += shllv_s_qh.tst
-TESTCASES += shllv_s_w.tst
-#TESTCASES += shra_ob.tst
-TESTCASES += shra_ph.tst
-TESTCASES += shra_pw.tst
-TESTCASES += shra_qh.tst
-#TESTCASES += shra_r_ob.tst
-TESTCASES += shra_r_ph.tst
-TESTCASES += shra_r_pw.tst
-TESTCASES += shra_r_qh.tst
-TESTCASES += shra_r_w.tst
-TESTCASES += shrav_ph.tst
-TESTCASES += shrav_pw.tst
-TESTCASES += shrav_qh.tst
-TESTCASES += shrav_r_ph.tst
-TESTCASES += shrav_r_pw.tst
-TESTCASES += shrav_r_qh.tst
-TESTCASES += shrav_r_w.tst
-TESTCASES += shrl_ob.tst
-TESTCASES += shrl_qb.tst
-#TESTCASES += shrl_qh.tst
-TESTCASES += shrlv_ob.tst
-TESTCASES += shrlv_qb.tst
-#TESTCASES += shrlv_qh.tst
-TESTCASES += subq_ph.tst
-TESTCASES += subq_pw.tst
-TESTCASES += subq_qh.tst
-TESTCASES += subq_s_ph.tst
-TESTCASES += subq_s_pw.tst
-TESTCASES += subq_s_qh.tst
-TESTCASES += subq_s_w.tst
-TESTCASES += subu_ob.tst
-TESTCASES += subu_qb.tst
-TESTCASES += subu_s_ob.tst
-TESTCASES += subu_s_qb.tst
-TESTCASES += wrdsp.tst
-
-all: build
-
-head.o : head.S
-	$(Q)$(CC) $(HEAD_FLAGS) -D"STACK_TOP=0xffffffff80200000" -c $< -o $@
-
-%.o  : %.S
-	$(CC) $(CFLAGS) -c $< -o $@
-
-%.o  : %.c
-	$(CC) $(CFLAGS) -c $< -o $@
-
-%.tst: %.o $(VECTORS_OBJ)
-	$(CC) $(VECTORS_OBJ) $(FLAGS) $(LDFLAGS) $< -o $@
-
-build: $(VECTORS_OBJ) $(MIPSSOC_LIB) $(TESTCASES)
-
-check:  $(VECTORS_OBJ) $(MIPSSOC_LIB) $(TESTCASES)
-	@for case in $(TESTCASES); do \
-		echo $(SIM) $(SIMFLAGS) ./$$case; \
-		$(SIM) $(SIMFLAGS) ./$$case & (sleep 1; killall $(SIM)); \
-	done
-
-clean:
-	$(Q)rm -f *.o *.tst *.a
diff --git a/tests/tcg/mips/mips64-dsp/head.S b/tests/tcg/mips/mips64-dsp/head.S
deleted file mode 100644
index 9a099ae..0000000
--- a/tests/tcg/mips/mips64-dsp/head.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- *  Startup Code for MIPS64 CPU-core
- *
- */
-.text
-.globl _start
-.align 4
-_start:
-    ori    $2, $2, 0xffff
-    sll    $2, $2, 16
-    ori    $2, $2, 0xffff
-    mtc0   $2, $12, 0
-    jal    main
-
-end:
-    b end
diff --git a/tests/tcg/mips/mips64-dsp/io.h b/tests/tcg/mips/mips64-dsp/io.h
deleted file mode 100644
index b7db61d..0000000
--- a/tests/tcg/mips/mips64-dsp/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef _ASM_IO_H
-#define _ASM_IO_H
-extern int printf(const char *fmt, ...);
-extern unsigned long get_ticks(void);
-
-#define _read(source)                \
-({ unsigned long __res;                \
-    __asm__ __volatile__(            \
-        "mfc0\t%0, " #source "\n\t"    \
-        : "=r" (__res));        \
-    __res;                    \
-})
-
-#define __read(source)                \
-({ unsigned long __res;                \
-    __asm__ __volatile__(            \
-        "move\t%0, " #source "\n\t"    \
-        : "=r" (__res));        \
-    __res;                    \
-})
-
-#endif
diff --git a/tests/tcg/mips/mips64-dsp/mips_boot.lds b/tests/tcg/mips/mips64-dsp/mips_boot.lds
deleted file mode 100644
index bd7c0c0..0000000
--- a/tests/tcg/mips/mips64-dsp/mips_boot.lds
+++ /dev/null
@@ -1,31 +0,0 @@
-OUTPUT_ARCH(mips)
-SECTIONS
-{
-    . = 0xffffffff80100000;
-    . = ALIGN((1 << 13));
-    .text :
-    {
-        *(.text)
-        *(.rodata)
-        *(.rodata.*)
-    }
-
-    __init_begin = .;
-    . = ALIGN((1 << 12));
-    .init.text : AT(ADDR(.init.text) - 0)
-    {
-        *(.init.text)
-    }
-    .init.data : AT(ADDR(.init.data) - 0)
-    {
-        *(.init.data)
-    }
-    . = ALIGN((1 << 12));
-    __init_end = .;
-
-    . = ALIGN((1 << 13));
-    .data :
-    {
-        *(.data)
-    }
-}
diff --git a/tests/tcg/mips/mips64-dspr2/.directory b/tests/tcg/mips/mips64-dspr2/.directory
deleted file mode 100644
index c75a914..0000000
--- a/tests/tcg/mips/mips64-dspr2/.directory
+++ /dev/null
@@ -1,2 +0,0 @@
-[Dolphin]
-Timestamp=2012,8,3,16,41,52
diff --git a/tests/tcg/mips/mips64-dspr2/Makefile b/tests/tcg/mips/mips64-dspr2/Makefile
deleted file mode 100644
index ba44bb9..0000000
--- a/tests/tcg/mips/mips64-dspr2/Makefile
+++ /dev/null
@@ -1,116 +0,0 @@
-CROSS_COMPILE	?= mips64el-unknown-linux-gnu-
-
-SIM = qemu-system-mips64el
-SIMFLAGS = -nographic -cpu mips64dspr2 -kernel
-
-AS      = $(CROSS_COMPILE)as
-LD      = $(CROSS_COMPILE)ld
-CC      = $(CROSS_COMPILE)gcc
-AR      = $(CROSS_COMPILE)ar
-NM      = $(CROSS_COMPILE)nm
-STRIP       = $(CROSS_COMPILE)strip
-RANLIB      = $(CROSS_COMPILE)ranlib
-OBJCOPY     = $(CROSS_COMPILE)objcopy
-OBJDUMP     = $(CROSS_COMPILE)objdump
-
-VECTORS_OBJ ?= ./head.o ./printf.o
-
-HEAD_FLAGS ?= -nostdinc -mabi=64 -G 0 -mno-abicalls -fno-pic -pipe \
-              -msoft-float -march=mips64 -Wa,-mips64 -Wa,--trap \
-              -msym32 -DKBUILD_64BIT_SYM32 -I./
-
-CFLAGS ?= -nostdinc -mabi=64 -G 0 -mno-abicalls -fno-pic -fno-builtin  \
-          -pipe -march=mips64r2 -mgp64 -mdspr2 -static -Wa,--trap -msym32 \
-          -DKBUILD_64BIT_SYM32 -I./
-
-LDFLAGS = -T./mips_boot.lds -L./
-FLAGS = -nostdlib -mabi=64 -march=mips64r2 -mgp64 -mdspr2
-
-TESTCASES = absq_s_qb.tst
-TESTCASES += addqh_ph.tst
-TESTCASES += addqh_r_ph.tst
-TESTCASES += addqh_r_w.tst
-TESTCASES += addqh_w.tst
-#TESTCASES += adduh_ob.tst
-TESTCASES += adduh_qb.tst
-#TESTCASES += adduh_r_ob.tst
-TESTCASES += adduh_r_qb.tst
-TESTCASES += addu_ph.tst
-#TESTCASES += addu_qh.tst
-TESTCASES += addu_s_ph.tst
-#TESTCASES += addu_s_qh.tst
-TESTCASES += append.tst
-TESTCASES += balign.tst
-#TESTCASES += cmpgdu_eq_ob.tst
-TESTCASES += cmpgdu_eq_qb.tst
-#TESTCASES += cmpgdu_le_ob.tst
-TESTCASES += cmpgdu_le_qb.tst
-#TESTCASES += cmpgdu_lt_ob.tst
-TESTCASES += cmpgdu_lt_qb.tst
-#TESTCASES += dbalign.tst
-TESTCASES += dpaqx_sa_w_ph.tst
-TESTCASES += dpaqx_s_w_ph.tst
-TESTCASES += dpa_w_ph.tst
-#TESTCASES += dpa_w_qh.tst
-TESTCASES += dpax_w_ph.tst
-TESTCASES += dpsqx_sa_w_ph.tst
-TESTCASES += dpsqx_s_w_ph.tst
-TESTCASES += dps_w_ph.tst
-#TESTCASES += dps_w_qh.tst
-TESTCASES += dpsx_w_ph.tst
-TESTCASES += mul_ph.tst
-TESTCASES += mulq_rs_w.tst
-TESTCASES += mulq_s_ph.tst
-TESTCASES += mulq_s_w.tst
-TESTCASES += mulsaq_s_w_ph.tst
-TESTCASES += mulsa_w_ph.tst
-TESTCASES += mul_s_ph.tst
-TESTCASES += precr_qb_ph.tst
-TESTCASES += precr_sra_ph_w.tst
-TESTCASES += precr_sra_r_ph_w.tst
-TESTCASES += prepend.tst
-TESTCASES += shra_qb.tst
-TESTCASES += shra_r_qb.tst
-#TESTCASES += shrav_ob.tst
-TESTCASES += shrav_qb.tst
-#TESTCASES += shrav_r_ob.tst
-TESTCASES += shrav_r_qb.tst
-TESTCASES += shrl_ph.tst
-TESTCASES += shrlv_ph.tst
-TESTCASES += subqh_ph.tst
-TESTCASES += subqh_r_ph.tst
-TESTCASES += subqh_r_w.tst
-TESTCASES += subqh_w.tst
-#TESTCASES += subuh_ob.tst
-TESTCASES += subuh_qb.tst
-#TESTCASES += subuh_r_ob.tst
-TESTCASES += subuh_r_qb.tst
-TESTCASES += subu_ph.tst
-#TESTCASES += subu_qh.tst
-TESTCASES += subu_s_ph.tst
-#TESTCASES += subu_s_qh.tst
-
-all: build
-
-head.o : head.S
-	$(Q)$(CC) $(HEAD_FLAGS) -D"STACK_TOP=0xffffffff80200000" -c $< -o $@
-
-%.o  : %.S
-	$(CC) $(CFLAGS) -c $< -o $@
-
-%.o  : %.c
-	$(CC) $(CFLAGS) -c $< -o $@
-
-%.tst: %.o $(VECTORS_OBJ)
-	$(CC) $(VECTORS_OBJ) $(FLAGS) $(LDFLAGS) $< -o $@
-
-build: $(VECTORS_OBJ) $(MIPSSOC_LIB) $(TESTCASES)
-
-check:  $(VECTORS_OBJ) $(MIPSSOC_LIB) $(TESTCASES)
-	@for case in $(TESTCASES); do \
-		echo $(SIM) $(SIMFLAGS) ./$$case; \
-		$(SIM) $(SIMFLAGS) ./$$case & (sleep 1; killall $(SIM)); \
-	done
-
-clean:
-	$(Q)rm -f *.o *.tst *.a
diff --git a/tests/tcg/mips/mips64-dspr2/head.S b/tests/tcg/mips/mips64-dspr2/head.S
deleted file mode 100644
index 9a099ae..0000000
--- a/tests/tcg/mips/mips64-dspr2/head.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- *  Startup Code for MIPS64 CPU-core
- *
- */
-.text
-.globl _start
-.align 4
-_start:
-    ori    $2, $2, 0xffff
-    sll    $2, $2, 16
-    ori    $2, $2, 0xffff
-    mtc0   $2, $12, 0
-    jal    main
-
-end:
-    b end
diff --git a/tests/tcg/mips/mips64-dspr2/io.h b/tests/tcg/mips/mips64-dspr2/io.h
deleted file mode 100644
index b7db61d..0000000
--- a/tests/tcg/mips/mips64-dspr2/io.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef _ASM_IO_H
-#define _ASM_IO_H
-extern int printf(const char *fmt, ...);
-extern unsigned long get_ticks(void);
-
-#define _read(source)                \
-({ unsigned long __res;                \
-    __asm__ __volatile__(            \
-        "mfc0\t%0, " #source "\n\t"    \
-        : "=r" (__res));        \
-    __res;                    \
-})
-
-#define __read(source)                \
-({ unsigned long __res;                \
-    __asm__ __volatile__(            \
-        "move\t%0, " #source "\n\t"    \
-        : "=r" (__res));        \
-    __res;                    \
-})
-
-#endif
diff --git a/tests/tcg/mips/mips64-dspr2/mips_boot.lds b/tests/tcg/mips/mips64-dspr2/mips_boot.lds
deleted file mode 100644
index bd7c0c0..0000000
--- a/tests/tcg/mips/mips64-dspr2/mips_boot.lds
+++ /dev/null
@@ -1,31 +0,0 @@
-OUTPUT_ARCH(mips)
-SECTIONS
-{
-    . = 0xffffffff80100000;
-    . = ALIGN((1 << 13));
-    .text :
-    {
-        *(.text)
-        *(.rodata)
-        *(.rodata.*)
-    }
-
-    __init_begin = .;
-    . = ALIGN((1 << 12));
-    .init.text : AT(ADDR(.init.text) - 0)
-    {
-        *(.init.text)
-    }
-    .init.data : AT(ADDR(.init.data) - 0)
-    {
-        *(.init.data)
-    }
-    . = ALIGN((1 << 12));
-    __init_end = .;
-
-    . = ALIGN((1 << 13));
-    .data :
-    {
-        *(.data)
-    }
-}
diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
deleted file mode 100644
index 27ee5d5..0000000
--- a/tests/tcg/mips/mipsr5900/Makefile
+++ /dev/null
@@ -1,32 +0,0 @@
--include ../../config-host.mak
-
-CROSS=mipsr5900el-unknown-linux-gnu-
-
-SIM=qemu-mipsel
-SIM_FLAGS=-cpu R5900
-
-CC      = $(CROSS)gcc
-CFLAGS  = -Wall -mabi=32 -march=r5900 -static
-
-TESTCASES = div1.tst
-TESTCASES += divu1.tst
-TESTCASES += madd.tst
-TESTCASES += maddu.tst
-TESTCASES += mflohi1.tst
-TESTCASES += mtlohi1.tst
-TESTCASES += mult.tst
-TESTCASES += multu.tst
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) $(CFLAGS) $< -o $@
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-        echo $(SIM) $(SIM_FLAGS) ./$$case;\
-        $(SIM) $(SIM_FLAGS) ./$$case; \
-	done
-
-clean:
-	$(RM) -rf $(TESTCASES)
-- 
2.7.4
