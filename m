Received: from eggs.gnu.org ([209.51.188.92]:58490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmgo7-0002nf-Rh
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmgo1-0007Ou-Ry
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:20:43 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37214 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gmgnq-0006Ww-Vf
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:20:30 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 24 Jan 2019 16:19:11 +0100
Message-Id: <1548343154-8774-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 0/3] tests: Reorganize MIPS TCG directories
 and files
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

Reorganize MIPS TCG directories and files. 

Directories for DSP tests in system mode are deleted. They
introduce more complexity in test structure compared to the
value they add. Still, these tests may be moved somewhere
else, let's say in a new acceptance test that will boot
"mips64r2" virtual machine.

All remaining test will are user mode tests, which will
simplify maintenance of mips tcg tests overall.

The file movement is done using "git mv" command, so "git
blame" will still display the original information, regardless
of the new names and locations of involved files. Also, the
command "git config diff.renames true" was used to keep the
size of movement patches reasonable.

v3->v4:
  - DSP ASE system mode tests given up
  - Makefiles provided for tests that remain

v2->v3:
  - corrected missing "v2" that caused wrong message linking
    (the version is now "v3", of course) 

v1->v2:
  - used "git config diff.renames true" before sending
  - rebased to the latest code (included newly added r5900 tests)


Aleksandar Markovic (3):
  tests: tcg: mips: Move source files to new locations
  tests: tcg: mips: Add two new Makefiles
  tests: tcg: mips: Remove old directories

 tests/tcg/mips/mips32-dsp/Makefile                 | 136 ---------
 tests/tcg/mips/mips32-dspr2/Makefile               |  71 -----
 tests/tcg/mips/mips64-dsp/Makefile                 | 306 ---------------------
 tests/tcg/mips/mips64-dsp/absq_s_ob.c              |  63 -----
 tests/tcg/mips/mips64-dsp/absq_s_ph.c              |  37 ---
 tests/tcg/mips/mips64-dsp/absq_s_pw.c              |  66 -----
 tests/tcg/mips/mips64-dsp/absq_s_qh.c              |  40 ---
 tests/tcg/mips/mips64-dsp/absq_s_w.c               |  48 ----
 tests/tcg/mips/mips64-dsp/addq_ph.c                |  57 ----
 tests/tcg/mips/mips64-dsp/addq_pw.c                |  46 ----
 tests/tcg/mips/mips64-dsp/addq_qh.c                |  28 --
 tests/tcg/mips/mips64-dsp/addq_s_ph.c              |  84 ------
 tests/tcg/mips/mips64-dsp/addq_s_pw.c              |  45 ---
 tests/tcg/mips/mips64-dsp/addq_s_qh.c              |  26 --
 tests/tcg/mips/mips64-dsp/addq_s_w.c               |  48 ----
 tests/tcg/mips/mips64-dsp/addsc.c                  |  39 ---
 tests/tcg/mips/mips64-dsp/addu_ob.c                |  28 --
 tests/tcg/mips/mips64-dsp/addu_qb.c                |  40 ---
 tests/tcg/mips/mips64-dsp/addu_s_ob.c              |  27 --
 tests/tcg/mips/mips64-dsp/addu_s_qb.c              |  40 ---
 tests/tcg/mips/mips64-dsp/addwc.c                  |  59 ----
 tests/tcg/mips/mips64-dsp/bitrev.c                 |  23 --
 tests/tcg/mips/mips64-dsp/bposge32.c               |  50 ----
 tests/tcg/mips/mips64-dsp/bposge64.c               |  50 ----
 tests/tcg/mips/mips64-dsp/cmp_eq_ph.c              |  42 ---
 tests/tcg/mips/mips64-dsp/cmp_eq_pw.c              |  46 ----
 tests/tcg/mips/mips64-dsp/cmp_eq_qh.c              |  46 ----
 tests/tcg/mips/mips64-dsp/cmp_le_ph.c              |  40 ---
 tests/tcg/mips/mips64-dsp/cmp_le_pw.c              |  46 ----
 tests/tcg/mips/mips64-dsp/cmp_le_qh.c              |  46 ----
 tests/tcg/mips/mips64-dsp/cmp_lt_ph.c              |  41 ---
 tests/tcg/mips/mips64-dsp/cmp_lt_pw.c              |  46 ----
 tests/tcg/mips/mips64-dsp/cmp_lt_qh.c              |  46 ----
 tests/tcg/mips/mips64-dsp/cmpgu_eq_ob.c            |  40 ---
 tests/tcg/mips/mips64-dsp/cmpgu_eq_qb.c            |  38 ---
 tests/tcg/mips/mips64-dsp/cmpgu_le_ob.c            |  40 ---
 tests/tcg/mips/mips64-dsp/cmpgu_le_qb.c            |  37 ---
 tests/tcg/mips/mips64-dsp/cmpgu_lt_ob.c            |  40 ---
 tests/tcg/mips/mips64-dsp/cmpgu_lt_qb.c            |  38 ---
 tests/tcg/mips/mips64-dsp/cmpu_eq_ob.c             |  46 ----
 tests/tcg/mips/mips64-dsp/cmpu_eq_qb.c             |  42 ---
 tests/tcg/mips/mips64-dsp/cmpu_le_ob.c             |  44 ---
 tests/tcg/mips/mips64-dsp/cmpu_le_qb.c             |  41 ---
 tests/tcg/mips/mips64-dsp/cmpu_lt_ob.c             |  44 ---
 tests/tcg/mips/mips64-dsp/cmpu_lt_qb.c             |  42 ---
 tests/tcg/mips/mips64-dsp/dappend.c                |  37 ---
 tests/tcg/mips/mips64-dsp/dextp.c                  |  54 ----
 tests/tcg/mips/mips64-dsp/dextpdp.c                |  59 ----
 tests/tcg/mips/mips64-dsp/dextpdpv.c               |  63 -----
 tests/tcg/mips/mips64-dsp/dextpv.c                 |  58 ----
 tests/tcg/mips/mips64-dsp/dextr_l.c                |  44 ---
 tests/tcg/mips/mips64-dsp/dextr_r_l.c              |  54 ----
 tests/tcg/mips/mips64-dsp/dextr_r_w.c              |  54 ----
 tests/tcg/mips/mips64-dsp/dextr_rs_l.c             |  52 ----
 tests/tcg/mips/mips64-dsp/dextr_rs_w.c             |  52 ----
 tests/tcg/mips/mips64-dsp/dextr_s_h.c              |  73 -----
 tests/tcg/mips/mips64-dsp/dextr_w.c                |  44 ---
 tests/tcg/mips/mips64-dsp/dextrv_l.c               |  46 ----
 tests/tcg/mips/mips64-dsp/dextrv_r_l.c             |  56 ----
 tests/tcg/mips/mips64-dsp/dextrv_r_w.c             |  56 ----
 tests/tcg/mips/mips64-dsp/dextrv_rs_l.c            |  54 ----
 tests/tcg/mips/mips64-dsp/dextrv_rs_w.c            |  54 ----
 tests/tcg/mips/mips64-dsp/dextrv_s_h.c             |  32 ---
 tests/tcg/mips/mips64-dsp/dextrv_w.c               |  46 ----
 tests/tcg/mips/mips64-dsp/dinsv.c                  |  26 --
 tests/tcg/mips/mips64-dsp/dmadd.c                  |  57 ----
 tests/tcg/mips/mips64-dsp/dmaddu.c                 |  56 ----
 tests/tcg/mips/mips64-dsp/dmsub.c                  |  59 ----
 tests/tcg/mips/mips64-dsp/dmsubu.c                 |  59 ----
 tests/tcg/mips/mips64-dsp/dmthlip.c                |  41 ---
 tests/tcg/mips/mips64-dsp/dpaq_s_w_ph.c            |  32 ---
 tests/tcg/mips/mips64-dsp/dpaq_s_w_qh.c            |  57 ----
 tests/tcg/mips/mips64-dsp/dpaq_sa_l_pw.c           |  88 ------
 tests/tcg/mips/mips64-dsp/dpaq_sa_l_w.c            |  82 ------
 tests/tcg/mips/mips64-dsp/dpau_h_obl.c             |  59 ----
 tests/tcg/mips/mips64-dsp/dpau_h_obr.c             |  59 ----
 tests/tcg/mips/mips64-dsp/dpau_h_qbl.c             |  29 --
 tests/tcg/mips/mips64-dsp/dpau_h_qbr.c             |  29 --
 tests/tcg/mips/mips64-dsp/dpsq_s_w_ph.c            |  51 ----
 tests/tcg/mips/mips64-dsp/dpsq_s_w_qh.c            |  56 ----
 tests/tcg/mips/mips64-dsp/dpsq_sa_l_pw.c           |  76 -----
 tests/tcg/mips/mips64-dsp/dpsq_sa_l_w.c            |  59 ----
 tests/tcg/mips/mips64-dsp/dpsu_h_obl.c             |  32 ---
 tests/tcg/mips/mips64-dsp/dpsu_h_obr.c             |  32 ---
 tests/tcg/mips/mips64-dsp/dpsu_h_qbl.c             |  29 --
 tests/tcg/mips/mips64-dsp/dpsu_h_qbr.c             |  29 --
 tests/tcg/mips/mips64-dsp/dshilo.c                 |  52 ----
 tests/tcg/mips/mips64-dsp/dshilov.c                |  54 ----
 tests/tcg/mips/mips64-dsp/extp.c                   |  50 ----
 tests/tcg/mips/mips64-dsp/extpdp.c                 |  51 ----
 tests/tcg/mips/mips64-dsp/extpdpv.c                |  52 ----
 tests/tcg/mips/mips64-dsp/extpv.c                  |  51 ----
 tests/tcg/mips/mips64-dsp/extr_r_w.c               |  53 ----
 tests/tcg/mips/mips64-dsp/extr_rs_w.c              |  53 ----
 tests/tcg/mips/mips64-dsp/extr_s_h.c               |  71 -----
 tests/tcg/mips/mips64-dsp/extr_w.c                 |  53 ----
 tests/tcg/mips/mips64-dsp/extrv_r_w.c              |  59 ----
 tests/tcg/mips/mips64-dsp/extrv_rs_w.c             |  59 ----
 tests/tcg/mips/mips64-dsp/extrv_s_h.c              |  79 ------
 tests/tcg/mips/mips64-dsp/extrv_w.c                |  59 ----
 tests/tcg/mips/mips64-dsp/head.S                   |  16 --
 tests/tcg/mips/mips64-dsp/insv.c                   |  26 --
 tests/tcg/mips/mips64-dsp/io.h                     |  22 --
 tests/tcg/mips/mips64-dsp/lbux.c                   |  27 --
 tests/tcg/mips/mips64-dsp/ldx.c                    |  27 --
 tests/tcg/mips/mips64-dsp/lhx.c                    |  27 --
 tests/tcg/mips/mips64-dsp/lwx.c                    |  27 --
 tests/tcg/mips/mips64-dsp/madd.c                   |  33 ---
 tests/tcg/mips/mips64-dsp/maddu.c                  |  33 ---
 tests/tcg/mips/mips64-dsp/maq_s_l_pwl.c            |  56 ----
 tests/tcg/mips/mips64-dsp/maq_s_l_pwr.c            |  56 ----
 tests/tcg/mips/mips64-dsp/maq_s_w_phl.c            |  60 ----
 tests/tcg/mips/mips64-dsp/maq_s_w_phr.c            |  60 ----
 tests/tcg/mips/mips64-dsp/maq_s_w_qhll.c           |  62 -----
 tests/tcg/mips/mips64-dsp/maq_s_w_qhlr.c           |  62 -----
 tests/tcg/mips/mips64-dsp/maq_s_w_qhrl.c           |  63 -----
 tests/tcg/mips/mips64-dsp/maq_s_w_qhrr.c           |  63 -----
 tests/tcg/mips/mips64-dsp/maq_sa_w_phl.c           |  60 ----
 tests/tcg/mips/mips64-dsp/maq_sa_w_phr.c           |  60 ----
 tests/tcg/mips/mips64-dsp/maq_sa_w_qhll.c          |  62 -----
 tests/tcg/mips/mips64-dsp/maq_sa_w_qhlr.c          |  64 -----
 tests/tcg/mips/mips64-dsp/maq_sa_w_qhrl.c          |  64 -----
 tests/tcg/mips/mips64-dsp/maq_sa_w_qhrr.c          |  64 -----
 tests/tcg/mips/mips64-dsp/mfhi.c                   |  24 --
 tests/tcg/mips/mips64-dsp/mflo.c                   |  24 --
 tests/tcg/mips/mips64-dsp/mips_boot.lds            |  31 ---
 tests/tcg/mips/mips64-dsp/modsub.c                 |  37 ---
 tests/tcg/mips/mips64-dsp/msub.c                   |  32 ---
 tests/tcg/mips/mips64-dsp/msubu.c                  |  32 ---
 tests/tcg/mips/mips64-dsp/mthi.c                   |  24 --
 tests/tcg/mips/mips64-dsp/mthlip.c                 |  61 ----
 tests/tcg/mips/mips64-dsp/mtlo.c                   |  22 --
 tests/tcg/mips/mips64-dsp/muleq_s_pw_qhl.c         |  56 ----
 tests/tcg/mips/mips64-dsp/muleq_s_pw_qhr.c         |  57 ----
 tests/tcg/mips/mips64-dsp/muleq_s_w_phl.c          |  46 ----
 tests/tcg/mips/mips64-dsp/muleq_s_w_phr.c          |  45 ---
 tests/tcg/mips/mips64-dsp/muleu_s_ph_qbl.c         |  27 --
 tests/tcg/mips/mips64-dsp/muleu_s_ph_qbr.c         |  27 --
 tests/tcg/mips/mips64-dsp/muleu_s_qh_obl.c         |  30 --
 tests/tcg/mips/mips64-dsp/muleu_s_qh_obr.c         |  31 ---
 tests/tcg/mips/mips64-dsp/mulq_rs_ph.c             |  27 --
 tests/tcg/mips/mips64-dsp/mulq_rs_qh.c             |  33 ---
 tests/tcg/mips/mips64-dsp/mulsaq_s_l_pw.c          |  59 ----
 tests/tcg/mips/mips64-dsp/mulsaq_s_w_qh.c          |  57 ----
 tests/tcg/mips/mips64-dsp/mult.c                   |  26 --
 tests/tcg/mips/mips64-dsp/multu.c                  |  26 --
 tests/tcg/mips/mips64-dsp/packrl_ph.c              |  24 --
 tests/tcg/mips/mips64-dsp/packrl_pw.c              |  24 --
 tests/tcg/mips/mips64-dsp/pick_ob.c                |  66 -----
 tests/tcg/mips/mips64-dsp/pick_ph.c                |  60 ----
 tests/tcg/mips/mips64-dsp/pick_pw.c                |  48 ----
 tests/tcg/mips/mips64-dsp/pick_qb.c                |  43 ---
 tests/tcg/mips/mips64-dsp/pick_qh.c                |  48 ----
 tests/tcg/mips/mips64-dsp/preceq_l_pwl.c           |  24 --
 tests/tcg/mips/mips64-dsp/preceq_l_pwr.c           |  24 --
 tests/tcg/mips/mips64-dsp/preceq_pw_qhl.c          |  21 --
 tests/tcg/mips/mips64-dsp/preceq_pw_qhla.c         |  23 --
 tests/tcg/mips/mips64-dsp/preceq_pw_qhr.c          |  21 --
 tests/tcg/mips/mips64-dsp/preceq_pw_qhra.c         |  23 --
 tests/tcg/mips/mips64-dsp/preceq_w_phl.c           |  23 --
 tests/tcg/mips/mips64-dsp/preceq_w_phr.c           |  23 --
 tests/tcg/mips/mips64-dsp/precequ_ph_qbl.c         |  23 --
 tests/tcg/mips/mips64-dsp/precequ_ph_qbla.c        |  23 --
 tests/tcg/mips/mips64-dsp/precequ_ph_qbr.c         |  23 --
 tests/tcg/mips/mips64-dsp/precequ_ph_qbra.c        |  23 --
 tests/tcg/mips/mips64-dsp/precequ_qh_obl.c         |  22 --
 tests/tcg/mips/mips64-dsp/precequ_qh_obla.c        |  22 --
 tests/tcg/mips/mips64-dsp/precequ_qh_obr.c         |  24 --
 tests/tcg/mips/mips64-dsp/precequ_qh_obra.c        |  24 --
 tests/tcg/mips/mips64-dsp/preceu_ph_qbl.c          |  23 --
 tests/tcg/mips/mips64-dsp/preceu_ph_qbla.c         |  23 --
 tests/tcg/mips/mips64-dsp/preceu_ph_qbr.c          |  23 --
 tests/tcg/mips/mips64-dsp/preceu_ph_qbra.c         |  23 --
 tests/tcg/mips/mips64-dsp/preceu_qh_obl.c          |  22 --
 tests/tcg/mips/mips64-dsp/preceu_qh_obla.c         |  22 --
 tests/tcg/mips/mips64-dsp/preceu_qh_obr.c          |  23 --
 tests/tcg/mips/mips64-dsp/preceu_qh_obra.c         |  23 --
 tests/tcg/mips/mips64-dsp/precr_ob_qh.c            |  25 --
 tests/tcg/mips/mips64-dsp/precr_sra_qh_pw.c        |  40 ---
 tests/tcg/mips/mips64-dsp/precr_sra_r_qh_pw.c      |  40 ---
 tests/tcg/mips/mips64-dsp/precrq_ob_qh.c           |  25 --
 tests/tcg/mips/mips64-dsp/precrq_ph_w.c            |  24 --
 tests/tcg/mips/mips64-dsp/precrq_pw_l.c            |  25 --
 tests/tcg/mips/mips64-dsp/precrq_qb_ph.c           |  24 --
 tests/tcg/mips/mips64-dsp/precrq_qh_pw.c           |  25 --
 tests/tcg/mips/mips64-dsp/precrq_rs_ph_w.c         |  41 ---
 tests/tcg/mips/mips64-dsp/precrq_rs_qh_pw.c        |  43 ---
 tests/tcg/mips/mips64-dsp/precrqu_s_ob_qh.c        |  27 --
 tests/tcg/mips/mips64-dsp/precrqu_s_qb_ph.c        |  26 --
 tests/tcg/mips/mips64-dsp/prependd.c               |  37 ---
 tests/tcg/mips/mips64-dsp/prependw.c               |  37 ---
 tests/tcg/mips/mips64-dsp/printf.c                 | 266 ------------------
 tests/tcg/mips/mips64-dsp/raddu_l_ob.c             |  22 --
 tests/tcg/mips/mips64-dsp/raddu_w_qb.c             |  23 --
 tests/tcg/mips/mips64-dsp/rddsp.c                  |  53 ----
 tests/tcg/mips/mips64-dsp/repl_ob.c                |  21 --
 tests/tcg/mips/mips64-dsp/repl_ph.c                |  30 --
 tests/tcg/mips/mips64-dsp/repl_pw.c                |  34 ---
 tests/tcg/mips/mips64-dsp/repl_qb.c                |  19 --
 tests/tcg/mips/mips64-dsp/repl_qh.c                |  34 ---
 tests/tcg/mips/mips64-dsp/replv_ob.c               |  23 --
 tests/tcg/mips/mips64-dsp/replv_ph.c               |  22 --
 tests/tcg/mips/mips64-dsp/replv_pw.c               |  23 --
 tests/tcg/mips/mips64-dsp/replv_qb.c               |  22 --
 tests/tcg/mips/mips64-dsp/shilo.c                  |  29 --
 tests/tcg/mips/mips64-dsp/shilov.c                 |  31 ---
 tests/tcg/mips/mips64-dsp/shll_ob.c                |  43 ---
 tests/tcg/mips/mips64-dsp/shll_ph.c                |  43 ---
 tests/tcg/mips/mips64-dsp/shll_pw.c                |  43 ---
 tests/tcg/mips/mips64-dsp/shll_qb.c                |  26 --
 tests/tcg/mips/mips64-dsp/shll_qh.c                |  42 ---
 tests/tcg/mips/mips64-dsp/shll_s_ph.c              |  43 ---
 tests/tcg/mips/mips64-dsp/shll_s_pw.c              |  43 ---
 tests/tcg/mips/mips64-dsp/shll_s_qh.c              |  43 ---
 tests/tcg/mips/mips64-dsp/shll_s_w.c               |  26 --
 tests/tcg/mips/mips64-dsp/shllv_ob.c               |  45 ---
 tests/tcg/mips/mips64-dsp/shllv_ph.c               |  27 --
 tests/tcg/mips/mips64-dsp/shllv_pw.c               |  45 ---
 tests/tcg/mips/mips64-dsp/shllv_qb.c               |  27 --
 tests/tcg/mips/mips64-dsp/shllv_qh.c               |  45 ---
 tests/tcg/mips/mips64-dsp/shllv_s_ph.c             |  27 --
 tests/tcg/mips/mips64-dsp/shllv_s_pw.c             |  45 ---
 tests/tcg/mips/mips64-dsp/shllv_s_qh.c             |  45 ---
 tests/tcg/mips/mips64-dsp/shllv_s_w.c              |  27 --
 tests/tcg/mips/mips64-dsp/shra_ob.c                |  23 --
 tests/tcg/mips/mips64-dsp/shra_ph.c                |  23 --
 tests/tcg/mips/mips64-dsp/shra_pw.c                |  36 ---
 tests/tcg/mips/mips64-dsp/shra_qh.c                |  37 ---
 tests/tcg/mips/mips64-dsp/shra_r_ob.c              |  22 --
 tests/tcg/mips/mips64-dsp/shra_r_ph.c              |  23 --
 tests/tcg/mips/mips64-dsp/shra_r_pw.c              |  36 ---
 tests/tcg/mips/mips64-dsp/shra_r_qh.c              |  37 ---
 tests/tcg/mips/mips64-dsp/shra_r_w.c               |  23 --
 tests/tcg/mips/mips64-dsp/shrav_ph.c               |  24 --
 tests/tcg/mips/mips64-dsp/shrav_pw.c               |  38 ---
 tests/tcg/mips/mips64-dsp/shrav_qh.c               |  39 ---
 tests/tcg/mips/mips64-dsp/shrav_r_ph.c             |  24 --
 tests/tcg/mips/mips64-dsp/shrav_r_pw.c             |  37 ---
 tests/tcg/mips/mips64-dsp/shrav_r_qh.c             |  39 ---
 tests/tcg/mips/mips64-dsp/shrav_r_w.c              |  24 --
 tests/tcg/mips/mips64-dsp/shrl_ob.c                |  38 ---
 tests/tcg/mips/mips64-dsp/shrl_qb.c                |  23 --
 tests/tcg/mips/mips64-dsp/shrl_qh.c                |  22 --
 tests/tcg/mips/mips64-dsp/shrlv_ob.c               |  39 ---
 tests/tcg/mips/mips64-dsp/shrlv_qb.c               |  24 --
 tests/tcg/mips/mips64-dsp/shrlv_qh.c               |  23 --
 tests/tcg/mips/mips64-dsp/subq_ph.c                |  27 --
 tests/tcg/mips/mips64-dsp/subq_pw.c                |  44 ---
 tests/tcg/mips/mips64-dsp/subq_qh.c                |  26 --
 tests/tcg/mips/mips64-dsp/subq_s_ph.c              |  27 --
 tests/tcg/mips/mips64-dsp/subq_s_pw.c              |  63 -----
 tests/tcg/mips/mips64-dsp/subq_s_qh.c              |  61 ----
 tests/tcg/mips/mips64-dsp/subq_s_w.c               |  27 --
 tests/tcg/mips/mips64-dsp/subu_ob.c                |  26 --
 tests/tcg/mips/mips64-dsp/subu_qb.c                |  27 --
 tests/tcg/mips/mips64-dsp/subu_s_ob.c              |  26 --
 tests/tcg/mips/mips64-dsp/subu_s_qb.c              |  27 --
 tests/tcg/mips/mips64-dsp/wrdsp.c                  |  48 ----
 tests/tcg/mips/mips64-dspr2/Makefile               | 116 --------
 tests/tcg/mips/mips64-dspr2/absq_s_qb.c            |  42 ---
 tests/tcg/mips/mips64-dspr2/addqh_ph.c             |  35 ---
 tests/tcg/mips/mips64-dspr2/addqh_r_ph.c           |  35 ---
 tests/tcg/mips/mips64-dspr2/addqh_r_w.c            |  38 ---
 tests/tcg/mips/mips64-dspr2/addqh_w.c              |  39 ---
 tests/tcg/mips/mips64-dspr2/addu_ph.c              |  37 ---
 tests/tcg/mips/mips64-dspr2/addu_qh.c              |  43 ---
 tests/tcg/mips/mips64-dspr2/addu_s_ph.c            |  37 ---
 tests/tcg/mips/mips64-dspr2/addu_s_qh.c            |  43 ---
 tests/tcg/mips/mips64-dspr2/adduh_ob.c             |  35 ---
 tests/tcg/mips/mips64-dspr2/adduh_qb.c             |  35 ---
 tests/tcg/mips/mips64-dspr2/adduh_r_ob.c           |  35 ---
 tests/tcg/mips/mips64-dspr2/adduh_r_qb.c           |  35 ---
 tests/tcg/mips/mips64-dspr2/append.c               |  35 ---
 tests/tcg/mips/mips64-dspr2/balign.c               |  35 ---
 tests/tcg/mips/mips64-dspr2/cmpgdu_eq_ob.c         |  44 ---
 tests/tcg/mips/mips64-dspr2/cmpgdu_eq_qb.c         |  41 ---
 tests/tcg/mips/mips64-dspr2/cmpgdu_le_ob.c         |  44 ---
 tests/tcg/mips/mips64-dspr2/cmpgdu_le_qb.c         |  48 ----
 tests/tcg/mips/mips64-dspr2/cmpgdu_lt_ob.c         |  44 ---
 tests/tcg/mips/mips64-dspr2/cmpgdu_lt_qb.c         |  48 ----
 tests/tcg/mips/mips64-dspr2/dbalign.c              |  39 ---
 tests/tcg/mips/mips64-dspr2/dpa_w_ph.c             |  47 ----
 tests/tcg/mips/mips64-dspr2/dpa_w_qh.c             |  56 ----
 tests/tcg/mips/mips64-dspr2/dpaqx_s_w_ph.c         |  97 -------
 tests/tcg/mips/mips64-dspr2/dpaqx_sa_w_ph.c        |  54 ----
 tests/tcg/mips/mips64-dspr2/dpax_w_ph.c            |  32 ---
 tests/tcg/mips/mips64-dspr2/dps_w_ph.c             |  28 --
 tests/tcg/mips/mips64-dspr2/dps_w_qh.c             |  55 ----
 tests/tcg/mips/mips64-dspr2/dpsqx_s_w_ph.c         |  55 ----
 tests/tcg/mips/mips64-dspr2/dpsqx_sa_w_ph.c        |  53 ----
 tests/tcg/mips/mips64-dspr2/dpsx_w_ph.c            |  28 --
 tests/tcg/mips/mips64-dspr2/head.S                 |  16 --
 tests/tcg/mips/mips64-dspr2/io.h                   |  22 --
 tests/tcg/mips/mips64-dspr2/mips_boot.lds          |  31 ---
 tests/tcg/mips/mips64-dspr2/mul_ph.c               |  50 ----
 tests/tcg/mips/mips64-dspr2/mul_s_ph.c             |  67 -----
 tests/tcg/mips/mips64-dspr2/mulq_rs_w.c            |  40 ---
 tests/tcg/mips/mips64-dspr2/mulq_s_ph.c            |  26 --
 tests/tcg/mips/mips64-dspr2/mulq_s_w.c             |  40 ---
 tests/tcg/mips/mips64-dspr2/mulsa_w_ph.c           |  30 --
 tests/tcg/mips/mips64-dspr2/mulsaq_s_w_ph.c        |  30 --
 tests/tcg/mips/mips64-dspr2/precr_qb_ph.c          |  23 --
 tests/tcg/mips/mips64-dspr2/precr_sra_ph_w.c       |  37 ---
 tests/tcg/mips/mips64-dspr2/precr_sra_r_ph_w.c     |  37 ---
 tests/tcg/mips/mips64-dspr2/prepend.c              |  35 ---
 tests/tcg/mips/mips64-dspr2/printf.c               | 266 ------------------
 tests/tcg/mips/mips64-dspr2/shra_qb.c              |  35 ---
 tests/tcg/mips/mips64-dspr2/shra_r_qb.c            |  35 ---
 tests/tcg/mips/mips64-dspr2/shrav_ob.c             |  22 --
 tests/tcg/mips/mips64-dspr2/shrav_qb.c             |  37 ---
 tests/tcg/mips/mips64-dspr2/shrav_r_ob.c           |  22 --
 tests/tcg/mips/mips64-dspr2/shrav_r_qb.c           |  37 ---
 tests/tcg/mips/mips64-dspr2/shrl_ph.c              |  22 --
 tests/tcg/mips/mips64-dspr2/shrlv_ph.c             |  23 --
 tests/tcg/mips/mips64-dspr2/subqh_ph.c             |  23 --
 tests/tcg/mips/mips64-dspr2/subqh_r_ph.c           |  23 --
 tests/tcg/mips/mips64-dspr2/subqh_r_w.c            |  23 --
 tests/tcg/mips/mips64-dspr2/subqh_w.c              |  23 --
 tests/tcg/mips/mips64-dspr2/subu_ph.c              |  26 --
 tests/tcg/mips/mips64-dspr2/subu_qh.c              |  24 --
 tests/tcg/mips/mips64-dspr2/subu_s_ph.c            |  25 --
 tests/tcg/mips/mips64-dspr2/subu_s_qh.c            |  42 ---
 tests/tcg/mips/mips64-dspr2/subuh_ob.c             |  36 ---
 tests/tcg/mips/mips64-dspr2/subuh_qb.c             |  23 --
 tests/tcg/mips/mips64-dspr2/subuh_r_ob.c           |  23 --
 tests/tcg/mips/mips64-dspr2/subuh_r_qb.c           |  37 ---
 tests/tcg/mips/user/ase/dsp/Makefile               | 184 +++++++++++++
 .../ase/dsp/test_dsp_r1_absq_s_ph.c}               |   0
 .../ase/dsp/test_dsp_r1_absq_s_w.c}                |   0
 .../ase/dsp/test_dsp_r1_addq_ph.c}                 |   0
 .../ase/dsp/test_dsp_r1_addq_s_ph.c}               |   0
 .../ase/dsp/test_dsp_r1_addq_s_w.c}                |   0
 .../addsc.c => user/ase/dsp/test_dsp_r1_addsc.c}   |   0
 .../ase/dsp/test_dsp_r1_addu_qb.c}                 |   0
 .../ase/dsp/test_dsp_r1_addu_s_qb.c}               |   0
 .../addwc.c => user/ase/dsp/test_dsp_r1_addwc.c}   |   0
 .../bitrev.c => user/ase/dsp/test_dsp_r1_bitrev.c} |   0
 .../ase/dsp/test_dsp_r1_bposge32.c}                |   0
 .../ase/dsp/test_dsp_r1_cmp_eq_ph.c}               |   0
 .../ase/dsp/test_dsp_r1_cmp_le_ph.c}               |   0
 .../ase/dsp/test_dsp_r1_cmp_lt_ph.c}               |   0
 .../ase/dsp/test_dsp_r1_cmpgu_eq_qb.c}             |   0
 .../ase/dsp/test_dsp_r1_cmpgu_le_qb.c}             |   0
 .../ase/dsp/test_dsp_r1_cmpgu_lt_qb.c}             |   0
 .../ase/dsp/test_dsp_r1_cmpu_eq_qb.c}              |   0
 .../ase/dsp/test_dsp_r1_cmpu_le_qb.c}              |   0
 .../ase/dsp/test_dsp_r1_cmpu_lt_qb.c}              |   0
 .../ase/dsp/test_dsp_r1_dpaq_s_w_ph.c}             |   0
 .../ase/dsp/test_dsp_r1_dpaq_sa_l_w.c}             |   0
 .../ase/dsp/test_dsp_r1_dpau_h_qbl.c}              |   0
 .../ase/dsp/test_dsp_r1_dpau_h_qbr.c}              |   0
 .../ase/dsp/test_dsp_r1_dpsq_s_w_ph.c}             |   0
 .../ase/dsp/test_dsp_r1_dpsq_sa_l_w.c}             |   0
 .../ase/dsp/test_dsp_r1_dpsu_h_qbl.c}              |   0
 .../ase/dsp/test_dsp_r1_dpsu_h_qbr.c}              |   0
 .../extp.c => user/ase/dsp/test_dsp_r1_extp.c}     |   0
 .../extpdp.c => user/ase/dsp/test_dsp_r1_extpdp.c} |   0
 .../ase/dsp/test_dsp_r1_extpdpv.c}                 |   0
 .../extpv.c => user/ase/dsp/test_dsp_r1_extpv.c}   |   0
 .../ase/dsp/test_dsp_r1_extr_r_w.c}                |   0
 .../ase/dsp/test_dsp_r1_extr_rs_w.c}               |   0
 .../ase/dsp/test_dsp_r1_extr_s_h.c}                |   0
 .../extr_w.c => user/ase/dsp/test_dsp_r1_extr_w.c} |   0
 .../ase/dsp/test_dsp_r1_extrv_r_w.c}               |   0
 .../ase/dsp/test_dsp_r1_extrv_rs_w.c}              |   0
 .../ase/dsp/test_dsp_r1_extrv_s_h.c}               |   0
 .../ase/dsp/test_dsp_r1_extrv_w.c}                 |   0
 .../insv.c => user/ase/dsp/test_dsp_r1_insv.c}     |   0
 .../lbux.c => user/ase/dsp/test_dsp_r1_lbux.c}     |   0
 .../lhx.c => user/ase/dsp/test_dsp_r1_lhx.c}       |   0
 .../lwx.c => user/ase/dsp/test_dsp_r1_lwx.c}       |   0
 .../maddu.c => user/ase/dsp/test_dsp_r1_madd.c}    |   0
 .../madd.c => user/ase/dsp/test_dsp_r1_maddu.c}    |   0
 .../main.c => user/ase/dsp/test_dsp_r1_main.c}     |   0
 .../ase/dsp/test_dsp_r1_maq_s_w_phl.c}             |   0
 .../ase/dsp/test_dsp_r1_maq_s_w_phr.c}             |   0
 .../ase/dsp/test_dsp_r1_maq_sa_w_phl.c}            |   0
 .../ase/dsp/test_dsp_r1_maq_sa_w_phr.c}            |   0
 .../mthi.c => user/ase/dsp/test_dsp_r1_mfhi.c}     |   0
 .../mtlo.c => user/ase/dsp/test_dsp_r1_mflo.c}     |   0
 .../modsub.c => user/ase/dsp/test_dsp_r1_modsub.c} |   0
 .../msub.c => user/ase/dsp/test_dsp_r1_msub.c}     |   0
 .../msubu.c => user/ase/dsp/test_dsp_r1_msubu.c}   |   0
 .../mfhi.c => user/ase/dsp/test_dsp_r1_mthi.c}     |   0
 .../mthlip.c => user/ase/dsp/test_dsp_r1_mthlip.c} |   0
 .../mflo.c => user/ase/dsp/test_dsp_r1_mtlo.c}     |   0
 .../ase/dsp/test_dsp_r1_muleq_s_w_phl.c}           |   0
 .../ase/dsp/test_dsp_r1_muleq_s_w_phr.c}           |   0
 .../ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c}          |   0
 .../ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c}          |   0
 .../ase/dsp/test_dsp_r1_mulq_rs_ph.c}              |   0
 .../mult.c => user/ase/dsp/test_dsp_r1_mult.c}     |   0
 .../multu.c => user/ase/dsp/test_dsp_r1_multu.c}   |   0
 .../ase/dsp/test_dsp_r1_packrl_ph.c}               |   0
 .../ase/dsp/test_dsp_r1_pick_ph.c}                 |   0
 .../ase/dsp/test_dsp_r1_pick_qb.c}                 |   0
 .../ase/dsp/test_dsp_r1_preceq_w_phl.c}            |   0
 .../ase/dsp/test_dsp_r1_preceq_w_phr.c}            |   0
 .../ase/dsp/test_dsp_r1_precequ_ph_qbl.c}          |   0
 .../ase/dsp/test_dsp_r1_precequ_ph_qbla.c}         |   0
 .../ase/dsp/test_dsp_r1_precequ_ph_qbr.c}          |   0
 .../ase/dsp/test_dsp_r1_precequ_ph_qbra.c}         |   0
 .../ase/dsp/test_dsp_r1_preceu_ph_qbl.c}           |   0
 .../ase/dsp/test_dsp_r1_preceu_ph_qbla.c}          |   0
 .../ase/dsp/test_dsp_r1_preceu_ph_qbr.c}           |   0
 .../ase/dsp/test_dsp_r1_preceu_ph_qbra.c}          |   0
 .../ase/dsp/test_dsp_r1_precrq_ph_w.c}             |   0
 .../ase/dsp/test_dsp_r1_precrq_qb_ph.c}            |   0
 .../ase/dsp/test_dsp_r1_precrq_rs_ph_w.c}          |   0
 .../ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c}         |   0
 .../ase/dsp/test_dsp_r1_raddu_w_qb.c}              |   0
 .../rddsp.c => user/ase/dsp/test_dsp_r1_rddsp.c}   |   0
 .../ase/dsp/test_dsp_r1_repl_ph.c}                 |   0
 .../ase/dsp/test_dsp_r1_repl_qb.c}                 |   0
 .../ase/dsp/test_dsp_r1_replv_ph.c}                |   0
 .../ase/dsp/test_dsp_r1_replv_qb.c}                |   0
 .../shilo.c => user/ase/dsp/test_dsp_r1_shilo.c}   |   0
 .../shilov.c => user/ase/dsp/test_dsp_r1_shilov.c} |   0
 .../ase/dsp/test_dsp_r1_shll_ph.c}                 |   0
 .../ase/dsp/test_dsp_r1_shll_qb.c}                 |   0
 .../ase/dsp/test_dsp_r1_shll_s_ph.c}               |   0
 .../ase/dsp/test_dsp_r1_shll_s_w.c}                |   0
 .../ase/dsp/test_dsp_r1_shllv_ph.c}                |   0
 .../ase/dsp/test_dsp_r1_shllv_qb.c}                |   0
 .../ase/dsp/test_dsp_r1_shllv_s_ph.c}              |   0
 .../ase/dsp/test_dsp_r1_shllv_s_w.c}               |   0
 .../ase/dsp/test_dsp_r1_shra_ph.c}                 |   0
 .../ase/dsp/test_dsp_r1_shra_r_ph.c}               |   0
 .../ase/dsp/test_dsp_r1_shra_r_w.c}                |   0
 .../ase/dsp/test_dsp_r1_shrav_ph.c}                |   0
 .../ase/dsp/test_dsp_r1_shrav_r_ph.c}              |   0
 .../ase/dsp/test_dsp_r1_shrav_r_w.c}               |   0
 .../ase/dsp/test_dsp_r1_shrl_qb.c}                 |   0
 .../ase/dsp/test_dsp_r1_shrlv_qb.c}                |   0
 .../ase/dsp/test_dsp_r1_subq_ph.c}                 |   0
 .../ase/dsp/test_dsp_r1_subq_s_ph.c}               |   0
 .../ase/dsp/test_dsp_r1_subq_s_w.c}                |   0
 .../ase/dsp/test_dsp_r1_subu_qb.c}                 |   0
 .../ase/dsp/test_dsp_r1_subu_s_qb.c}               |   0
 .../wrdsp.c => user/ase/dsp/test_dsp_r1_wrdsp.c}   |   0
 .../ase/dsp/test_dsp_r2_absq_s_qb.c}               |   0
 .../ase/dsp/test_dsp_r2_addqh_ph.c}                |   0
 .../ase/dsp/test_dsp_r2_addqh_r_ph.c}              |   0
 .../ase/dsp/test_dsp_r2_addqh_r_w.c}               |   0
 .../ase/dsp/test_dsp_r2_addqh_w.c}                 |   0
 .../ase/dsp/test_dsp_r2_addu_ph.c}                 |   0
 .../ase/dsp/test_dsp_r2_addu_s_ph.c}               |   0
 .../ase/dsp/test_dsp_r2_adduh_qb.c}                |   0
 .../ase/dsp/test_dsp_r2_adduh_r_qb.c}              |   0
 .../append.c => user/ase/dsp/test_dsp_r2_append.c} |   0
 .../balign.c => user/ase/dsp/test_dsp_r2_balign.c} |   0
 .../ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c}            |   0
 .../ase/dsp/test_dsp_r2_cmpgdu_le_qb.c}            |   0
 .../ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c}            |   0
 .../ase/dsp/test_dsp_r2_dpa_w_ph.c}                |   0
 .../ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c}            |   0
 .../ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c}           |   0
 .../ase/dsp/test_dsp_r2_dpax_w_ph.c}               |   0
 .../ase/dsp/test_dsp_r2_dps_w_ph.c}                |   0
 .../ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c}            |   0
 .../ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c}           |   0
 .../ase/dsp/test_dsp_r2_dpsx_w_ph.c}               |   0
 .../mul_ph.c => user/ase/dsp/test_dsp_r2_mul_ph.c} |   0
 .../ase/dsp/test_dsp_r2_mul_s_ph.c}                |   0
 .../ase/dsp/test_dsp_r2_mulq_rs_w.c}               |   0
 .../ase/dsp/test_dsp_r2_mulq_s_ph.c}               |   0
 .../ase/dsp/test_dsp_r2_mulq_s_w.c}                |   0
 .../ase/dsp/test_dsp_r2_mulsa_w_ph.c}              |   0
 .../ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c}           |   0
 .../ase/dsp/test_dsp_r2_precr_qb_ph.c}             |   0
 .../ase/dsp/test_dsp_r2_precr_sra_ph_w.c}          |   0
 .../ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c}        |   0
 .../ase/dsp/test_dsp_r2_prepend.c}                 |   0
 .../ase/dsp/test_dsp_r2_shra_qb.c}                 |   0
 .../ase/dsp/test_dsp_r2_shra_r_qb.c}               |   0
 .../ase/dsp/test_dsp_r2_shrav_qb.c}                |   0
 .../ase/dsp/test_dsp_r2_shrav_r_qb.c}              |   0
 .../ase/dsp/test_dsp_r2_shrl_ph.c}                 |   0
 .../ase/dsp/test_dsp_r2_shrlv_ph.c}                |   0
 .../ase/dsp/test_dsp_r2_subqh_ph.c}                |   0
 .../ase/dsp/test_dsp_r2_subqh_r_ph.c}              |   0
 .../ase/dsp/test_dsp_r2_subqh_r_w.c}               |   0
 .../ase/dsp/test_dsp_r2_subqh_w.c}                 |   0
 .../ase/dsp/test_dsp_r2_subu_ph.c}                 |   0
 .../ase/dsp/test_dsp_r2_subu_s_ph.c}               |   0
 .../ase/dsp/test_dsp_r2_subuh_qb.c}                |   0
 .../ase/dsp/test_dsp_r2_subuh_r_qb.c}              |   0
 .../mips/{mipsr5900 => user/isa/r5900}/Makefile    |  18 +-
 .../div1.c => user/isa/r5900/test_r5900_div1.c}    |   0
 .../divu1.c => user/isa/r5900/test_r5900_divu1.c}  |   0
 .../madd.c => user/isa/r5900/test_r5900_madd.c}    |   0
 .../maddu.c => user/isa/r5900/test_r5900_maddu.c}  |   0
 .../isa/r5900/test_r5900_mflohi1.c}                |   0
 .../isa/r5900/test_r5900_mtlohi1.c}                |   0
 .../mult.c => user/isa/r5900/test_r5900_mult.c}    |   0
 .../multu.c => user/isa/r5900/test_r5900_multu.c}  |   0
 496 files changed, 193 insertions(+), 13685 deletions(-)
 delete mode 100644 tests/tcg/mips/mips32-dsp/Makefile
 delete mode 100644 tests/tcg/mips/mips32-dspr2/Makefile
 delete mode 100644 tests/tcg/mips/mips64-dsp/Makefile
 delete mode 100644 tests/tcg/mips/mips64-dsp/absq_s_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/absq_s_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/absq_s_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/absq_s_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/absq_s_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addq_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addq_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addq_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addq_s_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addq_s_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addq_s_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addq_s_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addsc.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addu_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addu_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addu_s_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addu_s_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/addwc.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/bitrev.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/bposge32.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/bposge64.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmp_eq_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmp_eq_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmp_eq_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmp_le_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmp_le_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmp_le_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmp_lt_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmp_lt_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmp_lt_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpgu_eq_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpgu_eq_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpgu_le_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpgu_le_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpgu_lt_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpgu_lt_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpu_eq_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpu_eq_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpu_le_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpu_le_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpu_lt_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/cmpu_lt_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dappend.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextp.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextpdp.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextpdpv.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextpv.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextr_l.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextr_r_l.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextr_r_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextr_rs_l.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextr_rs_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextr_s_h.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextr_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextrv_l.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextrv_r_l.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextrv_r_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextrv_rs_l.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextrv_rs_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextrv_s_h.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dextrv_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dinsv.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dmadd.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dmaddu.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dmsub.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dmsubu.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dmthlip.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpaq_s_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpaq_s_w_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpaq_sa_l_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpaq_sa_l_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpau_h_obl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpau_h_obr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpau_h_qbl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpau_h_qbr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpsq_s_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpsq_s_w_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpsq_sa_l_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpsq_sa_l_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpsu_h_obl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpsu_h_obr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpsu_h_qbl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dpsu_h_qbr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dshilo.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/dshilov.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extp.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extpdp.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extpdpv.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extpv.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extr_r_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extr_rs_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extr_s_h.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extr_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extrv_r_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extrv_rs_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extrv_s_h.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/extrv_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/head.S
 delete mode 100644 tests/tcg/mips/mips64-dsp/insv.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/io.h
 delete mode 100644 tests/tcg/mips/mips64-dsp/lbux.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/ldx.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/lhx.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/lwx.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/madd.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maddu.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_s_l_pwl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_s_l_pwr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_s_w_phl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_s_w_phr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_s_w_qhll.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_s_w_qhlr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_s_w_qhrl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_s_w_qhrr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_sa_w_phl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_sa_w_phr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_sa_w_qhll.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_sa_w_qhlr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_sa_w_qhrl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/maq_sa_w_qhrr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mfhi.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mflo.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mips_boot.lds
 delete mode 100644 tests/tcg/mips/mips64-dsp/modsub.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/msub.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/msubu.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mthi.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mthlip.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mtlo.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/muleq_s_pw_qhl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/muleq_s_pw_qhr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/muleq_s_w_phl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/muleq_s_w_phr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/muleu_s_ph_qbl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/muleu_s_ph_qbr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/muleu_s_qh_obl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/muleu_s_qh_obr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mulq_rs_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mulq_rs_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mulsaq_s_l_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mulsaq_s_w_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/mult.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/multu.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/packrl_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/packrl_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/pick_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/pick_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/pick_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/pick_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/pick_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceq_l_pwl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceq_l_pwr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceq_pw_qhl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceq_pw_qhla.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceq_pw_qhr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceq_pw_qhra.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceq_w_phl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceq_w_phr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precequ_ph_qbl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precequ_ph_qbla.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precequ_ph_qbr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precequ_ph_qbra.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precequ_qh_obl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precequ_qh_obla.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precequ_qh_obr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precequ_qh_obra.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceu_ph_qbl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceu_ph_qbla.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceu_ph_qbr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceu_ph_qbra.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceu_qh_obl.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceu_qh_obla.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceu_qh_obr.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/preceu_qh_obra.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precr_ob_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precr_sra_qh_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precr_sra_r_qh_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precrq_ob_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precrq_ph_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precrq_pw_l.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precrq_qb_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precrq_qh_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precrq_rs_ph_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precrq_rs_qh_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precrqu_s_ob_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/precrqu_s_qb_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/prependd.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/prependw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/printf.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/raddu_l_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/raddu_w_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/rddsp.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/repl_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/repl_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/repl_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/repl_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/repl_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/replv_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/replv_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/replv_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/replv_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shilo.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shilov.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shll_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shll_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shll_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shll_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shll_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shll_s_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shll_s_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shll_s_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shll_s_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shllv_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shllv_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shllv_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shllv_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shllv_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shllv_s_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shllv_s_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shllv_s_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shllv_s_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shra_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shra_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shra_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shra_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shra_r_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shra_r_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shra_r_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shra_r_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shra_r_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrav_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrav_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrav_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrav_r_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrav_r_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrav_r_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrav_r_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrl_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrl_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrl_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrlv_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrlv_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/shrlv_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subq_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subq_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subq_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subq_s_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subq_s_pw.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subq_s_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subq_s_w.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subu_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subu_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subu_s_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/subu_s_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dsp/wrdsp.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/Makefile
 delete mode 100644 tests/tcg/mips/mips64-dspr2/absq_s_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/addqh_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/addqh_r_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/addqh_r_w.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/addqh_w.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/addu_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/addu_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/addu_s_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/addu_s_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/adduh_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/adduh_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/adduh_r_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/adduh_r_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/append.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/balign.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/cmpgdu_eq_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/cmpgdu_eq_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/cmpgdu_le_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/cmpgdu_le_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/cmpgdu_lt_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/cmpgdu_lt_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dbalign.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dpa_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dpa_w_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dpaqx_s_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dpaqx_sa_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dpax_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dps_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dps_w_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dpsqx_s_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dpsqx_sa_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/dpsx_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/head.S
 delete mode 100644 tests/tcg/mips/mips64-dspr2/io.h
 delete mode 100644 tests/tcg/mips/mips64-dspr2/mips_boot.lds
 delete mode 100644 tests/tcg/mips/mips64-dspr2/mul_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/mul_s_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/mulq_rs_w.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/mulq_s_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/mulq_s_w.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/mulsa_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/mulsaq_s_w_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/precr_qb_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/precr_sra_ph_w.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/precr_sra_r_ph_w.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/prepend.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/printf.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/shra_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/shra_r_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/shrav_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/shrav_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/shrav_r_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/shrav_r_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/shrl_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/shrlv_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subqh_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subqh_r_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subqh_r_w.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subqh_w.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subu_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subu_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subu_s_ph.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subu_s_qh.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subuh_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subuh_qb.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subuh_r_ob.c
 delete mode 100644 tests/tcg/mips/mips64-dspr2/subuh_r_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
 rename tests/tcg/mips/{mips32-dsp/absq_s_ph.c => user/ase/dsp/test_dsp_r1_absq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/absq_s_w.c => user/ase/dsp/test_dsp_r1_absq_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addq_ph.c => user/ase/dsp/test_dsp_r1_addq_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addq_s_ph.c => user/ase/dsp/test_dsp_r1_addq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addq_s_w.c => user/ase/dsp/test_dsp_r1_addq_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addsc.c => user/ase/dsp/test_dsp_r1_addsc.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addu_qb.c => user/ase/dsp/test_dsp_r1_addu_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addu_s_qb.c => user/ase/dsp/test_dsp_r1_addu_s_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addwc.c => user/ase/dsp/test_dsp_r1_addwc.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/bitrev.c => user/ase/dsp/test_dsp_r1_bitrev.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/bposge32.c => user/ase/dsp/test_dsp_r1_bposge32.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmp_eq_ph.c => user/ase/dsp/test_dsp_r1_cmp_eq_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmp_le_ph.c => user/ase/dsp/test_dsp_r1_cmp_le_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmp_lt_ph.c => user/ase/dsp/test_dsp_r1_cmp_lt_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpgu_eq_qb.c => user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpgu_le_qb.c => user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpgu_lt_qb.c => user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpu_eq_qb.c => user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpu_le_qb.c => user/ase/dsp/test_dsp_r1_cmpu_le_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpu_lt_qb.c => user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpaq_s_w_ph.c => user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpaq_sa_l_w.c => user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpau_h_qbl.c => user/ase/dsp/test_dsp_r1_dpau_h_qbl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpau_h_qbr.c => user/ase/dsp/test_dsp_r1_dpau_h_qbr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpsq_s_w_ph.c => user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpsq_sa_l_w.c => user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpsu_h_qbl.c => user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpsu_h_qbr.c => user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extp.c => user/ase/dsp/test_dsp_r1_extp.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extpdp.c => user/ase/dsp/test_dsp_r1_extpdp.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extpdpv.c => user/ase/dsp/test_dsp_r1_extpdpv.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extpv.c => user/ase/dsp/test_dsp_r1_extpv.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extr_r_w.c => user/ase/dsp/test_dsp_r1_extr_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extr_rs_w.c => user/ase/dsp/test_dsp_r1_extr_rs_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extr_s_h.c => user/ase/dsp/test_dsp_r1_extr_s_h.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extr_w.c => user/ase/dsp/test_dsp_r1_extr_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extrv_r_w.c => user/ase/dsp/test_dsp_r1_extrv_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extrv_rs_w.c => user/ase/dsp/test_dsp_r1_extrv_rs_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extrv_s_h.c => user/ase/dsp/test_dsp_r1_extrv_s_h.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extrv_w.c => user/ase/dsp/test_dsp_r1_extrv_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/insv.c => user/ase/dsp/test_dsp_r1_insv.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/lbux.c => user/ase/dsp/test_dsp_r1_lbux.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/lhx.c => user/ase/dsp/test_dsp_r1_lhx.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/lwx.c => user/ase/dsp/test_dsp_r1_lwx.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/maddu.c => user/ase/dsp/test_dsp_r1_madd.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/madd.c => user/ase/dsp/test_dsp_r1_maddu.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/main.c => user/ase/dsp/test_dsp_r1_main.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/maq_s_w_phl.c => user/ase/dsp/test_dsp_r1_maq_s_w_phl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/maq_s_w_phr.c => user/ase/dsp/test_dsp_r1_maq_s_w_phr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/maq_sa_w_phl.c => user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/maq_sa_w_phr.c => user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mthi.c => user/ase/dsp/test_dsp_r1_mfhi.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mtlo.c => user/ase/dsp/test_dsp_r1_mflo.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/modsub.c => user/ase/dsp/test_dsp_r1_modsub.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/msub.c => user/ase/dsp/test_dsp_r1_msub.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/msubu.c => user/ase/dsp/test_dsp_r1_msubu.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mfhi.c => user/ase/dsp/test_dsp_r1_mthi.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mthlip.c => user/ase/dsp/test_dsp_r1_mthlip.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mflo.c => user/ase/dsp/test_dsp_r1_mtlo.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/muleq_s_w_phl.c => user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/muleq_s_w_phr.c => user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/muleu_s_ph_qbl.c => user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/muleu_s_ph_qbr.c => user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mulq_rs_ph.c => user/ase/dsp/test_dsp_r1_mulq_rs_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mult.c => user/ase/dsp/test_dsp_r1_mult.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/multu.c => user/ase/dsp/test_dsp_r1_multu.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/packrl_ph.c => user/ase/dsp/test_dsp_r1_packrl_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/pick_ph.c => user/ase/dsp/test_dsp_r1_pick_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/pick_qb.c => user/ase/dsp/test_dsp_r1_pick_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceq_w_phl.c => user/ase/dsp/test_dsp_r1_preceq_w_phl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceq_w_phr.c => user/ase/dsp/test_dsp_r1_preceq_w_phr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precequ_ph_qbl.c => user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precequ_ph_qbla.c => user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precequ_ph_qbr.c => user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precequ_ph_qbra.c => user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceu_ph_qbl.c => user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceu_ph_qbla.c => user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceu_ph_qbr.c => user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceu_ph_qbra.c => user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precrq_ph_w.c => user/ase/dsp/test_dsp_r1_precrq_ph_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precrq_qb_ph.c => user/ase/dsp/test_dsp_r1_precrq_qb_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precrq_rs_ph_w.c => user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precrqu_s_qb_ph.c => user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/raddu_w_qb.c => user/ase/dsp/test_dsp_r1_raddu_w_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/rddsp.c => user/ase/dsp/test_dsp_r1_rddsp.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/repl_ph.c => user/ase/dsp/test_dsp_r1_repl_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/repl_qb.c => user/ase/dsp/test_dsp_r1_repl_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/replv_ph.c => user/ase/dsp/test_dsp_r1_replv_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/replv_qb.c => user/ase/dsp/test_dsp_r1_replv_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shilo.c => user/ase/dsp/test_dsp_r1_shilo.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shilov.c => user/ase/dsp/test_dsp_r1_shilov.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shll_ph.c => user/ase/dsp/test_dsp_r1_shll_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shll_qb.c => user/ase/dsp/test_dsp_r1_shll_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shll_s_ph.c => user/ase/dsp/test_dsp_r1_shll_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shll_s_w.c => user/ase/dsp/test_dsp_r1_shll_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shllv_ph.c => user/ase/dsp/test_dsp_r1_shllv_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shllv_qb.c => user/ase/dsp/test_dsp_r1_shllv_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shllv_s_ph.c => user/ase/dsp/test_dsp_r1_shllv_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shllv_s_w.c => user/ase/dsp/test_dsp_r1_shllv_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shra_ph.c => user/ase/dsp/test_dsp_r1_shra_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shra_r_ph.c => user/ase/dsp/test_dsp_r1_shra_r_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shra_r_w.c => user/ase/dsp/test_dsp_r1_shra_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shrav_ph.c => user/ase/dsp/test_dsp_r1_shrav_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shrav_r_ph.c => user/ase/dsp/test_dsp_r1_shrav_r_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shrav_r_w.c => user/ase/dsp/test_dsp_r1_shrav_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shrl_qb.c => user/ase/dsp/test_dsp_r1_shrl_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shrlv_qb.c => user/ase/dsp/test_dsp_r1_shrlv_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/subq_ph.c => user/ase/dsp/test_dsp_r1_subq_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/subq_s_ph.c => user/ase/dsp/test_dsp_r1_subq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/subq_s_w.c => user/ase/dsp/test_dsp_r1_subq_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/subu_qb.c => user/ase/dsp/test_dsp_r1_subu_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/subu_s_qb.c => user/ase/dsp/test_dsp_r1_subu_s_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/wrdsp.c => user/ase/dsp/test_dsp_r1_wrdsp.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/absq_s_qb.c => user/ase/dsp/test_dsp_r2_absq_s_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addqh_ph.c => user/ase/dsp/test_dsp_r2_addqh_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addqh_r_ph.c => user/ase/dsp/test_dsp_r2_addqh_r_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addqh_r_w.c => user/ase/dsp/test_dsp_r2_addqh_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addqh_w.c => user/ase/dsp/test_dsp_r2_addqh_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addu_ph.c => user/ase/dsp/test_dsp_r2_addu_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addu_s_ph.c => user/ase/dsp/test_dsp_r2_addu_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/adduh_qb.c => user/ase/dsp/test_dsp_r2_adduh_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/adduh_r_qb.c => user/ase/dsp/test_dsp_r2_adduh_r_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/append.c => user/ase/dsp/test_dsp_r2_append.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/balign.c => user/ase/dsp/test_dsp_r2_balign.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/cmpgdu_eq_qb.c => user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/cmpgdu_le_qb.c => user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/cmpgdu_lt_qb.c => user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpa_w_ph.c => user/ase/dsp/test_dsp_r2_dpa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpaqx_s_w_ph.c => user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpaqx_sa_w_ph.c => user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpax_w_ph.c => user/ase/dsp/test_dsp_r2_dpax_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dps_w_ph.c => user/ase/dsp/test_dsp_r2_dps_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpsqx_s_w_ph.c => user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpsqx_sa_w_ph.c => user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpsx_w_ph.c => user/ase/dsp/test_dsp_r2_dpsx_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mul_ph.c => user/ase/dsp/test_dsp_r2_mul_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mul_s_ph.c => user/ase/dsp/test_dsp_r2_mul_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mulq_rs_w.c => user/ase/dsp/test_dsp_r2_mulq_rs_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mulq_s_ph.c => user/ase/dsp/test_dsp_r2_mulq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mulq_s_w.c => user/ase/dsp/test_dsp_r2_mulq_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mulsa_w_ph.c => user/ase/dsp/test_dsp_r2_mulsa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mulsaq_s_w_ph.c => user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/precr_qb_ph.c => user/ase/dsp/test_dsp_r2_precr_qb_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/precr_sra_ph_w.c => user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/precr_sra_r_ph_w.c => user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/prepend.c => user/ase/dsp/test_dsp_r2_prepend.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shra_qb.c => user/ase/dsp/test_dsp_r2_shra_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shra_r_qb.c => user/ase/dsp/test_dsp_r2_shra_r_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shrav_qb.c => user/ase/dsp/test_dsp_r2_shrav_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shrav_r_qb.c => user/ase/dsp/test_dsp_r2_shrav_r_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shrl_ph.c => user/ase/dsp/test_dsp_r2_shrl_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shrlv_ph.c => user/ase/dsp/test_dsp_r2_shrlv_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subqh_ph.c => user/ase/dsp/test_dsp_r2_subqh_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subqh_r_ph.c => user/ase/dsp/test_dsp_r2_subqh_r_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subqh_r_w.c => user/ase/dsp/test_dsp_r2_subqh_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subqh_w.c => user/ase/dsp/test_dsp_r2_subqh_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subu_ph.c => user/ase/dsp/test_dsp_r2_subu_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subu_s_ph.c => user/ase/dsp/test_dsp_r2_subu_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subuh_qb.c => user/ase/dsp/test_dsp_r2_subuh_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subuh_r_qb.c => user/ase/dsp/test_dsp_r2_subuh_r_qb.c} (100%)
 rename tests/tcg/mips/{mipsr5900 => user/isa/r5900}/Makefile (55%)
 rename tests/tcg/mips/{mipsr5900/div1.c => user/isa/r5900/test_r5900_div1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/divu1.c => user/isa/r5900/test_r5900_divu1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/madd.c => user/isa/r5900/test_r5900_madd.c} (100%)
 rename tests/tcg/mips/{mipsr5900/maddu.c => user/isa/r5900/test_r5900_maddu.c} (100%)
 rename tests/tcg/mips/{mipsr5900/mflohi1.c => user/isa/r5900/test_r5900_mflohi1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/mtlohi1.c => user/isa/r5900/test_r5900_mtlohi1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/mult.c => user/isa/r5900/test_r5900_mult.c} (100%)
 rename tests/tcg/mips/{mipsr5900/multu.c => user/isa/r5900/test_r5900_multu.c} (100%)

-- 
2.7.4
