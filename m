Received: from eggs.gnu.org ([209.51.188.92]:58642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmgoc-00032X-1j
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmgo9-0007TH-J6
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:21:14 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37356 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gmgo7-0006aW-W2
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:20:45 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 24 Jan 2019 16:19:14 +0100
Message-Id: <1548343154-8774-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548343154-8774-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548343154-8774-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 3/3] tests: tcg: mips: Remove old directories
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

Remove old test directories.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mips32-dsp/Makefile             | 136 -----------
 tests/tcg/mips/mips32-dspr2/Makefile           |  71 ------
 tests/tcg/mips/mips64-dsp/Makefile             | 306 -------------------------
 tests/tcg/mips/mips64-dsp/absq_s_ob.c          |  63 -----
 tests/tcg/mips/mips64-dsp/absq_s_ph.c          |  37 ---
 tests/tcg/mips/mips64-dsp/absq_s_pw.c          |  66 ------
 tests/tcg/mips/mips64-dsp/absq_s_qh.c          |  40 ----
 tests/tcg/mips/mips64-dsp/absq_s_w.c           |  48 ----
 tests/tcg/mips/mips64-dsp/addq_ph.c            |  57 -----
 tests/tcg/mips/mips64-dsp/addq_pw.c            |  46 ----
 tests/tcg/mips/mips64-dsp/addq_qh.c            |  28 ---
 tests/tcg/mips/mips64-dsp/addq_s_ph.c          |  84 -------
 tests/tcg/mips/mips64-dsp/addq_s_pw.c          |  45 ----
 tests/tcg/mips/mips64-dsp/addq_s_qh.c          |  26 ---
 tests/tcg/mips/mips64-dsp/addq_s_w.c           |  48 ----
 tests/tcg/mips/mips64-dsp/addsc.c              |  39 ----
 tests/tcg/mips/mips64-dsp/addu_ob.c            |  28 ---
 tests/tcg/mips/mips64-dsp/addu_qb.c            |  40 ----
 tests/tcg/mips/mips64-dsp/addu_s_ob.c          |  27 ---
 tests/tcg/mips/mips64-dsp/addu_s_qb.c          |  40 ----
 tests/tcg/mips/mips64-dsp/addwc.c              |  59 -----
 tests/tcg/mips/mips64-dsp/bitrev.c             |  23 --
 tests/tcg/mips/mips64-dsp/bposge32.c           |  50 ----
 tests/tcg/mips/mips64-dsp/bposge64.c           |  50 ----
 tests/tcg/mips/mips64-dsp/cmp_eq_ph.c          |  42 ----
 tests/tcg/mips/mips64-dsp/cmp_eq_pw.c          |  46 ----
 tests/tcg/mips/mips64-dsp/cmp_eq_qh.c          |  46 ----
 tests/tcg/mips/mips64-dsp/cmp_le_ph.c          |  40 ----
 tests/tcg/mips/mips64-dsp/cmp_le_pw.c          |  46 ----
 tests/tcg/mips/mips64-dsp/cmp_le_qh.c          |  46 ----
 tests/tcg/mips/mips64-dsp/cmp_lt_ph.c          |  41 ----
 tests/tcg/mips/mips64-dsp/cmp_lt_pw.c          |  46 ----
 tests/tcg/mips/mips64-dsp/cmp_lt_qh.c          |  46 ----
 tests/tcg/mips/mips64-dsp/cmpgu_eq_ob.c        |  40 ----
 tests/tcg/mips/mips64-dsp/cmpgu_eq_qb.c        |  38 ---
 tests/tcg/mips/mips64-dsp/cmpgu_le_ob.c        |  40 ----
 tests/tcg/mips/mips64-dsp/cmpgu_le_qb.c        |  37 ---
 tests/tcg/mips/mips64-dsp/cmpgu_lt_ob.c        |  40 ----
 tests/tcg/mips/mips64-dsp/cmpgu_lt_qb.c        |  38 ---
 tests/tcg/mips/mips64-dsp/cmpu_eq_ob.c         |  46 ----
 tests/tcg/mips/mips64-dsp/cmpu_eq_qb.c         |  42 ----
 tests/tcg/mips/mips64-dsp/cmpu_le_ob.c         |  44 ----
 tests/tcg/mips/mips64-dsp/cmpu_le_qb.c         |  41 ----
 tests/tcg/mips/mips64-dsp/cmpu_lt_ob.c         |  44 ----
 tests/tcg/mips/mips64-dsp/cmpu_lt_qb.c         |  42 ----
 tests/tcg/mips/mips64-dsp/dappend.c            |  37 ---
 tests/tcg/mips/mips64-dsp/dextp.c              |  54 -----
 tests/tcg/mips/mips64-dsp/dextpdp.c            |  59 -----
 tests/tcg/mips/mips64-dsp/dextpdpv.c           |  63 -----
 tests/tcg/mips/mips64-dsp/dextpv.c             |  58 -----
 tests/tcg/mips/mips64-dsp/dextr_l.c            |  44 ----
 tests/tcg/mips/mips64-dsp/dextr_r_l.c          |  54 -----
 tests/tcg/mips/mips64-dsp/dextr_r_w.c          |  54 -----
 tests/tcg/mips/mips64-dsp/dextr_rs_l.c         |  52 -----
 tests/tcg/mips/mips64-dsp/dextr_rs_w.c         |  52 -----
 tests/tcg/mips/mips64-dsp/dextr_s_h.c          |  73 ------
 tests/tcg/mips/mips64-dsp/dextr_w.c            |  44 ----
 tests/tcg/mips/mips64-dsp/dextrv_l.c           |  46 ----
 tests/tcg/mips/mips64-dsp/dextrv_r_l.c         |  56 -----
 tests/tcg/mips/mips64-dsp/dextrv_r_w.c         |  56 -----
 tests/tcg/mips/mips64-dsp/dextrv_rs_l.c        |  54 -----
 tests/tcg/mips/mips64-dsp/dextrv_rs_w.c        |  54 -----
 tests/tcg/mips/mips64-dsp/dextrv_s_h.c         |  32 ---
 tests/tcg/mips/mips64-dsp/dextrv_w.c           |  46 ----
 tests/tcg/mips/mips64-dsp/dinsv.c              |  26 ---
 tests/tcg/mips/mips64-dsp/dmadd.c              |  57 -----
 tests/tcg/mips/mips64-dsp/dmaddu.c             |  56 -----
 tests/tcg/mips/mips64-dsp/dmsub.c              |  59 -----
 tests/tcg/mips/mips64-dsp/dmsubu.c             |  59 -----
 tests/tcg/mips/mips64-dsp/dmthlip.c            |  41 ----
 tests/tcg/mips/mips64-dsp/dpaq_s_w_ph.c        |  32 ---
 tests/tcg/mips/mips64-dsp/dpaq_s_w_qh.c        |  57 -----
 tests/tcg/mips/mips64-dsp/dpaq_sa_l_pw.c       |  88 -------
 tests/tcg/mips/mips64-dsp/dpaq_sa_l_w.c        |  82 -------
 tests/tcg/mips/mips64-dsp/dpau_h_obl.c         |  59 -----
 tests/tcg/mips/mips64-dsp/dpau_h_obr.c         |  59 -----
 tests/tcg/mips/mips64-dsp/dpau_h_qbl.c         |  29 ---
 tests/tcg/mips/mips64-dsp/dpau_h_qbr.c         |  29 ---
 tests/tcg/mips/mips64-dsp/dpsq_s_w_ph.c        |  51 -----
 tests/tcg/mips/mips64-dsp/dpsq_s_w_qh.c        |  56 -----
 tests/tcg/mips/mips64-dsp/dpsq_sa_l_pw.c       |  76 ------
 tests/tcg/mips/mips64-dsp/dpsq_sa_l_w.c        |  59 -----
 tests/tcg/mips/mips64-dsp/dpsu_h_obl.c         |  32 ---
 tests/tcg/mips/mips64-dsp/dpsu_h_obr.c         |  32 ---
 tests/tcg/mips/mips64-dsp/dpsu_h_qbl.c         |  29 ---
 tests/tcg/mips/mips64-dsp/dpsu_h_qbr.c         |  29 ---
 tests/tcg/mips/mips64-dsp/dshilo.c             |  52 -----
 tests/tcg/mips/mips64-dsp/dshilov.c            |  54 -----
 tests/tcg/mips/mips64-dsp/extp.c               |  50 ----
 tests/tcg/mips/mips64-dsp/extpdp.c             |  51 -----
 tests/tcg/mips/mips64-dsp/extpdpv.c            |  52 -----
 tests/tcg/mips/mips64-dsp/extpv.c              |  51 -----
 tests/tcg/mips/mips64-dsp/extr_r_w.c           |  53 -----
 tests/tcg/mips/mips64-dsp/extr_rs_w.c          |  53 -----
 tests/tcg/mips/mips64-dsp/extr_s_h.c           |  71 ------
 tests/tcg/mips/mips64-dsp/extr_w.c             |  53 -----
 tests/tcg/mips/mips64-dsp/extrv_r_w.c          |  59 -----
 tests/tcg/mips/mips64-dsp/extrv_rs_w.c         |  59 -----
 tests/tcg/mips/mips64-dsp/extrv_s_h.c          |  79 -------
 tests/tcg/mips/mips64-dsp/extrv_w.c            |  59 -----
 tests/tcg/mips/mips64-dsp/head.S               |  16 --
 tests/tcg/mips/mips64-dsp/insv.c               |  26 ---
 tests/tcg/mips/mips64-dsp/io.h                 |  22 --
 tests/tcg/mips/mips64-dsp/lbux.c               |  27 ---
 tests/tcg/mips/mips64-dsp/ldx.c                |  27 ---
 tests/tcg/mips/mips64-dsp/lhx.c                |  27 ---
 tests/tcg/mips/mips64-dsp/lwx.c                |  27 ---
 tests/tcg/mips/mips64-dsp/madd.c               |  33 ---
 tests/tcg/mips/mips64-dsp/maddu.c              |  33 ---
 tests/tcg/mips/mips64-dsp/maq_s_l_pwl.c        |  56 -----
 tests/tcg/mips/mips64-dsp/maq_s_l_pwr.c        |  56 -----
 tests/tcg/mips/mips64-dsp/maq_s_w_phl.c        |  60 -----
 tests/tcg/mips/mips64-dsp/maq_s_w_phr.c        |  60 -----
 tests/tcg/mips/mips64-dsp/maq_s_w_qhll.c       |  62 -----
 tests/tcg/mips/mips64-dsp/maq_s_w_qhlr.c       |  62 -----
 tests/tcg/mips/mips64-dsp/maq_s_w_qhrl.c       |  63 -----
 tests/tcg/mips/mips64-dsp/maq_s_w_qhrr.c       |  63 -----
 tests/tcg/mips/mips64-dsp/maq_sa_w_phl.c       |  60 -----
 tests/tcg/mips/mips64-dsp/maq_sa_w_phr.c       |  60 -----
 tests/tcg/mips/mips64-dsp/maq_sa_w_qhll.c      |  62 -----
 tests/tcg/mips/mips64-dsp/maq_sa_w_qhlr.c      |  64 ------
 tests/tcg/mips/mips64-dsp/maq_sa_w_qhrl.c      |  64 ------
 tests/tcg/mips/mips64-dsp/maq_sa_w_qhrr.c      |  64 ------
 tests/tcg/mips/mips64-dsp/mfhi.c               |  24 --
 tests/tcg/mips/mips64-dsp/mflo.c               |  24 --
 tests/tcg/mips/mips64-dsp/mips_boot.lds        |  31 ---
 tests/tcg/mips/mips64-dsp/modsub.c             |  37 ---
 tests/tcg/mips/mips64-dsp/msub.c               |  32 ---
 tests/tcg/mips/mips64-dsp/msubu.c              |  32 ---
 tests/tcg/mips/mips64-dsp/mthi.c               |  24 --
 tests/tcg/mips/mips64-dsp/mthlip.c             |  61 -----
 tests/tcg/mips/mips64-dsp/mtlo.c               |  22 --
 tests/tcg/mips/mips64-dsp/muleq_s_pw_qhl.c     |  56 -----
 tests/tcg/mips/mips64-dsp/muleq_s_pw_qhr.c     |  57 -----
 tests/tcg/mips/mips64-dsp/muleq_s_w_phl.c      |  46 ----
 tests/tcg/mips/mips64-dsp/muleq_s_w_phr.c      |  45 ----
 tests/tcg/mips/mips64-dsp/muleu_s_ph_qbl.c     |  27 ---
 tests/tcg/mips/mips64-dsp/muleu_s_ph_qbr.c     |  27 ---
 tests/tcg/mips/mips64-dsp/muleu_s_qh_obl.c     |  30 ---
 tests/tcg/mips/mips64-dsp/muleu_s_qh_obr.c     |  31 ---
 tests/tcg/mips/mips64-dsp/mulq_rs_ph.c         |  27 ---
 tests/tcg/mips/mips64-dsp/mulq_rs_qh.c         |  33 ---
 tests/tcg/mips/mips64-dsp/mulsaq_s_l_pw.c      |  59 -----
 tests/tcg/mips/mips64-dsp/mulsaq_s_w_qh.c      |  57 -----
 tests/tcg/mips/mips64-dsp/mult.c               |  26 ---
 tests/tcg/mips/mips64-dsp/multu.c              |  26 ---
 tests/tcg/mips/mips64-dsp/packrl_ph.c          |  24 --
 tests/tcg/mips/mips64-dsp/packrl_pw.c          |  24 --
 tests/tcg/mips/mips64-dsp/pick_ob.c            |  66 ------
 tests/tcg/mips/mips64-dsp/pick_ph.c            |  60 -----
 tests/tcg/mips/mips64-dsp/pick_pw.c            |  48 ----
 tests/tcg/mips/mips64-dsp/pick_qb.c            |  43 ----
 tests/tcg/mips/mips64-dsp/pick_qh.c            |  48 ----
 tests/tcg/mips/mips64-dsp/preceq_l_pwl.c       |  24 --
 tests/tcg/mips/mips64-dsp/preceq_l_pwr.c       |  24 --
 tests/tcg/mips/mips64-dsp/preceq_pw_qhl.c      |  21 --
 tests/tcg/mips/mips64-dsp/preceq_pw_qhla.c     |  23 --
 tests/tcg/mips/mips64-dsp/preceq_pw_qhr.c      |  21 --
 tests/tcg/mips/mips64-dsp/preceq_pw_qhra.c     |  23 --
 tests/tcg/mips/mips64-dsp/preceq_w_phl.c       |  23 --
 tests/tcg/mips/mips64-dsp/preceq_w_phr.c       |  23 --
 tests/tcg/mips/mips64-dsp/precequ_ph_qbl.c     |  23 --
 tests/tcg/mips/mips64-dsp/precequ_ph_qbla.c    |  23 --
 tests/tcg/mips/mips64-dsp/precequ_ph_qbr.c     |  23 --
 tests/tcg/mips/mips64-dsp/precequ_ph_qbra.c    |  23 --
 tests/tcg/mips/mips64-dsp/precequ_qh_obl.c     |  22 --
 tests/tcg/mips/mips64-dsp/precequ_qh_obla.c    |  22 --
 tests/tcg/mips/mips64-dsp/precequ_qh_obr.c     |  24 --
 tests/tcg/mips/mips64-dsp/precequ_qh_obra.c    |  24 --
 tests/tcg/mips/mips64-dsp/preceu_ph_qbl.c      |  23 --
 tests/tcg/mips/mips64-dsp/preceu_ph_qbla.c     |  23 --
 tests/tcg/mips/mips64-dsp/preceu_ph_qbr.c      |  23 --
 tests/tcg/mips/mips64-dsp/preceu_ph_qbra.c     |  23 --
 tests/tcg/mips/mips64-dsp/preceu_qh_obl.c      |  22 --
 tests/tcg/mips/mips64-dsp/preceu_qh_obla.c     |  22 --
 tests/tcg/mips/mips64-dsp/preceu_qh_obr.c      |  23 --
 tests/tcg/mips/mips64-dsp/preceu_qh_obra.c     |  23 --
 tests/tcg/mips/mips64-dsp/precr_ob_qh.c        |  25 --
 tests/tcg/mips/mips64-dsp/precr_sra_qh_pw.c    |  40 ----
 tests/tcg/mips/mips64-dsp/precr_sra_r_qh_pw.c  |  40 ----
 tests/tcg/mips/mips64-dsp/precrq_ob_qh.c       |  25 --
 tests/tcg/mips/mips64-dsp/precrq_ph_w.c        |  24 --
 tests/tcg/mips/mips64-dsp/precrq_pw_l.c        |  25 --
 tests/tcg/mips/mips64-dsp/precrq_qb_ph.c       |  24 --
 tests/tcg/mips/mips64-dsp/precrq_qh_pw.c       |  25 --
 tests/tcg/mips/mips64-dsp/precrq_rs_ph_w.c     |  41 ----
 tests/tcg/mips/mips64-dsp/precrq_rs_qh_pw.c    |  43 ----
 tests/tcg/mips/mips64-dsp/precrqu_s_ob_qh.c    |  27 ---
 tests/tcg/mips/mips64-dsp/precrqu_s_qb_ph.c    |  26 ---
 tests/tcg/mips/mips64-dsp/prependd.c           |  37 ---
 tests/tcg/mips/mips64-dsp/prependw.c           |  37 ---
 tests/tcg/mips/mips64-dsp/printf.c             | 266 ---------------------
 tests/tcg/mips/mips64-dsp/raddu_l_ob.c         |  22 --
 tests/tcg/mips/mips64-dsp/raddu_w_qb.c         |  23 --
 tests/tcg/mips/mips64-dsp/rddsp.c              |  53 -----
 tests/tcg/mips/mips64-dsp/repl_ob.c            |  21 --
 tests/tcg/mips/mips64-dsp/repl_ph.c            |  30 ---
 tests/tcg/mips/mips64-dsp/repl_pw.c            |  34 ---
 tests/tcg/mips/mips64-dsp/repl_qb.c            |  19 --
 tests/tcg/mips/mips64-dsp/repl_qh.c            |  34 ---
 tests/tcg/mips/mips64-dsp/replv_ob.c           |  23 --
 tests/tcg/mips/mips64-dsp/replv_ph.c           |  22 --
 tests/tcg/mips/mips64-dsp/replv_pw.c           |  23 --
 tests/tcg/mips/mips64-dsp/replv_qb.c           |  22 --
 tests/tcg/mips/mips64-dsp/shilo.c              |  29 ---
 tests/tcg/mips/mips64-dsp/shilov.c             |  31 ---
 tests/tcg/mips/mips64-dsp/shll_ob.c            |  43 ----
 tests/tcg/mips/mips64-dsp/shll_ph.c            |  43 ----
 tests/tcg/mips/mips64-dsp/shll_pw.c            |  43 ----
 tests/tcg/mips/mips64-dsp/shll_qb.c            |  26 ---
 tests/tcg/mips/mips64-dsp/shll_qh.c            |  42 ----
 tests/tcg/mips/mips64-dsp/shll_s_ph.c          |  43 ----
 tests/tcg/mips/mips64-dsp/shll_s_pw.c          |  43 ----
 tests/tcg/mips/mips64-dsp/shll_s_qh.c          |  43 ----
 tests/tcg/mips/mips64-dsp/shll_s_w.c           |  26 ---
 tests/tcg/mips/mips64-dsp/shllv_ob.c           |  45 ----
 tests/tcg/mips/mips64-dsp/shllv_ph.c           |  27 ---
 tests/tcg/mips/mips64-dsp/shllv_pw.c           |  45 ----
 tests/tcg/mips/mips64-dsp/shllv_qb.c           |  27 ---
 tests/tcg/mips/mips64-dsp/shllv_qh.c           |  45 ----
 tests/tcg/mips/mips64-dsp/shllv_s_ph.c         |  27 ---
 tests/tcg/mips/mips64-dsp/shllv_s_pw.c         |  45 ----
 tests/tcg/mips/mips64-dsp/shllv_s_qh.c         |  45 ----
 tests/tcg/mips/mips64-dsp/shllv_s_w.c          |  27 ---
 tests/tcg/mips/mips64-dsp/shra_ob.c            |  23 --
 tests/tcg/mips/mips64-dsp/shra_ph.c            |  23 --
 tests/tcg/mips/mips64-dsp/shra_pw.c            |  36 ---
 tests/tcg/mips/mips64-dsp/shra_qh.c            |  37 ---
 tests/tcg/mips/mips64-dsp/shra_r_ob.c          |  22 --
 tests/tcg/mips/mips64-dsp/shra_r_ph.c          |  23 --
 tests/tcg/mips/mips64-dsp/shra_r_pw.c          |  36 ---
 tests/tcg/mips/mips64-dsp/shra_r_qh.c          |  37 ---
 tests/tcg/mips/mips64-dsp/shra_r_w.c           |  23 --
 tests/tcg/mips/mips64-dsp/shrav_ph.c           |  24 --
 tests/tcg/mips/mips64-dsp/shrav_pw.c           |  38 ---
 tests/tcg/mips/mips64-dsp/shrav_qh.c           |  39 ----
 tests/tcg/mips/mips64-dsp/shrav_r_ph.c         |  24 --
 tests/tcg/mips/mips64-dsp/shrav_r_pw.c         |  37 ---
 tests/tcg/mips/mips64-dsp/shrav_r_qh.c         |  39 ----
 tests/tcg/mips/mips64-dsp/shrav_r_w.c          |  24 --
 tests/tcg/mips/mips64-dsp/shrl_ob.c            |  38 ---
 tests/tcg/mips/mips64-dsp/shrl_qb.c            |  23 --
 tests/tcg/mips/mips64-dsp/shrl_qh.c            |  22 --
 tests/tcg/mips/mips64-dsp/shrlv_ob.c           |  39 ----
 tests/tcg/mips/mips64-dsp/shrlv_qb.c           |  24 --
 tests/tcg/mips/mips64-dsp/shrlv_qh.c           |  23 --
 tests/tcg/mips/mips64-dsp/subq_ph.c            |  27 ---
 tests/tcg/mips/mips64-dsp/subq_pw.c            |  44 ----
 tests/tcg/mips/mips64-dsp/subq_qh.c            |  26 ---
 tests/tcg/mips/mips64-dsp/subq_s_ph.c          |  27 ---
 tests/tcg/mips/mips64-dsp/subq_s_pw.c          |  63 -----
 tests/tcg/mips/mips64-dsp/subq_s_qh.c          |  61 -----
 tests/tcg/mips/mips64-dsp/subq_s_w.c           |  27 ---
 tests/tcg/mips/mips64-dsp/subu_ob.c            |  26 ---
 tests/tcg/mips/mips64-dsp/subu_qb.c            |  27 ---
 tests/tcg/mips/mips64-dsp/subu_s_ob.c          |  26 ---
 tests/tcg/mips/mips64-dsp/subu_s_qb.c          |  27 ---
 tests/tcg/mips/mips64-dsp/wrdsp.c              |  48 ----
 tests/tcg/mips/mips64-dspr2/Makefile           | 116 ----------
 tests/tcg/mips/mips64-dspr2/absq_s_qb.c        |  42 ----
 tests/tcg/mips/mips64-dspr2/addqh_ph.c         |  35 ---
 tests/tcg/mips/mips64-dspr2/addqh_r_ph.c       |  35 ---
 tests/tcg/mips/mips64-dspr2/addqh_r_w.c        |  38 ---
 tests/tcg/mips/mips64-dspr2/addqh_w.c          |  39 ----
 tests/tcg/mips/mips64-dspr2/addu_ph.c          |  37 ---
 tests/tcg/mips/mips64-dspr2/addu_qh.c          |  43 ----
 tests/tcg/mips/mips64-dspr2/addu_s_ph.c        |  37 ---
 tests/tcg/mips/mips64-dspr2/addu_s_qh.c        |  43 ----
 tests/tcg/mips/mips64-dspr2/adduh_ob.c         |  35 ---
 tests/tcg/mips/mips64-dspr2/adduh_qb.c         |  35 ---
 tests/tcg/mips/mips64-dspr2/adduh_r_ob.c       |  35 ---
 tests/tcg/mips/mips64-dspr2/adduh_r_qb.c       |  35 ---
 tests/tcg/mips/mips64-dspr2/append.c           |  35 ---
 tests/tcg/mips/mips64-dspr2/balign.c           |  35 ---
 tests/tcg/mips/mips64-dspr2/cmpgdu_eq_ob.c     |  44 ----
 tests/tcg/mips/mips64-dspr2/cmpgdu_eq_qb.c     |  41 ----
 tests/tcg/mips/mips64-dspr2/cmpgdu_le_ob.c     |  44 ----
 tests/tcg/mips/mips64-dspr2/cmpgdu_le_qb.c     |  48 ----
 tests/tcg/mips/mips64-dspr2/cmpgdu_lt_ob.c     |  44 ----
 tests/tcg/mips/mips64-dspr2/cmpgdu_lt_qb.c     |  48 ----
 tests/tcg/mips/mips64-dspr2/dbalign.c          |  39 ----
 tests/tcg/mips/mips64-dspr2/dpa_w_ph.c         |  47 ----
 tests/tcg/mips/mips64-dspr2/dpa_w_qh.c         |  56 -----
 tests/tcg/mips/mips64-dspr2/dpaqx_s_w_ph.c     |  97 --------
 tests/tcg/mips/mips64-dspr2/dpaqx_sa_w_ph.c    |  54 -----
 tests/tcg/mips/mips64-dspr2/dpax_w_ph.c        |  32 ---
 tests/tcg/mips/mips64-dspr2/dps_w_ph.c         |  28 ---
 tests/tcg/mips/mips64-dspr2/dps_w_qh.c         |  55 -----
 tests/tcg/mips/mips64-dspr2/dpsqx_s_w_ph.c     |  55 -----
 tests/tcg/mips/mips64-dspr2/dpsqx_sa_w_ph.c    |  53 -----
 tests/tcg/mips/mips64-dspr2/dpsx_w_ph.c        |  28 ---
 tests/tcg/mips/mips64-dspr2/head.S             |  16 --
 tests/tcg/mips/mips64-dspr2/io.h               |  22 --
 tests/tcg/mips/mips64-dspr2/mips_boot.lds      |  31 ---
 tests/tcg/mips/mips64-dspr2/mul_ph.c           |  50 ----
 tests/tcg/mips/mips64-dspr2/mul_s_ph.c         |  67 ------
 tests/tcg/mips/mips64-dspr2/mulq_rs_w.c        |  40 ----
 tests/tcg/mips/mips64-dspr2/mulq_s_ph.c        |  26 ---
 tests/tcg/mips/mips64-dspr2/mulq_s_w.c         |  40 ----
 tests/tcg/mips/mips64-dspr2/mulsa_w_ph.c       |  30 ---
 tests/tcg/mips/mips64-dspr2/mulsaq_s_w_ph.c    |  30 ---
 tests/tcg/mips/mips64-dspr2/precr_qb_ph.c      |  23 --
 tests/tcg/mips/mips64-dspr2/precr_sra_ph_w.c   |  37 ---
 tests/tcg/mips/mips64-dspr2/precr_sra_r_ph_w.c |  37 ---
 tests/tcg/mips/mips64-dspr2/prepend.c          |  35 ---
 tests/tcg/mips/mips64-dspr2/printf.c           | 266 ---------------------
 tests/tcg/mips/mips64-dspr2/shra_qb.c          |  35 ---
 tests/tcg/mips/mips64-dspr2/shra_r_qb.c        |  35 ---
 tests/tcg/mips/mips64-dspr2/shrav_ob.c         |  22 --
 tests/tcg/mips/mips64-dspr2/shrav_qb.c         |  37 ---
 tests/tcg/mips/mips64-dspr2/shrav_r_ob.c       |  22 --
 tests/tcg/mips/mips64-dspr2/shrav_r_qb.c       |  37 ---
 tests/tcg/mips/mips64-dspr2/shrl_ph.c          |  22 --
 tests/tcg/mips/mips64-dspr2/shrlv_ph.c         |  23 --
 tests/tcg/mips/mips64-dspr2/subqh_ph.c         |  23 --
 tests/tcg/mips/mips64-dspr2/subqh_r_ph.c       |  23 --
 tests/tcg/mips/mips64-dspr2/subqh_r_w.c        |  23 --
 tests/tcg/mips/mips64-dspr2/subqh_w.c          |  23 --
 tests/tcg/mips/mips64-dspr2/subu_ph.c          |  26 ---
 tests/tcg/mips/mips64-dspr2/subu_qh.c          |  24 --
 tests/tcg/mips/mips64-dspr2/subu_s_ph.c        |  25 --
 tests/tcg/mips/mips64-dspr2/subu_s_qh.c        |  42 ----
 tests/tcg/mips/mips64-dspr2/subuh_ob.c         |  36 ---
 tests/tcg/mips/mips64-dspr2/subuh_qb.c         |  23 --
 tests/tcg/mips/mips64-dspr2/subuh_r_ob.c       |  23 --
 tests/tcg/mips/mips64-dspr2/subuh_r_qb.c       |  37 ---
 tests/tcg/mips/mipsr5900/Makefile              |  32 ---
 327 files changed, 13708 deletions(-)
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
diff --git a/tests/tcg/mips/mips64-dsp/absq_s_ob.c b/tests/tcg/mips/mips64-dsp/absq_s_ob.c
deleted file mode 100644
index 6214031..0000000
--- a/tests/tcg/mips/mips64-dsp/absq_s_ob.c
+++ /dev/null
@@ -1,63 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result, dspcontrol;
-    rt = 0x7F7F7F7F7F7F7F7F;
-    result = 0x7F7F7F7F7F7F7F7F;
-
-
-    __asm
-        (".set mips64\n\t"
-         "absq_s.ob %0 %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("absq_s.ob test 1 error\n");
-
-        return -1;
-    }
-
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(rd)
-        );
-    rd >> 20;
-    rd = rd & 0x1;
-    if (rd != 0) {
-        printf("absq_s.ob test 1 dspcontrol overflow flag error\n");
-
-        return -1;
-    }
-
-    rt = 0x80FFFFFFFFFFFFFF;
-    result = 0x7F01010101010101;
-
-    __asm
-        ("absq_s.ob %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("absq_s.ob test 2 error\n");
-
-        return -1;
-    }
-
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(rd)
-        );
-    rd = rd >> 20;
-    rd = rd & 0x1;
-    if (rd != 1) {
-        printf("absq_s.ob test 2 dspcontrol overflow flag error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/absq_s_ph.c b/tests/tcg/mips/mips64-dsp/absq_s_ph.c
deleted file mode 100644
index 238416d..0000000
--- a/tests/tcg/mips/mips64-dsp/absq_s_ph.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt     = 0x10017EFD;
-    result = 0x10017EFD;
-
-    __asm
-        ("absq_s.ph %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("absq_s.ph wrong\n");
-
-        return -1;
-    }
-
-    rt     = 0x8000A536;
-    result = 0x7FFF5ACA;
-
-    __asm
-        ("absq_s.ph %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("absq_s.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/absq_s_pw.c b/tests/tcg/mips/mips64-dsp/absq_s_pw.c
deleted file mode 100644
index 48fc763..0000000
--- a/tests/tcg/mips/mips64-dsp/absq_s_pw.c
+++ /dev/null
@@ -1,66 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result, dspcontrol;
-    rd = 0;
-    rt = 0x7F7F7F7F7F7F7F7F;
-    result = 0x7F7F7F7F7F7F7F7F;
-
-
-    __asm
-        ("absq_s.pw %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("absq_s.pw test 1 error\n");
-
-        return -1;
-    }
-
-    rd = 0;
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(rd)
-        );
-    rd >> 20;
-    rd = rd & 0x1;
-    if (rd != 0) {
-        printf("absq_s.pw test 1 dspcontrol overflow flag error\n");
-
-        return -1;
-    }
-
-    rd = 0;
-    rt = 0x80000000FFFFFFFF;
-    result = 0x7FFFFFFF00000001;
-
-    __asm
-        ("absq_s.pw %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("absq_s.pw test 2 error\n");
-
-        return -1;
-    }
-
-    rd = 0;
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(rd)
-        );
-    rd = rd >> 20;
-    rd = rd & 0x1;
-    if (rd != 1) {
-        printf("absq_s.pw test 2 dspcontrol overflow flag error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/absq_s_qh.c b/tests/tcg/mips/mips64-dsp/absq_s_qh.c
deleted file mode 100644
index 9001a9e..0000000
--- a/tests/tcg/mips/mips64-dsp/absq_s_qh.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result, dspcontrol;
-    rd = 0;
-    rt = 0x7F7F7F7F7F7F7F7F;
-    result = 0x7F7F7F7F7F7F7F7F;
-
-
-    __asm
-        ("absq_s.qh %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("absq_s.qh test 1 error\n");
-
-        return -1;
-    }
-
-    rd = 0;
-    rt = 0x8000FFFFFFFFFFFF;
-    result = 0x7FFF000100000001;
-
-    __asm
-        ("absq_s.pw %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("absq_s.rw test 2 error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/absq_s_w.c b/tests/tcg/mips/mips64-dsp/absq_s_w.c
deleted file mode 100644
index 414c8bd..0000000
--- a/tests/tcg/mips/mips64-dsp/absq_s_w.c
+++ /dev/null
@@ -1,48 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt     = 0x80000000;
-    result = 0x7FFFFFFF;
-    __asm
-        ("absq_s.w %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("absq_s_w.ph wrong\n");
-
-        return -1;
-    }
-
-    rt     = 0x80030000;
-    result = 0x7FFD0000;
-    __asm
-        ("absq_s.w %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("absq_s_w.ph wrong\n");
-
-        return -1;
-    }
-
-    rt     = 0x31036080;
-    result = 0x31036080;
-    __asm
-        ("absq_s.w %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("absq_s_w.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addq_ph.c b/tests/tcg/mips/mips64-dsp/addq_ph.c
deleted file mode 100644
index 22a36d9..0000000
--- a/tests/tcg/mips/mips64-dsp/addq_ph.c
+++ /dev/null
@@ -1,57 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs     = 0xFFFFFFFF;
-    rt     = 0x10101010;
-    result = 0x100F100F;
-    __asm
-        ("addq.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("1 addq.ph wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x3712847D;
-    rt     = 0x0031AF2D;
-    result = 0x374333AA;
-    __asm
-        ("addq.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("2 addq.ph wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x7fff847D;
-    rt     = 0x0031AF2D;
-    result = 0xffffffff803033AA;
-    __asm
-        ("addq.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    __asm("rddsp %0\n\t"
-          : "=r"(dsp)
-         );
-
-    if (rd != result || (((dsp >> 20) & 0x01) != 1)) {
-        printf("3 addq.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addq_pw.c b/tests/tcg/mips/mips64-dsp/addq_pw.c
deleted file mode 100644
index 99a7668..0000000
--- a/tests/tcg/mips/mips64-dsp/addq_pw.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-
-    rs = 0x123456787FFFFFFF;
-    rt = 0x1111111100000101;
-    result = 0x2345678980000100;
-    dspresult = 0x1;
-
-    __asm
-        ("addq.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("addq.pw error\n");
-
-        return -1;
-    }
-
-    rs = 0x1234567880FFFFFF;
-    rt = 0x1111111180000001;
-    result = 0x2345678901000000;
-    dspresult = 0x1;
-
-    __asm
-        ("addq.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("addq.pw error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addq_qh.c b/tests/tcg/mips/mips64-dsp/addq_qh.c
deleted file mode 100644
index 4b874af..0000000
--- a/tests/tcg/mips/mips64-dsp/addq_qh.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-
-    rs = 0x123456787FFF8010;
-    rt = 0x1111111100018000;
-    result = 0x2345678980000010;
-    dspresult = 0x1;
-
-    __asm
-        ("addq.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("addq.qh error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addq_s_ph.c b/tests/tcg/mips/mips64-dsp/addq_s_ph.c
deleted file mode 100644
index ad84cdc..0000000
--- a/tests/tcg/mips/mips64-dsp/addq_s_ph.c
+++ /dev/null
@@ -1,84 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs     = 0xFFFFFFFF;
-    rt     = 0x10101010;
-    result = 0x100F100F;
-    __asm
-        ("addq_s.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("1 addq_s.ph wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x3712847D;
-    rt     = 0x0031AF2D;
-    result = 0x37438000;
-    __asm
-        ("addq_s.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(dsp)
-        );
-
-    if ((rd != result) || (((dsp >> 20) & 0x01) != 1)) {
-        printf("2 addq_s.ph wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x7fff847D;
-    rt     = 0x0031AF2D;
-    result = 0x7fff8000;
-    __asm
-        ("addq_s.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(dsp)
-        );
-
-    if ((rd != result) || (((dsp >> 20) & 0x01) != 1)) {
-        printf("3 addq_s.ph wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x8030847D;
-    rt     = 0x8a00AF2D;
-    result = 0xffffffff80008000;
-    __asm
-        ("addq_s.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(dsp)
-        );
-
-    if ((rd != result) || (((dsp >> 20) & 0x01) != 1)) {
-        printf("4 addq_s.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addq_s_pw.c b/tests/tcg/mips/mips64-dsp/addq_s_pw.c
deleted file mode 100644
index 2e380bb..0000000
--- a/tests/tcg/mips/mips64-dsp/addq_s_pw.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-    rs = 0x123456787FFFFFFF;
-    rt = 0x1111111100000001;
-    result = 0x234567897FFFFFFF;
-    dspresult = 0x1;
-
-    __asm
-        ("addq_s.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("addq_s.pw error\n");
-
-        return -1;
-    }
-
-    rs = 0x80FFFFFFE00000FF;
-    rt = 0x80000001200000DD;
-    result = 0x80000000000001DC;
-    dspresult = 0x01;
-
-    __asm
-        ("addq_s.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("addq_s.pw error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addq_s_qh.c b/tests/tcg/mips/mips64-dsp/addq_s_qh.c
deleted file mode 100644
index b638a2b..0000000
--- a/tests/tcg/mips/mips64-dsp/addq_s_qh.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-    rs = 0x123456787FFF8000;
-    rt = 0x1111111100028000;
-    result = 0x234567897FFF8000;
-    dspresult = 0x1;
-
-    __asm
-        ("addq_s.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("addq_s.qh error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addq_s_w.c b/tests/tcg/mips/mips64-dsp/addq_s_w.c
deleted file mode 100644
index 3e08f5d..0000000
--- a/tests/tcg/mips/mips64-dsp/addq_s_w.c
+++ /dev/null
@@ -1,48 +0,0 @@
-#include "io.h"
-
-int main()
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rt     = 0x10017EFD;
-    rs     = 0x11111111;
-    result = 0x2112900e;
-
-    __asm
-        ("addq_s.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("addq_s.w error\n");
-    }
-
-    rt     = 0x80017EFD;
-    rs     = 0x81111111;
-    result = 0xffffffff80000000;
-
-    __asm
-        ("addq_s.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("addq_s.w error\n");
-    }
-
-    rt     = 0x7fffffff;
-    rs     = 0x01111111;
-    result = 0x7fffffff;
-
-    __asm
-        ("addq_s.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("addq_s.w error\n");
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addsc.c b/tests/tcg/mips/mips64-dsp/addsc.c
deleted file mode 100644
index 4b684b9..0000000
--- a/tests/tcg/mips/mips64-dsp/addsc.c
+++ /dev/null
@@ -1,39 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs     = 0x0000000F;
-    rt     = 0x00000001;
-    result = 0x00000010;
-    __asm
-        ("addsc %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("1 addsc wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0xFFFF0FFF;
-    rt     = 0x00010111;
-    result = 0x00001110;
-    __asm
-        ("addsc %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((rd != result) || (((dsp >> 13) & 0x01) != 1)) {
-        printf("2 addsc wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addu_ob.c b/tests/tcg/mips/mips64-dsp/addu_ob.c
deleted file mode 100644
index 17f9c66..0000000
--- a/tests/tcg/mips/mips64-dsp/addu_ob.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x3456123498DEF390;
-    result = 0x468A68AC329AD180;
-    dspresult = 0x01;
-
-    __asm
-        ("addu.ob %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("addu.ob error\n\t");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addu_qb.c b/tests/tcg/mips/mips64-dsp/addu_qb.c
deleted file mode 100644
index 3b9b5fc..0000000
--- a/tests/tcg/mips/mips64-dsp/addu_qb.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs     = 0x00FF00FF;
-    rt     = 0x00010001;
-    result = 0x00000000;
-    __asm
-        ("addu.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((rd != result) || (((dsp >> 20) & 0x01) != 1)) {
-        printf("1 addu.qb wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0xFFFF1111;
-    rt     = 0x00020001;
-    result = 0xFFFFFFFFFF011112;
-    __asm
-        ("addu.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((rd != result) || (((dsp >> 20) & 0x01) != 1)) {
-        printf("2 addu.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addu_s_ob.c b/tests/tcg/mips/mips64-dsp/addu_s_ob.c
deleted file mode 100644
index e89a463..0000000
--- a/tests/tcg/mips/mips64-dsp/addu_s_ob.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-    rs = 0x123456789ABCDEF0;
-    rt = 0x3456123498DEF390;
-    result = 0x468A68ACFFFFFFFF;
-    dspresult = 0x01;
-
-    __asm
-        ("addu_s.ob %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("addu_s.ob error\n\t");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addu_s_qb.c b/tests/tcg/mips/mips64-dsp/addu_s_qb.c
deleted file mode 100644
index cb84293..0000000
--- a/tests/tcg/mips/mips64-dsp/addu_s_qb.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs     = 0x10FF01FF;
-    rt     = 0x10010001;
-    result = 0x20FF01FF;
-    __asm
-        ("addu_s.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((rd != result) || (((dsp >> 20) & 0x1) != 1)) {
-        printf("1 addu_s.qb error 1\n");
-
-        return -1;
-    }
-
-    rs     = 0xFFFFFFFFFFFF1111;
-    rt     = 0x00020001;
-    result = 0xFFFFFFFFFFFF1112;
-    __asm
-        ("addu_s.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((rd != result) || (((dsp >> 20) & 0x1) != 1)) {
-        printf("2 addu_s.qb error 2\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/addwc.c b/tests/tcg/mips/mips64-dsp/addwc.c
deleted file mode 100644
index 5929cd2..0000000
--- a/tests/tcg/mips/mips64-dsp/addwc.c
+++ /dev/null
@@ -1,59 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dspi, dspo;
-    long long result;
-
-    rs     = 0x10FF01FF;
-    rt     = 0x10010001;
-    dspi   = 0x00002000;
-    result = 0x21000201;
-    __asm
-        ("wrdsp %3\n"
-         "addwc %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt), "r"(dspi)
-        );
-    if (rd != result) {
-        printf("1 addwc wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0xFFFF1111;
-    rt     = 0x00020001;
-    dspi   = 0x00;
-    result = 0x00011112;
-    __asm
-        ("wrdsp %3\n"
-         "addwc %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt), "r"(dspi)
-        );
-    if (rd != result) {
-        printf("2 addwc wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x8FFF1111;
-    rt     = 0x80020001;
-    dspi   = 0x00;
-    result = 0x10011112;
-    __asm
-        ("wrdsp %4\n"
-         "addwc %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspo)
-         : "r"(rs), "r"(rt), "r"(dspi)
-        );
-    if ((rd != result) || (((dspo >> 20) & 0x01) != 1)) {
-        printf("3 addwc wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/bitrev.c b/tests/tcg/mips/mips64-dsp/bitrev.c
deleted file mode 100644
index ac24ef3..0000000
--- a/tests/tcg/mips/mips64-dsp/bitrev.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt     = 0x12345678;
-    result = 0x00001E6A;
-
-    __asm
-        ("bitrev %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("bitrev wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/bposge32.c b/tests/tcg/mips/mips64-dsp/bposge32.c
deleted file mode 100644
index 97bce44..0000000
--- a/tests/tcg/mips/mips64-dsp/bposge32.c
+++ /dev/null
@@ -1,50 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long dsp, sum;
-    long long result;
-
-    dsp =  0x20;
-    sum = 0x01;
-    result = 0x02;
-
-    __asm
-        ("wrdsp %1\n\t"
-         "bposge32 test1\n\t"
-         "nop\n\t"
-         "addi %0, 0xA2\n\t"
-         "nop\n\t"
-         "test1:\n\t"
-         "addi %0, 0x01\n\t"
-         : "+r"(sum)
-         : "r"(dsp)
-        );
-    if (sum != result) {
-        printf("bposge32 wrong\n");
-
-        return -1;
-    }
-
-    dsp =  0x10;
-    sum = 0x01;
-    result = 0xA4;
-
-    __asm
-        ("wrdsp %1\n\t"
-         "bposge32 test2\n\t"
-         "nop\n\t"
-         "addi %0, 0xA2\n\t"
-         "nop\n\t"
-         "test2:\n\t"
-         "addi %0, 0x01\n\t"
-         : "+r"(sum)
-         : "r"(dsp)
-        );
-    if (sum != result) {
-        printf("bposge32 wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/bposge64.c b/tests/tcg/mips/mips64-dsp/bposge64.c
deleted file mode 100644
index 36161ad..0000000
--- a/tests/tcg/mips/mips64-dsp/bposge64.c
+++ /dev/null
@@ -1,50 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long dsp, sum;
-    long long result;
-
-    dsp =  0x40;
-    sum = 0x01;
-    result = 0x02;
-
-    __asm
-        ("wrdsp %1\n\t"
-         "bposge64 test1\n\t"
-         "nop\n\t"
-         "addi %0, 0xA2\n\t"
-         "nop\n\t"
-         "test1:\n\t"
-         "addi %0, 0x01\n\t"
-         : "+r"(sum)
-         : "r"(dsp)
-        );
-    if (sum != result) {
-        printf("bposge64 wrong\n");
-
-        return -1;
-    }
-
-    dsp =  0x10;
-    sum = 0x01;
-    result = 0xA4;
-
-    __asm
-        ("wrdsp %1\n\t"
-         "bposge64 test2\n\t"
-         "nop\n\t"
-         "addi %0, 0xA2\n\t"
-         "nop\n\t"
-         "test2:\n\t"
-         "addi %0, 0x01\n\t"
-         : "+r"(sum)
-         : "r"(dsp)
-        );
-    if (sum != result) {
-        printf("bposge64 wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmp_eq_ph.c b/tests/tcg/mips/mips64-dsp/cmp_eq_ph.c
deleted file mode 100644
index 63069d0..0000000
--- a/tests/tcg/mips/mips64-dsp/cmp_eq_ph.c
+++ /dev/null
@@ -1,42 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x11777066;
-    rt     = 0x55AA33FF;
-    result = 0x00;
-    __asm
-        ("cmp.eq.ph %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    rd = (rd >> 24) & 0x03;
-    if (rd != result) {
-        printf("cmp.eq.ph wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x11777066;
-    rt     = 0x11777066;
-    result = 0x03;
-    __asm
-        ("cmp.eq.ph %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    rd = (rd >> 24) & 0x03;
-    if (rd != result) {
-        printf("cmp.eq.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmp_eq_pw.c b/tests/tcg/mips/mips64-dsp/cmp_eq_pw.c
deleted file mode 100644
index bae4c06..0000000
--- a/tests/tcg/mips/mips64-dsp/cmp_eq_pw.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-  long long rs, rt, dspreg, dspresult;
-
-  rs = 0x123456789ABCDEFF;
-  rt = 0x123456789ABCDEFF;
-  dspresult = 0x03;
-
-  __asm
-      ("cmp.eq.pw %1, %2\n\t"
-       "rddsp %0\n\t"
-       : "=r"(dspreg)
-       : "r"(rs), "r"(rt)
-      );
-
-  dspreg = ((dspreg >> 24) & 0x03);
-
-  if (dspreg != dspresult) {
-    printf("1 cmp.eq.pw error\n");
-
-    return -1;
-  }
-
-  rs = 0x123456799ABCDEFe;
-  rt = 0x123456789ABCDEFF;
-  dspresult = 0x00;
-
-  __asm
-      ("cmp.eq.pw %1, %2\n\t"
-       "rddsp %0\n\t"
-       : "=r"(dspreg)
-       : "r"(rs), "r"(rt)
-      );
-
-  dspreg = ((dspreg >> 24) & 0x03);
-
-  if (dspreg != dspresult) {
-    printf("2 cmp.eq.pw error\n");
-
-    return -1;
-  }
-
-  return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmp_eq_qh.c b/tests/tcg/mips/mips64-dsp/cmp_eq_qh.c
deleted file mode 100644
index 49ea271..0000000
--- a/tests/tcg/mips/mips64-dsp/cmp_eq_qh.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-  long long rs, rt, dspreg, dspresult;
-
-  rs = 0x123456789ABCDEF0;
-  rt = 0x123456789ABCDEFF;
-  dspresult = 0x0E;
-
-  __asm
-      ("cmp.eq.qh %1, %2\n\t"
-        "rddsp %0\n\t"
-        : "=r"(dspreg)
-        : "r"(rs), "r"(rt)
-       );
-
-  dspreg = ((dspreg >> 24) & 0x0F);
-
-  if (dspreg != dspresult) {
-    printf("cmp.eq.qh error\n");
-
-    return -1;
-  }
-
-  rs = 0x12355a789A4CD3F0;
-  rt = 0x123456789ABCDEFF;
-  dspresult = 0x00;
-
-  __asm
-      ("cmp.eq.qh %1, %2\n\t"
-        "rddsp %0\n\t"
-        : "=r"(dspreg)
-        : "r"(rs), "r"(rt)
-       );
-
-  dspreg = ((dspreg >> 24) & 0x0F);
-
-  if (dspreg != dspresult) {
-    printf("cmp.eq.qh error\n");
-
-    return -1;
-  }
-
-  return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmp_le_ph.c b/tests/tcg/mips/mips64-dsp/cmp_le_ph.c
deleted file mode 100644
index 12d24f1..0000000
--- a/tests/tcg/mips/mips64-dsp/cmp_le_ph.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x11777066;
-    rt     = 0x55AA33FF;
-    result = 0x02;
-    __asm
-        ("cmp.le.ph %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    rd = (rd >> 24) & 0x03;
-    if (rd != result) {
-        printf("cmp.le.ph wrong\n");
-
-        return -1;
-    }
-    rs     = 0x11777066;
-    rt     = 0x11777066;
-    result = 0x03;
-    __asm
-        ("cmp.le.ph %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    rd = (rd >> 24) & 0x03;
-    if (rd != result) {
-        printf("cmp.le.ph wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmp_le_pw.c b/tests/tcg/mips/mips64-dsp/cmp_le_pw.c
deleted file mode 100644
index 6acc43c..0000000
--- a/tests/tcg/mips/mips64-dsp/cmp_le_pw.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dspreg, dspresult;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x03;
-
-    __asm
-        ("cmp.le.pw %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 24) & 0x03);
-
-    if (dspreg != dspresult) {
-        printf("1 cmp.le.pw error\n");
-
-        return -1;
-    }
-
-    rs = 0x123456799ABCEEFF;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x00;
-
-    __asm
-        ("cmp.le.pw %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 24) & 0x03);
-
-    if (dspreg != dspresult) {
-        printf("2 cmp.le.pw error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmp_le_qh.c b/tests/tcg/mips/mips64-dsp/cmp_le_qh.c
deleted file mode 100644
index c9ce216..0000000
--- a/tests/tcg/mips/mips64-dsp/cmp_le_qh.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dspreg, dspresult;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x0F;
-
-    __asm
-        ("cmp.le.qh %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 24) & 0x0F);
-
-    if (dspreg != dspresult) {
-        printf("cmp.le.qh error\n");
-
-        return -1;
-    }
-
-    rs = 0x823456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x0f;
-
-    __asm
-        ("cmp.le.qh %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 24) & 0x0F);
-
-    if (dspreg != dspresult) {
-        printf("cmp.le.qh error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmp_lt_ph.c b/tests/tcg/mips/mips64-dsp/cmp_lt_ph.c
deleted file mode 100644
index 1d91228..0000000
--- a/tests/tcg/mips/mips64-dsp/cmp_lt_ph.c
+++ /dev/null
@@ -1,41 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x11777066;
-    rt     = 0x55AA33FF;
-    result = 0x02;
-    __asm
-        ("cmp.lt.ph %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    rd = (rd >> 24) & 0x03;
-    if (rd != result) {
-        printf("cmp.lt.ph wrong\n");
-
-        return -1;
-    }
-    rs     = 0x11777066;
-    rt     = 0x11777066;
-    result = 0x00;
-    __asm
-        ("cmp.lt.ph %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    rd = (rd >> 24) & 0x03;
-    if (rd != result) {
-        printf("cmp.lt.ph2 wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmp_lt_pw.c b/tests/tcg/mips/mips64-dsp/cmp_lt_pw.c
deleted file mode 100644
index 87e74ca..0000000
--- a/tests/tcg/mips/mips64-dsp/cmp_lt_pw.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dspreg, dspresult;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x01;
-
-    __asm
-        ("cmp.lt.pw %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 24) & 0x03);
-
-    if (dspreg != dspresult) {
-        printf("cmp.lt.pw error\n");
-
-        return -1;
-    }
-
-    rs = 0x123456779ABCDEFf;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x02;
-
-    __asm
-        ("cmp.lt.pw %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 24) & 0x03);
-
-    if (dspreg != dspresult) {
-        printf("cmp.lt.pw error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmp_lt_qh.c b/tests/tcg/mips/mips64-dsp/cmp_lt_qh.c
deleted file mode 100644
index 0a13a5e..0000000
--- a/tests/tcg/mips/mips64-dsp/cmp_lt_qh.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dspreg, dspresult;
-
-    rs = 0x123558789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x01;
-
-    __asm
-        ("cmp.lt.qh %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 24) & 0x0F);
-
-    if (dspreg != dspresult) {
-        printf("cmp.lt.qh error\n");
-
-        return -1;
-    }
-
-    rs = 0x123356779ABbDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x0f;
-
-    __asm
-        ("cmp.lt.qh %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 24) & 0x0F);
-
-    if (dspreg != dspresult) {
-        printf("cmp.lt.qh error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_eq_ob.c b/tests/tcg/mips/mips64-dsp/cmpgu_eq_ob.c
deleted file mode 100644
index 697d73d..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpgu_eq_ob.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    result = 0xFE;
-
-    __asm
-        ("cmpgu.eq.ob %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("cmpgu.eq.ob error\n");
-
-        return -1;
-    }
-
-    rs = 0x133456789ABCDEF0;
-    rt = 0x123556789ABCDEFF;
-    result = 0x3E;
-
-    __asm
-        ("cmpgu.eq.ob %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("cmpgu.eq.ob error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_eq_qb.c b/tests/tcg/mips/mips64-dsp/cmpgu_eq_qb.c
deleted file mode 100644
index b41c443..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpgu_eq_qb.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x11777066;
-    rt     = 0x55AA70FF;
-    result = 0x02;
-    __asm
-        ("cmpgu.eq.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("cmpgu.eq.ph wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x11777066;
-    rt     = 0x11777066;
-    result = 0x0F;
-    __asm
-        ("cmpgu.eq.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("cmpgu.eq.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_le_ob.c b/tests/tcg/mips/mips64-dsp/cmpgu_le_ob.c
deleted file mode 100644
index 8b65f18..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpgu_le_ob.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    result = 0xFF;
-
-    __asm
-        ("cmpgu.le.ob %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("cmpgu.le.ob error\n");
-
-        return -1;
-    }
-
-    rs = 0x823556789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    result = 0x3F;
-
-    __asm
-        ("cmpgu.le.ob %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("cmpgu.le.ob error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_le_qb.c b/tests/tcg/mips/mips64-dsp/cmpgu_le_qb.c
deleted file mode 100644
index dd2b091..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpgu_le_qb.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x11777066;
-    rt     = 0x55AA70FF;
-    result = 0x0F;
-    __asm
-        ("cmpgu.le.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("cmpgu.le.qb wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x11777066;
-    rt     = 0x11766066;
-    result = 0x09;
-    __asm
-        ("cmpgu.le.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("cmpgu.le.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_lt_ob.c b/tests/tcg/mips/mips64-dsp/cmpgu_lt_ob.c
deleted file mode 100644
index 3e5c9dd..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpgu_lt_ob.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    result = 0x01;
-
-    __asm
-        ("cmpgu.lt.ob %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("cmpgu.lt.ob error\n");
-
-        return -1;
-    }
-
-    rs = 0x823455789ABCDEF0;
-    rt = 0x123356789ABCDEFF;
-    result = 0x21;
-
-    __asm
-        ("cmpgu.lt.ob %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("cmpgu.lt.ob error\n");
-
-        return -1;
-    }
-
-   return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_lt_qb.c b/tests/tcg/mips/mips64-dsp/cmpgu_lt_qb.c
deleted file mode 100644
index a467cb7..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpgu_lt_qb.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x11777066;
-    rt     = 0x55AA70FF;
-    result = 0x0D;
-    __asm
-        ("cmpgu.lt.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("cmpgu.lt.qb wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x11777066;
-    rt     = 0x11766066;
-    result = 0x00;
-    __asm
-        ("cmpgu.lt.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("cmpgu.lt.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_eq_ob.c b/tests/tcg/mips/mips64-dsp/cmpu_eq_ob.c
deleted file mode 100644
index 4d1983e..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpu_eq_ob.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dspreg, dspresult;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0xFE;
-
-    __asm
-        ("cmpu.eq.ob %1, %2\n\t"
-         "rddsp %0"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 24) & 0xFF);
-
-    if (dspreg != dspresult) {
-        printf("cmpu.eq.ob error\n");
-
-        return -1;
-    }
-
-    rs = 0x133516713A0CD1F0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x00;
-
-    __asm
-        ("cmpu.eq.ob %1, %2\n\t"
-         "rddsp %0"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = ((dspreg >> 24) & 0xFF);
-
-    if (dspreg != dspresult) {
-        printf("cmpu.eq.ob error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_eq_qb.c b/tests/tcg/mips/mips64-dsp/cmpu_eq_qb.c
deleted file mode 100644
index 28f3bec..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpu_eq_qb.c
+++ /dev/null
@@ -1,42 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long dsp;
-    long long result;
-
-    rs         = 0x11777066;
-    rt         = 0x55AA70FF;
-    result     = 0x02;
-    __asm
-        ("cmpu.eq.qb %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if (dsp != result) {
-        printf("cmpu.eq.qb wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x11777066;
-    rt     = 0x11777066;
-    result = 0x0F;
-    __asm
-        ("cmpu.eq.qb %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if (dsp != result) {
-        printf("cmpu.eq.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_le_ob.c b/tests/tcg/mips/mips64-dsp/cmpu_le_ob.c
deleted file mode 100644
index 8acbd1c..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpu_le_ob.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dspreg, dspresult;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0xFF;
-
-    __asm
-        ("cmpu.le.ob %1, %2\n\t"
-         "rddsp %0"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = dspreg >> 24;
-    if (dspreg != dspresult) {
-        printf("cmpu.le.ob error\n");
-
-        return -1;
-    }
-
-    rs = 0x823656789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x3F;
-
-    __asm
-        ("cmpu.le.ob %1, %2\n\t"
-         "rddsp %0"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = dspreg >> 24;
-    if (dspreg != dspresult) {
-        printf("cmpu.le.ob error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_le_qb.c b/tests/tcg/mips/mips64-dsp/cmpu_le_qb.c
deleted file mode 100644
index 8a17a08..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpu_le_qb.c
+++ /dev/null
@@ -1,41 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long dsp;
-    long long result;
-
-    rs         = 0x11777066;
-    rt         = 0x55AA70FF;
-    result     = 0x0F;
-    __asm
-        ("cmpu.le.qb %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if (dsp != result) {
-        printf("cmpu.le.qb wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x11777066;
-    rt     = 0x11777066;
-    result = 0x0F;
-    __asm
-        ("cmpu.le.qb %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if (dsp != result) {
-        printf("cmpu.le.qb wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_lt_ob.c b/tests/tcg/mips/mips64-dsp/cmpu_lt_ob.c
deleted file mode 100644
index 34e312d..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpu_lt_ob.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dspreg, dspresult;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x01;
-
-    __asm
-        ("cmpu.lt.ob %1, %2\n\t"
-         "rddsp %0"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = dspreg >> 24;
-    if (dspreg != dspresult) {
-        printf("cmpu.lt.ob error\n");
-
-        return -1;
-    }
-
-    rs = 0x823156789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x41;
-
-    __asm
-        ("cmpu.lt.ob %1, %2\n\t"
-         "rddsp %0"
-         : "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = dspreg >> 24;
-    if (dspreg != dspresult) {
-        printf("cmpu.lt.ob error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_lt_qb.c b/tests/tcg/mips/mips64-dsp/cmpu_lt_qb.c
deleted file mode 100644
index adb75ee..0000000
--- a/tests/tcg/mips/mips64-dsp/cmpu_lt_qb.c
+++ /dev/null
@@ -1,42 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long dsp;
-    long long result;
-
-    rs         = 0x11777066;
-    rt         = 0x55AA70FF;
-    result     = 0x0D;
-    __asm
-        ("cmpu.lt.qb %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if (dsp != result) {
-        printf("cmpu.lt.qb wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x11777066;
-    rt     = 0x11777066;
-    result = 0x00;
-    __asm
-        ("cmpu.lt.qb %1, %2\n\t"
-         "rddsp %0\n\t"
-         : "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if (dsp != result) {
-        printf("cmpu.lt.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dappend.c b/tests/tcg/mips/mips64-dsp/dappend.c
deleted file mode 100644
index ba8e121..0000000
--- a/tests/tcg/mips/mips64-dsp/dappend.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long res;
-    rt = 0x1234567887654321;
-    rs = 0xabcd1234abcd8765;
-
-    res = 0x1234567887654321;
-    __asm
-        ("dappend %0, %1, 0x0\n\t"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("dappend error\n");
-        return -1;
-    }
-
-    rt = 0x1234567887654321;
-    rs = 0xabcd1234abcd8765;
-
-    res = 0x2345678876543215;
-    __asm
-        ("dappend %0, %1, 0x4\n\t"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("dappend error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextp.c b/tests/tcg/mips/mips64-dsp/dextp.c
deleted file mode 100644
index a469cc0..0000000
--- a/tests/tcg/mips/mips64-dsp/dextp.c
+++ /dev/null
@@ -1,54 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-    int rs;
-
-    rs = 0xabcd1234;
-
-    achi = 0x12345678;
-    acli = 0x87654321;
-    res = 0xff;
-    resdsp = 0x0;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "wrdsp %4\n\t"
-         "dextp %0, $ac1, 0x7\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    dsp = (dsp >> 14) & 0x1;
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextp error\n");
-        return -1;
-    }
-
-    rs = 0xabcd1200;
-
-    achi = 0x12345678;
-    acli = 0x87654321;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "wrdsp %4\n\t"
-         "dextp %0, $ac1, 0x7\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    dsp = (dsp >> 14) & 0x1;
-    if (dsp != resdsp) {
-        printf("dextp error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextpdp.c b/tests/tcg/mips/mips64-dsp/dextpdp.c
deleted file mode 100644
index a2361e2..0000000
--- a/tests/tcg/mips/mips64-dsp/dextpdp.c
+++ /dev/null
@@ -1,59 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, dsp;
-    long long achi, acli;
-    long long res, resdsp, resdsppos;
-    int rs;
-    int tmp1, tmp2;
-
-    rs = 0xabcd1234;
-
-    achi = 0x12345678;
-    acli = 0x87654321;
-    res = 0xff;
-    resdsp = 0x0;
-    resdsppos = 0x2c;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "wrdsp %4\n\t"
-         "dextpdp %0, $ac1, 0x7\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    tmp1 = (dsp >> 14) & 0x1;
-    tmp2 = dsp & 0x3f;
-
-    if ((tmp1 != resdsp) || (rt != res) || (tmp2 != resdsppos)) {
-        printf("dextpdp error\n");
-        return -1;
-    }
-
-    rs = 0xabcd1200;
-
-    achi = 0x12345678;
-    acli = 0x87654321;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "wrdsp %4\n\t"
-         "dextpdp %0, $ac1, 0x7\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    tmp1 = (dsp >> 14) & 0x1;
-
-    if (tmp1 != resdsp) {
-        printf("dextpdp error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextpdpv.c b/tests/tcg/mips/mips64-dsp/dextpdpv.c
deleted file mode 100644
index 09c0b5b..0000000
--- a/tests/tcg/mips/mips64-dsp/dextpdpv.c
+++ /dev/null
@@ -1,63 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long res, resdsp, resdsppos;
-    int rsdsp;
-    int tmp1, tmp2;
-
-    rsdsp = 0xabcd1234;
-    rs = 0x7;
-    achi = 0x12345678;
-    acli = 0x87654321;
-    res = 0xff;
-    resdsp = 0x0;
-    resdsppos = 0x2c;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "wrdsp %4, 0x1\n\t"
-         "wrdsp %4\n\t"
-         "dextpdpv %0, $ac1, %5\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rsdsp), "r"(rs)
-        );
-
-    tmp1 = (dsp >> 14) & 0x1;
-    tmp2 = dsp & 0x3f;
-
-    if ((tmp1 != resdsp) || (rt != res) || (tmp2 != resdsppos)) {
-        printf("dextpdpv error\n");
-        return -1;
-    }
-
-    rsdsp = 0xabcd1200;
-    rs = 0x7;
-    achi = 0x12345678;
-    acli = 0x87654321;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "wrdsp %4, 0x1\n\t"
-         "wrdsp %4\n\t"
-         "dextpdpv %0, $ac1, %5\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rsdsp), "r"(rs)
-        );
-
-    tmp1 = (dsp >> 14) & 0x1;
-
-    if (tmp1 != resdsp) {
-        printf("dextpdpv error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextpv.c b/tests/tcg/mips/mips64-dsp/dextpv.c
deleted file mode 100644
index 2626f3d..0000000
--- a/tests/tcg/mips/mips64-dsp/dextpv.c
+++ /dev/null
@@ -1,58 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-    int rsdsp;
-
-    rsdsp = 0xabcd1234;
-    rs = 0x7;
-
-    achi = 0x12345678;
-    acli = 0x87654321;
-    res = 0xff;
-    resdsp = 0x0;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "wrdsp %4, 0x1\n\t"
-         "wrdsp %4\n\t"
-         "dextpv %0, $ac1, %5\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rsdsp), "r"(rs)
-        );
-    dsp = (dsp >> 14) & 0x1;
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextpv error\n");
-        return -1;
-    }
-
-    rsdsp = 0xabcd1200;
-    rs = 0x7;
-
-    achi = 0x12345678;
-    acli = 0x87654321;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "wrdsp %4, 0x1\n\t"
-         "wrdsp %4\n\t"
-         "dextpv %0, $ac1, %5\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rsdsp), "r"(rs)
-        );
-    dsp = (dsp >> 14) & 0x1;
-    if (dsp != resdsp) {
-        printf("dextpv error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextr_l.c b/tests/tcg/mips/mips64-dsp/dextr_l.c
deleted file mode 100644
index 538846d..0000000
--- a/tests/tcg/mips/mips64-dsp/dextr_l.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt;
-    long long achi, acli;
-    long long res;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0x2100000000123456;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mtlo %2, $ac1\n\t"
-         "dextr.l %0, $ac1, 0x8\n\t"
-         : "=r"(rt)
-         : "r"(achi), "r"(acli)
-        );
-    if (rt != res) {
-        printf("dextr.l error\n");
-        return -1;
-    }
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0x12345678;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mtlo %2, $ac1\n\t"
-         "dextr.l %0, $ac1, 0x0\n\t"
-         : "=r"(rt)
-         : "r"(achi), "r"(acli)
-        );
-    if (rt != res) {
-        printf("dextr.l error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextr_r_l.c b/tests/tcg/mips/mips64-dsp/dextr_r_l.c
deleted file mode 100644
index a10a9ab..0000000
--- a/tests/tcg/mips/mips64-dsp/dextr_r_l.c
+++ /dev/null
@@ -1,54 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0x2100000000123456;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_r.l %0, $ac1, 0x8\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextr_r.l error\n");
-        return -1;
-    }
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0x12345678;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_r.l %0, $ac1, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextr_r.l error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextr_r_w.c b/tests/tcg/mips/mips64-dsp/dextr_r_w.c
deleted file mode 100644
index 2774e9b..0000000
--- a/tests/tcg/mips/mips64-dsp/dextr_r_w.c
+++ /dev/null
@@ -1,54 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0x123456;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_r.w %0, $ac1, 0x8\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextr_r.w error\n");
-        return -1;
-    }
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0x12345678;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_r.w %0, $ac1, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextr_r.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextr_rs_l.c b/tests/tcg/mips/mips64-dsp/dextr_rs_l.c
deleted file mode 100644
index 1a202fe..0000000
--- a/tests/tcg/mips/mips64-dsp/dextr_rs_l.c
+++ /dev/null
@@ -1,52 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0x8000000000000000;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_rs.l %0, $ac1, 0x8\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextr_rs.l error\n");
-        return -1;
-    }
-
-    achi = 0x00;
-    acli = 0x12345678;
-
-    res = 0x12345678;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_rs.l %0, $ac1, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextr_rs.l error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextr_rs_w.c b/tests/tcg/mips/mips64-dsp/dextr_rs_w.c
deleted file mode 100644
index ebe5f99..0000000
--- a/tests/tcg/mips/mips64-dsp/dextr_rs_w.c
+++ /dev/null
@@ -1,52 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0xffffffff80000000;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_rs.w %0, $ac1, 0x8\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextr_rs.w error\n");
-        return -1;
-    }
-
-    achi = 0x00;
-    acli = 0x12345678;
-
-    res = 0x123456;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_rs.w %0, $ac1, 0x8\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextr_rs.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextr_s_h.c b/tests/tcg/mips/mips64-dsp/dextr_s_h.c
deleted file mode 100644
index 1adb554..0000000
--- a/tests/tcg/mips/mips64-dsp/dextr_s_h.c
+++ /dev/null
@@ -1,73 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0xffffffffffff8000;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_s.h %0, $ac1, 0x8\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("1 dextr_s.h error\n");
-        return -1;
-    }
-
-    achi = 0x77654321;
-    acli = 0x12345678;
-
-    res = 0x7fff;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_s.h %0, $ac1, 0x8\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("2 dextr_s.h error\n");
-        return -1;
-    }
-
-    achi = 0x00;
-    acli = 0x78;
-
-    res = 0x7;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextr_s.h %0, $ac1, 0x4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("3 dextr_s.h error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextr_w.c b/tests/tcg/mips/mips64-dsp/dextr_w.c
deleted file mode 100644
index 79bed5d..0000000
--- a/tests/tcg/mips/mips64-dsp/dextr_w.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt;
-    long long achi, acli;
-    long long res;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0x123456;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mtlo %2, $ac1\n\t"
-         "dextr.w %0, $ac1, 0x8\n\t"
-         : "=r"(rt)
-         : "r"(achi), "r"(acli)
-        );
-    if (rt != res) {
-        printf("dextr.w error\n");
-        return -1;
-    }
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    res = 0x12345678;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mtlo %2, $ac1\n\t"
-         "dextr.w %0, $ac1, 0x0\n\t"
-         : "=r"(rt)
-         : "r"(achi), "r"(acli)
-        );
-    if (rt != res) {
-        printf("dextr.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_l.c b/tests/tcg/mips/mips64-dsp/dextrv_l.c
deleted file mode 100644
index 2e6187f..0000000
--- a/tests/tcg/mips/mips64-dsp/dextrv_l.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long res;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x8;
-
-    res = 0x2100000000123456;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mtlo %2, $ac1\n\t"
-         "dextrv.l %0, $ac1, %3\n\t"
-         : "=r"(rt)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    if (rt != res) {
-        printf("dextrv.l error\n");
-        return -1;
-    }
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x0;
-
-    res = 0x12345678;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mtlo %2, $ac1\n\t"
-         "dextrv.l %0, $ac1, %3\n\t"
-         : "=r"(rt)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    if (rt != res) {
-        printf("dextrv.l error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_r_l.c b/tests/tcg/mips/mips64-dsp/dextrv_r_l.c
deleted file mode 100644
index b47a017..0000000
--- a/tests/tcg/mips/mips64-dsp/dextrv_r_l.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, dsp, rs;
-    long long achi, acli;
-    long long res, resdsp;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x8;
-
-    res = 0x2100000000123456;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextrv_r.l %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextrv_r.l error\n");
-        return -1;
-    }
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x0;
-
-    res = 0x12345678;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextrv_r.l %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextrv_r.l error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_r_w.c b/tests/tcg/mips/mips64-dsp/dextrv_r_w.c
deleted file mode 100644
index cd201de..0000000
--- a/tests/tcg/mips/mips64-dsp/dextrv_r_w.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x8;
-
-    res = 0x123456;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextrv_r.w %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextrv_r.w error\n");
-        return -1;
-    }
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x0;
-
-    res = 0x12345678;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextrv_r.w %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextrv_r.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_rs_l.c b/tests/tcg/mips/mips64-dsp/dextrv_rs_l.c
deleted file mode 100644
index 6ce4185..0000000
--- a/tests/tcg/mips/mips64-dsp/dextrv_rs_l.c
+++ /dev/null
@@ -1,54 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x8;
-
-    res = 0x8000000000000000;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextrv_rs.l %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextrv_rs.l error\n");
-        return -1;
-    }
-
-    achi = 0x00;
-    acli = 0x12345678;
-    rs = 0x0;
-
-    res = 0x12345678;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextrv_rs.l %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextrv_rs.l error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_rs_w.c b/tests/tcg/mips/mips64-dsp/dextrv_rs_w.c
deleted file mode 100644
index a65183c..0000000
--- a/tests/tcg/mips/mips64-dsp/dextrv_rs_w.c
+++ /dev/null
@@ -1,54 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x8;
-
-    res = 0xffffffff80000000;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextrv_rs.w %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextrv_rs.w error\n");
-        return -1;
-    }
-
-    achi = 0x00;
-    acli = 0x12345678;
-    rs = 0x8;
-
-    res = 0x123456;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextrv_rs.w %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextrv_rs.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_s_h.c b/tests/tcg/mips/mips64-dsp/dextrv_s_h.c
deleted file mode 100644
index 87d3aee..0000000
--- a/tests/tcg/mips/mips64-dsp/dextrv_s_h.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long res, resdsp;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x8;
-
-    res = 0xffffffffffff8000;
-    resdsp = 0x1;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dextrv_s.h %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    dsp = (dsp >> 23) & 0x1;
-
-    if ((dsp != resdsp) || (rt != res)) {
-        printf("dextrv_s.h error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_w.c b/tests/tcg/mips/mips64-dsp/dextrv_w.c
deleted file mode 100644
index 973765c..0000000
--- a/tests/tcg/mips/mips64-dsp/dextrv_w.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long res;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x8;
-
-    res = 0x123456;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mtlo %2, $ac1\n\t"
-         "dextrv.w %0, $ac1, %3\n\t"
-         : "=r"(rt)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    if (rt != res) {
-        printf("dextrv.w error\n");
-        return -1;
-    }
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x0;
-
-    res = 0x12345678;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mtlo %2, $ac1\n\t"
-         "dextrv.w %0, $ac1, %3\n\t"
-         : "=r"(rt)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-    if (rt != res) {
-        printf("dextrv.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dinsv.c b/tests/tcg/mips/mips64-dsp/dinsv.c
deleted file mode 100644
index f619218..0000000
--- a/tests/tcg/mips/mips64-dsp/dinsv.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dsp;
-    long long res;
-
-    rs = 0x1234567887654321;
-    rt = 0x1234567812345678;
-    dsp = 0x2222;
-    res = 0x1234567812345678;
-    __asm
-        ("wrdsp  %1, 0x3\n\t"
-         "wrdsp %1\n\t"
-         "dinsv %0, %2\n\t"
-         : "+r"(rt)
-         : "r"(dsp), "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("dinsv error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dmadd.c b/tests/tcg/mips/mips64-dsp/dmadd.c
deleted file mode 100644
index fb22614..0000000
--- a/tests/tcg/mips/mips64-dsp/dmadd.c
+++ /dev/null
@@ -1,57 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resh, resl;
-
-    achi = 0x1;
-    acli = 0x1;
-
-    rs = 0x0000000100000001;
-    rt = 0x0000000200000002;
-
-    resh = 0x1;
-    resl = 0x5;
-    __asm
-       ("mthi %2, $ac1 \t\n"
-        "mtlo %3, $ac1 \t\n"
-        "dmadd $ac1, %4, %5\t\n"
-        "mfhi %0, $ac1 \t\n"
-        "mflo %1, $ac1 \t\n"
-        : "=r"(acho), "=r"(aclo)
-        : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-      );
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dmadd error\n");
-
-        return -1;
-    }
-
-    achi = 0x1;
-    acli = 0x1;
-
-    rs = 0xaaaabbbbccccdddd;
-    rt = 0xaaaabbbbccccdddd;
-
-    resh = 0x0000000000000000;
-    resl = 0xffffffffca860b63;
-
-    __asm
-       ("mthi %2, $ac1 \t\n"
-        "mtlo %3, $ac1 \t\n"
-        "dmadd $ac1, %4, %5\t\n"
-        "mfhi %0, $ac1 \t\n"
-        "mflo %1, $ac1 \t\n"
-        : "=r"(acho), "=r"(aclo)
-        : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-      );
-    if ((acho != resh) || (aclo != resl)) {
-        printf("2 dmadd error\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dmaddu.c b/tests/tcg/mips/mips64-dsp/dmaddu.c
deleted file mode 100644
index 39ab0c1..0000000
--- a/tests/tcg/mips/mips64-dsp/dmaddu.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resh, resl;
-    achi = 0x1;
-    acli = 0x2;
-
-    rs = 0x0000000200000002;
-    rt = 0x0000000200000002;
-    resh = 0x1;
-    resl = 0xa;
-    __asm
-        ("mthi %2, $ac1 \t\n"
-         "mtlo %3, $ac1 \t\n"
-         "dmaddu $ac1, %4, %5\t\n"
-         "mfhi %0, $ac1 \t\n"
-         "mflo %1, $ac1 \t\n"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dmaddu error\n");
-
-        return -1;
-    }
-
-    achi = 0x1;
-    acli = 0x1;
-
-    rs = 0xaaaabbbbccccdddd;
-    rt = 0xaaaabbbbccccdddd;
-
-    resh = 0x0000000000000002;
-    resl = 0xffffffffca860b63;
-
-    __asm
-        ("mthi %2, $ac1 \t\n"
-         "mtlo %3, $ac1 \t\n"
-         "dmaddu $ac1, %4, %5\t\n"
-         "mfhi %0, $ac1 \t\n"
-         "mflo %1, $ac1 \t\n"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((acho != resh) || (aclo != resl)) {
-        printf("2 dmaddu error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dmsub.c b/tests/tcg/mips/mips64-dsp/dmsub.c
deleted file mode 100644
index 16be617..0000000
--- a/tests/tcg/mips/mips64-dsp/dmsub.c
+++ /dev/null
@@ -1,59 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resh, resl;
-    achi = 0x1;
-    acli = 0x8;
-
-    rs = 0x0000000100000001;
-    rt = 0x0000000200000002;
-
-    resh = 0x1;
-    resl = 0x4;
-
-    __asm
-        ("mthi %2, $ac1 \t\n"
-         "mtlo %3, $ac1 \t\n"
-         "dmsub $ac1, %4, %5\t\n"
-         "mfhi %0, $ac1 \t\n"
-         "mflo %1, $ac1 \t\n"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dmsub error\n");
-
-        return -1;
-    }
-
-    achi = 0xfffffffF;
-    acli = 0xfffffffF;
-
-    rs = 0x8888999977776666;
-    rt = 0x9999888877776666;
-
-    resh = 0xffffffffffffffff;
-    resl = 0x789aae13;
-
-    __asm
-        ("mthi %2, $ac1 \t\n"
-         "mtlo %3, $ac1 \t\n"
-         "dmsub $ac1, %4, %5\t\n"
-         "mfhi %0, $ac1 \t\n"
-         "mflo %1, $ac1 \t\n"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("2 dmsub error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dmsubu.c b/tests/tcg/mips/mips64-dsp/dmsubu.c
deleted file mode 100644
index cc4838a..0000000
--- a/tests/tcg/mips/mips64-dsp/dmsubu.c
+++ /dev/null
@@ -1,59 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resh, resl;
-    achi = 0x1;
-    acli = 0x8;
-
-    rs = 0x0000000100000001;
-    rt = 0x0000000200000002;
-
-    resh = 0x1;
-    resl = 0x4;
-
-    __asm
-        ("mthi %2, $ac1 \t\n"
-         "mtlo %3, $ac1 \t\n"
-         "dmsubu $ac1, %4, %5\t\n"
-         "mfhi %0, $ac1 \t\n"
-         "mflo %1, $ac1 \t\n"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dmsubu error\n");
-
-        return -1;
-    }
-
-    achi = 0xfffffffF;
-    acli = 0xfffffffF;
-
-    rs = 0x8888999977776666;
-    rt = 0x9999888877776666;
-
-    resh = 0xffffffffffffffff;
-    resl = 0x789aae13;
-
-    __asm
-        ("mthi %2, $ac1 \t\n"
-         "mtlo %3, $ac1 \t\n"
-         "dmsubu $ac1, %4, %5\t\n"
-         "mfhi %0, $ac1 \t\n"
-         "mflo %1, $ac1 \t\n"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("2 dmsubu error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dmthlip.c b/tests/tcg/mips/mips64-dsp/dmthlip.c
deleted file mode 100644
index 027555f..0000000
--- a/tests/tcg/mips/mips64-dsp/dmthlip.c
+++ /dev/null
@@ -1,41 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, dsp;
-    long long achi, acli;
-
-    long long rsdsp;
-    long long acho, aclo;
-
-    long long res;
-    long long reshi, reslo;
-
-
-    rs = 0xaaaabbbbccccdddd;
-    achi = 0x87654321;
-    acli = 0x12345678;
-    dsp = 0x22;
-
-    res = 0x62;
-    reshi = 0x12345678;
-    reslo = 0xffffffffccccdddd;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "wrdsp %5\n\t"
-         "dmthlip %6, $ac1\n\t"
-         "rddsp %0\n\t"
-         "mfhi %1, $ac1\n\t"
-         "mflo %2, $ac1\n\t"
-         : "=r"(rsdsp), "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(dsp), "r"(rs)
-        );
-    if ((rsdsp != res) || (acho != reshi) || (aclo != reslo)) {
-        printf("dmthlip error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpaq_s_w_ph.c b/tests/tcg/mips/mips64-dsp/dpaq_s_w_ph.c
deleted file mode 100644
index 1bca935..0000000
--- a/tests/tcg/mips/mips64-dsp/dpaq_s_w_ph.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dsp;
-    long long ach = 0, acl = 0;
-    long long resulth, resultl, resultdsp;
-
-    rs        = 0x800000FF;
-    rt        = 0x80000002;
-    resulth   = 0x00;
-    resultl   = 0xFFFFFFFF800003FB;
-    resultdsp = 0x01;
-    __asm
-        ("mthi        %0, $ac1\n\t"
-         "mtlo        %1, $ac1\n\t"
-         "dpaq_s.w.ph $ac1, %3, %4\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = dsp >> 17 & 0x01;
-    if ((dsp != resultdsp) || (ach != resulth) || (acl != resultl)) {
-        printf("dpaq_w.w.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpaq_s_w_qh.c b/tests/tcg/mips/mips64-dsp/dpaq_s_w_qh.c
deleted file mode 100644
index 844a347..0000000
--- a/tests/tcg/mips/mips64-dsp/dpaq_s_w_qh.c
+++ /dev/null
@@ -1,57 +0,0 @@
-#include"io.h"
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resh, resl;
-
-    achi = 0x1;
-    acli = 0x1;
-    rs = 0x0001000100010001;
-    rt = 0x0002000200020002;
-    resh = 0x1;
-    resl = 0x11;
-
-    __asm
-        ("mthi %2, $ac1\t\n"
-         "mtlo %3, $ac1\t\n"
-         "dpaq_s.w.qh $ac1, %4, %5\t\n"
-         "mfhi %0, $ac1\t\n"
-         "mflo %1, $ac1\t\n"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dpaq_s.w.qh error\n");
-
-        return -1;
-    }
-
-    achi = 0xffffffff;
-    acli = 0xaaaaaaaa;
-
-    rs = 0x1111222233334444;
-    rt = 0xffffeeeeddddcccc;
-
-    resh = 0x00;
-    resl = 0xffffffffd27ad82e;
-
-    __asm
-        ("mthi %2, $ac1\t\n"
-         "mtlo %3, $ac1\t\n"
-         "dpaq_s.w.qh $ac1, %4, %5\t\n"
-         "mfhi %0, $ac1\t\n"
-         "mflo %1, $ac1\t\n"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("2 dpaq_s.w.qh error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpaq_sa_l_pw.c b/tests/tcg/mips/mips64-dsp/dpaq_sa_l_pw.c
deleted file mode 100644
index 1bb2ec2..0000000
--- a/tests/tcg/mips/mips64-dsp/dpaq_sa_l_pw.c
+++ /dev/null
@@ -1,88 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long achi, acli;
-    long long acho, aclo;
-    long long dsp;
-    long long resh, resl;
-    long long resdsp;
-
-    rs = 0x0000000100000001;
-    rt = 0x0000000200000002;
-    achi = 0x1;
-    acli = 0x1;
-    resh = 0xffffffffffffffff;
-    resl = 0x0;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi        %3, $ac1\n\t"
-         "mtlo        %4, $ac1\n\t"
-         "dpaq_sa.l.pw $ac1, %5, %6\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl) || ((dsp >> (16 + 1)) != resdsp)) {
-        printf("1 dpaq_sa_l_pw error\n");
-
-        return -1;
-    }
-
-    rs = 0xaaaabbbbccccdddd;
-    rt = 0x3333444455556666;
-    achi = 0x88888888;
-    acli = 0x66666666;
-
-    resh = 0xffffffff88888887;
-    resl = 0xffffffff9e2661da;
-
-    __asm
-        ("mthi        %2, $ac1\n\t"
-         "mtlo        %3, $ac1\n\t"
-         "dpaq_sa.l.pw $ac1, %4, %5\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("2 dpaq_sa_l_pw error\n");
-
-        return -1;
-    }
-
-    rs = 0x8000000080000000;
-    rt = 0x8000000080000000;
-    achi = 0x88888888;
-    acli = 0x66666666;
-
-    resh = 0xffffffffffffffff;
-    resl = 0x00;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi        %3, $ac1\n\t"
-         "mtlo        %4, $ac1\n\t"
-         "dpaq_sa.l.pw $ac1, %5, %6\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl) || ((dsp >> (16 + 1)) != resdsp)) {
-        printf("2 dpaq_sa_l_pw error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpaq_sa_l_w.c b/tests/tcg/mips/mips64-dsp/dpaq_sa_l_w.c
deleted file mode 100644
index f840cdd..0000000
--- a/tests/tcg/mips/mips64-dsp/dpaq_sa_l_w.c
+++ /dev/null
@@ -1,82 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dsp;
-    long long ach = 0, acl = 0;
-    long long resulth, resultl, resultdsp;
-
-    rs        = 0x80000000;
-    rt        = 0x80000000;
-    resulth   = 0x7FFFFFFF;
-    resultl   = 0xffffffffFFFFFFFF;
-    resultdsp = 0x01;
-    __asm
-        ("mthi        %0, $ac1\n\t"
-         "mtlo        %0, $ac1\n\t"
-         "dpaq_sa.l.w $ac1, %3, %4\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if ((dsp != resultdsp) || (ach != resulth) || (acl != resultl)) {
-        printf("dpaq_sa.l.w error\n");
-
-        return -1;
-    }
-
-    ach = 0x12;
-    acl = 0x48;
-    rs  = 0x80000000;
-    rt  = 0x80000000;
-
-    resulth   = 0x7FFFFFFF;
-    resultl   = 0xffffffffFFFFFFFF;
-    resultdsp = 0x01;
-    __asm
-        ("mthi        %0, $ac1\n\t"
-         "mtlo        %0, $ac1\n\t"
-         "dpaq_sa.l.w $ac1, %3, %4\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if ((dsp != resultdsp) || (ach != resulth) || (acl != resultl)) {
-        printf("dpaq_sa.l.w error\n");
-
-        return -1;
-    }
-
-    ach = 0x741532A0;
-    acl = 0xfceabb08;
-    rs  = 0x80000000;
-    rt  = 0x80000000;
-
-    resulth   = 0x7fffffff;
-    resultl   = 0xffffffffffffffff;
-    resultdsp = 0x01;
-    __asm
-        ("mthi        %0, $ac1\n\t"
-         "mtlo        %0, $ac1\n\t"
-         "dpaq_sa.l.w $ac1, %3, %4\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if ((dsp != resultdsp) || (ach != resulth) || (acl != resultl)) {
-        printf("dpaq_sa.l.w error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpau_h_obl.c b/tests/tcg/mips/mips64-dsp/dpau_h_obl.c
deleted file mode 100644
index 54905e8..0000000
--- a/tests/tcg/mips/mips64-dsp/dpau_h_obl.c
+++ /dev/null
@@ -1,59 +0,0 @@
-
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resh, resl;
-
-    rs = 0x0000000100000001;
-    rt = 0x0000000200000002;
-    achi = 0x1;
-    acli = 0x1;
-    resh = 0x1;
-    resl = 0x3;
-
-    __asm
-        ("mthi        %2, $ac1\n\t"
-         "mtlo        %3, $ac1\n\t"
-         "dpau.h.obl $ac1, %4, %5\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dpau.h.obl error\n");
-
-        return -1;
-    }
-
-    rs = 0xaaaabbbbccccdddd;
-    rt = 0x3333444455556666;
-    achi = 0x88888888;
-    acli = 0x66666666;
-
-    resh = 0xffffffff88888888;
-    resl = 0x66670d7a;
-
-    __asm
-        ("mthi        %2, $ac1\n\t"
-         "mtlo        %3, $ac1\n\t"
-         "dpau.h.obl $ac1, %4, %5\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dpau.h.obl error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpau_h_obr.c b/tests/tcg/mips/mips64-dsp/dpau_h_obr.c
deleted file mode 100644
index d7aa60b..0000000
--- a/tests/tcg/mips/mips64-dsp/dpau_h_obr.c
+++ /dev/null
@@ -1,59 +0,0 @@
-
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resh, resl;
-
-    rs = 0x0000000100000001;
-    rt = 0x0000000200000002;
-    achi = 0x1;
-    acli = 0x1;
-    resh = 0x1;
-    resl = 0x3;
-
-    __asm
-        ("mthi        %2, $ac1\n\t"
-         "mtlo        %3, $ac1\n\t"
-         "dpau.h.obr $ac1, %4, %5\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dpau.h.obr error\n");
-
-        return -1;
-    }
-
-    rs = 0xccccddddaaaabbbb;
-    rt = 0x5555666633334444;
-    achi = 0x88888888;
-    acli = 0x66666666;
-
-    resh = 0xffffffff88888888;
-    resl = 0x66670d7a;
-
-    __asm
-        ("mthi        %2, $ac1\n\t"
-         "mtlo        %3, $ac1\n\t"
-         "dpau.h.obr $ac1, %4, %5\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dpau.h.obr error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpau_h_qbl.c b/tests/tcg/mips/mips64-dsp/dpau_h_qbl.c
deleted file mode 100644
index fcfd764..0000000
--- a/tests/tcg/mips/mips64-dsp/dpau_h_qbl.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long ach = 5, acl = 3;
-    long long resulth, resultl;
-
-    rs        = 0x800000FF;
-    rt        = 0x80000002;
-    resulth   = 0x05;
-    resultl   = 0x4003;
-    __asm
-        ("mthi       %0, $ac1\n\t"
-         "mtlo       %1, $ac1\n\t"
-         "dpau.h.qbl $ac1, %2, %3\n\t"
-         "mfhi       %0,   $ac1\n\t"
-         "mflo       %1,   $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("dpau.h.qbl wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpau_h_qbr.c b/tests/tcg/mips/mips64-dsp/dpau_h_qbr.c
deleted file mode 100644
index 3282461..0000000
--- a/tests/tcg/mips/mips64-dsp/dpau_h_qbr.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long ach = 5, acl = 3;
-    long long resulth, resultl;
-
-    rs        = 0x800000FF;
-    rt        = 0x80000002;
-    resulth   = 0x05;
-    resultl   = 0x0201;
-    __asm
-        ("mthi       %0, $ac1\n\t"
-         "mtlo       %1, $ac1\n\t"
-         "dpau.h.qbr $ac1, %2, %3\n\t"
-         "mfhi       %0,   $ac1\n\t"
-         "mflo       %1,   $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("dpau.h.qbr wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpsq_s_w_ph.c b/tests/tcg/mips/mips64-dsp/dpsq_s_w_ph.c
deleted file mode 100644
index 7660f03..0000000
--- a/tests/tcg/mips/mips64-dsp/dpsq_s_w_ph.c
+++ /dev/null
@@ -1,51 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl;
-
-    rs      = 0xBC0123AD;
-    rt      = 0x01643721;
-    resulth = 0x04;
-    resultl = 0xFFFFFFFFEE9794A3;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsq_s.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("1 dpsq_s.w.ph wrong\n");
-
-        return -1;
-    }
-
-    ach = 0x1424Ef1f;
-    acl = 0x1035219A;
-    rs      = 0x800083AD;
-    rt      = 0x80003721;
-    resulth = 0x1424ef1e;
-    resultl = 0x577ed901;
-
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsq_s.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("2 dpsq_s.w.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpsq_s_w_qh.c b/tests/tcg/mips/mips64-dsp/dpsq_s_w_qh.c
deleted file mode 100644
index 2cc50c5..0000000
--- a/tests/tcg/mips/mips64-dsp/dpsq_s_w_qh.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resh, resl;
-
-    rs = 0xffffeeeeddddcccc;
-    rt = 0x9999888877776666;
-    achi = 0x67576;
-    acli = 0x98878;
-
-    resh = 0x67576;
-    resl = 0x5b1682c4;
-    __asm
-        ("mthi  %2, $ac1\n\t"
-         "mtlo  %3, $ac1\n\t"
-         "dpsq_s.w.qh $ac1, %4, %5\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dpsq_s.w.qh wrong\n");
-
-        return -1;
-    }
-
-    rs = 0x8000800080008000;
-    rt = 0x8000800080008000;
-    achi = 0x67576;
-    acli = 0x98878;
-
-    resh = 0x67575;
-    resl = 0x0009887c;
-
-    __asm
-        ("mthi  %2, $ac1\n\t"
-         "mtlo  %3, $ac1\n\t"
-         "dpsq_s.w.qh $ac1, %4, %5\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((acho != resh) || (aclo != resl)) {
-        printf("2 dpsq_s.w.qh wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpsq_sa_l_pw.c b/tests/tcg/mips/mips64-dsp/dpsq_sa_l_pw.c
deleted file mode 100644
index 7fc2503..0000000
--- a/tests/tcg/mips/mips64-dsp/dpsq_sa_l_pw.c
+++ /dev/null
@@ -1,76 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dsp;
-    long long achi, acli;
-    long long resh, resl, resdsp;
-
-    rs = 0x89789BC0123AD;
-    rt = 0x5467591643721;
-
-    achi = 0x98765437;
-    acli = 0x65489709;
-
-    resh = 0xffffffffffffffff;
-    resl = 0x00;
-
-    resdsp = 0x01;
-
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsq_sa.l.pw $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(achi), "+r"(acli), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x01;
-    if ((dsp != resdsp) || (achi != resh) || (acli != resl)) {
-        printf("1 dpsq_sa.l.pw wrong\n");
-
-        return -1;
-    }
-
-    /* clear dspcontrol reg for next test use. */
-    dsp = 0;
-    __asm
-        ("wrdsp %0"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 0x8B78980000000;
-    rt = 0x5867580000000;
-
-    achi = 0x98765437;
-    acli = 0x65489709;
-
-    resh = 0xffffffff98765436;
-    resl = 0x11d367d0;
-
-    resdsp = 0x01;
-
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsq_sa.l.pw $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(achi), "+r"(acli), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x01;
-    if ((dsp != resdsp) || (achi != resh) || (acli != resl)) {
-        printf("2 dpsq_sa.l.pw wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpsq_sa_l_w.c b/tests/tcg/mips/mips64-dsp/dpsq_sa_l_w.c
deleted file mode 100644
index f55afc9..0000000
--- a/tests/tcg/mips/mips64-dsp/dpsq_sa_l_w.c
+++ /dev/null
@@ -1,59 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dsp;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl, resultdsp;
-
-    rs = 0xBC0123AD;
-    rt = 0x01643721;
-
-    resulth = 0xfffffffffdf4cbe0;
-    resultl = 0xFFFFFFFFd138776b;
-    resultdsp = 0x00;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsq_sa.l.w $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if ((dsp != resultdsp) || (ach != resulth) || (acl != resultl)) {
-        printf("1 dpsq_sa.l.w wrong\n");
-
-        return -1;
-    }
-
-    ach = 0x54321123;
-    acl = 5;
-    rs = 0x80000000;
-    rt = 0x80000000;
-
-    resulth = 0xffffffffd4321123;
-    resultl = 0x06;
-    resultdsp = 0x01;
-
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsq_sa.l.w $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if ((dsp != resultdsp) || (ach != resulth) || (acl != resultl)) {
-        printf("2 dpsq_sa.l.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpsu_h_obl.c b/tests/tcg/mips/mips64-dsp/dpsu_h_obl.c
deleted file mode 100644
index c0a8f4d..0000000
--- a/tests/tcg/mips/mips64-dsp/dpsu_h_obl.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl;
-
-    rs      = 0x88886666BC0123AD;
-    rt      = 0x9999888801643721;
-
-    resulth = 0x04;
-    resultl = 0xFFFFFFFFFFFEF115;
-
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsu.h.obl $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("dpsu.h.obl wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpsu_h_obr.c b/tests/tcg/mips/mips64-dsp/dpsu_h_obr.c
deleted file mode 100644
index aa0d47a..0000000
--- a/tests/tcg/mips/mips64-dsp/dpsu_h_obr.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl;
-
-    rs      = 0x7878878888886666;
-    rt      = 0x9865454399998888;
-
-    resulth = 0x04;
-    resultl = 0xFFFFFFFFFFFeF115;
-
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsu.h.obr $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("dpsu.h.qbr wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpsu_h_qbl.c b/tests/tcg/mips/mips64-dsp/dpsu_h_qbl.c
deleted file mode 100644
index da6dbb6..0000000
--- a/tests/tcg/mips/mips64-dsp/dpsu_h_qbl.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl;
-
-    rs      = 0xBC0123AD;
-    rt      = 0x01643721;
-    resulth = 0x04;
-    resultl = 0xFFFFFFFFFFFFFEE5;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsu.h.qbl $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("dpsu.h.qbl wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dpsu_h_qbr.c b/tests/tcg/mips/mips64-dsp/dpsu_h_qbr.c
deleted file mode 100644
index bf00b70..0000000
--- a/tests/tcg/mips/mips64-dsp/dpsu_h_qbr.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl;
-
-    rs      = 0xBC0123AD;
-    rt      = 0x01643721;
-    resulth = 0x04;
-    resultl = 0xFFFFFFFFFFFFE233;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsu.h.qbr $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("dpsu.h.qbr wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dshilo.c b/tests/tcg/mips/mips64-dsp/dshilo.c
deleted file mode 100644
index f50584b..0000000
--- a/tests/tcg/mips/mips64-dsp/dshilo.c
+++ /dev/null
@@ -1,52 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long achi, acli;
-    long long acho, aclo;
-    long long reshi, reslo;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    reshi = 0xfffffffff8765432;
-    reslo = 0x1234567;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dshilo $ac1, 0x4\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli)
-        );
-
-    if ((acho != reshi) || (aclo != reslo)) {
-        printf("1 dshilo error\n");
-        return -1;
-    }
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    reshi = 0x1234567;
-    reslo = 0x00;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dshilo $ac1, -60\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli)
-        );
-
-    if ((acho != reshi) || (aclo != reslo)) {
-        printf("2 dshilo error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/dshilov.c b/tests/tcg/mips/mips64-dsp/dshilov.c
deleted file mode 100644
index 792bd23..0000000
--- a/tests/tcg/mips/mips64-dsp/dshilov.c
+++ /dev/null
@@ -1,54 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long achi, acli, rs;
-    long long acho, aclo;
-    long long reshi, reslo;
-
-    achi = 0x87654321;
-    acli = 0x12345678;
-    rs = 0x4;
-
-    reshi = 0xfffffffff8765432;
-    reslo = 0x1234567;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dshilov $ac1, %4\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-
-    if ((acho != reshi) || (aclo != reslo)) {
-        printf("dshilov error\n");
-        return -1;
-    }
-
-    rs = 0x44;
-    achi = 0x87654321;
-    acli = 0x12345678;
-
-    reshi = 0x1234567;
-    reslo = 0x00;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "dshilov $ac1, %4\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs)
-        );
-
-    if ((acho != reshi) || (aclo != reslo)) {
-        printf("dshilov error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extp.c b/tests/tcg/mips/mips64-dsp/extp.c
deleted file mode 100644
index c72f54b..0000000
--- a/tests/tcg/mips/mips64-dsp/extp.c
+++ /dev/null
@@ -1,50 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, ach, acl, dsp;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x07;
-    result = 0x000C;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extp %0, $ac1, 0x03\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 14) & 0x01;
-    if ((dsp != 0) || (result != rt)) {
-        printf("extp wrong\n");
-
-        return -1;
-    }
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x01;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extp %0, $ac1, 0x03\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 14) & 0x01;
-    if (dsp != 1) {
-        printf("extp wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extpdp.c b/tests/tcg/mips/mips64-dsp/extpdp.c
deleted file mode 100644
index f430193..0000000
--- a/tests/tcg/mips/mips64-dsp/extpdp.c
+++ /dev/null
@@ -1,51 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, ach, acl, dsp, pos, efi;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x07;
-    result = 0x000C;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extpdp %0, $ac1, 0x03\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    pos =  dsp & 0x3F;
-    efi = (dsp >> 14) & 0x01;
-    if ((pos != 3) || (efi != 0) || (result != rt)) {
-        printf("extpdp wrong\n");
-
-        return -1;
-    }
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x01;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extpdp %0, $ac1, 0x03\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    efi = (dsp >> 14) & 0x01;
-    if (efi != 1) {
-        printf("extpdp wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extpdpv.c b/tests/tcg/mips/mips64-dsp/extpdpv.c
deleted file mode 100644
index ba57426..0000000
--- a/tests/tcg/mips/mips64-dsp/extpdpv.c
+++ /dev/null
@@ -1,52 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, ach, acl, dsp, pos, efi;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x07;
-    rs  = 0x03;
-    result = 0x000C;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extpdpv %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(ach), "r"(acl), "r"(rs)
-        );
-    pos =  dsp & 0x3F;
-    efi = (dsp >> 14) & 0x01;
-    if ((pos != 3) || (efi != 0) || (result != rt)) {
-        printf("extpdpv wrong\n");
-
-        return -1;
-    }
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x01;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extpdpv %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(ach), "r"(acl), "r"(rs)
-        );
-    efi = (dsp >> 14) & 0x01;
-    if (efi != 1) {
-        printf("extpdpv wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extpv.c b/tests/tcg/mips/mips64-dsp/extpv.c
deleted file mode 100644
index 158472b..0000000
--- a/tests/tcg/mips/mips64-dsp/extpv.c
+++ /dev/null
@@ -1,51 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, ac, ach, acl, dsp;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x07;
-    ac  = 0x03;
-    result = 0x000C;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extpv %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(ach), "r"(acl), "r"(ac)
-        );
-    dsp = (dsp >> 14) & 0x01;
-    if ((dsp != 0) || (result != rt)) {
-        printf("extpv wrong\n");
-
-        return -1;
-    }
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x01;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extpv %0, $ac1, %4\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(ach), "r"(acl), "r"(ac)
-        );
-    dsp = (dsp >> 14) & 0x01;
-    if (dsp != 1) {
-        printf("extpv wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extr_r_w.c b/tests/tcg/mips/mips64-dsp/extr_r_w.c
deleted file mode 100644
index 94572ad..0000000
--- a/tests/tcg/mips/mips64-dsp/extr_r_w.c
+++ /dev/null
@@ -1,53 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, ach, acl, dsp;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    result = 0xFFFFFFFFA0001699;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_r.w %0, $ac1, 0x03\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 1) || (result != rt)) {
-        printf("1 extr_r.w wrong\n");
-
-        return -1;
-    }
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0x01;
-    acl = 0xB4CB;
-    result = 0x10000B4D;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_r.w %0, $ac1, 0x04\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 0) || (result != rt)) {
-        printf("2 extr_r.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extr_rs_w.c b/tests/tcg/mips/mips64-dsp/extr_rs_w.c
deleted file mode 100644
index 73551f9..0000000
--- a/tests/tcg/mips/mips64-dsp/extr_rs_w.c
+++ /dev/null
@@ -1,53 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, ach, acl, dsp;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    result = 0x7FFFFFFF;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_rs.w %0, $ac1, 0x03\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 1) || (result != rt)) {
-        printf("1 extr_rs.w wrong\n");
-
-        return -1;
-    }
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0x01;
-    acl = 0xB4CB;
-    result = 0x10000B4D;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_rs.w %0, $ac1, 0x04\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 0) || (result != rt)) {
-        printf("2 extr_rs.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extr_s_h.c b/tests/tcg/mips/mips64-dsp/extr_s_h.c
deleted file mode 100644
index de10cb5..0000000
--- a/tests/tcg/mips/mips64-dsp/extr_s_h.c
+++ /dev/null
@@ -1,71 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, ach, acl, dsp;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    result = 0x00007FFF;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_s.h %0, $ac1, 0x03\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 1) || (result != rt)) {
-        printf("extr_s.h wrong\n");
-
-        return -1;
-    }
-
-    ach = 0xffffffff;
-    acl = 0x12344321;
-    result = 0xffffffffFFFF8000;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_s.h %0, $ac1, 0x08\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 1) || (result != rt)) {
-        printf("extr_s.h wrong\n");
-
-        return -1;
-    }
-
-    /* Clear dsp */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0x00;
-    acl = 0x4321;
-    result = 0x432;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_s.h %0, $ac1, 0x04\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 0) || (result != rt)) {
-        printf("extr_s.h wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extr_w.c b/tests/tcg/mips/mips64-dsp/extr_w.c
deleted file mode 100644
index bd69576..0000000
--- a/tests/tcg/mips/mips64-dsp/extr_w.c
+++ /dev/null
@@ -1,53 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, ach, acl, dsp;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    result = 0xFFFFFFFFA0001699;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr.w %0, $ac1, 0x03\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 1) || (result != rt)) {
-        printf("extr.w wrong\n");
-
-        return -1;
-    }
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0x01;
-    acl = 0xB4CB;
-    result = 0x10000B4C;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr.w %0, $ac1, 0x04\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 0) || (result != rt)) {
-        printf("extr.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extrv_r_w.c b/tests/tcg/mips/mips64-dsp/extrv_r_w.c
deleted file mode 100644
index 8379729..0000000
--- a/tests/tcg/mips/mips64-dsp/extrv_r_w.c
+++ /dev/null
@@ -1,59 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, ach, acl, dsp;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x07;
-    rs  = 0x03;
-    result = 0xFFFFFFFFA0001699;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "extrv_r.w %0, $ac1, %2\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(rs), "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 1) || (result != rt)) {
-        printf("extrv_r.w wrong\n");
-
-        return -1;
-    }
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 4;
-    ach = 0x01;
-    acl = 0xB4CB;
-    result = 0x10000B4D;
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "extrv_r.w %0, $ac1, %2\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(rs), "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 0) || (result != rt)) {
-        printf("extrv_r.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extrv_rs_w.c b/tests/tcg/mips/mips64-dsp/extrv_rs_w.c
deleted file mode 100644
index 8707cd11..0000000
--- a/tests/tcg/mips/mips64-dsp/extrv_rs_w.c
+++ /dev/null
@@ -1,59 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, ach, acl, dsp;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x07;
-    rs  = 0x03;
-    result = 0x7FFFFFFF;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "extrv_rs.w %0, $ac1, %2\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(rs), "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 1) || (result != rt)) {
-        printf("1 extrv_rs.w wrong\n");
-
-        return -1;
-    }
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 4;
-    ach = 0x01;
-    acl = 0xB4CB;
-    result = 0x10000B4D;
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "extrv_rs.w %0, $ac1, %2\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(rs), "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 0) || (result != rt)) {
-        printf("2 extrv_rs.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extrv_s_h.c b/tests/tcg/mips/mips64-dsp/extrv_s_h.c
deleted file mode 100644
index b6dcaeb..0000000
--- a/tests/tcg/mips/mips64-dsp/extrv_s_h.c
+++ /dev/null
@@ -1,79 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, ach, acl, dsp;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x07;
-    rs  = 0x03;
-    result = 0x00007FFF;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "extrv_s.h %0, $ac1, %2\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(rs), "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 1) || (result != rt)) {
-        printf("extrv_s.h wrong\n");
-
-        return -1;
-    }
-
-    rs = 0x08;
-    ach = 0xffffffff;
-    acl = 0x12344321;
-    result = 0xffffffffFFFF8000;
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "extrv_s.h %0, $ac1, %2\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(rs), "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 1) || (result != rt)) {
-        printf("extrv_s.h wrong\n");
-
-        return -1;
-    }
-
-    /* Clear dsp */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 0x04;
-    ach = 0x00;
-    acl = 0x4321;
-    result = 0x432;
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "extrv_s.h %0, $ac1, %2\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(rs), "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 0) || (result != rt)) {
-        printf("extrv_s.h wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/extrv_w.c b/tests/tcg/mips/mips64-dsp/extrv_w.c
deleted file mode 100644
index 8adffb3..0000000
--- a/tests/tcg/mips/mips64-dsp/extrv_w.c
+++ /dev/null
@@ -1,59 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, ach, acl, dsp;
-    long long result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x07;
-    rs  = 0x03;
-    result = 0xFFFFFFFFA0001699;
-
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "extrv.w %0, $ac1, %2\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(rs), "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 1) || (result != rt)) {
-        printf("extrv.w wrong\n");
-
-        return -1;
-    }
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 4;
-    ach = 0x01;
-    acl = 0xB4CB;
-    result = 0x10000B4C;
-    __asm
-        ("wrdsp %1, 0x01\n\t"
-         "mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "extrv.w %0, $ac1, %2\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(rs), "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    if ((dsp != 0) || (result != rt)) {
-        printf("extrv.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
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
diff --git a/tests/tcg/mips/mips64-dsp/insv.c b/tests/tcg/mips/mips64-dsp/insv.c
deleted file mode 100644
index fc5696f..0000000
--- a/tests/tcg/mips/mips64-dsp/insv.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long result;
-
-    /* msb = 10, lsb = 5 */
-    dsp    = 0x305;
-    rt     = 0x12345678;
-    rs     = 0xffffffff87654321;
-    result = 0x12345338;
-    __asm
-        ("wrdsp %2, 0x03\n\t"
-         "insv  %0, %1\n\t"
-         : "+r"(rt)
-         : "r"(rs), "r"(dsp)
-        );
-    if (rt != result) {
-        printf("insv wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
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
diff --git a/tests/tcg/mips/mips64-dsp/lbux.c b/tests/tcg/mips/mips64-dsp/lbux.c
deleted file mode 100644
index dbdc87b..0000000
--- a/tests/tcg/mips/mips64-dsp/lbux.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long value, rd;
-    long long *p;
-    unsigned long long addr, index;
-    long long result;
-
-    value  = 0xBCDEF389;
-    p = &value;
-    addr = (unsigned long long)p;
-    index  = 0;
-    result = value & 0xFF;
-    __asm
-        ("lbux %0, %1(%2)\n\t"
-         : "=r"(rd)
-         : "r"(index), "r"(addr)
-        );
-    if (rd != result) {
-        printf("lbux wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/ldx.c b/tests/tcg/mips/mips64-dsp/ldx.c
deleted file mode 100644
index 787d9f0..0000000
--- a/tests/tcg/mips/mips64-dsp/ldx.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long value, rd;
-    long long *p;
-    unsigned long long addr, index;
-    long long result;
-
-    value  = 0xBCDEF389;
-    p = &value;
-    addr = (unsigned long long)p;
-    index  = 0;
-    result = 0xBCDEF389;
-    __asm
-        ("ldx %0, %1(%2)\n\t"
-         : "=r"(rd)
-         : "r"(index), "r"(addr)
-        );
-    if (rd != result) {
-        printf("lwx wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/lhx.c b/tests/tcg/mips/mips64-dsp/lhx.c
deleted file mode 100644
index 2020e56..0000000
--- a/tests/tcg/mips/mips64-dsp/lhx.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long value, rd;
-    long long *p;
-    unsigned long long addr, index;
-    long long result;
-
-    value  = 0xBCDEF389;
-    p = &value;
-    addr = (unsigned long long)p;
-    index  = 0;
-    result = 0xFFFFFFFFFFFFF389;
-    __asm
-        ("lhx %0, %1(%2)\n\t"
-         : "=r"(rd)
-         : "r"(index), "r"(addr)
-        );
-    if (rd != result) {
-        printf("lhx wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/lwx.c b/tests/tcg/mips/mips64-dsp/lwx.c
deleted file mode 100644
index 6a81414..0000000
--- a/tests/tcg/mips/mips64-dsp/lwx.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long value, rd;
-    long long *p;
-    unsigned long long addr, index;
-    long long result;
-
-    value  = 0xBCDEF389;
-    p = &value;
-    addr = (unsigned long long)p;
-    index  = 0;
-    result = 0xFFFFFFFFBCDEF389;
-    __asm
-        ("lwx %0, %1(%2)\n\t"
-         : "=r"(rd)
-         : "r"(index), "r"(addr)
-        );
-    if (rd != result) {
-        printf("lwx wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/madd.c b/tests/tcg/mips/mips64-dsp/madd.c
deleted file mode 100644
index de6e44f..0000000
--- a/tests/tcg/mips/mips64-dsp/madd.c
+++ /dev/null
@@ -1,33 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0xB4CB;
-    rs  = 0x01;
-    rt  = 0x01;
-    resulth = 0x05;
-    resultl = 0xB4CC;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "madd $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("madd wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maddu.c b/tests/tcg/mips/mips64-dsp/maddu.c
deleted file mode 100644
index e9f426a..0000000
--- a/tests/tcg/mips/mips64-dsp/maddu.c
+++ /dev/null
@@ -1,33 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0xB4CB;
-    rs  = 0x01;
-    rt  = 0x01;
-    resulth = 0x05;
-    resultl = 0xB4CC;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "madd $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("maddu wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_l_pwl.c b/tests/tcg/mips/mips64-dsp/maq_s_l_pwl.c
deleted file mode 100644
index c196b43..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_s_l_pwl.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0xB4CB;
-    rs  = 0x98765432FF060000;
-    rt  = 0xfdeca987CB000000;
-    resulth = 0x05;
-    resultl = 0x18278587;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_s.l.pwl $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("maq_s_l.w.pwl wrong 1\n");
-
-        return -1;
-    }
-
-    achi = 0x05;
-    acli = 0xB4CB;
-    rs  = 0x80000000FF060000;
-    rt  = 0x80000000CB000000;
-    resulth = 0x05;
-    resultl = 0xb4ca;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_s.l.pwl $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (resulth != acho) || (resultl != aclo)) {
-        printf("maq_s_l.w.pwl wrong 2\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_l_pwr.c b/tests/tcg/mips/mips64-dsp/maq_s_l_pwr.c
deleted file mode 100644
index e2af69f..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_s_l_pwr.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0xB4CB;
-    rs  = 0x87898765432;
-    rt  = 0x7878fdeca987;
-    resulth = 0x05;
-    resultl = 0x18278587;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_s.l.pwr $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("maq_s.w.pwr wrong\n");
-
-        return -1;
-    }
-
-    achi = 0x05;
-    acli = 0xB4CB;
-    rs  = 0x89899980000000;
-    rt  = 0x88780000000;
-    resulth = 0x05;
-    resultl = 0xb4ca;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_s.l.pwr $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (resulth != acho) || (resultl != aclo)) {
-        printf("maq_s.w.pwr wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_phl.c b/tests/tcg/mips/mips64-dsp/maq_s_w_phl.c
deleted file mode 100644
index 7dba874..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_s_w_phl.c
+++ /dev/null
@@ -1,60 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long dsp;
-    long long acho, aclo;
-    long long resulth, resultl;
-    long long resdsp;
-
-    achi = 0x05;
-    acli = 0xB4CB;
-    rs  = 0xFF060000;
-    rt  = 0xCB000000;
-    resulth = 0x04;
-    resultl = 0xffffffff947438CB;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_s.w.phl $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("1 maq_s.w.phl error\n");
-
-        return -1;
-    }
-
-    achi = 0x06;
-    acli = 0xB4CB;
-    rs  = 0x80000000;
-    rt  = 0x80000000;
-    resulth = 0x6;
-    resultl = 0xffffffff8000b4ca;
-    resdsp = 1;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_s.w.phl $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo) ||
-        (((dsp >> 17) & 0x01) != resdsp)) {
-        printf("2 maq_s.w.phl error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_phr.c b/tests/tcg/mips/mips64-dsp/maq_s_w_phr.c
deleted file mode 100644
index 138ee2a..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_s_w_phr.c
+++ /dev/null
@@ -1,60 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long dsp;
-    long long acho, aclo;
-    long long resulth, resultl;
-    long long resdsp;
-
-    achi = 0x05;
-    acli = 0xB4CB;
-    rs  = 0xFF06;
-    rt  = 0xCB00;
-    resulth = 0x04;
-    resultl = 0xffffffff947438CB;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_s.w.phr $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("1 maq_s.w.phr error\n");
-
-        return -1;
-    }
-
-    achi = 0x06;
-    acli = 0xB4CB;
-    rs  = 0x8000;
-    rt  = 0x8000;
-    resulth = 0x6;
-    resultl = 0xffffffff8000b4ca;
-    resdsp = 1;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_s.w.phr $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo) ||
-        (((dsp >> 17) & 0x01) != resdsp)) {
-        printf("2 maq_s.w.phr error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_qhll.c b/tests/tcg/mips/mips64-dsp/maq_s_w_qhll.c
deleted file mode 100644
index 234a0af..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_s_w_qhll.c
+++ /dev/null
@@ -1,62 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0x05;
-
-    rs  = 0x1234888899990000;
-    rt  = 0x9876888899990000;
-
-    resulth = 0x05;
-    resultl = 0x15ae87f5;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_s.w.qhll $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("maq_s.w.qhll wrong\n");
-
-        return -1;
-    }
-
-
-    achi = 0x04;
-    acli = 0x06;
-    rs  = 0x8000888899990000;
-    rt  = 0x8000888899990000;
-
-    resulth = 0x04;
-    resultl = 0xffffffff80000005;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_s.w.qhll $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (resulth != acho) || (resultl != aclo)) {
-        printf("maq_s.w.qhll wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_qhlr.c b/tests/tcg/mips/mips64-dsp/maq_s_w_qhlr.c
deleted file mode 100644
index 8768cba..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_s_w_qhlr.c
+++ /dev/null
@@ -1,62 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0x05;
-
-    rs  = 0x1234123412340000;
-    rt  = 0x9876987698760000;
-
-    resulth = 0x05;
-    resultl = 0x15ae87f5;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_s.w.qhlr $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("1 maq_s.w.qhlr wrong\n");
-
-        return -1;
-    }
-
-
-    achi = 0x04;
-    acli = 0x06;
-    rs  = 0x8000800080000000;
-    rt  = 0x8000800080000000;
-
-    resulth = 0x04;
-    resultl = 0xffffffff80000005;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_s.w.qhlr $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (resulth != acho) || (resultl != aclo)) {
-        printf("2 maq_s.w.qhlr wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_qhrl.c b/tests/tcg/mips/mips64-dsp/maq_s_w_qhrl.c
deleted file mode 100644
index 5006e2b..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_s_w_qhrl.c
+++ /dev/null
@@ -1,63 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0x05;
-
-    rs  = 0x1234888812340000;
-    rt  = 0x9876888898760000;
-
-    resulth = 0x05;
-    resultl = 0x15ae87f5;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_s.w.qhrl $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("1 maq_s.w.qhrl wrong\n");
-
-        return -1;
-    }
-
-
-    achi = 0x04;
-    acli = 0x06;
-    rs  = 0x8888999980000000;
-    rt  = 0x8888999980000000;
-
-    resulth = 0x04;
-    resultl = 0xffffffff80000005;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_s.w.qhrl $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (resulth != acho) || (resultl != aclo)) {
-        printf("2 maq_s.w.qhrl wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_qhrr.c b/tests/tcg/mips/mips64-dsp/maq_s_w_qhrr.c
deleted file mode 100644
index 1d213a5..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_s_w_qhrr.c
+++ /dev/null
@@ -1,63 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0x05;
-
-    rs  = 0x1234888812341234;
-    rt  = 0x9876888898769876;
-
-    resulth = 0x05;
-    resultl = 0x15ae87f5;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_s.w.qhrr $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("1 maq_s.w.qhrr wrong\n");
-
-        return -1;
-    }
-
-
-    achi = 0x04;
-    acli = 0x06;
-    rs  = 0x8000888899998000;
-    rt  = 0x8000888899998000;
-
-    resulth = 0x04;
-    resultl = 0xffffffff80000005;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_s.w.qhrr $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (resulth != acho) || (resultl != aclo)) {
-        printf("2 maq_s.w.qhrr wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_phl.c b/tests/tcg/mips/mips64-dsp/maq_sa_w_phl.c
deleted file mode 100644
index 5530ffb..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_sa_w_phl.c
+++ /dev/null
@@ -1,60 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long dsp;
-    long long acho, aclo;
-    long long resulth, resultl;
-    long long resdsp;
-
-    achi = 0x05;
-    acli = 0xB4CB;
-    rs = 0xFF060000;
-    rt = 0xCB000000;
-    resulth = 0xffffffffffffffff;
-    resultl = 0xffffffff947438cb;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_sa.w.phl $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("1 maq_sa.w.phl error\n");
-
-        return -1;
-    }
-
-    achi = 0x06;
-    acli = 0xB4CB;
-    rs  = 0x80000000;
-    rt  = 0x80000000;
-    resulth = 0x00;
-    resultl = 0x7fffffff;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_sa.w.phl $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo) ||
-        (((dsp >> 17) & 0x01) != 0x01)) {
-        printf("2 maq_sa.w.phl error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_phr.c b/tests/tcg/mips/mips64-dsp/maq_sa_w_phr.c
deleted file mode 100644
index b611cfa..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_sa_w_phr.c
+++ /dev/null
@@ -1,60 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long dsp;
-    long long acho, aclo;
-    long long resulth, resultl;
-    long long resdsp;
-
-    achi = 0x05;
-    acli = 0xB4CB;
-    rs = 0xFF06;
-    rt = 0xCB00;
-    resulth = 0xffffffffffffffff;
-    resultl = 0xffffffff947438cb;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_sa.w.phr $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("1 maq_sa.w.phr error\n");
-
-        return -1;
-    }
-
-    achi = 0x06;
-    acli = 0xB4CB;
-    rs  = 0x8000;
-    rt  = 0x8000;
-    resulth = 0x00;
-    resultl = 0x7fffffff;
-    resdsp = 0x01;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_sa.w.phr $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((resulth != acho) || (resultl != aclo) ||
-        (((dsp >> 17) & 0x01) != 0x01)) {
-        printf("2 maq_sa.w.phr error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhll.c b/tests/tcg/mips/mips64-dsp/maq_sa_w_qhll.c
deleted file mode 100644
index 136ff2d..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhll.c
+++ /dev/null
@@ -1,62 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0x05;
-
-    rs  = 0x1234888899990000;
-    rt  = 0x9876888899990000;
-
-    resulth = 0x00;
-    resultl = 0x15ae87f5;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "maq_sa.w.qhll $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((resulth != acho) || (resultl != aclo)) {
-        printf("1 maq_sa.w.qhll wrong\n");
-
-        return -1;
-    }
-
-
-    achi = 0x04;
-    acli = 0x06;
-    rs  = 0x8000888899990000;
-    rt  = 0x8000888899990000;
-
-    resulth = 0x00;
-    resultl = 0x7fffffff;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_sa.w.qhll $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (resulth != acho) || (resultl != aclo)) {
-        printf("2 maq_sa.w.qhll wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhlr.c b/tests/tcg/mips/mips64-dsp/maq_sa_w_qhlr.c
deleted file mode 100644
index dd0ae1c..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhlr.c
+++ /dev/null
@@ -1,64 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0x05;
-
-    rs  = 0x1234123412340000;
-    rt  = 0x9876987699990000;
-
-    resulth = 0x0;
-    resultl = 0x15ae87f5;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_sa.w.qhlr $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x0) || (resulth != acho) || (resultl != aclo)) {
-        printf("maq_sa.w.qhlr wrong\n");
-
-        return -1;
-    }
-
-
-    achi = 0x04;
-    acli = 0x06;
-    rs  = 0x8000800099990000;
-    rt  = 0x8000800099990000;
-
-    resulth = 0x00;
-    resultl = 0x7fffffff;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_sa.w.qhlr $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (resulth != acho) || (resultl != aclo)) {
-        printf("maq_sa.w.qhlr wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhrl.c b/tests/tcg/mips/mips64-dsp/maq_sa_w_qhrl.c
deleted file mode 100644
index a3de6f8..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhrl.c
+++ /dev/null
@@ -1,64 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0x05;
-
-    rs  = 0x1234123412340000;
-    rt  = 0x9876987698760000;
-
-    resulth = 0x0;
-    resultl = 0x15ae87f5;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_sa.w.qhrl $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x0) || (resulth != acho) || (resultl != aclo)) {
-        printf("1 maq_sa.w.qhrl wrong\n");
-
-        return -1;
-    }
-
-
-    achi = 0x04;
-    acli = 0x06;
-    rs  = 0x8000800080000000;
-    rt  = 0x8000800080000000;
-
-    resulth = 0x00;
-    resultl = 0x7fffffff;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_sa.w.qhrl $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (resulth != acho) || (resultl != aclo)) {
-        printf("2 maq_sa.w.qhrl wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhrr.c b/tests/tcg/mips/mips64-dsp/maq_sa_w_qhrr.c
deleted file mode 100644
index f021737..0000000
--- a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhrr.c
+++ /dev/null
@@ -1,64 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    achi = 0x05;
-    acli = 0x05;
-
-    rs  = 0x1234123412341234;
-    rt  = 0x9876987698769876;
-
-    resulth = 0x0;
-    resultl = 0x15ae87f5;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_sa.w.qhrr $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x0) || (resulth != acho) || (resultl != aclo)) {
-        printf("1 maq_sa.w.qhrr wrong\n");
-
-        return -1;
-    }
-
-
-    achi = 0x04;
-    acli = 0x06;
-    rs  = 0x8000800080008000;
-    rt  = 0x8000800080008000;
-
-    resulth = 0x00;
-    resultl = 0x7fffffff;
-
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "maq_sa.w.qhrr $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (resulth != acho) || (resultl != aclo)) {
-        printf("2 maq_sa.w.qhrr wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/mfhi.c b/tests/tcg/mips/mips64-dsp/mfhi.c
deleted file mode 100644
index ee915f7..0000000
--- a/tests/tcg/mips/mips64-dsp/mfhi.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long achi, acho;
-    long long result;
-
-    achi   = 0x004433;
-    result = 0x004433;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mfhi %0, $ac1\n\t"
-         : "=r"(acho)
-         : "r"(achi)
-        );
-    if (result != acho) {
-        printf("mfhi wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/mflo.c b/tests/tcg/mips/mips64-dsp/mflo.c
deleted file mode 100644
index cdc646b..0000000
--- a/tests/tcg/mips/mips64-dsp/mflo.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long acli, aclo;
-    long long result;
-
-    acli   = 0x004433;
-    result = 0x004433;
-
-    __asm
-        ("mtlo %1, $ac1\n\t"
-         "mflo %0, $ac1\n\t"
-         : "=r"(aclo)
-         : "r"(acli)
-        );
-    if (result != aclo) {
-        printf("mflo wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
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
diff --git a/tests/tcg/mips/mips64-dsp/modsub.c b/tests/tcg/mips/mips64-dsp/modsub.c
deleted file mode 100644
index 2c91cb4..0000000
--- a/tests/tcg/mips/mips64-dsp/modsub.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0xFFFFFFFF;
-    rt     = 0x000000FF;
-    result = 0xFFFFFF00;
-    __asm
-        ("modsub %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (result != rd) {
-        printf("modsub wrong\n");
-
-        return -1;
-    }
-
-    rs     = 0x00000000;
-    rt     = 0x00CD1FFF;
-    result = 0x0000CD1F;
-    __asm
-        ("modsub %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (result != rd) {
-        printf("modsub wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/msub.c b/tests/tcg/mips/mips64-dsp/msub.c
deleted file mode 100644
index 75066b5..0000000
--- a/tests/tcg/mips/mips64-dsp/msub.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long achi, acli, rs, rt;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    rs      = 0x00BBAACC;
-    rt      = 0x0B1C3D2F;
-    achi    = 0x00004433;
-    acli    = 0xFFCC0011;
-    resulth = 0xFFFFFFFFFFF81F29;
-    resultl = 0xFFFFFFFFB355089D;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "msub $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((acho != resulth) || (aclo != resultl)) {
-        printf("msub wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/msubu.c b/tests/tcg/mips/mips64-dsp/msubu.c
deleted file mode 100644
index 55f8ae0..0000000
--- a/tests/tcg/mips/mips64-dsp/msubu.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long achi, acli, rs, rt;
-    long long acho, aclo;
-    long long resulth, resultl;
-
-    rs      = 0x00BBAACC;
-    rt      = 0x0B1C3D2F;
-    achi    = 0x00004433;
-    acli    = 0xFFCC0011;
-    resulth = 0xFFFFFFFFFFF81F29;
-    resultl = 0xFFFFFFFFB355089D;
-
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "msubu $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    if ((acho != resulth) || (aclo != resultl)) {
-        printf("msubu wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/mthi.c b/tests/tcg/mips/mips64-dsp/mthi.c
deleted file mode 100644
index 8570051..0000000
--- a/tests/tcg/mips/mips64-dsp/mthi.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long achi, acho;
-    long long result;
-
-    achi   = 0x004433;
-    result = 0x004433;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mfhi %0, $ac1\n\t"
-         : "=r"(acho)
-         : "r"(achi)
-        );
-    if (result != acho) {
-        printf("mthi wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/mthlip.c b/tests/tcg/mips/mips64-dsp/mthlip.c
deleted file mode 100644
index 957cd42..0000000
--- a/tests/tcg/mips/mips64-dsp/mthlip.c
+++ /dev/null
@@ -1,61 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, ach, acl, dsp;
-    long long result, resulth, resultl;
-
-    dsp = 0x07;
-    ach = 0x05;
-    acl = 0xB4CB;
-    rs  = 0x00FFBBAA;
-    resulth = 0xB4CB;
-    resultl = 0x00FFBBAA;
-    result  = 0x27;
-
-    __asm
-        ("wrdsp %0, 0x01\n\t"
-         "mthi %1, $ac1\n\t"
-         "mtlo %2, $ac1\n\t"
-         "mthlip %3, $ac1\n\t"
-         "mfhi %1, $ac1\n\t"
-         "mflo %2, $ac1\n\t"
-         "rddsp %0\n\t"
-         : "+r"(dsp), "+r"(ach), "+r"(acl)
-         : "r"(rs)
-        );
-    dsp = dsp & 0x3F;
-    if ((dsp != result) || (ach != resulth) || (acl != resultl)) {
-        printf("mthlip wrong\n");
-
-        return -1;
-    }
-
-    dsp = 0x3f;
-    ach = 0x05;
-    acl = 0xB4CB;
-    rs  = 0x00FFBBAA;
-    resulth = 0xB4CB;
-    resultl = 0x00FFBBAA;
-    result  = 0x3f;
-
-    __asm
-        ("wrdsp %0, 0x01\n\t"
-         "mthi %1, $ac1\n\t"
-         "mtlo %2, $ac1\n\t"
-         "mthlip %3, $ac1\n\t"
-         "mfhi %1, $ac1\n\t"
-         "mflo %2, $ac1\n\t"
-         "rddsp %0\n\t"
-         : "+r"(dsp), "+r"(ach), "+r"(acl)
-         : "r"(rs)
-        );
-    dsp = dsp & 0x3F;
-    if ((dsp != result) || (ach != resulth) || (acl != resultl)) {
-        printf("mthlip wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/mtlo.c b/tests/tcg/mips/mips64-dsp/mtlo.c
deleted file mode 100644
index 304fffb..0000000
--- a/tests/tcg/mips/mips64-dsp/mtlo.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long acli, aclo;
-    long long result;
-
-    acli   = 0x004433;
-    result = 0x004433;
-
-    __asm
-        ("mthi %1, $ac1\n\t"
-         "mfhi %0, $ac1\n\t"
-         : "=r"(aclo)
-         : "r"(acli)
-        );
-    if (result != aclo) {
-        printf("mtlo wrong\n");
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/muleq_s_pw_qhl.c b/tests/tcg/mips/mips64-dsp/muleq_s_pw_qhl.c
deleted file mode 100644
index 6c68d45..0000000
--- a/tests/tcg/mips/mips64-dsp/muleq_s_pw_qhl.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result;
-
-    rd = 0;
-    rs = 0x45BCFFFF12345678;
-    rt = 0x98529AD287654321;
-    result = 0x52fbec7035a2ca5c;
-
-    __asm
-        ("muleq_s.pw.qhl %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("1 muleq_s.pw.qhl error\n");
-
-        return -1;
-    }
-
-    rd = 0;
-    rs = 0x45BC800012345678;
-    rt = 0x9852800087654321;
-    result = 0x52fbec707FFFFFFF;
-
-    __asm
-        ("muleq_s.pw.qhl %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("2 muleq_s.pw.qhl error\n");
-
-        return -1;
-    }
-
-    rd = 0;
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(rd)
-        );
-    rd = rd >> 21;
-    rd = rd & 0x1;
-
-    if (rd != 1) {
-        printf("3 muleq_s.pw.qhl error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/muleq_s_pw_qhr.c b/tests/tcg/mips/mips64-dsp/muleq_s_pw_qhr.c
deleted file mode 100644
index fa8b41f..0000000
--- a/tests/tcg/mips/mips64-dsp/muleq_s_pw_qhr.c
+++ /dev/null
@@ -1,57 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rd = 0;
-    rs = 0x1234567845BCFFFF;
-    rt = 0x8765432198529AD2;
-    result = 0x52fbec7035a2ca5c;
-
-    __asm
-        ("muleq_s.pw.qhr %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("1 muleq_s.pw.qhr error\n");
-
-        return -1;
-    }
-
-    rd = 0;
-    rs = 0x1234567845BC8000;
-    rt = 0x8765432198528000;
-    result = 0x52fbec707FFFFFFF;
-
-    __asm
-        ("muleq_s.pw.qhr %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("2 muleq_s.pw.qhr error\n");
-
-        return -1;
-    }
-
-    rd = 0;
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(rd)
-        );
-    rd = rd >> 21;
-    rd = rd & 0x1;
-
-    if (rd != 1) {
-        printf("3 muleq_s.pw.qhr error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/muleq_s_w_phl.c b/tests/tcg/mips/mips64-dsp/muleq_s_w_phl.c
deleted file mode 100644
index 997a9f6..0000000
--- a/tests/tcg/mips/mips64-dsp/muleq_s_w_phl.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x80009988;
-    rt = 0x80009988;
-    result = 0x7FFFFFFF;
-    resultdsp = 1;
-
-    __asm
-        ("muleq_s.w.phl %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if ((rd  != result) || (dsp != resultdsp)) {
-        printf("muleq_s.w.phl wrong\n");
-
-        return -1;
-    }
-
-    rs = 0x12343322;
-    rt = 0x43213322;
-    result = 0x98be968;
-    resultdsp = 1;
-
-    __asm
-        ("muleq_s.w.phl %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if ((rd  != result) || (dsp != resultdsp)) {
-        printf("muleq_s.w.phl wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/muleq_s_w_phr.c b/tests/tcg/mips/mips64-dsp/muleq_s_w_phr.c
deleted file mode 100644
index 0e59479..0000000
--- a/tests/tcg/mips/mips64-dsp/muleq_s_w_phr.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x8000;
-    rt = 0x8000;
-    result = 0x7FFFFFFF;
-    resultdsp = 1;
-
-    __asm
-        ("muleq_s.w.phr %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if ((rd  != result) || (dsp != resultdsp)) {
-        printf("muleq_s.w.phr wrong\n");
-
-        return -1;
-    }
-
-    rs = 0x1234;
-    rt = 0x4321;
-    result = 0x98be968;
-    resultdsp = 1;
-
-    __asm
-        ("muleq_s.w.phr %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if ((rd  != result) || (dsp != resultdsp)) {
-        printf("muleq_s.w.phr wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/muleu_s_ph_qbl.c b/tests/tcg/mips/mips64-dsp/muleu_s_ph_qbl.c
deleted file mode 100644
index 2f444c9..0000000
--- a/tests/tcg/mips/mips64-dsp/muleu_s_ph_qbl.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x80001234;
-    rt = 0x80004321;
-    result = 0xFFFFFFFFFFFF0000;
-    resultdsp = 1;
-
-    __asm
-        ("muleu_s.ph.qbl %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if ((rd  != result) || (dsp != resultdsp)) {
-        printf("muleu_s.ph.qbl wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/muleu_s_ph_qbr.c b/tests/tcg/mips/mips64-dsp/muleu_s_ph_qbr.c
deleted file mode 100644
index 8bd0e99..0000000
--- a/tests/tcg/mips/mips64-dsp/muleu_s_ph_qbr.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x8000;
-    rt = 0x80004321;
-    result = 0xFFFFFFFFFFFF0000;
-    resultdsp = 1;
-
-    __asm
-        ("muleu_s.ph.qbr %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if ((rd  != result) || (dsp != resultdsp)) {
-        printf("muleu_s.ph.qbr wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/muleu_s_qh_obl.c b/tests/tcg/mips/mips64-dsp/muleu_s_qh_obl.c
deleted file mode 100644
index db0d386..0000000
--- a/tests/tcg/mips/mips64-dsp/muleu_s_qh_obl.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long resdsp, result;
-
-    rd = 0;
-    rs = 0x1234567802020202;
-    rt = 0x0034432112344321;
-    result = 0x03A8FFFFFFFFFFFF;
-    resdsp = 0x01;
-
-    __asm
-        ("muleu_s.qh.obl %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 21) & 0x01;
-    if ((rd != result) || (resdsp != dsp)) {
-        printf("muleu_s.qh.obl error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/muleu_s_qh_obr.c b/tests/tcg/mips/mips64-dsp/muleu_s_qh_obr.c
deleted file mode 100644
index 52ed9c0..0000000
--- a/tests/tcg/mips/mips64-dsp/muleu_s_qh_obr.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long resdsp, result;
-
-    rd = 0;
-    rs = 0x0202020212345678;
-
-    rt = 0x0034432112344321;
-    result = 0x03A8FFFFFFFFFFFF;
-    resdsp = 0x01;
-
-    __asm
-        ("muleu_s.qh.obr %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-
-    dsp = (dsp >> 21) & 0x01;
-    if ((rd != result) || (resdsp != dsp)) {
-        printf("muleu_s.qh.obr error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/mulq_rs_ph.c b/tests/tcg/mips/mips64-dsp/mulq_rs_ph.c
deleted file mode 100644
index fd6233d..0000000
--- a/tests/tcg/mips/mips64-dsp/mulq_rs_ph.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x80001234;
-    rt = 0x80004321;
-    result = 0x7FFF098C;
-    resultdsp = 1;
-
-    __asm
-        ("mulq_rs.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if ((rd  != result) || (dsp != resultdsp)) {
-        printf("mulq_rs.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/mulq_rs_qh.c b/tests/tcg/mips/mips64-dsp/mulq_rs_qh.c
deleted file mode 100644
index 7863c05..0000000
--- a/tests/tcg/mips/mips64-dsp/mulq_rs_qh.c
+++ /dev/null
@@ -1,33 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dsp, dspresult;
-    rt = 0x80003698CE8F9201;
-    rs = 0x800034634BCDE321;
-    result = 0x7fff16587a530313;
-
-    dspresult = 0x01;
-
-    __asm
-        ("mulq_rs.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != result) {
-        printf("mulq_rs.qh error\n");
-
-        return -1;
-    }
-
-    dsp = (dsp >> 21) & 0x01;
-    if (dsp != dspresult) {
-        printf("mulq_rs.qh DSPControl Reg ouflag error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/mulsaq_s_l_pw.c b/tests/tcg/mips/mips64-dsp/mulsaq_s_l_pw.c
deleted file mode 100644
index 02548f8..0000000
--- a/tests/tcg/mips/mips64-dsp/mulsaq_s_l_pw.c
+++ /dev/null
@@ -1,59 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resl, resh;
-
-    achi = 0x4;
-    acli = 0x4;
-
-    rs = 0x1234567887654321;
-    rt = 0x8765432112345678;
-
-    resh = 0x4;
-    resl = 0x4;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "mulsaq_s.l.pw $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 mulsaq_s.l.pw wrong\n");
-
-        return -1;
-    }
-
-    achi = 0x4;
-    acli = 0x4;
-
-    rs = 0x8000000087654321;
-    rt = 0x8000000012345678;
-
-    resh = 0x4;
-    resl = 0x1e8ee513;
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "mulsaq_s.l.pw $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (acho != resh) || (aclo != resl)) {
-        printf("2 mulsaq_s.l.pw wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/mulsaq_s_w_qh.c b/tests/tcg/mips/mips64-dsp/mulsaq_s_w_qh.c
deleted file mode 100644
index 92d7a0b..0000000
--- a/tests/tcg/mips/mips64-dsp/mulsaq_s_w_qh.c
+++ /dev/null
@@ -1,57 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, dsp;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resl, resh;
-
-    achi = 0x4;
-    acli = 0x4;
-
-    rs = 0x5678123443218765;
-    rt = 0x4321876556781234;
-
-    resh = 0x4;
-    resl = 0x342fcbd4;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "mulsaq_s.w.qh $ac1, %4, %5\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 mulsaq_s.w.qh wrong\n");
-        return -1;
-    }
-
-    achi = 0x4;
-    acli = 0x4;
-
-    rs = 0x8000800087654321;
-    rt = 0x8000800012345678;
-
-    resh = 0x3;
-    resl = 0xffffffffe5e81a1c;
-    __asm
-        ("mthi %3, $ac1\n\t"
-         "mtlo %4, $ac1\n\t"
-         "mulsaq_s.w.qh $ac1, %5, %6\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "=r"(acho), "=r"(aclo), "=r"(dsp)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x1;
-    if ((dsp != 0x1) || (acho != resh) || (aclo != resl)) {
-        printf("2 mulsaq_s.w.qh wrong\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/mult.c b/tests/tcg/mips/mips64-dsp/mult.c
deleted file mode 100644
index 4a294d1..0000000
--- a/tests/tcg/mips/mips64-dsp/mult.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, ach, acl;
-    long long result, resulth, resultl;
-
-    rs  = 0x00FFBBAA;
-    rt  = 0x4B231000;
-    resulth = 0x4b0f01;
-    resultl = 0x71f8a000;
-    __asm
-        ("mult $ac1, %2, %3\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(ach), "=r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("mult wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/multu.c b/tests/tcg/mips/mips64-dsp/multu.c
deleted file mode 100644
index 21a8a7c..0000000
--- a/tests/tcg/mips/mips64-dsp/multu.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt, ach, acl;
-    long long result, resulth, resultl;
-
-    rs  = 0x00FFBBAA;
-    rt  = 0x4B231000;
-    resulth = 0x4b0f01;
-    resultl = 0x71f8a000;
-    __asm
-        ("multu $ac1, %2, %3\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "=r"(ach), "=r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("multu wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/packrl_ph.c b/tests/tcg/mips/mips64-dsp/packrl_ph.c
deleted file mode 100644
index 3722b0a..0000000
--- a/tests/tcg/mips/mips64-dsp/packrl_ph.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x56788765;
-
-    __asm
-        ("packrl.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (result != rd) {
-        printf("packrl.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/packrl_pw.c b/tests/tcg/mips/mips64-dsp/packrl_pw.c
deleted file mode 100644
index 7807418..0000000
--- a/tests/tcg/mips/mips64-dsp/packrl_pw.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long res;
-
-    rs = 0x1234567887654321;
-    rt = 0xabcdef9812345678;
-
-    res = 0x87654321abcdef98;
-
-    __asm
-        ("packrl.pw %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != res) {
-        printf("packrl.pw error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/pick_ob.c b/tests/tcg/mips/mips64-dsp/pick_ob.c
deleted file mode 100644
index 160049f..0000000
--- a/tests/tcg/mips/mips64-dsp/pick_ob.c
+++ /dev/null
@@ -1,66 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long res;
-
-    dsp = 0xff000000;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x1234567812345678;
-
-    __asm
-        ("wrdsp %1, 0x10\n\t"
-         "pick.ob %0, %2, %3\n\t"
-         : "=r"(rd)
-         : "r"(dsp), "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("1 pick.ob error\n");
-        return -1;
-    }
-
-    dsp = 0x00000000;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x8765432187654321;
-
-    __asm
-        ("wrdsp %1, 0x10\n\t"
-         "pick.ob %0, %2, %3\n\t"
-         : "=r"(rd)
-         : "r"(dsp), "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("2 pick.ob error\n");
-        return -1;
-    }
-
-    dsp = 0x34000000;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x8765567887344321;
-
-    __asm
-        ("wrdsp %1, 0x10\n\t"
-         "pick.ob %0, %2, %3\n\t"
-         : "=r"(rd)
-         : "r"(dsp), "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("3 pick.ob error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/pick_ph.c b/tests/tcg/mips/mips64-dsp/pick_ph.c
deleted file mode 100644
index 8800c14..0000000
--- a/tests/tcg/mips/mips64-dsp/pick_ph.c
+++ /dev/null
@@ -1,60 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    dsp = 0x0A000000;
-    result = 0x12344321;
-
-    __asm
-        ("wrdsp %3, 0x10\n\t"
-         "pick.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt), "r"(dsp)
-        );
-    if (rd != result) {
-        printf("1 pick.ph wrong\n");
-
-        return -1;
-    }
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    dsp = 0x03000000;
-    result = 0x12345678;
-
-    __asm
-        ("wrdsp %3, 0x10\n\t"
-         "pick.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt), "r"(dsp)
-        );
-    if (rd != result) {
-        printf("2 pick.ph wrong\n");
-
-        return -1;
-    }
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    dsp = 0x00000000;
-    result = 0xffffffff87654321;
-
-    __asm
-        ("wrdsp %3, 0x10\n\t"
-         "pick.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt), "r"(dsp)
-        );
-    if (rd != result) {
-        printf("3 pick.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/pick_pw.c b/tests/tcg/mips/mips64-dsp/pick_pw.c
deleted file mode 100644
index 24d80f5..0000000
--- a/tests/tcg/mips/mips64-dsp/pick_pw.c
+++ /dev/null
@@ -1,48 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long res;
-    dsp = 0xff000000;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x1234567812345678;
-
-    __asm
-        ("wrdsp %1, 0x10\n\t"
-         "wrdsp %1\n\t"
-         "pick.pw %0, %2, %3\n\t"
-         : "=r"(rd), "+r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("pick.pw error\n");
-        return -1;
-    }
-
-    dsp = 0x00000000;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x8765432187654321;
-
-    __asm
-        ("wrdsp %1, 0x10\n\t"
-         "wrdsp %1\n\t"
-         "pick.pw %0, %2, %3\n\t"
-         : "=r"(rd), "+r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("pick.pw error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/pick_qb.c b/tests/tcg/mips/mips64-dsp/pick_qb.c
deleted file mode 100644
index 0d5de9d..0000000
--- a/tests/tcg/mips/mips64-dsp/pick_qb.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    dsp = 0x0f000000;
-    result = 0x12345678;
-
-    __asm
-        ("wrdsp %3, 0x10\n\t"
-         "pick.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt), "r"(dsp)
-        );
-    if (rd != result) {
-        printf("pick.qb wrong\n");
-
-        return -1;
-    }
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    dsp = 0x00000000;
-    result = 0xffffffff87654321;
-
-    __asm
-        ("wrdsp %3, 0x10\n\t"
-         "pick.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt), "r"(dsp)
-        );
-    if (rd != result) {
-        printf("pick.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/pick_qh.c b/tests/tcg/mips/mips64-dsp/pick_qh.c
deleted file mode 100644
index aa2e293..0000000
--- a/tests/tcg/mips/mips64-dsp/pick_qh.c
+++ /dev/null
@@ -1,48 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long res;
-    dsp = 0xff000000;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x1234567812345678;
-
-    __asm
-        ("wrdsp %1, 0x10\n\t"
-         "wrdsp %1\n\t"
-         "pick.qh %0, %2, %3\n\t"
-         : "=r"(rd), "+r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("pick.qh error\n");
-        return -1;
-    }
-
-    dsp = 0x00000000;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x8765432187654321;
-
-    __asm
-        ("wrdsp %1, 0x10\n\t"
-         "wrdsp %1\n\t"
-         "pick.qh %0, %2, %3\n\t"
-         : "=r"(rd), "+r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("pick.qh error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceq_l_pwl.c b/tests/tcg/mips/mips64-dsp/preceq_l_pwl.c
deleted file mode 100644
index 6455100..0000000
--- a/tests/tcg/mips/mips64-dsp/preceq_l_pwl.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-    rt = 0xFFFFFFFF11111111;
-    result = 0xFFFFFFFF00000000;
-
-    __asm
-        ("preceq.l.pwl %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("preceq.l.pwl wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/preceq_l_pwr.c b/tests/tcg/mips/mips64-dsp/preceq_l_pwr.c
deleted file mode 100644
index 1e05339..0000000
--- a/tests/tcg/mips/mips64-dsp/preceq_l_pwr.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-    rt = 0xFFFFFFFF11111111;
-    result = 0x1111111100000000;
-
-    __asm
-        ("preceq.l.pwl %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("preceq.l.pwr wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/preceq_pw_qhl.c b/tests/tcg/mips/mips64-dsp/preceq_pw_qhl.c
deleted file mode 100644
index f44b940..0000000
--- a/tests/tcg/mips/mips64-dsp/preceq_pw_qhl.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-    rt = 0x0123456789ABCDEF;
-    result = 0x0123000045670000;
-
-    __asm
-        ("preceq.pw.qhl %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("preceq.pw.qhl error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceq_pw_qhla.c b/tests/tcg/mips/mips64-dsp/preceq_pw_qhla.c
deleted file mode 100644
index f0f78f4..0000000
--- a/tests/tcg/mips/mips64-dsp/preceq_pw_qhla.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-
-    rt = 0x123456789ABCDEF0;
-    result = 0x123400009ABC0000;
-
-    __asm
-        ("preceq.pw.qhla %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("preceq.pw.qhla error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceq_pw_qhr.c b/tests/tcg/mips/mips64-dsp/preceq_pw_qhr.c
deleted file mode 100644
index 709d4f9..0000000
--- a/tests/tcg/mips/mips64-dsp/preceq_pw_qhr.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-    rt = 0x0123456789ABCDEF;
-    result = 0x89AB0000CDEF0000;
-
-    __asm
-        ("preceq.pw.qhr %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("preceq.pw.qhr error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceq_pw_qhra.c b/tests/tcg/mips/mips64-dsp/preceq_pw_qhra.c
deleted file mode 100644
index 4d071ec..0000000
--- a/tests/tcg/mips/mips64-dsp/preceq_pw_qhra.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-
-    rt = 0x123456789ABCDEF0;
-    result = 0x56780000DEF00000;
-
-    __asm
-        ("preceq.pw.qhra %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("preceq.pw.qhra error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceq_w_phl.c b/tests/tcg/mips/mips64-dsp/preceq_w_phl.c
deleted file mode 100644
index 4ed3fc0..0000000
--- a/tests/tcg/mips/mips64-dsp/preceq_w_phl.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x87654321;
-    result = 0xFFFFFFFF87650000;
-
-    __asm
-        ("preceq.w.phl %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("preceq.w.phl wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceq_w_phr.c b/tests/tcg/mips/mips64-dsp/preceq_w_phr.c
deleted file mode 100644
index e2ea093..0000000
--- a/tests/tcg/mips/mips64-dsp/preceq_w_phr.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x87654321;
-    result = 0x43210000;
-
-    __asm
-        ("preceq.w.phr %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("preceq.w.phr wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precequ_ph_qbl.c b/tests/tcg/mips/mips64-dsp/precequ_ph_qbl.c
deleted file mode 100644
index 17b7331..0000000
--- a/tests/tcg/mips/mips64-dsp/precequ_ph_qbl.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x87654321;
-    result = 0x43803280;
-
-    __asm
-        ("precequ.ph.qbl %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("precequ.ph.qbl wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precequ_ph_qbla.c b/tests/tcg/mips/mips64-dsp/precequ_ph_qbla.c
deleted file mode 100644
index 15e9494..0000000
--- a/tests/tcg/mips/mips64-dsp/precequ_ph_qbla.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x87654321;
-    result = 0x43802180;
-
-    __asm
-        ("precequ.ph.qbla %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("precequ.ph.qbla wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precequ_ph_qbr.c b/tests/tcg/mips/mips64-dsp/precequ_ph_qbr.c
deleted file mode 100644
index 495368c..0000000
--- a/tests/tcg/mips/mips64-dsp/precequ_ph_qbr.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x87654321;
-    result = 0x21801080;
-
-    __asm
-        ("precequ.ph.qbr %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("precequ.ph.qbr wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precequ_ph_qbra.c b/tests/tcg/mips/mips64-dsp/precequ_ph_qbra.c
deleted file mode 100644
index 7c66369..0000000
--- a/tests/tcg/mips/mips64-dsp/precequ_ph_qbra.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x87654321;
-    result = 0x32801080;
-
-    __asm
-        ("precequ.ph.qbra %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("precequ.ph.qbra wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precequ_qh_obl.c b/tests/tcg/mips/mips64-dsp/precequ_qh_obl.c
deleted file mode 100644
index 176d236..0000000
--- a/tests/tcg/mips/mips64-dsp/precequ_qh_obl.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-    rt = 0x123456789ABCDEF0;
-    result = 0x09001A002B003C00;
-
-    __asm
-        ("precequ.qh.obla %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("precequ.qh.obla error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precequ_qh_obla.c b/tests/tcg/mips/mips64-dsp/precequ_qh_obla.c
deleted file mode 100644
index 93a36a4..0000000
--- a/tests/tcg/mips/mips64-dsp/precequ_qh_obla.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-    rt = 0x123456789ABCDEF0;
-    result = 0x09002B004D006F00;
-
-    __asm
-        ("precequ.qh.obla %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("precequ.qh.obla error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precequ_qh_obr.c b/tests/tcg/mips/mips64-dsp/precequ_qh_obr.c
deleted file mode 100644
index 1214730..0000000
--- a/tests/tcg/mips/mips64-dsp/precequ_qh_obr.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-
-    rt = 0x123456789ABCDEF0;
-    result = 0x4D005E006F007000;
-
-    __asm
-        ("precequ.qh.obr %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("precequ.qh.obr error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/precequ_qh_obra.c b/tests/tcg/mips/mips64-dsp/precequ_qh_obra.c
deleted file mode 100644
index 3aa0e09..0000000
--- a/tests/tcg/mips/mips64-dsp/precequ_qh_obra.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-
-    rt = 0x123456789ABCDEF0;
-    result = 0x1A003C005D007000;
-
-    __asm
-        ("precequ.qh.obra %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("precequ.qh.obra error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/preceu_ph_qbl.c b/tests/tcg/mips/mips64-dsp/preceu_ph_qbl.c
deleted file mode 100644
index 81f7917..0000000
--- a/tests/tcg/mips/mips64-dsp/preceu_ph_qbl.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x87654321;
-    result = 0x00870065;
-
-    __asm
-        ("preceu.ph.qbl %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("preceu.ph.qbl wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceu_ph_qbla.c b/tests/tcg/mips/mips64-dsp/preceu_ph_qbla.c
deleted file mode 100644
index 38cf6a6..0000000
--- a/tests/tcg/mips/mips64-dsp/preceu_ph_qbla.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x87654321;
-    result = 0x00870043;
-
-    __asm
-        ("preceu.ph.qbla %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("preceu.ph.qbla wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceu_ph_qbr.c b/tests/tcg/mips/mips64-dsp/preceu_ph_qbr.c
deleted file mode 100644
index 70c32b6..0000000
--- a/tests/tcg/mips/mips64-dsp/preceu_ph_qbr.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x87654321;
-    result = 0x00430021;
-
-    __asm
-        ("preceu.ph.qbr %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("preceu.ph.qbr wrong");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceu_ph_qbra.c b/tests/tcg/mips/mips64-dsp/preceu_ph_qbra.c
deleted file mode 100644
index c6638aa..0000000
--- a/tests/tcg/mips/mips64-dsp/preceu_ph_qbra.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x87654321;
-    result = 0x00650021;
-
-    __asm
-        ("preceu.ph.qbra %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (result != rd) {
-        printf("preceu.ph.qbra wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceu_qh_obl.c b/tests/tcg/mips/mips64-dsp/preceu_qh_obl.c
deleted file mode 100644
index 63f9373..0000000
--- a/tests/tcg/mips/mips64-dsp/preceu_qh_obl.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-    rt = 0x123456789ABCDEF0;
-    result = 0x0012003400560078;
-
-    __asm
-        ("preceu.qh.obl %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("preceu.qh.obl error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceu_qh_obla.c b/tests/tcg/mips/mips64-dsp/preceu_qh_obla.c
deleted file mode 100644
index 5fb65e4..0000000
--- a/tests/tcg/mips/mips64-dsp/preceu_qh_obla.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-    rt = 0x123456789ABCDEF0;
-    result = 0x00120056009A00DE;
-
-    __asm
-        ("preceu.qh.obla %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("preceu.qh.obla error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceu_qh_obr.c b/tests/tcg/mips/mips64-dsp/preceu_qh_obr.c
deleted file mode 100644
index 9af3b63..0000000
--- a/tests/tcg/mips/mips64-dsp/preceu_qh_obr.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-
-    rt = 0x123456789ABCDEF0;
-    result = 0x009A00BC00DE00F0;
-
-    __asm
-        ("preceu.qh.obr %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("preceu.qh.obr error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/preceu_qh_obra.c b/tests/tcg/mips/mips64-dsp/preceu_qh_obra.c
deleted file mode 100644
index fd04083..0000000
--- a/tests/tcg/mips/mips64-dsp/preceu_qh_obra.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-
-    rt = 0x123456789ABCDEF0;
-    result = 0x0034007800BC00F0;
-
-    __asm
-        ("preceu.qh.obra %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("preceu.qh.obra error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precr_ob_qh.c b/tests/tcg/mips/mips64-dsp/precr_ob_qh.c
deleted file mode 100644
index ce2da79..0000000
--- a/tests/tcg/mips/mips64-dsp/precr_ob_qh.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long res;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x3478347865216521;
-
-    __asm
-        ("precr.ob.qh %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("precr.ob.qh error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precr_sra_qh_pw.c b/tests/tcg/mips/mips64-dsp/precr_sra_qh_pw.c
deleted file mode 100644
index 8bb16de..0000000
--- a/tests/tcg/mips/mips64-dsp/precr_sra_qh_pw.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long res;
-
-    rt = 0x8765432187654321;
-    rs = 0x1234567812345678;
-
-    res = 0x4321432156785678;
-
-    __asm
-        ("precr_sra.qh.pw %0, %1, 0x0\n\t"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("precr_sra.qh.pw error\n");
-        return -1;
-    }
-
-    rt = 0x8765432187654321;
-    rs = 0x1234567812345678;
-
-    res = 0x5432543245674567;
-
-    __asm
-        ("precr_sra.qh.pw %0, %1, 0x4\n\t"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("precr_sra.qh.pw error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precr_sra_r_qh_pw.c b/tests/tcg/mips/mips64-dsp/precr_sra_r_qh_pw.c
deleted file mode 100644
index 734ac32..0000000
--- a/tests/tcg/mips/mips64-dsp/precr_sra_r_qh_pw.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long res;
-
-    rt = 0x8765432187654321;
-    rs = 0x1234567812345678;
-
-    res = 0x4321432156785678;
-
-    __asm
-        ("precr_sra_r.qh.pw %0, %1, 0x0\n\t"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("precr_sra_r.qh.pw error\n");
-        return -1;
-    }
-
-    rt = 0x8765432187654321;
-    rs = 0x1234567812345678;
-
-    res = 0x5432543245684568;
-
-    __asm
-        ("precr_sra_r.qh.pw %0, %1, 0x4\n\t"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("precr_sra_r.qh.pw error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precrq_ob_qh.c b/tests/tcg/mips/mips64-dsp/precrq_ob_qh.c
deleted file mode 100644
index 4f61b17..0000000
--- a/tests/tcg/mips/mips64-dsp/precrq_ob_qh.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long res;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x1256125687438743;
-
-    __asm
-        ("precrq.ob.qh %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("precrq.ob.qh error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precrq_ph_w.c b/tests/tcg/mips/mips64-dsp/precrq_ph_w.c
deleted file mode 100644
index f0946ab..0000000
--- a/tests/tcg/mips/mips64-dsp/precrq_ph_w.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x12348765;
-
-    __asm
-        ("precrq.ph.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (result != rd) {
-        printf("precrq.ph.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precrq_pw_l.c b/tests/tcg/mips/mips64-dsp/precrq_pw_l.c
deleted file mode 100644
index da957c0..0000000
--- a/tests/tcg/mips/mips64-dsp/precrq_pw_l.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long res;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x1234567887654321;
-
-    __asm
-        ("precrq.pw.l %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("precrq.pw.l error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precrq_qb_ph.c b/tests/tcg/mips/mips64-dsp/precrq_qb_ph.c
deleted file mode 100644
index f417c9f..0000000
--- a/tests/tcg/mips/mips64-dsp/precrq_qb_ph.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x12568743;
-
-    __asm
-        ("precrq.qb.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (result != rd) {
-        printf("precrq.qb.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precrq_qh_pw.c b/tests/tcg/mips/mips64-dsp/precrq_qh_pw.c
deleted file mode 100644
index 4a4ffef..0000000
--- a/tests/tcg/mips/mips64-dsp/precrq_qh_pw.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long res;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x1234123487658765;
-
-    __asm
-        ("precrq.qh.pw %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("precrq.qh.pw error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precrq_rs_ph_w.c b/tests/tcg/mips/mips64-dsp/precrq_rs_ph_w.c
deleted file mode 100644
index 61da333..0000000
--- a/tests/tcg/mips/mips64-dsp/precrq_rs_ph_w.c
+++ /dev/null
@@ -1,41 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x12348765;
-
-    __asm
-        ("precrq_rs.ph.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (result != rd) {
-        printf("1 precrq_rs.ph.w wrong\n");
-
-        return -1;
-    }
-
-    rs = 0x7fffC678;
-    rt = 0x865432A0;
-    result = 0x7fff8654;
-
-    __asm
-        ("precrq_rs.ph.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((result != rd) || (((dsp >> 22) & 0x01) != 1)) {
-        printf("2 precrq_rs.ph.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precrq_rs_qh_pw.c b/tests/tcg/mips/mips64-dsp/precrq_rs_qh_pw.c
deleted file mode 100644
index ac78728..0000000
--- a/tests/tcg/mips/mips64-dsp/precrq_rs_qh_pw.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long res;
-
-    rs = 0x1234567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x1234123487658765;
-
-    __asm
-        ("precrq_rs.qh.pw %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("precrq_rs.qh.pw error\n");
-        return -1;
-    }
-
-    rs = 0x7fffC67812345678;
-    rt = 0x8765432187654321;
-
-    res = 0x7fff123487658765;
-
-    __asm
-        ("precrq_rs.qh.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("precrq_rs.qh.pw error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precrqu_s_ob_qh.c b/tests/tcg/mips/mips64-dsp/precrqu_s_ob_qh.c
deleted file mode 100644
index e27c36b..0000000
--- a/tests/tcg/mips/mips64-dsp/precrqu_s_ob_qh.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long res, resdsp;
-
-    rs = 0x7fff567812345678;
-    rt = 0x8765432187654321;
-
-    res = 0xffac24ac00860086;
-    resdsp = 0x1;
-
-    __asm
-        ("precrqu_s.ob.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x1;
-    if ((rd != res) || (dsp != resdsp)) {
-        printf("precrq_s.ob.qh error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/precrqu_s_qb_ph.c b/tests/tcg/mips/mips64-dsp/precrqu_s_qb_ph.c
deleted file mode 100644
index cb1fee4..0000000
--- a/tests/tcg/mips/mips64-dsp/precrqu_s_qb_ph.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87657fff;
-    result = 0x24AC00FF;
-
-    __asm
-        ("precrqu_s.qb.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((result != rd) || (((dsp >> 22) & 0x01) != 0x01)) {
-        printf("precrqu_s.qb.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/prependd.c b/tests/tcg/mips/mips64-dsp/prependd.c
deleted file mode 100644
index b4208c2..0000000
--- a/tests/tcg/mips/mips64-dsp/prependd.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long res;
-    rt = 0x1234567887654321;
-    rs = 0xabcd1234abcd8765;
-
-    res = 0x1234567887654321;
-    __asm
-        ("prependd %0, %1, 0x0\n\t"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("prependd error\n");
-        return -1;
-    }
-
-    rt = 0x1234567887654321;
-    rs = 0xabcd1234abcd8765;
-
-    res = 0xd876512345678876;
-    __asm
-        ("prependd %0, %1, 0x4\n\t"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("prependd error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/prependw.c b/tests/tcg/mips/mips64-dsp/prependw.c
deleted file mode 100644
index d91bd20..0000000
--- a/tests/tcg/mips/mips64-dsp/prependw.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long res;
-    rt = 0x1234567887654321;
-    rs = 0xabcd1234abcd8765;
-
-    res = 0x1234567887654321;
-    __asm
-        ("prependw %0, %1, 0x0\n\t"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("prependw error\n");
-        return -1;
-    }
-
-    rt = 0x1234567887654321;
-    rs = 0xabcd1234abcd8765;
-
-    res = 0x5123456788765432;
-    __asm
-        ("prependw %0, %1, 0x4\n\t"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("prependw error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/printf.c b/tests/tcg/mips/mips64-dsp/printf.c
deleted file mode 100644
index cf8676d..0000000
--- a/tests/tcg/mips/mips64-dsp/printf.c
+++ /dev/null
@@ -1,266 +0,0 @@
-
-typedef unsigned long va_list;
-
-#define ACC    4
-#define __read(source)                    \
-({ va_list __res;                    \
-    __asm__ __volatile__(                \
-        "move\t%0, " #source "\n\t"        \
-        : "=r" (__res));            \
-    __res;                        \
-})
-
-enum format_type {
-    FORMAT_TYPE_NONE,
-    FORMAT_TYPE_HEX,
-    FORMAT_TYPE_ULONG,
-    FORMAT_TYPE_FLOAT
-};
-
-struct printf_spec {
-    char    type;
-};
-
-static int format_decode(char *fmt, struct printf_spec *spec)
-{
-    char *start = fmt;
-
-    for (; *fmt ; ++fmt) {
-        if (*fmt == '%') {
-            break;
-        }
-    }
-
-    switch (*++fmt) {
-    case 'x':
-        spec->type = FORMAT_TYPE_HEX;
-        break;
-
-    case 'd':
-        spec->type = FORMAT_TYPE_ULONG;
-        break;
-
-    case 'f':
-        spec->type = FORMAT_TYPE_FLOAT;
-        break;
-
-    default:
-        spec->type = FORMAT_TYPE_NONE;
-    }
-
-    return ++fmt - start;
-}
-
-void *memcpy(void *dest, void *src, int n)
-{
-    int i;
-    char *s = src;
-    char *d = dest;
-
-    for (i = 0; i < n; i++) {
-        d[i] = s[i];
-    }
-    return dest;
-}
-
-char *number(char *buf, va_list num)
-{
-    int i;
-    char *str = buf;
-    static char digits[16] = "0123456789abcdef";
-    str = str + sizeof(num) * 2;
-
-    for (i = 0; i < sizeof(num) * 2; i++) {
-        *--str = digits[num & 15];
-        num >>= 4;
-    }
-
-    return buf + sizeof(num) * 2;
-}
-
-char *__number(char *buf, va_list num)
-{
-    int i;
-    va_list mm = num;
-    char *str = buf;
-
-    if (!num) {
-        *str++ = '0';
-        return str;
-    }
-
-    for (i = 0; mm; mm = mm/10, i++) {
-        /* Do nothing. */
-    }
-
-    str = str + i;
-
-    while (num) {
-        *--str = num % 10 + 48;
-        num = num / 10;
-    }
-
-    return str + i;
-}
-
-va_list modf(va_list args, va_list *integer, va_list *num)
-{
-    int i;
-    double dot_v = 0;
-    va_list E, DOT, DOT_V;
-
-    if (!args) {
-        return 0;
-    }
-
-    for (i = 0, args = args << 1 >> 1; i < 52; i++) {
-        if ((args >> i) & 0x1) {
-            break;
-        }
-    }
-
-    *integer = 0;
-
-    if ((args >> 56 != 0x3f) || (args >> 52 == 0x3ff)) {
-        E = (args >> 52) - 1023;
-        DOT = 52 - E - i;
-        DOT_V = args << (12 + E) >> (12 + E) >> i;
-        *integer = ((args << 12 >> 12) >> (i + DOT)) | (1 << E);
-    } else {
-        E = ~((args >> 52) - 1023) + 1;
-        DOT_V = args << 12 >> 12;
-
-        dot_v += 1.0 / (1 << E);
-
-        for (i = 1; i <= 16; i++) {
-            if ((DOT_V >> (52 - i)) & 0x1) {
-                dot_v += 1.0 / (1 << E + i);
-            }
-        }
-
-        for (i = 1, E = 0; i <= ACC; i++) {
-            dot_v *= 10;
-            if (!(va_list)dot_v) {
-                E++;
-            }
-    }
-
-    *num = E;
-
-    return dot_v;
-    }
-
-    if (args & 0xf) {
-        for (i = 1; i <= 16; i++) {
-            if ((DOT_V >> (DOT - i)) & 0x1) {
-                dot_v += 1.0 / (1 << i);
-            }
-        }
-
-        for (i = 1, E = 0; i <= ACC; i++) {
-            dot_v *= 10;
-            if (!(va_list)dot_v) {
-                E++;
-            }
-        }
-
-        *num = E;
-
-        return dot_v;
-    } else if (DOT) {
-        for (i = 1; i <= DOT; i++) {
-            if ((DOT_V >> (DOT - i)) & 0x1) {
-                dot_v += 1.0 / (1 << i);
-            }
-        }
-
-        for (i = 1; i <= ACC; i++) {
-            dot_v = dot_v * 10;
-        }
-
-    return dot_v;
-    }
-
-    return 0;
-}
-
-int vsnprintf(char *buf, int size, char *fmt, va_list args)
-{
-    char *str, *mm;
-    struct printf_spec spec = {0};
-
-    str = mm = buf;
-
-    while (*fmt) {
-        char *old_fmt = fmt;
-        int read = format_decode(fmt, &spec);
-
-        fmt += read;
-
-        switch (spec.type) {
-        case FORMAT_TYPE_NONE: {
-            memcpy(str, old_fmt, read);
-            str += read;
-            break;
-        }
-        case FORMAT_TYPE_HEX: {
-            memcpy(str, old_fmt, read);
-            str = number(str + read, args);
-            for (; *mm ; ++mm) {
-                if (*mm == '%') {
-                    *mm = '0';
-                break;
-                }
-            }
-        break;
-        }
-        case FORMAT_TYPE_ULONG: {
-            memcpy(str, old_fmt, read - 2);
-            str = __number(str + read - 2, args);
-            break;
-        }
-        case FORMAT_TYPE_FLOAT: {
-            va_list integer, dot_v, num;
-            dot_v = modf(args, &integer, &num);
-            memcpy(str, old_fmt, read - 2);
-            str += read - 2;
-            if ((args >> 63 & 0x1)) {
-                *str++ = '-';
-            }
-            str = __number(str, integer);
-            if (dot_v) {
-                *str++ = '.';
-                while (num--) {
-                    *str++ = '0';
-                }
-                str = __number(str, dot_v);
-            }
-            break;
-        }
-        }
-    }
-    *str = '\0';
-
-    return str - buf;
-}
-
-static void serial_out(char *str)
-{
-    while (*str) {
-        *(char *)0xffffffffb80003f8 = *str++;
-    }
-}
-
-int vprintf(char *fmt, va_list args)
-{
-    int printed_len = 0;
-    static char printf_buf[512];
-    printed_len = vsnprintf(printf_buf, sizeof(printf_buf), fmt, args);
-    serial_out(printf_buf);
-    return printed_len;
-}
-
-int printf(char *fmt, ...)
-{
-    return vprintf(fmt, __read($5));
-}
diff --git a/tests/tcg/mips/mips64-dsp/raddu_l_ob.c b/tests/tcg/mips/mips64-dsp/raddu_l_ob.c
deleted file mode 100644
index 76ddf25..0000000
--- a/tests/tcg/mips/mips64-dsp/raddu_l_ob.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, result;
-    rs = 0x12345678ABCDEF0;
-    result = 0x000000000001E258;
-
-    __asm
-        ("raddu.l.ob %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs)
-        );
-
-    if (rd != result) {
-        printf("raddu.l.ob error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/raddu_w_qb.c b/tests/tcg/mips/mips64-dsp/raddu_w_qb.c
deleted file mode 100644
index c9d6535..0000000
--- a/tests/tcg/mips/mips64-dsp/raddu_w_qb.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs;
-    long long result;
-
-    rs = 0x12345678;
-    result = 0x114;
-
-    __asm
-        ("raddu.w.qb %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rs)
-        );
-    if (rd != result) {
-        printf("raddu.w.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/rddsp.c b/tests/tcg/mips/mips64-dsp/rddsp.c
deleted file mode 100644
index 7165572..0000000
--- a/tests/tcg/mips/mips64-dsp/rddsp.c
+++ /dev/null
@@ -1,53 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long dsp_i, dsp_o;
-    long long ccond_i, outflag_i, efi_i, c_i, scount_i, pos_i;
-    long long ccond_o, outflag_o, efi_o, c_o, scount_o, pos_o;
-    long long ccond_r, outflag_r, efi_r, c_r, scount_r, pos_r;
-
-    ccond_i   = 0x000000BC;/* 4 */
-    outflag_i = 0x0000001B;/* 3 */
-    efi_i     = 0x00000001;/* 5 */
-    c_i       = 0x00000001;/* 2 */
-    scount_i  = 0x0000000F;/* 1 */
-    pos_i     = 0x0000000C;/* 0 */
-
-    dsp_i = (ccond_i   << 24) | \
-            (outflag_i << 16) | \
-            (efi_i     << 14) | \
-            (c_i       << 13) | \
-            (scount_i  <<  7) | \
-            pos_i;
-
-    ccond_r   = ccond_i;
-    outflag_r = outflag_i;
-    efi_r     = efi_i;
-    c_r       = c_i;
-    scount_r  = scount_i;
-    pos_r     = pos_i;
-
-    __asm
-        ("wrdsp %1, 0x3F\n\t"
-         "rddsp %0, 0x3F\n\t"
-         : "=r"(dsp_o)
-         : "r"(dsp_i)
-        );
-
-    ccond_o   = (dsp_o >> 24) & 0xFF;
-    outflag_o = (dsp_o >> 16) & 0xFF;
-    efi_o     = (dsp_o >> 14) & 0x01;
-    c_o       = (dsp_o >> 14) & 0x01;
-    scount_o  = (dsp_o >>  7) & 0x3F;
-    pos_o     =  dsp_o & 0x1F;
-
-    if ((ccond_o != ccond_r) || (outflag_o != outflag_r) || (efi_o != efi_r) \
-            || (c_o != c_r) || (scount_o != scount_r) || (pos_o != pos_r)) {
-        printf("rddsp wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/repl_ob.c b/tests/tcg/mips/mips64-dsp/repl_ob.c
deleted file mode 100644
index 20cb780..0000000
--- a/tests/tcg/mips/mips64-dsp/repl_ob.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, result;
-    rd = 0;
-    result = 0xFFFFFFFFFFFFFFFF;
-
-    __asm
-        ("repl.ob %0, 0xFF\n\t"
-         : "=r"(rd)
-        );
-
-    if (result != rd) {
-        printf("repl.ob error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/repl_ph.c b/tests/tcg/mips/mips64-dsp/repl_ph.c
deleted file mode 100644
index 11d29bd..0000000
--- a/tests/tcg/mips/mips64-dsp/repl_ph.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, result;
-
-    result = 0x01BF01BF;
-    __asm
-        ("repl.ph %0, 0x1BF\n\t"
-         : "=r"(rd)
-        );
-    if (rd != result) {
-        printf("repl.ph wrong\n");
-
-        return -1;
-    }
-
-    result = 0x01FF01FF;
-    __asm
-        ("repl.ph %0, 0x01FF\n\t"
-         : "=r"(rd)
-        );
-    if (rd != result) {
-        printf("repl.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/repl_pw.c b/tests/tcg/mips/mips64-dsp/repl_pw.c
deleted file mode 100644
index d35376a..0000000
--- a/tests/tcg/mips/mips64-dsp/repl_pw.c
+++ /dev/null
@@ -1,34 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, result;
-    rd = 0;
-    result = 0x000001FF000001FF;
-
-    __asm
-        ("repl.pw %0, 0x1FF\n\t"
-         : "=r"(rd)
-        );
-
-    if (result != rd) {
-        printf("repl.pw error1\n");
-
-        return -1;
-    }
-
-    rd = 0;
-    result = 0xFFFFFE00FFFFFE00;
-    __asm
-        ("repl.pw %0, 0xFFFFFFFFFFFFFE00\n\t"
-         : "=r"(rd)
-        );
-
-    if (result != rd) {
-        printf("repl.pw error2\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/repl_qb.c b/tests/tcg/mips/mips64-dsp/repl_qb.c
deleted file mode 100644
index 592feae..0000000
--- a/tests/tcg/mips/mips64-dsp/repl_qb.c
+++ /dev/null
@@ -1,19 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, result;
-
-    result = 0xFFFFFFFFBFBFBFBF;
-    __asm
-        ("repl.qb %0, 0xBF\n\t"
-         : "=r"(rd)
-        );
-    if (rd != result) {
-        printf("repl.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/repl_qh.c b/tests/tcg/mips/mips64-dsp/repl_qh.c
deleted file mode 100644
index 82afc37..0000000
--- a/tests/tcg/mips/mips64-dsp/repl_qh.c
+++ /dev/null
@@ -1,34 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, result;
-    rd = 0;
-    result = 0x01FF01FF01FF01FF;
-
-    __asm
-        ("repl.qh %0, 0x1FF\n\t"
-         : "=r"(rd)
-        );
-
-    if (result != rd) {
-        printf("repl.qh error 1\n");
-
-        return -1;
-    }
-
-    rd = 0;
-    result = 0xFE00FE00FE00FE00;
-    __asm
-        ("repl.qh %0, 0xFFFFFFFFFFFFFE00\n\t"
-         : "=r"(rd)
-        );
-
-    if (result != rd) {
-        printf("repl.qh error 2\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/replv_ob.c b/tests/tcg/mips/mips64-dsp/replv_ob.c
deleted file mode 100644
index 31ff318..0000000
--- a/tests/tcg/mips/mips64-dsp/replv_ob.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-
-    rt = 0xFF;
-    result = 0xFFFFFFFFFFFFFFFF;
-
-    __asm
-        ("replv.ob %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("replv.ob error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/replv_ph.c b/tests/tcg/mips/mips64-dsp/replv_ph.c
deleted file mode 100644
index 0af7a36..0000000
--- a/tests/tcg/mips/mips64-dsp/replv_ph.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x12345678;
-    result = 0x56785678;
-    __asm
-        ("replv.ph %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("replv.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/replv_pw.c b/tests/tcg/mips/mips64-dsp/replv_pw.c
deleted file mode 100644
index e1789af..0000000
--- a/tests/tcg/mips/mips64-dsp/replv_pw.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, result;
-    rd = 0;
-    rt = 0xFFFFFFFF;
-    result = 0xFFFFFFFFFFFFFFFF;
-
-    __asm
-        ("replv.pw %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (result != rd) {
-        printf("replv.pw error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/replv_qb.c b/tests/tcg/mips/mips64-dsp/replv_qb.c
deleted file mode 100644
index d99298c..0000000
--- a/tests/tcg/mips/mips64-dsp/replv_qb.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt     = 0x12345678;
-    result = 0x78787878;
-    __asm
-        ("replv.qb %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("replv.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shilo.c b/tests/tcg/mips/mips64-dsp/shilo.c
deleted file mode 100644
index 5f454f6..0000000
--- a/tests/tcg/mips/mips64-dsp/shilo.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long ach, acl;
-    long long resulth, resultl;
-
-    ach = 0xBBAACCFF;
-    acl = 0x1C3B001D;
-
-    resulth = 0x17755;
-    resultl = 0xFFFFFFFF99fe3876;
-
-    __asm
-        ("mthi %0, $ac1\n\t"
-         "mtlo %1, $ac1\n\t"
-         "shilo $ac1, 0x0F\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("shilo wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shilov.c b/tests/tcg/mips/mips64-dsp/shilov.c
deleted file mode 100644
index e82615a..0000000
--- a/tests/tcg/mips/mips64-dsp/shilov.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, ach, acl;
-    long long resulth, resultl;
-
-    rs  = 0x0F;
-    ach = 0xBBAACCFF;
-    acl = 0x1C3B001D;
-
-    resulth = 0x17755;
-    resultl = 0xFFFFFFFF99fe3876;
-
-    __asm
-        ("mthi %0, $ac1\n\t"
-         "mtlo %1, $ac1\n\t"
-         "shilov $ac1, %2\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("shilov wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shll_ob.c b/tests/tcg/mips/mips64-dsp/shll_ob.c
deleted file mode 100644
index 7dcb58f..0000000
--- a/tests/tcg/mips/mips64-dsp/shll_ob.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, dsp;
-    long long res, resdsp;
-
-    rt = 0x9ba8765433456789;
-    res = 0x9ba8765433456789;
-    resdsp = 0x0;
-    __asm
-        ("shll.ob %0, %2, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-
-    dsp = (dsp >> 22) & 0x1;
-
-    if ((dsp != resdsp) || (rd != res)) {
-        printf("shll.ob error\n");
-        return -1;
-    }
-
-    rt = 0x9ba8765433456789;
-    res = 0xd840b0a098283848;
-    resdsp = 0x1;
-    __asm
-        ("shll.ob %0, %2, 0x3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-
-    dsp = (dsp >> 22) & 0x1;
-
-    if ((dsp != resdsp) || (rd != res)) {
-        printf("shll.ob error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shll_ph.c b/tests/tcg/mips/mips64-dsp/shll_ph.c
deleted file mode 100644
index 42b462d..0000000
--- a/tests/tcg/mips/mips64-dsp/shll_ph.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, dsp;
-    long long result, resultdsp;
-
-    rt        = 0x12345678;
-    result    = 0x12345678;
-    resultdsp = 0;
-
-    __asm
-        ("shll.ph %0, %2, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shll.ph wrong\n");
-
-        return -1;
-    }
-
-    rt        = 0x12345678;
-    result    = 0xFFFFFFFFA000C000;
-    resultdsp = 1;
-
-    __asm
-        ("shll.ph %0, %2, 0x0B\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shll.ph wrong1\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shll_pw.c b/tests/tcg/mips/mips64-dsp/shll_pw.c
deleted file mode 100644
index d7878b2..0000000
--- a/tests/tcg/mips/mips64-dsp/shll_pw.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, dsp;
-    long long result, resultdsp;
-
-    rt        = 0x8765432112345678;
-    result    = 0x8765432112345678;
-    resultdsp = 0;
-
-    __asm
-        ("shll.pw %0, %2, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shll.pw wrong\n");
-        return -1;
-    }
-
-    rt        = 0x8765432112345678;
-    result    = 0x6543210034567800;
-    resultdsp = 1;
-
-    __asm
-        ("shll.pw %0, %2, 0x8\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shll.pw wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shll_qb.c b/tests/tcg/mips/mips64-dsp/shll_qb.c
deleted file mode 100644
index c21ab66..0000000
--- a/tests/tcg/mips/mips64-dsp/shll_qb.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, dsp;
-    long long result, resultdsp;
-
-    rt     = 0x87654321;
-    result = 0x38281808;
-    resultdsp = 0x01;
-
-    __asm
-        ("shll.qb %0, %2, 0x03\n\t"
-         "rddsp   %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    if (rd != result) {
-        printf("shll.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shll_qh.c b/tests/tcg/mips/mips64-dsp/shll_qh.c
deleted file mode 100644
index 1380825..0000000
--- a/tests/tcg/mips/mips64-dsp/shll_qh.c
+++ /dev/null
@@ -1,42 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, dsp;
-    long long res, resdsp;
-
-    rt = 0x9ba8765433456789;
-    res = 0x9ba8765433456789;
-    resdsp = 0x0;
-    __asm
-        ("shll.qh %0, %2, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x1;
-
-    if ((dsp != resdsp) || (rd != res)) {
-        printf("shll.qh error\n");
-        return -1;
-    }
-
-    rt = 0x9ba8765433456789;
-    res = 0xdd40b2a09a283c48;
-    resdsp = 0x1;
-    __asm
-        ("shll.qh %0, %2, 0x3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-
-    dsp = (dsp >> 22) & 0x1;
-
-    if ((dsp != resdsp) || (rd != res)) {
-        printf("shll.qh error1\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shll_s_ph.c b/tests/tcg/mips/mips64-dsp/shll_s_ph.c
deleted file mode 100644
index 1cf5d6d..0000000
--- a/tests/tcg/mips/mips64-dsp/shll_s_ph.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, dsp;
-    long long result, resultdsp;
-
-    rt        = 0x12345678;
-    result    = 0x12345678;
-    resultdsp = 0x0;
-
-    __asm
-        ("shll_s.ph %0, %2, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shll_s.ph wrong\n");
-
-        return -1;
-    }
-
-    rt        = 0x12345678;
-    result    = 0x7FFF7FFF;
-    resultdsp = 0x01;
-
-    __asm
-        ("shll_s.ph %0, %2, 0x0B\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shll_s.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shll_s_pw.c b/tests/tcg/mips/mips64-dsp/shll_s_pw.c
deleted file mode 100644
index e38f686..0000000
--- a/tests/tcg/mips/mips64-dsp/shll_s_pw.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, dsp;
-    long long result, resultdsp;
-
-    rt        = 0x8765432112345678;
-    result    = 0x8765432112345678;
-    resultdsp = 0;
-
-    __asm
-        ("shll_s.pw %0, %2, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shll_s.pw wrong\n");
-        return -1;
-    }
-
-    rt        = 0x8765432112345678;
-    result    = 0x800000007fffffff;
-    resultdsp = 1;
-
-    __asm
-        ("shll_s.pw %0, %2, 0x8\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shll_s.pw wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shll_s_qh.c b/tests/tcg/mips/mips64-dsp/shll_s_qh.c
deleted file mode 100644
index f2f57fa..0000000
--- a/tests/tcg/mips/mips64-dsp/shll_s_qh.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, dsp;
-    long long res, resdsp;
-
-    rt = 0x9ba8765433456789;
-    res = 0x9ba8765433456789;
-    resdsp = 0x0;
-    __asm
-        ("shll_s.qh %0, %2, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-
-    dsp = (dsp >> 22) & 0x1;
-
-    if ((dsp != resdsp) || (rd != res)) {
-        printf("shll_s.qh error\n");
-        return -1;
-    }
-
-    rt = 0x9ba8765433456789;
-    res = 0x80007fff7fff7fff;
-    resdsp = 0x1;
-    __asm
-        ("shll_s.qh %0, %2, 0x3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-
-    dsp = (dsp >> 22) & 0x1;
-
-    if ((dsp != resdsp) || (rd != res)) {
-        printf("shll_s.qh error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shll_s_w.c b/tests/tcg/mips/mips64-dsp/shll_s_w.c
deleted file mode 100644
index 5780061..0000000
--- a/tests/tcg/mips/mips64-dsp/shll_s_w.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, dsp;
-    long long result, resultdsp;
-
-    rt        = 0x12345678;
-    result    = 0x7FFFFFFF;
-    resultdsp = 0x01;
-
-    __asm
-        ("shll_s.w %0, %2, 0x0B\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shll_s.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shllv_ob.c b/tests/tcg/mips/mips64-dsp/shllv_ob.c
deleted file mode 100644
index 96a2e6f..0000000
--- a/tests/tcg/mips/mips64-dsp/shllv_ob.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs, dsp;
-    long long result, resultdsp;
-
-    rt        = 0x8765432112345678;
-    rs = 0x0;
-    result    = 0x8765432112345678;
-    resultdsp = 0;
-
-    __asm
-        ("shllv.ob %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv.ob wrong\n");
-        return -1;
-    }
-
-    rt        = 0x8765432112345678;
-    rs = 0x4;
-    result    = 0x7050301020406080;
-    resultdsp = 1;
-
-    __asm
-        ("shllv.ob %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv.ob wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shllv_ph.c b/tests/tcg/mips/mips64-dsp/shllv_ph.c
deleted file mode 100644
index 532291f..0000000
--- a/tests/tcg/mips/mips64-dsp/shllv_ph.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs        = 0x0B;
-    rt        = 0x12345678;
-    result    = 0xFFFFFFFFA000C000;
-    resultdsp = 1;
-
-    __asm
-        ("shllv.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shllv_pw.c b/tests/tcg/mips/mips64-dsp/shllv_pw.c
deleted file mode 100644
index 8d4ec29..0000000
--- a/tests/tcg/mips/mips64-dsp/shllv_pw.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs, dsp;
-    long long result, resultdsp;
-    rt        = 0x8765432112345678;
-    rs = 0x0;
-    result    = 0x8765432112345678;
-    resultdsp = 0;
-
-    __asm
-        ("shllv.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv.pw wrong\n");
-        return -1;
-    }
-
-
-    rt        = 0x8765432112345678;
-    rs = 0x8;
-    result    = 0x6543210034567800;
-    resultdsp = 1;
-
-    __asm
-        ("shllv.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv.pw wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shllv_qb.c b/tests/tcg/mips/mips64-dsp/shllv_qb.c
deleted file mode 100644
index e49356b..0000000
--- a/tests/tcg/mips/mips64-dsp/shllv_qb.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs     = 0x03;
-    rt     = 0x87654321;
-    result = 0x38281808;
-    resultdsp = 0x01;
-
-    __asm
-        ("shllv.qb %0, %2, %3\n\t"
-         "rddsp   %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    if (rd != result) {
-        printf("shllv.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shllv_qh.c b/tests/tcg/mips/mips64-dsp/shllv_qh.c
deleted file mode 100644
index 0de4077..0000000
--- a/tests/tcg/mips/mips64-dsp/shllv_qh.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs, dsp;
-    long long result, resultdsp;
-
-    rt        = 0x8765432112345678;
-    rs = 0x0;
-    result    = 0x8765432112345678;
-    resultdsp = 0;
-
-    __asm
-        ("shllv.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv.qh wrong\n");
-        return -1;
-    }
-
-    rt        = 0x8765432112345678;
-    rs = 0x4;
-    result    = 0x7650321023406780;
-    resultdsp = 1;
-
-    __asm
-        ("shllv.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv.qh wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shllv_s_ph.c b/tests/tcg/mips/mips64-dsp/shllv_s_ph.c
deleted file mode 100644
index 7e69f94..0000000
--- a/tests/tcg/mips/mips64-dsp/shllv_s_ph.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs        = 0x0B;
-    rt        = 0x12345678;
-    result    = 0x7FFF7FFF;
-    resultdsp = 0x01;
-
-    __asm
-        ("shllv_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv_s.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shllv_s_pw.c b/tests/tcg/mips/mips64-dsp/shllv_s_pw.c
deleted file mode 100644
index f8dc8d2..0000000
--- a/tests/tcg/mips/mips64-dsp/shllv_s_pw.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs, dsp;
-    long long result, resultdsp;
-
-    rt        = 0x8765432112345678;
-    rs = 0x0;
-    result    = 0x8765432112345678;
-    resultdsp = 0;
-
-    __asm
-        ("shllv_s.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv_s.pw wrong\n");
-        return -1;
-    }
-
-    rt        = 0x8765432112345678;
-    rs = 0x8;
-    result    = 0x800000007fffffff;
-    resultdsp = 1;
-
-    __asm
-        ("shllv_s.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv_s.pw wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shllv_s_qh.c b/tests/tcg/mips/mips64-dsp/shllv_s_qh.c
deleted file mode 100644
index db3832d..0000000
--- a/tests/tcg/mips/mips64-dsp/shllv_s_qh.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs, dsp;
-    long long result, resultdsp;
-
-    rt        = 0x8765432112345678;
-    rs = 0x0;
-    result    = 0x8765432112345678;
-    resultdsp = 0;
-
-    __asm
-        ("shllv_s.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv_s.qh wrong\n");
-        return -1;
-    }
-
-    rt        = 0x8765432112345678;
-    rs = 0x4;
-    result    = 0x80007fff7fff7fff;
-    resultdsp = 1;
-
-    __asm
-        ("shllv_s.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv_s.qh wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shllv_s_w.c b/tests/tcg/mips/mips64-dsp/shllv_s_w.c
deleted file mode 100644
index 5f6af8b..0000000
--- a/tests/tcg/mips/mips64-dsp/shllv_s_w.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs        = 0x0B;
-    rt        = 0x12345678;
-    result    = 0x7FFFFFFF;
-    resultdsp = 0x01;
-
-    __asm
-        ("shllv_s.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("shllv_s.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shra_ob.c b/tests/tcg/mips/mips64-dsp/shra_ob.c
deleted file mode 100644
index d7fcfa8..0000000
--- a/tests/tcg/mips/mips64-dsp/shra_ob.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main()
-{
-    long long rd, rt;
-    long long res;
-
-    rt = 0xbc98756abc654389;
-    res = 0xfbf9f7f6fb0604f8;
-
-    __asm
-        ("shra.ob %0, %1, 0x4\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shra.ob error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shra_ph.c b/tests/tcg/mips/mips64-dsp/shra_ph.c
deleted file mode 100644
index a2dc014..0000000
--- a/tests/tcg/mips/mips64-dsp/shra_ph.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt     = 0x87654321;
-    result = 0xFFFFFFFFF0EC0864;
-
-    __asm
-        ("shra.ph %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("shra.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shra_pw.c b/tests/tcg/mips/mips64-dsp/shra_pw.c
deleted file mode 100644
index 33b1b8f..0000000
--- a/tests/tcg/mips/mips64-dsp/shra_pw.c
+++ /dev/null
@@ -1,36 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long res;
-
-    rt = 0x1234567887654321;
-    res = 0x01234567f8765432;
-
-    __asm
-        ("shra.pw %0, %1, 0x4"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shra.pw error\n");
-        return -1;
-    }
-
-    rt = 0x1234567887654321;
-    res = 0x1234567887654321;
-
-    __asm
-        ("shra.pw %0, %1, 0x0"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shra.pw error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shra_qh.c b/tests/tcg/mips/mips64-dsp/shra_qh.c
deleted file mode 100644
index 85dbfef..0000000
--- a/tests/tcg/mips/mips64-dsp/shra_qh.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long res;
-
-    rt = 0x8512345654323454;
-    res = 0xf851034505430345;
-
-    __asm
-        ("shra.qh %0, %1, 0x4\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shra.qh error\n");
-        return -1;
-    }
-
-    rt = 0x8512345654323454;
-    res = 0x8512345654323454;
-
-    __asm
-        ("shra.qh %0, %1, 0x0\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shra.qh error1\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shra_r_ob.c b/tests/tcg/mips/mips64-dsp/shra_r_ob.c
deleted file mode 100644
index 1847094..0000000
--- a/tests/tcg/mips/mips64-dsp/shra_r_ob.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main()
-{
-    long long rd, rt;
-    long long res;
-
-    rt = 0xbc98756abc654389;
-    res = 0xfcfaf8f7fc0705f9;
-
-    __asm
-        ("shra_r.ob %0, %1, 0x4\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shra_r.ob error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shra_r_ph.c b/tests/tcg/mips/mips64-dsp/shra_r_ph.c
deleted file mode 100644
index e0943ad..0000000
--- a/tests/tcg/mips/mips64-dsp/shra_r_ph.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt     = 0x87654321;
-    result = 0xFFFFFFFFF0ED0864;
-
-    __asm
-        ("shra_r.ph %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("shra_r.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shra_r_pw.c b/tests/tcg/mips/mips64-dsp/shra_r_pw.c
deleted file mode 100644
index 6a86e68..0000000
--- a/tests/tcg/mips/mips64-dsp/shra_r_pw.c
+++ /dev/null
@@ -1,36 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long res;
-
-    rt = 0x1234567887654321;
-    res = 0x01234568f8765432;
-
-    __asm
-        ("shra_r.pw %0, %1, 0x4"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shra_r.pw error\n");
-        return -1;
-    }
-
-    rt = 0x1234567887654321;
-    res = 0x1234567887654321;
-
-    __asm
-        ("shra_r.pw %0, %1, 0x0"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shra_r.pw error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shra_r_qh.c b/tests/tcg/mips/mips64-dsp/shra_r_qh.c
deleted file mode 100644
index d5c2110..0000000
--- a/tests/tcg/mips/mips64-dsp/shra_r_qh.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long res;
-
-    rt = 0x8512345654323454;
-    res = 0xf0a2068b0a86068b;
-
-    __asm
-        ("shra_r.qh %0, %1, 0x3\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shra_r.qh error\n");
-        return -1;
-    }
-
-    rt = 0x8512345654323454;
-    res = 0x8512345654323454;
-
-    __asm
-        ("shra_r.qh %0, %1, 0x0\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shra_r.qh error1\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shra_r_w.c b/tests/tcg/mips/mips64-dsp/shra_r_w.c
deleted file mode 100644
index 36d2c9c..0000000
--- a/tests/tcg/mips/mips64-dsp/shra_r_w.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt     = 0x87654321;
-    result = 0xFFFFFFFFF0ECA864;
-
-    __asm
-        ("shra_r.w %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("shra_r.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrav_ph.c b/tests/tcg/mips/mips64-dsp/shrav_ph.c
deleted file mode 100644
index 1b4e983..0000000
--- a/tests/tcg/mips/mips64-dsp/shrav_ph.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x03;
-    rt     = 0x87654321;
-    result = 0xFFFFFFFFF0EC0864;
-
-    __asm
-        ("shrav.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    if (rd != result) {
-        printf("shrav.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrav_pw.c b/tests/tcg/mips/mips64-dsp/shrav_pw.c
deleted file mode 100644
index e19d515..0000000
--- a/tests/tcg/mips/mips64-dsp/shrav_pw.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs;
-    long long res;
-
-    rt = 0x1234567887654321;
-    rs = 0x4;
-    res = 0x01234567f8765432;
-
-    __asm
-        ("shrav.pw %0, %1, %2"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shrav.pw error\n");
-        return -1;
-    }
-
-    rt = 0x1234567887654321;
-    rs = 0x0;
-    res = 0x1234567887654321;
-
-    __asm
-        ("shrav.pw %0, %1, %2"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shrav.pw error1\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrav_qh.c b/tests/tcg/mips/mips64-dsp/shrav_qh.c
deleted file mode 100644
index dc92e09..0000000
--- a/tests/tcg/mips/mips64-dsp/shrav_qh.c
+++ /dev/null
@@ -1,39 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs;
-    long long res;
-
-    rt = 0x8512345654323454;
-    rs = 0x4;
-    res = 0xf851034505430345;
-
-    __asm
-        ("shrav.qh %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shrav.qh error\n");
-        return -1;
-    }
-
-    rt = 0x8512345654323454;
-    rs = 0x0;
-    res = 0x8512345654323454;
-
-    __asm
-        ("shrav.qh %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shrav.qh error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrav_r_ph.c b/tests/tcg/mips/mips64-dsp/shrav_r_ph.c
deleted file mode 100644
index 350d529..0000000
--- a/tests/tcg/mips/mips64-dsp/shrav_r_ph.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x03;
-    rt     = 0x87654321;
-    result = 0xFFFFFFFFF0ED0864;
-
-    __asm
-        ("shrav_r.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    if (rd != result) {
-        printf("shrav_r.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrav_r_pw.c b/tests/tcg/mips/mips64-dsp/shrav_r_pw.c
deleted file mode 100644
index 25b0545..0000000
--- a/tests/tcg/mips/mips64-dsp/shrav_r_pw.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs;
-    long long res;
-
-    rt = 0x1234567887654321;
-    rs = 0x4;
-    res = 0x01234568f8765432;
-
-    __asm
-        ("shrav_r.pw %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shrav_r.pw error\n");
-        return -1;
-    }
-
-    rt = 0x1234567887654321;
-    rs = 0x0;
-    res = 0x1234567887654321;
-
-    __asm
-        ("shrav_r.pw %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    if (rd != res) {
-        printf("shrav_r.pw error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrav_r_qh.c b/tests/tcg/mips/mips64-dsp/shrav_r_qh.c
deleted file mode 100644
index fd187a1..0000000
--- a/tests/tcg/mips/mips64-dsp/shrav_r_qh.c
+++ /dev/null
@@ -1,39 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs;
-    long long res;
-
-    rt = 0x8512345654323454;
-    rs = 0x3;
-    res = 0xf0a2068b0a86068b;
-
-    __asm
-        ("shrav_r.qh %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shrav_r.qh error\n");
-        return -1;
-    }
-
-    rt = 0x400000000000000;
-    rs = 0x0;
-    res = 0x400000000000000;
-
-    __asm
-        ("shrav_r.qh %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shrav_r.qh error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrav_r_w.c b/tests/tcg/mips/mips64-dsp/shrav_r_w.c
deleted file mode 100644
index 3766c72..0000000
--- a/tests/tcg/mips/mips64-dsp/shrav_r_w.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x03;
-    rt     = 0x87654321;
-    result = 0xFFFFFFFFF0ECA864;
-
-    __asm
-        ("shrav_r.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    if (rd != result) {
-        printf("shrav_r.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrl_ob.c b/tests/tcg/mips/mips64-dsp/shrl_ob.c
deleted file mode 100644
index a114571..0000000
--- a/tests/tcg/mips/mips64-dsp/shrl_ob.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long res;
-
-    rt = 0xab76543212345678;
-    res = 0x150e0a0602060a0f;
-
-    __asm
-        ("shrl.ob %0, %1, 0x3\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shrl.ob error\n");
-        return -1;
-    }
-
-    rt = 0xab76543212345678;
-    res = 0xab76543212345678;
-
-    __asm
-        ("shrl.ob %0, %1, 0x0\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shrl.ob error\n");
-        return -1;
-    }
-
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrl_qb.c b/tests/tcg/mips/mips64-dsp/shrl_qb.c
deleted file mode 100644
index c0e36db..0000000
--- a/tests/tcg/mips/mips64-dsp/shrl_qb.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt     = 0x12345678;
-    result = 0x00010203;
-
-    __asm
-        ("shrl.qb %0, %1, 0x05\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("shrl.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrl_qh.c b/tests/tcg/mips/mips64-dsp/shrl_qh.c
deleted file mode 100644
index c156246..0000000
--- a/tests/tcg/mips/mips64-dsp/shrl_qh.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long res;
-
-    rt = 0x8765679abc543786;
-    res = 0x087606790bc50378;
-
-    __asm
-        ("shrl.qh %0, %1, 0x4\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    if (rd != res) {
-        printf("shrl.qh error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrlv_ob.c b/tests/tcg/mips/mips64-dsp/shrlv_ob.c
deleted file mode 100644
index cb39c46..0000000
--- a/tests/tcg/mips/mips64-dsp/shrlv_ob.c
+++ /dev/null
@@ -1,39 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs;
-    long long res;
-
-    rt = 0xab76543212345678;
-    rs = 0x3;
-    res = 0x150e0a0602060a0f;
-
-    __asm
-        ("shrlv.ob %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shrlv.ob error\n");
-        return -1;
-    }
-
-    rt = 0xab76543212345678;
-    rs = 0x0;
-    res = 0xab76543212345678;
-
-    __asm
-        ("shrlv.ob %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shrlv.ob error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrlv_qb.c b/tests/tcg/mips/mips64-dsp/shrlv_qb.c
deleted file mode 100644
index 5616aa9..0000000
--- a/tests/tcg/mips/mips64-dsp/shrlv_qb.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x05;
-    rt     = 0x12345678;
-    result = 0x00010203;
-
-    __asm
-        ("shrlv.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    if (rd != result) {
-        printf("shrlv.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/shrlv_qh.c b/tests/tcg/mips/mips64-dsp/shrlv_qh.c
deleted file mode 100644
index 05de2fd..0000000
--- a/tests/tcg/mips/mips64-dsp/shrlv_qh.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs;
-    long long res;
-
-    rt = 0x8765679abc543786;
-    rs = 0x4;
-    res = 0x087606790bc50378;
-
-    __asm
-        ("shrlv.qh %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shrlv.qh error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/subq_ph.c b/tests/tcg/mips/mips64-dsp/subq_ph.c
deleted file mode 100644
index 6a1b186..0000000
--- a/tests/tcg/mips/mips64-dsp/subq_ph.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result    = 0xFFFFFFFF8ACF1357;
-    resultdsp = 0x01;
-
-    __asm
-        ("subq.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("subq.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/subq_pw.c b/tests/tcg/mips/mips64-dsp/subq_pw.c
deleted file mode 100644
index 32f96ba..0000000
--- a/tests/tcg/mips/mips64-dsp/subq_pw.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-    rt = 0x123456789ABCDEF0;
-    rs = 0x123456789ABCDEF0;
-    result = 0x0;
-    dspresult = 0x0;
-
-    __asm
-        ("subq.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-         );
-    dspreg = (dspreg >> 20) & 0x1;
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subq.pw error1\n\t");
-
-        return -1;
-    }
-
-    rt = 0x123456789ABCDEF1;
-    rs = 0x123456789ABCDEF2;
-    result =  0x0000000000000001;
-    dspresult = 0x0;
-
-    __asm
-        ("subq.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-    dspreg = (dspreg >> 20) & 0x1;
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subq.pw error2\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/subq_qh.c b/tests/tcg/mips/mips64-dsp/subq_qh.c
deleted file mode 100644
index 76d5f0a..0000000
--- a/tests/tcg/mips/mips64-dsp/subq_qh.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-    rt = 0x123456789ABCDEF0;
-    rs = 0x123456789ABCDEF0;
-    result = 0x0;
-    dspresult = 0x0;
-
-    __asm
-        ("subq.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-    dspreg = (dspreg >> 20) & 0x1;
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subq.qh error\n\t");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/subq_s_ph.c b/tests/tcg/mips/mips64-dsp/subq_s_ph.c
deleted file mode 100644
index 0b162f0..0000000
--- a/tests/tcg/mips/mips64-dsp/subq_s_ph.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result    = 0x7FFF1357;
-    resultdsp = 0x01;
-
-    __asm
-        ("subq_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("subq_s.ph wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/subq_s_pw.c b/tests/tcg/mips/mips64-dsp/subq_s_pw.c
deleted file mode 100644
index 4c080b7..0000000
--- a/tests/tcg/mips/mips64-dsp/subq_s_pw.c
+++ /dev/null
@@ -1,63 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-    rt = 0x9FFFFFFD9FFFFFFD;
-    rs = 0x4000000080000000;
-    result = 0x7fffffffe0000003;
-    dspresult = 0x1;
-
-    __asm
-        ("subq_s.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-    dspreg = (dspreg >> 20) & 0x1;
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subq_s.pw error1\n");
-
-        return -1;
-    }
-
-    rt = 0x123456789ABCDEF1;
-    rs = 0x123456789ABCDEF2;
-    result =  0x0000000000000001;
-    /* This time we do not set dspctrl, but set it in pre-action. */
-    dspresult = 0x1;
-
-    __asm
-        ("subq_s.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-    dspreg = (dspreg >> 20) & 0x1;
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subq_s.pw error2\n");
-
-        return -1;
-    }
-
-    rt = 0x8000000080000000;
-    rs = 0x7000000070000000;
-    dspresult = 0x1;
-
-    __asm
-        ("subq_s.pw %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = (dspreg >> 20) & 0x1;
-    if ((dspreg != dspresult)) {
-        printf("subq_s.pw error3\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/subq_s_qh.c b/tests/tcg/mips/mips64-dsp/subq_s_qh.c
deleted file mode 100644
index 4053b6b..0000000
--- a/tests/tcg/mips/mips64-dsp/subq_s_qh.c
+++ /dev/null
@@ -1,61 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEF0;
-    result = 0x0;
-    dspresult = 0x0;
-
-    __asm
-        ("subq_s.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-    dspreg = (dspreg >> 20) & 0x1;
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subq_s.qh error1\n");
-
-        return -1;
-    }
-
-    rs = 0x4000000080000000;
-    rt = 0x9FFD00009FFC0000;
-    result =  0x7FFF0000E0040000;
-    dspresult = 0x1;
-
-    __asm
-        ("subq_s.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-    dspreg = (dspreg >> 20) & 0x1;
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subq_s.qh error2\n");
-
-        return -1;
-    }
-
-    rs = 0x8000000000000000;
-    rt = 0x7000000000000000;
-    result =  0x8000000000000000;
-    dspresult = 0x1;
-    __asm
-        ("subq_s.qh %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-        );
-
-    dspreg = (dspreg >> 20) & 0x1;
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subq_s.qh error3\n");
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/subq_s_w.c b/tests/tcg/mips/mips64-dsp/subq_s_w.c
deleted file mode 100644
index 91d32da..0000000
--- a/tests/tcg/mips/mips64-dsp/subq_s_w.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result    = 0x7FFFFFFF;
-    resultdsp = 0x01;
-
-    __asm
-        ("subq_s.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("subq_s.w wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/subu_ob.c b/tests/tcg/mips/mips64-dsp/subu_ob.c
deleted file mode 100644
index f670967..0000000
--- a/tests/tcg/mips/mips64-dsp/subu_ob.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-    rs = 0x6F6F6F6F6F6F6F6F;
-    rt = 0x5E5E5E5E5E5E5E5E;
-    result = 0x1111111111111111;
-    dspresult = 0x0;
-
-    __asm
-        ("subu.ob %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-         );
-
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subu.ob error\n");
-
-        return -1;
-    }
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips64-dsp/subu_qb.c b/tests/tcg/mips/mips64-dsp/subu_qb.c
deleted file mode 100644
index 9eb80df..0000000
--- a/tests/tcg/mips/mips64-dsp/subu_qb.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result    = 0xFFFFFFFF8BCF1357;
-    resultdsp = 0x01;
-
-    __asm
-        ("subu.qb %0, %2, %3\n\t"
-         "rddsp   %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("subu.qb wrong\n");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/subu_s_ob.c b/tests/tcg/mips/mips64-dsp/subu_s_ob.c
deleted file mode 100644
index 5df64e5..0000000
--- a/tests/tcg/mips/mips64-dsp/subu_s_ob.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dspreg, result, dspresult;
-    rs = 0x12345678ABCDEF0;
-    rt = 0x12345678ABCDEF1;
-    result = 0x00000000000;
-    dspresult = 0x01;
-
-    __asm
-        ("subu_s.ob %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dspreg)
-         : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subu_s.ob error\n\t");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/subu_s_qb.c b/tests/tcg/mips/mips64-dsp/subu_s_qb.c
deleted file mode 100644
index 9de76f4..0000000
--- a/tests/tcg/mips/mips64-dsp/subu_s_qb.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result    = 0x00001357;
-    resultdsp = 0x01;
-
-    __asm
-        ("subu_s.qb %0, %2, %3\n\t"
-         "rddsp   %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    if ((dsp != resultdsp) || (rd  != result)) {
-        printf("subu_s_qb wrong");
-
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dsp/wrdsp.c b/tests/tcg/mips/mips64-dsp/wrdsp.c
deleted file mode 100644
index 3033fd8..0000000
--- a/tests/tcg/mips/mips64-dsp/wrdsp.c
+++ /dev/null
@@ -1,48 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long dsp_i, dsp_o;
-    long long ccond_i, outflag_i, efi_i, c_i, scount_i, pos_i;
-    long long ccond_o, outflag_o, efi_o, c_o, scount_o, pos_o;
-    long long ccond_r, outflag_r, efi_r, c_r, scount_r, pos_r;
-
-    ccond_i = 0x000000BC;/* 4 */
-    outflag_i = 0x0000001B;/* 3 */
-    efi_i = 0x00000001;/* 5 */
-    c_i = 0x00000001;/* 2 */
-    scount_i = 0x0000000F;/* 1 */
-    pos_i = 0x0000000C;/* 0 */
-
-    dsp_i = (ccond_i << 24) | (outflag_i << 16) | (efi_i << 14) | (c_i << 13)
-            | (scount_i << 7) | pos_i;
-
-    ccond_r = ccond_i;
-    outflag_r = outflag_i;
-    efi_r = efi_i;
-    c_r = c_i;
-    scount_r = scount_i;
-    pos_r = pos_i;
-
-    __asm
-        ("wrdsp %1, 0x3F\n\t"
-         "rddsp %0, 0x3F\n\t"
-         : "=r"(dsp_o)
-         : "r"(dsp_i)
-        );
-
-    ccond_o = (dsp_o >> 24) & 0xFF;
-    outflag_o = (dsp_o >> 16) & 0xFF;
-    efi_o = (dsp_o >> 14) & 0x01;
-    c_o = (dsp_o >> 14) & 0x01;
-    scount_o = (dsp_o >> 7) & 0x3F;
-    pos_o = dsp_o & 0x1F;
-
-    if ((ccond_o != ccond_r) || (outflag_o != outflag_r) || (efi_o != efi_r) \
-            || (c_o != c_r) || (scount_o != scount_r) || (pos_o != pos_r)) {
-        printf("wrddsp wrong\n");
-
-        return -1;
-    }
-    return 0;
-}
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
diff --git a/tests/tcg/mips/mips64-dspr2/absq_s_qb.c b/tests/tcg/mips/mips64-dspr2/absq_s_qb.c
deleted file mode 100644
index f7aec3e..0000000
--- a/tests/tcg/mips/mips64-dspr2/absq_s_qb.c
+++ /dev/null
@@ -1,42 +0,0 @@
-#include "io.h"
-int main()
-{
-    long long input, result, dsp;
-    long long hope;
-
-    input = 0x701BA35E;
-    hope  = 0x701B5D5E;
-
-    __asm
-        ("absq_s.qb %0, %1\n\t"
-         : "=r"(result)
-         : "r"(input)
-        );
-    if (result != hope) {
-        printf("absq_s.qb error\n");
-        return -1;
-    }
-
-    input = 0x801BA35E;
-    hope  = 0x7F1B5D5E;
-
-    __asm
-        ("absq_s.qb %0, %2\n\t"
-         "rddsp %1\n\t"
-         : "=r"(result), "=r"(dsp)
-         : "r"(input)
-        );
-    dsp = dsp >> 20;
-    dsp &= 0x01;
-    if (result != hope) {
-        printf("absq_s.qb error\n");
-        return -1;
-    }
-
-    if (dsp != 1) {
-        printf("absq_s.qb error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/addqh_ph.c b/tests/tcg/mips/mips64-dspr2/addqh_ph.c
deleted file mode 100644
index 6b43cb8..0000000
--- a/tests/tcg/mips/mips64-dspr2/addqh_ph.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x706A13FE;
-    rt     = 0x13065174;
-    result = 0x41B832B9;
-    __asm
-        ("addqh.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (result != rd) {
-        printf("addqh.ph error!\n");
-        return -1;
-    }
-
-    rs     = 0x81000100;
-    rt     = 0xc2000100;
-    result = 0xffffffffa1800100;
-    __asm
-        ("addqh.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (result != rd) {
-        printf("addqh.ph error!\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/addqh_r_ph.c b/tests/tcg/mips/mips64-dspr2/addqh_r_ph.c
deleted file mode 100644
index 890ec98..0000000
--- a/tests/tcg/mips/mips64-dspr2/addqh_r_ph.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x706A13FE;
-    rt     = 0x13065174;
-    result = 0x41B832B9;
-    __asm
-        ("addqh_r.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("addqh_r.ph error\n");
-        return -1;
-    }
-
-    rs     = 0x81010100;
-    rt     = 0xc2000100;
-    result = 0xffffffffa1810100;
-    __asm
-        ("addqh_r.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("addqh_r.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/addqh_r_w.c b/tests/tcg/mips/mips64-dspr2/addqh_r_w.c
deleted file mode 100644
index d324dec..0000000
--- a/tests/tcg/mips/mips64-dspr2/addqh_r_w.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x00000010;
-    rt     = 0x00000001;
-    result = 0x00000009;
-
-    __asm
-        ("addqh_r.w  %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("addqh_r.w error!\n");
-        return -1;
-    }
-    rs     = 0xFFFFFFFE;
-    rt     = 0x00000001;
-    result = 0x00000000;
-
-    __asm
-        ("addqh_r.w  %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("addqh_r.w error!\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/addqh_w.c b/tests/tcg/mips/mips64-dspr2/addqh_w.c
deleted file mode 100644
index 78559e6..0000000
--- a/tests/tcg/mips/mips64-dspr2/addqh_w.c
+++ /dev/null
@@ -1,39 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x00000010;
-    rt     = 0x00000001;
-    result = 0x00000008;
-
-    __asm
-        ("addqh.w  %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("addqh.w wrong\n");
-        return -1;
-    }
-
-    rs     = 0xFFFFFFFE;
-    rt     = 0x00000001;
-    result = 0xFFFFFFFFFFFFFFFF;
-
-    __asm
-        ("addqh.w  %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    if (rd != result) {
-        printf("addqh.w wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/addu_ph.c b/tests/tcg/mips/mips64-dspr2/addu_ph.c
deleted file mode 100644
index d64c8cd..0000000
--- a/tests/tcg/mips/mips64-dspr2/addu_ph.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs     = 0x00FF00FF;
-    rt     = 0x00010001;
-    result = 0x01000100;
-    __asm
-        ("addu.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("1 addu.ph error\n");
-        return -1;
-    }
-
-    rs     = 0xFFFF1111;
-    rt     = 0x00020001;
-    result = 0x00011112;
-    __asm
-        ("addu.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((rd != result) || (((dsp >> 20) & 0x01) != 1)) {
-        printf("2 addu.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/addu_qh.c b/tests/tcg/mips/mips64-dspr2/addu_qh.c
deleted file mode 100644
index edcbf34..0000000
--- a/tests/tcg/mips/mips64-dspr2/addu_qh.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dspreg;
-    long long result, dspresult;
-
-    rs = 0x123456787FFF0000;
-    rt = 0x1111111180000000;
-    result = 0x23456789FFFF0000;
-    dspresult = 0x0;
-
-    __asm("addu.qh %0, %2, %3\n\t"
-          "rddsp %1\n\t"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("addu.qh error\n");
-        return -1;
-    }
-
-    rs = 0x123456787FFF0000;
-    rt = 0x1111111180020000;
-    result = 0x23456789FFFF0000;
-    dspresult = 0x01;
-
-    __asm("addu.qh %0, %2, %3\n\t"
-          "rddsp %1\n\t"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("addu.qh overflow error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/addu_s_ph.c b/tests/tcg/mips/mips64-dspr2/addu_s_ph.c
deleted file mode 100644
index 9250edb..0000000
--- a/tests/tcg/mips/mips64-dspr2/addu_s_ph.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs     = 0x00FE00FE;
-    rt     = 0x00020001;
-    result = 0x010000FF;
-    __asm
-        ("addu_s.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("addu_s.ph error\n");
-        return -1;
-    }
-
-    rs     = 0xFFFF1111;
-    rt     = 0x00020001;
-    result = 0xFFFFFFFFFFFF1112;
-    __asm
-        ("addu_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((rd != result) || (((dsp >> 20) & 0x01) != 1)) {
-        printf("addu_s.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/addu_s_qh.c b/tests/tcg/mips/mips64-dspr2/addu_s_qh.c
deleted file mode 100644
index b0c1626..0000000
--- a/tests/tcg/mips/mips64-dspr2/addu_s_qh.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dspreg;
-    long long result, dspresult;
-
-    rs = 0x123456787FFF0000;
-    rt = 0x1111111180000000;
-    result = 0x23456789FFFF0000;
-    dspresult = 0x0;
-
-    __asm("addu_s.qh %0, %2, %3\n\t"
-          "rddsp %1\n\t"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("1 addu_s.qh error\n");
-        return -1;
-    }
-
-    rs = 0x12345678FFFF0000;
-    rt = 0x11111111000F0000;
-    result = 0x23456789FFFF0000;
-    dspresult = 0x01;
-
-    __asm("addu_s.qh %0, %2, %3\n\t"
-          "rddsp %1\n\t"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("2 addu_s.qh error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/adduh_ob.c b/tests/tcg/mips/mips64-dspr2/adduh_ob.c
deleted file mode 100644
index 9b309f6..0000000
--- a/tests/tcg/mips/mips64-dspr2/adduh_ob.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result;
-    rs = 0xFF987CDEBCEF2356;
-    rt = 0xFF987CDEBCEF2354;
-    result = 0xFF987CDEBCEF2355;
-
-    __asm("adduh.ob %0, %1, %2\n\t"
-          : "=r"(rd)
-          : "r"(rs), "r"(rt)
-         );
-
-    if (rd != result) {
-        printf("adduh.ob error\n\t");
-        return -1;
-    }
-
-    rs = 0xac50691729945316;
-    rt = 0xb9234ca3f5573162;
-    result = 0xb2395a5d8f75423c;
-
-    __asm("adduh.ob %0, %1, %2\n\t"
-          : "=r"(rd)
-          : "r"(rs), "r"(rt)
-         );
-
-    if (rd != result) {
-        printf("adduh.ob error\n\t");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/adduh_qb.c b/tests/tcg/mips/mips64-dspr2/adduh_qb.c
deleted file mode 100644
index 796b409..0000000
--- a/tests/tcg/mips/mips64-dspr2/adduh_qb.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0xFF0055AA;
-    rt     = 0x0113421B;
-    result = 0xffffffff80094B62;
-    __asm
-        ("adduh.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("adduh.qb error\n");
-        return -1;
-    }
-    rs     = 0xFFFF0FFF;
-    rt     = 0x00010111;
-    result = 0x7F800888;
-
-    __asm
-        ("adduh.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("adduh.qb error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/adduh_r_ob.c b/tests/tcg/mips/mips64-dspr2/adduh_r_ob.c
deleted file mode 100644
index 832de83..0000000
--- a/tests/tcg/mips/mips64-dspr2/adduh_r_ob.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result;
-    rs = 0xFF987CDEBCEF2356;
-    rt = 0xFF987CDEBCEF2355;
-    result = 0xFF987CDEBCEF2356;
-
-    __asm("adduh_r.ob %0, %1, %2\n\t"
-          : "=r"(rd)
-          : "r"(rs), "r"(rt)
-         );
-
-    if (rd != result) {
-        printf("1 adduh_r.ob error\n\t");
-        return -1;
-    }
-
-    rs = 0xac50691729945316;
-    rt = 0xb9234ca3f5573162;
-    result = 0xb33a5b5d8f76423c;
-
-    __asm("adduh_r.ob %0, %1, %2\n\t"
-          : "=r"(rd)
-          : "r"(rs), "r"(rt)
-         );
-
-    if (rd != result) {
-        printf("2 adduh_r.ob error\n\t");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/adduh_r_qb.c b/tests/tcg/mips/mips64-dspr2/adduh_r_qb.c
deleted file mode 100644
index ae65fa5..0000000
--- a/tests/tcg/mips/mips64-dspr2/adduh_r_qb.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0xFF0055AA;
-    rt     = 0x01112211;
-    result = 0xffffffff80093C5E;
-    __asm
-        ("adduh_r.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("adduh_r.qb error\n");
-        return -1;
-    }
-
-    rs     = 0xFFFF0FFF;
-    rt     = 0x00010111;
-    result = 0xffffffff80800888;
-    __asm
-        ("adduh_r.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("adduh_r.qb error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/append.c b/tests/tcg/mips/mips64-dspr2/append.c
deleted file mode 100644
index 68a7cec..0000000
--- a/tests/tcg/mips/mips64-dspr2/append.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long result;
-
-    rs     = 0xFF0055AA;
-    rt     = 0x0113421B;
-    result = 0x02268436;
-    __asm
-        ("append %0, %1, 0x01\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    if (rt != result) {
-        printf("append error\n");
-        return -1;
-    }
-
-    rs     = 0xFFFF0FFF;
-    rt     = 0x00010111;
-    result = 0x0010111F;
-    __asm
-        ("append %0, %1, 0x04\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    if (rt != result) {
-        printf("append error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/balign.c b/tests/tcg/mips/mips64-dspr2/balign.c
deleted file mode 100644
index 7fbe815..0000000
--- a/tests/tcg/mips/mips64-dspr2/balign.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long result;
-
-    rs     = 0xFF0055AA;
-    rt     = 0x0113421B;
-    result = 0x13421BFF;
-    __asm
-        ("balign %0, %1, 0x01\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    if (rt != result) {
-        printf("balign error\n");
-        return -1;
-    }
-
-    rs     = 0xFFFF0FFF;
-    rt     = 0x00010111;
-    result = 0x11FFFF0F;
-    __asm
-        ("balign %0, %1, 0x03\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    if (rt != result) {
-        printf("balign error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_eq_ob.c b/tests/tcg/mips/mips64-dspr2/cmpgdu_eq_ob.c
deleted file mode 100644
index 61217f3..0000000
--- a/tests/tcg/mips/mips64-dspr2/cmpgdu_eq_ob.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    result = 0xFE;
-    dspresult = 0xFE;
-
-    __asm("cmpgdu.eq.ob %0, %2, %3\n\t"
-          "rddsp %1"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 24) & 0xFF);
-
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("1 cmpgdu.eq.ob error\n");
-        return -1;
-    }
-
-    rs = 0x133256789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    result = 0x3E;
-    dspresult = 0x3E;
-
-    __asm("cmpgdu.eq.ob %0, %2, %3\n\t"
-          "rddsp %1"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 24) & 0xFF);
-
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("2 cmpgdu.eq.ob error\n");
-        return -1;
-    }
-
-   return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_eq_qb.c b/tests/tcg/mips/mips64-dspr2/cmpgdu_eq_qb.c
deleted file mode 100644
index c63f648..0000000
--- a/tests/tcg/mips/mips64-dspr2/cmpgdu_eq_qb.c
+++ /dev/null
@@ -1,41 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs         = 0x11777066;
-    rt         = 0x55AA70FF;
-    result     = 0x02;
-    __asm
-        ("cmpgdu.eq.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if ((rd != result) || (dsp != result)) {
-        printf("cmpgdu.eq.qb error\n");
-        return -1;
-    }
-
-    rs     = 0x11777066;
-    rt     = 0x11777066;
-    result = 0x0F;
-    __asm
-        ("cmpgdu.eq.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-
-    if ((rd != result) || (dsp != result)) {
-        printf("cmpgdu.eq.qb error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_le_ob.c b/tests/tcg/mips/mips64-dspr2/cmpgdu_le_ob.c
deleted file mode 100644
index b3da098..0000000
--- a/tests/tcg/mips/mips64-dspr2/cmpgdu_le_ob.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-
-    rs = 0x123456789abcdef0;
-    rt = 0x123456789abcdeff;
-    dspresult = 0xff;
-    result = 0xff;
-
-    __asm("cmpgdu.le.ob %0, %2, %3\n\t"
-          "rddsp %1"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 24) & 0xff);
-
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("cmpgdu.le.ob error\n");
-        return -1;
-    }
-
-    rs = 0x113556789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    result = 0xBE;
-    dspresult = 0xFE;
-
-    __asm("cmpgdu.eq.ob %0, %2, %3\n\t"
-          "rddsp %1"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 24) & 0xFF);
-
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("cmpgdu.eq.ob error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_le_qb.c b/tests/tcg/mips/mips64-dspr2/cmpgdu_le_qb.c
deleted file mode 100644
index f0a60ea..0000000
--- a/tests/tcg/mips/mips64-dspr2/cmpgdu_le_qb.c
+++ /dev/null
@@ -1,48 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs         = 0x11777066;
-    rt         = 0x55AA70FF;
-    result     = 0x0F;
-    __asm
-        ("cmpgdu.le.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if (rd  != result) {
-        printf("cmpgdu.le.qb error\n");
-        return -1;
-    }
-    if (dsp != result) {
-        printf("cmpgdu.le.qb error\n");
-        return -1;
-    }
-
-    rs     = 0x11777066;
-    rt     = 0x11707066;
-    result = 0x0B;
-    __asm
-        ("cmpgdu.le.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if (rd  != result) {
-        printf("cmpgdu.le.qb error\n");
-        return -1;
-    }
-    if (dsp != result) {
-        printf("cmpgdu.le.qb error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_lt_ob.c b/tests/tcg/mips/mips64-dspr2/cmpgdu_lt_ob.c
deleted file mode 100644
index d80b4e6..0000000
--- a/tests/tcg/mips/mips64-dspr2/cmpgdu_lt_ob.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result, dspreg, dspresult;
-
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x01;
-    result = 0x01;
-
-    __asm("cmpgdu.lt.ob %0, %2, %3\n\t"
-          "rddsp %1"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 24) & 0xFF);
-
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("cmpgdu.lt.ob error\n");
-        return -1;
-    }
-
-    rs = 0x143356789ABCDEF0;
-    rt = 0x123456789ABCDEFF;
-    dspresult = 0x41;
-    result = 0x41;
-
-    __asm("cmpgdu.lt.ob %0, %2, %3\n\t"
-          "rddsp %1"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 24) & 0xFF);
-
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("cmpgdu.lt.ob error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_lt_qb.c b/tests/tcg/mips/mips64-dspr2/cmpgdu_lt_qb.c
deleted file mode 100644
index a71e4e3..0000000
--- a/tests/tcg/mips/mips64-dspr2/cmpgdu_lt_qb.c
+++ /dev/null
@@ -1,48 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long dsp;
-    long long result;
-
-    rs         = 0x11777066;
-    rt         = 0x55AA70FF;
-    result     = 0x0D;
-    __asm
-        ("cmpgdu.lt.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if (rd  != result) {
-        printf("cmpgdu.lt.qb error\n");
-        return -1;
-    }
-    if (dsp != result) {
-        printf("cmpgdu.lt.qb error\n");
-        return -1;
-    }
-
-    rs     = 0x11777066;
-    rt     = 0x11777066;
-    result = 0x00;
-    __asm
-        ("cmpgdu.lt.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    if (rd  != result) {
-        printf("cmpgdu.lt.qb error\n");
-        return -1;
-    }
-    if (dsp != result) {
-        printf("cmpgdu.lt.qb error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dbalign.c b/tests/tcg/mips/mips64-dspr2/dbalign.c
deleted file mode 100644
index c7431b1..0000000
--- a/tests/tcg/mips/mips64-dspr2/dbalign.c
+++ /dev/null
@@ -1,39 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rt, rs;
-    long long res;
-
-    rt = 0x1234567887654321;
-    rs = 0xabcd1234abcd1234;
-
-    res = 0x34567887654321ab;
-
-    asm ("dbalign %0, %1, 0x1\n"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("dbalign error\n");
-        return -1;
-    }
-
-    rt = 0x1234567887654321;
-    rs = 0xabcd1234abcd1234;
-
-    res = 0x7887654321abcd12;
-
-    asm ("dbalign %0, %1, 0x3\n"
-         : "=r"(rt)
-         : "r"(rs)
-        );
-
-    if (rt != res) {
-        printf("dbalign error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dpa_w_ph.c b/tests/tcg/mips/mips64-dspr2/dpa_w_ph.c
deleted file mode 100644
index 39dc99a..0000000
--- a/tests/tcg/mips/mips64-dspr2/dpa_w_ph.c
+++ /dev/null
@@ -1,47 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl;
-
-    rs = 0x00FF00FF;
-    rt = 0x00010002;
-    resulth = 0x05;
-    resultl = 0x0302;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpa.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("1 dpa.w.ph error\n");
-        return -1;
-    }
-
-    ach = 6, acl = 7;
-    rs = 0xFFFF00FF;
-    rt = 0xFFFF0002;
-    resulth = 0x05;
-    resultl = 0xfffffffffffe0206;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpa.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if ((ach != resulth) || (acl != resultl)) {
-        printf("2 dpa.w.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dpa_w_qh.c b/tests/tcg/mips/mips64-dspr2/dpa_w_qh.c
deleted file mode 100644
index 1411e44..0000000
--- a/tests/tcg/mips/mips64-dspr2/dpa_w_qh.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#include"io.h"
-int main(void)
-{
-    long long rt, rs;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resh, resl;
-
-    achi = 0x1;
-    acli = 0x1;
-
-    rs = 0x0001000100010001;
-    rt = 0x0002000200020002;
-
-    resh = 0x1;
-    resl = 0x9;
-
-    asm("mthi %2, $ac1\t\n"
-        "mtlo %3, $ac1\t\n"
-        "dpa.w.qh $ac1, %4, %5\t\n"
-        "mfhi %0, $ac1\t\n"
-        "mflo %1, $ac1\t\n"
-        : "=r"(acho), "=r"(aclo)
-        : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-       );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dpa.w.qh error\n");
-        return -1;
-    }
-
-
-    achi = 0xffffffff;
-    acli = 0xaaaaaaaa;
-
-    rs = 0xaaaabbbbccccdddd;
-    rt = 0x7777888899996666;
-
-    resh = 0xffffffffffffffff;
-    resl = 0x320cdf02;
-
-    asm("mthi %2, $ac1\t\n"
-        "mtlo %3, $ac1\t\n"
-        "dpa.w.qh $ac1, %4, %5\t\n"
-        "mfhi %0, $ac1\t\n"
-        "mflo %1, $ac1\t\n"
-        : "=r"(acho), "=r"(aclo)
-        : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-       );
-    if ((acho != resh) || (aclo != resl)) {
-        printf("2 dpa.w.qh error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dpaqx_s_w_ph.c b/tests/tcg/mips/mips64-dspr2/dpaqx_s_w_ph.c
deleted file mode 100644
index 51252fb..0000000
--- a/tests/tcg/mips/mips64-dspr2/dpaqx_s_w_ph.c
+++ /dev/null
@@ -1,97 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt, dsp;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl, resultdsp;
-
-    rs     = 0x800000FF;
-    rt     = 0x00018000;
-    resulth = 0x05;
-    resultl = 0xFFFFFFFF80000202;
-    resultdsp = 0x01;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpaqx_s.w.ph $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if (dsp != resultdsp) {
-        printf("dpaqx_s.w.ph error\n");
-        return -1;
-    }
-    if (ach != resulth) {
-        printf("dpaqx_s.w.ph error\n");
-        return -1;
-    }
-    if (acl != resultl) {
-        printf("dpaqx_s.w.ph error\n");
-        return -1;
-    }
-
-    ach    = 5;
-    acl    = 5;
-    rs     = 0x00FF00FF;
-    rt     = 0x00010002;
-    resulth = 0x05;
-    resultl = 0x05FF;
-    /***********************************************************
-     * Because of we set outflag at last time, although this
-     * time we set nothing, but it is stay the last time value.
-     **********************************************************/
-    resultdsp = 0x01;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpaqx_s.w.ph $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if (dsp != resultdsp) {
-        printf("dpaqx_s.w.ph error\n");
-        return -1;
-    }
-    if (ach != resulth) {
-        printf("dpaqx_s.w.ph error\n");
-        return -1;
-    }
-    if (acl != resultl) {
-        printf("dpaqx_s.w.ph error\n");
-        return -1;
-    }
-
-    ach    = 5;
-    acl    = 5;
-    rs     = 0x800000FF;
-    rt     = 0x00028000;
-    resulth = 0x05;
-    resultl = 0xffffffff80000400;
-    resultdsp = 0x01;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpaqx_s.w.ph $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if ((dsp != resultdsp) || (ach != resulth) || (acl != resultl)) {
-        printf("dpaqx_s.w.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dpaqx_sa_w_ph.c b/tests/tcg/mips/mips64-dspr2/dpaqx_sa_w_ph.c
deleted file mode 100644
index 18d6b3a..0000000
--- a/tests/tcg/mips/mips64-dspr2/dpaqx_sa_w_ph.c
+++ /dev/null
@@ -1,54 +0,0 @@
-#include "io.h"
-
-int main()
-{
-    long long rs, rt, dsp;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl, resultdsp;
-
-    rs     = 0x00FF00FF;
-    rt     = 0x00010002;
-    resulth = 0x00;
-    resultl = 0x7FFFFFFF;
-    resultdsp = 0x01;
-    __asm
-        ("wrdsp %2\n\t"
-         "mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpaqx_sa.w.ph $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "+r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((dsp >> (16 + 1) != resultdsp) || (ach != resulth) ||
-        (acl != resultl)) {
-        printf("dpaqx_sa.w.ph errror\n");
-    }
-
-    ach = 9;
-    acl = 0xb;
-    rs     = 0x800000FF;
-    rt     = 0x00018000;
-    resulth = 0x00;
-    resultl = 0x7fffffff;
-    resultdsp = 0x01;
-    __asm
-        ("wrdsp %2\n\t"
-         "mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpaqx_sa.w.ph $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "+r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    if ((dsp >> (16 + 1) != resultdsp) || (ach != resulth) ||
-        (acl != resultl)) {
-        printf("dpaqx_sa.w.ph errror\n");
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dpax_w_ph.c b/tests/tcg/mips/mips64-dspr2/dpax_w_ph.c
deleted file mode 100644
index 9d595fc..0000000
--- a/tests/tcg/mips/mips64-dspr2/dpax_w_ph.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long rs, rt;
-    long ach = 5, acl = 5;
-    long resulth, resultl;
-
-    rs     = 0x00FF00FF;
-    rt     = 0x00010002;
-    resulth = 0x05;
-    resultl = 0x0302;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpax.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if (ach != resulth) {
-        printf("dpax.w.ph error\n");
-        return -1;
-    }
-    if (acl != resultl) {
-        printf("dpax.w.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dps_w_ph.c b/tests/tcg/mips/mips64-dspr2/dps_w_ph.c
deleted file mode 100644
index 99f292e..0000000
--- a/tests/tcg/mips/mips64-dspr2/dps_w_ph.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl;
-
-    rs     = 0x00FF00FF;
-    rt     = 0x00010002;
-    resulth = 0x04;
-    resultl = 0xFFFFFFFFFFFFFFD08;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dps.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if (ach != resulth || acl != resultl) {
-        printf("dps.w.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dps_w_qh.c b/tests/tcg/mips/mips64-dspr2/dps_w_qh.c
deleted file mode 100644
index 61277eb..0000000
--- a/tests/tcg/mips/mips64-dspr2/dps_w_qh.c
+++ /dev/null
@@ -1,55 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long achi, acli;
-    long long acho, aclo;
-    long long resh, resl;
-
-    rs = 0x0000000100000001;
-    rt = 0x0000000200000002;
-    achi = 0x1;
-    acli = 0x8;
-
-    resh = 0x1;
-    resl = 0x4;
-
-    asm ("mthi %2, $ac1\t\n"
-         "mtlo %3, $ac1\t\n"
-         "dps.w.qh $ac1, %4, %5\t\n"
-         "mfhi %0, $ac1\t\n"
-         "mflo %1, $ac1\t\n"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dps.w.qh error\n");
-        return -1;
-    }
-
-    rs = 0xaaaabbbbccccdddd;
-    rt = 0xaaaabbbbccccdddd;
-
-    achi = 0x88888888;
-    achi = 0x55555555;
-
-    resh = 0xfffffffff7777777;
-    resl = 0x0a38b181;
-
-    asm ("mthi %2, $ac1\t\n"
-         "mtlo %3, $ac1\t\n"
-         "dps.w.qh $ac1, %4, %5\t\n"
-         "mfhi %0, $ac1\t\n"
-         "mflo %1, $ac1\t\n"
-         : "=r"(acho), "=r"(aclo)
-         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
-        );
-
-    if ((acho != resh) || (aclo != resl)) {
-        printf("1 dps.w.qh error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dpsqx_s_w_ph.c b/tests/tcg/mips/mips64-dspr2/dpsqx_s_w_ph.c
deleted file mode 100644
index ba46a92..0000000
--- a/tests/tcg/mips/mips64-dspr2/dpsqx_s_w_ph.c
+++ /dev/null
@@ -1,55 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt, dsp;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl, resultdsp;
-
-    rs = 0xBC0123AD;
-    rt = 0x01643721;
-    resulth = 0x04;
-    resultl = 0xFFFFFFFFAEA3E09B;
-    resultdsp = 0x00;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsqx_s.w.ph $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if (dsp != resultdsp || ach != resulth || acl != resultl) {
-        printf("dpsqx_s.w.ph error\n");
-        return -1;
-    }
-
-    ach = 0x99f13005;
-    acl = 0x51730062;
-    rs = 0x80008000;
-    rt = 0x80008000;
-
-    resulth = 0xffffffff99f13004;
-    resultl = 0x51730064;
-    resultdsp = 0x01;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsqx_s.w.ph $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if (dsp != resultdsp || ach != resulth || acl != resultl) {
-        printf("dpsqx_s.w.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dpsqx_sa_w_ph.c b/tests/tcg/mips/mips64-dspr2/dpsqx_sa_w_ph.c
deleted file mode 100644
index 24c8881..0000000
--- a/tests/tcg/mips/mips64-dspr2/dpsqx_sa_w_ph.c
+++ /dev/null
@@ -1,53 +0,0 @@
-#include"io.h"
-int main()
-{
-    long long rs, rt, dsp;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl, resultdsp;
-
-    rs = 0xBC0123AD;
-    rt = 0x01643721;
-    resulth = 0x00;
-    resultl = 0x7FFFFFFF;
-    resultdsp = 0x01;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsqx_sa.w.ph $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if (dsp != resultdsp || ach != resulth || acl != resultl) {
-        printf("dpsqx_sa.w.ph error\n");
-        return -1;
-    }
-
-    ach = 0x8c0b354A;
-    acl = 0xbbc02249;
-    rs      = 0x800023AD;
-    rt      = 0x01648000;
-    resulth = 0xffffffffffffffff;
-    resultl = 0xffffffff80000000;
-    resultdsp = 0x01;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsqx_sa.w.ph $ac1, %3, %4\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         "rddsp %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    if (dsp != resultdsp || ach != resulth || acl != resultl) {
-        printf("dpsqx_sa.w.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/dpsx_w_ph.c b/tests/tcg/mips/mips64-dspr2/dpsx_w_ph.c
deleted file mode 100644
index b6291b5..0000000
--- a/tests/tcg/mips/mips64-dspr2/dpsx_w_ph.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long ach = 5, acl = 5;
-    long long resulth, resultl;
-
-    rs      = 0xBC0123AD;
-    rt      = 0x01643721;
-    resulth = 0x04;
-    resultl = 0xFFFFFFFFD751F050;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsx.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if (ach != resulth || acl != resultl) {
-        printf("dpsx.w.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
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
diff --git a/tests/tcg/mips/mips64-dspr2/mul_ph.c b/tests/tcg/mips/mips64-dspr2/mul_ph.c
deleted file mode 100644
index 5a3d05c..0000000
--- a/tests/tcg/mips/mips64-dspr2/mul_ph.c
+++ /dev/null
@@ -1,50 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x03FB1234;
-    rt = 0x0BCC4321;
-    result = 0xFFFFFFFFF504F4B4;
-    resultdsp = 1;
-
-    __asm
-        ("mul.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if (rd  != result || dsp != resultdsp) {
-        printf("mul.ph wrong\n");
-        return -1;
-    }
-
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 0x00210010;
-    rt = 0x00110005;
-    result = 0x2310050;
-    resultdsp = 0;
-
-    __asm
-        ("mul.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if (rd  != result || dsp != resultdsp) {
-        printf("mul.ph wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/mul_s_ph.c b/tests/tcg/mips/mips64-dspr2/mul_s_ph.c
deleted file mode 100644
index 7c8b2c7..0000000
--- a/tests/tcg/mips/mips64-dspr2/mul_s_ph.c
+++ /dev/null
@@ -1,67 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x03FB1234;
-    rt = 0x0BCC4321;
-    result = 0x7fff7FFF;
-    resultdsp = 1;
-
-    __asm
-        ("mul_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if (rd != result || dsp != resultdsp) {
-        printf("1 mul_s.ph error\n");
-        return -1;
-    }
-
-    rs = 0x7fffff00;
-    rt = 0xff007fff;
-    result = 0xffffffff80008000;
-    resultdsp = 1;
-
-    __asm
-        ("mul_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if (rd != result || dsp != resultdsp) {
-        printf("2 mul_s.ph error\n");
-        return -1;
-    }
-
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 0x00320001;
-    rt = 0x00210002;
-    result = 0x06720002;
-    resultdsp = 0;
-
-    __asm
-        ("mul_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if (rd != result || dsp != resultdsp) {
-        printf("3 mul_s.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/mulq_rs_w.c b/tests/tcg/mips/mips64-dspr2/mulq_rs_w.c
deleted file mode 100644
index ffdc66d..0000000
--- a/tests/tcg/mips/mips64-dspr2/mulq_rs_w.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x80001234;
-    rt = 0x80004321;
-    result = 0xFFFFFFFF80005555;
-
-    __asm
-        ("mulq_rs.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("mulq_rs.w error!\n");
-        return -1;
-    }
-
-    rs = 0x80000000;
-    rt = 0x80000000;
-    result = 0x7FFFFFFF;
-    resultdsp = 1;
-
-    __asm
-        ("mulq_rs.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if (rd != result || dsp != resultdsp) {
-        printf("mulq_rs.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/mulq_s_ph.c b/tests/tcg/mips/mips64-dspr2/mulq_s_ph.c
deleted file mode 100644
index b8c20c6..0000000
--- a/tests/tcg/mips/mips64-dspr2/mulq_s_ph.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x80001234;
-    rt = 0x80004321;
-    result = 0x7FFF098B;
-    resultdsp = 1;
-
-    __asm
-        ("mulq_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if (rd  != result || dsp != resultdsp) {
-        printf("mulq_s.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/mulq_s_w.c b/tests/tcg/mips/mips64-dspr2/mulq_s_w.c
deleted file mode 100644
index db74b71..0000000
--- a/tests/tcg/mips/mips64-dspr2/mulq_s_w.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x80001234;
-    rt = 0x80004321;
-    result = 0xFFFFFFFF80005555;
-
-    __asm
-        ("mulq_s.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("mulq_s.w error\n");
-        return -1;
-    }
-
-    rs = 0x80000000;
-    rt = 0x80000000;
-    result = 0x7FFFFFFF;
-    resultdsp = 1;
-
-    __asm
-        ("mulq_s.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    if (rd != result || dsp != resultdsp) {
-        printf("mulq_s.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/mulsa_w_ph.c b/tests/tcg/mips/mips64-dspr2/mulsa_w_ph.c
deleted file mode 100644
index 5b22a60..0000000
--- a/tests/tcg/mips/mips64-dspr2/mulsa_w_ph.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt, ach, acl;
-    long long resulth, resultl;
-
-    ach = 0x05;
-    acl = 0x00BBDDCC;
-    rs = 0x80001234;
-    rt = 0x80004321;
-    resulth = 0x05;
-    resultl = 0x3BF5E918;
-
-    __asm
-        ("mthi %0, $ac1\n\t"
-         "mtlo %1, $ac1\n\t"
-         "mulsa.w.ph $ac1, %2, %3\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if (ach != resulth || acl != resultl) {
-        printf("mulsa.w.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/mulsaq_s_w_ph.c b/tests/tcg/mips/mips64-dspr2/mulsaq_s_w_ph.c
deleted file mode 100644
index 835a73d..0000000
--- a/tests/tcg/mips/mips64-dspr2/mulsaq_s_w_ph.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt, ach, acl;
-    long long resulth, resultl;
-
-    ach = 0x05;
-    acl = 0x00BBDDCC;
-    rs = 0x80001234;
-    rt = 0x80004321;
-    resulth = 0x05;
-    resultl = 0x772ff463;
-
-    __asm
-        ("mthi %0, $ac1\n\t"
-         "mtlo %1, $ac1\n\t"
-         "mulsaq_s.w.ph $ac1, %2, %3\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    if (ach != resulth || acl != resultl) {
-        printf("mulsaq_s.w.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/precr_qb_ph.c b/tests/tcg/mips/mips64-dspr2/precr_qb_ph.c
deleted file mode 100644
index 80d5e8d..0000000
--- a/tests/tcg/mips/mips64-dspr2/precr_qb_ph.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include"io.h"
-
-int main()
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x34786521;
-
-    __asm
-        ("precr.qb.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (result != rd) {
-        printf("precr.qb.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/precr_sra_ph_w.c b/tests/tcg/mips/mips64-dspr2/precr_sra_ph_w.c
deleted file mode 100644
index b1d7bcd..0000000
--- a/tests/tcg/mips/mips64-dspr2/precr_sra_ph_w.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x43215678;
-
-    __asm
-        ("precr_sra.ph.w %0, %1, 0x00\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    if (result != rt) {
-        printf("precr_sra.ph.w error\n");
-        return -1;
-    }
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0xFFFFFFFFFFFF0000;
-
-    __asm
-        ("precr_sra.ph.w %0, %1, 0x1F\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    if (result != rt) {
-        printf("precr_sra.ph.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/precr_sra_r_ph_w.c b/tests/tcg/mips/mips64-dspr2/precr_sra_r_ph_w.c
deleted file mode 100644
index 62d220d..0000000
--- a/tests/tcg/mips/mips64-dspr2/precr_sra_r_ph_w.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x43215678;
-
-    __asm
-        ("precr_sra_r.ph.w %0, %1, 0x00\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    if (result != rt) {
-        printf("precr_sra_r.ph.w error\n");
-        return -1;
-    }
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0xFFFFFFFFFFFF0000;
-
-    __asm
-        ("precr_sra_r.ph.w %0, %1, 0x1F\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    if (result != rt) {
-        printf("precr_sra_r.ph.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/prepend.c b/tests/tcg/mips/mips64-dspr2/prepend.c
deleted file mode 100644
index 4ab083e..0000000
--- a/tests/tcg/mips/mips64-dspr2/prepend.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0xFFFFFFFF87654321;
-    __asm
-        ("prepend %0, %1, 0x00\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    if (rt != result) {
-        printf("prepend error\n");
-        return -1;
-    }
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0xFFFFFFFFACF10ECA;
-    __asm
-        ("prepend %0, %1, 0x0F\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    if (rt != result) {
-        printf("prepend error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/printf.c b/tests/tcg/mips/mips64-dspr2/printf.c
deleted file mode 100644
index cf8676d..0000000
--- a/tests/tcg/mips/mips64-dspr2/printf.c
+++ /dev/null
@@ -1,266 +0,0 @@
-
-typedef unsigned long va_list;
-
-#define ACC    4
-#define __read(source)                    \
-({ va_list __res;                    \
-    __asm__ __volatile__(                \
-        "move\t%0, " #source "\n\t"        \
-        : "=r" (__res));            \
-    __res;                        \
-})
-
-enum format_type {
-    FORMAT_TYPE_NONE,
-    FORMAT_TYPE_HEX,
-    FORMAT_TYPE_ULONG,
-    FORMAT_TYPE_FLOAT
-};
-
-struct printf_spec {
-    char    type;
-};
-
-static int format_decode(char *fmt, struct printf_spec *spec)
-{
-    char *start = fmt;
-
-    for (; *fmt ; ++fmt) {
-        if (*fmt == '%') {
-            break;
-        }
-    }
-
-    switch (*++fmt) {
-    case 'x':
-        spec->type = FORMAT_TYPE_HEX;
-        break;
-
-    case 'd':
-        spec->type = FORMAT_TYPE_ULONG;
-        break;
-
-    case 'f':
-        spec->type = FORMAT_TYPE_FLOAT;
-        break;
-
-    default:
-        spec->type = FORMAT_TYPE_NONE;
-    }
-
-    return ++fmt - start;
-}
-
-void *memcpy(void *dest, void *src, int n)
-{
-    int i;
-    char *s = src;
-    char *d = dest;
-
-    for (i = 0; i < n; i++) {
-        d[i] = s[i];
-    }
-    return dest;
-}
-
-char *number(char *buf, va_list num)
-{
-    int i;
-    char *str = buf;
-    static char digits[16] = "0123456789abcdef";
-    str = str + sizeof(num) * 2;
-
-    for (i = 0; i < sizeof(num) * 2; i++) {
-        *--str = digits[num & 15];
-        num >>= 4;
-    }
-
-    return buf + sizeof(num) * 2;
-}
-
-char *__number(char *buf, va_list num)
-{
-    int i;
-    va_list mm = num;
-    char *str = buf;
-
-    if (!num) {
-        *str++ = '0';
-        return str;
-    }
-
-    for (i = 0; mm; mm = mm/10, i++) {
-        /* Do nothing. */
-    }
-
-    str = str + i;
-
-    while (num) {
-        *--str = num % 10 + 48;
-        num = num / 10;
-    }
-
-    return str + i;
-}
-
-va_list modf(va_list args, va_list *integer, va_list *num)
-{
-    int i;
-    double dot_v = 0;
-    va_list E, DOT, DOT_V;
-
-    if (!args) {
-        return 0;
-    }
-
-    for (i = 0, args = args << 1 >> 1; i < 52; i++) {
-        if ((args >> i) & 0x1) {
-            break;
-        }
-    }
-
-    *integer = 0;
-
-    if ((args >> 56 != 0x3f) || (args >> 52 == 0x3ff)) {
-        E = (args >> 52) - 1023;
-        DOT = 52 - E - i;
-        DOT_V = args << (12 + E) >> (12 + E) >> i;
-        *integer = ((args << 12 >> 12) >> (i + DOT)) | (1 << E);
-    } else {
-        E = ~((args >> 52) - 1023) + 1;
-        DOT_V = args << 12 >> 12;
-
-        dot_v += 1.0 / (1 << E);
-
-        for (i = 1; i <= 16; i++) {
-            if ((DOT_V >> (52 - i)) & 0x1) {
-                dot_v += 1.0 / (1 << E + i);
-            }
-        }
-
-        for (i = 1, E = 0; i <= ACC; i++) {
-            dot_v *= 10;
-            if (!(va_list)dot_v) {
-                E++;
-            }
-    }
-
-    *num = E;
-
-    return dot_v;
-    }
-
-    if (args & 0xf) {
-        for (i = 1; i <= 16; i++) {
-            if ((DOT_V >> (DOT - i)) & 0x1) {
-                dot_v += 1.0 / (1 << i);
-            }
-        }
-
-        for (i = 1, E = 0; i <= ACC; i++) {
-            dot_v *= 10;
-            if (!(va_list)dot_v) {
-                E++;
-            }
-        }
-
-        *num = E;
-
-        return dot_v;
-    } else if (DOT) {
-        for (i = 1; i <= DOT; i++) {
-            if ((DOT_V >> (DOT - i)) & 0x1) {
-                dot_v += 1.0 / (1 << i);
-            }
-        }
-
-        for (i = 1; i <= ACC; i++) {
-            dot_v = dot_v * 10;
-        }
-
-    return dot_v;
-    }
-
-    return 0;
-}
-
-int vsnprintf(char *buf, int size, char *fmt, va_list args)
-{
-    char *str, *mm;
-    struct printf_spec spec = {0};
-
-    str = mm = buf;
-
-    while (*fmt) {
-        char *old_fmt = fmt;
-        int read = format_decode(fmt, &spec);
-
-        fmt += read;
-
-        switch (spec.type) {
-        case FORMAT_TYPE_NONE: {
-            memcpy(str, old_fmt, read);
-            str += read;
-            break;
-        }
-        case FORMAT_TYPE_HEX: {
-            memcpy(str, old_fmt, read);
-            str = number(str + read, args);
-            for (; *mm ; ++mm) {
-                if (*mm == '%') {
-                    *mm = '0';
-                break;
-                }
-            }
-        break;
-        }
-        case FORMAT_TYPE_ULONG: {
-            memcpy(str, old_fmt, read - 2);
-            str = __number(str + read - 2, args);
-            break;
-        }
-        case FORMAT_TYPE_FLOAT: {
-            va_list integer, dot_v, num;
-            dot_v = modf(args, &integer, &num);
-            memcpy(str, old_fmt, read - 2);
-            str += read - 2;
-            if ((args >> 63 & 0x1)) {
-                *str++ = '-';
-            }
-            str = __number(str, integer);
-            if (dot_v) {
-                *str++ = '.';
-                while (num--) {
-                    *str++ = '0';
-                }
-                str = __number(str, dot_v);
-            }
-            break;
-        }
-        }
-    }
-    *str = '\0';
-
-    return str - buf;
-}
-
-static void serial_out(char *str)
-{
-    while (*str) {
-        *(char *)0xffffffffb80003f8 = *str++;
-    }
-}
-
-int vprintf(char *fmt, va_list args)
-{
-    int printed_len = 0;
-    static char printf_buf[512];
-    printed_len = vsnprintf(printf_buf, sizeof(printf_buf), fmt, args);
-    serial_out(printf_buf);
-    return printed_len;
-}
-
-int printf(char *fmt, ...)
-{
-    return vprintf(fmt, __read($5));
-}
diff --git a/tests/tcg/mips/mips64-dspr2/shra_qb.c b/tests/tcg/mips/mips64-dspr2/shra_qb.c
deleted file mode 100644
index cac3102..0000000
--- a/tests/tcg/mips/mips64-dspr2/shra_qb.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt = 0x12345678;
-    result = 0x02060A0F;
-
-    __asm
-        ("shra.qb %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("shra.qb error\n");
-        return -1;
-    }
-
-    rt = 0x87654321;
-    result = 0xFFFFFFFFF00C0804;
-
-    __asm
-        ("shra.qb %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("shra.qb error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/shra_r_qb.c b/tests/tcg/mips/mips64-dspr2/shra_r_qb.c
deleted file mode 100644
index 9c64f75..0000000
--- a/tests/tcg/mips/mips64-dspr2/shra_r_qb.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include "io.h"
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x12345678;
-    result = 0x02070B0F;
-
-    __asm
-        ("shra_r.qb %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("shra_r.qb wrong\n");
-        return -1;
-    }
-
-    rt = 0x87654321;
-    result = 0xF10D0804;
-
-    __asm
-        ("shra_r.qb %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("shra_r.qb wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/shrav_ob.c b/tests/tcg/mips/mips64-dspr2/shrav_ob.c
deleted file mode 100644
index fbdfbab..0000000
--- a/tests/tcg/mips/mips64-dspr2/shrav_ob.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs;
-    long long res;
-
-    rt = 0x1234567887654321;
-    rs = 0x4;
-    res = 0xf1f3f5f7f8060402;
-
-    asm ("shrav.ob %0, %1, %2"
-        : "=r"(rd)
-        : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shra.ob error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/shrav_qb.c b/tests/tcg/mips/mips64-dspr2/shrav_qb.c
deleted file mode 100644
index a716203..0000000
--- a/tests/tcg/mips/mips64-dspr2/shrav_qb.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x03;
-    rt = 0x12345678;
-    result = 0x02060A0F;
-
-    __asm
-        ("shrav.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    if (rd != result) {
-        printf("shrav.qb error\n");
-        return -1;
-    }
-
-    rs = 0x03;
-    rt = 0x87654321;
-    result = 0xFFFFFFFFF00C0804;
-
-    __asm
-        ("shrav.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    if (rd != result) {
-        printf("shrav.qb error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/shrav_r_ob.c b/tests/tcg/mips/mips64-dspr2/shrav_r_ob.c
deleted file mode 100644
index b80100a..0000000
--- a/tests/tcg/mips/mips64-dspr2/shrav_r_ob.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rt, rs;
-    long long res;
-
-    rt = 0x1234567887654321;
-    rs = 0x4;
-    res = 0xe3e7ebf0f1ede9e5;
-
-    asm ("shrav_r.ob %0, %1, %2"
-        : "=r"(rd)
-        : "r"(rt), "r"(rs)
-        );
-
-    if (rd != res) {
-        printf("shra_r.ob error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/shrav_r_qb.c b/tests/tcg/mips/mips64-dspr2/shrav_r_qb.c
deleted file mode 100644
index 009080b..0000000
--- a/tests/tcg/mips/mips64-dspr2/shrav_r_qb.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x03;
-    rt = 0x12345678;
-    result = 0x02070B0F;
-
-    __asm
-        ("shrav_r.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    if (rd != result) {
-        printf("shrav_r.qb error\n");
-        return -1;
-    }
-
-    rs = 0x03;
-    rt = 0x87654321;
-    result = 0xFFFFFFFFF10D0804;
-
-    __asm
-        ("shrav_r.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    if (rd != result) {
-        printf("shrav_r.qb error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/shrl_ph.c b/tests/tcg/mips/mips64-dspr2/shrl_ph.c
deleted file mode 100644
index e32d976..0000000
--- a/tests/tcg/mips/mips64-dspr2/shrl_ph.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rt;
-    long long result;
-
-    rt     = 0x12345678;
-    result = 0x009102B3;
-
-    __asm
-        ("shrl.ph %0, %1, 0x05\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    if (rd != result) {
-        printf("shrl.ph error!\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/shrlv_ph.c b/tests/tcg/mips/mips64-dspr2/shrlv_ph.c
deleted file mode 100644
index 58c5488..0000000
--- a/tests/tcg/mips/mips64-dspr2/shrlv_ph.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs     = 0x05;
-    rt     = 0x12345678;
-    result = 0x009102B3;
-
-    __asm
-        ("shrlv.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    if (rd != result) {
-        printf("shrlv.ph error!\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subqh_ph.c b/tests/tcg/mips/mips64-dspr2/subqh_ph.c
deleted file mode 100644
index 9037401..0000000
--- a/tests/tcg/mips/mips64-dspr2/subqh_ph.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x456709AB;
-
-    __asm
-        ("subqh.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("subqh.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subqh_r_ph.c b/tests/tcg/mips/mips64-dspr2/subqh_r_ph.c
deleted file mode 100644
index b8f9d2f..0000000
--- a/tests/tcg/mips/mips64-dspr2/subqh_r_ph.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x456809AC;
-
-    __asm
-        ("subqh_r.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("subqh_r.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subqh_r_w.c b/tests/tcg/mips/mips64-dspr2/subqh_r_w.c
deleted file mode 100644
index b025e40..0000000
--- a/tests/tcg/mips/mips64-dspr2/subqh_r_w.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include"io.h"
-
-int main()
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x456789AC;
-
-    __asm
-        ("subqh_r.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("subqh_r.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subqh_w.c b/tests/tcg/mips/mips64-dspr2/subqh_w.c
deleted file mode 100644
index 65f1760..0000000
--- a/tests/tcg/mips/mips64-dspr2/subqh_w.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x456789AB;
-
-    __asm
-        ("subqh.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("subqh.w error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subu_ph.c b/tests/tcg/mips/mips64-dspr2/subu_ph.c
deleted file mode 100644
index 60a6b1b..0000000
--- a/tests/tcg/mips/mips64-dspr2/subu_ph.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x87654321;
-    rt = 0x12345678;
-    result    = 0x7531ECA9;
-    resultdsp = 0x01;
-
-    __asm
-        ("subu.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    if (dsp != resultdsp || rd  != result) {
-        printf("subu.ph error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subu_qh.c b/tests/tcg/mips/mips64-dspr2/subu_qh.c
deleted file mode 100644
index 911cb34..0000000
--- a/tests/tcg/mips/mips64-dspr2/subu_qh.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dspreg, result, dspresult;
-    rs = 0x123456789ABCDEF0;
-    rt = 0x123456789ABCDEF1;
-    result = 0x000000000000000F;
-    dspresult = 0x01;
-
-    __asm("subu.qh %0, %2, %3\n\t"
-          "rddsp %1\n\t"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subu.qh error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subu_s_ph.c b/tests/tcg/mips/mips64-dspr2/subu_s_ph.c
deleted file mode 100644
index ae32cc0..0000000
--- a/tests/tcg/mips/mips64-dspr2/subu_s_ph.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dsp;
-    long long result, resultdsp;
-
-    rs = 0x87654321;
-    rt = 0x12345678;
-    result    = 0x75310000;
-    resultdsp = 0x01;
-
-    __asm
-        ("subu_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    if (dsp != resultdsp || rd  != result) {
-        printf("subu_s.ph error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subu_s_qh.c b/tests/tcg/mips/mips64-dspr2/subu_s_qh.c
deleted file mode 100644
index de7a29e..0000000
--- a/tests/tcg/mips/mips64-dspr2/subu_s_qh.c
+++ /dev/null
@@ -1,42 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, dspreg, result, dspresult;
-    rs = 0x1111111111111111;
-    rt = 0x2222222222222222;
-    result = 0x1111111111111111;
-    dspresult = 0x00;
-
-    __asm("subu_s.qh %0, %2, %3\n\t"
-          "rddsp %1\n\t"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subu_s.qh error\n\t");
-        return -1;
-    }
-
-
-    rs = 0x8888888888888888;
-    rt = 0xa888a888a888a888;
-    result = 0x0000000000000000;
-    dspresult = 0x01;
-
-    __asm("subu_s.qh %0, %2, %3\n\t"
-          "rddsp %1\n\t"
-          : "=r"(rd), "=r"(dspreg)
-          : "r"(rs), "r"(rt)
-         );
-
-    dspreg = ((dspreg >> 20) & 0x01);
-    if ((rd != result) || (dspreg != dspresult)) {
-        printf("subu_s.qh error\n\t");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subuh_ob.c b/tests/tcg/mips/mips64-dspr2/subuh_ob.c
deleted file mode 100644
index 3fc452b..0000000
--- a/tests/tcg/mips/mips64-dspr2/subuh_ob.c
+++ /dev/null
@@ -1,36 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result;
-
-    rd = 0x0;
-    rs = 0x246856789ABCDEF0;
-    rt = 0x123456789ABCDEF0;
-    result = 0x091A000000000000;
-
-    __asm("subuh.ob %0, %1, %2\n\t"
-          : "=r"(rd)
-          : "r"(rs), "r"(rt)
-         );
-
-    if (rd != result) {
-        printf("subuh.ob error\n");
-        return -1;
-    }
-
-    rs = 0x246856789ABCDEF0;
-    rt = 0x1131517191B1D1F1;
-    result = 0x1b4f2d2d51637577;
-
-    __asm("subuh.ob %0, %1, %2\n\t"
-          : "=r"(rd)
-          : "r"(rs), "r"(rt)
-         );
-
-    if (rd != result) {
-        printf("subuh.ob error\n");
-        return -1;
-    }
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subuh_qb.c b/tests/tcg/mips/mips64-dspr2/subuh_qb.c
deleted file mode 100644
index aac7a83..0000000
--- a/tests/tcg/mips/mips64-dspr2/subuh_qb.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0xC5E7092B;
-
-    __asm
-        ("subuh.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("subuh.qb wrong\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subuh_r_ob.c b/tests/tcg/mips/mips64-dspr2/subuh_r_ob.c
deleted file mode 100644
index fc20ffd..0000000
--- a/tests/tcg/mips/mips64-dspr2/subuh_r_ob.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "io.h"
-
-int main(void)
-{
-    long long rd, rs, rt, result;
-
-    rd = 0x0;
-    rs = 0x246956789ABCDEF0;
-    rt = 0x123456789ABCDEF0;
-    result = 0x091B000000000000;
-
-    __asm("subuh.ob %0, %1, %2\n\t"
-          : "=r"(rd)
-          : "r"(rs), "r"(rt)
-         );
-
-    if (rd != result) {
-        printf("subuh.ob error\n");
-        return -1;
-    }
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips64-dspr2/subuh_r_qb.c b/tests/tcg/mips/mips64-dspr2/subuh_r_qb.c
deleted file mode 100644
index 66d4680..0000000
--- a/tests/tcg/mips/mips64-dspr2/subuh_r_qb.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include"io.h"
-
-int main(void)
-{
-    long long rd, rs, rt;
-    long long result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0xC6E80A2C;
-
-    __asm
-        ("subuh_r.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("1 subuh_r.qb wrong\n");
-        return -1;
-    }
-
-    rs = 0xBEFC292A;
-    rt = 0x9205C1B4;
-    result = 0x167cb4bb;
-
-    __asm
-        ("subuh_r.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    if (rd != result) {
-        printf("2 subuh_r.qb wrong\n");
-        return -1;
-    }
-
-    return 0;
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
