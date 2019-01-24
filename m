Received: from eggs.gnu.org ([209.51.188.92]:58561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmgoE-0002o5-OB
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmgo7-0007RT-Rq
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:20:50 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37340 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gmgnz-0006ZN-Ue
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:20:39 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 24 Jan 2019 16:19:12 +0100
Message-Id: <1548343154-8774-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548343154-8774-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548343154-8774-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 1/3] tests: tcg: mips: Move source files to
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
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

MIPS TCG test will be organized by ISAs and ASEs in future.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../mips/{mips32-dsp/absq_s_ph.c => user/ase/dsp/test_dsp_r1_absq_s_ph.c} | 0
 .../mips/{mips32-dsp/absq_s_w.c => user/ase/dsp/test_dsp_r1_absq_s_w.c}   | 0
 .../tcg/mips/{mips32-dsp/addq_ph.c => user/ase/dsp/test_dsp_r1_addq_ph.c} | 0
 .../mips/{mips32-dsp/addq_s_ph.c => user/ase/dsp/test_dsp_r1_addq_s_ph.c} | 0
 .../mips/{mips32-dsp/addq_s_w.c => user/ase/dsp/test_dsp_r1_addq_s_w.c}   | 0
 tests/tcg/mips/{mips32-dsp/addsc.c => user/ase/dsp/test_dsp_r1_addsc.c}   | 0
 .../tcg/mips/{mips32-dsp/addu_qb.c => user/ase/dsp/test_dsp_r1_addu_qb.c} | 0
 .../mips/{mips32-dsp/addu_s_qb.c => user/ase/dsp/test_dsp_r1_addu_s_qb.c} | 0
 tests/tcg/mips/{mips32-dsp/addwc.c => user/ase/dsp/test_dsp_r1_addwc.c}   | 0
 tests/tcg/mips/{mips32-dsp/bitrev.c => user/ase/dsp/test_dsp_r1_bitrev.c} | 0
 .../mips/{mips32-dsp/bposge32.c => user/ase/dsp/test_dsp_r1_bposge32.c}   | 0
 .../mips/{mips32-dsp/cmp_eq_ph.c => user/ase/dsp/test_dsp_r1_cmp_eq_ph.c} | 0
 .../mips/{mips32-dsp/cmp_le_ph.c => user/ase/dsp/test_dsp_r1_cmp_le_ph.c} | 0
 .../mips/{mips32-dsp/cmp_lt_ph.c => user/ase/dsp/test_dsp_r1_cmp_lt_ph.c} | 0
 .../{mips32-dsp/cmpgu_eq_qb.c => user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c}  | 0
 .../{mips32-dsp/cmpgu_le_qb.c => user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c}  | 0
 .../{mips32-dsp/cmpgu_lt_qb.c => user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c}  | 0
 .../{mips32-dsp/cmpu_eq_qb.c => user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c}    | 0
 .../{mips32-dsp/cmpu_le_qb.c => user/ase/dsp/test_dsp_r1_cmpu_le_qb.c}    | 0
 .../{mips32-dsp/cmpu_lt_qb.c => user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c}    | 0
 .../{mips32-dsp/dpaq_s_w_ph.c => user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c}  | 0
 .../{mips32-dsp/dpaq_sa_l_w.c => user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c}  | 0
 .../{mips32-dsp/dpau_h_qbl.c => user/ase/dsp/test_dsp_r1_dpau_h_qbl.c}    | 0
 .../{mips32-dsp/dpau_h_qbr.c => user/ase/dsp/test_dsp_r1_dpau_h_qbr.c}    | 0
 .../{mips32-dsp/dpsq_s_w_ph.c => user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c}  | 0
 .../{mips32-dsp/dpsq_sa_l_w.c => user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c}  | 0
 .../{mips32-dsp/dpsu_h_qbl.c => user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c}    | 0
 .../{mips32-dsp/dpsu_h_qbr.c => user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c}    | 0
 tests/tcg/mips/{mips32-dsp/extp.c => user/ase/dsp/test_dsp_r1_extp.c}     | 0
 tests/tcg/mips/{mips32-dsp/extpdp.c => user/ase/dsp/test_dsp_r1_extpdp.c} | 0
 .../tcg/mips/{mips32-dsp/extpdpv.c => user/ase/dsp/test_dsp_r1_extpdpv.c} | 0
 tests/tcg/mips/{mips32-dsp/extpv.c => user/ase/dsp/test_dsp_r1_extpv.c}   | 0
 .../mips/{mips32-dsp/extr_r_w.c => user/ase/dsp/test_dsp_r1_extr_r_w.c}   | 0
 .../mips/{mips32-dsp/extr_rs_w.c => user/ase/dsp/test_dsp_r1_extr_rs_w.c} | 0
 .../mips/{mips32-dsp/extr_s_h.c => user/ase/dsp/test_dsp_r1_extr_s_h.c}   | 0
 tests/tcg/mips/{mips32-dsp/extr_w.c => user/ase/dsp/test_dsp_r1_extr_w.c} | 0
 .../mips/{mips32-dsp/extrv_r_w.c => user/ase/dsp/test_dsp_r1_extrv_r_w.c} | 0
 .../{mips32-dsp/extrv_rs_w.c => user/ase/dsp/test_dsp_r1_extrv_rs_w.c}    | 0
 .../mips/{mips32-dsp/extrv_s_h.c => user/ase/dsp/test_dsp_r1_extrv_s_h.c} | 0
 .../tcg/mips/{mips32-dsp/extrv_w.c => user/ase/dsp/test_dsp_r1_extrv_w.c} | 0
 tests/tcg/mips/{mips32-dsp/insv.c => user/ase/dsp/test_dsp_r1_insv.c}     | 0
 tests/tcg/mips/{mips32-dsp/lbux.c => user/ase/dsp/test_dsp_r1_lbux.c}     | 0
 tests/tcg/mips/{mips32-dsp/lhx.c => user/ase/dsp/test_dsp_r1_lhx.c}       | 0
 tests/tcg/mips/{mips32-dsp/lwx.c => user/ase/dsp/test_dsp_r1_lwx.c}       | 0
 tests/tcg/mips/{mips32-dsp/maddu.c => user/ase/dsp/test_dsp_r1_madd.c}    | 0
 tests/tcg/mips/{mips32-dsp/madd.c => user/ase/dsp/test_dsp_r1_maddu.c}    | 0
 tests/tcg/mips/{mips32-dsp/main.c => user/ase/dsp/test_dsp_r1_main.c}     | 0
 .../{mips32-dsp/maq_s_w_phl.c => user/ase/dsp/test_dsp_r1_maq_s_w_phl.c}  | 0
 .../{mips32-dsp/maq_s_w_phr.c => user/ase/dsp/test_dsp_r1_maq_s_w_phr.c}  | 0
 .../maq_sa_w_phl.c => user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c}            | 0
 .../maq_sa_w_phr.c => user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c}            | 0
 tests/tcg/mips/{mips32-dsp/mthi.c => user/ase/dsp/test_dsp_r1_mfhi.c}     | 0
 tests/tcg/mips/{mips32-dsp/mtlo.c => user/ase/dsp/test_dsp_r1_mflo.c}     | 0
 tests/tcg/mips/{mips32-dsp/modsub.c => user/ase/dsp/test_dsp_r1_modsub.c} | 0
 tests/tcg/mips/{mips32-dsp/msub.c => user/ase/dsp/test_dsp_r1_msub.c}     | 0
 tests/tcg/mips/{mips32-dsp/msubu.c => user/ase/dsp/test_dsp_r1_msubu.c}   | 0
 tests/tcg/mips/{mips32-dsp/mfhi.c => user/ase/dsp/test_dsp_r1_mthi.c}     | 0
 tests/tcg/mips/{mips32-dsp/mthlip.c => user/ase/dsp/test_dsp_r1_mthlip.c} | 0
 tests/tcg/mips/{mips32-dsp/mflo.c => user/ase/dsp/test_dsp_r1_mtlo.c}     | 0
 .../muleq_s_w_phl.c => user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c}          | 0
 .../muleq_s_w_phr.c => user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c}          | 0
 .../muleu_s_ph_qbl.c => user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c}        | 0
 .../muleu_s_ph_qbr.c => user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c}        | 0
 .../{mips32-dsp/mulq_rs_ph.c => user/ase/dsp/test_dsp_r1_mulq_rs_ph.c}    | 0
 tests/tcg/mips/{mips32-dsp/mult.c => user/ase/dsp/test_dsp_r1_mult.c}     | 0
 tests/tcg/mips/{mips32-dsp/multu.c => user/ase/dsp/test_dsp_r1_multu.c}   | 0
 .../mips/{mips32-dsp/packrl_ph.c => user/ase/dsp/test_dsp_r1_packrl_ph.c} | 0
 .../tcg/mips/{mips32-dsp/pick_ph.c => user/ase/dsp/test_dsp_r1_pick_ph.c} | 0
 .../tcg/mips/{mips32-dsp/pick_qb.c => user/ase/dsp/test_dsp_r1_pick_qb.c} | 0
 .../preceq_w_phl.c => user/ase/dsp/test_dsp_r1_preceq_w_phl.c}            | 0
 .../preceq_w_phr.c => user/ase/dsp/test_dsp_r1_preceq_w_phr.c}            | 0
 .../precequ_ph_qbl.c => user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c}        | 0
 .../precequ_ph_qbla.c => user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c}      | 0
 .../precequ_ph_qbr.c => user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c}        | 0
 .../precequ_ph_qbra.c => user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c}      | 0
 .../preceu_ph_qbl.c => user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c}          | 0
 .../preceu_ph_qbla.c => user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c}        | 0
 .../preceu_ph_qbr.c => user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c}          | 0
 .../preceu_ph_qbra.c => user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c}        | 0
 .../{mips32-dsp/precrq_ph_w.c => user/ase/dsp/test_dsp_r1_precrq_ph_w.c}  | 0
 .../precrq_qb_ph.c => user/ase/dsp/test_dsp_r1_precrq_qb_ph.c}            | 0
 .../precrq_rs_ph_w.c => user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c}        | 0
 .../precrqu_s_qb_ph.c => user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c}      | 0
 .../{mips32-dsp/raddu_w_qb.c => user/ase/dsp/test_dsp_r1_raddu_w_qb.c}    | 0
 tests/tcg/mips/{mips32-dsp/rddsp.c => user/ase/dsp/test_dsp_r1_rddsp.c}   | 0
 .../tcg/mips/{mips32-dsp/repl_ph.c => user/ase/dsp/test_dsp_r1_repl_ph.c} | 0
 .../tcg/mips/{mips32-dsp/repl_qb.c => user/ase/dsp/test_dsp_r1_repl_qb.c} | 0
 .../mips/{mips32-dsp/replv_ph.c => user/ase/dsp/test_dsp_r1_replv_ph.c}   | 0
 .../mips/{mips32-dsp/replv_qb.c => user/ase/dsp/test_dsp_r1_replv_qb.c}   | 0
 tests/tcg/mips/{mips32-dsp/shilo.c => user/ase/dsp/test_dsp_r1_shilo.c}   | 0
 tests/tcg/mips/{mips32-dsp/shilov.c => user/ase/dsp/test_dsp_r1_shilov.c} | 0
 .../tcg/mips/{mips32-dsp/shll_ph.c => user/ase/dsp/test_dsp_r1_shll_ph.c} | 0
 .../tcg/mips/{mips32-dsp/shll_qb.c => user/ase/dsp/test_dsp_r1_shll_qb.c} | 0
 .../mips/{mips32-dsp/shll_s_ph.c => user/ase/dsp/test_dsp_r1_shll_s_ph.c} | 0
 .../mips/{mips32-dsp/shll_s_w.c => user/ase/dsp/test_dsp_r1_shll_s_w.c}   | 0
 .../mips/{mips32-dsp/shllv_ph.c => user/ase/dsp/test_dsp_r1_shllv_ph.c}   | 0
 .../mips/{mips32-dsp/shllv_qb.c => user/ase/dsp/test_dsp_r1_shllv_qb.c}   | 0
 .../{mips32-dsp/shllv_s_ph.c => user/ase/dsp/test_dsp_r1_shllv_s_ph.c}    | 0
 .../mips/{mips32-dsp/shllv_s_w.c => user/ase/dsp/test_dsp_r1_shllv_s_w.c} | 0
 .../tcg/mips/{mips32-dsp/shra_ph.c => user/ase/dsp/test_dsp_r1_shra_ph.c} | 0
 .../mips/{mips32-dsp/shra_r_ph.c => user/ase/dsp/test_dsp_r1_shra_r_ph.c} | 0
 .../mips/{mips32-dsp/shra_r_w.c => user/ase/dsp/test_dsp_r1_shra_r_w.c}   | 0
 .../mips/{mips32-dsp/shrav_ph.c => user/ase/dsp/test_dsp_r1_shrav_ph.c}   | 0
 .../{mips32-dsp/shrav_r_ph.c => user/ase/dsp/test_dsp_r1_shrav_r_ph.c}    | 0
 .../mips/{mips32-dsp/shrav_r_w.c => user/ase/dsp/test_dsp_r1_shrav_r_w.c} | 0
 .../tcg/mips/{mips32-dsp/shrl_qb.c => user/ase/dsp/test_dsp_r1_shrl_qb.c} | 0
 .../mips/{mips32-dsp/shrlv_qb.c => user/ase/dsp/test_dsp_r1_shrlv_qb.c}   | 0
 .../tcg/mips/{mips32-dsp/subq_ph.c => user/ase/dsp/test_dsp_r1_subq_ph.c} | 0
 .../mips/{mips32-dsp/subq_s_ph.c => user/ase/dsp/test_dsp_r1_subq_s_ph.c} | 0
 .../mips/{mips32-dsp/subq_s_w.c => user/ase/dsp/test_dsp_r1_subq_s_w.c}   | 0
 .../tcg/mips/{mips32-dsp/subu_qb.c => user/ase/dsp/test_dsp_r1_subu_qb.c} | 0
 .../mips/{mips32-dsp/subu_s_qb.c => user/ase/dsp/test_dsp_r1_subu_s_qb.c} | 0
 tests/tcg/mips/{mips32-dsp/wrdsp.c => user/ase/dsp/test_dsp_r1_wrdsp.c}   | 0
 .../{mips32-dspr2/absq_s_qb.c => user/ase/dsp/test_dsp_r2_absq_s_qb.c}    | 0
 .../mips/{mips32-dspr2/addqh_ph.c => user/ase/dsp/test_dsp_r2_addqh_ph.c} | 0
 .../{mips32-dspr2/addqh_r_ph.c => user/ase/dsp/test_dsp_r2_addqh_r_ph.c}  | 0
 .../{mips32-dspr2/addqh_r_w.c => user/ase/dsp/test_dsp_r2_addqh_r_w.c}    | 0
 .../mips/{mips32-dspr2/addqh_w.c => user/ase/dsp/test_dsp_r2_addqh_w.c}   | 0
 .../mips/{mips32-dspr2/addu_ph.c => user/ase/dsp/test_dsp_r2_addu_ph.c}   | 0
 .../{mips32-dspr2/addu_s_ph.c => user/ase/dsp/test_dsp_r2_addu_s_ph.c}    | 0
 .../mips/{mips32-dspr2/adduh_qb.c => user/ase/dsp/test_dsp_r2_adduh_qb.c} | 0
 .../{mips32-dspr2/adduh_r_qb.c => user/ase/dsp/test_dsp_r2_adduh_r_qb.c}  | 0
 .../tcg/mips/{mips32-dspr2/append.c => user/ase/dsp/test_dsp_r2_append.c} | 0
 .../tcg/mips/{mips32-dspr2/balign.c => user/ase/dsp/test_dsp_r2_balign.c} | 0
 .../cmpgdu_eq_qb.c => user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c}            | 0
 .../cmpgdu_le_qb.c => user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c}            | 0
 .../cmpgdu_lt_qb.c => user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c}            | 0
 .../mips/{mips32-dspr2/dpa_w_ph.c => user/ase/dsp/test_dsp_r2_dpa_w_ph.c} | 0
 .../dpaqx_s_w_ph.c => user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c}            | 0
 .../dpaqx_sa_w_ph.c => user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c}          | 0
 .../{mips32-dspr2/dpax_w_ph.c => user/ase/dsp/test_dsp_r2_dpax_w_ph.c}    | 0
 .../mips/{mips32-dspr2/dps_w_ph.c => user/ase/dsp/test_dsp_r2_dps_w_ph.c} | 0
 .../dpsqx_s_w_ph.c => user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c}            | 0
 .../dpsqx_sa_w_ph.c => user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c}          | 0
 .../{mips32-dspr2/dpsx_w_ph.c => user/ase/dsp/test_dsp_r2_dpsx_w_ph.c}    | 0
 .../tcg/mips/{mips32-dspr2/mul_ph.c => user/ase/dsp/test_dsp_r2_mul_ph.c} | 0
 .../mips/{mips32-dspr2/mul_s_ph.c => user/ase/dsp/test_dsp_r2_mul_s_ph.c} | 0
 .../{mips32-dspr2/mulq_rs_w.c => user/ase/dsp/test_dsp_r2_mulq_rs_w.c}    | 0
 .../{mips32-dspr2/mulq_s_ph.c => user/ase/dsp/test_dsp_r2_mulq_s_ph.c}    | 0
 .../mips/{mips32-dspr2/mulq_s_w.c => user/ase/dsp/test_dsp_r2_mulq_s_w.c} | 0
 .../{mips32-dspr2/mulsa_w_ph.c => user/ase/dsp/test_dsp_r2_mulsa_w_ph.c}  | 0
 .../mulsaq_s_w_ph.c => user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c}          | 0
 .../precr_qb_ph.c => user/ase/dsp/test_dsp_r2_precr_qb_ph.c}              | 0
 .../precr_sra_ph_w.c => user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c}        | 0
 .../precr_sra_r_ph_w.c => user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c}    | 0
 .../mips/{mips32-dspr2/prepend.c => user/ase/dsp/test_dsp_r2_prepend.c}   | 0
 .../mips/{mips32-dspr2/shra_qb.c => user/ase/dsp/test_dsp_r2_shra_qb.c}   | 0
 .../{mips32-dspr2/shra_r_qb.c => user/ase/dsp/test_dsp_r2_shra_r_qb.c}    | 0
 .../mips/{mips32-dspr2/shrav_qb.c => user/ase/dsp/test_dsp_r2_shrav_qb.c} | 0
 .../{mips32-dspr2/shrav_r_qb.c => user/ase/dsp/test_dsp_r2_shrav_r_qb.c}  | 0
 .../mips/{mips32-dspr2/shrl_ph.c => user/ase/dsp/test_dsp_r2_shrl_ph.c}   | 0
 .../mips/{mips32-dspr2/shrlv_ph.c => user/ase/dsp/test_dsp_r2_shrlv_ph.c} | 0
 .../mips/{mips32-dspr2/subqh_ph.c => user/ase/dsp/test_dsp_r2_subqh_ph.c} | 0
 .../{mips32-dspr2/subqh_r_ph.c => user/ase/dsp/test_dsp_r2_subqh_r_ph.c}  | 0
 .../{mips32-dspr2/subqh_r_w.c => user/ase/dsp/test_dsp_r2_subqh_r_w.c}    | 0
 .../mips/{mips32-dspr2/subqh_w.c => user/ase/dsp/test_dsp_r2_subqh_w.c}   | 0
 .../mips/{mips32-dspr2/subu_ph.c => user/ase/dsp/test_dsp_r2_subu_ph.c}   | 0
 .../{mips32-dspr2/subu_s_ph.c => user/ase/dsp/test_dsp_r2_subu_s_ph.c}    | 0
 .../mips/{mips32-dspr2/subuh_qb.c => user/ase/dsp/test_dsp_r2_subuh_qb.c} | 0
 .../{mips32-dspr2/subuh_r_qb.c => user/ase/dsp/test_dsp_r2_subuh_r_qb.c}  | 0
 tests/tcg/mips/{mipsr5900/div1.c => user/isa/r5900/test_r5900_div1.c}     | 0
 tests/tcg/mips/{mipsr5900/divu1.c => user/isa/r5900/test_r5900_divu1.c}   | 0
 tests/tcg/mips/{mipsr5900/madd.c => user/isa/r5900/test_r5900_madd.c}     | 0
 tests/tcg/mips/{mipsr5900/maddu.c => user/isa/r5900/test_r5900_maddu.c}   | 0
 .../tcg/mips/{mipsr5900/mflohi1.c => user/isa/r5900/test_r5900_mflohi1.c} | 0
 .../tcg/mips/{mipsr5900/mtlohi1.c => user/isa/r5900/test_r5900_mtlohi1.c} | 0
 tests/tcg/mips/{mipsr5900/mult.c => user/isa/r5900/test_r5900_mult.c}     | 0
 tests/tcg/mips/{mipsr5900/multu.c => user/isa/r5900/test_r5900_multu.c}   | 0
 168 files changed, 0 insertions(+), 0 deletions(-)
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
 rename tests/tcg/mips/{mipsr5900/div1.c => user/isa/r5900/test_r5900_div1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/divu1.c => user/isa/r5900/test_r5900_divu1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/madd.c => user/isa/r5900/test_r5900_madd.c} (100%)
 rename tests/tcg/mips/{mipsr5900/maddu.c => user/isa/r5900/test_r5900_maddu.c} (100%)
 rename tests/tcg/mips/{mipsr5900/mflohi1.c => user/isa/r5900/test_r5900_mflohi1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/mtlohi1.c => user/isa/r5900/test_r5900_mtlohi1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/mult.c => user/isa/r5900/test_r5900_mult.c} (100%)
 rename tests/tcg/mips/{mipsr5900/multu.c => user/isa/r5900/test_r5900_multu.c} (100%)

