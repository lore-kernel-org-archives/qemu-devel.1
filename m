Received: from eggs.gnu.org ([209.51.188.92]:46596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aw-0003Dd-85
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aL-0002ZK-AZ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:26 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36398 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gn1aI-0002WI-Eh
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:53 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 25 Jan 2019 14:31:34 +0100
Message-Id: <1548423098-31864-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 10/14] tests: tcg: mips: Move source files to
 new locations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

MIPS TCG test will be organized by ISAs and ASEs in future.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mips32-dsp/absq_s_ph.c              |  31 -----
 tests/tcg/mips/mips32-dsp/absq_s_w.c               |  37 ------
 tests/tcg/mips/mips32-dsp/addq_ph.c                |  46 --------
 tests/tcg/mips/mips32-dsp/addq_s_ph.c              |  69 ------------
 tests/tcg/mips/mips32-dsp/addq_s_w.c               |  44 --------
 tests/tcg/mips/mips32-dsp/addsc.c                  |  33 ------
 tests/tcg/mips/mips32-dsp/addu_qb.c                |  35 ------
 tests/tcg/mips/mips32-dsp/addu_s_qb.c              |  35 ------
 tests/tcg/mips/mips32-dsp/addwc.c                  |  49 --------
 tests/tcg/mips/mips32-dsp/bitrev.c                 |  20 ----
 tests/tcg/mips/mips32-dsp/bposge32.c               |  44 --------
 tests/tcg/mips/mips32-dsp/cmp_eq_ph.c              |  35 ------
 tests/tcg/mips/mips32-dsp/cmp_le_ph.c              |  35 ------
 tests/tcg/mips/mips32-dsp/cmp_lt_ph.c              |  35 ------
 tests/tcg/mips/mips32-dsp/cmpgu_eq_qb.c            |  31 -----
 tests/tcg/mips/mips32-dsp/cmpgu_le_qb.c            |  31 -----
 tests/tcg/mips/mips32-dsp/cmpgu_lt_qb.c            |  31 -----
 tests/tcg/mips/mips32-dsp/cmpu_eq_qb.c             |  35 ------
 tests/tcg/mips/mips32-dsp/cmpu_le_qb.c             |  35 ------
 tests/tcg/mips/mips32-dsp/cmpu_lt_qb.c             |  35 ------
 tests/tcg/mips/mips32-dsp/dpaq_s_w_ph.c            |  31 -----
 tests/tcg/mips/mips32-dsp/dpaq_sa_l_w.c            | 125 ---------------------
 tests/tcg/mips/mips32-dsp/dpau_h_qbl.c             |  27 -----
 tests/tcg/mips/mips32-dsp/dpau_h_qbr.c             |  27 -----
 tests/tcg/mips/mips32-dsp/dpsq_s_w_ph.c            |  45 --------
 tests/tcg/mips/mips32-dsp/dpsq_sa_l_w.c            |  55 ---------
 tests/tcg/mips/mips32-dsp/dpsu_h_qbl.c             |  27 -----
 tests/tcg/mips/mips32-dsp/dpsu_h_qbr.c             |  27 -----
 tests/tcg/mips/mips32-dsp/extp.c                   |  62 ----------
 tests/tcg/mips/mips32-dsp/extpdp.c                 |  64 -----------
 tests/tcg/mips/mips32-dsp/extpdpv.c                |  47 --------
 tests/tcg/mips/mips32-dsp/extpv.c                  |  45 --------
 tests/tcg/mips/mips32-dsp/extr_r_w.c               |  94 ----------------
 tests/tcg/mips/mips32-dsp/extr_rs_w.c              | 117 -------------------
 tests/tcg/mips/mips32-dsp/extr_s_h.c               |  86 --------------
 tests/tcg/mips/mips32-dsp/extr_w.c                 |  94 ----------------
 tests/tcg/mips/mips32-dsp/extrv_r_w.c              |  79 -------------
 tests/tcg/mips/mips32-dsp/extrv_rs_w.c             |  77 -------------
 tests/tcg/mips/mips32-dsp/extrv_s_h.c              |  88 ---------------
 tests/tcg/mips/mips32-dsp/extrv_w.c                |  80 -------------
 tests/tcg/mips/mips32-dsp/insv.c                   |  36 ------
 tests/tcg/mips/mips32-dsp/lbux.c                   |  25 -----
 tests/tcg/mips/mips32-dsp/lhx.c                    |  25 -----
 tests/tcg/mips/mips32-dsp/lwx.c                    |  25 -----
 tests/tcg/mips/mips32-dsp/madd.c                   |  31 -----
 tests/tcg/mips/mips32-dsp/maddu.c                  |  31 -----
 tests/tcg/mips/mips32-dsp/main.c                   |   6 -
 tests/tcg/mips/mips32-dsp/maq_s_w_phl.c            |  55 ---------
 tests/tcg/mips/mips32-dsp/maq_s_w_phr.c            |  55 ---------
 tests/tcg/mips/mips32-dsp/maq_sa_w_phl.c           |  55 ---------
 tests/tcg/mips/mips32-dsp/maq_sa_w_phr.c           |  55 ---------
 tests/tcg/mips/mips32-dsp/mfhi.c                   |  21 ----
 tests/tcg/mips/mips32-dsp/mflo.c                   |  21 ----
 tests/tcg/mips/mips32-dsp/modsub.c                 |  30 -----
 tests/tcg/mips/mips32-dsp/msub.c                   |  30 -----
 tests/tcg/mips/mips32-dsp/msubu.c                  |  30 -----
 tests/tcg/mips/mips32-dsp/mthi.c                   |  21 ----
 tests/tcg/mips/mips32-dsp/mthlip.c                 |  58 ----------
 tests/tcg/mips/mips32-dsp/mtlo.c                   |  21 ----
 tests/tcg/mips/mips32-dsp/muleq_s_w_phl.c          |  41 -------
 tests/tcg/mips/mips32-dsp/muleq_s_w_phr.c          |  40 -------
 tests/tcg/mips/mips32-dsp/muleu_s_ph_qbl.c         |  25 -----
 tests/tcg/mips/mips32-dsp/muleu_s_ph_qbr.c         |  25 -----
 tests/tcg/mips/mips32-dsp/mulq_rs_ph.c             |  42 -------
 tests/tcg/mips/mips32-dsp/mult.c                   |  24 ----
 tests/tcg/mips/mips32-dsp/multu.c                  |  24 ----
 tests/tcg/mips/mips32-dsp/packrl_ph.c              |  21 ----
 tests/tcg/mips/mips32-dsp/pick_ph.c                |  49 --------
 tests/tcg/mips/mips32-dsp/pick_qb.c                |  36 ------
 tests/tcg/mips/mips32-dsp/preceq_w_phl.c           |  20 ----
 tests/tcg/mips/mips32-dsp/preceq_w_phr.c           |  20 ----
 tests/tcg/mips/mips32-dsp/precequ_ph_qbl.c         |  20 ----
 tests/tcg/mips/mips32-dsp/precequ_ph_qbla.c        |  20 ----
 tests/tcg/mips/mips32-dsp/precequ_ph_qbr.c         |  20 ----
 tests/tcg/mips/mips32-dsp/precequ_ph_qbra.c        |  20 ----
 tests/tcg/mips/mips32-dsp/preceu_ph_qbl.c          |  20 ----
 tests/tcg/mips/mips32-dsp/preceu_ph_qbla.c         |  20 ----
 tests/tcg/mips/mips32-dsp/preceu_ph_qbr.c          |  20 ----
 tests/tcg/mips/mips32-dsp/preceu_ph_qbra.c         |  20 ----
 tests/tcg/mips/mips32-dsp/precrq_ph_w.c            |  21 ----
 tests/tcg/mips/mips32-dsp/precrq_qb_ph.c           |  21 ----
 tests/tcg/mips/mips32-dsp/precrq_rs_ph_w.c         |  51 ---------
 tests/tcg/mips/mips32-dsp/precrqu_s_qb_ph.c        |  24 ----
 tests/tcg/mips/mips32-dsp/raddu_w_qb.c             |  20 ----
 tests/tcg/mips/mips32-dsp/rddsp.c                  |  46 --------
 tests/tcg/mips/mips32-dsp/repl_ph.c                |  23 ----
 tests/tcg/mips/mips32-dsp/repl_qb.c                |  16 ---
 tests/tcg/mips/mips32-dsp/replv_ph.c               |  19 ----
 tests/tcg/mips/mips32-dsp/replv_qb.c               |  19 ----
 tests/tcg/mips/mips32-dsp/shilo.c                  |  45 --------
 tests/tcg/mips/mips32-dsp/shilov.c                 |  49 --------
 tests/tcg/mips/mips32-dsp/shll_ph.c                |  55 ---------
 tests/tcg/mips/mips32-dsp/shll_qb.c                |  55 ---------
 tests/tcg/mips/mips32-dsp/shll_s_ph.c              |  24 ----
 tests/tcg/mips/mips32-dsp/shll_s_w.c               |  52 ---------
 tests/tcg/mips/mips32-dsp/shllv_ph.c               |  40 -------
 tests/tcg/mips/mips32-dsp/shllv_qb.c               |  38 -------
 tests/tcg/mips/mips32-dsp/shllv_s_ph.c             |  40 -------
 tests/tcg/mips/mips32-dsp/shllv_s_w.c              |  40 -------
 tests/tcg/mips/mips32-dsp/shra_ph.c                |  30 -----
 tests/tcg/mips/mips32-dsp/shra_r_ph.c              |  30 -----
 tests/tcg/mips/mips32-dsp/shra_r_w.c               |  30 -----
 tests/tcg/mips/mips32-dsp/shrav_ph.c               |  32 ------
 tests/tcg/mips/mips32-dsp/shrav_r_ph.c             |  32 ------
 tests/tcg/mips/mips32-dsp/shrav_r_w.c              |  32 ------
 tests/tcg/mips/mips32-dsp/shrl_qb.c                |  31 -----
 tests/tcg/mips/mips32-dsp/shrlv_qb.c               |  32 ------
 tests/tcg/mips/mips32-dsp/subq_ph.c                |  40 -------
 tests/tcg/mips/mips32-dsp/subq_s_ph.c              |  58 ----------
 tests/tcg/mips/mips32-dsp/subq_s_w.c               |  74 ------------
 tests/tcg/mips/mips32-dsp/subu_qb.c                |  25 -----
 tests/tcg/mips/mips32-dsp/subu_s_qb.c              |  25 -----
 tests/tcg/mips/mips32-dsp/wrdsp.c                  |  46 --------
 tests/tcg/mips/mips32-dspr2/absq_s_qb.c            |  35 ------
 tests/tcg/mips/mips32-dspr2/addqh_ph.c             |  30 -----
 tests/tcg/mips/mips32-dspr2/addqh_r_ph.c           |  30 -----
 tests/tcg/mips/mips32-dspr2/addqh_r_w.c            |  34 ------
 tests/tcg/mips/mips32-dspr2/addqh_w.c              |  34 ------
 tests/tcg/mips/mips32-dspr2/addu_ph.c              |  33 ------
 tests/tcg/mips/mips32-dspr2/addu_s_ph.c            |  33 ------
 tests/tcg/mips/mips32-dspr2/adduh_qb.c             |  30 -----
 tests/tcg/mips/mips32-dspr2/adduh_r_qb.c           |  30 -----
 tests/tcg/mips/mips32-dspr2/append.c               |  30 -----
 tests/tcg/mips/mips32-dspr2/balign.c               |  30 -----
 tests/tcg/mips/mips32-dspr2/cmpgdu_eq_qb.c         |  37 ------
 tests/tcg/mips/mips32-dspr2/cmpgdu_le_qb.c         |  37 ------
 tests/tcg/mips/mips32-dspr2/cmpgdu_lt_qb.c         |  37 ------
 tests/tcg/mips/mips32-dspr2/dpa_w_ph.c             |  44 --------
 tests/tcg/mips/mips32-dspr2/dpaqx_s_w_ph.c         |  79 -------------
 tests/tcg/mips/mips32-dspr2/dpaqx_sa_w_ph.c        |  57 ----------
 tests/tcg/mips/mips32-dspr2/dpax_w_ph.c            |  44 --------
 tests/tcg/mips/mips32-dspr2/dps_w_ph.c             |  44 --------
 tests/tcg/mips/mips32-dspr2/dpsqx_s_w_ph.c         |  54 ---------
 tests/tcg/mips/mips32-dspr2/dpsqx_sa_w_ph.c        |  53 ---------
 tests/tcg/mips/mips32-dspr2/dpsx_w_ph.c            |  27 -----
 tests/tcg/mips/mips32-dspr2/mul_ph.c               |  47 --------
 tests/tcg/mips/mips32-dspr2/mul_s_ph.c             |  62 ----------
 tests/tcg/mips/mips32-dspr2/mulq_rs_w.c            |  36 ------
 tests/tcg/mips/mips32-dspr2/mulq_s_ph.c            |  40 -------
 tests/tcg/mips/mips32-dspr2/mulq_s_w.c             |  36 ------
 tests/tcg/mips/mips32-dspr2/mulsa_w_ph.c           |  29 -----
 tests/tcg/mips/mips32-dspr2/mulsaq_s_w_ph.c        |  29 -----
 tests/tcg/mips/mips32-dspr2/precr_qb_ph.c          |  21 ----
 tests/tcg/mips/mips32-dspr2/precr_sra_ph_w.c       |  32 ------
 tests/tcg/mips/mips32-dspr2/precr_sra_r_ph_w.c     |  32 ------
 tests/tcg/mips/mips32-dspr2/prepend.c              |  30 -----
 tests/tcg/mips/mips32-dspr2/shra_qb.c              |  30 -----
 tests/tcg/mips/mips32-dspr2/shra_r_qb.c            |  30 -----
 tests/tcg/mips/mips32-dspr2/shrav_qb.c             |  32 ------
 tests/tcg/mips/mips32-dspr2/shrav_r_qb.c           |  32 ------
 tests/tcg/mips/mips32-dspr2/shrl_ph.c              |  20 ----
 tests/tcg/mips/mips32-dspr2/shrlv_ph.c             |  21 ----
 tests/tcg/mips/mips32-dspr2/subqh_ph.c             |  21 ----
 tests/tcg/mips/mips32-dspr2/subqh_r_ph.c           |  21 ----
 tests/tcg/mips/mips32-dspr2/subqh_r_w.c            |  21 ----
 tests/tcg/mips/mips32-dspr2/subqh_w.c              |  21 ----
 tests/tcg/mips/mips32-dspr2/subu_ph.c              |  40 -------
 tests/tcg/mips/mips32-dspr2/subu_s_ph.c            |  25 -----
 tests/tcg/mips/mips32-dspr2/subuh_qb.c             |  21 ----
 tests/tcg/mips/mips32-dspr2/subuh_r_qb.c           |  32 ------
 tests/tcg/mips/mipsr5900/div1.c                    |  73 ------------
 tests/tcg/mips/mipsr5900/divu1.c                   |  48 --------
 tests/tcg/mips/mipsr5900/madd.c                    |  78 -------------
 tests/tcg/mips/mipsr5900/maddu.c                   |  70 ------------
 tests/tcg/mips/mipsr5900/mflohi1.c                 |  35 ------
 tests/tcg/mips/mipsr5900/mtlohi1.c                 |  40 -------
 tests/tcg/mips/mipsr5900/mult.c                    |  76 -------------
 tests/tcg/mips/mipsr5900/multu.c                   |  68 -----------
 .../tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c  |  31 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c |  37 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c  |  46 ++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c  |  69 ++++++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c |  44 ++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c    |  33 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c  |  35 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c  |  35 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c    |  49 ++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c   |  20 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c |  44 ++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c  |  35 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c  |  35 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c  |  35 ++++++
 .../mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c    |  31 +++++
 .../mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c    |  31 +++++
 .../mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c    |  31 +++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c |  35 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c |  35 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c |  35 ++++++
 .../mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c    |  31 +++++
 .../mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c    | 125 +++++++++++++++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c |  27 +++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c |  27 +++++
 .../mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c    |  45 ++++++++
 .../mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c    |  55 +++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c |  27 +++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c |  27 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c     |  62 ++++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c   |  64 +++++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c  |  47 ++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c    |  45 ++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c |  94 ++++++++++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c  | 117 +++++++++++++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c |  86 ++++++++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c   |  94 ++++++++++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c  |  79 +++++++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c |  77 +++++++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c  |  88 +++++++++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c  |  80 +++++++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c     |  36 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c     |  25 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c      |  25 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c      |  25 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c     |  31 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c    |  31 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c     |   6 +
 .../mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c    |  55 +++++++++
 .../mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c    |  55 +++++++++
 .../mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c   |  55 +++++++++
 .../mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c   |  55 +++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c     |  21 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c     |  21 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c   |  30 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c     |  30 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c    |  30 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c     |  21 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c   |  58 ++++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c     |  21 ++++
 .../mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c  |  41 +++++++
 .../mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c  |  40 +++++++
 .../mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c |  25 +++++
 .../mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c |  25 +++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c |  42 +++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c     |  24 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c    |  24 ++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c  |  21 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c  |  49 ++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c  |  36 ++++++
 .../mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c   |  20 ++++
 .../mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c   |  20 ++++
 .../mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c |  20 ++++
 .../user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c     |  20 ++++
 .../mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c |  20 ++++
 .../user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c     |  20 ++++
 .../mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c  |  20 ++++
 .../mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c |  20 ++++
 .../mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c  |  20 ++++
 .../mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c |  20 ++++
 .../mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c    |  21 ++++
 .../mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c   |  21 ++++
 .../mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c |  51 +++++++++
 .../user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c     |  24 ++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c |  20 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c    |  46 ++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c  |  23 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c  |  16 +++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c |  19 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c |  19 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c    |  45 ++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c   |  49 ++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c  |  55 +++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c  |  55 +++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c  |  24 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c |  52 +++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c |  40 +++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c |  38 +++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c |  40 +++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c  |  40 +++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c  |  30 +++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c  |  30 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c |  30 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c |  32 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c |  32 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c  |  32 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c  |  31 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c |  32 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c  |  40 +++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c  |  58 ++++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c |  74 ++++++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c  |  25 +++++
 .../tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c  |  25 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c    |  46 ++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c  |  35 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c |  30 +++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c |  30 +++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c  |  34 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c  |  34 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c  |  33 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c  |  33 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c |  30 +++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c |  30 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c   |  30 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c   |  30 +++++
 .../mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c   |  37 ++++++
 .../mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c   |  37 ++++++
 .../mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c   |  37 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c |  44 ++++++++
 .../mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c   |  79 +++++++++++++
 .../mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c  |  57 ++++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c  |  44 ++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c |  44 ++++++++
 .../mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c   |  54 +++++++++
 .../mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c  |  53 +++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c  |  27 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c   |  47 ++++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c |  62 ++++++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c  |  36 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c  |  40 +++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c |  36 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c |  29 +++++
 .../mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c  |  29 +++++
 .../mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c    |  21 ++++
 .../mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c |  32 ++++++
 .../user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c    |  32 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c  |  30 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c  |  30 +++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c  |  30 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c |  32 ++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c |  32 ++++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c  |  20 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c |  21 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c |  21 ++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c |  21 ++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c  |  21 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c  |  21 ++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c  |  40 +++++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c  |  25 +++++
 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c |  21 ++++
 .../tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c |  32 ++++++
 tests/tcg/mips/user/isa/r5900/test_r5900_div1.c    |  73 ++++++++++++
 tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c   |  48 ++++++++
 tests/tcg/mips/user/isa/r5900/test_r5900_madd.c    |  78 +++++++++++++
 tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c   |  70 ++++++++++++
 tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c |  35 ++++++
 tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c |  40 +++++++
 tests/tcg/mips/user/isa/r5900/test_r5900_mult.c    |  76 +++++++++++++
 tests/tcg/mips/user/isa/r5900/test_r5900_multu.c   |  68 +++++++++++
 336 files changed, 6527 insertions(+), 6527 deletions(-)
 delete mode 100644 tests/tcg/mips/mips32-dsp/absq_s_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/absq_s_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/addq_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/addq_s_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/addq_s_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/addsc.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/addu_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/addu_s_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/addwc.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/bitrev.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/bposge32.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/cmp_eq_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/cmp_le_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/cmp_lt_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/cmpgu_eq_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/cmpgu_le_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/cmpgu_lt_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/cmpu_eq_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/cmpu_le_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/cmpu_lt_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/dpaq_s_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/dpaq_sa_l_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/dpau_h_qbl.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/dpau_h_qbr.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/dpsq_s_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/dpsq_sa_l_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/dpsu_h_qbl.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/dpsu_h_qbr.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extp.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extpdp.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extpdpv.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extpv.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extr_r_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extr_rs_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extr_s_h.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extr_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extrv_r_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extrv_rs_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extrv_s_h.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/extrv_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/insv.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/lbux.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/lhx.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/lwx.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/madd.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/maddu.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/main.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/maq_s_w_phl.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/maq_s_w_phr.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/maq_sa_w_phl.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/maq_sa_w_phr.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/mfhi.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/mflo.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/modsub.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/msub.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/msubu.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/mthi.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/mthlip.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/mtlo.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/muleq_s_w_phl.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/muleq_s_w_phr.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/muleu_s_ph_qbl.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/muleu_s_ph_qbr.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/mulq_rs_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/mult.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/multu.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/packrl_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/pick_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/pick_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/preceq_w_phl.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/preceq_w_phr.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/precequ_ph_qbl.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/precequ_ph_qbla.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/precequ_ph_qbr.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/precequ_ph_qbra.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/preceu_ph_qbl.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/preceu_ph_qbla.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/preceu_ph_qbr.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/preceu_ph_qbra.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/precrq_ph_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/precrq_qb_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/precrq_rs_ph_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/precrqu_s_qb_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/raddu_w_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/rddsp.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/repl_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/repl_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/replv_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/replv_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shilo.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shilov.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shll_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shll_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shll_s_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shll_s_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shllv_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shllv_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shllv_s_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shllv_s_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shra_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shra_r_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shra_r_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shrav_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shrav_r_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shrav_r_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shrl_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/shrlv_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/subq_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/subq_s_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/subq_s_w.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/subu_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/subu_s_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dsp/wrdsp.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/absq_s_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/addqh_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/addqh_r_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/addqh_r_w.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/addqh_w.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/addu_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/addu_s_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/adduh_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/adduh_r_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/append.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/balign.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/cmpgdu_eq_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/cmpgdu_le_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/cmpgdu_lt_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/dpa_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/dpaqx_s_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/dpaqx_sa_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/dpax_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/dps_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/dpsqx_s_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/dpsqx_sa_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/dpsx_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/mul_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/mul_s_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/mulq_rs_w.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/mulq_s_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/mulq_s_w.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/mulsa_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/mulsaq_s_w_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/precr_qb_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/precr_sra_ph_w.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/precr_sra_r_ph_w.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/prepend.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/shra_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/shra_r_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/shrav_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/shrav_r_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/shrl_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/shrlv_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/subqh_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/subqh_r_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/subqh_r_w.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/subqh_w.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/subu_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/subu_s_ph.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/subuh_qb.c
 delete mode 100644 tests/tcg/mips/mips32-dspr2/subuh_r_qb.c
 delete mode 100644 tests/tcg/mips/mipsr5900/div1.c
 delete mode 100644 tests/tcg/mips/mipsr5900/divu1.c
 delete mode 100644 tests/tcg/mips/mipsr5900/madd.c
 delete mode 100644 tests/tcg/mips/mipsr5900/maddu.c
 delete mode 100644 tests/tcg/mips/mipsr5900/mflohi1.c
 delete mode 100644 tests/tcg/mips/mipsr5900/mtlohi1.c
 delete mode 100644 tests/tcg/mips/mipsr5900/mult.c
 delete mode 100644 tests/tcg/mips/mipsr5900/multu.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c
 create mode 100644 tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c
 create mode 100644 tests/tcg/mips/user/isa/r5900/test_r5900_div1.c
 create mode 100644 tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c
 create mode 100644 tests/tcg/mips/user/isa/r5900/test_r5900_madd.c
 create mode 100644 tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c
 create mode 100644 tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c
 create mode 100644 tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c
 create mode 100644 tests/tcg/mips/user/isa/r5900/test_r5900_mult.c
 create mode 100644 tests/tcg/mips/user/isa/r5900/test_r5900_multu.c