diff --git a/tests/tcg/mips/mips32-dsp/absq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/absq_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/absq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/absq_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c
diff --git a/tests/tcg/mips/mips32-dsp/addq_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addq_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/addq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addq_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/addq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addq_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c
diff --git a/tests/tcg/mips/mips32-dsp/addsc.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addsc.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c
diff --git a/tests/tcg/mips/mips32-dsp/addu_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addu_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/addu_s_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addu_s_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/addwc.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addwc.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c
diff --git a/tests/tcg/mips/mips32-dsp/bitrev.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/bitrev.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c
diff --git a/tests/tcg/mips/mips32-dsp/bposge32.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/bposge32.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c
diff --git a/tests/tcg/mips/mips32-dsp/cmp_eq_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmp_eq_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/cmp_le_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmp_le_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/cmp_lt_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmp_lt_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpgu_eq_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpgu_eq_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpgu_le_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpgu_le_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpgu_lt_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpgu_lt_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpu_eq_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpu_eq_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpu_le_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpu_le_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpu_lt_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpu_lt_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/dpaq_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpaq_s_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/dpaq_sa_l_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpaq_sa_l_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c
diff --git a/tests/tcg/mips/mips32-dsp/dpau_h_qbl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpau_h_qbl.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c
diff --git a/tests/tcg/mips/mips32-dsp/dpau_h_qbr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpau_h_qbr.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c
diff --git a/tests/tcg/mips/mips32-dsp/dpsq_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpsq_s_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/dpsq_sa_l_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpsq_sa_l_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c
diff --git a/tests/tcg/mips/mips32-dsp/dpsu_h_qbl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpsu_h_qbl.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c
diff --git a/tests/tcg/mips/mips32-dsp/dpsu_h_qbr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpsu_h_qbr.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c
diff --git a/tests/tcg/mips/mips32-dsp/extp.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extp.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c
diff --git a/tests/tcg/mips/mips32-dsp/extpdp.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extpdp.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c
diff --git a/tests/tcg/mips/mips32-dsp/extpdpv.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extpdpv.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c
diff --git a/tests/tcg/mips/mips32-dsp/extpv.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extpv.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c
diff --git a/tests/tcg/mips/mips32-dsp/extr_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extr_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c
diff --git a/tests/tcg/mips/mips32-dsp/extr_rs_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extr_rs_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c
diff --git a/tests/tcg/mips/mips32-dsp/extr_s_h.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extr_s_h.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c
diff --git a/tests/tcg/mips/mips32-dsp/extr_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extr_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c
diff --git a/tests/tcg/mips/mips32-dsp/extrv_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extrv_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c
diff --git a/tests/tcg/mips/mips32-dsp/extrv_rs_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extrv_rs_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c
diff --git a/tests/tcg/mips/mips32-dsp/extrv_s_h.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extrv_s_h.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c
diff --git a/tests/tcg/mips/mips32-dsp/extrv_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extrv_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c
diff --git a/tests/tcg/mips/mips32-dsp/insv.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/insv.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c
diff --git a/tests/tcg/mips/mips32-dsp/lbux.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/lbux.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c
diff --git a/tests/tcg/mips/mips32-dsp/lhx.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/lhx.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c
diff --git a/tests/tcg/mips/mips32-dsp/lwx.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/lwx.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c
diff --git a/tests/tcg/mips/mips32-dsp/maddu.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/maddu.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c
diff --git a/tests/tcg/mips/mips32-dsp/madd.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/madd.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c
diff --git a/tests/tcg/mips/mips32-dsp/main.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/main.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c
diff --git a/tests/tcg/mips/mips32-dsp/maq_s_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/maq_s_w_phl.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c
diff --git a/tests/tcg/mips/mips32-dsp/maq_s_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/maq_s_w_phr.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c
diff --git a/tests/tcg/mips/mips32-dsp/maq_sa_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/maq_sa_w_phl.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c
diff --git a/tests/tcg/mips/mips32-dsp/maq_sa_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/maq_sa_w_phr.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c
diff --git a/tests/tcg/mips/mips32-dsp/mthi.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mthi.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c
diff --git a/tests/tcg/mips/mips32-dsp/mtlo.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mtlo.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c
diff --git a/tests/tcg/mips/mips32-dsp/modsub.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/modsub.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c
diff --git a/tests/tcg/mips/mips32-dsp/msub.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/msub.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c
diff --git a/tests/tcg/mips/mips32-dsp/msubu.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/msubu.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c
diff --git a/tests/tcg/mips/mips32-dsp/mfhi.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mfhi.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c
diff --git a/tests/tcg/mips/mips32-dsp/mthlip.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mthlip.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c
diff --git a/tests/tcg/mips/mips32-dsp/mflo.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mflo.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c
diff --git a/tests/tcg/mips/mips32-dsp/muleq_s_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/muleq_s_w_phl.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c
diff --git a/tests/tcg/mips/mips32-dsp/muleq_s_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/muleq_s_w_phr.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c
diff --git a/tests/tcg/mips/mips32-dsp/muleu_s_ph_qbl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/muleu_s_ph_qbl.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c
diff --git a/tests/tcg/mips/mips32-dsp/muleu_s_ph_qbr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/muleu_s_ph_qbr.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c
diff --git a/tests/tcg/mips/mips32-dsp/mulq_rs_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mulq_rs_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/mult.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mult.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c
diff --git a/tests/tcg/mips/mips32-dsp/multu.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/multu.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c
diff --git a/tests/tcg/mips/mips32-dsp/packrl_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/packrl_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/pick_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/pick_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/pick_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/pick_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/preceq_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceq_w_phl.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c
diff --git a/tests/tcg/mips/mips32-dsp/preceq_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceq_w_phr.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precequ_ph_qbl.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbla.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precequ_ph_qbla.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precequ_ph_qbr.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbra.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precequ_ph_qbra.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbl.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceu_ph_qbl.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbla.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceu_ph_qbla.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbr.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceu_ph_qbr.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbra.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceu_ph_qbra.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c
diff --git a/tests/tcg/mips/mips32-dsp/precrq_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precrq_ph_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c
diff --git a/tests/tcg/mips/mips32-dsp/precrq_qb_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precrq_qb_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/precrq_rs_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precrq_rs_ph_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c
diff --git a/tests/tcg/mips/mips32-dsp/precrqu_s_qb_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precrqu_s_qb_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/raddu_w_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/raddu_w_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/rddsp.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/rddsp.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c
diff --git a/tests/tcg/mips/mips32-dsp/repl_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/repl_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/repl_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/repl_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/replv_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/replv_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/replv_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/replv_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/shilo.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shilo.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c
diff --git a/tests/tcg/mips/mips32-dsp/shilov.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shilov.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c
diff --git a/tests/tcg/mips/mips32-dsp/shll_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shll_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shll_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shll_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/shll_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shll_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shll_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shll_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c
diff --git a/tests/tcg/mips/mips32-dsp/shllv_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shllv_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shllv_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shllv_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/shllv_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shllv_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shllv_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shllv_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c
diff --git a/tests/tcg/mips/mips32-dsp/shra_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shra_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shra_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shra_r_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shra_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shra_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c
diff --git a/tests/tcg/mips/mips32-dsp/shrav_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shrav_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shrav_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shrav_r_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shrav_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shrav_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c
diff --git a/tests/tcg/mips/mips32-dsp/shrl_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shrl_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/shrlv_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shrlv_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/subq_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/subq_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/subq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/subq_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/subq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/subq_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c
diff --git a/tests/tcg/mips/mips32-dsp/subu_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/subu_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/subu_s_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/subu_s_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/wrdsp.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/wrdsp.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c
diff --git a/tests/tcg/mips/mips32-dspr2/absq_s_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/absq_s_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addqh_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addqh_r_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addqh_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addqh_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/addu_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addu_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/addu_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addu_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/adduh_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/adduh_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/adduh_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/adduh_r_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/append.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/append.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c
diff --git a/tests/tcg/mips/mips32-dspr2/balign.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/balign.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c
diff --git a/tests/tcg/mips/mips32-dspr2/cmpgdu_eq_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/cmpgdu_eq_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/cmpgdu_le_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/cmpgdu_le_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/cmpgdu_lt_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/cmpgdu_lt_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpa_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpaqx_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpaqx_s_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpaqx_sa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpaqx_sa_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpax_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpax_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dps_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dps_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpsqx_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpsqx_s_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpsqx_sa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpsqx_sa_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpsx_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpsx_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/mul_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mul_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/mul_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mul_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/mulq_rs_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mulq_rs_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/mulq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mulq_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/mulq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mulq_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/mulsa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mulsa_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/mulsaq_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mulsaq_s_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/precr_qb_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/precr_qb_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/precr_sra_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/precr_sra_ph_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/precr_sra_r_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/precr_sra_r_ph_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/prepend.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/prepend.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c
diff --git a/tests/tcg/mips/mips32-dspr2/shra_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shra_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/shra_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shra_r_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/shrav_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shrav_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/shrav_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shrav_r_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/shrl_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shrl_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/shrlv_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shrlv_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subqh_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subqh_r_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_r_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subqh_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_w.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subqh_w.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/subu_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subu_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/subu_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subu_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/subuh_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subuh_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/subuh_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subuh_r_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c
diff --git a/tests/tcg/mips/mipsr5900/div1.c b/tests/tcg/mips/user/isa/r5900/test_r5900_div1.c
similarity index 100%
rename from tests/tcg/mips/mipsr5900/div1.c
rename to tests/tcg/mips/user/isa/r5900/test_r5900_div1.c
diff --git a/tests/tcg/mips/mipsr5900/divu1.c b/tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c
similarity index 100%
rename from tests/tcg/mips/mipsr5900/divu1.c
rename to tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c
diff --git a/tests/tcg/mips/mipsr5900/madd.c b/tests/tcg/mips/user/isa/r5900/test_r5900_madd.c
similarity index 100%
rename from tests/tcg/mips/mipsr5900/madd.c
rename to tests/tcg/mips/user/isa/r5900/test_r5900_madd.c
diff --git a/tests/tcg/mips/mipsr5900/maddu.c b/tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c
similarity index 100%
rename from tests/tcg/mips/mipsr5900/maddu.c
rename to tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c
diff --git a/tests/tcg/mips/mipsr5900/mflohi1.c b/tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c
similarity index 100%
rename from tests/tcg/mips/mipsr5900/mflohi1.c
rename to tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c
diff --git a/tests/tcg/mips/mipsr5900/mtlohi1.c b/tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c
similarity index 100%
rename from tests/tcg/mips/mipsr5900/mtlohi1.c
rename to tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c
diff --git a/tests/tcg/mips/mipsr5900/mult.c b/tests/tcg/mips/user/isa/r5900/test_r5900_mult.c
similarity index 100%
rename from tests/tcg/mips/mipsr5900/mult.c
rename to tests/tcg/mips/user/isa/r5900/test_r5900_mult.c
diff --git a/tests/tcg/mips/mipsr5900/multu.c b/tests/tcg/mips/user/isa/r5900/test_r5900_multu.c
similarity index 100%
rename from tests/tcg/mips/mipsr5900/multu.c
rename to tests/tcg/mips/user/isa/r5900/test_r5900_multu.c
-- 
2.7.4