diff --git a/tests/tcg/mips/mips32-dsp/absq_s_ph.c b/tests/tcg/mips/mips32-dsp/absq_s_ph.c
deleted file mode 100644
index aa84112..0000000
--- a/tests/tcg/mips/mips32-dsp/absq_s_ph.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt     = 0x10017EFD;
-    result = 0x10017EFD;
-
-    __asm
-        ("absq_s.ph %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    rt     = 0x8000A536;
-    result = 0x7FFF5ACA;
-
-    __asm
-        ("absq_s.ph %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/absq_s_w.c b/tests/tcg/mips/mips32-dsp/absq_s_w.c
deleted file mode 100644
index 3f52a48..0000000
--- a/tests/tcg/mips/mips32-dsp/absq_s_w.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt     = 0x80000000;
-    result = 0x7FFFFFFF;
-    __asm
-        ("absq_s.w %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    rt     = 0x80030000;
-    result = 0x7FFD0000;
-    __asm
-        ("absq_s.w %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    rt     = 0x31036080;
-    result = 0x31036080;
-    __asm
-        ("absq_s.w %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/addq_ph.c b/tests/tcg/mips/mips32-dsp/addq_ph.c
deleted file mode 100644
index 96a5496..0000000
--- a/tests/tcg/mips/mips32-dsp/addq_ph.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
-
-    rs     = 0xFFFFFFFF;
-    rt     = 0x10101010;
-    result = 0x100F100F;
-    __asm
-        ("addq.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-
-    rs     = 0x3712847D;
-    rt     = 0x0031AF2D;
-    result = 0x374333AA;
-    __asm
-        ("addq.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-
-    rs     = 0x7fff847D;
-    rt     = 0x0031AF2D;
-    result = 0x803033AA;
-    __asm
-        ("addq.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-
-    __asm("rddsp %0\n\t"
-          : "=r"(dsp)
-         );
-    assert(((dsp >> 20) & 0x01) == 1);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/addq_s_ph.c b/tests/tcg/mips/mips32-dsp/addq_s_ph.c
deleted file mode 100644
index 5f865f6..0000000
--- a/tests/tcg/mips/mips32-dsp/addq_s_ph.c
+++ /dev/null
@@ -1,69 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
-
-    rs     = 0xFFFFFFFF;
-    rt     = 0x10101010;
-    result = 0x100F100F;
-    __asm
-        ("addq_s.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-
-    rs     = 0x3712847D;
-    rt     = 0x0031AF2D;
-    result = 0x37438000;
-    __asm
-        ("addq_s.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(dsp)
-        );
-    assert(((dsp >> 20) & 0x01) == 1);
-
-    rs     = 0x7fff847D;
-    rt     = 0x0031AF2D;
-    result = 0x7fff8000;
-    __asm
-        ("addq_s.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(dsp)
-        );
-    assert(((dsp >> 20) & 0x01) == 1);
-
-    rs     = 0x8030847D;
-    rt     = 0x8a00AF2D;
-    result = 0x80008000;
-    __asm
-        ("addq_s.ph   %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-
-    __asm
-        ("rddsp %0\n\t"
-         : "=r"(dsp)
-        );
-    assert(((dsp >> 20) & 0x01) == 1);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/addq_s_w.c b/tests/tcg/mips/mips32-dsp/addq_s_w.c
deleted file mode 100644
index 1e13acf..0000000
--- a/tests/tcg/mips/mips32-dsp/addq_s_w.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    rt     = 0x80017EFD;
-    rs     = 0x81111111;
-    result = 0x80000000;
-
-    __asm
-        ("addq_s.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/addsc.c b/tests/tcg/mips/mips32-dsp/addsc.c
deleted file mode 100644
index ace749f..0000000
--- a/tests/tcg/mips/mips32-dsp/addsc.c
+++ /dev/null
@@ -1,33 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
-
-    rs     = 0x0000000F;
-    rt     = 0x00000001;
-    result = 0x00000010;
-    __asm
-        ("addsc %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
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
-    assert(rd == result);
-    assert(((dsp >> 13) & 0x01) == 1);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/addu_qb.c b/tests/tcg/mips/mips32-dsp/addu_qb.c
deleted file mode 100644
index 23ba2e9..0000000
--- a/tests/tcg/mips/mips32-dsp/addu_qb.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
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
-    assert(rd == result);
-    assert(((dsp >> 20) & 0x01) == 1);
-
-    rs     = 0xFFFF1111;
-    rt     = 0x00020001;
-    result = 0xFF011112;
-    __asm
-        ("addu.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-    assert(((dsp >> 20) & 0x01) == 1);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/addu_s_qb.c b/tests/tcg/mips/mips32-dsp/addu_s_qb.c
deleted file mode 100644
index fe7fd3e..0000000
--- a/tests/tcg/mips/mips32-dsp/addu_s_qb.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
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
-    assert(rd == result);
-    assert(((dsp >> 20) & 0x1) == 1);
-
-    rs     = 0xFFFF1111;
-    rt     = 0x00020001;
-    result = 0xFFFF1112;
-    __asm
-        ("addu_s.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-    assert(((dsp >> 20) & 0x1) == 1);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/addwc.c b/tests/tcg/mips/mips32-dsp/addwc.c
deleted file mode 100644
index 8a8d81f..0000000
--- a/tests/tcg/mips/mips32-dsp/addwc.c
+++ /dev/null
@@ -1,49 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dspi, dspo;
-    int result;
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
-    assert(rd == result);
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
-    assert(rd == result);
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
-    assert(rd == result);
-    assert(((dspo >> 20) & 0x01) == 1);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/bitrev.c b/tests/tcg/mips/mips32-dsp/bitrev.c
deleted file mode 100644
index 04d8a38..0000000
--- a/tests/tcg/mips/mips32-dsp/bitrev.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt     = 0x12345678;
-    result = 0x00001E6A;
-
-    __asm
-        ("bitrev %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/bposge32.c b/tests/tcg/mips/mips32-dsp/bposge32.c
deleted file mode 100644
index d25417e..0000000
--- a/tests/tcg/mips/mips32-dsp/bposge32.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int dsp, sum;
-    int result;
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
-    assert(sum == result);
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
-    assert(sum == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/cmp_eq_ph.c b/tests/tcg/mips/mips32-dsp/cmp_eq_ph.c
deleted file mode 100644
index 957bd88..0000000
--- a/tests/tcg/mips/mips32-dsp/cmp_eq_ph.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/cmp_le_ph.c b/tests/tcg/mips/mips32-dsp/cmp_le_ph.c
deleted file mode 100644
index 356f156..0000000
--- a/tests/tcg/mips/mips32-dsp/cmp_le_ph.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/cmp_lt_ph.c b/tests/tcg/mips/mips32-dsp/cmp_lt_ph.c
deleted file mode 100644
index 3fb4827..0000000
--- a/tests/tcg/mips/mips32-dsp/cmp_lt_ph.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/cmpgu_eq_qb.c b/tests/tcg/mips/mips32-dsp/cmpgu_eq_qb.c
deleted file mode 100644
index 2615c84..0000000
--- a/tests/tcg/mips/mips32-dsp/cmpgu_eq_qb.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    rs     = 0x11777066;
-    rt     = 0x11777066;
-    result = 0x0F;
-    __asm
-        ("cmpgu.eq.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/cmpgu_le_qb.c b/tests/tcg/mips/mips32-dsp/cmpgu_le_qb.c
deleted file mode 100644
index 65d0813..0000000
--- a/tests/tcg/mips/mips32-dsp/cmpgu_le_qb.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
-
-    rs     = 0x11777066;
-    rt     = 0x55AA70FF;
-    result = 0x0F;
-    __asm
-        ("cmpgu.le.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    assert(rd == result);
-
-    rs     = 0x11777066;
-    rt     = 0x11766066;
-    result = 0x09;
-    __asm
-        ("cmpgu.le.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/cmpgu_lt_qb.c b/tests/tcg/mips/mips32-dsp/cmpgu_lt_qb.c
deleted file mode 100644
index 7dddad9..0000000
--- a/tests/tcg/mips/mips32-dsp/cmpgu_lt_qb.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    rs     = 0x11777066;
-    rt     = 0x11766066;
-    result = 0x00;
-    __asm
-        ("cmpgu.lt.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/cmpu_eq_qb.c b/tests/tcg/mips/mips32-dsp/cmpu_eq_qb.c
deleted file mode 100644
index 680f2a1..0000000
--- a/tests/tcg/mips/mips32-dsp/cmpu_eq_qb.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int dsp;
-    int result;
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
-    assert(dsp == result);
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
-    assert(dsp == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/cmpu_le_qb.c b/tests/tcg/mips/mips32-dsp/cmpu_le_qb.c
deleted file mode 100644
index 43cfa50..0000000
--- a/tests/tcg/mips/mips32-dsp/cmpu_le_qb.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int dsp;
-    int result;
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
-    assert(dsp == result);
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
-    assert(dsp == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/cmpu_lt_qb.c b/tests/tcg/mips/mips32-dsp/cmpu_lt_qb.c
deleted file mode 100644
index 074ca5b..0000000
--- a/tests/tcg/mips/mips32-dsp/cmpu_lt_qb.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int dsp;
-    int result;
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
-    assert(dsp == result);
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
-    assert(dsp == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/dpaq_s_w_ph.c b/tests/tcg/mips/mips32-dsp/dpaq_s_w_ph.c
deleted file mode 100644
index a6425b6..0000000
--- a/tests/tcg/mips/mips32-dsp/dpaq_s_w_ph.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, dsp;
-    int ach = 0, acl = 0;
-    int resulth, resultl, resultdsp;
-
-    rs        = 0x800000FF;
-    rt        = 0x80000002;
-    resulth   = 0x00;
-    resultl   = 0x800003FB;
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
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/dpaq_sa_l_w.c b/tests/tcg/mips/mips32-dsp/dpaq_sa_l_w.c
deleted file mode 100644
index cbf9007..0000000
--- a/tests/tcg/mips/mips32-dsp/dpaq_sa_l_w.c
+++ /dev/null
@@ -1,125 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, dsp;
-    int ach = 0, acl = 0;
-    int resulth, resultl, resultdsp;
-
-    rs        = 0x80000000;
-    rt        = 0x80000000;
-    resulth   = 0x7FFFFFFF;
-    resultl   = 0xFFFFFFFF;
-    resultdsp = 0x01;
-    __asm
-        ("mthi        %0, $ac1\n\t"
-         "mtlo        %1, $ac1\n\t"
-         "dpaq_sa.l.w $ac1, %3, %4\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 0x00000012;
-    acl = 0x00000048;
-    rs  = 0x80000000;
-    rt  = 0x80000000;
-
-    resulth   = 0x7FFFFFFF;
-    resultl   = 0xFFFFFFFF;
-    resultdsp = 0x01;
-    __asm
-        ("mthi        %0, $ac1\n\t"
-         "mtlo        %1, $ac1\n\t"
-         "dpaq_sa.l.w $ac1, %3, %4\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 0x741532A0;
-    acl = 0xFCEABB08;
-    rs  = 0x80000000;
-    rt  = 0x80000000;
-
-    resulth   = 0x7FFFFFFF;
-    resultl   = 0xFFFFFFFF;
-    resultdsp = 0x01;
-    __asm
-        ("mthi        %0, $ac1\n\t"
-         "mtlo        %1, $ac1\n\t"
-         "dpaq_sa.l.w $ac1, %3, %4\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 0;
-    acl = 0;
-    rs  = 0xC0000000;
-    rt  = 0x7FFFFFFF;
-
-    resulth   = 0xC0000000;
-    resultl   = 0x80000000;
-    resultdsp = 0;
-    __asm
-        ("wrdsp       $0\n\t"
-         "mthi        %0, $ac1\n\t"
-         "mtlo        %1, $ac1\n\t"
-         "dpaq_sa.l.w $ac1, %3, %4\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 0x20000000;
-    acl = 0;
-    rs  = 0xE0000000;
-    rt  = 0x7FFFFFFF;
-
-    resulth   = 0;
-    resultl   = 0x40000000;
-    resultdsp = 0;
-    __asm
-        ("wrdsp       $0\n\t"
-         "mthi        %0, $ac1\n\t"
-         "mtlo        %1, $ac1\n\t"
-         "dpaq_sa.l.w $ac1, %3, %4\n\t"
-         "mfhi        %0,   $ac1\n\t"
-         "mflo        %1,   $ac1\n\t"
-         "rddsp       %2\n\t"
-         : "+r"(ach), "+r"(acl), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 17) & 0x01;
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/dpau_h_qbl.c b/tests/tcg/mips/mips32-dsp/dpau_h_qbl.c
deleted file mode 100644
index 6017b5e..0000000
--- a/tests/tcg/mips/mips32-dsp/dpau_h_qbl.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int ach = 5, acl = 3;
-    int resulth, resultl;
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
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/dpau_h_qbr.c b/tests/tcg/mips/mips32-dsp/dpau_h_qbr.c
deleted file mode 100644
index e4abb2e..0000000
--- a/tests/tcg/mips/mips32-dsp/dpau_h_qbr.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int ach = 5, acl = 3;
-    int resulth, resultl;
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
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/dpsq_s_w_ph.c b/tests/tcg/mips/mips32-dsp/dpsq_s_w_ph.c
deleted file mode 100644
index 74058fe..0000000
--- a/tests/tcg/mips/mips32-dsp/dpsq_s_w_ph.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int ach = 5, acl = 5;
-    int resulth, resultl;
-
-    rs      = 0xBC0123AD;
-    rt      = 0x01643721;
-    resulth = 0x00000004;
-    resultl = 0xF15F94A3;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsq_s.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 0x1424EF1F;
-    acl = 0x1035219A;
-    rs      = 0x800083AD;
-    rt      = 0x80003721;
-    resulth = 0x1424EF1E;
-    resultl = 0xC5C0D901;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsq_s.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/dpsq_sa_l_w.c b/tests/tcg/mips/mips32-dsp/dpsq_sa_l_w.c
deleted file mode 100644
index eda3b14..0000000
--- a/tests/tcg/mips/mips32-dsp/dpsq_sa_l_w.c
+++ /dev/null
@@ -1,55 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, dsp;
-    int ach = 5, acl = 5;
-    int resulth, resultl, resultdsp;
-
-    rs      = 0xBC0123AD;
-    rt      = 0x01643721;
-    resulth = 0x00BD3A22;
-    resultl = 0xD138776B;
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
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 0x54321123;
-    acl = 5;
-    rs      = 0x80000000;
-    rt      = 0x80000000;
-
-    resulth = 0xd4321123;
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
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/dpsu_h_qbl.c b/tests/tcg/mips/mips32-dsp/dpsu_h_qbl.c
deleted file mode 100644
index 94e2bf6..0000000
--- a/tests/tcg/mips/mips32-dsp/dpsu_h_qbl.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int ach = 5, acl = 5;
-    int resulth, resultl;
-
-    rs      = 0xBC0123AD;
-    rt      = 0x01643721;
-    resulth = 0x04;
-    resultl = 0xFFFFFEE5;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsu.h.qbl $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/dpsu_h_qbr.c b/tests/tcg/mips/mips32-dsp/dpsu_h_qbr.c
deleted file mode 100644
index a1e6635..0000000
--- a/tests/tcg/mips/mips32-dsp/dpsu_h_qbr.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int ach = 5, acl = 5;
-    int resulth, resultl;
-
-    rs      = 0xBC0123AD;
-    rt      = 0x01643721;
-    resulth = 0x04;
-    resultl = 0xFFFFE233;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsu.h.qbr $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extp.c b/tests/tcg/mips/mips32-dsp/extp.c
deleted file mode 100644
index b18bdb3..0000000
--- a/tests/tcg/mips/mips32-dsp/extp.c
+++ /dev/null
@@ -1,62 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, ach, acl, dsp;
-    int result;
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
-    assert(dsp == 0);
-    assert(result == rt);
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
-    assert(dsp == 1);
-
-    ach = 0;
-    acl = 0x80000001;
-    dsp = 0x1F;
-    result = 0x80000001;
-
-    __asm
-        ("wrdsp %1\n\t"
-         "mthi %2, $ac2\n\t"
-         "mtlo %3, $ac2\n\t"
-         "extp %0, $ac2, 0x1F\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 14) & 0x01;
-    assert(dsp == 0);
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extpdp.c b/tests/tcg/mips/mips32-dsp/extpdp.c
deleted file mode 100644
index 79ee16e..0000000
--- a/tests/tcg/mips/mips32-dsp/extpdp.c
+++ /dev/null
@@ -1,64 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, ach, acl, dsp, pos, efi;
-    int result;
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
-    assert(pos == 3);
-    assert(efi == 0);
-    assert(result == rt);
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
-    assert(efi == 1);
-
-
-    ach = 0;
-    acl = 0;
-    dsp = 0;
-    result = 0;
-
-    __asm
-        ("wrdsp %1\n\t"
-         "mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extpdp %0, $ac1, 0x00\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "+r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    assert(dsp == 0x3F);
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extpdpv.c b/tests/tcg/mips/mips32-dsp/extpdpv.c
deleted file mode 100644
index f5774ee..0000000
--- a/tests/tcg/mips/mips32-dsp/extpdpv.c
+++ /dev/null
@@ -1,47 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs, ach, acl, dsp, pos, efi;
-    int result;
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
-    assert(pos == 3);
-    assert(efi == 0);
-    assert(result == rt);
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
-    assert(efi == 1);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extpv.c b/tests/tcg/mips/mips32-dsp/extpv.c
deleted file mode 100644
index 401b94a..0000000
--- a/tests/tcg/mips/mips32-dsp/extpv.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, ac, ach, acl, dsp;
-    int result;
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
-    assert(dsp == 0);
-    assert(result == rt);
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
-    assert(dsp == 1);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extr_r_w.c b/tests/tcg/mips/mips32-dsp/extr_r_w.c
deleted file mode 100644
index 489c193..0000000
--- a/tests/tcg/mips/mips32-dsp/extr_r_w.c
+++ /dev/null
@@ -1,94 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, ach, acl, dsp;
-    int result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    result = 0xA0001699;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_r.w %0, $ac1, 0x03\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 1);
-    assert(result == rt);
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0x3fffffff;
-    acl = 0x2bcdef01;
-    result = 0x7ffffffe;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_r.w %0, $ac1, 0x1F\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 0);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0xFFFFFFFF;
-    acl = 0xFFFFFFFF;
-    result = 0;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_r.w %0, $ac1, 0x1F\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-         );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 0);
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extr_rs_w.c b/tests/tcg/mips/mips32-dsp/extr_rs_w.c
deleted file mode 100644
index f9d2ed6..0000000
--- a/tests/tcg/mips/mips32-dsp/extr_rs_w.c
+++ /dev/null
@@ -1,117 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, ach, acl, dsp;
-    int result;
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
-    assert(dsp == 1);
-    assert(result == rt);
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0x3fffffff;
-    acl = 0x2bcdef01;
-    result = 0x7ffffffe;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_rs.w %0, $ac1, 0x1F\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 0);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0x80000000;
-    acl = 0x00000000;
-    result = 0x80000000;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_rs.w %0, $ac1, 0x1F\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 1);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0xFFFFFFFF;
-    acl = 0xFFFFFFFF;
-    result = 0;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_rs.w %0, $ac1, 0x1F\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-         );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 0);
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extr_s_h.c b/tests/tcg/mips/mips32-dsp/extr_s_h.c
deleted file mode 100644
index 9bc2a63..0000000
--- a/tests/tcg/mips/mips32-dsp/extr_s_h.c
+++ /dev/null
@@ -1,86 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, ach, acl, dsp;
-    int result;
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
-    assert(dsp == 1);
-    assert(result == rt);
-
-    ach = 0xffffffff;
-    acl = 0x12344321;
-    result = 0xFFFF8000;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_s.h %0, $ac1, 0x08\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 1);
-    assert(result == rt);
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    /* Clear dsp */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0x123;
-    acl = 0x87654321;
-    result = 0x1238;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr_s.h %0, $ac1, 28\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 0);
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extr_w.c b/tests/tcg/mips/mips32-dsp/extr_w.c
deleted file mode 100644
index cf92614..0000000
--- a/tests/tcg/mips/mips32-dsp/extr_w.c
+++ /dev/null
@@ -1,94 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, ach, acl, dsp;
-    int result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    result = 0xA0001699;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr.w %0, $ac1, 0x03\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 1);
-    assert(result == rt);
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0x3fffffff;
-    acl = 0x2bcdef01;
-    result = 0x7ffffffe;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr.w %0, $ac1, 0x1F\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-        );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 0);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    ach = 0xFFFFFFFF;
-    acl = 0xFFFFFFFF;
-    result = 0xFFFFFFFF;
-    __asm
-        ("mthi %2, $ac1\n\t"
-         "mtlo %3, $ac1\n\t"
-         "extr.w %0, $ac1, 0x1F\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rt), "=r"(dsp)
-         : "r"(ach), "r"(acl)
-         );
-    dsp = (dsp >> 23) & 0x01;
-    assert(dsp == 0);
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extrv_r_w.c b/tests/tcg/mips/mips32-dsp/extrv_r_w.c
deleted file mode 100644
index 2403b3a..0000000
--- a/tests/tcg/mips/mips32-dsp/extrv_r_w.c
+++ /dev/null
@@ -1,79 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs, ach, acl, dsp;
-    int result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x07;
-    rs  = 0x03;
-    result = 0xA0001699;
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
-    assert(dsp == 1);
-    assert(result == rt);
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 31;
-    ach = 0x3fffffff;
-    acl = 0x2bcdef01;
-    result = 0x7ffffffe;
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extrv_rs_w.c b/tests/tcg/mips/mips32-dsp/extrv_rs_w.c
deleted file mode 100644
index ccceeb9..0000000
--- a/tests/tcg/mips/mips32-dsp/extrv_rs_w.c
+++ /dev/null
@@ -1,77 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs, ach, acl, dsp;
-    int result;
-
-    rs = 0x03;
-    ach = 0x05;
-    acl = 0xB4CB;
-    result = 0x7FFFFFFF;
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
-    assert(dsp == 1);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 0x04;
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 0x1F;
-    ach = 0x3fffffff;
-    acl = 0x2bcdef01;
-    result = 0x7ffffffe;
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extrv_s_h.c b/tests/tcg/mips/mips32-dsp/extrv_s_h.c
deleted file mode 100644
index feac3e2..0000000
--- a/tests/tcg/mips/mips32-dsp/extrv_s_h.c
+++ /dev/null
@@ -1,88 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs, ach, acl, dsp;
-    int result;
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
-    assert(dsp == 1);
-    assert(result == rt);
-
-    rs = 0x08;
-    ach = 0xffffffff;
-    acl = 0x12344321;
-    result = 0xFFFF8000;
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
-    assert(dsp == 1);
-    assert(result == rt);
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    rs = 0x1C;
-    ach = 0x123;
-    acl = 0x87654321;
-    result = 0x1238;
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/extrv_w.c b/tests/tcg/mips/mips32-dsp/extrv_w.c
deleted file mode 100644
index 9e8b238..0000000
--- a/tests/tcg/mips/mips32-dsp/extrv_w.c
+++ /dev/null
@@ -1,80 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs, ach, acl, dsp;
-    int result;
-
-    ach = 0x05;
-    acl = 0xB4CB;
-    dsp = 0x07;
-    rs  = 0x03;
-    result = 0xA0001699;
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
-    assert(dsp == 1);
-    assert(result == rt);
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-    /* Clear dspcontrol */
-    dsp = 0;
-    __asm
-        ("wrdsp %0\n\t"
-         :
-         : "r"(dsp)
-        );
-
-    rs = 31;
-    ach = 0x3fffffff;
-    acl = 0x2bcdef01;
-    result = 0x7ffffffe;
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
-    assert(dsp == 0);
-    assert(result == rt);
-
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/insv.c b/tests/tcg/mips/mips32-dsp/insv.c
deleted file mode 100644
index 9d67469..0000000
--- a/tests/tcg/mips/mips32-dsp/insv.c
+++ /dev/null
@@ -1,36 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs, dsp;
-    int result;
-
-    /* msb = 10, lsb = 5 */
-    dsp    = 0x305;
-    rt     = 0x12345678;
-    rs     = 0x87654321;
-    result = 0x12345438;
-    __asm
-        ("wrdsp %2, 0x03\n\t"
-         "insv  %0, %1\n\t"
-         : "+r"(rt)
-         : "r"(rs), "r"(dsp)
-        );
-    assert(rt == result);
-
-    dsp    = 0x1000;
-    rt     = 0xF0F0F0F0;
-    rs     = 0xA5A5A5A5;
-    result = 0xA5A5A5A5;
-
-    __asm
-        ("wrdsp %2\n\t"
-         "insv  %0, %1\n\t"
-         : "+r"(rt)
-         : "r"(rs), "r"(dsp)
-        );
-    assert(rt == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/lbux.c b/tests/tcg/mips/mips32-dsp/lbux.c
deleted file mode 100644
index 2337abe..0000000
--- a/tests/tcg/mips/mips32-dsp/lbux.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include <stdio.h>
-#include <assert.h>
-
-int main(void)
-{
-    int value, rd;
-    int *p;
-    unsigned long addr, index;
-    int result;
-
-    value  = 0xBCDEF389;
-    p = &value;
-    addr = (unsigned long)p;
-    index  = 0;
-    result = value & 0xFF;
-    __asm
-        ("lbux %0, %1(%2)\n\t"
-         : "=r"(rd)
-         : "r"(index), "r"(addr)
-        );
-
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/lhx.c b/tests/tcg/mips/mips32-dsp/lhx.c
deleted file mode 100644
index 10be3b3..0000000
--- a/tests/tcg/mips/mips32-dsp/lhx.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include <stdio.h>
-#include <assert.h>
-
-int main(void)
-{
-    int value, rd;
-    int *p;
-    unsigned long addr, index;
-    int result;
-
-    value  = 0xBCDEF389;
-    p = &value;
-    addr = (unsigned long)p;
-    index  = 0;
-    result = 0xFFFFF389;
-    __asm
-        ("lhx %0, %1(%2)\n\t"
-         : "=r"(rd)
-         : "r"(index), "r"(addr)
-        );
-
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/lwx.c b/tests/tcg/mips/mips32-dsp/lwx.c
deleted file mode 100644
index e6543c9..0000000
--- a/tests/tcg/mips/mips32-dsp/lwx.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include <stdio.h>
-#include <assert.h>
-
-int main(void)
-{
-    int value, rd;
-    int *p;
-    unsigned long addr, index;
-    int result;
-
-    value  = 0xBCDEF389;
-    p = &value;
-    addr = (unsigned long)p;
-    index  = 0;
-    result = 0xBCDEF389;
-    __asm
-        ("lwx %0, %1(%2)\n\t"
-         : "=r"(rd)
-         : "r"(index), "r"(addr)
-        );
-
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/madd.c b/tests/tcg/mips/mips32-dsp/madd.c
deleted file mode 100644
index af4bfcf..0000000
--- a/tests/tcg/mips/mips32-dsp/madd.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs;
-    int achi, acli;
-    int acho, aclo;
-    int resulth, resultl;
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
-    assert(resulth == acho);
-    assert(resultl == aclo);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/maddu.c b/tests/tcg/mips/mips32-dsp/maddu.c
deleted file mode 100644
index af4bfcf..0000000
--- a/tests/tcg/mips/mips32-dsp/maddu.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs;
-    int achi, acli;
-    int acho, aclo;
-    int resulth, resultl;
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
-    assert(resulth == acho);
-    assert(resultl == aclo);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/main.c b/tests/tcg/mips/mips32-dsp/main.c
deleted file mode 100644
index b296b20..0000000
--- a/tests/tcg/mips/mips32-dsp/main.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include<stdio.h>
-
-int main()
-{
-    printf("hello world\n");
-}
diff --git a/tests/tcg/mips/mips32-dsp/maq_s_w_phl.c b/tests/tcg/mips/mips32-dsp/maq_s_w_phl.c
deleted file mode 100644
index 0f7c070..0000000
--- a/tests/tcg/mips/mips32-dsp/maq_s_w_phl.c
+++ /dev/null
@@ -1,55 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs;
-    int achi, acli;
-    int dsp;
-    int acho, aclo;
-    int resulth, resultl;
-    int resdsp;
-
-    achi = 0x00000005;
-    acli = 0x0000B4CB;
-    rs  = 0xFF060000;
-    rt  = 0xCB000000;
-    resulth = 0x00000005;
-    resultl = 0x006838CB;
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
-    assert(resulth == acho);
-    assert(resultl == aclo);
-
-    achi = 0x00000006;
-    acli = 0x0000B4CB;
-    rs  = 0x80000000;
-    rt  = 0x80000000;
-    resulth = 0x00000006;
-    resultl = 0x8000B4CA;
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
-    assert(resulth == acho);
-    assert(resultl == aclo);
-    assert(((dsp >> 17) & 0x01) == resdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/maq_s_w_phr.c b/tests/tcg/mips/mips32-dsp/maq_s_w_phr.c
deleted file mode 100644
index 942722a..0000000
--- a/tests/tcg/mips/mips32-dsp/maq_s_w_phr.c
+++ /dev/null
@@ -1,55 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs;
-    int achi, acli;
-    int dsp;
-    int acho, aclo;
-    int resulth, resultl;
-    int resdsp;
-
-    achi = 0x00000005;
-    acli = 0x0000B4CB;
-    rs  = 0x0000FF06;
-    rt  = 0x0000CB00;
-    resulth = 0x00000005;
-    resultl = 0x006838CB;
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
-    assert(resulth == acho);
-    assert(resultl == aclo);
-
-    achi = 0x00000006;
-    acli = 0x0000B4CB;
-    rs  = 0x00008000;
-    rt  = 0x00008000;
-    resulth = 0x00000006;
-    resultl = 0x8000B4CA;
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
-    assert(resulth == acho);
-    assert(resultl == aclo);
-    assert(((dsp >> 17) & 0x01) == resdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/maq_sa_w_phl.c b/tests/tcg/mips/mips32-dsp/maq_sa_w_phl.c
deleted file mode 100644
index d83dce6..0000000
--- a/tests/tcg/mips/mips32-dsp/maq_sa_w_phl.c
+++ /dev/null
@@ -1,55 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs;
-    int achi, acli;
-    int dsp;
-    int acho, aclo;
-    int resulth, resultl;
-    int resdsp;
-
-    achi = 0x00000000;
-    acli = 0x0000B4CB;
-    rs = 0xFF060000;
-    rt = 0xCB000000;
-    resulth = 0x00000000;
-    resultl = 0x006838CB;
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
-    assert(resulth == acho);
-    assert(resultl == aclo);
-
-    achi = 0x00000000;
-    acli = 0x0000B4CB;
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
-    assert(resulth == acho);
-    assert(resultl == aclo);
-    assert(((dsp >> 17) & 0x01) == 0x01);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/maq_sa_w_phr.c b/tests/tcg/mips/mips32-dsp/maq_sa_w_phr.c
deleted file mode 100644
index d233111..0000000
--- a/tests/tcg/mips/mips32-dsp/maq_sa_w_phr.c
+++ /dev/null
@@ -1,55 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rt, rs;
-    int achi, acli;
-    int dsp;
-    int acho, aclo;
-    int resulth, resultl;
-    int resdsp;
-
-    achi = 0x00000000;
-    acli = 0x0000B4CB;
-    rs  = 0x0000FF06;
-    rt  = 0x0000CB00;
-    resulth = 0x00000000;
-    resultl = 0x006838CB;
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
-    assert(resulth == acho);
-    assert(resultl == aclo);
-
-    achi = 0x00000000;
-    acli = 0x0000B4CB;
-    rs  = 0x00008000;
-    rt  = 0x00008000;
-    resulth = 0x00000000;
-    resultl = 0x7FFFFFFF;
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
-    assert(resulth == acho);
-    assert(resultl == aclo);
-    assert(((dsp >> 17) & 0x01) == 0x01);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/mfhi.c b/tests/tcg/mips/mips32-dsp/mfhi.c
deleted file mode 100644
index 43a8066..0000000
--- a/tests/tcg/mips/mips32-dsp/mfhi.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int achi, acho;
-    int result;
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
-    assert(result == acho);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/mflo.c b/tests/tcg/mips/mips32-dsp/mflo.c
deleted file mode 100644
index caeafdb..0000000
--- a/tests/tcg/mips/mips32-dsp/mflo.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int acli, aclo;
-    int result;
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
-    assert(result == aclo);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/modsub.c b/tests/tcg/mips/mips32-dsp/modsub.c
deleted file mode 100644
index c294eeb..0000000
--- a/tests/tcg/mips/mips32-dsp/modsub.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
-
-    rs     = 0xFFFFFFFF;
-    rt     = 0x000000FF;
-    result = 0xFFFFFF00;
-    __asm
-        ("modsub %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-
-    rs     = 0x00000000;
-    rt     = 0x00CD1FFF;
-    result = 0x0000CD1F;
-    __asm
-        ("modsub %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/msub.c b/tests/tcg/mips/mips32-dsp/msub.c
deleted file mode 100644
index 5779e6f..0000000
--- a/tests/tcg/mips/mips32-dsp/msub.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int achi, acli, rs, rt;
-    int acho, aclo;
-    int resulth, resultl;
-
-    rs      = 0x00BBAACC;
-    rt      = 0x0B1C3D2F;
-    achi    = 0x00004433;
-    acli    = 0xFFCC0011;
-    resulth = 0xFFF81F29;
-    resultl = 0xB355089D;
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
-    assert(acho == resulth);
-    assert(aclo == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/msubu.c b/tests/tcg/mips/mips32-dsp/msubu.c
deleted file mode 100644
index e0f9b5a..0000000
--- a/tests/tcg/mips/mips32-dsp/msubu.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int achi, acli, rs, rt;
-    int acho, aclo;
-    int resulth, resultl;
-
-    rs      = 0x00BBAACC;
-    rt      = 0x0B1C3D2F;
-    achi    = 0x00004433;
-    acli    = 0xFFCC0011;
-    resulth = 0xFFF81F29;
-    resultl = 0xB355089D;
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
-    assert(acho == resulth);
-    assert(aclo == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/mthi.c b/tests/tcg/mips/mips32-dsp/mthi.c
deleted file mode 100644
index 43a8066..0000000
--- a/tests/tcg/mips/mips32-dsp/mthi.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int achi, acho;
-    int result;
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
-    assert(result == acho);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/mthlip.c b/tests/tcg/mips/mips32-dsp/mthlip.c
deleted file mode 100644
index 85f94d8..0000000
--- a/tests/tcg/mips/mips32-dsp/mthlip.c
+++ /dev/null
@@ -1,58 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, ach, acl, dsp;
-    int result, resulth, resultl;
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
-    assert(dsp == result);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    dsp = 0x1f;
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
-    assert(dsp == result);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/mtlo.c b/tests/tcg/mips/mips32-dsp/mtlo.c
deleted file mode 100644
index caeafdb..0000000
--- a/tests/tcg/mips/mips32-dsp/mtlo.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int acli, aclo;
-    int result;
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
-    assert(result == aclo);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/muleq_s_w_phl.c b/tests/tcg/mips/mips32-dsp/muleq_s_w_phl.c
deleted file mode 100644
index b3a5370..0000000
--- a/tests/tcg/mips/mips32-dsp/muleq_s_w_phl.c
+++ /dev/null
@@ -1,41 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x80001234;
-    rt = 0x80001234;
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
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    rs = 0x12349988;
-    rt = 0x43219988;
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
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    return 0;
-}
-
diff --git a/tests/tcg/mips/mips32-dsp/muleq_s_w_phr.c b/tests/tcg/mips/mips32-dsp/muleq_s_w_phr.c
deleted file mode 100644
index 8066d7d..0000000
--- a/tests/tcg/mips/mips32-dsp/muleq_s_w_phr.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
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
-    assert(rd  == result);
-    assert(dsp == resultdsp);
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
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/muleu_s_ph_qbl.c b/tests/tcg/mips/mips32-dsp/muleu_s_ph_qbl.c
deleted file mode 100644
index 66a3828..0000000
--- a/tests/tcg/mips/mips32-dsp/muleu_s_ph_qbl.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x80001234;
-    rt = 0x80004321;
-    result = 0xFFFF0000;
-    resultdsp = 1;
-
-    __asm
-        ("muleu_s.ph.qbl %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/muleu_s_ph_qbr.c b/tests/tcg/mips/mips32-dsp/muleu_s_ph_qbr.c
deleted file mode 100644
index 4cc6c8f..0000000
--- a/tests/tcg/mips/mips32-dsp/muleu_s_ph_qbr.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x8000;
-    rt = 0x80004321;
-    result = 0xFFFF0000;
-    resultdsp = 1;
-
-    __asm
-        ("muleu_s.ph.qbr %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/mulq_rs_ph.c b/tests/tcg/mips/mips32-dsp/mulq_rs_ph.c
deleted file mode 100644
index 370c2a8..0000000
--- a/tests/tcg/mips/mips32-dsp/mulq_rs_ph.c
+++ /dev/null
@@ -1,42 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x80001234;
-    rt = 0x80004321;
-    result = 0x7FFF098C;
-    resultdsp = 1;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "mulq_rs.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    rs = 0x80011234;
-    rt = 0x80024321;
-    result = 0x7FFD098C;
-    resultdsp = 0;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "mulq_rs.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/mult.c b/tests/tcg/mips/mips32-dsp/mult.c
deleted file mode 100644
index 15e6fde..0000000
--- a/tests/tcg/mips/mips32-dsp/mult.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, ach, acl;
-    int result, resulth, resultl;
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
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/multu.c b/tests/tcg/mips/mips32-dsp/multu.c
deleted file mode 100644
index 85d36c1..0000000
--- a/tests/tcg/mips/mips32-dsp/multu.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, ach, acl;
-    int result, resulth, resultl;
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
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/packrl_ph.c b/tests/tcg/mips/mips32-dsp/packrl_ph.c
deleted file mode 100644
index 1f8e699..0000000
--- a/tests/tcg/mips/mips32-dsp/packrl_ph.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/pick_ph.c b/tests/tcg/mips/mips32-dsp/pick_ph.c
deleted file mode 100644
index 929a002..0000000
--- a/tests/tcg/mips/mips32-dsp/pick_ph.c
+++ /dev/null
@@ -1,49 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result;
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
-    assert(rd == result);
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
-    assert(rd == result);
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    dsp = 0x00000000;
-    result = 0x87654321;
-
-    __asm
-        ("wrdsp %3, 0x10\n\t"
-         "pick.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt), "r"(dsp)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/pick_qb.c b/tests/tcg/mips/mips32-dsp/pick_qb.c
deleted file mode 100644
index a790475..0000000
--- a/tests/tcg/mips/mips32-dsp/pick_qb.c
+++ /dev/null
@@ -1,36 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result;
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
-    assert(rd == result);
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    dsp = 0x00000000;
-    result = 0x87654321;
-
-    __asm
-        ("wrdsp %3, 0x10\n\t"
-         "pick.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt), "r"(dsp)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/preceq_w_phl.c b/tests/tcg/mips/mips32-dsp/preceq_w_phl.c
deleted file mode 100644
index bf70bf7..0000000
--- a/tests/tcg/mips/mips32-dsp/preceq_w_phl.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x87654321;
-    result = 0x87650000;
-
-    __asm
-        ("preceq.w.phl %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/preceq_w_phr.c b/tests/tcg/mips/mips32-dsp/preceq_w_phr.c
deleted file mode 100644
index 3f885ef..0000000
--- a/tests/tcg/mips/mips32-dsp/preceq_w_phr.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x87654321;
-    result = 0x43210000;
-
-    __asm
-        ("preceq.w.phr %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbl.c b/tests/tcg/mips/mips32-dsp/precequ_ph_qbl.c
deleted file mode 100644
index 63b7a95..0000000
--- a/tests/tcg/mips/mips32-dsp/precequ_ph_qbl.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x87654321;
-    result = 0x43803280;
-
-    __asm
-        ("precequ.ph.qbl %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbla.c b/tests/tcg/mips/mips32-dsp/precequ_ph_qbla.c
deleted file mode 100644
index 31627f0..0000000
--- a/tests/tcg/mips/mips32-dsp/precequ_ph_qbla.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x87654321;
-    result = 0x43802180;
-
-    __asm
-        ("precequ.ph.qbla %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbr.c b/tests/tcg/mips/mips32-dsp/precequ_ph_qbr.c
deleted file mode 100644
index b6f72d3..0000000
--- a/tests/tcg/mips/mips32-dsp/precequ_ph_qbr.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x87654321;
-    result = 0x21801080;
-
-    __asm
-        ("precequ.ph.qbr %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbra.c b/tests/tcg/mips/mips32-dsp/precequ_ph_qbra.c
deleted file mode 100644
index 4764fd0..0000000
--- a/tests/tcg/mips/mips32-dsp/precequ_ph_qbra.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x87654321;
-    result = 0x32801080;
-
-    __asm
-        ("precequ.ph.qbra %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbl.c b/tests/tcg/mips/mips32-dsp/preceu_ph_qbl.c
deleted file mode 100644
index fa95c26..0000000
--- a/tests/tcg/mips/mips32-dsp/preceu_ph_qbl.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x87654321;
-    result = 0x00870065;
-
-    __asm
-        ("preceu.ph.qbl %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbla.c b/tests/tcg/mips/mips32-dsp/preceu_ph_qbla.c
deleted file mode 100644
index 021f21a..0000000
--- a/tests/tcg/mips/mips32-dsp/preceu_ph_qbla.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x87654321;
-    result = 0x00870043;
-
-    __asm
-        ("preceu.ph.qbla %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbr.c b/tests/tcg/mips/mips32-dsp/preceu_ph_qbr.c
deleted file mode 100644
index 03df18c..0000000
--- a/tests/tcg/mips/mips32-dsp/preceu_ph_qbr.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x87654321;
-    result = 0x00430021;
-
-    __asm
-        ("preceu.ph.qbr %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbra.c b/tests/tcg/mips/mips32-dsp/preceu_ph_qbra.c
deleted file mode 100644
index 6343276..0000000
--- a/tests/tcg/mips/mips32-dsp/preceu_ph_qbra.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x87654321;
-    result = 0x00650021;
-
-    __asm
-        ("preceu.ph.qbra %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/precrq_ph_w.c b/tests/tcg/mips/mips32-dsp/precrq_ph_w.c
deleted file mode 100644
index 25d45f1..0000000
--- a/tests/tcg/mips/mips32-dsp/precrq_ph_w.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/precrq_qb_ph.c b/tests/tcg/mips/mips32-dsp/precrq_qb_ph.c
deleted file mode 100644
index fe23acc..0000000
--- a/tests/tcg/mips/mips32-dsp/precrq_qb_ph.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/precrq_rs_ph_w.c b/tests/tcg/mips/mips32-dsp/precrq_rs_ph_w.c
deleted file mode 100644
index da6845b..0000000
--- a/tests/tcg/mips/mips32-dsp/precrq_rs_ph_w.c
+++ /dev/null
@@ -1,51 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x12348765;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "precrq_rs.ph.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-
-    rs = 0x7FFFC678;
-    rt = 0x865432A0;
-    result = 0x7FFF8654;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "precrq_rs.ph.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    assert(((dsp >> 22) & 0x01) == 1);
-    assert(result == rd);
-
-    rs = 0xBEEFFEED;
-    rt = 0x7FFF8000;
-    result = 0xBEF07FFF;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "precrq_rs.ph.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    assert(((dsp >> 22) & 0x01) == 1);
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/precrqu_s_qb_ph.c b/tests/tcg/mips/mips32-dsp/precrqu_s_qb_ph.c
deleted file mode 100644
index 7481d5a..0000000
--- a/tests/tcg/mips/mips32-dsp/precrqu_s_qb_ph.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
-
-    rs = 0x12345678;
-    rt = 0x87657FFF;
-    result = 0x24AC00FF;
-
-    __asm
-        ("precrqu_s.qb.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    assert(result == rd);
-    assert(((dsp >> 22) & 0x01) == 0x01);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/raddu_w_qb.c b/tests/tcg/mips/mips32-dsp/raddu_w_qb.c
deleted file mode 100644
index 77a983c..0000000
--- a/tests/tcg/mips/mips32-dsp/raddu_w_qb.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs;
-    int result;
-
-    rs = 0x12345678;
-    result = 0x114;
-
-    __asm
-        ("raddu.w.qb %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rs)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/rddsp.c b/tests/tcg/mips/mips32-dsp/rddsp.c
deleted file mode 100644
index 2f30285..0000000
--- a/tests/tcg/mips/mips32-dsp/rddsp.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int dsp_i, dsp_o;
-    int ccond_i, outflag_i, efi_i, c_i, scount_i, pos_i;
-    int ccond_o, outflag_o, efi_o, c_o, scount_o, pos_o;
-
-    ccond_i   = 0x0000000C;  /* 4 */
-    outflag_i = 0x0000001B;  /* 3 */
-    efi_i     = 0x00000001;  /* 5 */
-    c_i       = 0x00000001;  /* 2 */
-    scount_i  = 0x0000000F;  /* 1 */
-    pos_i     = 0x0000000C;  /* 0 */
-
-    dsp_i = (ccond_i   << 24) | \
-            (outflag_i << 16) | \
-            (efi_i     << 14) | \
-            (c_i       << 13) | \
-            (scount_i  <<  7) | \
-            pos_i;
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
-    assert(ccond_o   == ccond_i);
-    assert(outflag_o == outflag_i);
-    assert(efi_o     == efi_i);
-    assert(c_o       == c_i);
-    assert(scount_o  == scount_i);
-    assert(pos_o     == pos_i);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/repl_ph.c b/tests/tcg/mips/mips32-dsp/repl_ph.c
deleted file mode 100644
index 2107495..0000000
--- a/tests/tcg/mips/mips32-dsp/repl_ph.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, result;
-
-    result = 0x01BF01BF;
-    __asm
-        ("repl.ph %0, 0x1BF\n\t"
-         : "=r"(rd)
-        );
-    assert(rd == result);
-
-    result = 0x01FF01FF;
-    __asm
-        ("repl.ph %0, 0x01FF\n\t"
-         : "=r"(rd)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/repl_qb.c b/tests/tcg/mips/mips32-dsp/repl_qb.c
deleted file mode 100644
index 6631393..0000000
--- a/tests/tcg/mips/mips32-dsp/repl_qb.c
+++ /dev/null
@@ -1,16 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, result;
-
-    result = 0xBFBFBFBF;
-    __asm
-        ("repl.qb %0, 0xBF\n\t"
-         : "=r"(rd)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/replv_ph.c b/tests/tcg/mips/mips32-dsp/replv_ph.c
deleted file mode 100644
index 07fb15f..0000000
--- a/tests/tcg/mips/mips32-dsp/replv_ph.c
+++ /dev/null
@@ -1,19 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x12345678;
-    result = 0x56785678;
-    __asm
-        ("replv.ph %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/replv_qb.c b/tests/tcg/mips/mips32-dsp/replv_qb.c
deleted file mode 100644
index dd1271f..0000000
--- a/tests/tcg/mips/mips32-dsp/replv_qb.c
+++ /dev/null
@@ -1,19 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt     = 0x12345678;
-    result = 0x78787878;
-    __asm
-        ("replv.qb %0, %1\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shilo.c b/tests/tcg/mips/mips32-dsp/shilo.c
deleted file mode 100644
index ce8ebc6..0000000
--- a/tests/tcg/mips/mips32-dsp/shilo.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int ach, acl;
-    int resulth, resultl;
-
-    ach = 0xBBAACCFF;
-    acl = 0x1C3B001D;
-
-    resulth = 0x17755;
-    resultl = 0x99fe3876;
-
-    __asm
-        ("mthi %0, $ac1\n\t"
-         "mtlo %1, $ac1\n\t"
-         "shilo $ac1, 0x0F\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-
-    ach = 0x1;
-    acl = 0x80000000;
-
-    resulth = 0x3;
-    resultl = 0x0;
-
-    __asm
-        ("mthi %0, $ac1\n\t"
-         "mtlo %1, $ac1\n\t"
-         "shilo $ac1, -1\n\t"
-         "mfhi %0, $ac1\n\t"
-         "mflo %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shilov.c b/tests/tcg/mips/mips32-dsp/shilov.c
deleted file mode 100644
index e1d6cea..0000000
--- a/tests/tcg/mips/mips32-dsp/shilov.c
+++ /dev/null
@@ -1,49 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, ach, acl;
-    int resulth, resultl;
-
-    rs  = 0x0F;
-    ach = 0xBBAACCFF;
-    acl = 0x1C3B001D;
-
-    resulth = 0x17755;
-    resultl = 0x99fe3876;
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
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-
-    rs  = 0xffffffff;
-    ach = 0x1;
-    acl = 0x80000000;
-
-    resulth = 0x3;
-    resultl = 0x0;
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
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shll_ph.c b/tests/tcg/mips/mips32-dsp/shll_ph.c
deleted file mode 100644
index 5fa58cc..0000000
--- a/tests/tcg/mips/mips32-dsp/shll_ph.c
+++ /dev/null
@@ -1,55 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt, dsp;
-    int result, resultdsp;
-
-    rt        = 0x12345678;
-    result    = 0xA000C000;
-    resultdsp = 1;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "shll.ph %0, %2, 0x0B\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rt        = 0x7fff8000;
-    result    = 0xfffe0000;
-    resultdsp = 1;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "shll.ph %0, %2, 0x01\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rt        = 0x00000001;
-    result    = 0x00008000;
-    resultdsp = 1;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "shll.ph %0, %2, 0x0F\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shll_qb.c b/tests/tcg/mips/mips32-dsp/shll_qb.c
deleted file mode 100644
index 729716d..0000000
--- a/tests/tcg/mips/mips32-dsp/shll_qb.c
+++ /dev/null
@@ -1,55 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt, dsp;
-    int result, resultdsp;
-
-    rt     = 0x87654321;
-    result  = 0x87654321;
-    resultdsp = 0x00;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "shll.qb %0, %2, 0x00\n\t"
-         "rddsp   %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd == result);
-
-    rt     = 0x87654321;
-    result = 0x38281808;
-    resultdsp = 0x01;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "shll.qb %0, %2, 0x03\n\t"
-         "rddsp   %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd == result);
-
-    rt     = 0x00000001;
-    result = 0x00000080;
-    resultdsp = 0x00;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "shll.qb %0, %2, 0x07\n\t"
-         "rddsp   %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shll_s_ph.c b/tests/tcg/mips/mips32-dsp/shll_s_ph.c
deleted file mode 100644
index 910fea3..0000000
--- a/tests/tcg/mips/mips32-dsp/shll_s_ph.c
+++ /dev/null
@@ -1,24 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt, dsp;
-    int result, resultdsp;
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
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shll_s_w.c b/tests/tcg/mips/mips32-dsp/shll_s_w.c
deleted file mode 100644
index 628c752..0000000
--- a/tests/tcg/mips/mips32-dsp/shll_s_w.c
+++ /dev/null
@@ -1,52 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt, dsp;
-    int result, resultdsp;
-
-    rt        = 0x82345678;
-    result    = 0x82345678;
-    resultdsp = 0x00;
-
-    __asm
-        ("shll_s.w %0, %2, 0x0\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rt        = 0x82345678;
-    result    = 0x80000000;
-    resultdsp = 0x01;
-
-    __asm
-        ("shll_s.w %0, %2, 0x0B\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
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
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shllv_ph.c b/tests/tcg/mips/mips32-dsp/shllv_ph.c
deleted file mode 100644
index f98a632..0000000
--- a/tests/tcg/mips/mips32-dsp/shllv_ph.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs        = 0x0;
-    rt        = 0x12345678;
-    result    = 0x12345678;
-    resultdsp = 0;
-
-    __asm
-        ("shllv.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rs        = 0x0B;
-    rt        = 0x12345678;
-    result    = 0xA000C000;
-    resultdsp = 1;
-
-    __asm
-        ("shllv.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shllv_qb.c b/tests/tcg/mips/mips32-dsp/shllv_qb.c
deleted file mode 100644
index 6d8ff4a..0000000
--- a/tests/tcg/mips/mips32-dsp/shllv_qb.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
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
-    assert(rd == result);
-
-    rs     = 0x00;
-    rt     = 0x87654321;
-    result = 0x87654321;
-    resultdsp = 0x01;
-
-    __asm
-        ("shllv.qb %0, %2, %3\n\t"
-         "rddsp   %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shllv_s_ph.c b/tests/tcg/mips/mips32-dsp/shllv_s_ph.c
deleted file mode 100644
index fc9bd32..0000000
--- a/tests/tcg/mips/mips32-dsp/shllv_s_ph.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs        = 0x0;
-    rt        = 0x12345678;
-    result    = 0x12345678;
-    resultdsp = 0x0;
-
-    __asm
-        ("shllv_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
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
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shllv_s_w.c b/tests/tcg/mips/mips32-dsp/shllv_s_w.c
deleted file mode 100644
index 350c256..0000000
--- a/tests/tcg/mips/mips32-dsp/shllv_s_w.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
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
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rs        = 0x0;
-    rt        = 0x12345678;
-    result    = 0x12345678;
-    resultdsp = 0x01;
-
-    __asm
-        ("shllv_s.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rt), "r"(rs)
-        );
-    dsp = (dsp >> 22) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shra_ph.c b/tests/tcg/mips/mips32-dsp/shra_ph.c
deleted file mode 100644
index 5b2d840..0000000
--- a/tests/tcg/mips/mips32-dsp/shra_ph.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt     = 0x87654321;
-    result = 0xF0EC0864;
-
-    __asm
-        ("shra.ph %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    rt     = 0x87654321;
-    result = 0x87654321;
-
-    __asm
-        ("shra.ph %0, %1, 0x00\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shra_r_ph.c b/tests/tcg/mips/mips32-dsp/shra_r_ph.c
deleted file mode 100644
index adc4ae6..0000000
--- a/tests/tcg/mips/mips32-dsp/shra_r_ph.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt     = 0x87654321;
-    result = 0xF0ED0864;
-
-    __asm
-        ("shra_r.ph %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    rt     = 0x87654321;
-    result = 0x87654321;
-
-    __asm
-        ("shra_r.ph %0, %1, 0x00\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shra_r_w.c b/tests/tcg/mips/mips32-dsp/shra_r_w.c
deleted file mode 100644
index ec0cf2c..0000000
--- a/tests/tcg/mips/mips32-dsp/shra_r_w.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt     = 0x87654321;
-    result = 0xF0ECA864;
-
-    __asm
-        ("shra_r.w %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    rt     = 0x87654321;
-    result = 0x87654321;
-
-    __asm
-        ("shra_r.w %0, %1, 0x0\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shrav_ph.c b/tests/tcg/mips/mips32-dsp/shrav_ph.c
deleted file mode 100644
index 6e42aaf..0000000
--- a/tests/tcg/mips/mips32-dsp/shrav_ph.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
-
-    rs     = 0x03;
-    rt     = 0x87654321;
-    result = 0xF0EC0864;
-
-    __asm
-        ("shrav.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    assert(rd == result);
-
-    rs     = 0x00;
-    rt     = 0x87654321;
-    result = 0x87654321;
-
-    __asm
-        ("shrav.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shrav_r_ph.c b/tests/tcg/mips/mips32-dsp/shrav_r_ph.c
deleted file mode 100644
index f03b978..0000000
--- a/tests/tcg/mips/mips32-dsp/shrav_r_ph.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
-
-    rs     = 0x03;
-    rt     = 0x87654321;
-    result = 0xF0ED0864;
-
-    __asm
-        ("shrav_r.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    assert(rd == result);
-
-    rs     = 0x00;
-    rt     = 0x87654321;
-    result = 0x87654321;
-
-    __asm
-        ("shrav_r.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shrav_r_w.c b/tests/tcg/mips/mips32-dsp/shrav_r_w.c
deleted file mode 100644
index 2ab03bb..0000000
--- a/tests/tcg/mips/mips32-dsp/shrav_r_w.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
-
-    rs     = 0x03;
-    rt     = 0x87654321;
-    result = 0xF0ECA864;
-
-    __asm
-        ("shrav_r.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    assert(rd == result);
-
-    rs     = 0x00;
-    rt     = 0x40000000;
-    result = 0x40000000;
-
-    __asm
-        ("shrav_r.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-
-    assert(rd == result);
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shrl_qb.c b/tests/tcg/mips/mips32-dsp/shrl_qb.c
deleted file mode 100644
index a7e4e6a..0000000
--- a/tests/tcg/mips/mips32-dsp/shrl_qb.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt     = 0x12345678;
-    result = 0x00010203;
-
-    __asm
-        ("shrl.qb %0, %1, 0x05\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    rt     = 0x12345678;
-    result = 0x12345678;
-
-    __asm
-        ("shrl.qb %0, %1, 0x0\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/shrlv_qb.c b/tests/tcg/mips/mips32-dsp/shrlv_qb.c
deleted file mode 100644
index db77f6d..0000000
--- a/tests/tcg/mips/mips32-dsp/shrlv_qb.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    rs     = 0x00;
-    rt     = 0x12345678;
-    result = 0x12345678;
-
-    __asm
-        ("shrlv.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/subq_ph.c b/tests/tcg/mips/mips32-dsp/subq_ph.c
deleted file mode 100644
index fdd7b38..0000000
--- a/tests/tcg/mips/mips32-dsp/subq_ph.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x77777777;
-    rt = 0x67654321;
-    result    = 0x10123456;
-    resultdsp = 0x0;
-
-    __asm
-        ("subq.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result    = 0x8ACF1357;
-    resultdsp = 0x01;
-
-    __asm
-        ("subq.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/subq_s_ph.c b/tests/tcg/mips/mips32-dsp/subq_s_ph.c
deleted file mode 100644
index 64c89eb..0000000
--- a/tests/tcg/mips/mips32-dsp/subq_s_ph.c
+++ /dev/null
@@ -1,58 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result    = 0x7FFF1357;
-    resultdsp = 0x01;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "subq_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rs = 0x12348000;
-    rt = 0x87657000;
-    result    = 0x7FFF8000;
-    resultdsp = 0x01;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "subq_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rs = 0x12340000;
-    rt = 0x87658000;
-    result    = 0x7FFF7FFF;
-    resultdsp = 0x01;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "subq_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/subq_s_w.c b/tests/tcg/mips/mips32-dsp/subq_s_w.c
deleted file mode 100644
index 9d456a9..0000000
--- a/tests/tcg/mips/mips32-dsp/subq_s_w.c
+++ /dev/null
@@ -1,74 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result    = 0x7FFFFFFF;
-    resultdsp = 0x01;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "subq_s.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rs = 0x66666;
-    rt = 0x55555;
-    result    = 0x11111;
-    resultdsp = 0x0;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "subq_s.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rs = 0x0;
-    rt = 0x80000000;
-    result    = 0x7FFFFFFF;
-    resultdsp = 0x01;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "subq_s.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    rs = 0x80000000;
-    rt = 0x80000000;
-    result    = 0;
-    resultdsp = 0x00;
-
-    __asm
-        ("wrdsp $0\n\t"
-         "subq_s.w %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/subu_qb.c b/tests/tcg/mips/mips32-dsp/subu_qb.c
deleted file mode 100644
index 4209096..0000000
--- a/tests/tcg/mips/mips32-dsp/subu_qb.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result    = 0x8BCF1357;
-    resultdsp = 0x01;
-
-    __asm
-        ("subu.qb %0, %2, %3\n\t"
-         "rddsp   %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/subu_s_qb.c b/tests/tcg/mips/mips32-dsp/subu_s_qb.c
deleted file mode 100644
index 3d65053..0000000
--- a/tests/tcg/mips/mips32-dsp/subu_s_qb.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
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
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dsp/wrdsp.c b/tests/tcg/mips/mips32-dsp/wrdsp.c
deleted file mode 100644
index dc54943..0000000
--- a/tests/tcg/mips/mips32-dsp/wrdsp.c
+++ /dev/null
@@ -1,46 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int dsp_i, dsp_o;
-    int ccond_i, outflag_i, efi_i, c_i, scount_i, pos_i;
-    int ccond_o, outflag_o, efi_o, c_o, scount_o, pos_o;
-
-    ccond_i   = 0x000000BC;  /* 4 */
-    outflag_i = 0x0000001B;  /* 3 */
-    efi_i     = 0x00000001;  /* 5 */
-    c_i       = 0x00000001;  /* 2 */
-    scount_i  = 0x0000000F;  /* 1 */
-    pos_i     = 0x0000000C;  /* 0 */
-
-    dsp_i = (ccond_i   << 24) | \
-            (outflag_i << 16) | \
-            (efi_i     << 14) | \
-            (c_i       << 13) | \
-            (scount_i  <<  7) | \
-            pos_i;
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
-    assert(ccond_o   == (ccond_i & 0x0F));
-    assert(outflag_o == outflag_i);
-    assert(efi_o     == efi_i);
-    assert(c_o       == c_i);
-    assert(scount_o  == scount_i);
-    assert(pos_o     == pos_i);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/absq_s_qb.c b/tests/tcg/mips/mips32-dspr2/absq_s_qb.c
deleted file mode 100644
index af4683f..0000000
--- a/tests/tcg/mips/mips32-dspr2/absq_s_qb.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int input, result, dsp;
-    int hope;
-
-    input = 0x701BA35E;
-    hope  = 0x701B5D5E;
-
-    __asm
-        ("absq_s.qb %0, %1\n\t"
-         : "=r"(result)
-         : "r"(input)
-        );
-    assert(result == hope);
-
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
-    assert(dsp == 1);
-    assert(result == hope);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_ph.c b/tests/tcg/mips/mips32-dspr2/addqh_ph.c
deleted file mode 100644
index 921f0ea..0000000
--- a/tests/tcg/mips/mips32-dspr2/addqh_ph.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
-
-    rs     = 0x706A13FE;
-    rt     = 0x13065174;
-    result = 0x41B832B9;
-    __asm
-        ("addqh.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    rs     = 0x81000100;
-    rt     = 0xc2000100;
-    result = 0xa1800100;
-    __asm
-        ("addqh.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_r_ph.c b/tests/tcg/mips/mips32-dspr2/addqh_r_ph.c
deleted file mode 100644
index 213ba37..0000000
--- a/tests/tcg/mips/mips32-dspr2/addqh_r_ph.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
-
-    rs     = 0x706A13FE;
-    rt     = 0x13065174;
-    result = 0x41B832B9;
-    __asm
-        ("addqh_r.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    rs     = 0x81010100;
-    rt     = 0xc2000100;
-    result = 0xa1810100;
-    __asm
-        ("addqh_r.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_r_w.c b/tests/tcg/mips/mips32-dspr2/addqh_r_w.c
deleted file mode 100644
index 75a75c5..0000000
--- a/tests/tcg/mips/mips32-dspr2/addqh_r_w.c
+++ /dev/null
@@ -1,34 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_w.c b/tests/tcg/mips/mips32-dspr2/addqh_w.c
deleted file mode 100644
index de6926e..0000000
--- a/tests/tcg/mips/mips32-dspr2/addqh_w.c
+++ /dev/null
@@ -1,34 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    rs     = 0xFFFFFFFE;
-    rt     = 0x00000001;
-    result = 0xFFFFFFFF;
-
-    __asm
-        ("addqh.w  %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/addu_ph.c b/tests/tcg/mips/mips32-dspr2/addu_ph.c
deleted file mode 100644
index 1d7a25a..0000000
--- a/tests/tcg/mips/mips32-dspr2/addu_ph.c
+++ /dev/null
@@ -1,33 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
-
-    rs     = 0x00FF00FF;
-    rt     = 0x00010001;
-    result = 0x01000100;
-    __asm
-        ("addu.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
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
-    assert(rd == result);
-    assert(((dsp >> 20) & 0x01) == 1);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/addu_s_ph.c b/tests/tcg/mips/mips32-dspr2/addu_s_ph.c
deleted file mode 100644
index 979651b..0000000
--- a/tests/tcg/mips/mips32-dspr2/addu_s_ph.c
+++ /dev/null
@@ -1,33 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
-
-    rs     = 0x00FE00FE;
-    rt     = 0x00020001;
-    result = 0x010000FF;
-    __asm
-        ("addu_s.ph %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    rs     = 0xFFFF1111;
-    rt     = 0x00020001;
-    result = 0xFFFF1112;
-    __asm
-        ("addu_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-    assert(((dsp >> 20) & 0x01) == 1);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/adduh_qb.c b/tests/tcg/mips/mips32-dspr2/adduh_qb.c
deleted file mode 100644
index a1f5d63..0000000
--- a/tests/tcg/mips/mips32-dspr2/adduh_qb.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
-
-    rs     = 0xFF0055AA;
-    rt     = 0x0113421B;
-    result = 0x80094B62;
-    __asm
-        ("adduh.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    rs     = 0xFFFF0FFF;
-    rt     = 0x00010111;
-    result = 0x7F800888;
-    __asm
-        ("adduh.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/adduh_r_qb.c b/tests/tcg/mips/mips32-dspr2/adduh_r_qb.c
deleted file mode 100644
index 81e98c1..0000000
--- a/tests/tcg/mips/mips32-dspr2/adduh_r_qb.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
-
-    rs     = 0xFF0055AA;
-    rt     = 0x01112211;
-    result = 0x80093C5E;
-    __asm
-        ("adduh_r.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    rs     = 0xFFFF0FFF;
-    rt     = 0x00010111;
-    result = 0x80800888;
-    __asm
-        ("adduh_r.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/append.c b/tests/tcg/mips/mips32-dspr2/append.c
deleted file mode 100644
index 9a91e16..0000000
--- a/tests/tcg/mips/mips32-dspr2/append.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int result;
-
-    rs     = 0xFF0055AA;
-    rt     = 0x0113421B;
-    result = 0x02268436;
-    __asm
-        ("append %0, %1, 0x01\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    assert(rt == result);
-
-    rs     = 0xFFFF0FFF;
-    rt     = 0x00010111;
-    result = 0x0010111F;
-    __asm
-        ("append %0, %1, 0x04\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    assert(rt == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/balign.c b/tests/tcg/mips/mips32-dspr2/balign.c
deleted file mode 100644
index 537cf04..0000000
--- a/tests/tcg/mips/mips32-dspr2/balign.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int result;
-
-    rs     = 0xFF0055AA;
-    rt     = 0x0113421B;
-    result = 0x13421BFF;
-    __asm
-        ("balign %0, %1, 0x01\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    assert(rt == result);
-
-    rs     = 0xFFFF0FFF;
-    rt     = 0x00010111;
-    result = 0x11FFFF0F;
-    __asm
-        ("balign %0, %1, 0x03\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    assert(rt == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/cmpgdu_eq_qb.c b/tests/tcg/mips/mips32-dspr2/cmpgdu_eq_qb.c
deleted file mode 100644
index 2d6340d..0000000
--- a/tests/tcg/mips/mips32-dspr2/cmpgdu_eq_qb.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
-
-    rs = 0x11777066;
-    rt = 0x55AA70FF;
-    result = 0x02;
-    __asm
-        ("cmpgdu.eq.qb %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 24) & 0x0F;
-    assert(rd  == result);
-    assert(dsp == result);
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
-    assert(rd  == result);
-    assert(dsp == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/cmpgdu_le_qb.c b/tests/tcg/mips/mips32-dspr2/cmpgdu_le_qb.c
deleted file mode 100644
index a0ecdca..0000000
--- a/tests/tcg/mips/mips32-dspr2/cmpgdu_le_qb.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
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
-    assert(rd  == result);
-    assert(dsp == result);
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
-    assert(rd  == result);
-    assert(dsp == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/cmpgdu_lt_qb.c b/tests/tcg/mips/mips32-dspr2/cmpgdu_lt_qb.c
deleted file mode 100644
index dba99e3..0000000
--- a/tests/tcg/mips/mips32-dspr2/cmpgdu_lt_qb.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int dsp;
-    int result;
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
-    assert(rd  == result);
-    assert(dsp == result);
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
-    assert(rd  == result);
-    assert(dsp == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/dpa_w_ph.c b/tests/tcg/mips/mips32-dspr2/dpa_w_ph.c
deleted file mode 100644
index fae49f1..0000000
--- a/tests/tcg/mips/mips32-dspr2/dpa_w_ph.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int ach = 5, acl = 5;
-    int resulth, resultl;
-
-    rs     = 0x00FF00FF;
-    rt     = 0x00010002;
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
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 6, acl = 7;
-    rs     = 0xFFFF00FF;
-    rt     = 0xFFFF0002;
-    resulth = 0x06;
-    resultl = 0x206;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpa.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/dpaqx_s_w_ph.c b/tests/tcg/mips/mips32-dspr2/dpaqx_s_w_ph.c
deleted file mode 100644
index ce87830..0000000
--- a/tests/tcg/mips/mips32-dspr2/dpaqx_s_w_ph.c
+++ /dev/null
@@ -1,79 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, dsp;
-    int ach = 5, acl = 5;
-    int resulth, resultl, resultdsp;
-
-    rs     = 0x800000FF;
-    rt     = 0x00018000;
-    resulth = 0x05;
-    resultl = 0x80000202;
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
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
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
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach    = 5;
-    acl    = 5;
-    rs     = 0x800000FF;
-    rt     = 0x00028000;
-    resulth = 0x05;
-    resultl = 0x80000400;
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
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/dpaqx_sa_w_ph.c b/tests/tcg/mips/mips32-dspr2/dpaqx_sa_w_ph.c
deleted file mode 100644
index d551d64..0000000
--- a/tests/tcg/mips/mips32-dspr2/dpaqx_sa_w_ph.c
+++ /dev/null
@@ -1,57 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, dsp;
-    int ach, acl;
-    int resulth, resultl, resultdsp;
-
-    ach = 0x00000005;
-    acl = 0x00000005;
-    rs     = 0x00FF00FF;
-    rt     = 0x00010002;
-    resulth = 0x00;
-    resultl = 0x7FFFFFFF;
-    resultdsp = 0x01;
-    dsp = 0;
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
-    assert(dsp >> (16 + 1) == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 0x00000009;
-    acl = 0x0000000B;
-    rs     = 0x800000FF;
-    rt     = 0x00018000;
-    resulth = 0x00;
-    resultl = 0x7FFFFFFF;
-    resultdsp = 0x01;
-    dsp = 0;
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
-    assert(dsp >> (16 + 1) == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/dpax_w_ph.c b/tests/tcg/mips/mips32-dspr2/dpax_w_ph.c
deleted file mode 100644
index 514797c..0000000
--- a/tests/tcg/mips/mips32-dspr2/dpax_w_ph.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int ach = 5, acl = 5;
-    int resulth, resultl;
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
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 6, acl = 7;
-    rs     = 0xFFFF00FF;
-    rt     = 0xFFFF0002;
-    resulth = 0x05;
-    resultl = 0xFFFFFF06;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpax.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/dps_w_ph.c b/tests/tcg/mips/mips32-dspr2/dps_w_ph.c
deleted file mode 100644
index f51f9b9..0000000
--- a/tests/tcg/mips/mips32-dspr2/dps_w_ph.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int ach = 5, acl = 5;
-    int resulth, resultl;
-
-    rs     = 0x00FF00FF;
-    rt     = 0x00010002;
-    resulth = 0x04;
-    resultl = 0xFFFFFD08;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dps.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 6, acl = 7;
-    rs     = 0xFFFF00FF;
-    rt     = 0xFFFF0002;
-    resulth = 0x05;
-    resultl = 0xFFFFFE08;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dps.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/dpsqx_s_w_ph.c b/tests/tcg/mips/mips32-dspr2/dpsqx_s_w_ph.c
deleted file mode 100644
index e40543f..0000000
--- a/tests/tcg/mips/mips32-dspr2/dpsqx_s_w_ph.c
+++ /dev/null
@@ -1,54 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, dsp;
-    int ach = 5, acl = 5;
-    int resulth, resultl, resultdsp;
-
-    rs      = 0xBC0123AD;
-    rt      = 0x01643721;
-    resulth = 0x00000005;
-    resultl = 0x1CE5E09B;
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
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 0x99F13005;
-    acl = 0x51730062;
-    rs      = 0x80008000;
-    rt      = 0x80008000;
-
-    resulth = 0x99F13004;
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
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/dpsqx_sa_w_ph.c b/tests/tcg/mips/mips32-dspr2/dpsqx_sa_w_ph.c
deleted file mode 100644
index 7da278e..0000000
--- a/tests/tcg/mips/mips32-dspr2/dpsqx_sa_w_ph.c
+++ /dev/null
@@ -1,53 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, dsp;
-    int ach = 5, acl = 5;
-    int resulth, resultl, resultdsp;
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
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    ach = 0x8c0b354A;
-    acl = 0xbbc02249;
-    rs = 0x800023AD;
-    rt = 0x01648000;
-    resulth = 0xffffffff;
-    resultl = 0x80000000;
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
-    assert(dsp == resultdsp);
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/dpsx_w_ph.c b/tests/tcg/mips/mips32-dspr2/dpsx_w_ph.c
deleted file mode 100644
index bb49a40..0000000
--- a/tests/tcg/mips/mips32-dspr2/dpsx_w_ph.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int ach = 5, acl = 5;
-    int resulth, resultl;
-
-    rs      = 0xBC0123AD;
-    rt      = 0x01643721;
-    resulth = 0x05;
-    resultl = 0xE72F050;
-    __asm
-        ("mthi  %0, $ac1\n\t"
-         "mtlo  %1, $ac1\n\t"
-         "dpsx.w.ph $ac1, %2, %3\n\t"
-         "mfhi  %0, $ac1\n\t"
-         "mflo  %1, $ac1\n\t"
-         : "+r"(ach), "+r"(acl)
-         : "r"(rs), "r"(rt)
-        );
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/mul_ph.c b/tests/tcg/mips/mips32-dspr2/mul_ph.c
deleted file mode 100644
index c7e9d60..0000000
--- a/tests/tcg/mips/mips32-dspr2/mul_ph.c
+++ /dev/null
@@ -1,47 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x03FB1234;
-    rt = 0x0BCC4321;
-    result = 0xF504F4B4;
-    resultdsp = 1;
-
-    __asm
-        ("mul.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    assert(rd  == result);
-    assert(dsp == resultdsp);
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
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/mul_s_ph.c b/tests/tcg/mips/mips32-dspr2/mul_s_ph.c
deleted file mode 100644
index 33da110..0000000
--- a/tests/tcg/mips/mips32-dspr2/mul_s_ph.c
+++ /dev/null
@@ -1,62 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
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
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    rs = 0x7fffff00;
-    rt = 0xff007fff;
-    result = 0x80008000;
-    resultdsp = 1;
-
-    __asm
-        ("mul_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    assert(rd  == result);
-    assert(dsp == resultdsp);
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
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/mulq_rs_w.c b/tests/tcg/mips/mips32-dspr2/mulq_rs_w.c
deleted file mode 100644
index 7ba633b..0000000
--- a/tests/tcg/mips/mips32-dspr2/mulq_rs_w.c
+++ /dev/null
@@ -1,36 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x80001234;
-    rt = 0x80004321;
-    result = 0x7FFFAAAB;
-
-    __asm
-        ("mulq_rs.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd  == result);
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
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/mulq_s_ph.c b/tests/tcg/mips/mips32-dspr2/mulq_s_ph.c
deleted file mode 100644
index 00e0155..0000000
--- a/tests/tcg/mips/mips32-dspr2/mulq_s_ph.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x80000000;
-    rt = 0x0ffc0000;
-    result = 0xF0040000;
-    resultdsp = 0;
-
-    __asm
-        ("mulq_s.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 21) & 0x01;
-    assert(rd  == result);
-    assert(dsp == resultdsp);
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
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/mulq_s_w.c b/tests/tcg/mips/mips32-dspr2/mulq_s_w.c
deleted file mode 100644
index 9c2be06..0000000
--- a/tests/tcg/mips/mips32-dspr2/mulq_s_w.c
+++ /dev/null
@@ -1,36 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x80001234;
-    rt = 0x80004321;
-    result = 0x7FFFAAAB;
-
-    __asm
-        ("mulq_s.w %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rs), "r"(rt)
-        );
-    assert(rd  == result);
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
-    assert(rd  == result);
-    assert(dsp == resultdsp);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/mulsa_w_ph.c b/tests/tcg/mips/mips32-dspr2/mulsa_w_ph.c
deleted file mode 100644
index a694093..0000000
--- a/tests/tcg/mips/mips32-dspr2/mulsa_w_ph.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, ach, acl;
-    int resulth, resultl;
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
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/mulsaq_s_w_ph.c b/tests/tcg/mips/mips32-dspr2/mulsaq_s_w_ph.c
deleted file mode 100644
index 06c91a4..0000000
--- a/tests/tcg/mips/mips32-dspr2/mulsaq_s_w_ph.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt, ach, acl;
-    int resulth, resultl;
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
-    assert(ach == resulth);
-    assert(acl == resultl);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/precr_qb_ph.c b/tests/tcg/mips/mips32-dspr2/precr_qb_ph.c
deleted file mode 100644
index 3a2b3fd..0000000
--- a/tests/tcg/mips/mips32-dspr2/precr_qb_ph.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(result == rd);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/precr_sra_ph_w.c b/tests/tcg/mips/mips32-dspr2/precr_sra_ph_w.c
deleted file mode 100644
index 5c9baab..0000000
--- a/tests/tcg/mips/mips32-dspr2/precr_sra_ph_w.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int result;
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
-    assert(result == rt);
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0xFFFF0000;
-
-    __asm
-        ("precr_sra.ph.w %0, %1, 0x1F\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/precr_sra_r_ph_w.c b/tests/tcg/mips/mips32-dspr2/precr_sra_r_ph_w.c
deleted file mode 100644
index 6474a10..0000000
--- a/tests/tcg/mips/mips32-dspr2/precr_sra_r_ph_w.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int result;
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
-    assert(result == rt);
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0xFFFF0000;
-
-    __asm
-        ("precr_sra_r.ph.w %0, %1, 0x1F\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    assert(result == rt);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/prepend.c b/tests/tcg/mips/mips32-dspr2/prepend.c
deleted file mode 100644
index f6bcd47..0000000
--- a/tests/tcg/mips/mips32-dspr2/prepend.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rs, rt;
-    int result;
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0x87654321;
-    __asm
-        ("prepend %0, %1, 0x00\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    assert(rt == result);
-
-    rs = 0x12345678;
-    rt = 0x87654321;
-    result = 0xACF10ECA;
-    __asm
-        ("prepend %0, %1, 0x0F\n\t"
-         : "+r"(rt)
-         : "r"(rs)
-        );
-    assert(rt == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/shra_qb.c b/tests/tcg/mips/mips32-dspr2/shra_qb.c
deleted file mode 100644
index 48193de..0000000
--- a/tests/tcg/mips/mips32-dspr2/shra_qb.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt = 0x12345678;
-    result = 0x02060A0F;
-
-    __asm
-        ("shra.qb %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    rt = 0x87654321;
-    result = 0xF00C0804;
-
-    __asm
-        ("shra.qb %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/shra_r_qb.c b/tests/tcg/mips/mips32-dspr2/shra_r_qb.c
deleted file mode 100644
index 29afa0e..0000000
--- a/tests/tcg/mips/mips32-dspr2/shra_r_qb.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
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
-    assert(rd == result);
-
-    rt = 0x87654321;
-    result = 0xF10D0804;
-
-    __asm
-        ("shra_r.qb %0, %1, 0x03\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/shrav_qb.c b/tests/tcg/mips/mips32-dspr2/shrav_qb.c
deleted file mode 100644
index b21e1b7..0000000
--- a/tests/tcg/mips/mips32-dspr2/shrav_qb.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    rs = 0x03;
-    rt = 0x87654321;
-    result = 0xF00C0804;
-
-    __asm
-        ("shrav.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/shrav_r_qb.c b/tests/tcg/mips/mips32-dspr2/shrav_r_qb.c
deleted file mode 100644
index 9ea8aa0..0000000
--- a/tests/tcg/mips/mips32-dspr2/shrav_r_qb.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    rs = 0x03;
-    rt = 0x87654321;
-    result = 0xF10D0804;
-
-    __asm
-        ("shrav_r.qb %0, %1, %2\n\t"
-         : "=r"(rd)
-         : "r"(rt), "r"(rs)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/shrl_ph.c b/tests/tcg/mips/mips32-dspr2/shrl_ph.c
deleted file mode 100644
index 724b9a7..0000000
--- a/tests/tcg/mips/mips32-dspr2/shrl_ph.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rt;
-    int result;
-
-    rt     = 0x12345678;
-    result = 0x009102B3;
-
-    __asm
-        ("shrl.ph %0, %1, 0x05\n\t"
-         : "=r"(rd)
-         : "r"(rt)
-        );
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/shrlv_ph.c b/tests/tcg/mips/mips32-dspr2/shrlv_ph.c
deleted file mode 100644
index ac79aa6..0000000
--- a/tests/tcg/mips/mips32-dspr2/shrlv_ph.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_ph.c b/tests/tcg/mips/mips32-dspr2/subqh_ph.c
deleted file mode 100644
index dbc0967..0000000
--- a/tests/tcg/mips/mips32-dspr2/subqh_ph.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_r_ph.c b/tests/tcg/mips/mips32-dspr2/subqh_r_ph.c
deleted file mode 100644
index 24ef0f1..0000000
--- a/tests/tcg/mips/mips32-dspr2/subqh_r_ph.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_r_w.c b/tests/tcg/mips/mips32-dspr2/subqh_r_w.c
deleted file mode 100644
index d460f86..0000000
--- a/tests/tcg/mips/mips32-dspr2/subqh_r_w.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_w.c b/tests/tcg/mips/mips32-dspr2/subqh_w.c
deleted file mode 100644
index 42be3de..0000000
--- a/tests/tcg/mips/mips32-dspr2/subqh_w.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/subu_ph.c b/tests/tcg/mips/mips32-dspr2/subu_ph.c
deleted file mode 100644
index 0d39a01..0000000
--- a/tests/tcg/mips/mips32-dspr2/subu_ph.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
-
-    rs = 0x87654321;
-    rt = 0x11111111;
-    result    = 0x76543210;
-    resultdsp = 0x00;
-
-    __asm
-        ("subu.ph %0, %2, %3\n\t"
-         "rddsp %1\n\t"
-         : "=r"(rd), "=r"(dsp)
-         : "r"(rs), "r"(rt)
-        );
-    dsp = (dsp >> 20) & 0x01;
-    assert(dsp == resultdsp);
-    assert(rd  == result);
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
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/subu_s_ph.c b/tests/tcg/mips/mips32-dspr2/subu_s_ph.c
deleted file mode 100644
index 8e4da4f..0000000
--- a/tests/tcg/mips/mips32-dspr2/subu_s_ph.c
+++ /dev/null
@@ -1,25 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt, dsp;
-    int result, resultdsp;
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
-    assert(dsp == resultdsp);
-    assert(rd  == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/subuh_qb.c b/tests/tcg/mips/mips32-dspr2/subuh_qb.c
deleted file mode 100644
index 92cfc76..0000000
--- a/tests/tcg/mips/mips32-dspr2/subuh_qb.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mips32-dspr2/subuh_r_qb.c b/tests/tcg/mips/mips32-dspr2/subuh_r_qb.c
deleted file mode 100644
index dac81d4..0000000
--- a/tests/tcg/mips/mips32-dspr2/subuh_r_qb.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include<stdio.h>
-#include<assert.h>
-
-int main()
-{
-    int rd, rs, rt;
-    int result;
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
-    assert(rd == result);
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
-    assert(rd == result);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mipsr5900/div1.c b/tests/tcg/mips/mipsr5900/div1.c
deleted file mode 100644
index 83dafa0..0000000
--- a/tests/tcg/mips/mipsr5900/div1.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * Test R5900-specific DIV1.
- */
-
-#include <stdio.h>
-#include <inttypes.h>
-#include <assert.h>
-
-struct quotient_remainder { int32_t quotient, remainder; };
-
-static struct quotient_remainder div1(int32_t rs, int32_t rt)
-{
-    int32_t lo, hi;
-
-    __asm__ __volatile__ (
-            "    div1 $0, %2, %3\n"
-            "    mflo1 %0\n"
-            "    mfhi1 %1\n"
-            : "=r" (lo), "=r" (hi)
-            : "r" (rs), "r" (rt));
-
-    assert(rs / rt == lo);
-    assert(rs % rt == hi);
-
-    return (struct quotient_remainder) { .quotient = lo, .remainder = hi };
-}
-
-static void verify_div1(int32_t rs, int32_t rt,
-                        int32_t expected_quotient,
-                        int32_t expected_remainder)
-{
-    struct quotient_remainder qr = div1(rs, rt);
-
-    assert(qr.quotient == expected_quotient);
-    assert(qr.remainder == expected_remainder);
-}
-
-static void verify_div1_negations(int32_t rs, int32_t rt,
-                                  int32_t expected_quotient,
-                                  int32_t expected_remainder)
-{
-    verify_div1(rs, rt, expected_quotient, expected_remainder);
-    verify_div1(rs, -rt, -expected_quotient, expected_remainder);
-    verify_div1(-rs, rt, -expected_quotient, -expected_remainder);
-    verify_div1(-rs, -rt, expected_quotient, -expected_remainder);
-}
-
-int main()
-{
-    verify_div1_negations(0, 1, 0, 0);
-    verify_div1_negations(1, 1, 1, 0);
-    verify_div1_negations(1, 2, 0, 1);
-    verify_div1_negations(17, 19, 0, 17);
-    verify_div1_negations(19, 17, 1, 2);
-    verify_div1_negations(77773, 101, 770, 3);
-
-    verify_div1(-0x80000000,  1, -0x80000000, 0);
-
-    /*
-     * Supplementary explanation from the Toshiba TX System RISC TX79 Core
-     * Architecture manual, A-38 and B-7, https://wiki.qemu.org/File:C790.pdf
-     *
-     * Normally, when 0x80000000 (-2147483648) the signed minimum value is
-     * divided by 0xFFFFFFFF (-1), the operation will result in an overflow.
-     * However, in this instruction an overflow exception doesn't occur and
-     * the result will be as follows:
-     *
-     * Quotient is 0x80000000 (-2147483648), and remainder is 0x00000000 (0).
-     */
-    verify_div1(-0x80000000, -1, -0x80000000, 0);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mipsr5900/divu1.c b/tests/tcg/mips/mipsr5900/divu1.c
deleted file mode 100644
index 72aeed3..0000000
--- a/tests/tcg/mips/mipsr5900/divu1.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Test R5900-specific DIVU1.
- */
-
-#include <stdio.h>
-#include <inttypes.h>
-#include <assert.h>
-
-struct quotient_remainder { uint32_t quotient, remainder; };
-
-static struct quotient_remainder divu1(uint32_t rs, uint32_t rt)
-{
-    uint32_t lo, hi;
-
-    __asm__ __volatile__ (
-            "    divu1 $0, %2, %3\n"
-            "    mflo1 %0\n"
-            "    mfhi1 %1\n"
-            : "=r" (lo), "=r" (hi)
-            : "r" (rs), "r" (rt));
-
-    assert(rs / rt == lo);
-    assert(rs % rt == hi);
-
-    return (struct quotient_remainder) { .quotient = lo, .remainder = hi };
-}
-
-static void verify_divu1(uint32_t rs, uint32_t rt,
-                         uint32_t expected_quotient,
-                         uint32_t expected_remainder)
-{
-    struct quotient_remainder qr = divu1(rs, rt);
-
-    assert(qr.quotient == expected_quotient);
-    assert(qr.remainder == expected_remainder);
-}
-
-int main()
-{
-    verify_divu1(0, 1, 0, 0);
-    verify_divu1(1, 1, 1, 0);
-    verify_divu1(1, 2, 0, 1);
-    verify_divu1(17, 19, 0, 17);
-    verify_divu1(19, 17, 1, 2);
-    verify_divu1(77773, 101, 770, 3);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mipsr5900/madd.c b/tests/tcg/mips/mipsr5900/madd.c
deleted file mode 100644
index f6f215e..0000000
--- a/tests/tcg/mips/mipsr5900/madd.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * Test R5900-specific three-operand MADD and MADD1.
- */
-
-#include <stdio.h>
-#include <inttypes.h>
-#include <assert.h>
-
-int64_t madd(int64_t a, int32_t rs, int32_t rt)
-{
-    int32_t lo = a;
-    int32_t hi = a >> 32;
-    int32_t rd;
-    int64_t r;
-
-    __asm__ __volatile__ (
-            "    mtlo %5\n"
-            "    mthi %6\n"
-            "    madd %0, %3, %4\n"
-            "    mflo %1\n"
-            "    mfhi %2\n"
-            : "=r" (rd), "=r" (lo), "=r" (hi)
-            : "r" (rs), "r" (rt), "r" (lo), "r" (hi));
-    r = ((int64_t)hi << 32) | (uint32_t)lo;
-
-    assert(a + (int64_t)rs * rt == r);
-    assert(rd == lo);
-
-    return r;
-}
-
-int64_t madd1(int64_t a, int32_t rs, int32_t rt)
-{
-    int32_t lo = a;
-    int32_t hi = a >> 32;
-    int32_t rd;
-    int64_t r;
-
-    __asm__ __volatile__ (
-            "    mtlo1 %5\n"
-            "    mthi1 %6\n"
-            "    madd1 %0, %3, %4\n"
-            "    mflo1 %1\n"
-            "    mfhi1 %2\n"
-            : "=r" (rd), "=r" (lo), "=r" (hi)
-            : "r" (rs), "r" (rt), "r" (lo), "r" (hi));
-    r = ((int64_t)hi << 32) | (uint32_t)lo;
-
-    assert(a + (int64_t)rs * rt == r);
-    assert(rd == lo);
-
-    return r;
-}
-
-static int64_t madd_variants(int64_t a, int32_t rs, int32_t rt)
-{
-    int64_t rd  = madd(a, rs, rt);
-    int64_t rd1 = madd1(a, rs, rt);
-
-    assert(rd == rd1);
-
-    return rd;
-}
-
-static void verify_madd(int64_t a, int32_t rs, int32_t rt, int64_t expected)
-{
-    assert(madd_variants(a, rs, rt) == expected);
-    assert(madd_variants(a, -rs, rt) == a + a - expected);
-    assert(madd_variants(a, rs, -rt) == a + a - expected);
-    assert(madd_variants(a, -rs, -rt) == expected);
-}
-
-int main()
-{
-    verify_madd(13, 17, 19, 336);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mipsr5900/maddu.c b/tests/tcg/mips/mipsr5900/maddu.c
deleted file mode 100644
index 30936fb..0000000
--- a/tests/tcg/mips/mipsr5900/maddu.c
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * Test R5900-specific three-operand MADDU and MADDU1.
- */
-
-#include <stdio.h>
-#include <inttypes.h>
-#include <assert.h>
-
-uint64_t maddu(uint64_t a, uint32_t rs, uint32_t rt)
-{
-    uint32_t lo = a;
-    uint32_t hi = a >> 32;
-    uint32_t rd;
-    uint64_t r;
-
-    __asm__ __volatile__ (
-            "    mtlo  %5\n"
-            "    mthi  %6\n"
-            "    maddu %0, %3, %4\n"
-            "    mflo  %1\n"
-            "    mfhi  %2\n"
-            : "=r" (rd), "=r" (lo), "=r" (hi)
-            : "r" (rs), "r" (rt), "r" (lo), "r" (hi));
-    r = ((uint64_t)hi << 32) | (uint32_t)lo;
-
-    assert(a + (uint64_t)rs * rt == r);
-    assert(rd == lo);
-
-    return r;
-}
-
-uint64_t maddu1(uint64_t a, uint32_t rs, uint32_t rt)
-{
-    uint32_t lo = a;
-    uint32_t hi = a >> 32;
-    uint32_t rd;
-    uint64_t r;
-
-    __asm__ __volatile__ (
-            "    mtlo1  %5\n"
-            "    mthi1  %6\n"
-            "    maddu1 %0, %3, %4\n"
-            "    mflo1  %1\n"
-            "    mfhi1  %2\n"
-            : "=r" (rd), "=r" (lo), "=r" (hi)
-            : "r" (rs), "r" (rt), "r" (lo), "r" (hi));
-    r = ((uint64_t)hi << 32) | (uint32_t)lo;
-
-    assert(a + (uint64_t)rs * rt == r);
-    assert(rd == lo);
-
-    return r;
-}
-
-static int64_t maddu_variants(int64_t a, int32_t rs, int32_t rt)
-{
-    int64_t rd  = maddu(a, rs, rt);
-    int64_t rd1 = maddu1(a, rs, rt);
-
-    assert(rd == rd1);
-
-    return rd;
-}
-
-int main()
-{
-    assert(maddu_variants(13, 17, 19) == 336);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mipsr5900/mflohi1.c b/tests/tcg/mips/mipsr5900/mflohi1.c
deleted file mode 100644
index eed3683..0000000
--- a/tests/tcg/mips/mipsr5900/mflohi1.c
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Test R5900-specific MFLO1 and MFHI1.
- */
-
-#include <stdio.h>
-#include <inttypes.h>
-#include <assert.h>
-
-int main()
-{
-    int32_t rs  = 12207031, rt  = 305175781;
-    int32_t rs1 = 32452867, rt1 = 49979687;
-    int64_t lo, hi, lo1, hi1;
-    int64_t r, r1;
-
-    /* Test both LO/HI and LO1/HI1 to verify separation. */
-    __asm__ __volatile__ (
-            "    mult $0, %4, %5\n"
-            "    mult1 $0, %6, %7\n"
-            "    mflo %0\n"
-            "    mfhi %1\n"
-            "    mflo1 %2\n"
-            "    mfhi1 %3\n"
-            : "=r" (lo),  "=r" (hi),
-              "=r" (lo1), "=r" (hi1)
-            : "r" (rs),  "r" (rt),
-              "r" (rs1), "r" (rt1));
-    r  = ((int64_t)hi  << 32) | (uint32_t)lo;
-    r1 = ((int64_t)hi1 << 32) | (uint32_t)lo1;
-
-    assert(r  == 3725290219116211);
-    assert(r1 == 1621984134912629);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mipsr5900/mtlohi1.c b/tests/tcg/mips/mipsr5900/mtlohi1.c
deleted file mode 100644
index 7f3e728..0000000
--- a/tests/tcg/mips/mipsr5900/mtlohi1.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Test R5900-specific MTLO1 and MTHI1.
- */
-
-#include <stdio.h>
-#include <inttypes.h>
-#include <assert.h>
-
-int main()
-{
-    int32_t tlo  = 12207031, thi  = 305175781;
-    int32_t tlo1 = 32452867, thi1 = 49979687;
-    int32_t flo, fhi, flo1, fhi1;
-
-    /* Test both LO/HI and LO1/HI1 to verify separation. */
-    __asm__ __volatile__ (
-            "    mtlo  %4\n"
-            "    mthi  %5\n"
-            "    mtlo1 %6\n"
-            "    mthi1 %7\n"
-            "    move  %0, $0\n"
-            "    move  %1, $0\n"
-            "    move  %2, $0\n"
-            "    move  %3, $0\n"
-            "    mflo  %0\n"
-            "    mfhi  %1\n"
-            "    mflo1 %2\n"
-            "    mfhi1 %3\n"
-            : "=r" (flo),  "=r" (fhi),
-              "=r" (flo1), "=r" (fhi1)
-            : "r" (tlo),  "r" (thi),
-              "r" (tlo1), "r" (thi1));
-
-    assert(flo  == 12207031);
-    assert(fhi  == 305175781);
-    assert(flo1 == 32452867);
-    assert(fhi1 == 49979687);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mipsr5900/mult.c b/tests/tcg/mips/mipsr5900/mult.c
deleted file mode 100644
index 5710b39..0000000
--- a/tests/tcg/mips/mipsr5900/mult.c
+++ /dev/null
@@ -1,76 +0,0 @@
-/*
- * Test R5900-specific three-operand MULT and MULT1.
- */
-
-#include <stdio.h>
-#include <inttypes.h>
-#include <assert.h>
-
-static int64_t mult(int32_t rs, int32_t rt)
-{
-    int32_t rd, lo, hi;
-    int64_t r;
-
-    __asm__ __volatile__ (
-            "    mult %0, %3, %4\n"
-            "    mflo %1\n"
-            "    mfhi %2\n"
-            : "=r" (rd), "=r" (lo), "=r" (hi)
-            : "r" (rs), "r" (rt));
-    r = ((int64_t)hi << 32) | (uint32_t)lo;
-
-    assert((int64_t)rs * rt == r);
-    assert(rd == lo);
-
-    return r;
-}
-
-static int64_t mult1(int32_t rs, int32_t rt)
-{
-    int32_t rd, lo, hi;
-    int64_t r;
-
-    __asm__ __volatile__ (
-            "    mult1 %0, %3, %4\n"
-            "    mflo1 %1\n"
-            "    mfhi1 %2\n"
-            : "=r" (rd), "=r" (lo), "=r" (hi)
-            : "r" (rs), "r" (rt));
-    r = ((int64_t)hi << 32) | (uint32_t)lo;
-
-    assert((int64_t)rs * rt == r);
-    assert(rd == lo);
-
-    return r;
-}
-
-static int64_t mult_variants(int32_t rs, int32_t rt)
-{
-    int64_t rd  = mult(rs, rt);
-    int64_t rd1 = mult1(rs, rt);
-
-    assert(rd == rd1);
-
-    return rd;
-}
-
-static void verify_mult_negations(int32_t rs, int32_t rt, int64_t expected)
-{
-    assert(mult_variants(rs, rt) == expected);
-    assert(mult_variants(-rs, rt) == -expected);
-    assert(mult_variants(rs, -rt) == -expected);
-    assert(mult_variants(-rs, -rt) == expected);
-}
-
-int main()
-{
-    verify_mult_negations(17, 19, 323);
-    verify_mult_negations(77773, 99991, 7776600043);
-    verify_mult_negations(12207031, 305175781, 3725290219116211);
-
-    assert(mult_variants(-0x80000000,  0x7FFFFFFF) == -0x3FFFFFFF80000000);
-    assert(mult_variants(-0x80000000, -0x7FFFFFFF) ==  0x3FFFFFFF80000000);
-    assert(mult_variants(-0x80000000, -0x80000000) ==  0x4000000000000000);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/mipsr5900/multu.c b/tests/tcg/mips/mipsr5900/multu.c
deleted file mode 100644
index f043904..0000000
--- a/tests/tcg/mips/mipsr5900/multu.c
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * Test R5900-specific three-operand MULTU and MULTU1.
- */
-
-#include <stdio.h>
-#include <inttypes.h>
-#include <assert.h>
-
-static uint64_t multu(uint32_t rs, uint32_t rt)
-{
-    uint32_t rd, lo, hi;
-    uint64_t r;
-
-    __asm__ __volatile__ (
-            "    multu %0, %3, %4\n"
-            "    mflo %1\n"
-            "    mfhi %2\n"
-            : "=r" (rd), "=r" (lo), "=r" (hi)
-            : "r" (rs), "r" (rt));
-    r = ((uint64_t)hi << 32) | (uint32_t)lo;
-
-    assert((uint64_t)rs * rt == r);
-    assert(rd == lo);
-
-    return r;
-}
-
-static uint64_t multu1(uint32_t rs, uint32_t rt)
-{
-    uint32_t rd, lo, hi;
-    uint64_t r;
-
-    __asm__ __volatile__ (
-            "    multu1 %0, %3, %4\n"
-            "    mflo1 %1\n"
-            "    mfhi1 %2\n"
-            : "=r" (rd), "=r" (lo), "=r" (hi)
-            : "r" (rs), "r" (rt));
-    r = ((uint64_t)hi << 32) | (uint32_t)lo;
-
-    assert((uint64_t)rs * rt == r);
-    assert(rd == lo);
-
-    return r;
-}
-
-static uint64_t multu_variants(uint32_t rs, uint32_t rt)
-{
-    uint64_t rd  = multu(rs, rt);
-    uint64_t rd1 = multu1(rs, rt);
-
-    assert(rd == rd1);
-
-    return rd;
-}
-
-int main()
-{
-    assert(multu_variants(17, 19) == 323);
-    assert(multu_variants(77773, 99991) == 7776600043);
-    assert(multu_variants(12207031, 305175781) == 3725290219116211);
-
-    assert(multu_variants(0x80000000U, 0x7FFFFFFF) == 0x3FFFFFFF80000000);
-    assert(multu_variants(0x80000000U, 0x80000000U) ==  0x4000000000000000);
-    assert(multu_variants(0xFFFFFFFFU, 0xFFFFFFFFU) ==  0xFFFFFFFE00000001U);
-
-    return 0;
-}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c
new file mode 100644
index 0000000..aa84112
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c
@@ -0,0 +1,31 @@
+#include<stdio.h>
+#include<assert.h>
+
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt     = 0x10017EFD;
+    result = 0x10017EFD;
+
+    __asm
+        ("absq_s.ph %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    rt     = 0x8000A536;
+    result = 0x7FFF5ACA;
+
+    __asm
+        ("absq_s.ph %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c
new file mode 100644
index 0000000..3f52a48
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c
@@ -0,0 +1,37 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt     = 0x80000000;
+    result = 0x7FFFFFFF;
+    __asm
+        ("absq_s.w %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    rt     = 0x80030000;
+    result = 0x7FFD0000;
+    __asm
+        ("absq_s.w %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    rt     = 0x31036080;
+    result = 0x31036080;
+    __asm
+        ("absq_s.w %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c
new file mode 100644
index 0000000..96a5496
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c
@@ -0,0 +1,46 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs     = 0xFFFFFFFF;
+    rt     = 0x10101010;
+    result = 0x100F100F;
+    __asm
+        ("addq.ph   %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    rs     = 0x3712847D;
+    rt     = 0x0031AF2D;
+    result = 0x374333AA;
+    __asm
+        ("addq.ph   %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    rs     = 0x7fff847D;
+    rt     = 0x0031AF2D;
+    result = 0x803033AA;
+    __asm
+        ("addq.ph   %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    __asm("rddsp %0\n\t"
+          : "=r"(dsp)
+         );
+    assert(((dsp >> 20) & 0x01) == 1);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c
new file mode 100644
index 0000000..5f865f6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c
@@ -0,0 +1,69 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs     = 0xFFFFFFFF;
+    rt     = 0x10101010;
+    result = 0x100F100F;
+    __asm
+        ("addq_s.ph   %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    rs     = 0x3712847D;
+    rt     = 0x0031AF2D;
+    result = 0x37438000;
+    __asm
+        ("addq_s.ph   %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    __asm
+        ("rddsp %0\n\t"
+         : "=r"(dsp)
+        );
+    assert(((dsp >> 20) & 0x01) == 1);
+
+    rs     = 0x7fff847D;
+    rt     = 0x0031AF2D;
+    result = 0x7fff8000;
+    __asm
+        ("addq_s.ph   %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    __asm
+        ("rddsp %0\n\t"
+         : "=r"(dsp)
+        );
+    assert(((dsp >> 20) & 0x01) == 1);
+
+    rs     = 0x8030847D;
+    rt     = 0x8a00AF2D;
+    result = 0x80008000;
+    __asm
+        ("addq_s.ph   %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    __asm
+        ("rddsp %0\n\t"
+         : "=r"(dsp)
+        );
+    assert(((dsp >> 20) & 0x01) == 1);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c
new file mode 100644
index 0000000..1e13acf
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c
@@ -0,0 +1,44 @@
+#include<stdio.h>
+#include<assert.h>
+
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rt     = 0x10017EFD;
+    rs     = 0x11111111;
+    result = 0x2112900e;
+
+    __asm
+        ("addq_s.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    rt     = 0x80017EFD;
+    rs     = 0x81111111;
+    result = 0x80000000;
+
+    __asm
+        ("addq_s.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    rt     = 0x7fffffff;
+    rs     = 0x01111111;
+    result = 0x7fffffff;
+
+    __asm
+        ("addq_s.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c
new file mode 100644
index 0000000..ace749f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c
@@ -0,0 +1,33 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs     = 0x0000000F;
+    rt     = 0x00000001;
+    result = 0x00000010;
+    __asm
+        ("addsc %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    rs     = 0xFFFF0FFF;
+    rt     = 0x00010111;
+    result = 0x00001110;
+    __asm
+        ("addsc %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+    assert(((dsp >> 13) & 0x01) == 1);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c
new file mode 100644
index 0000000..23ba2e9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c
@@ -0,0 +1,35 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs     = 0x00FF00FF;
+    rt     = 0x00010001;
+    result = 0x00000000;
+    __asm
+        ("addu.qb %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+    assert(((dsp >> 20) & 0x01) == 1);
+
+    rs     = 0xFFFF1111;
+    rt     = 0x00020001;
+    result = 0xFF011112;
+    __asm
+        ("addu.qb %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+    assert(((dsp >> 20) & 0x01) == 1);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c
new file mode 100644
index 0000000..fe7fd3e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c
@@ -0,0 +1,35 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs     = 0x10FF01FF;
+    rt     = 0x10010001;
+    result = 0x20FF01FF;
+    __asm
+        ("addu_s.qb %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+    assert(((dsp >> 20) & 0x1) == 1);
+
+    rs     = 0xFFFF1111;
+    rt     = 0x00020001;
+    result = 0xFFFF1112;
+    __asm
+        ("addu_s.qb %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+    assert(((dsp >> 20) & 0x1) == 1);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c
new file mode 100644
index 0000000..8a8d81f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c
@@ -0,0 +1,49 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dspi, dspo;
+    int result;
+
+    rs     = 0x10FF01FF;
+    rt     = 0x10010001;
+    dspi   = 0x00002000;
+    result = 0x21000201;
+    __asm
+        ("wrdsp %3\n"
+         "addwc %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt), "r"(dspi)
+        );
+    assert(rd == result);
+
+    rs     = 0xFFFF1111;
+    rt     = 0x00020001;
+    dspi   = 0x00;
+    result = 0x00011112;
+    __asm
+        ("wrdsp %3\n"
+         "addwc %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt), "r"(dspi)
+        );
+    assert(rd == result);
+
+    rs     = 0x8FFF1111;
+    rt     = 0x80020001;
+    dspi   = 0x00;
+    result = 0x10011112;
+    __asm
+        ("wrdsp %4\n"
+         "addwc %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dspo)
+         : "r"(rs), "r"(rt), "r"(dspi)
+        );
+    assert(rd == result);
+    assert(((dspo >> 20) & 0x01) == 1);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c
new file mode 100644
index 0000000..04d8a38
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt     = 0x12345678;
+    result = 0x00001E6A;
+
+    __asm
+        ("bitrev %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c
new file mode 100644
index 0000000..d25417e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c
@@ -0,0 +1,44 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int dsp, sum;
+    int result;
+
+    dsp =  0x20;
+    sum = 0x01;
+    result = 0x02;
+
+    __asm
+        ("wrdsp %1\n\t"
+         "bposge32 test1\n\t"
+         "nop\n\t"
+         "addi %0, 0xA2\n\t"
+         "nop\n\t"
+         "test1:\n\t"
+         "addi %0, 0x01\n\t"
+         : "+r"(sum)
+         : "r"(dsp)
+        );
+    assert(sum == result);
+
+    dsp =  0x10;
+    sum = 0x01;
+    result = 0xA4;
+
+    __asm
+        ("wrdsp %1\n\t"
+         "bposge32 test2\n\t"
+         "nop\n\t"
+         "addi %0, 0xA2\n\t"
+         "nop\n\t"
+         "test2:\n\t"
+         "addi %0, 0x01\n\t"
+         : "+r"(sum)
+         : "r"(dsp)
+        );
+    assert(sum == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c
new file mode 100644
index 0000000..957bd88
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c
@@ -0,0 +1,35 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x11777066;
+    rt     = 0x55AA33FF;
+    result = 0x00;
+    __asm
+        ("cmp.eq.ph %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+
+    rd = (rd >> 24) & 0x03;
+    assert(rd == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11777066;
+    result = 0x03;
+    __asm
+        ("cmp.eq.ph %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    rd = (rd >> 24) & 0x03;
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c
new file mode 100644
index 0000000..356f156
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c
@@ -0,0 +1,35 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x11777066;
+    rt     = 0x55AA33FF;
+    result = 0x02;
+    __asm
+        ("cmp.le.ph %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+
+    rd = (rd >> 24) & 0x03;
+    assert(rd == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11777066;
+    result = 0x03;
+    __asm
+        ("cmp.le.ph %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    rd = (rd >> 24) & 0x03;
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c
new file mode 100644
index 0000000..3fb4827
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c
@@ -0,0 +1,35 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x11777066;
+    rt     = 0x55AA33FF;
+    result = 0x02;
+    __asm
+        ("cmp.lt.ph %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+
+    rd = (rd >> 24) & 0x03;
+    assert(rd == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11777066;
+    result = 0x00;
+    __asm
+        ("cmp.lt.ph %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    rd = (rd >> 24) & 0x03;
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c
new file mode 100644
index 0000000..2615c84
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c
@@ -0,0 +1,31 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x11777066;
+    rt     = 0x55AA70FF;
+    result = 0x02;
+    __asm
+        ("cmpgu.eq.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+
+    assert(rd == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11777066;
+    result = 0x0F;
+    __asm
+        ("cmpgu.eq.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c
new file mode 100644
index 0000000..65d0813
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c
@@ -0,0 +1,31 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x11777066;
+    rt     = 0x55AA70FF;
+    result = 0x0F;
+    __asm
+        ("cmpgu.le.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+
+    assert(rd == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11766066;
+    result = 0x09;
+    __asm
+        ("cmpgu.le.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c
new file mode 100644
index 0000000..7dddad9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c
@@ -0,0 +1,31 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x11777066;
+    rt     = 0x55AA70FF;
+    result = 0x0D;
+    __asm
+        ("cmpgu.lt.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+
+    assert(rd == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11766066;
+    result = 0x00;
+    __asm
+        ("cmpgu.lt.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c
new file mode 100644
index 0000000..680f2a1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c
@@ -0,0 +1,35 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int dsp;
+    int result;
+
+    rs         = 0x11777066;
+    rt         = 0x55AA70FF;
+    result     = 0x02;
+    __asm
+        ("cmpu.eq.qb %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(dsp == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11777066;
+    result = 0x0F;
+    __asm
+        ("cmpu.eq.qb %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(dsp == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c
new file mode 100644
index 0000000..43cfa50
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c
@@ -0,0 +1,35 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int dsp;
+    int result;
+
+    rs         = 0x11777066;
+    rt         = 0x55AA70FF;
+    result     = 0x0F;
+    __asm
+        ("cmpu.le.qb %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(dsp == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11777066;
+    result = 0x0F;
+    __asm
+        ("cmpu.le.qb %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(dsp == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c
new file mode 100644
index 0000000..074ca5b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c
@@ -0,0 +1,35 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int dsp;
+    int result;
+
+    rs         = 0x11777066;
+    rt         = 0x55AA70FF;
+    result     = 0x0D;
+    __asm
+        ("cmpu.lt.qb %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(dsp == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11777066;
+    result = 0x00;
+    __asm
+        ("cmpu.lt.qb %1, %2\n\t"
+         "rddsp %0\n\t"
+         : "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(dsp == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c
new file mode 100644
index 0000000..a6425b6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c
@@ -0,0 +1,31 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, dsp;
+    int ach = 0, acl = 0;
+    int resulth, resultl, resultdsp;
+
+    rs        = 0x800000FF;
+    rt        = 0x80000002;
+    resulth   = 0x00;
+    resultl   = 0x800003FB;
+    resultdsp = 0x01;
+    __asm
+        ("mthi        %0, $ac1\n\t"
+         "mtlo        %1, $ac1\n\t"
+         "dpaq_s.w.ph $ac1, %3, %4\n\t"
+         "mfhi        %0,   $ac1\n\t"
+         "mflo        %1,   $ac1\n\t"
+         "rddsp       %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = dsp >> 17 & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c
new file mode 100644
index 0000000..cbf9007
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c
@@ -0,0 +1,125 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, dsp;
+    int ach = 0, acl = 0;
+    int resulth, resultl, resultdsp;
+
+    rs        = 0x80000000;
+    rt        = 0x80000000;
+    resulth   = 0x7FFFFFFF;
+    resultl   = 0xFFFFFFFF;
+    resultdsp = 0x01;
+    __asm
+        ("mthi        %0, $ac1\n\t"
+         "mtlo        %1, $ac1\n\t"
+         "dpaq_sa.l.w $ac1, %3, %4\n\t"
+         "mfhi        %0,   $ac1\n\t"
+         "mflo        %1,   $ac1\n\t"
+         "rddsp       %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 0x00000012;
+    acl = 0x00000048;
+    rs  = 0x80000000;
+    rt  = 0x80000000;
+
+    resulth   = 0x7FFFFFFF;
+    resultl   = 0xFFFFFFFF;
+    resultdsp = 0x01;
+    __asm
+        ("mthi        %0, $ac1\n\t"
+         "mtlo        %1, $ac1\n\t"
+         "dpaq_sa.l.w $ac1, %3, %4\n\t"
+         "mfhi        %0,   $ac1\n\t"
+         "mflo        %1,   $ac1\n\t"
+         "rddsp       %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 0x741532A0;
+    acl = 0xFCEABB08;
+    rs  = 0x80000000;
+    rt  = 0x80000000;
+
+    resulth   = 0x7FFFFFFF;
+    resultl   = 0xFFFFFFFF;
+    resultdsp = 0x01;
+    __asm
+        ("mthi        %0, $ac1\n\t"
+         "mtlo        %1, $ac1\n\t"
+         "dpaq_sa.l.w $ac1, %3, %4\n\t"
+         "mfhi        %0,   $ac1\n\t"
+         "mflo        %1,   $ac1\n\t"
+         "rddsp       %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 0;
+    acl = 0;
+    rs  = 0xC0000000;
+    rt  = 0x7FFFFFFF;
+
+    resulth   = 0xC0000000;
+    resultl   = 0x80000000;
+    resultdsp = 0;
+    __asm
+        ("wrdsp       $0\n\t"
+         "mthi        %0, $ac1\n\t"
+         "mtlo        %1, $ac1\n\t"
+         "dpaq_sa.l.w $ac1, %3, %4\n\t"
+         "mfhi        %0,   $ac1\n\t"
+         "mflo        %1,   $ac1\n\t"
+         "rddsp       %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 0x20000000;
+    acl = 0;
+    rs  = 0xE0000000;
+    rt  = 0x7FFFFFFF;
+
+    resulth   = 0;
+    resultl   = 0x40000000;
+    resultdsp = 0;
+    __asm
+        ("wrdsp       $0\n\t"
+         "mthi        %0, $ac1\n\t"
+         "mtlo        %1, $ac1\n\t"
+         "dpaq_sa.l.w $ac1, %3, %4\n\t"
+         "mfhi        %0,   $ac1\n\t"
+         "mflo        %1,   $ac1\n\t"
+         "rddsp       %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c
new file mode 100644
index 0000000..6017b5e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c
@@ -0,0 +1,27 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int ach = 5, acl = 3;
+    int resulth, resultl;
+
+    rs        = 0x800000FF;
+    rt        = 0x80000002;
+    resulth   = 0x05;
+    resultl   = 0x4003;
+    __asm
+        ("mthi       %0, $ac1\n\t"
+         "mtlo       %1, $ac1\n\t"
+         "dpau.h.qbl $ac1, %2, %3\n\t"
+         "mfhi       %0,   $ac1\n\t"
+         "mflo       %1,   $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c
new file mode 100644
index 0000000..e4abb2e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c
@@ -0,0 +1,27 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int ach = 5, acl = 3;
+    int resulth, resultl;
+
+    rs        = 0x800000FF;
+    rt        = 0x80000002;
+    resulth   = 0x05;
+    resultl   = 0x0201;
+    __asm
+        ("mthi       %0, $ac1\n\t"
+         "mtlo       %1, $ac1\n\t"
+         "dpau.h.qbr $ac1, %2, %3\n\t"
+         "mfhi       %0,   $ac1\n\t"
+         "mflo       %1,   $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c
new file mode 100644
index 0000000..74058fe
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c
@@ -0,0 +1,45 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int ach = 5, acl = 5;
+    int resulth, resultl;
+
+    rs      = 0xBC0123AD;
+    rt      = 0x01643721;
+    resulth = 0x00000004;
+    resultl = 0xF15F94A3;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsq_s.w.ph $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 0x1424EF1F;
+    acl = 0x1035219A;
+    rs      = 0x800083AD;
+    rt      = 0x80003721;
+    resulth = 0x1424EF1E;
+    resultl = 0xC5C0D901;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsq_s.w.ph $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c
new file mode 100644
index 0000000..eda3b14
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c
@@ -0,0 +1,55 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, dsp;
+    int ach = 5, acl = 5;
+    int resulth, resultl, resultdsp;
+
+    rs      = 0xBC0123AD;
+    rt      = 0x01643721;
+    resulth = 0x00BD3A22;
+    resultl = 0xD138776B;
+    resultdsp = 0x00;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsq_sa.l.w $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 0x54321123;
+    acl = 5;
+    rs      = 0x80000000;
+    rt      = 0x80000000;
+
+    resulth = 0xd4321123;
+    resultl = 0x06;
+    resultdsp = 0x01;
+
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsq_sa.l.w $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c
new file mode 100644
index 0000000..94e2bf6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c
@@ -0,0 +1,27 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int ach = 5, acl = 5;
+    int resulth, resultl;
+
+    rs      = 0xBC0123AD;
+    rt      = 0x01643721;
+    resulth = 0x04;
+    resultl = 0xFFFFFEE5;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsu.h.qbl $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c
new file mode 100644
index 0000000..a1e6635
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c
@@ -0,0 +1,27 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int ach = 5, acl = 5;
+    int resulth, resultl;
+
+    rs      = 0xBC0123AD;
+    rt      = 0x01643721;
+    resulth = 0x04;
+    resultl = 0xFFFFE233;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsu.h.qbr $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c
new file mode 100644
index 0000000..b18bdb3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c
@@ -0,0 +1,62 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, ach, acl, dsp;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x07;
+    result = 0x000C;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extp %0, $ac1, 0x03\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 14) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x01;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extp %0, $ac1, 0x03\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 14) & 0x01;
+    assert(dsp == 1);
+
+    ach = 0;
+    acl = 0x80000001;
+    dsp = 0x1F;
+    result = 0x80000001;
+
+    __asm
+        ("wrdsp %1\n\t"
+         "mthi %2, $ac2\n\t"
+         "mtlo %3, $ac2\n\t"
+         "extp %0, $ac2, 0x1F\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 14) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c
new file mode 100644
index 0000000..79ee16e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c
@@ -0,0 +1,64 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, ach, acl, dsp, pos, efi;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x07;
+    result = 0x000C;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extpdp %0, $ac1, 0x03\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    pos =  dsp & 0x3F;
+    efi = (dsp >> 14) & 0x01;
+    assert(pos == 3);
+    assert(efi == 0);
+    assert(result == rt);
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x01;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extpdp %0, $ac1, 0x03\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    efi = (dsp >> 14) & 0x01;
+    assert(efi == 1);
+
+
+    ach = 0;
+    acl = 0;
+    dsp = 0;
+    result = 0;
+
+    __asm
+        ("wrdsp %1\n\t"
+         "mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extpdp %0, $ac1, 0x00\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    assert(dsp == 0x3F);
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c
new file mode 100644
index 0000000..f5774ee
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c
@@ -0,0 +1,47 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs, ach, acl, dsp, pos, efi;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x07;
+    rs  = 0x03;
+    result = 0x000C;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extpdpv %0, $ac1, %4\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(ach), "r"(acl), "r"(rs)
+        );
+    pos =  dsp & 0x3F;
+    efi = (dsp >> 14) & 0x01;
+    assert(pos == 3);
+    assert(efi == 0);
+    assert(result == rt);
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x01;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extpdpv %0, $ac1, %4\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(ach), "r"(acl), "r"(rs)
+        );
+    efi = (dsp >> 14) & 0x01;
+    assert(efi == 1);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c
new file mode 100644
index 0000000..401b94a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c
@@ -0,0 +1,45 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, ac, ach, acl, dsp;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x07;
+    ac  = 0x03;
+    result = 0x000C;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extpv %0, $ac1, %4\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(ach), "r"(acl), "r"(ac)
+        );
+    dsp = (dsp >> 14) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x01;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extpv %0, $ac1, %4\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(ach), "r"(acl), "r"(ac)
+        );
+    dsp = (dsp >> 14) & 0x01;
+    assert(dsp == 1);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c
new file mode 100644
index 0000000..489c193
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c
@@ -0,0 +1,94 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, ach, acl, dsp;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    result = 0xA0001699;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_r.w %0, $ac1, 0x03\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0x01;
+    acl = 0xB4CB;
+    result = 0x10000B4D;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_r.w %0, $ac1, 0x04\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0x3fffffff;
+    acl = 0x2bcdef01;
+    result = 0x7ffffffe;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_r.w %0, $ac1, 0x1F\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0xFFFFFFFF;
+    acl = 0xFFFFFFFF;
+    result = 0;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_r.w %0, $ac1, 0x1F\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+         );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c
new file mode 100644
index 0000000..f9d2ed6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c
@@ -0,0 +1,117 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, ach, acl, dsp;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    result = 0x7FFFFFFF;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_rs.w %0, $ac1, 0x03\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0x01;
+    acl = 0xB4CB;
+    result = 0x10000B4D;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_rs.w %0, $ac1, 0x04\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0x3fffffff;
+    acl = 0x2bcdef01;
+    result = 0x7ffffffe;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_rs.w %0, $ac1, 0x1F\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0x80000000;
+    acl = 0x00000000;
+    result = 0x80000000;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_rs.w %0, $ac1, 0x1F\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0xFFFFFFFF;
+    acl = 0xFFFFFFFF;
+    result = 0;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_rs.w %0, $ac1, 0x1F\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+         );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c
new file mode 100644
index 0000000..9bc2a63
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c
@@ -0,0 +1,86 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, ach, acl, dsp;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    result = 0x00007FFF;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_s.h %0, $ac1, 0x03\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    ach = 0xffffffff;
+    acl = 0x12344321;
+    result = 0xFFFF8000;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_s.h %0, $ac1, 0x08\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    /* Clear dsp */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0x00;
+    acl = 0x4321;
+    result = 0x432;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_s.h %0, $ac1, 0x04\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    /* Clear dsp */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0x123;
+    acl = 0x87654321;
+    result = 0x1238;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr_s.h %0, $ac1, 28\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c
new file mode 100644
index 0000000..cf92614
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c
@@ -0,0 +1,94 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, ach, acl, dsp;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    result = 0xA0001699;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr.w %0, $ac1, 0x03\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0x01;
+    acl = 0xB4CB;
+    result = 0x10000B4C;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr.w %0, $ac1, 0x04\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0x3fffffff;
+    acl = 0x2bcdef01;
+    result = 0x7ffffffe;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr.w %0, $ac1, 0x1F\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    ach = 0xFFFFFFFF;
+    acl = 0xFFFFFFFF;
+    result = 0xFFFFFFFF;
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "extr.w %0, $ac1, 0x1F\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "=r"(dsp)
+         : "r"(ach), "r"(acl)
+         );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c
new file mode 100644
index 0000000..2403b3a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c
@@ -0,0 +1,79 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs, ach, acl, dsp;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x07;
+    rs  = 0x03;
+    result = 0xA0001699;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv_r.w %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    rs = 4;
+    ach = 0x01;
+    acl = 0xB4CB;
+    result = 0x10000B4D;
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv_r.w %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    rs = 31;
+    ach = 0x3fffffff;
+    acl = 0x2bcdef01;
+    result = 0x7ffffffe;
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv_r.w %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c
new file mode 100644
index 0000000..ccceeb9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c
@@ -0,0 +1,77 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs, ach, acl, dsp;
+    int result;
+
+    rs = 0x03;
+    ach = 0x05;
+    acl = 0xB4CB;
+    result = 0x7FFFFFFF;
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv_rs.w %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    rs = 0x04;
+    ach = 0x01;
+    acl = 0xB4CB;
+    result = 0x10000B4D;
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv_rs.w %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    rs = 0x1F;
+    ach = 0x3fffffff;
+    acl = 0x2bcdef01;
+    result = 0x7ffffffe;
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv_rs.w %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c
new file mode 100644
index 0000000..feac3e2
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c
@@ -0,0 +1,88 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs, ach, acl, dsp;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x07;
+    rs  = 0x03;
+    result = 0x00007FFF;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv_s.h %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    rs = 0x08;
+    ach = 0xffffffff;
+    acl = 0x12344321;
+    result = 0xFFFF8000;
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv_s.h %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    /* Clear dsp */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    rs = 0x04;
+    ach = 0x00;
+    acl = 0x4321;
+    result = 0x432;
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv_s.h %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    rs = 0x1C;
+    ach = 0x123;
+    acl = 0x87654321;
+    result = 0x1238;
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv_s.h %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c
new file mode 100644
index 0000000..9e8b238
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c
@@ -0,0 +1,80 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs, ach, acl, dsp;
+    int result;
+
+    ach = 0x05;
+    acl = 0xB4CB;
+    dsp = 0x07;
+    rs  = 0x03;
+    result = 0xA0001699;
+
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv.w %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 1);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    rs = 4;
+    ach = 0x01;
+    acl = 0xB4CB;
+    result = 0x10000B4C;
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv.w %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+    /* Clear dspcontrol */
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    rs = 31;
+    ach = 0x3fffffff;
+    acl = 0x2bcdef01;
+    result = 0x7ffffffe;
+    __asm
+        ("wrdsp %1, 0x01\n\t"
+         "mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "extrv.w %0, $ac1, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rt), "+r"(dsp)
+         : "r"(rs), "r"(ach), "r"(acl)
+        );
+    dsp = (dsp >> 23) & 0x01;
+    assert(dsp == 0);
+    assert(result == rt);
+
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c
new file mode 100644
index 0000000..9d67469
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c
@@ -0,0 +1,36 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs, dsp;
+    int result;
+
+    /* msb = 10, lsb = 5 */
+    dsp    = 0x305;
+    rt     = 0x12345678;
+    rs     = 0x87654321;
+    result = 0x12345438;
+    __asm
+        ("wrdsp %2, 0x03\n\t"
+         "insv  %0, %1\n\t"
+         : "+r"(rt)
+         : "r"(rs), "r"(dsp)
+        );
+    assert(rt == result);
+
+    dsp    = 0x1000;
+    rt     = 0xF0F0F0F0;
+    rs     = 0xA5A5A5A5;
+    result = 0xA5A5A5A5;
+
+    __asm
+        ("wrdsp %2\n\t"
+         "insv  %0, %1\n\t"
+         : "+r"(rt)
+         : "r"(rs), "r"(dsp)
+        );
+    assert(rt == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c
new file mode 100644
index 0000000..2337abe
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c
@@ -0,0 +1,25 @@
+#include <stdio.h>
+#include <assert.h>
+
+int main(void)
+{
+    int value, rd;
+    int *p;
+    unsigned long addr, index;
+    int result;
+
+    value  = 0xBCDEF389;
+    p = &value;
+    addr = (unsigned long)p;
+    index  = 0;
+    result = value & 0xFF;
+    __asm
+        ("lbux %0, %1(%2)\n\t"
+         : "=r"(rd)
+         : "r"(index), "r"(addr)
+        );
+
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c
new file mode 100644
index 0000000..10be3b3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c
@@ -0,0 +1,25 @@
+#include <stdio.h>
+#include <assert.h>
+
+int main(void)
+{
+    int value, rd;
+    int *p;
+    unsigned long addr, index;
+    int result;
+
+    value  = 0xBCDEF389;
+    p = &value;
+    addr = (unsigned long)p;
+    index  = 0;
+    result = 0xFFFFF389;
+    __asm
+        ("lhx %0, %1(%2)\n\t"
+         : "=r"(rd)
+         : "r"(index), "r"(addr)
+        );
+
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c
new file mode 100644
index 0000000..e6543c9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c
@@ -0,0 +1,25 @@
+#include <stdio.h>
+#include <assert.h>
+
+int main(void)
+{
+    int value, rd;
+    int *p;
+    unsigned long addr, index;
+    int result;
+
+    value  = 0xBCDEF389;
+    p = &value;
+    addr = (unsigned long)p;
+    index  = 0;
+    result = 0xBCDEF389;
+    __asm
+        ("lwx %0, %1(%2)\n\t"
+         : "=r"(rd)
+         : "r"(index), "r"(addr)
+        );
+
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c
new file mode 100644
index 0000000..af4bfcf
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c
@@ -0,0 +1,31 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs;
+    int achi, acli;
+    int acho, aclo;
+    int resulth, resultl;
+
+    achi = 0x05;
+    acli = 0xB4CB;
+    rs  = 0x01;
+    rt  = 0x01;
+    resulth = 0x05;
+    resultl = 0xB4CC;
+
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "madd $ac1, %4, %5\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "=r"(acho), "=r"(aclo)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(resulth == acho);
+    assert(resultl == aclo);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c
new file mode 100644
index 0000000..af4bfcf
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c
@@ -0,0 +1,31 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs;
+    int achi, acli;
+    int acho, aclo;
+    int resulth, resultl;
+
+    achi = 0x05;
+    acli = 0xB4CB;
+    rs  = 0x01;
+    rt  = 0x01;
+    resulth = 0x05;
+    resultl = 0xB4CC;
+
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "madd $ac1, %4, %5\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "=r"(acho), "=r"(aclo)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(resulth == acho);
+    assert(resultl == aclo);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c
new file mode 100644
index 0000000..b296b20
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c
@@ -0,0 +1,6 @@
+#include<stdio.h>
+
+int main()
+{
+    printf("hello world\n");
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c
new file mode 100644
index 0000000..0f7c070
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c
@@ -0,0 +1,55 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs;
+    int achi, acli;
+    int dsp;
+    int acho, aclo;
+    int resulth, resultl;
+    int resdsp;
+
+    achi = 0x00000005;
+    acli = 0x0000B4CB;
+    rs  = 0xFF060000;
+    rt  = 0xCB000000;
+    resulth = 0x00000005;
+    resultl = 0x006838CB;
+
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "maq_s.w.phl $ac1, %4, %5\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "=r"(acho), "=r"(aclo)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(resulth == acho);
+    assert(resultl == aclo);
+
+    achi = 0x00000006;
+    acli = 0x0000B4CB;
+    rs  = 0x80000000;
+    rt  = 0x80000000;
+    resulth = 0x00000006;
+    resultl = 0x8000B4CA;
+    resdsp = 1;
+
+    __asm
+        ("mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "maq_s.w.phl $ac1, %5, %6\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "=r"(acho), "=r"(aclo), "=r"(dsp)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(resulth == acho);
+    assert(resultl == aclo);
+    assert(((dsp >> 17) & 0x01) == resdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c
new file mode 100644
index 0000000..942722a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c
@@ -0,0 +1,55 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs;
+    int achi, acli;
+    int dsp;
+    int acho, aclo;
+    int resulth, resultl;
+    int resdsp;
+
+    achi = 0x00000005;
+    acli = 0x0000B4CB;
+    rs  = 0x0000FF06;
+    rt  = 0x0000CB00;
+    resulth = 0x00000005;
+    resultl = 0x006838CB;
+
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "maq_s.w.phr $ac1, %4, %5\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "=r"(acho), "=r"(aclo)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(resulth == acho);
+    assert(resultl == aclo);
+
+    achi = 0x00000006;
+    acli = 0x0000B4CB;
+    rs  = 0x00008000;
+    rt  = 0x00008000;
+    resulth = 0x00000006;
+    resultl = 0x8000B4CA;
+    resdsp = 1;
+
+    __asm
+        ("mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "maq_s.w.phr $ac1, %5, %6\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "=r"(acho), "=r"(aclo), "=r"(dsp)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(resulth == acho);
+    assert(resultl == aclo);
+    assert(((dsp >> 17) & 0x01) == resdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c
new file mode 100644
index 0000000..d83dce6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c
@@ -0,0 +1,55 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs;
+    int achi, acli;
+    int dsp;
+    int acho, aclo;
+    int resulth, resultl;
+    int resdsp;
+
+    achi = 0x00000000;
+    acli = 0x0000B4CB;
+    rs = 0xFF060000;
+    rt = 0xCB000000;
+    resulth = 0x00000000;
+    resultl = 0x006838CB;
+
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "maq_sa.w.phl $ac1, %4, %5\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "=r"(acho), "=r"(aclo)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(resulth == acho);
+    assert(resultl == aclo);
+
+    achi = 0x00000000;
+    acli = 0x0000B4CB;
+    rs  = 0x80000000;
+    rt  = 0x80000000;
+    resulth = 0x00;
+    resultl = 0x7fffffff;
+    resdsp = 0x01;
+
+    __asm
+        ("mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "maq_sa.w.phl $ac1, %5, %6\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "=r"(acho), "=r"(aclo), "=r"(dsp)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(resulth == acho);
+    assert(resultl == aclo);
+    assert(((dsp >> 17) & 0x01) == 0x01);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c
new file mode 100644
index 0000000..d233111
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c
@@ -0,0 +1,55 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rt, rs;
+    int achi, acli;
+    int dsp;
+    int acho, aclo;
+    int resulth, resultl;
+    int resdsp;
+
+    achi = 0x00000000;
+    acli = 0x0000B4CB;
+    rs  = 0x0000FF06;
+    rt  = 0x0000CB00;
+    resulth = 0x00000000;
+    resultl = 0x006838CB;
+
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "maq_sa.w.phr $ac1, %4, %5\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "=r"(acho), "=r"(aclo)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(resulth == acho);
+    assert(resultl == aclo);
+
+    achi = 0x00000000;
+    acli = 0x0000B4CB;
+    rs  = 0x00008000;
+    rt  = 0x00008000;
+    resulth = 0x00000000;
+    resultl = 0x7FFFFFFF;
+    resdsp = 0x01;
+
+    __asm
+        ("mthi %3, $ac1\n\t"
+         "mtlo %4, $ac1\n\t"
+         "maq_sa.w.phr $ac1, %5, %6\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "=r"(acho), "=r"(aclo), "=r"(dsp)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(resulth == acho);
+    assert(resultl == aclo);
+    assert(((dsp >> 17) & 0x01) == 0x01);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c
new file mode 100644
index 0000000..43a8066
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int achi, acho;
+    int result;
+
+    achi   = 0x004433;
+    result = 0x004433;
+
+    __asm
+        ("mthi %1, $ac1\n\t"
+         "mfhi %0, $ac1\n\t"
+         : "=r"(acho)
+         : "r"(achi)
+        );
+    assert(result == acho);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c
new file mode 100644
index 0000000..caeafdb
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int acli, aclo;
+    int result;
+
+    acli   = 0x004433;
+    result = 0x004433;
+
+    __asm
+        ("mthi %1, $ac1\n\t"
+         "mfhi %0, $ac1\n\t"
+         : "=r"(aclo)
+         : "r"(acli)
+        );
+    assert(result == aclo);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c
new file mode 100644
index 0000000..c294eeb
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0xFFFFFFFF;
+    rt     = 0x000000FF;
+    result = 0xFFFFFF00;
+    __asm
+        ("modsub %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    rs     = 0x00000000;
+    rt     = 0x00CD1FFF;
+    result = 0x0000CD1F;
+    __asm
+        ("modsub %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c
new file mode 100644
index 0000000..5779e6f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int achi, acli, rs, rt;
+    int acho, aclo;
+    int resulth, resultl;
+
+    rs      = 0x00BBAACC;
+    rt      = 0x0B1C3D2F;
+    achi    = 0x00004433;
+    acli    = 0xFFCC0011;
+    resulth = 0xFFF81F29;
+    resultl = 0xB355089D;
+
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "msub $ac1, %4, %5\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "=r"(acho), "=r"(aclo)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(acho == resulth);
+    assert(aclo == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c
new file mode 100644
index 0000000..e0f9b5a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int achi, acli, rs, rt;
+    int acho, aclo;
+    int resulth, resultl;
+
+    rs      = 0x00BBAACC;
+    rt      = 0x0B1C3D2F;
+    achi    = 0x00004433;
+    acli    = 0xFFCC0011;
+    resulth = 0xFFF81F29;
+    resultl = 0xB355089D;
+
+    __asm
+        ("mthi %2, $ac1\n\t"
+         "mtlo %3, $ac1\n\t"
+         "msubu $ac1, %4, %5\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "=r"(acho), "=r"(aclo)
+         : "r"(achi), "r"(acli), "r"(rs), "r"(rt)
+        );
+    assert(acho == resulth);
+    assert(aclo == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c
new file mode 100644
index 0000000..43a8066
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int achi, acho;
+    int result;
+
+    achi   = 0x004433;
+    result = 0x004433;
+
+    __asm
+        ("mthi %1, $ac1\n\t"
+         "mfhi %0, $ac1\n\t"
+         : "=r"(acho)
+         : "r"(achi)
+        );
+    assert(result == acho);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c
new file mode 100644
index 0000000..85f94d8
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c
@@ -0,0 +1,58 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, ach, acl, dsp;
+    int result, resulth, resultl;
+
+    dsp = 0x07;
+    ach = 0x05;
+    acl = 0xB4CB;
+    rs  = 0x00FFBBAA;
+    resulth = 0xB4CB;
+    resultl = 0x00FFBBAA;
+    result  = 0x27;
+
+    __asm
+        ("wrdsp %0, 0x01\n\t"
+         "mthi %1, $ac1\n\t"
+         "mtlo %2, $ac1\n\t"
+         "mthlip %3, $ac1\n\t"
+         "mfhi %1, $ac1\n\t"
+         "mflo %2, $ac1\n\t"
+         "rddsp %0\n\t"
+         : "+r"(dsp), "+r"(ach), "+r"(acl)
+         : "r"(rs)
+        );
+    dsp = dsp & 0x3F;
+    assert(dsp == result);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    dsp = 0x1f;
+    ach = 0x05;
+    acl = 0xB4CB;
+    rs  = 0x00FFBBAA;
+    resulth = 0xB4CB;
+    resultl = 0x00FFBBAA;
+    result  = 0x3f;
+
+    __asm
+        ("wrdsp %0, 0x01\n\t"
+         "mthi %1, $ac1\n\t"
+         "mtlo %2, $ac1\n\t"
+         "mthlip %3, $ac1\n\t"
+         "mfhi %1, $ac1\n\t"
+         "mflo %2, $ac1\n\t"
+         "rddsp %0\n\t"
+         : "+r"(dsp), "+r"(ach), "+r"(acl)
+         : "r"(rs)
+        );
+    dsp = dsp & 0x3F;
+    assert(dsp == result);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c
new file mode 100644
index 0000000..caeafdb
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int acli, aclo;
+    int result;
+
+    acli   = 0x004433;
+    result = 0x004433;
+
+    __asm
+        ("mthi %1, $ac1\n\t"
+         "mfhi %0, $ac1\n\t"
+         : "=r"(aclo)
+         : "r"(acli)
+        );
+    assert(result == aclo);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c
new file mode 100644
index 0000000..b3a5370
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c
@@ -0,0 +1,41 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x80001234;
+    rt = 0x80001234;
+    result = 0x7FFFFFFF;
+    resultdsp = 1;
+
+    __asm
+        ("muleq_s.w.phl %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    rs = 0x12349988;
+    rt = 0x43219988;
+    result = 0x98be968;
+    resultdsp = 1;
+
+    __asm
+        ("muleq_s.w.phl %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    return 0;
+}
+
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c
new file mode 100644
index 0000000..8066d7d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c
@@ -0,0 +1,40 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x8000;
+    rt = 0x8000;
+    result = 0x7FFFFFFF;
+    resultdsp = 1;
+
+    __asm
+        ("muleq_s.w.phr %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    rs = 0x1234;
+    rt = 0x4321;
+    result = 0x98be968;
+    resultdsp = 1;
+
+    __asm
+        ("muleq_s.w.phr %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c
new file mode 100644
index 0000000..66a3828
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c
@@ -0,0 +1,25 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x80001234;
+    rt = 0x80004321;
+    result = 0xFFFF0000;
+    resultdsp = 1;
+
+    __asm
+        ("muleu_s.ph.qbl %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c
new file mode 100644
index 0000000..4cc6c8f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c
@@ -0,0 +1,25 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x8000;
+    rt = 0x80004321;
+    result = 0xFFFF0000;
+    resultdsp = 1;
+
+    __asm
+        ("muleu_s.ph.qbr %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c
new file mode 100644
index 0000000..370c2a8
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c
@@ -0,0 +1,42 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x80001234;
+    rt = 0x80004321;
+    result = 0x7FFF098C;
+    resultdsp = 1;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "mulq_rs.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    rs = 0x80011234;
+    rt = 0x80024321;
+    result = 0x7FFD098C;
+    resultdsp = 0;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "mulq_rs.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c
new file mode 100644
index 0000000..15e6fde
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c
@@ -0,0 +1,24 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, ach, acl;
+    int result, resulth, resultl;
+
+    rs  = 0x00FFBBAA;
+    rt  = 0x4B231000;
+    resulth = 0x4b0f01;
+    resultl = 0x71f8a000;
+    __asm
+        ("mult $ac1, %2, %3\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "=r"(ach), "=r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c
new file mode 100644
index 0000000..85d36c1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c
@@ -0,0 +1,24 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, ach, acl;
+    int result, resulth, resultl;
+
+    rs  = 0x00FFBBAA;
+    rt  = 0x4B231000;
+    resulth = 0x4b0f01;
+    resultl = 0x71f8a000;
+    __asm
+        ("multu $ac1, %2, %3\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "=r"(ach), "=r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c
new file mode 100644
index 0000000..1f8e699
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x56788765;
+
+    __asm
+        ("packrl.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c
new file mode 100644
index 0000000..929a002
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c
@@ -0,0 +1,49 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    dsp = 0x0A000000;
+    result = 0x12344321;
+
+    __asm
+        ("wrdsp %3, 0x10\n\t"
+         "pick.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt), "r"(dsp)
+        );
+    assert(rd == result);
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    dsp = 0x03000000;
+    result = 0x12345678;
+
+    __asm
+        ("wrdsp %3, 0x10\n\t"
+         "pick.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt), "r"(dsp)
+        );
+    assert(rd == result);
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    dsp = 0x00000000;
+    result = 0x87654321;
+
+    __asm
+        ("wrdsp %3, 0x10\n\t"
+         "pick.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt), "r"(dsp)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c
new file mode 100644
index 0000000..a790475
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c
@@ -0,0 +1,36 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    dsp = 0x0f000000;
+    result = 0x12345678;
+
+    __asm
+        ("wrdsp %3, 0x10\n\t"
+         "pick.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt), "r"(dsp)
+        );
+    assert(rd == result);
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    dsp = 0x00000000;
+    result = 0x87654321;
+
+    __asm
+        ("wrdsp %3, 0x10\n\t"
+         "pick.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt), "r"(dsp)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c
new file mode 100644
index 0000000..bf70bf7
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x87654321;
+    result = 0x87650000;
+
+    __asm
+        ("preceq.w.phl %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c
new file mode 100644
index 0000000..3f885ef
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x87654321;
+    result = 0x43210000;
+
+    __asm
+        ("preceq.w.phr %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c
new file mode 100644
index 0000000..63b7a95
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x87654321;
+    result = 0x43803280;
+
+    __asm
+        ("precequ.ph.qbl %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c
new file mode 100644
index 0000000..31627f0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x87654321;
+    result = 0x43802180;
+
+    __asm
+        ("precequ.ph.qbla %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c
new file mode 100644
index 0000000..b6f72d3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x87654321;
+    result = 0x21801080;
+
+    __asm
+        ("precequ.ph.qbr %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c
new file mode 100644
index 0000000..4764fd0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x87654321;
+    result = 0x32801080;
+
+    __asm
+        ("precequ.ph.qbra %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c
new file mode 100644
index 0000000..fa95c26
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x87654321;
+    result = 0x00870065;
+
+    __asm
+        ("preceu.ph.qbl %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c
new file mode 100644
index 0000000..021f21a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x87654321;
+    result = 0x00870043;
+
+    __asm
+        ("preceu.ph.qbla %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c
new file mode 100644
index 0000000..03df18c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x87654321;
+    result = 0x00430021;
+
+    __asm
+        ("preceu.ph.qbr %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c
new file mode 100644
index 0000000..6343276
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x87654321;
+    result = 0x00650021;
+
+    __asm
+        ("preceu.ph.qbra %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c
new file mode 100644
index 0000000..25d45f1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x12348765;
+
+    __asm
+        ("precrq.ph.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c
new file mode 100644
index 0000000..fe23acc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x12568743;
+
+    __asm
+        ("precrq.qb.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c
new file mode 100644
index 0000000..da6845b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c
@@ -0,0 +1,51 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x12348765;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "precrq_rs.ph.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    rs = 0x7FFFC678;
+    rt = 0x865432A0;
+    result = 0x7FFF8654;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "precrq_rs.ph.w %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(((dsp >> 22) & 0x01) == 1);
+    assert(result == rd);
+
+    rs = 0xBEEFFEED;
+    rt = 0x7FFF8000;
+    result = 0xBEF07FFF;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "precrq_rs.ph.w %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(((dsp >> 22) & 0x01) == 1);
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c
new file mode 100644
index 0000000..7481d5a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c
@@ -0,0 +1,24 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87657FFF;
+    result = 0x24AC00FF;
+
+    __asm
+        ("precrqu_s.qb.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+    assert(((dsp >> 22) & 0x01) == 0x01);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c
new file mode 100644
index 0000000..77a983c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs;
+    int result;
+
+    rs = 0x12345678;
+    result = 0x114;
+
+    __asm
+        ("raddu.w.qb %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rs)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c
new file mode 100644
index 0000000..2f30285
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c
@@ -0,0 +1,46 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int dsp_i, dsp_o;
+    int ccond_i, outflag_i, efi_i, c_i, scount_i, pos_i;
+    int ccond_o, outflag_o, efi_o, c_o, scount_o, pos_o;
+
+    ccond_i   = 0x0000000C;  /* 4 */
+    outflag_i = 0x0000001B;  /* 3 */
+    efi_i     = 0x00000001;  /* 5 */
+    c_i       = 0x00000001;  /* 2 */
+    scount_i  = 0x0000000F;  /* 1 */
+    pos_i     = 0x0000000C;  /* 0 */
+
+    dsp_i = (ccond_i   << 24) | \
+            (outflag_i << 16) | \
+            (efi_i     << 14) | \
+            (c_i       << 13) | \
+            (scount_i  <<  7) | \
+            pos_i;
+
+    __asm
+        ("wrdsp %1, 0x3F\n\t"
+         "rddsp %0, 0x3F\n\t"
+         : "=r"(dsp_o)
+         : "r"(dsp_i)
+        );
+
+    ccond_o   = (dsp_o >> 24) & 0xFF;
+    outflag_o = (dsp_o >> 16) & 0xFF;
+    efi_o     = (dsp_o >> 14) & 0x01;
+    c_o       = (dsp_o >> 14) & 0x01;
+    scount_o  = (dsp_o >>  7) & 0x3F;
+    pos_o     =  dsp_o & 0x1F;
+
+    assert(ccond_o   == ccond_i);
+    assert(outflag_o == outflag_i);
+    assert(efi_o     == efi_i);
+    assert(c_o       == c_i);
+    assert(scount_o  == scount_i);
+    assert(pos_o     == pos_i);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c
new file mode 100644
index 0000000..2107495
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c
@@ -0,0 +1,23 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, result;
+
+    result = 0x01BF01BF;
+    __asm
+        ("repl.ph %0, 0x1BF\n\t"
+         : "=r"(rd)
+        );
+    assert(rd == result);
+
+    result = 0x01FF01FF;
+    __asm
+        ("repl.ph %0, 0x01FF\n\t"
+         : "=r"(rd)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c
new file mode 100644
index 0000000..6631393
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c
@@ -0,0 +1,16 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, result;
+
+    result = 0xBFBFBFBF;
+    __asm
+        ("repl.qb %0, 0xBF\n\t"
+         : "=r"(rd)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c
new file mode 100644
index 0000000..07fb15f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c
@@ -0,0 +1,19 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x12345678;
+    result = 0x56785678;
+    __asm
+        ("replv.ph %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c
new file mode 100644
index 0000000..dd1271f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c
@@ -0,0 +1,19 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt     = 0x12345678;
+    result = 0x78787878;
+    __asm
+        ("replv.qb %0, %1\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c
new file mode 100644
index 0000000..ce8ebc6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c
@@ -0,0 +1,45 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int ach, acl;
+    int resulth, resultl;
+
+    ach = 0xBBAACCFF;
+    acl = 0x1C3B001D;
+
+    resulth = 0x17755;
+    resultl = 0x99fe3876;
+
+    __asm
+        ("mthi %0, $ac1\n\t"
+         "mtlo %1, $ac1\n\t"
+         "shilo $ac1, 0x0F\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+
+    ach = 0x1;
+    acl = 0x80000000;
+
+    resulth = 0x3;
+    resultl = 0x0;
+
+    __asm
+        ("mthi %0, $ac1\n\t"
+         "mtlo %1, $ac1\n\t"
+         "shilo $ac1, -1\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c
new file mode 100644
index 0000000..e1d6cea
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c
@@ -0,0 +1,49 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, ach, acl;
+    int resulth, resultl;
+
+    rs  = 0x0F;
+    ach = 0xBBAACCFF;
+    acl = 0x1C3B001D;
+
+    resulth = 0x17755;
+    resultl = 0x99fe3876;
+
+    __asm
+        ("mthi %0, $ac1\n\t"
+         "mtlo %1, $ac1\n\t"
+         "shilov $ac1, %2\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+
+    rs  = 0xffffffff;
+    ach = 0x1;
+    acl = 0x80000000;
+
+    resulth = 0x3;
+    resultl = 0x0;
+
+    __asm
+        ("mthi %0, $ac1\n\t"
+         "mtlo %1, $ac1\n\t"
+         "shilov $ac1, %2\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c
new file mode 100644
index 0000000..5fa58cc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c
@@ -0,0 +1,55 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt, dsp;
+    int result, resultdsp;
+
+    rt        = 0x12345678;
+    result    = 0xA000C000;
+    resultdsp = 1;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "shll.ph %0, %2, 0x0B\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rt        = 0x7fff8000;
+    result    = 0xfffe0000;
+    resultdsp = 1;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "shll.ph %0, %2, 0x01\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rt        = 0x00000001;
+    result    = 0x00008000;
+    resultdsp = 1;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "shll.ph %0, %2, 0x0F\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c
new file mode 100644
index 0000000..729716d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c
@@ -0,0 +1,55 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt, dsp;
+    int result, resultdsp;
+
+    rt     = 0x87654321;
+    result  = 0x87654321;
+    resultdsp = 0x00;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "shll.qb %0, %2, 0x00\n\t"
+         "rddsp   %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd == result);
+
+    rt     = 0x87654321;
+    result = 0x38281808;
+    resultdsp = 0x01;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "shll.qb %0, %2, 0x03\n\t"
+         "rddsp   %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd == result);
+
+    rt     = 0x00000001;
+    result = 0x00000080;
+    resultdsp = 0x00;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "shll.qb %0, %2, 0x07\n\t"
+         "rddsp   %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c
new file mode 100644
index 0000000..910fea3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c
@@ -0,0 +1,24 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt, dsp;
+    int result, resultdsp;
+
+    rt        = 0x12345678;
+    result    = 0x7FFF7FFF;
+    resultdsp = 0x01;
+
+    __asm
+        ("shll_s.ph %0, %2, 0x0B\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c
new file mode 100644
index 0000000..628c752
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c
@@ -0,0 +1,52 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt, dsp;
+    int result, resultdsp;
+
+    rt        = 0x82345678;
+    result    = 0x82345678;
+    resultdsp = 0x00;
+
+    __asm
+        ("shll_s.w %0, %2, 0x0\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rt        = 0x82345678;
+    result    = 0x80000000;
+    resultdsp = 0x01;
+
+    __asm
+        ("shll_s.w %0, %2, 0x0B\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rt        = 0x12345678;
+    result    = 0x7FFFFFFF;
+    resultdsp = 0x01;
+
+    __asm
+        ("shll_s.w %0, %2, 0x0B\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c
new file mode 100644
index 0000000..f98a632
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c
@@ -0,0 +1,40 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs        = 0x0;
+    rt        = 0x12345678;
+    result    = 0x12345678;
+    resultdsp = 0;
+
+    __asm
+        ("shllv.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt), "r"(rs)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rs        = 0x0B;
+    rt        = 0x12345678;
+    result    = 0xA000C000;
+    resultdsp = 1;
+
+    __asm
+        ("shllv.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt), "r"(rs)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c
new file mode 100644
index 0000000..6d8ff4a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c
@@ -0,0 +1,38 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs     = 0x03;
+    rt     = 0x87654321;
+    result = 0x38281808;
+    resultdsp = 0x01;
+
+    __asm
+        ("shllv.qb %0, %2, %3\n\t"
+         "rddsp   %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt), "r"(rs)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(rd == result);
+
+    rs     = 0x00;
+    rt     = 0x87654321;
+    result = 0x87654321;
+    resultdsp = 0x01;
+
+    __asm
+        ("shllv.qb %0, %2, %3\n\t"
+         "rddsp   %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt), "r"(rs)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c
new file mode 100644
index 0000000..fc9bd32
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c
@@ -0,0 +1,40 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs        = 0x0;
+    rt        = 0x12345678;
+    result    = 0x12345678;
+    resultdsp = 0x0;
+
+    __asm
+        ("shllv_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt), "r"(rs)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rs        = 0x0B;
+    rt        = 0x12345678;
+    result    = 0x7FFF7FFF;
+    resultdsp = 0x01;
+
+    __asm
+        ("shllv_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt), "r"(rs)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c
new file mode 100644
index 0000000..350c256
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c
@@ -0,0 +1,40 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs        = 0x0B;
+    rt        = 0x12345678;
+    result    = 0x7FFFFFFF;
+    resultdsp = 0x01;
+
+    __asm
+        ("shllv_s.w %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt), "r"(rs)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rs        = 0x0;
+    rt        = 0x12345678;
+    result    = 0x12345678;
+    resultdsp = 0x01;
+
+    __asm
+        ("shllv_s.w %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rt), "r"(rs)
+        );
+    dsp = (dsp >> 22) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c
new file mode 100644
index 0000000..5b2d840
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt     = 0x87654321;
+    result = 0xF0EC0864;
+
+    __asm
+        ("shra.ph %0, %1, 0x03\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    rt     = 0x87654321;
+    result = 0x87654321;
+
+    __asm
+        ("shra.ph %0, %1, 0x00\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c
new file mode 100644
index 0000000..adc4ae6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt     = 0x87654321;
+    result = 0xF0ED0864;
+
+    __asm
+        ("shra_r.ph %0, %1, 0x03\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    rt     = 0x87654321;
+    result = 0x87654321;
+
+    __asm
+        ("shra_r.ph %0, %1, 0x00\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c
new file mode 100644
index 0000000..ec0cf2c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt     = 0x87654321;
+    result = 0xF0ECA864;
+
+    __asm
+        ("shra_r.w %0, %1, 0x03\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    rt     = 0x87654321;
+    result = 0x87654321;
+
+    __asm
+        ("shra_r.w %0, %1, 0x0\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c
new file mode 100644
index 0000000..6e42aaf
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c
@@ -0,0 +1,32 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x03;
+    rt     = 0x87654321;
+    result = 0xF0EC0864;
+
+    __asm
+        ("shrav.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    rs     = 0x00;
+    rt     = 0x87654321;
+    result = 0x87654321;
+
+    __asm
+        ("shrav.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c
new file mode 100644
index 0000000..f03b978
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c
@@ -0,0 +1,32 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x03;
+    rt     = 0x87654321;
+    result = 0xF0ED0864;
+
+    __asm
+        ("shrav_r.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    rs     = 0x00;
+    rt     = 0x87654321;
+    result = 0x87654321;
+
+    __asm
+        ("shrav_r.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c
new file mode 100644
index 0000000..2ab03bb
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c
@@ -0,0 +1,32 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x03;
+    rt     = 0x87654321;
+    result = 0xF0ECA864;
+
+    __asm
+        ("shrav_r.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    rs     = 0x00;
+    rt     = 0x40000000;
+    result = 0x40000000;
+
+    __asm
+        ("shrav_r.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+
+    assert(rd == result);
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c
new file mode 100644
index 0000000..a7e4e6a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c
@@ -0,0 +1,31 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt     = 0x12345678;
+    result = 0x00010203;
+
+    __asm
+        ("shrl.qb %0, %1, 0x05\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    rt     = 0x12345678;
+    result = 0x12345678;
+
+    __asm
+        ("shrl.qb %0, %1, 0x0\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c
new file mode 100644
index 0000000..db77f6d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c
@@ -0,0 +1,32 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x05;
+    rt     = 0x12345678;
+    result = 0x00010203;
+
+    __asm
+        ("shrlv.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    rs     = 0x00;
+    rt     = 0x12345678;
+    result = 0x12345678;
+
+    __asm
+        ("shrlv.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c
new file mode 100644
index 0000000..fdd7b38
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c
@@ -0,0 +1,40 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x77777777;
+    rt = 0x67654321;
+    result    = 0x10123456;
+    resultdsp = 0x0;
+
+    __asm
+        ("subq.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result    = 0x8ACF1357;
+    resultdsp = 0x01;
+
+    __asm
+        ("subq.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c
new file mode 100644
index 0000000..64c89eb
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c
@@ -0,0 +1,58 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result    = 0x7FFF1357;
+    resultdsp = 0x01;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "subq_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rs = 0x12348000;
+    rt = 0x87657000;
+    result    = 0x7FFF8000;
+    resultdsp = 0x01;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "subq_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rs = 0x12340000;
+    rt = 0x87658000;
+    result    = 0x7FFF7FFF;
+    resultdsp = 0x01;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "subq_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c
new file mode 100644
index 0000000..9d456a9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c
@@ -0,0 +1,74 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result    = 0x7FFFFFFF;
+    resultdsp = 0x01;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "subq_s.w %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rs = 0x66666;
+    rt = 0x55555;
+    result    = 0x11111;
+    resultdsp = 0x0;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "subq_s.w %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rs = 0x0;
+    rt = 0x80000000;
+    result    = 0x7FFFFFFF;
+    resultdsp = 0x01;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "subq_s.w %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rs = 0x80000000;
+    rt = 0x80000000;
+    result    = 0;
+    resultdsp = 0x00;
+
+    __asm
+        ("wrdsp $0\n\t"
+         "subq_s.w %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c
new file mode 100644
index 0000000..4209096
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c
@@ -0,0 +1,25 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result    = 0x8BCF1357;
+    resultdsp = 0x01;
+
+    __asm
+        ("subu.qb %0, %2, %3\n\t"
+         "rddsp   %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c
new file mode 100644
index 0000000..3d65053
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c
@@ -0,0 +1,25 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result    = 0x00001357;
+    resultdsp = 0x01;
+
+    __asm
+        ("subu_s.qb %0, %2, %3\n\t"
+         "rddsp   %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c
new file mode 100644
index 0000000..dc54943
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c
@@ -0,0 +1,46 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int dsp_i, dsp_o;
+    int ccond_i, outflag_i, efi_i, c_i, scount_i, pos_i;
+    int ccond_o, outflag_o, efi_o, c_o, scount_o, pos_o;
+
+    ccond_i   = 0x000000BC;  /* 4 */
+    outflag_i = 0x0000001B;  /* 3 */
+    efi_i     = 0x00000001;  /* 5 */
+    c_i       = 0x00000001;  /* 2 */
+    scount_i  = 0x0000000F;  /* 1 */
+    pos_i     = 0x0000000C;  /* 0 */
+
+    dsp_i = (ccond_i   << 24) | \
+            (outflag_i << 16) | \
+            (efi_i     << 14) | \
+            (c_i       << 13) | \
+            (scount_i  <<  7) | \
+            pos_i;
+
+    __asm
+        ("wrdsp %1, 0x3F\n\t"
+         "rddsp %0, 0x3F\n\t"
+         : "=r"(dsp_o)
+         : "r"(dsp_i)
+        );
+
+    ccond_o   = (dsp_o >> 24) & 0xFF;
+    outflag_o = (dsp_o >> 16) & 0xFF;
+    efi_o     = (dsp_o >> 14) & 0x01;
+    c_o       = (dsp_o >> 14) & 0x01;
+    scount_o  = (dsp_o >>  7) & 0x3F;
+    pos_o     =  dsp_o & 0x1F;
+
+    assert(ccond_o   == (ccond_i & 0x0F));
+    assert(outflag_o == outflag_i);
+    assert(efi_o     == efi_i);
+    assert(c_o       == c_i);
+    assert(scount_o  == scount_i);
+    assert(pos_o     == pos_i);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c
new file mode 100644
index 0000000..af4683f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c
@@ -0,0 +1,35 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int input, result, dsp;
+    int hope;
+
+    input = 0x701BA35E;
+    hope  = 0x701B5D5E;
+
+    __asm
+        ("absq_s.qb %0, %1\n\t"
+         : "=r"(result)
+         : "r"(input)
+        );
+    assert(result == hope);
+
+
+    input = 0x801BA35E;
+    hope  = 0x7F1B5D5E;
+
+    __asm
+        ("absq_s.qb %0, %2\n\t"
+         "rddsp %1\n\t"
+         : "=r"(result), "=r"(dsp)
+         : "r"(input)
+        );
+    dsp = dsp >> 20;
+    dsp &= 0x01;
+    assert(dsp == 1);
+    assert(result == hope);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c
new file mode 100644
index 0000000..921f0ea
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x706A13FE;
+    rt     = 0x13065174;
+    result = 0x41B832B9;
+    __asm
+        ("addqh.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    rs     = 0x81000100;
+    rt     = 0xc2000100;
+    result = 0xa1800100;
+    __asm
+        ("addqh.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c
new file mode 100644
index 0000000..213ba37
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x706A13FE;
+    rt     = 0x13065174;
+    result = 0x41B832B9;
+    __asm
+        ("addqh_r.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    rs     = 0x81010100;
+    rt     = 0xc2000100;
+    result = 0xa1810100;
+    __asm
+        ("addqh_r.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c
new file mode 100644
index 0000000..75a75c5
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c
@@ -0,0 +1,34 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x00000010;
+    rt     = 0x00000001;
+    result = 0x00000009;
+
+    __asm
+        ("addqh_r.w  %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+
+    assert(rd == result);
+
+    rs     = 0xFFFFFFFE;
+    rt     = 0x00000001;
+    result = 0x00000000;
+
+    __asm
+        ("addqh_r.w  %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c
new file mode 100644
index 0000000..de6926e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c
@@ -0,0 +1,34 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x00000010;
+    rt     = 0x00000001;
+    result = 0x00000008;
+
+    __asm
+        ("addqh.w  %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+
+    assert(rd == result);
+
+    rs     = 0xFFFFFFFE;
+    rt     = 0x00000001;
+    result = 0xFFFFFFFF;
+
+    __asm
+        ("addqh.w  %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c
new file mode 100644
index 0000000..1d7a25a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c
@@ -0,0 +1,33 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs     = 0x00FF00FF;
+    rt     = 0x00010001;
+    result = 0x01000100;
+    __asm
+        ("addu.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    rs     = 0xFFFF1111;
+    rt     = 0x00020001;
+    result = 0x00011112;
+    __asm
+        ("addu.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+    assert(((dsp >> 20) & 0x01) == 1);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c
new file mode 100644
index 0000000..979651b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c
@@ -0,0 +1,33 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs     = 0x00FE00FE;
+    rt     = 0x00020001;
+    result = 0x010000FF;
+    __asm
+        ("addu_s.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    rs     = 0xFFFF1111;
+    rt     = 0x00020001;
+    result = 0xFFFF1112;
+    __asm
+        ("addu_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+    assert(((dsp >> 20) & 0x01) == 1);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c
new file mode 100644
index 0000000..a1f5d63
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0xFF0055AA;
+    rt     = 0x0113421B;
+    result = 0x80094B62;
+    __asm
+        ("adduh.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    rs     = 0xFFFF0FFF;
+    rt     = 0x00010111;
+    result = 0x7F800888;
+    __asm
+        ("adduh.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c
new file mode 100644
index 0000000..81e98c1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0xFF0055AA;
+    rt     = 0x01112211;
+    result = 0x80093C5E;
+    __asm
+        ("adduh_r.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    rs     = 0xFFFF0FFF;
+    rt     = 0x00010111;
+    result = 0x80800888;
+    __asm
+        ("adduh_r.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c
new file mode 100644
index 0000000..9a91e16
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int result;
+
+    rs     = 0xFF0055AA;
+    rt     = 0x0113421B;
+    result = 0x02268436;
+    __asm
+        ("append %0, %1, 0x01\n\t"
+         : "+r"(rt)
+         : "r"(rs)
+        );
+    assert(rt == result);
+
+    rs     = 0xFFFF0FFF;
+    rt     = 0x00010111;
+    result = 0x0010111F;
+    __asm
+        ("append %0, %1, 0x04\n\t"
+         : "+r"(rt)
+         : "r"(rs)
+        );
+    assert(rt == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c
new file mode 100644
index 0000000..537cf04
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int result;
+
+    rs     = 0xFF0055AA;
+    rt     = 0x0113421B;
+    result = 0x13421BFF;
+    __asm
+        ("balign %0, %1, 0x01\n\t"
+         : "+r"(rt)
+         : "r"(rs)
+        );
+    assert(rt == result);
+
+    rs     = 0xFFFF0FFF;
+    rt     = 0x00010111;
+    result = 0x11FFFF0F;
+    __asm
+        ("balign %0, %1, 0x03\n\t"
+         : "+r"(rt)
+         : "r"(rs)
+        );
+    assert(rt == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c
new file mode 100644
index 0000000..2d6340d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c
@@ -0,0 +1,37 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs = 0x11777066;
+    rt = 0x55AA70FF;
+    result = 0x02;
+    __asm
+        ("cmpgdu.eq.qb %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(rd  == result);
+    assert(dsp == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11777066;
+    result = 0x0F;
+    __asm
+        ("cmpgdu.eq.qb %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(rd  == result);
+    assert(dsp == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c
new file mode 100644
index 0000000..a0ecdca
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c
@@ -0,0 +1,37 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs         = 0x11777066;
+    rt         = 0x55AA70FF;
+    result     = 0x0F;
+    __asm
+        ("cmpgdu.le.qb %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(rd  == result);
+    assert(dsp == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11707066;
+    result = 0x0B;
+    __asm
+        ("cmpgdu.le.qb %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(rd  == result);
+    assert(dsp == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c
new file mode 100644
index 0000000..dba99e3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c
@@ -0,0 +1,37 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int dsp;
+    int result;
+
+    rs         = 0x11777066;
+    rt         = 0x55AA70FF;
+    result     = 0x0D;
+    __asm
+        ("cmpgdu.lt.qb %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(rd  == result);
+    assert(dsp == result);
+
+    rs     = 0x11777066;
+    rt     = 0x11777066;
+    result = 0x00;
+    __asm
+        ("cmpgdu.lt.qb %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 24) & 0x0F;
+    assert(rd  == result);
+    assert(dsp == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c
new file mode 100644
index 0000000..fae49f1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c
@@ -0,0 +1,44 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int ach = 5, acl = 5;
+    int resulth, resultl;
+
+    rs     = 0x00FF00FF;
+    rt     = 0x00010002;
+    resulth = 0x05;
+    resultl = 0x0302;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpa.w.ph $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 6, acl = 7;
+    rs     = 0xFFFF00FF;
+    rt     = 0xFFFF0002;
+    resulth = 0x06;
+    resultl = 0x206;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpa.w.ph $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c
new file mode 100644
index 0000000..ce87830
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c
@@ -0,0 +1,79 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, dsp;
+    int ach = 5, acl = 5;
+    int resulth, resultl, resultdsp;
+
+    rs     = 0x800000FF;
+    rt     = 0x00018000;
+    resulth = 0x05;
+    resultl = 0x80000202;
+    resultdsp = 0x01;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpaqx_s.w.ph $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach    = 5;
+    acl    = 5;
+    rs     = 0x00FF00FF;
+    rt     = 0x00010002;
+    resulth = 0x05;
+    resultl = 0x05FF;
+    /***********************************************************
+     * Because of we set outflag at last time, although this
+     * time we set nothing, but it is stay the last time value.
+     **********************************************************/
+    resultdsp = 0x01;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpaqx_s.w.ph $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach    = 5;
+    acl    = 5;
+    rs     = 0x800000FF;
+    rt     = 0x00028000;
+    resulth = 0x05;
+    resultl = 0x80000400;
+    resultdsp = 0x01;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpaqx_s.w.ph $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c
new file mode 100644
index 0000000..d551d64
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c
@@ -0,0 +1,57 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, dsp;
+    int ach, acl;
+    int resulth, resultl, resultdsp;
+
+    ach = 0x00000005;
+    acl = 0x00000005;
+    rs     = 0x00FF00FF;
+    rt     = 0x00010002;
+    resulth = 0x00;
+    resultl = 0x7FFFFFFF;
+    resultdsp = 0x01;
+    dsp = 0;
+    __asm
+        ("wrdsp %2\n\t"
+         "mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpaqx_sa.w.ph $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "+r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(dsp >> (16 + 1) == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 0x00000009;
+    acl = 0x0000000B;
+    rs     = 0x800000FF;
+    rt     = 0x00018000;
+    resulth = 0x00;
+    resultl = 0x7FFFFFFF;
+    resultdsp = 0x01;
+    dsp = 0;
+    __asm
+        ("wrdsp %2\n\t"
+         "mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpaqx_sa.w.ph $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "+r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    assert(dsp >> (16 + 1) == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c
new file mode 100644
index 0000000..514797c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c
@@ -0,0 +1,44 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int ach = 5, acl = 5;
+    int resulth, resultl;
+
+    rs     = 0x00FF00FF;
+    rt     = 0x00010002;
+    resulth = 0x05;
+    resultl = 0x0302;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpax.w.ph $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 6, acl = 7;
+    rs     = 0xFFFF00FF;
+    rt     = 0xFFFF0002;
+    resulth = 0x05;
+    resultl = 0xFFFFFF06;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpax.w.ph $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c
new file mode 100644
index 0000000..f51f9b9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c
@@ -0,0 +1,44 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int ach = 5, acl = 5;
+    int resulth, resultl;
+
+    rs     = 0x00FF00FF;
+    rt     = 0x00010002;
+    resulth = 0x04;
+    resultl = 0xFFFFFD08;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dps.w.ph $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 6, acl = 7;
+    rs     = 0xFFFF00FF;
+    rt     = 0xFFFF0002;
+    resulth = 0x05;
+    resultl = 0xFFFFFE08;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dps.w.ph $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c
new file mode 100644
index 0000000..e40543f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c
@@ -0,0 +1,54 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, dsp;
+    int ach = 5, acl = 5;
+    int resulth, resultl, resultdsp;
+
+    rs      = 0xBC0123AD;
+    rt      = 0x01643721;
+    resulth = 0x00000005;
+    resultl = 0x1CE5E09B;
+    resultdsp = 0x00;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsqx_s.w.ph $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 0x99F13005;
+    acl = 0x51730062;
+    rs      = 0x80008000;
+    rt      = 0x80008000;
+
+    resulth = 0x99F13004;
+    resultl = 0x51730064;
+    resultdsp = 0x01;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsqx_s.w.ph $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c
new file mode 100644
index 0000000..7da278e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c
@@ -0,0 +1,53 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, dsp;
+    int ach = 5, acl = 5;
+    int resulth, resultl, resultdsp;
+
+    rs = 0xBC0123AD;
+    rt = 0x01643721;
+    resulth = 0x00;
+    resultl = 0x7FFFFFFF;
+    resultdsp = 0x01;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsqx_sa.w.ph $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    ach = 0x8c0b354A;
+    acl = 0xbbc02249;
+    rs = 0x800023AD;
+    rt = 0x01648000;
+    resulth = 0xffffffff;
+    resultl = 0x80000000;
+    resultdsp = 0x01;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsqx_sa.w.ph $ac1, %3, %4\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         "rddsp %2\n\t"
+         : "+r"(ach), "+r"(acl), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 17) & 0x01;
+    assert(dsp == resultdsp);
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c
new file mode 100644
index 0000000..bb49a40
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c
@@ -0,0 +1,27 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int ach = 5, acl = 5;
+    int resulth, resultl;
+
+    rs      = 0xBC0123AD;
+    rt      = 0x01643721;
+    resulth = 0x05;
+    resultl = 0xE72F050;
+    __asm
+        ("mthi  %0, $ac1\n\t"
+         "mtlo  %1, $ac1\n\t"
+         "dpsx.w.ph $ac1, %2, %3\n\t"
+         "mfhi  %0, $ac1\n\t"
+         "mflo  %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c
new file mode 100644
index 0000000..c7e9d60
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c
@@ -0,0 +1,47 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x03FB1234;
+    rt = 0x0BCC4321;
+    result = 0xF504F4B4;
+    resultdsp = 1;
+
+    __asm
+        ("mul.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    rs = 0x00210010;
+    rt = 0x00110005;
+    result = 0x2310050;
+    resultdsp = 0;
+
+    __asm
+        ("mul.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c
new file mode 100644
index 0000000..33da110
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c
@@ -0,0 +1,62 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x03FB1234;
+    rt = 0x0BCC4321;
+    result = 0x7fff7FFF;
+    resultdsp = 1;
+
+    __asm
+        ("mul_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    rs = 0x7fffff00;
+    rt = 0xff007fff;
+    result = 0x80008000;
+    resultdsp = 1;
+
+    __asm
+        ("mul_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    dsp = 0;
+    __asm
+        ("wrdsp %0\n\t"
+         :
+         : "r"(dsp)
+        );
+
+    rs = 0x00320001;
+    rt = 0x00210002;
+    result = 0x06720002;
+    resultdsp = 0;
+
+    __asm
+        ("mul_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c
new file mode 100644
index 0000000..7ba633b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c
@@ -0,0 +1,36 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x80001234;
+    rt = 0x80004321;
+    result = 0x7FFFAAAB;
+
+    __asm
+        ("mulq_rs.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd  == result);
+
+    rs = 0x80000000;
+    rt = 0x80000000;
+    result = 0x7FFFFFFF;
+    resultdsp = 1;
+
+    __asm
+        ("mulq_rs.w %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c
new file mode 100644
index 0000000..00e0155
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c
@@ -0,0 +1,40 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x80000000;
+    rt = 0x0ffc0000;
+    result = 0xF0040000;
+    resultdsp = 0;
+
+    __asm
+        ("mulq_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    rs = 0x80001234;
+    rt = 0x80004321;
+    result = 0x7FFF098B;
+    resultdsp = 1;
+
+    __asm
+        ("mulq_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c
new file mode 100644
index 0000000..9c2be06
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c
@@ -0,0 +1,36 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x80001234;
+    rt = 0x80004321;
+    result = 0x7FFFAAAB;
+
+    __asm
+        ("mulq_s.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd  == result);
+
+    rs = 0x80000000;
+    rt = 0x80000000;
+    result = 0x7FFFFFFF;
+    resultdsp = 1;
+
+    __asm
+        ("mulq_s.w %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 21) & 0x01;
+    assert(rd  == result);
+    assert(dsp == resultdsp);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c
new file mode 100644
index 0000000..a694093
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c
@@ -0,0 +1,29 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, ach, acl;
+    int resulth, resultl;
+
+    ach = 0x05;
+    acl = 0x00BBDDCC;
+    rs = 0x80001234;
+    rt = 0x80004321;
+    resulth = 0x05;
+    resultl = 0x3BF5E918;
+
+    __asm
+        ("mthi %0, $ac1\n\t"
+         "mtlo %1, $ac1\n\t"
+         "mulsa.w.ph $ac1, %2, %3\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c
new file mode 100644
index 0000000..06c91a4
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c
@@ -0,0 +1,29 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt, ach, acl;
+    int resulth, resultl;
+
+    ach = 0x05;
+    acl = 0x00BBDDCC;
+    rs = 0x80001234;
+    rt = 0x80004321;
+    resulth = 0x05;
+    resultl = 0x772ff463;
+
+    __asm
+        ("mthi %0, $ac1\n\t"
+         "mtlo %1, $ac1\n\t"
+         "mulsaq_s.w.ph $ac1, %2, %3\n\t"
+         "mfhi %0, $ac1\n\t"
+         "mflo %1, $ac1\n\t"
+         : "+r"(ach), "+r"(acl)
+         : "r"(rs), "r"(rt)
+        );
+    assert(ach == resulth);
+    assert(acl == resultl);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c
new file mode 100644
index 0000000..3a2b3fd
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x34786521;
+
+    __asm
+        ("precr.qb.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(result == rd);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c
new file mode 100644
index 0000000..5c9baab
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c
@@ -0,0 +1,32 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x43215678;
+
+    __asm
+        ("precr_sra.ph.w %0, %1, 0x00\n\t"
+         : "+r"(rt)
+         : "r"(rs)
+        );
+    assert(result == rt);
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0xFFFF0000;
+
+    __asm
+        ("precr_sra.ph.w %0, %1, 0x1F\n\t"
+         : "+r"(rt)
+         : "r"(rs)
+        );
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c
new file mode 100644
index 0000000..6474a10
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c
@@ -0,0 +1,32 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x43215678;
+
+    __asm
+        ("precr_sra_r.ph.w %0, %1, 0x00\n\t"
+         : "+r"(rt)
+         : "r"(rs)
+        );
+    assert(result == rt);
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0xFFFF0000;
+
+    __asm
+        ("precr_sra_r.ph.w %0, %1, 0x1F\n\t"
+         : "+r"(rt)
+         : "r"(rs)
+        );
+    assert(result == rt);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c
new file mode 100644
index 0000000..f6bcd47
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x87654321;
+    __asm
+        ("prepend %0, %1, 0x00\n\t"
+         : "+r"(rt)
+         : "r"(rs)
+        );
+    assert(rt == result);
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0xACF10ECA;
+    __asm
+        ("prepend %0, %1, 0x0F\n\t"
+         : "+r"(rt)
+         : "r"(rs)
+        );
+    assert(rt == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c
new file mode 100644
index 0000000..48193de
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x12345678;
+    result = 0x02060A0F;
+
+    __asm
+        ("shra.qb %0, %1, 0x03\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    rt = 0x87654321;
+    result = 0xF00C0804;
+
+    __asm
+        ("shra.qb %0, %1, 0x03\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c
new file mode 100644
index 0000000..29afa0e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c
@@ -0,0 +1,30 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt = 0x12345678;
+    result = 0x02070B0F;
+
+    __asm
+        ("shra_r.qb %0, %1, 0x03\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    rt = 0x87654321;
+    result = 0xF10D0804;
+
+    __asm
+        ("shra_r.qb %0, %1, 0x03\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c
new file mode 100644
index 0000000..b21e1b7
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c
@@ -0,0 +1,32 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x03;
+    rt = 0x12345678;
+    result = 0x02060A0F;
+
+    __asm
+        ("shrav.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    rs = 0x03;
+    rt = 0x87654321;
+    result = 0xF00C0804;
+
+    __asm
+        ("shrav.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c
new file mode 100644
index 0000000..9ea8aa0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c
@@ -0,0 +1,32 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x03;
+    rt = 0x12345678;
+    result = 0x02070B0F;
+
+    __asm
+        ("shrav_r.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    rs = 0x03;
+    rt = 0x87654321;
+    result = 0xF10D0804;
+
+    __asm
+        ("shrav_r.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c
new file mode 100644
index 0000000..724b9a7
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c
@@ -0,0 +1,20 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rt;
+    int result;
+
+    rt     = 0x12345678;
+    result = 0x009102B3;
+
+    __asm
+        ("shrl.ph %0, %1, 0x05\n\t"
+         : "=r"(rd)
+         : "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c
new file mode 100644
index 0000000..ac79aa6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs     = 0x05;
+    rt     = 0x12345678;
+    result = 0x009102B3;
+
+    __asm
+        ("shrlv.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rt), "r"(rs)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c
new file mode 100644
index 0000000..dbc0967
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x456709AB;
+
+    __asm
+        ("subqh.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c
new file mode 100644
index 0000000..24ef0f1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x456809AC;
+
+    __asm
+        ("subqh_r.ph %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c
new file mode 100644
index 0000000..d460f86
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x456789AC;
+
+    __asm
+        ("subqh_r.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c
new file mode 100644
index 0000000..42be3de
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0x456789AB;
+
+    __asm
+        ("subqh.w %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c
new file mode 100644
index 0000000..0d39a01
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c
@@ -0,0 +1,40 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x87654321;
+    rt = 0x11111111;
+    result    = 0x76543210;
+    resultdsp = 0x00;
+
+    __asm
+        ("subu.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    rs = 0x87654321;
+    rt = 0x12345678;
+    result    = 0x7531ECA9;
+    resultdsp = 0x01;
+
+    __asm
+        ("subu.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c
new file mode 100644
index 0000000..8e4da4f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c
@@ -0,0 +1,25 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt, dsp;
+    int result, resultdsp;
+
+    rs = 0x87654321;
+    rt = 0x12345678;
+    result    = 0x75310000;
+    resultdsp = 0x01;
+
+    __asm
+        ("subu_s.ph %0, %2, %3\n\t"
+         "rddsp %1\n\t"
+         : "=r"(rd), "=r"(dsp)
+         : "r"(rs), "r"(rt)
+        );
+    dsp = (dsp >> 20) & 0x01;
+    assert(dsp == resultdsp);
+    assert(rd  == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c
new file mode 100644
index 0000000..92cfc76
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c
@@ -0,0 +1,21 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0xC5E7092B;
+
+    __asm
+        ("subuh.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c
new file mode 100644
index 0000000..dac81d4
--- /dev/null
+++ b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c
@@ -0,0 +1,32 @@
+#include<stdio.h>
+#include<assert.h>
+
+int main()
+{
+    int rd, rs, rt;
+    int result;
+
+    rs = 0x12345678;
+    rt = 0x87654321;
+    result = 0xC6E80A2C;
+
+    __asm
+        ("subuh_r.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    rs = 0xBEFC292A;
+    rt = 0x9205C1B4;
+    result = 0x167cb4bb;
+
+    __asm
+        ("subuh_r.qb %0, %1, %2\n\t"
+         : "=r"(rd)
+         : "r"(rs), "r"(rt)
+        );
+    assert(rd == result);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_div1.c b/tests/tcg/mips/user/isa/r5900/test_r5900_div1.c
new file mode 100644
index 0000000..83dafa0
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/test_r5900_div1.c
@@ -0,0 +1,73 @@
+/*
+ * Test R5900-specific DIV1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+struct quotient_remainder { int32_t quotient, remainder; };
+
+static struct quotient_remainder div1(int32_t rs, int32_t rt)
+{
+    int32_t lo, hi;
+
+    __asm__ __volatile__ (
+            "    div1 $0, %2, %3\n"
+            "    mflo1 %0\n"
+            "    mfhi1 %1\n"
+            : "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt));
+
+    assert(rs / rt == lo);
+    assert(rs % rt == hi);
+
+    return (struct quotient_remainder) { .quotient = lo, .remainder = hi };
+}
+
+static void verify_div1(int32_t rs, int32_t rt,
+                        int32_t expected_quotient,
+                        int32_t expected_remainder)
+{
+    struct quotient_remainder qr = div1(rs, rt);
+
+    assert(qr.quotient == expected_quotient);
+    assert(qr.remainder == expected_remainder);
+}
+
+static void verify_div1_negations(int32_t rs, int32_t rt,
+                                  int32_t expected_quotient,
+                                  int32_t expected_remainder)
+{
+    verify_div1(rs, rt, expected_quotient, expected_remainder);
+    verify_div1(rs, -rt, -expected_quotient, expected_remainder);
+    verify_div1(-rs, rt, -expected_quotient, -expected_remainder);
+    verify_div1(-rs, -rt, expected_quotient, -expected_remainder);
+}
+
+int main()
+{
+    verify_div1_negations(0, 1, 0, 0);
+    verify_div1_negations(1, 1, 1, 0);
+    verify_div1_negations(1, 2, 0, 1);
+    verify_div1_negations(17, 19, 0, 17);
+    verify_div1_negations(19, 17, 1, 2);
+    verify_div1_negations(77773, 101, 770, 3);
+
+    verify_div1(-0x80000000,  1, -0x80000000, 0);
+
+    /*
+     * Supplementary explanation from the Toshiba TX System RISC TX79 Core
+     * Architecture manual, A-38 and B-7, https://wiki.qemu.org/File:C790.pdf
+     *
+     * Normally, when 0x80000000 (-2147483648) the signed minimum value is
+     * divided by 0xFFFFFFFF (-1), the operation will result in an overflow.
+     * However, in this instruction an overflow exception doesn't occur and
+     * the result will be as follows:
+     *
+     * Quotient is 0x80000000 (-2147483648), and remainder is 0x00000000 (0).
+     */
+    verify_div1(-0x80000000, -1, -0x80000000, 0);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c b/tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c
new file mode 100644
index 0000000..72aeed3
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c
@@ -0,0 +1,48 @@
+/*
+ * Test R5900-specific DIVU1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+struct quotient_remainder { uint32_t quotient, remainder; };
+
+static struct quotient_remainder divu1(uint32_t rs, uint32_t rt)
+{
+    uint32_t lo, hi;
+
+    __asm__ __volatile__ (
+            "    divu1 $0, %2, %3\n"
+            "    mflo1 %0\n"
+            "    mfhi1 %1\n"
+            : "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt));
+
+    assert(rs / rt == lo);
+    assert(rs % rt == hi);
+
+    return (struct quotient_remainder) { .quotient = lo, .remainder = hi };
+}
+
+static void verify_divu1(uint32_t rs, uint32_t rt,
+                         uint32_t expected_quotient,
+                         uint32_t expected_remainder)
+{
+    struct quotient_remainder qr = divu1(rs, rt);
+
+    assert(qr.quotient == expected_quotient);
+    assert(qr.remainder == expected_remainder);
+}
+
+int main()
+{
+    verify_divu1(0, 1, 0, 0);
+    verify_divu1(1, 1, 1, 0);
+    verify_divu1(1, 2, 0, 1);
+    verify_divu1(17, 19, 0, 17);
+    verify_divu1(19, 17, 1, 2);
+    verify_divu1(77773, 101, 770, 3);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_madd.c b/tests/tcg/mips/user/isa/r5900/test_r5900_madd.c
new file mode 100644
index 0000000..f6f215e
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/test_r5900_madd.c
@@ -0,0 +1,78 @@
+/*
+ * Test R5900-specific three-operand MADD and MADD1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+int64_t madd(int64_t a, int32_t rs, int32_t rt)
+{
+    int32_t lo = a;
+    int32_t hi = a >> 32;
+    int32_t rd;
+    int64_t r;
+
+    __asm__ __volatile__ (
+            "    mtlo %5\n"
+            "    mthi %6\n"
+            "    madd %0, %3, %4\n"
+            "    mflo %1\n"
+            "    mfhi %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt), "r" (lo), "r" (hi));
+    r = ((int64_t)hi << 32) | (uint32_t)lo;
+
+    assert(a + (int64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+int64_t madd1(int64_t a, int32_t rs, int32_t rt)
+{
+    int32_t lo = a;
+    int32_t hi = a >> 32;
+    int32_t rd;
+    int64_t r;
+
+    __asm__ __volatile__ (
+            "    mtlo1 %5\n"
+            "    mthi1 %6\n"
+            "    madd1 %0, %3, %4\n"
+            "    mflo1 %1\n"
+            "    mfhi1 %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt), "r" (lo), "r" (hi));
+    r = ((int64_t)hi << 32) | (uint32_t)lo;
+
+    assert(a + (int64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+static int64_t madd_variants(int64_t a, int32_t rs, int32_t rt)
+{
+    int64_t rd  = madd(a, rs, rt);
+    int64_t rd1 = madd1(a, rs, rt);
+
+    assert(rd == rd1);
+
+    return rd;
+}
+
+static void verify_madd(int64_t a, int32_t rs, int32_t rt, int64_t expected)
+{
+    assert(madd_variants(a, rs, rt) == expected);
+    assert(madd_variants(a, -rs, rt) == a + a - expected);
+    assert(madd_variants(a, rs, -rt) == a + a - expected);
+    assert(madd_variants(a, -rs, -rt) == expected);
+}
+
+int main()
+{
+    verify_madd(13, 17, 19, 336);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c b/tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c
new file mode 100644
index 0000000..30936fb
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c
@@ -0,0 +1,70 @@
+/*
+ * Test R5900-specific three-operand MADDU and MADDU1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+uint64_t maddu(uint64_t a, uint32_t rs, uint32_t rt)
+{
+    uint32_t lo = a;
+    uint32_t hi = a >> 32;
+    uint32_t rd;
+    uint64_t r;
+
+    __asm__ __volatile__ (
+            "    mtlo  %5\n"
+            "    mthi  %6\n"
+            "    maddu %0, %3, %4\n"
+            "    mflo  %1\n"
+            "    mfhi  %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt), "r" (lo), "r" (hi));
+    r = ((uint64_t)hi << 32) | (uint32_t)lo;
+
+    assert(a + (uint64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+uint64_t maddu1(uint64_t a, uint32_t rs, uint32_t rt)
+{
+    uint32_t lo = a;
+    uint32_t hi = a >> 32;
+    uint32_t rd;
+    uint64_t r;
+
+    __asm__ __volatile__ (
+            "    mtlo1  %5\n"
+            "    mthi1  %6\n"
+            "    maddu1 %0, %3, %4\n"
+            "    mflo1  %1\n"
+            "    mfhi1  %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt), "r" (lo), "r" (hi));
+    r = ((uint64_t)hi << 32) | (uint32_t)lo;
+
+    assert(a + (uint64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+static int64_t maddu_variants(int64_t a, int32_t rs, int32_t rt)
+{
+    int64_t rd  = maddu(a, rs, rt);
+    int64_t rd1 = maddu1(a, rs, rt);
+
+    assert(rd == rd1);
+
+    return rd;
+}
+
+int main()
+{
+    assert(maddu_variants(13, 17, 19) == 336);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c b/tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c
new file mode 100644
index 0000000..eed3683
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c
@@ -0,0 +1,35 @@
+/*
+ * Test R5900-specific MFLO1 and MFHI1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+int main()
+{
+    int32_t rs  = 12207031, rt  = 305175781;
+    int32_t rs1 = 32452867, rt1 = 49979687;
+    int64_t lo, hi, lo1, hi1;
+    int64_t r, r1;
+
+    /* Test both LO/HI and LO1/HI1 to verify separation. */
+    __asm__ __volatile__ (
+            "    mult $0, %4, %5\n"
+            "    mult1 $0, %6, %7\n"
+            "    mflo %0\n"
+            "    mfhi %1\n"
+            "    mflo1 %2\n"
+            "    mfhi1 %3\n"
+            : "=r" (lo),  "=r" (hi),
+              "=r" (lo1), "=r" (hi1)
+            : "r" (rs),  "r" (rt),
+              "r" (rs1), "r" (rt1));
+    r  = ((int64_t)hi  << 32) | (uint32_t)lo;
+    r1 = ((int64_t)hi1 << 32) | (uint32_t)lo1;
+
+    assert(r  == 3725290219116211);
+    assert(r1 == 1621984134912629);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c b/tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c
new file mode 100644
index 0000000..7f3e728
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c
@@ -0,0 +1,40 @@
+/*
+ * Test R5900-specific MTLO1 and MTHI1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+int main()
+{
+    int32_t tlo  = 12207031, thi  = 305175781;
+    int32_t tlo1 = 32452867, thi1 = 49979687;
+    int32_t flo, fhi, flo1, fhi1;
+
+    /* Test both LO/HI and LO1/HI1 to verify separation. */
+    __asm__ __volatile__ (
+            "    mtlo  %4\n"
+            "    mthi  %5\n"
+            "    mtlo1 %6\n"
+            "    mthi1 %7\n"
+            "    move  %0, $0\n"
+            "    move  %1, $0\n"
+            "    move  %2, $0\n"
+            "    move  %3, $0\n"
+            "    mflo  %0\n"
+            "    mfhi  %1\n"
+            "    mflo1 %2\n"
+            "    mfhi1 %3\n"
+            : "=r" (flo),  "=r" (fhi),
+              "=r" (flo1), "=r" (fhi1)
+            : "r" (tlo),  "r" (thi),
+              "r" (tlo1), "r" (thi1));
+
+    assert(flo  == 12207031);
+    assert(fhi  == 305175781);
+    assert(flo1 == 32452867);
+    assert(fhi1 == 49979687);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mult.c b/tests/tcg/mips/user/isa/r5900/test_r5900_mult.c
new file mode 100644
index 0000000..5710b39
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/test_r5900_mult.c
@@ -0,0 +1,76 @@
+/*
+ * Test R5900-specific three-operand MULT and MULT1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+static int64_t mult(int32_t rs, int32_t rt)
+{
+    int32_t rd, lo, hi;
+    int64_t r;
+
+    __asm__ __volatile__ (
+            "    mult %0, %3, %4\n"
+            "    mflo %1\n"
+            "    mfhi %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt));
+    r = ((int64_t)hi << 32) | (uint32_t)lo;
+
+    assert((int64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+static int64_t mult1(int32_t rs, int32_t rt)
+{
+    int32_t rd, lo, hi;
+    int64_t r;
+
+    __asm__ __volatile__ (
+            "    mult1 %0, %3, %4\n"
+            "    mflo1 %1\n"
+            "    mfhi1 %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt));
+    r = ((int64_t)hi << 32) | (uint32_t)lo;
+
+    assert((int64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+static int64_t mult_variants(int32_t rs, int32_t rt)
+{
+    int64_t rd  = mult(rs, rt);
+    int64_t rd1 = mult1(rs, rt);
+
+    assert(rd == rd1);
+
+    return rd;
+}
+
+static void verify_mult_negations(int32_t rs, int32_t rt, int64_t expected)
+{
+    assert(mult_variants(rs, rt) == expected);
+    assert(mult_variants(-rs, rt) == -expected);
+    assert(mult_variants(rs, -rt) == -expected);
+    assert(mult_variants(-rs, -rt) == expected);
+}
+
+int main()
+{
+    verify_mult_negations(17, 19, 323);
+    verify_mult_negations(77773, 99991, 7776600043);
+    verify_mult_negations(12207031, 305175781, 3725290219116211);
+
+    assert(mult_variants(-0x80000000,  0x7FFFFFFF) == -0x3FFFFFFF80000000);
+    assert(mult_variants(-0x80000000, -0x7FFFFFFF) ==  0x3FFFFFFF80000000);
+    assert(mult_variants(-0x80000000, -0x80000000) ==  0x4000000000000000);
+
+    return 0;
+}
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_multu.c b/tests/tcg/mips/user/isa/r5900/test_r5900_multu.c
new file mode 100644
index 0000000..f043904
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/test_r5900_multu.c
@@ -0,0 +1,68 @@
+/*
+ * Test R5900-specific three-operand MULTU and MULTU1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+static uint64_t multu(uint32_t rs, uint32_t rt)
+{
+    uint32_t rd, lo, hi;
+    uint64_t r;
+
+    __asm__ __volatile__ (
+            "    multu %0, %3, %4\n"
+            "    mflo %1\n"
+            "    mfhi %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt));
+    r = ((uint64_t)hi << 32) | (uint32_t)lo;
+
+    assert((uint64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+static uint64_t multu1(uint32_t rs, uint32_t rt)
+{
+    uint32_t rd, lo, hi;
+    uint64_t r;
+
+    __asm__ __volatile__ (
+            "    multu1 %0, %3, %4\n"
+            "    mflo1 %1\n"
+            "    mfhi1 %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt));
+    r = ((uint64_t)hi << 32) | (uint32_t)lo;
+
+    assert((uint64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+static uint64_t multu_variants(uint32_t rs, uint32_t rt)
+{
+    uint64_t rd  = multu(rs, rt);
+    uint64_t rd1 = multu1(rs, rt);
+
+    assert(rd == rd1);
+
+    return rd;
+}
+
+int main()
+{
+    assert(multu_variants(17, 19) == 323);
+    assert(multu_variants(77773, 99991) == 7776600043);
+    assert(multu_variants(12207031, 305175781) == 3725290219116211);
+
+    assert(multu_variants(0x80000000U, 0x7FFFFFFF) == 0x3FFFFFFF80000000);
+    assert(multu_variants(0x80000000U, 0x80000000U) ==  0x4000000000000000);
+    assert(multu_variants(0xFFFFFFFFU, 0xFFFFFFFFU) ==  0xFFFFFFFE00000001U);
+
+    return 0;
+}
-- 
2.7.4
