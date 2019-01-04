Received: from eggs.gnu.org ([208.118.235.92]:60505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gfSdl-0002fq-Gq
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gfSdT-0005uQ-Uq
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:48:09 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42512 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gfSdS-00052u-L7
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:47:51 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  4 Jan 2019 17:46:33 +0100
Message-Id: <1546620394-24958-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546620394-24958-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546620394-24958-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/2] tests: tcg: mips: Move source files to new
 location
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

New directory organization is as follows:

tests
  tcg
    mips
      user
        isa
          r5900
        ase
          dsp
      system
        ase
          dsp

New file names are unique within tests/tcg/mips directory, to
avoid potential name colision problems.

There will be new subdirectories in near future, for example:

tests/tcg/mips/user/isa/nanomips
tests/tcg/mips/user/ase/msa
tests/tcg/mips/user/ase/mxu

etc.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../{mips64-dsp/absq_s_ob.c => system/ase/dsp/test_64_dsp_r1_absq_s_ob.c} | 0
 .../{mips64-dsp/absq_s_ph.c => system/ase/dsp/test_64_dsp_r1_absq_s_ph.c} | 0
 .../{mips64-dsp/absq_s_pw.c => system/ase/dsp/test_64_dsp_r1_absq_s_pw.c} | 0
 .../{mips64-dsp/absq_s_qh.c => system/ase/dsp/test_64_dsp_r1_absq_s_qh.c} | 0
 .../{mips64-dsp/absq_s_w.c => system/ase/dsp/test_64_dsp_r1_absq_s_w.c}   | 0
 .../{mips64-dsp/addq_ph.c => system/ase/dsp/test_64_dsp_r1_addq_ph.c}     | 0
 .../{mips64-dsp/addq_pw.c => system/ase/dsp/test_64_dsp_r1_addq_pw.c}     | 0
 .../{mips64-dsp/addq_qh.c => system/ase/dsp/test_64_dsp_r1_addq_qh.c}     | 0
 .../{mips64-dsp/addq_s_ph.c => system/ase/dsp/test_64_dsp_r1_addq_s_ph.c} | 0
 .../{mips64-dsp/addq_s_pw.c => system/ase/dsp/test_64_dsp_r1_addq_s_pw.c} | 0
 .../{mips64-dsp/addq_s_qh.c => system/ase/dsp/test_64_dsp_r1_addq_s_qh.c} | 0
 .../{mips64-dsp/addq_s_w.c => system/ase/dsp/test_64_dsp_r1_addq_s_w.c}   | 0
 .../mips/{mips64-dsp/addsc.c => system/ase/dsp/test_64_dsp_r1_addsc.c}    | 0
 .../{mips64-dsp/addu_ob.c => system/ase/dsp/test_64_dsp_r1_addu_ob.c}     | 0
 .../{mips64-dsp/addu_qb.c => system/ase/dsp/test_64_dsp_r1_addu_qb.c}     | 0
 .../{mips64-dsp/addu_s_ob.c => system/ase/dsp/test_64_dsp_r1_addu_s_ob.c} | 0
 .../{mips64-dsp/addu_s_qb.c => system/ase/dsp/test_64_dsp_r1_addu_s_qb.c} | 0
 .../mips/{mips64-dsp/addwc.c => system/ase/dsp/test_64_dsp_r1_addwc.c}    | 0
 .../mips/{mips64-dsp/bitrev.c => system/ase/dsp/test_64_dsp_r1_bitrev.c}  | 0
 .../{mips64-dsp/bposge32.c => system/ase/dsp/test_64_dsp_r1_bposge32.c}   | 0
 .../{mips64-dsp/bposge64.c => system/ase/dsp/test_64_dsp_r1_bposge64.c}   | 0
 .../{mips64-dsp/cmp_eq_ph.c => system/ase/dsp/test_64_dsp_r1_cmp_eq_ph.c} | 0
 .../{mips64-dsp/cmp_eq_pw.c => system/ase/dsp/test_64_dsp_r1_cmp_eq_pw.c} | 0
 .../{mips64-dsp/cmp_eq_qh.c => system/ase/dsp/test_64_dsp_r1_cmp_eq_qh.c} | 0
 .../{mips64-dsp/cmp_le_ph.c => system/ase/dsp/test_64_dsp_r1_cmp_le_ph.c} | 0
 .../{mips64-dsp/cmp_le_pw.c => system/ase/dsp/test_64_dsp_r1_cmp_le_pw.c} | 0
 .../{mips64-dsp/cmp_le_qh.c => system/ase/dsp/test_64_dsp_r1_cmp_le_qh.c} | 0
 .../{mips64-dsp/cmp_lt_ph.c => system/ase/dsp/test_64_dsp_r1_cmp_lt_ph.c} | 0
 .../{mips64-dsp/cmp_lt_pw.c => system/ase/dsp/test_64_dsp_r1_cmp_lt_pw.c} | 0
 .../{mips64-dsp/cmp_lt_qh.c => system/ase/dsp/test_64_dsp_r1_cmp_lt_qh.c} | 0
 .../cmpgu_eq_ob.c => system/ase/dsp/test_64_dsp_r1_cmpgu_eq_ob.c}         | 0
 .../cmpgu_eq_qb.c => system/ase/dsp/test_64_dsp_r1_cmpgu_eq_qb.c}         | 0
 .../cmpgu_le_ob.c => system/ase/dsp/test_64_dsp_r1_cmpgu_le_ob.c}         | 0
 .../cmpgu_le_qb.c => system/ase/dsp/test_64_dsp_r1_cmpgu_le_qb.c}         | 0
 .../cmpgu_lt_ob.c => system/ase/dsp/test_64_dsp_r1_cmpgu_lt_ob.c}         | 0
 .../cmpgu_lt_qb.c => system/ase/dsp/test_64_dsp_r1_cmpgu_lt_qb.c}         | 0
 .../cmpu_eq_ob.c => system/ase/dsp/test_64_dsp_r1_cmpu_eq_ob.c}           | 0
 .../cmpu_eq_qb.c => system/ase/dsp/test_64_dsp_r1_cmpu_eq_qb.c}           | 0
 .../cmpu_le_ob.c => system/ase/dsp/test_64_dsp_r1_cmpu_le_ob.c}           | 0
 .../cmpu_le_qb.c => system/ase/dsp/test_64_dsp_r1_cmpu_le_qb.c}           | 0
 .../cmpu_lt_ob.c => system/ase/dsp/test_64_dsp_r1_cmpu_lt_ob.c}           | 0
 .../cmpu_lt_qb.c => system/ase/dsp/test_64_dsp_r1_cmpu_lt_qb.c}           | 0
 .../{mips64-dsp/dappend.c => system/ase/dsp/test_64_dsp_r1_dappend.c}     | 0
 .../mips/{mips64-dsp/dextp.c => system/ase/dsp/test_64_dsp_r1_dextp.c}    | 0
 .../{mips64-dsp/dextpdp.c => system/ase/dsp/test_64_dsp_r1_dextpdp.c}     | 0
 .../{mips64-dsp/dextpdpv.c => system/ase/dsp/test_64_dsp_r1_dextpdpv.c}   | 0
 .../mips/{mips64-dsp/dextpv.c => system/ase/dsp/test_64_dsp_r1_dextpv.c}  | 0
 .../{mips64-dsp/dextr_l.c => system/ase/dsp/test_64_dsp_r1_dextr_l.c}     | 0
 .../{mips64-dsp/dextr_r_l.c => system/ase/dsp/test_64_dsp_r1_dextr_r_l.c} | 0
 .../{mips64-dsp/dextr_r_w.c => system/ase/dsp/test_64_dsp_r1_dextr_r_w.c} | 0
 .../dextr_rs_l.c => system/ase/dsp/test_64_dsp_r1_dextr_rs_l.c}           | 0
 .../dextr_rs_w.c => system/ase/dsp/test_64_dsp_r1_dextr_rs_w.c}           | 0
 .../{mips64-dsp/dextr_s_h.c => system/ase/dsp/test_64_dsp_r1_dextr_s_h.c} | 0
 .../{mips64-dsp/dextr_w.c => system/ase/dsp/test_64_dsp_r1_dextr_w.c}     | 0
 .../{mips64-dsp/dextrv_l.c => system/ase/dsp/test_64_dsp_r1_dextrv_l.c}   | 0
 .../dextrv_r_l.c => system/ase/dsp/test_64_dsp_r1_dextrv_r_l.c}           | 0
 .../dextrv_r_w.c => system/ase/dsp/test_64_dsp_r1_dextrv_r_w.c}           | 0
 .../dextrv_rs_l.c => system/ase/dsp/test_64_dsp_r1_dextrv_rs_l.c}         | 0
 .../dextrv_rs_w.c => system/ase/dsp/test_64_dsp_r1_dextrv_rs_w.c}         | 0
 .../dextrv_s_h.c => system/ase/dsp/test_64_dsp_r1_dextrv_s_h.c}           | 0
 .../{mips64-dsp/dextrv_w.c => system/ase/dsp/test_64_dsp_r1_dextrv_w.c}   | 0
 .../mips/{mips64-dsp/dinsv.c => system/ase/dsp/test_64_dsp_r1_dinsv.c}    | 0
 .../mips/{mips64-dsp/dmadd.c => system/ase/dsp/test_64_dsp_r1_dmadd.c}    | 0
 .../mips/{mips64-dsp/dmaddu.c => system/ase/dsp/test_64_dsp_r1_dmaddu.c}  | 0
 .../mips/{mips64-dsp/dmsub.c => system/ase/dsp/test_64_dsp_r1_dmsub.c}    | 0
 .../mips/{mips64-dsp/dmsubu.c => system/ase/dsp/test_64_dsp_r1_dmsubu.c}  | 0
 .../{mips64-dsp/dmthlip.c => system/ase/dsp/test_64_dsp_r1_dmthlip.c}     | 0
 .../dpaq_s_w_ph.c => system/ase/dsp/test_64_dsp_r1_dpaq_s_w_ph.c}         | 0
 .../dpaq_s_w_qh.c => system/ase/dsp/test_64_dsp_r1_dpaq_s_w_qh.c}         | 0
 .../dpaq_sa_l_pw.c => system/ase/dsp/test_64_dsp_r1_dpaq_sa_l_pw.c}       | 0
 .../dpaq_sa_l_w.c => system/ase/dsp/test_64_dsp_r1_dpaq_sa_l_w.c}         | 0
 .../dpau_h_obl.c => system/ase/dsp/test_64_dsp_r1_dpau_h_obl.c}           | 0
 .../dpau_h_obr.c => system/ase/dsp/test_64_dsp_r1_dpau_h_obr.c}           | 0
 .../dpau_h_qbl.c => system/ase/dsp/test_64_dsp_r1_dpau_h_qbl.c}           | 0
 .../dpau_h_qbr.c => system/ase/dsp/test_64_dsp_r1_dpau_h_qbr.c}           | 0
 .../dpsq_s_w_ph.c => system/ase/dsp/test_64_dsp_r1_dpsq_s_w_ph.c}         | 0
 .../dpsq_s_w_qh.c => system/ase/dsp/test_64_dsp_r1_dpsq_s_w_qh.c}         | 0
 .../dpsq_sa_l_pw.c => system/ase/dsp/test_64_dsp_r1_dpsq_sa_l_pw.c}       | 0
 .../dpsq_sa_l_w.c => system/ase/dsp/test_64_dsp_r1_dpsq_sa_l_w.c}         | 0
 .../dpsu_h_obl.c => system/ase/dsp/test_64_dsp_r1_dpsu_h_obl.c}           | 0
 .../dpsu_h_obr.c => system/ase/dsp/test_64_dsp_r1_dpsu_h_obr.c}           | 0
 .../dpsu_h_qbl.c => system/ase/dsp/test_64_dsp_r1_dpsu_h_qbl.c}           | 0
 .../dpsu_h_qbr.c => system/ase/dsp/test_64_dsp_r1_dpsu_h_qbr.c}           | 0
 .../mips/{mips64-dsp/dshilo.c => system/ase/dsp/test_64_dsp_r1_dshilo.c}  | 0
 .../{mips64-dsp/dshilov.c => system/ase/dsp/test_64_dsp_r1_dshilov.c}     | 0
 .../tcg/mips/{mips64-dsp/extp.c => system/ase/dsp/test_64_dsp_r1_extp.c}  | 0
 .../mips/{mips64-dsp/extpdp.c => system/ase/dsp/test_64_dsp_r1_extpdp.c}  | 0
 .../{mips64-dsp/extpdpv.c => system/ase/dsp/test_64_dsp_r1_extpdpv.c}     | 0
 .../mips/{mips64-dsp/extpv.c => system/ase/dsp/test_64_dsp_r1_extpv.c}    | 0
 .../{mips64-dsp/extr_r_w.c => system/ase/dsp/test_64_dsp_r1_extr_r_w.c}   | 0
 .../{mips64-dsp/extr_rs_w.c => system/ase/dsp/test_64_dsp_r1_extr_rs_w.c} | 0
 .../{mips64-dsp/extr_s_h.c => system/ase/dsp/test_64_dsp_r1_extr_s_h.c}   | 0
 .../mips/{mips64-dsp/extr_w.c => system/ase/dsp/test_64_dsp_r1_extr_w.c}  | 0
 .../{mips64-dsp/extrv_r_w.c => system/ase/dsp/test_64_dsp_r1_extrv_r_w.c} | 0
 .../extrv_rs_w.c => system/ase/dsp/test_64_dsp_r1_extrv_rs_w.c}           | 0
 .../{mips64-dsp/extrv_s_h.c => system/ase/dsp/test_64_dsp_r1_extrv_s_h.c} | 0
 .../{mips64-dsp/extrv_w.c => system/ase/dsp/test_64_dsp_r1_extrv_w.c}     | 0
 .../tcg/mips/{mips64-dsp/insv.c => system/ase/dsp/test_64_dsp_r1_insv.c}  | 0
 .../tcg/mips/{mips64-dsp/lbux.c => system/ase/dsp/test_64_dsp_r1_lbux.c}  | 0
 tests/tcg/mips/{mips64-dsp/ldx.c => system/ase/dsp/test_64_dsp_r1_ldx.c}  | 0
 tests/tcg/mips/{mips64-dsp/lhx.c => system/ase/dsp/test_64_dsp_r1_lhx.c}  | 0
 tests/tcg/mips/{mips64-dsp/lwx.c => system/ase/dsp/test_64_dsp_r1_lwx.c}  | 0
 .../tcg/mips/{mips64-dsp/madd.c => system/ase/dsp/test_64_dsp_r1_madd.c}  | 0
 .../mips/{mips64-dsp/maddu.c => system/ase/dsp/test_64_dsp_r1_maddu.c}    | 0
 .../maq_s_l_pwl.c => system/ase/dsp/test_64_dsp_r1_maq_s_l_pwl.c}         | 0
 .../maq_s_l_pwr.c => system/ase/dsp/test_64_dsp_r1_maq_s_l_pwr.c}         | 0
 .../maq_s_w_phl.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_phl.c}         | 0
 .../maq_s_w_phr.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_phr.c}         | 0
 .../maq_s_w_qhll.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_qhll.c}       | 0
 .../maq_s_w_qhlr.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_qhlr.c}       | 0
 .../maq_s_w_qhrl.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_qhrl.c}       | 0
 .../maq_s_w_qhrr.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_qhrr.c}       | 0
 .../maq_sa_w_phl.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_phl.c}       | 0
 .../maq_sa_w_phr.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_phr.c}       | 0
 .../maq_sa_w_qhll.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhll.c}     | 0
 .../maq_sa_w_qhlr.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhlr.c}     | 0
 .../maq_sa_w_qhrl.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhrl.c}     | 0
 .../maq_sa_w_qhrr.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhrr.c}     | 0
 .../tcg/mips/{mips64-dsp/mfhi.c => system/ase/dsp/test_64_dsp_r1_mfhi.c}  | 0
 .../tcg/mips/{mips64-dsp/mflo.c => system/ase/dsp/test_64_dsp_r1_mflo.c}  | 0
 .../mips/{mips64-dsp/modsub.c => system/ase/dsp/test_64_dsp_r1_modsub.c}  | 0
 .../tcg/mips/{mips64-dsp/msub.c => system/ase/dsp/test_64_dsp_r1_msub.c}  | 0
 .../mips/{mips64-dsp/msubu.c => system/ase/dsp/test_64_dsp_r1_msubu.c}    | 0
 .../tcg/mips/{mips64-dsp/mthi.c => system/ase/dsp/test_64_dsp_r1_mthi.c}  | 0
 .../mips/{mips64-dsp/mthlip.c => system/ase/dsp/test_64_dsp_r1_mthlip.c}  | 0
 .../tcg/mips/{mips64-dsp/mtlo.c => system/ase/dsp/test_64_dsp_r1_mtlo.c}  | 0
 .../muleq_s_pw_qhl.c => system/ase/dsp/test_64_dsp_r1_muleq_s_pw_qhl.c}   | 0
 .../muleq_s_pw_qhr.c => system/ase/dsp/test_64_dsp_r1_muleq_s_pw_qhr.c}   | 0
 .../muleq_s_w_phl.c => system/ase/dsp/test_64_dsp_r1_muleq_s_w_phl.c}     | 0
 .../muleq_s_w_phr.c => system/ase/dsp/test_64_dsp_r1_muleq_s_w_phr.c}     | 0
 .../muleu_s_ph_qbl.c => system/ase/dsp/test_64_dsp_r1_muleu_s_ph_qbl.c}   | 0
 .../muleu_s_ph_qbr.c => system/ase/dsp/test_64_dsp_r1_muleu_s_ph_qbr.c}   | 0
 .../muleu_s_qh_obl.c => system/ase/dsp/test_64_dsp_r1_muleu_s_qh_obl.c}   | 0
 .../muleu_s_qh_obr.c => system/ase/dsp/test_64_dsp_r1_muleu_s_qh_obr.c}   | 0
 .../mulq_rs_ph.c => system/ase/dsp/test_64_dsp_r1_mulq_rs_ph.c}           | 0
 .../mulq_rs_qh.c => system/ase/dsp/test_64_dsp_r1_mulq_rs_qh.c}           | 0
 .../mulsaq_s_l_pw.c => system/ase/dsp/test_64_dsp_r1_mulsaq_s_l_pw.c}     | 0
 .../mulsaq_s_w_qh.c => system/ase/dsp/test_64_dsp_r1_mulsaq_s_w_qh.c}     | 0
 .../tcg/mips/{mips64-dsp/mult.c => system/ase/dsp/test_64_dsp_r1_mult.c}  | 0
 .../mips/{mips64-dsp/multu.c => system/ase/dsp/test_64_dsp_r1_multu.c}    | 0
 .../{mips64-dsp/packrl_ph.c => system/ase/dsp/test_64_dsp_r1_packrl_ph.c} | 0
 .../{mips64-dsp/packrl_pw.c => system/ase/dsp/test_64_dsp_r1_packrl_pw.c} | 0
 .../{mips64-dsp/pick_ob.c => system/ase/dsp/test_64_dsp_r1_pick_ob.c}     | 0
 .../{mips64-dsp/pick_ph.c => system/ase/dsp/test_64_dsp_r1_pick_ph.c}     | 0
 .../{mips64-dsp/pick_pw.c => system/ase/dsp/test_64_dsp_r1_pick_pw.c}     | 0
 .../{mips64-dsp/pick_qb.c => system/ase/dsp/test_64_dsp_r1_pick_qb.c}     | 0
 .../{mips64-dsp/pick_qh.c => system/ase/dsp/test_64_dsp_r1_pick_qh.c}     | 0
 .../preceq_l_pwl.c => system/ase/dsp/test_64_dsp_r1_preceq_l_pwl.c}       | 0
 .../preceq_l_pwr.c => system/ase/dsp/test_64_dsp_r1_preceq_l_pwr.c}       | 0
 .../preceq_pw_qhl.c => system/ase/dsp/test_64_dsp_r1_preceq_pw_qhl.c}     | 0
 .../preceq_pw_qhla.c => system/ase/dsp/test_64_dsp_r1_preceq_pw_qhla.c}   | 0
 .../preceq_pw_qhr.c => system/ase/dsp/test_64_dsp_r1_preceq_pw_qhr.c}     | 0
 .../preceq_pw_qhra.c => system/ase/dsp/test_64_dsp_r1_preceq_pw_qhra.c}   | 0
 .../preceq_w_phl.c => system/ase/dsp/test_64_dsp_r1_preceq_w_phl.c}       | 0
 .../preceq_w_phr.c => system/ase/dsp/test_64_dsp_r1_preceq_w_phr.c}       | 0
 .../precequ_ph_qbl.c => system/ase/dsp/test_64_dsp_r1_precequ_ph_qbl.c}   | 0
 .../precequ_ph_qbla.c => system/ase/dsp/test_64_dsp_r1_precequ_ph_qbla.c} | 0
 .../precequ_ph_qbr.c => system/ase/dsp/test_64_dsp_r1_precequ_ph_qbr.c}   | 0
 .../precequ_ph_qbra.c => system/ase/dsp/test_64_dsp_r1_precequ_ph_qbra.c} | 0
 .../precequ_qh_obl.c => system/ase/dsp/test_64_dsp_r1_precequ_qh_obl.c}   | 0
 .../precequ_qh_obla.c => system/ase/dsp/test_64_dsp_r1_precequ_qh_obla.c} | 0
 .../precequ_qh_obr.c => system/ase/dsp/test_64_dsp_r1_precequ_qh_obr.c}   | 0
 .../precequ_qh_obra.c => system/ase/dsp/test_64_dsp_r1_precequ_qh_obra.c} | 0
 .../preceu_ph_qbl.c => system/ase/dsp/test_64_dsp_r1_preceu_ph_qbl.c}     | 0
 .../preceu_ph_qbla.c => system/ase/dsp/test_64_dsp_r1_preceu_ph_qbla.c}   | 0
 .../preceu_ph_qbr.c => system/ase/dsp/test_64_dsp_r1_preceu_ph_qbr.c}     | 0
 .../preceu_ph_qbra.c => system/ase/dsp/test_64_dsp_r1_preceu_ph_qbra.c}   | 0
 .../preceu_qh_obl.c => system/ase/dsp/test_64_dsp_r1_preceu_qh_obl.c}     | 0
 .../preceu_qh_obla.c => system/ase/dsp/test_64_dsp_r1_preceu_qh_obla.c}   | 0
 .../preceu_qh_obr.c => system/ase/dsp/test_64_dsp_r1_preceu_qh_obr.c}     | 0
 .../preceu_qh_obra.c => system/ase/dsp/test_64_dsp_r1_preceu_qh_obra.c}   | 0
 .../precr_ob_qh.c => system/ase/dsp/test_64_dsp_r1_precr_ob_qh.c}         | 0
 .../precr_sra_qh_pw.c => system/ase/dsp/test_64_dsp_r1_precr_sra_qh_pw.c} | 0
 .../ase/dsp/test_64_dsp_r1_precr_sra_r_qh_pw.c}                           | 0
 .../precrq_ob_qh.c => system/ase/dsp/test_64_dsp_r1_precrq_ob_qh.c}       | 0
 .../precrq_ph_w.c => system/ase/dsp/test_64_dsp_r1_precrq_ph_w.c}         | 0
 .../precrq_pw_l.c => system/ase/dsp/test_64_dsp_r1_precrq_pw_l.c}         | 0
 .../precrq_qb_ph.c => system/ase/dsp/test_64_dsp_r1_precrq_qb_ph.c}       | 0
 .../precrq_qh_pw.c => system/ase/dsp/test_64_dsp_r1_precrq_qh_pw.c}       | 0
 .../precrq_rs_ph_w.c => system/ase/dsp/test_64_dsp_r1_precrq_rs_ph_w.c}   | 0
 .../precrq_rs_qh_pw.c => system/ase/dsp/test_64_dsp_r1_precrq_rs_qh_pw.c} | 0
 .../precrqu_s_ob_qh.c => system/ase/dsp/test_64_dsp_r1_precrqu_s_ob_qh.c} | 0
 .../precrqu_s_qb_ph.c => system/ase/dsp/test_64_dsp_r1_precrqu_s_qb_ph.c} | 0
 .../{mips64-dsp/prependd.c => system/ase/dsp/test_64_dsp_r1_prependd.c}   | 0
 .../{mips64-dsp/prependw.c => system/ase/dsp/test_64_dsp_r1_prependw.c}   | 0
 .../{mips64-dspr2/printf.c => system/ase/dsp/test_64_dsp_r1_printf.c}     | 0
 .../raddu_l_ob.c => system/ase/dsp/test_64_dsp_r1_raddu_l_ob.c}           | 0
 .../raddu_w_qb.c => system/ase/dsp/test_64_dsp_r1_raddu_w_qb.c}           | 0
 .../mips/{mips64-dsp/rddsp.c => system/ase/dsp/test_64_dsp_r1_rddsp.c}    | 0
 .../{mips64-dsp/repl_ob.c => system/ase/dsp/test_64_dsp_r1_repl_ob.c}     | 0
 .../{mips64-dsp/repl_ph.c => system/ase/dsp/test_64_dsp_r1_repl_ph.c}     | 0
 .../{mips64-dsp/repl_pw.c => system/ase/dsp/test_64_dsp_r1_repl_pw.c}     | 0
 .../{mips64-dsp/repl_qb.c => system/ase/dsp/test_64_dsp_r1_repl_qb.c}     | 0
 .../{mips64-dsp/repl_qh.c => system/ase/dsp/test_64_dsp_r1_repl_qh.c}     | 0
 .../{mips64-dsp/replv_ob.c => system/ase/dsp/test_64_dsp_r1_replv_ob.c}   | 0
 .../{mips64-dsp/replv_ph.c => system/ase/dsp/test_64_dsp_r1_replv_ph.c}   | 0
 .../{mips64-dsp/replv_pw.c => system/ase/dsp/test_64_dsp_r1_replv_pw.c}   | 0
 .../{mips64-dsp/replv_qb.c => system/ase/dsp/test_64_dsp_r1_replv_qb.c}   | 0
 .../mips/{mips64-dsp/shilo.c => system/ase/dsp/test_64_dsp_r1_shilo.c}    | 0
 .../mips/{mips64-dsp/shilov.c => system/ase/dsp/test_64_dsp_r1_shilov.c}  | 0
 .../{mips64-dsp/shll_ob.c => system/ase/dsp/test_64_dsp_r1_shll_ob.c}     | 0
 .../{mips64-dsp/shll_ph.c => system/ase/dsp/test_64_dsp_r1_shll_ph.c}     | 0
 .../{mips64-dsp/shll_pw.c => system/ase/dsp/test_64_dsp_r1_shll_pw.c}     | 0
 .../{mips64-dsp/shll_qb.c => system/ase/dsp/test_64_dsp_r1_shll_qb.c}     | 0
 .../{mips64-dsp/shll_qh.c => system/ase/dsp/test_64_dsp_r1_shll_qh.c}     | 0
 .../{mips64-dsp/shll_s_ph.c => system/ase/dsp/test_64_dsp_r1_shll_s_ph.c} | 0
 .../{mips64-dsp/shll_s_pw.c => system/ase/dsp/test_64_dsp_r1_shll_s_pw.c} | 0
 .../{mips64-dsp/shll_s_qh.c => system/ase/dsp/test_64_dsp_r1_shll_s_qh.c} | 0
 .../{mips64-dsp/shll_s_w.c => system/ase/dsp/test_64_dsp_r1_shll_s_w.c}   | 0
 .../{mips64-dsp/shllv_ob.c => system/ase/dsp/test_64_dsp_r1_shllv_ob.c}   | 0
 .../{mips64-dsp/shllv_ph.c => system/ase/dsp/test_64_dsp_r1_shllv_ph.c}   | 0
 .../{mips64-dsp/shllv_pw.c => system/ase/dsp/test_64_dsp_r1_shllv_pw.c}   | 0
 .../{mips64-dsp/shllv_qb.c => system/ase/dsp/test_64_dsp_r1_shllv_qb.c}   | 0
 .../{mips64-dsp/shllv_qh.c => system/ase/dsp/test_64_dsp_r1_shllv_qh.c}   | 0
 .../shllv_s_ph.c => system/ase/dsp/test_64_dsp_r1_shllv_s_ph.c}           | 0
 .../shllv_s_pw.c => system/ase/dsp/test_64_dsp_r1_shllv_s_pw.c}           | 0
 .../shllv_s_qh.c => system/ase/dsp/test_64_dsp_r1_shllv_s_qh.c}           | 0
 .../{mips64-dsp/shllv_s_w.c => system/ase/dsp/test_64_dsp_r1_shllv_s_w.c} | 0
 .../{mips64-dsp/shra_ob.c => system/ase/dsp/test_64_dsp_r1_shra_ob.c}     | 0
 .../{mips64-dsp/shra_ph.c => system/ase/dsp/test_64_dsp_r1_shra_ph.c}     | 0
 .../{mips64-dsp/shra_pw.c => system/ase/dsp/test_64_dsp_r1_shra_pw.c}     | 0
 .../{mips64-dsp/shra_qh.c => system/ase/dsp/test_64_dsp_r1_shra_qh.c}     | 0
 .../{mips64-dsp/shra_r_ob.c => system/ase/dsp/test_64_dsp_r1_shra_r_ob.c} | 0
 .../{mips64-dsp/shra_r_ph.c => system/ase/dsp/test_64_dsp_r1_shra_r_ph.c} | 0
 .../{mips64-dsp/shra_r_pw.c => system/ase/dsp/test_64_dsp_r1_shra_r_pw.c} | 0
 .../{mips64-dsp/shra_r_qh.c => system/ase/dsp/test_64_dsp_r1_shra_r_qh.c} | 0
 .../{mips64-dsp/shra_r_w.c => system/ase/dsp/test_64_dsp_r1_shra_r_w.c}   | 0
 .../{mips64-dsp/shrav_ph.c => system/ase/dsp/test_64_dsp_r1_shrav_ph.c}   | 0
 .../{mips64-dsp/shrav_pw.c => system/ase/dsp/test_64_dsp_r1_shrav_pw.c}   | 0
 .../{mips64-dsp/shrav_qh.c => system/ase/dsp/test_64_dsp_r1_shrav_qh.c}   | 0
 .../shrav_r_ph.c => system/ase/dsp/test_64_dsp_r1_shrav_r_ph.c}           | 0
 .../shrav_r_pw.c => system/ase/dsp/test_64_dsp_r1_shrav_r_pw.c}           | 0
 .../shrav_r_qh.c => system/ase/dsp/test_64_dsp_r1_shrav_r_qh.c}           | 0
 .../{mips64-dsp/shrav_r_w.c => system/ase/dsp/test_64_dsp_r1_shrav_r_w.c} | 0
 .../{mips64-dsp/shrl_ob.c => system/ase/dsp/test_64_dsp_r1_shrl_ob.c}     | 0
 .../{mips64-dsp/shrl_qb.c => system/ase/dsp/test_64_dsp_r1_shrl_qb.c}     | 0
 .../{mips64-dsp/shrl_qh.c => system/ase/dsp/test_64_dsp_r1_shrl_qh.c}     | 0
 .../{mips64-dsp/shrlv_ob.c => system/ase/dsp/test_64_dsp_r1_shrlv_ob.c}   | 0
 .../{mips64-dsp/shrlv_qb.c => system/ase/dsp/test_64_dsp_r1_shrlv_qb.c}   | 0
 .../{mips64-dsp/shrlv_qh.c => system/ase/dsp/test_64_dsp_r1_shrlv_qh.c}   | 0
 .../{mips64-dsp/subq_ph.c => system/ase/dsp/test_64_dsp_r1_subq_ph.c}     | 0
 .../{mips64-dsp/subq_pw.c => system/ase/dsp/test_64_dsp_r1_subq_pw.c}     | 0
 .../{mips64-dsp/subq_qh.c => system/ase/dsp/test_64_dsp_r1_subq_qh.c}     | 0
 .../{mips64-dsp/subq_s_ph.c => system/ase/dsp/test_64_dsp_r1_subq_s_ph.c} | 0
 .../{mips64-dsp/subq_s_pw.c => system/ase/dsp/test_64_dsp_r1_subq_s_pw.c} | 0
 .../{mips64-dsp/subq_s_qh.c => system/ase/dsp/test_64_dsp_r1_subq_s_qh.c} | 0
 .../{mips64-dsp/subq_s_w.c => system/ase/dsp/test_64_dsp_r1_subq_s_w.c}   | 0
 .../{mips64-dsp/subu_ob.c => system/ase/dsp/test_64_dsp_r1_subu_ob.c}     | 0
 .../{mips64-dsp/subu_qb.c => system/ase/dsp/test_64_dsp_r1_subu_qb.c}     | 0
 .../{mips64-dsp/subu_s_ob.c => system/ase/dsp/test_64_dsp_r1_subu_s_ob.c} | 0
 .../{mips64-dsp/subu_s_qb.c => system/ase/dsp/test_64_dsp_r1_subu_s_qb.c} | 0
 .../mips/{mips64-dsp/wrdsp.c => system/ase/dsp/test_64_dsp_r1_wrdsp.c}    | 0
 .../absq_s_qb.c => system/ase/dsp/test_64_dsp_r2_absq_s_qb.c}             | 0
 .../{mips64-dspr2/addqh_ph.c => system/ase/dsp/test_64_dsp_r2_addqh_ph.c} | 0
 .../addqh_r_ph.c => system/ase/dsp/test_64_dsp_r2_addqh_r_ph.c}           | 0
 .../addqh_r_w.c => system/ase/dsp/test_64_dsp_r2_addqh_r_w.c}             | 0
 .../{mips64-dspr2/addqh_w.c => system/ase/dsp/test_64_dsp_r2_addqh_w.c}   | 0
 .../{mips64-dspr2/addu_ph.c => system/ase/dsp/test_64_dsp_r2_addu_ph.c}   | 0
 .../{mips64-dspr2/addu_qh.c => system/ase/dsp/test_64_dsp_r2_addu_qh.c}   | 0
 .../addu_s_ph.c => system/ase/dsp/test_64_dsp_r2_addu_s_ph.c}             | 0
 .../addu_s_qh.c => system/ase/dsp/test_64_dsp_r2_addu_s_qh.c}             | 0
 .../{mips64-dspr2/adduh_ob.c => system/ase/dsp/test_64_dsp_r2_adduh_ob.c} | 0
 .../{mips64-dspr2/adduh_qb.c => system/ase/dsp/test_64_dsp_r2_adduh_qb.c} | 0
 .../adduh_r_ob.c => system/ase/dsp/test_64_dsp_r2_adduh_r_ob.c}           | 0
 .../adduh_r_qb.c => system/ase/dsp/test_64_dsp_r2_adduh_r_qb.c}           | 0
 .../{mips64-dspr2/append.c => system/ase/dsp/test_64_dsp_r2_append.c}     | 0
 .../{mips64-dspr2/balign.c => system/ase/dsp/test_64_dsp_r2_balign.c}     | 0
 .../cmpgdu_eq_ob.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_eq_ob.c}       | 0
 .../cmpgdu_eq_qb.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_eq_qb.c}       | 0
 .../cmpgdu_le_ob.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_le_ob.c}       | 0
 .../cmpgdu_le_qb.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_le_qb.c}       | 0
 .../cmpgdu_lt_ob.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_lt_ob.c}       | 0
 .../cmpgdu_lt_qb.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_lt_qb.c}       | 0
 .../{mips64-dspr2/dbalign.c => system/ase/dsp/test_64_dsp_r2_dbalign.c}   | 0
 .../{mips64-dspr2/dpa_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpa_w_ph.c} | 0
 .../{mips64-dspr2/dpa_w_qh.c => system/ase/dsp/test_64_dsp_r2_dpa_w_qh.c} | 0
 .../dpaqx_s_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpaqx_s_w_ph.c}       | 0
 .../dpaqx_sa_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpaqx_sa_w_ph.c}     | 0
 .../dpax_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpax_w_ph.c}             | 0
 .../{mips64-dspr2/dps_w_ph.c => system/ase/dsp/test_64_dsp_r2_dps_w_ph.c} | 0
 .../{mips64-dspr2/dps_w_qh.c => system/ase/dsp/test_64_dsp_r2_dps_w_qh.c} | 0
 .../dpsqx_s_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpsqx_s_w_ph.c}       | 0
 .../dpsqx_sa_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpsqx_sa_w_ph.c}     | 0
 .../dpsx_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpsx_w_ph.c}             | 0
 .../{mips64-dspr2/mul_ph.c => system/ase/dsp/test_64_dsp_r2_mul_ph.c}     | 0
 .../{mips64-dspr2/mul_s_ph.c => system/ase/dsp/test_64_dsp_r2_mul_s_ph.c} | 0
 .../mulq_rs_w.c => system/ase/dsp/test_64_dsp_r2_mulq_rs_w.c}             | 0
 .../mulq_s_ph.c => system/ase/dsp/test_64_dsp_r2_mulq_s_ph.c}             | 0
 .../{mips64-dspr2/mulq_s_w.c => system/ase/dsp/test_64_dsp_r2_mulq_s_w.c} | 0
 .../mulsa_w_ph.c => system/ase/dsp/test_64_dsp_r2_mulsa_w_ph.c}           | 0
 .../mulsaq_s_w_ph.c => system/ase/dsp/test_64_dsp_r2_mulsaq_s_w_ph.c}     | 0
 .../precr_qb_ph.c => system/ase/dsp/test_64_dsp_r2_precr_qb_ph.c}         | 0
 .../precr_sra_ph_w.c => system/ase/dsp/test_64_dsp_r2_precr_sra_ph_w.c}   | 0
 .../ase/dsp/test_64_dsp_r2_precr_sra_r_ph_w.c}                            | 0
 .../{mips64-dspr2/prepend.c => system/ase/dsp/test_64_dsp_r2_prepend.c}   | 0
 .../mips/{mips64-dsp/printf.c => system/ase/dsp/test_64_dsp_r2_printf.c}  | 0
 .../{mips64-dspr2/shra_qb.c => system/ase/dsp/test_64_dsp_r2_shra_qb.c}   | 0
 .../shra_r_qb.c => system/ase/dsp/test_64_dsp_r2_shra_r_qb.c}             | 0
 .../{mips64-dspr2/shrav_ob.c => system/ase/dsp/test_64_dsp_r2_shrav_ob.c} | 0
 .../{mips64-dspr2/shrav_qb.c => system/ase/dsp/test_64_dsp_r2_shrav_qb.c} | 0
 .../shrav_r_ob.c => system/ase/dsp/test_64_dsp_r2_shrav_r_ob.c}           | 0
 .../shrav_r_qb.c => system/ase/dsp/test_64_dsp_r2_shrav_r_qb.c}           | 0
 .../{mips64-dspr2/shrl_ph.c => system/ase/dsp/test_64_dsp_r2_shrl_ph.c}   | 0
 .../{mips64-dspr2/shrlv_ph.c => system/ase/dsp/test_64_dsp_r2_shrlv_ph.c} | 0
 .../{mips64-dspr2/subqh_ph.c => system/ase/dsp/test_64_dsp_r2_subqh_ph.c} | 0
 .../subqh_r_ph.c => system/ase/dsp/test_64_dsp_r2_subqh_r_ph.c}           | 0
 .../subqh_r_w.c => system/ase/dsp/test_64_dsp_r2_subqh_r_w.c}             | 0
 .../{mips64-dspr2/subqh_w.c => system/ase/dsp/test_64_dsp_r2_subqh_w.c}   | 0
 .../{mips64-dspr2/subu_ph.c => system/ase/dsp/test_64_dsp_r2_subu_ph.c}   | 0
 .../{mips64-dspr2/subu_qh.c => system/ase/dsp/test_64_dsp_r2_subu_qh.c}   | 0
 .../subu_s_ph.c => system/ase/dsp/test_64_dsp_r2_subu_s_ph.c}             | 0
 .../subu_s_qh.c => system/ase/dsp/test_64_dsp_r2_subu_s_qh.c}             | 0
 .../{mips64-dspr2/subuh_ob.c => system/ase/dsp/test_64_dsp_r2_subuh_ob.c} | 0
 .../{mips64-dspr2/subuh_qb.c => system/ase/dsp/test_64_dsp_r2_subuh_qb.c} | 0
 .../subuh_r_ob.c => system/ase/dsp/test_64_dsp_r2_subuh_r_ob.c}           | 0
 .../subuh_r_qb.c => system/ase/dsp/test_64_dsp_r2_subuh_r_qb.c}           | 0
 .../{mips32-dsp/absq_s_ph.c => user/ase/dsp/test_32_dsp_r1_absq_s_ph.c}   | 0
 .../{mips32-dsp/absq_s_w.c => user/ase/dsp/test_32_dsp_r1_absq_s_w.c}     | 0
 .../mips/{mips32-dsp/addq_ph.c => user/ase/dsp/test_32_dsp_r1_addq_ph.c}  | 0
 .../{mips32-dsp/addq_s_ph.c => user/ase/dsp/test_32_dsp_r1_addq_s_ph.c}   | 0
 .../{mips32-dsp/addq_s_w.c => user/ase/dsp/test_32_dsp_r1_addq_s_w.c}     | 0
 .../tcg/mips/{mips32-dsp/addsc.c => user/ase/dsp/test_32_dsp_r1_addsc.c}  | 0
 .../mips/{mips32-dsp/addu_qb.c => user/ase/dsp/test_32_dsp_r1_addu_qb.c}  | 0
 .../{mips32-dsp/addu_s_qb.c => user/ase/dsp/test_32_dsp_r1_addu_s_qb.c}   | 0
 .../tcg/mips/{mips32-dsp/addwc.c => user/ase/dsp/test_32_dsp_r1_addwc.c}  | 0
 .../mips/{mips32-dsp/bitrev.c => user/ase/dsp/test_32_dsp_r1_bitrev.c}    | 0
 .../{mips32-dsp/bposge32.c => user/ase/dsp/test_32_dsp_r1_bposge32.c}     | 0
 .../{mips32-dsp/cmp_eq_ph.c => user/ase/dsp/test_32_dsp_r1_cmp_eq_ph.c}   | 0
 .../{mips32-dsp/cmp_le_ph.c => user/ase/dsp/test_32_dsp_r1_cmp_le_ph.c}   | 0
 .../{mips32-dsp/cmp_lt_ph.c => user/ase/dsp/test_32_dsp_r1_cmp_lt_ph.c}   | 0
 .../cmpgu_eq_qb.c => user/ase/dsp/test_32_dsp_r1_cmpgu_eq_qb.c}           | 0
 .../cmpgu_le_qb.c => user/ase/dsp/test_32_dsp_r1_cmpgu_le_qb.c}           | 0
 .../cmpgu_lt_qb.c => user/ase/dsp/test_32_dsp_r1_cmpgu_lt_qb.c}           | 0
 .../{mips32-dsp/cmpu_eq_qb.c => user/ase/dsp/test_32_dsp_r1_cmpu_eq_qb.c} | 0
 .../{mips32-dsp/cmpu_le_qb.c => user/ase/dsp/test_32_dsp_r1_cmpu_le_qb.c} | 0
 .../{mips32-dsp/cmpu_lt_qb.c => user/ase/dsp/test_32_dsp_r1_cmpu_lt_qb.c} | 0
 .../dpaq_s_w_ph.c => user/ase/dsp/test_32_dsp_r1_dpaq_s_w_ph.c}           | 0
 .../dpaq_sa_l_w.c => user/ase/dsp/test_32_dsp_r1_dpaq_sa_l_w.c}           | 0
 .../{mips32-dsp/dpau_h_qbl.c => user/ase/dsp/test_32_dsp_r1_dpau_h_qbl.c} | 0
 .../{mips32-dsp/dpau_h_qbr.c => user/ase/dsp/test_32_dsp_r1_dpau_h_qbr.c} | 0
 .../dpsq_s_w_ph.c => user/ase/dsp/test_32_dsp_r1_dpsq_s_w_ph.c}           | 0
 .../dpsq_sa_l_w.c => user/ase/dsp/test_32_dsp_r1_dpsq_sa_l_w.c}           | 0
 .../{mips32-dsp/dpsu_h_qbl.c => user/ase/dsp/test_32_dsp_r1_dpsu_h_qbl.c} | 0
 .../{mips32-dsp/dpsu_h_qbr.c => user/ase/dsp/test_32_dsp_r1_dpsu_h_qbr.c} | 0
 tests/tcg/mips/{mips32-dsp/extp.c => user/ase/dsp/test_32_dsp_r1_extp.c}  | 0
 .../mips/{mips32-dsp/extpdp.c => user/ase/dsp/test_32_dsp_r1_extpdp.c}    | 0
 .../mips/{mips32-dsp/extpdpv.c => user/ase/dsp/test_32_dsp_r1_extpdpv.c}  | 0
 .../tcg/mips/{mips32-dsp/extpv.c => user/ase/dsp/test_32_dsp_r1_extpv.c}  | 0
 .../{mips32-dsp/extr_r_w.c => user/ase/dsp/test_32_dsp_r1_extr_r_w.c}     | 0
 .../{mips32-dsp/extr_rs_w.c => user/ase/dsp/test_32_dsp_r1_extr_rs_w.c}   | 0
 .../{mips32-dsp/extr_s_h.c => user/ase/dsp/test_32_dsp_r1_extr_s_h.c}     | 0
 .../mips/{mips32-dsp/extr_w.c => user/ase/dsp/test_32_dsp_r1_extr_w.c}    | 0
 .../{mips32-dsp/extrv_r_w.c => user/ase/dsp/test_32_dsp_r1_extrv_r_w.c}   | 0
 .../{mips32-dsp/extrv_rs_w.c => user/ase/dsp/test_32_dsp_r1_extrv_rs_w.c} | 0
 .../{mips32-dsp/extrv_s_h.c => user/ase/dsp/test_32_dsp_r1_extrv_s_h.c}   | 0
 .../mips/{mips32-dsp/extrv_w.c => user/ase/dsp/test_32_dsp_r1_extrv_w.c}  | 0
 tests/tcg/mips/{mips32-dsp/insv.c => user/ase/dsp/test_32_dsp_r1_insv.c}  | 0
 tests/tcg/mips/{mips32-dsp/lbux.c => user/ase/dsp/test_32_dsp_r1_lbux.c}  | 0
 tests/tcg/mips/{mips32-dsp/lhx.c => user/ase/dsp/test_32_dsp_r1_lhx.c}    | 0
 tests/tcg/mips/{mips32-dsp/lwx.c => user/ase/dsp/test_32_dsp_r1_lwx.c}    | 0
 tests/tcg/mips/{mips32-dsp/maddu.c => user/ase/dsp/test_32_dsp_r1_madd.c} | 0
 tests/tcg/mips/{mips32-dsp/madd.c => user/ase/dsp/test_32_dsp_r1_maddu.c} | 0
 tests/tcg/mips/{mips32-dsp/main.c => user/ase/dsp/test_32_dsp_r1_main.c}  | 0
 .../maq_s_w_phl.c => user/ase/dsp/test_32_dsp_r1_maq_s_w_phl.c}           | 0
 .../maq_s_w_phr.c => user/ase/dsp/test_32_dsp_r1_maq_s_w_phr.c}           | 0
 .../maq_sa_w_phl.c => user/ase/dsp/test_32_dsp_r1_maq_sa_w_phl.c}         | 0
 .../maq_sa_w_phr.c => user/ase/dsp/test_32_dsp_r1_maq_sa_w_phr.c}         | 0
 tests/tcg/mips/{mips32-dsp/mthi.c => user/ase/dsp/test_32_dsp_r1_mfhi.c}  | 0
 tests/tcg/mips/{mips32-dsp/mtlo.c => user/ase/dsp/test_32_dsp_r1_mflo.c}  | 0
 .../mips/{mips32-dsp/modsub.c => user/ase/dsp/test_32_dsp_r1_modsub.c}    | 0
 tests/tcg/mips/{mips32-dsp/msub.c => user/ase/dsp/test_32_dsp_r1_msub.c}  | 0
 .../tcg/mips/{mips32-dsp/msubu.c => user/ase/dsp/test_32_dsp_r1_msubu.c}  | 0
 tests/tcg/mips/{mips32-dsp/mfhi.c => user/ase/dsp/test_32_dsp_r1_mthi.c}  | 0
 .../mips/{mips32-dsp/mthlip.c => user/ase/dsp/test_32_dsp_r1_mthlip.c}    | 0
 tests/tcg/mips/{mips32-dsp/mflo.c => user/ase/dsp/test_32_dsp_r1_mtlo.c}  | 0
 .../muleq_s_w_phl.c => user/ase/dsp/test_32_dsp_r1_muleq_s_w_phl.c}       | 0
 .../muleq_s_w_phr.c => user/ase/dsp/test_32_dsp_r1_muleq_s_w_phr.c}       | 0
 .../muleu_s_ph_qbl.c => user/ase/dsp/test_32_dsp_r1_muleu_s_ph_qbl.c}     | 0
 .../muleu_s_ph_qbr.c => user/ase/dsp/test_32_dsp_r1_muleu_s_ph_qbr.c}     | 0
 .../{mips32-dsp/mulq_rs_ph.c => user/ase/dsp/test_32_dsp_r1_mulq_rs_ph.c} | 0
 tests/tcg/mips/{mips32-dsp/mult.c => user/ase/dsp/test_32_dsp_r1_mult.c}  | 0
 .../tcg/mips/{mips32-dsp/multu.c => user/ase/dsp/test_32_dsp_r1_multu.c}  | 0
 .../{mips32-dsp/packrl_ph.c => user/ase/dsp/test_32_dsp_r1_packrl_ph.c}   | 0
 .../mips/{mips32-dsp/pick_ph.c => user/ase/dsp/test_32_dsp_r1_pick_ph.c}  | 0
 .../mips/{mips32-dsp/pick_qb.c => user/ase/dsp/test_32_dsp_r1_pick_qb.c}  | 0
 .../preceq_w_phl.c => user/ase/dsp/test_32_dsp_r1_preceq_w_phl.c}         | 0
 .../preceq_w_phr.c => user/ase/dsp/test_32_dsp_r1_preceq_w_phr.c}         | 0
 .../precequ_ph_qbl.c => user/ase/dsp/test_32_dsp_r1_precequ_ph_qbl.c}     | 0
 .../precequ_ph_qbla.c => user/ase/dsp/test_32_dsp_r1_precequ_ph_qbla.c}   | 0
 .../precequ_ph_qbr.c => user/ase/dsp/test_32_dsp_r1_precequ_ph_qbr.c}     | 0
 .../precequ_ph_qbra.c => user/ase/dsp/test_32_dsp_r1_precequ_ph_qbra.c}   | 0
 .../preceu_ph_qbl.c => user/ase/dsp/test_32_dsp_r1_preceu_ph_qbl.c}       | 0
 .../preceu_ph_qbla.c => user/ase/dsp/test_32_dsp_r1_preceu_ph_qbla.c}     | 0
 .../preceu_ph_qbr.c => user/ase/dsp/test_32_dsp_r1_preceu_ph_qbr.c}       | 0
 .../preceu_ph_qbra.c => user/ase/dsp/test_32_dsp_r1_preceu_ph_qbra.c}     | 0
 .../precrq_ph_w.c => user/ase/dsp/test_32_dsp_r1_precrq_ph_w.c}           | 0
 .../precrq_qb_ph.c => user/ase/dsp/test_32_dsp_r1_precrq_qb_ph.c}         | 0
 .../precrq_rs_ph_w.c => user/ase/dsp/test_32_dsp_r1_precrq_rs_ph_w.c}     | 0
 .../precrqu_s_qb_ph.c => user/ase/dsp/test_32_dsp_r1_precrqu_s_qb_ph.c}   | 0
 .../{mips32-dsp/raddu_w_qb.c => user/ase/dsp/test_32_dsp_r1_raddu_w_qb.c} | 0
 .../tcg/mips/{mips32-dsp/rddsp.c => user/ase/dsp/test_32_dsp_r1_rddsp.c}  | 0
 .../mips/{mips32-dsp/repl_ph.c => user/ase/dsp/test_32_dsp_r1_repl_ph.c}  | 0
 .../mips/{mips32-dsp/repl_qb.c => user/ase/dsp/test_32_dsp_r1_repl_qb.c}  | 0
 .../{mips32-dsp/replv_ph.c => user/ase/dsp/test_32_dsp_r1_replv_ph.c}     | 0
 .../{mips32-dsp/replv_qb.c => user/ase/dsp/test_32_dsp_r1_replv_qb.c}     | 0
 .../tcg/mips/{mips32-dsp/shilo.c => user/ase/dsp/test_32_dsp_r1_shilo.c}  | 0
 .../mips/{mips32-dsp/shilov.c => user/ase/dsp/test_32_dsp_r1_shilov.c}    | 0
 .../mips/{mips32-dsp/shll_ph.c => user/ase/dsp/test_32_dsp_r1_shll_ph.c}  | 0
 .../mips/{mips32-dsp/shll_qb.c => user/ase/dsp/test_32_dsp_r1_shll_qb.c}  | 0
 .../{mips32-dsp/shll_s_ph.c => user/ase/dsp/test_32_dsp_r1_shll_s_ph.c}   | 0
 .../{mips32-dsp/shll_s_w.c => user/ase/dsp/test_32_dsp_r1_shll_s_w.c}     | 0
 .../{mips32-dsp/shllv_ph.c => user/ase/dsp/test_32_dsp_r1_shllv_ph.c}     | 0
 .../{mips32-dsp/shllv_qb.c => user/ase/dsp/test_32_dsp_r1_shllv_qb.c}     | 0
 .../{mips32-dsp/shllv_s_ph.c => user/ase/dsp/test_32_dsp_r1_shllv_s_ph.c} | 0
 .../{mips32-dsp/shllv_s_w.c => user/ase/dsp/test_32_dsp_r1_shllv_s_w.c}   | 0
 .../mips/{mips32-dsp/shra_ph.c => user/ase/dsp/test_32_dsp_r1_shra_ph.c}  | 0
 .../{mips32-dsp/shra_r_ph.c => user/ase/dsp/test_32_dsp_r1_shra_r_ph.c}   | 0
 .../{mips32-dsp/shra_r_w.c => user/ase/dsp/test_32_dsp_r1_shra_r_w.c}     | 0
 .../{mips32-dsp/shrav_ph.c => user/ase/dsp/test_32_dsp_r1_shrav_ph.c}     | 0
 .../{mips32-dsp/shrav_r_ph.c => user/ase/dsp/test_32_dsp_r1_shrav_r_ph.c} | 0
 .../{mips32-dsp/shrav_r_w.c => user/ase/dsp/test_32_dsp_r1_shrav_r_w.c}   | 0
 .../mips/{mips32-dsp/shrl_qb.c => user/ase/dsp/test_32_dsp_r1_shrl_qb.c}  | 0
 .../{mips32-dsp/shrlv_qb.c => user/ase/dsp/test_32_dsp_r1_shrlv_qb.c}     | 0
 .../mips/{mips32-dsp/subq_ph.c => user/ase/dsp/test_32_dsp_r1_subq_ph.c}  | 0
 .../{mips32-dsp/subq_s_ph.c => user/ase/dsp/test_32_dsp_r1_subq_s_ph.c}   | 0
 .../{mips32-dsp/subq_s_w.c => user/ase/dsp/test_32_dsp_r1_subq_s_w.c}     | 0
 .../mips/{mips32-dsp/subu_qb.c => user/ase/dsp/test_32_dsp_r1_subu_qb.c}  | 0
 .../{mips32-dsp/subu_s_qb.c => user/ase/dsp/test_32_dsp_r1_subu_s_qb.c}   | 0
 .../tcg/mips/{mips32-dsp/wrdsp.c => user/ase/dsp/test_32_dsp_r1_wrdsp.c}  | 0
 .../{mips32-dspr2/absq_s_qb.c => user/ase/dsp/test_32_dsp_r2_absq_s_qb.c} | 0
 .../{mips32-dspr2/addqh_ph.c => user/ase/dsp/test_32_dsp_r2_addqh_ph.c}   | 0
 .../addqh_r_ph.c => user/ase/dsp/test_32_dsp_r2_addqh_r_ph.c}             | 0
 .../{mips32-dspr2/addqh_r_w.c => user/ase/dsp/test_32_dsp_r2_addqh_r_w.c} | 0
 .../{mips32-dspr2/addqh_w.c => user/ase/dsp/test_32_dsp_r2_addqh_w.c}     | 0
 .../{mips32-dspr2/addu_ph.c => user/ase/dsp/test_32_dsp_r2_addu_ph.c}     | 0
 .../{mips32-dspr2/addu_s_ph.c => user/ase/dsp/test_32_dsp_r2_addu_s_ph.c} | 0
 .../{mips32-dspr2/adduh_qb.c => user/ase/dsp/test_32_dsp_r2_adduh_qb.c}   | 0
 .../adduh_r_qb.c => user/ase/dsp/test_32_dsp_r2_adduh_r_qb.c}             | 0
 .../mips/{mips32-dspr2/append.c => user/ase/dsp/test_32_dsp_r2_append.c}  | 0
 .../mips/{mips32-dspr2/balign.c => user/ase/dsp/test_32_dsp_r2_balign.c}  | 0
 .../cmpgdu_eq_qb.c => user/ase/dsp/test_32_dsp_r2_cmpgdu_eq_qb.c}         | 0
 .../cmpgdu_le_qb.c => user/ase/dsp/test_32_dsp_r2_cmpgdu_le_qb.c}         | 0
 .../cmpgdu_lt_qb.c => user/ase/dsp/test_32_dsp_r2_cmpgdu_lt_qb.c}         | 0
 .../{mips32-dspr2/dpa_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpa_w_ph.c}   | 0
 .../dpaqx_s_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpaqx_s_w_ph.c}         | 0
 .../dpaqx_sa_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpaqx_sa_w_ph.c}       | 0
 .../{mips32-dspr2/dpax_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpax_w_ph.c} | 0
 .../{mips32-dspr2/dps_w_ph.c => user/ase/dsp/test_32_dsp_r2_dps_w_ph.c}   | 0
 .../dpsqx_s_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpsqx_s_w_ph.c}         | 0
 .../dpsqx_sa_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpsqx_sa_w_ph.c}       | 0
 .../{mips32-dspr2/dpsx_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpsx_w_ph.c} | 0
 .../mips/{mips32-dspr2/mul_ph.c => user/ase/dsp/test_32_dsp_r2_mul_ph.c}  | 0
 .../{mips32-dspr2/mul_s_ph.c => user/ase/dsp/test_32_dsp_r2_mul_s_ph.c}   | 0
 .../{mips32-dspr2/mulq_rs_w.c => user/ase/dsp/test_32_dsp_r2_mulq_rs_w.c} | 0
 .../{mips32-dspr2/mulq_s_ph.c => user/ase/dsp/test_32_dsp_r2_mulq_s_ph.c} | 0
 .../{mips32-dspr2/mulq_s_w.c => user/ase/dsp/test_32_dsp_r2_mulq_s_w.c}   | 0
 .../mulsa_w_ph.c => user/ase/dsp/test_32_dsp_r2_mulsa_w_ph.c}             | 0
 .../mulsaq_s_w_ph.c => user/ase/dsp/test_32_dsp_r2_mulsaq_s_w_ph.c}       | 0
 .../precr_qb_ph.c => user/ase/dsp/test_32_dsp_r2_precr_qb_ph.c}           | 0
 .../precr_sra_ph_w.c => user/ase/dsp/test_32_dsp_r2_precr_sra_ph_w.c}     | 0
 .../precr_sra_r_ph_w.c => user/ase/dsp/test_32_dsp_r2_precr_sra_r_ph_w.c} | 0
 .../{mips32-dspr2/prepend.c => user/ase/dsp/test_32_dsp_r2_prepend.c}     | 0
 .../{mips32-dspr2/shra_qb.c => user/ase/dsp/test_32_dsp_r2_shra_qb.c}     | 0
 .../{mips32-dspr2/shra_r_qb.c => user/ase/dsp/test_32_dsp_r2_shra_r_qb.c} | 0
 .../{mips32-dspr2/shrav_qb.c => user/ase/dsp/test_32_dsp_r2_shrav_qb.c}   | 0
 .../shrav_r_qb.c => user/ase/dsp/test_32_dsp_r2_shrav_r_qb.c}             | 0
 .../{mips32-dspr2/shrl_ph.c => user/ase/dsp/test_32_dsp_r2_shrl_ph.c}     | 0
 .../{mips32-dspr2/shrlv_ph.c => user/ase/dsp/test_32_dsp_r2_shrlv_ph.c}   | 0
 .../{mips32-dspr2/subqh_ph.c => user/ase/dsp/test_32_dsp_r2_subqh_ph.c}   | 0
 .../subqh_r_ph.c => user/ase/dsp/test_32_dsp_r2_subqh_r_ph.c}             | 0
 .../{mips32-dspr2/subqh_r_w.c => user/ase/dsp/test_32_dsp_r2_subqh_r_w.c} | 0
 .../{mips32-dspr2/subqh_w.c => user/ase/dsp/test_32_dsp_r2_subqh_w.c}     | 0
 .../{mips32-dspr2/subu_ph.c => user/ase/dsp/test_32_dsp_r2_subu_ph.c}     | 0
 .../{mips32-dspr2/subu_s_ph.c => user/ase/dsp/test_32_dsp_r2_subu_s_ph.c} | 0
 .../{mips32-dspr2/subuh_qb.c => user/ase/dsp/test_32_dsp_r2_subuh_qb.c}   | 0
 .../subuh_r_qb.c => user/ase/dsp/test_32_dsp_r2_subuh_r_qb.c}             | 0
 tests/tcg/mips/{mipsr5900/div1.c => user/isa/r5900/test_r5900_div1.c}     | 0
 tests/tcg/mips/{mipsr5900/divu1.c => user/isa/r5900/test_r5900_divu1.c}   | 0
 tests/tcg/mips/{mipsr5900/madd.c => user/isa/r5900/test_r5900_madd.c}     | 0
 tests/tcg/mips/{mipsr5900/maddu.c => user/isa/r5900/test_r5900_maddu.c}   | 0
 .../tcg/mips/{mipsr5900/mflohi1.c => user/isa/r5900/test_r5900_mflohi1.c} | 0
 .../tcg/mips/{mipsr5900/mtlohi1.c => user/isa/r5900/test_r5900_mtlohi1.c} | 0
 tests/tcg/mips/{mipsr5900/mult.c => user/isa/r5900/test_r5900_mult.c}     | 0
 tests/tcg/mips/{mipsr5900/multu.c => user/isa/r5900/test_r5900_multu.c}   | 0
 484 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/tcg/mips/{mips64-dsp/absq_s_ob.c => system/ase/dsp/test_64_dsp_r1_absq_s_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/absq_s_ph.c => system/ase/dsp/test_64_dsp_r1_absq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/absq_s_pw.c => system/ase/dsp/test_64_dsp_r1_absq_s_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/absq_s_qh.c => system/ase/dsp/test_64_dsp_r1_absq_s_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/absq_s_w.c => system/ase/dsp/test_64_dsp_r1_absq_s_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addq_ph.c => system/ase/dsp/test_64_dsp_r1_addq_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addq_pw.c => system/ase/dsp/test_64_dsp_r1_addq_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addq_qh.c => system/ase/dsp/test_64_dsp_r1_addq_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addq_s_ph.c => system/ase/dsp/test_64_dsp_r1_addq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addq_s_pw.c => system/ase/dsp/test_64_dsp_r1_addq_s_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addq_s_qh.c => system/ase/dsp/test_64_dsp_r1_addq_s_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addq_s_w.c => system/ase/dsp/test_64_dsp_r1_addq_s_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addsc.c => system/ase/dsp/test_64_dsp_r1_addsc.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addu_ob.c => system/ase/dsp/test_64_dsp_r1_addu_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addu_qb.c => system/ase/dsp/test_64_dsp_r1_addu_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addu_s_ob.c => system/ase/dsp/test_64_dsp_r1_addu_s_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addu_s_qb.c => system/ase/dsp/test_64_dsp_r1_addu_s_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/addwc.c => system/ase/dsp/test_64_dsp_r1_addwc.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/bitrev.c => system/ase/dsp/test_64_dsp_r1_bitrev.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/bposge32.c => system/ase/dsp/test_64_dsp_r1_bposge32.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/bposge64.c => system/ase/dsp/test_64_dsp_r1_bposge64.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmp_eq_ph.c => system/ase/dsp/test_64_dsp_r1_cmp_eq_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmp_eq_pw.c => system/ase/dsp/test_64_dsp_r1_cmp_eq_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmp_eq_qh.c => system/ase/dsp/test_64_dsp_r1_cmp_eq_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmp_le_ph.c => system/ase/dsp/test_64_dsp_r1_cmp_le_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmp_le_pw.c => system/ase/dsp/test_64_dsp_r1_cmp_le_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmp_le_qh.c => system/ase/dsp/test_64_dsp_r1_cmp_le_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmp_lt_ph.c => system/ase/dsp/test_64_dsp_r1_cmp_lt_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmp_lt_pw.c => system/ase/dsp/test_64_dsp_r1_cmp_lt_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmp_lt_qh.c => system/ase/dsp/test_64_dsp_r1_cmp_lt_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpgu_eq_ob.c => system/ase/dsp/test_64_dsp_r1_cmpgu_eq_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpgu_eq_qb.c => system/ase/dsp/test_64_dsp_r1_cmpgu_eq_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpgu_le_ob.c => system/ase/dsp/test_64_dsp_r1_cmpgu_le_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpgu_le_qb.c => system/ase/dsp/test_64_dsp_r1_cmpgu_le_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpgu_lt_ob.c => system/ase/dsp/test_64_dsp_r1_cmpgu_lt_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpgu_lt_qb.c => system/ase/dsp/test_64_dsp_r1_cmpgu_lt_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpu_eq_ob.c => system/ase/dsp/test_64_dsp_r1_cmpu_eq_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpu_eq_qb.c => system/ase/dsp/test_64_dsp_r1_cmpu_eq_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpu_le_ob.c => system/ase/dsp/test_64_dsp_r1_cmpu_le_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpu_le_qb.c => system/ase/dsp/test_64_dsp_r1_cmpu_le_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpu_lt_ob.c => system/ase/dsp/test_64_dsp_r1_cmpu_lt_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/cmpu_lt_qb.c => system/ase/dsp/test_64_dsp_r1_cmpu_lt_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dappend.c => system/ase/dsp/test_64_dsp_r1_dappend.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextp.c => system/ase/dsp/test_64_dsp_r1_dextp.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextpdp.c => system/ase/dsp/test_64_dsp_r1_dextpdp.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextpdpv.c => system/ase/dsp/test_64_dsp_r1_dextpdpv.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextpv.c => system/ase/dsp/test_64_dsp_r1_dextpv.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextr_l.c => system/ase/dsp/test_64_dsp_r1_dextr_l.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextr_r_l.c => system/ase/dsp/test_64_dsp_r1_dextr_r_l.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextr_r_w.c => system/ase/dsp/test_64_dsp_r1_dextr_r_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextr_rs_l.c => system/ase/dsp/test_64_dsp_r1_dextr_rs_l.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextr_rs_w.c => system/ase/dsp/test_64_dsp_r1_dextr_rs_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextr_s_h.c => system/ase/dsp/test_64_dsp_r1_dextr_s_h.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextr_w.c => system/ase/dsp/test_64_dsp_r1_dextr_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextrv_l.c => system/ase/dsp/test_64_dsp_r1_dextrv_l.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextrv_r_l.c => system/ase/dsp/test_64_dsp_r1_dextrv_r_l.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextrv_r_w.c => system/ase/dsp/test_64_dsp_r1_dextrv_r_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextrv_rs_l.c => system/ase/dsp/test_64_dsp_r1_dextrv_rs_l.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextrv_rs_w.c => system/ase/dsp/test_64_dsp_r1_dextrv_rs_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextrv_s_h.c => system/ase/dsp/test_64_dsp_r1_dextrv_s_h.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dextrv_w.c => system/ase/dsp/test_64_dsp_r1_dextrv_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dinsv.c => system/ase/dsp/test_64_dsp_r1_dinsv.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dmadd.c => system/ase/dsp/test_64_dsp_r1_dmadd.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dmaddu.c => system/ase/dsp/test_64_dsp_r1_dmaddu.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dmsub.c => system/ase/dsp/test_64_dsp_r1_dmsub.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dmsubu.c => system/ase/dsp/test_64_dsp_r1_dmsubu.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dmthlip.c => system/ase/dsp/test_64_dsp_r1_dmthlip.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpaq_s_w_ph.c => system/ase/dsp/test_64_dsp_r1_dpaq_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpaq_s_w_qh.c => system/ase/dsp/test_64_dsp_r1_dpaq_s_w_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpaq_sa_l_pw.c => system/ase/dsp/test_64_dsp_r1_dpaq_sa_l_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpaq_sa_l_w.c => system/ase/dsp/test_64_dsp_r1_dpaq_sa_l_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpau_h_obl.c => system/ase/dsp/test_64_dsp_r1_dpau_h_obl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpau_h_obr.c => system/ase/dsp/test_64_dsp_r1_dpau_h_obr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpau_h_qbl.c => system/ase/dsp/test_64_dsp_r1_dpau_h_qbl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpau_h_qbr.c => system/ase/dsp/test_64_dsp_r1_dpau_h_qbr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpsq_s_w_ph.c => system/ase/dsp/test_64_dsp_r1_dpsq_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpsq_s_w_qh.c => system/ase/dsp/test_64_dsp_r1_dpsq_s_w_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpsq_sa_l_pw.c => system/ase/dsp/test_64_dsp_r1_dpsq_sa_l_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpsq_sa_l_w.c => system/ase/dsp/test_64_dsp_r1_dpsq_sa_l_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpsu_h_obl.c => system/ase/dsp/test_64_dsp_r1_dpsu_h_obl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpsu_h_obr.c => system/ase/dsp/test_64_dsp_r1_dpsu_h_obr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpsu_h_qbl.c => system/ase/dsp/test_64_dsp_r1_dpsu_h_qbl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dpsu_h_qbr.c => system/ase/dsp/test_64_dsp_r1_dpsu_h_qbr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dshilo.c => system/ase/dsp/test_64_dsp_r1_dshilo.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/dshilov.c => system/ase/dsp/test_64_dsp_r1_dshilov.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extp.c => system/ase/dsp/test_64_dsp_r1_extp.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extpdp.c => system/ase/dsp/test_64_dsp_r1_extpdp.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extpdpv.c => system/ase/dsp/test_64_dsp_r1_extpdpv.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extpv.c => system/ase/dsp/test_64_dsp_r1_extpv.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extr_r_w.c => system/ase/dsp/test_64_dsp_r1_extr_r_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extr_rs_w.c => system/ase/dsp/test_64_dsp_r1_extr_rs_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extr_s_h.c => system/ase/dsp/test_64_dsp_r1_extr_s_h.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extr_w.c => system/ase/dsp/test_64_dsp_r1_extr_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extrv_r_w.c => system/ase/dsp/test_64_dsp_r1_extrv_r_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extrv_rs_w.c => system/ase/dsp/test_64_dsp_r1_extrv_rs_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extrv_s_h.c => system/ase/dsp/test_64_dsp_r1_extrv_s_h.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/extrv_w.c => system/ase/dsp/test_64_dsp_r1_extrv_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/insv.c => system/ase/dsp/test_64_dsp_r1_insv.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/lbux.c => system/ase/dsp/test_64_dsp_r1_lbux.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/ldx.c => system/ase/dsp/test_64_dsp_r1_ldx.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/lhx.c => system/ase/dsp/test_64_dsp_r1_lhx.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/lwx.c => system/ase/dsp/test_64_dsp_r1_lwx.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/madd.c => system/ase/dsp/test_64_dsp_r1_madd.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maddu.c => system/ase/dsp/test_64_dsp_r1_maddu.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_s_l_pwl.c => system/ase/dsp/test_64_dsp_r1_maq_s_l_pwl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_s_l_pwr.c => system/ase/dsp/test_64_dsp_r1_maq_s_l_pwr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_s_w_phl.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_phl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_s_w_phr.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_phr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_s_w_qhll.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_qhll.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_s_w_qhlr.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_qhlr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_s_w_qhrl.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_qhrl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_s_w_qhrr.c => system/ase/dsp/test_64_dsp_r1_maq_s_w_qhrr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_sa_w_phl.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_phl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_sa_w_phr.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_phr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_sa_w_qhll.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhll.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_sa_w_qhlr.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhlr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_sa_w_qhrl.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhrl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/maq_sa_w_qhrr.c => system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhrr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/mfhi.c => system/ase/dsp/test_64_dsp_r1_mfhi.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/mflo.c => system/ase/dsp/test_64_dsp_r1_mflo.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/modsub.c => system/ase/dsp/test_64_dsp_r1_modsub.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/msub.c => system/ase/dsp/test_64_dsp_r1_msub.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/msubu.c => system/ase/dsp/test_64_dsp_r1_msubu.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/mthi.c => system/ase/dsp/test_64_dsp_r1_mthi.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/mthlip.c => system/ase/dsp/test_64_dsp_r1_mthlip.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/mtlo.c => system/ase/dsp/test_64_dsp_r1_mtlo.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/muleq_s_pw_qhl.c => system/ase/dsp/test_64_dsp_r1_muleq_s_pw_qhl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/muleq_s_pw_qhr.c => system/ase/dsp/test_64_dsp_r1_muleq_s_pw_qhr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/muleq_s_w_phl.c => system/ase/dsp/test_64_dsp_r1_muleq_s_w_phl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/muleq_s_w_phr.c => system/ase/dsp/test_64_dsp_r1_muleq_s_w_phr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/muleu_s_ph_qbl.c => system/ase/dsp/test_64_dsp_r1_muleu_s_ph_qbl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/muleu_s_ph_qbr.c => system/ase/dsp/test_64_dsp_r1_muleu_s_ph_qbr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/muleu_s_qh_obl.c => system/ase/dsp/test_64_dsp_r1_muleu_s_qh_obl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/muleu_s_qh_obr.c => system/ase/dsp/test_64_dsp_r1_muleu_s_qh_obr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/mulq_rs_ph.c => system/ase/dsp/test_64_dsp_r1_mulq_rs_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/mulq_rs_qh.c => system/ase/dsp/test_64_dsp_r1_mulq_rs_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/mulsaq_s_l_pw.c => system/ase/dsp/test_64_dsp_r1_mulsaq_s_l_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/mulsaq_s_w_qh.c => system/ase/dsp/test_64_dsp_r1_mulsaq_s_w_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/mult.c => system/ase/dsp/test_64_dsp_r1_mult.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/multu.c => system/ase/dsp/test_64_dsp_r1_multu.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/packrl_ph.c => system/ase/dsp/test_64_dsp_r1_packrl_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/packrl_pw.c => system/ase/dsp/test_64_dsp_r1_packrl_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/pick_ob.c => system/ase/dsp/test_64_dsp_r1_pick_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/pick_ph.c => system/ase/dsp/test_64_dsp_r1_pick_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/pick_pw.c => system/ase/dsp/test_64_dsp_r1_pick_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/pick_qb.c => system/ase/dsp/test_64_dsp_r1_pick_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/pick_qh.c => system/ase/dsp/test_64_dsp_r1_pick_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceq_l_pwl.c => system/ase/dsp/test_64_dsp_r1_preceq_l_pwl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceq_l_pwr.c => system/ase/dsp/test_64_dsp_r1_preceq_l_pwr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceq_pw_qhl.c => system/ase/dsp/test_64_dsp_r1_preceq_pw_qhl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceq_pw_qhla.c => system/ase/dsp/test_64_dsp_r1_preceq_pw_qhla.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceq_pw_qhr.c => system/ase/dsp/test_64_dsp_r1_preceq_pw_qhr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceq_pw_qhra.c => system/ase/dsp/test_64_dsp_r1_preceq_pw_qhra.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceq_w_phl.c => system/ase/dsp/test_64_dsp_r1_preceq_w_phl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceq_w_phr.c => system/ase/dsp/test_64_dsp_r1_preceq_w_phr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precequ_ph_qbl.c => system/ase/dsp/test_64_dsp_r1_precequ_ph_qbl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precequ_ph_qbla.c => system/ase/dsp/test_64_dsp_r1_precequ_ph_qbla.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precequ_ph_qbr.c => system/ase/dsp/test_64_dsp_r1_precequ_ph_qbr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precequ_ph_qbra.c => system/ase/dsp/test_64_dsp_r1_precequ_ph_qbra.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precequ_qh_obl.c => system/ase/dsp/test_64_dsp_r1_precequ_qh_obl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precequ_qh_obla.c => system/ase/dsp/test_64_dsp_r1_precequ_qh_obla.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precequ_qh_obr.c => system/ase/dsp/test_64_dsp_r1_precequ_qh_obr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precequ_qh_obra.c => system/ase/dsp/test_64_dsp_r1_precequ_qh_obra.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceu_ph_qbl.c => system/ase/dsp/test_64_dsp_r1_preceu_ph_qbl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceu_ph_qbla.c => system/ase/dsp/test_64_dsp_r1_preceu_ph_qbla.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceu_ph_qbr.c => system/ase/dsp/test_64_dsp_r1_preceu_ph_qbr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceu_ph_qbra.c => system/ase/dsp/test_64_dsp_r1_preceu_ph_qbra.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceu_qh_obl.c => system/ase/dsp/test_64_dsp_r1_preceu_qh_obl.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceu_qh_obla.c => system/ase/dsp/test_64_dsp_r1_preceu_qh_obla.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceu_qh_obr.c => system/ase/dsp/test_64_dsp_r1_preceu_qh_obr.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/preceu_qh_obra.c => system/ase/dsp/test_64_dsp_r1_preceu_qh_obra.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precr_ob_qh.c => system/ase/dsp/test_64_dsp_r1_precr_ob_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precr_sra_qh_pw.c => system/ase/dsp/test_64_dsp_r1_precr_sra_qh_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precr_sra_r_qh_pw.c => system/ase/dsp/test_64_dsp_r1_precr_sra_r_qh_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precrq_ob_qh.c => system/ase/dsp/test_64_dsp_r1_precrq_ob_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precrq_ph_w.c => system/ase/dsp/test_64_dsp_r1_precrq_ph_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precrq_pw_l.c => system/ase/dsp/test_64_dsp_r1_precrq_pw_l.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precrq_qb_ph.c => system/ase/dsp/test_64_dsp_r1_precrq_qb_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precrq_qh_pw.c => system/ase/dsp/test_64_dsp_r1_precrq_qh_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precrq_rs_ph_w.c => system/ase/dsp/test_64_dsp_r1_precrq_rs_ph_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precrq_rs_qh_pw.c => system/ase/dsp/test_64_dsp_r1_precrq_rs_qh_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precrqu_s_ob_qh.c => system/ase/dsp/test_64_dsp_r1_precrqu_s_ob_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/precrqu_s_qb_ph.c => system/ase/dsp/test_64_dsp_r1_precrqu_s_qb_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/prependd.c => system/ase/dsp/test_64_dsp_r1_prependd.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/prependw.c => system/ase/dsp/test_64_dsp_r1_prependw.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/printf.c => system/ase/dsp/test_64_dsp_r1_printf.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/raddu_l_ob.c => system/ase/dsp/test_64_dsp_r1_raddu_l_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/raddu_w_qb.c => system/ase/dsp/test_64_dsp_r1_raddu_w_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/rddsp.c => system/ase/dsp/test_64_dsp_r1_rddsp.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/repl_ob.c => system/ase/dsp/test_64_dsp_r1_repl_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/repl_ph.c => system/ase/dsp/test_64_dsp_r1_repl_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/repl_pw.c => system/ase/dsp/test_64_dsp_r1_repl_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/repl_qb.c => system/ase/dsp/test_64_dsp_r1_repl_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/repl_qh.c => system/ase/dsp/test_64_dsp_r1_repl_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/replv_ob.c => system/ase/dsp/test_64_dsp_r1_replv_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/replv_ph.c => system/ase/dsp/test_64_dsp_r1_replv_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/replv_pw.c => system/ase/dsp/test_64_dsp_r1_replv_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/replv_qb.c => system/ase/dsp/test_64_dsp_r1_replv_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shilo.c => system/ase/dsp/test_64_dsp_r1_shilo.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shilov.c => system/ase/dsp/test_64_dsp_r1_shilov.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shll_ob.c => system/ase/dsp/test_64_dsp_r1_shll_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shll_ph.c => system/ase/dsp/test_64_dsp_r1_shll_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shll_pw.c => system/ase/dsp/test_64_dsp_r1_shll_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shll_qb.c => system/ase/dsp/test_64_dsp_r1_shll_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shll_qh.c => system/ase/dsp/test_64_dsp_r1_shll_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shll_s_ph.c => system/ase/dsp/test_64_dsp_r1_shll_s_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shll_s_pw.c => system/ase/dsp/test_64_dsp_r1_shll_s_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shll_s_qh.c => system/ase/dsp/test_64_dsp_r1_shll_s_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shll_s_w.c => system/ase/dsp/test_64_dsp_r1_shll_s_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shllv_ob.c => system/ase/dsp/test_64_dsp_r1_shllv_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shllv_ph.c => system/ase/dsp/test_64_dsp_r1_shllv_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shllv_pw.c => system/ase/dsp/test_64_dsp_r1_shllv_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shllv_qb.c => system/ase/dsp/test_64_dsp_r1_shllv_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shllv_qh.c => system/ase/dsp/test_64_dsp_r1_shllv_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shllv_s_ph.c => system/ase/dsp/test_64_dsp_r1_shllv_s_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shllv_s_pw.c => system/ase/dsp/test_64_dsp_r1_shllv_s_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shllv_s_qh.c => system/ase/dsp/test_64_dsp_r1_shllv_s_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shllv_s_w.c => system/ase/dsp/test_64_dsp_r1_shllv_s_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shra_ob.c => system/ase/dsp/test_64_dsp_r1_shra_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shra_ph.c => system/ase/dsp/test_64_dsp_r1_shra_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shra_pw.c => system/ase/dsp/test_64_dsp_r1_shra_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shra_qh.c => system/ase/dsp/test_64_dsp_r1_shra_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shra_r_ob.c => system/ase/dsp/test_64_dsp_r1_shra_r_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shra_r_ph.c => system/ase/dsp/test_64_dsp_r1_shra_r_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shra_r_pw.c => system/ase/dsp/test_64_dsp_r1_shra_r_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shra_r_qh.c => system/ase/dsp/test_64_dsp_r1_shra_r_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shra_r_w.c => system/ase/dsp/test_64_dsp_r1_shra_r_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrav_ph.c => system/ase/dsp/test_64_dsp_r1_shrav_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrav_pw.c => system/ase/dsp/test_64_dsp_r1_shrav_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrav_qh.c => system/ase/dsp/test_64_dsp_r1_shrav_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrav_r_ph.c => system/ase/dsp/test_64_dsp_r1_shrav_r_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrav_r_pw.c => system/ase/dsp/test_64_dsp_r1_shrav_r_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrav_r_qh.c => system/ase/dsp/test_64_dsp_r1_shrav_r_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrav_r_w.c => system/ase/dsp/test_64_dsp_r1_shrav_r_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrl_ob.c => system/ase/dsp/test_64_dsp_r1_shrl_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrl_qb.c => system/ase/dsp/test_64_dsp_r1_shrl_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrl_qh.c => system/ase/dsp/test_64_dsp_r1_shrl_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrlv_ob.c => system/ase/dsp/test_64_dsp_r1_shrlv_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrlv_qb.c => system/ase/dsp/test_64_dsp_r1_shrlv_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/shrlv_qh.c => system/ase/dsp/test_64_dsp_r1_shrlv_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subq_ph.c => system/ase/dsp/test_64_dsp_r1_subq_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subq_pw.c => system/ase/dsp/test_64_dsp_r1_subq_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subq_qh.c => system/ase/dsp/test_64_dsp_r1_subq_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subq_s_ph.c => system/ase/dsp/test_64_dsp_r1_subq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subq_s_pw.c => system/ase/dsp/test_64_dsp_r1_subq_s_pw.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subq_s_qh.c => system/ase/dsp/test_64_dsp_r1_subq_s_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subq_s_w.c => system/ase/dsp/test_64_dsp_r1_subq_s_w.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subu_ob.c => system/ase/dsp/test_64_dsp_r1_subu_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subu_qb.c => system/ase/dsp/test_64_dsp_r1_subu_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subu_s_ob.c => system/ase/dsp/test_64_dsp_r1_subu_s_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/subu_s_qb.c => system/ase/dsp/test_64_dsp_r1_subu_s_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/wrdsp.c => system/ase/dsp/test_64_dsp_r1_wrdsp.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/absq_s_qb.c => system/ase/dsp/test_64_dsp_r2_absq_s_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/addqh_ph.c => system/ase/dsp/test_64_dsp_r2_addqh_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/addqh_r_ph.c => system/ase/dsp/test_64_dsp_r2_addqh_r_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/addqh_r_w.c => system/ase/dsp/test_64_dsp_r2_addqh_r_w.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/addqh_w.c => system/ase/dsp/test_64_dsp_r2_addqh_w.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/addu_ph.c => system/ase/dsp/test_64_dsp_r2_addu_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/addu_qh.c => system/ase/dsp/test_64_dsp_r2_addu_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/addu_s_ph.c => system/ase/dsp/test_64_dsp_r2_addu_s_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/addu_s_qh.c => system/ase/dsp/test_64_dsp_r2_addu_s_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/adduh_ob.c => system/ase/dsp/test_64_dsp_r2_adduh_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/adduh_qb.c => system/ase/dsp/test_64_dsp_r2_adduh_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/adduh_r_ob.c => system/ase/dsp/test_64_dsp_r2_adduh_r_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/adduh_r_qb.c => system/ase/dsp/test_64_dsp_r2_adduh_r_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/append.c => system/ase/dsp/test_64_dsp_r2_append.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/balign.c => system/ase/dsp/test_64_dsp_r2_balign.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/cmpgdu_eq_ob.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_eq_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/cmpgdu_eq_qb.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_eq_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/cmpgdu_le_ob.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_le_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/cmpgdu_le_qb.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_le_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/cmpgdu_lt_ob.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_lt_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/cmpgdu_lt_qb.c => system/ase/dsp/test_64_dsp_r2_cmpgdu_lt_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dbalign.c => system/ase/dsp/test_64_dsp_r2_dbalign.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dpa_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dpa_w_qh.c => system/ase/dsp/test_64_dsp_r2_dpa_w_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dpaqx_s_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpaqx_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dpaqx_sa_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpaqx_sa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dpax_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpax_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dps_w_ph.c => system/ase/dsp/test_64_dsp_r2_dps_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dps_w_qh.c => system/ase/dsp/test_64_dsp_r2_dps_w_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dpsqx_s_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpsqx_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dpsqx_sa_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpsqx_sa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/dpsx_w_ph.c => system/ase/dsp/test_64_dsp_r2_dpsx_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/mul_ph.c => system/ase/dsp/test_64_dsp_r2_mul_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/mul_s_ph.c => system/ase/dsp/test_64_dsp_r2_mul_s_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/mulq_rs_w.c => system/ase/dsp/test_64_dsp_r2_mulq_rs_w.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/mulq_s_ph.c => system/ase/dsp/test_64_dsp_r2_mulq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/mulq_s_w.c => system/ase/dsp/test_64_dsp_r2_mulq_s_w.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/mulsa_w_ph.c => system/ase/dsp/test_64_dsp_r2_mulsa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/mulsaq_s_w_ph.c => system/ase/dsp/test_64_dsp_r2_mulsaq_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/precr_qb_ph.c => system/ase/dsp/test_64_dsp_r2_precr_qb_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/precr_sra_ph_w.c => system/ase/dsp/test_64_dsp_r2_precr_sra_ph_w.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/precr_sra_r_ph_w.c => system/ase/dsp/test_64_dsp_r2_precr_sra_r_ph_w.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/prepend.c => system/ase/dsp/test_64_dsp_r2_prepend.c} (100%)
 rename tests/tcg/mips/{mips64-dsp/printf.c => system/ase/dsp/test_64_dsp_r2_printf.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/shra_qb.c => system/ase/dsp/test_64_dsp_r2_shra_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/shra_r_qb.c => system/ase/dsp/test_64_dsp_r2_shra_r_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/shrav_ob.c => system/ase/dsp/test_64_dsp_r2_shrav_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/shrav_qb.c => system/ase/dsp/test_64_dsp_r2_shrav_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/shrav_r_ob.c => system/ase/dsp/test_64_dsp_r2_shrav_r_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/shrav_r_qb.c => system/ase/dsp/test_64_dsp_r2_shrav_r_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/shrl_ph.c => system/ase/dsp/test_64_dsp_r2_shrl_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/shrlv_ph.c => system/ase/dsp/test_64_dsp_r2_shrlv_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subqh_ph.c => system/ase/dsp/test_64_dsp_r2_subqh_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subqh_r_ph.c => system/ase/dsp/test_64_dsp_r2_subqh_r_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subqh_r_w.c => system/ase/dsp/test_64_dsp_r2_subqh_r_w.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subqh_w.c => system/ase/dsp/test_64_dsp_r2_subqh_w.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subu_ph.c => system/ase/dsp/test_64_dsp_r2_subu_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subu_qh.c => system/ase/dsp/test_64_dsp_r2_subu_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subu_s_ph.c => system/ase/dsp/test_64_dsp_r2_subu_s_ph.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subu_s_qh.c => system/ase/dsp/test_64_dsp_r2_subu_s_qh.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subuh_ob.c => system/ase/dsp/test_64_dsp_r2_subuh_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subuh_qb.c => system/ase/dsp/test_64_dsp_r2_subuh_qb.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subuh_r_ob.c => system/ase/dsp/test_64_dsp_r2_subuh_r_ob.c} (100%)
 rename tests/tcg/mips/{mips64-dspr2/subuh_r_qb.c => system/ase/dsp/test_64_dsp_r2_subuh_r_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/absq_s_ph.c => user/ase/dsp/test_32_dsp_r1_absq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/absq_s_w.c => user/ase/dsp/test_32_dsp_r1_absq_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addq_ph.c => user/ase/dsp/test_32_dsp_r1_addq_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addq_s_ph.c => user/ase/dsp/test_32_dsp_r1_addq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addq_s_w.c => user/ase/dsp/test_32_dsp_r1_addq_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addsc.c => user/ase/dsp/test_32_dsp_r1_addsc.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addu_qb.c => user/ase/dsp/test_32_dsp_r1_addu_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addu_s_qb.c => user/ase/dsp/test_32_dsp_r1_addu_s_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/addwc.c => user/ase/dsp/test_32_dsp_r1_addwc.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/bitrev.c => user/ase/dsp/test_32_dsp_r1_bitrev.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/bposge32.c => user/ase/dsp/test_32_dsp_r1_bposge32.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmp_eq_ph.c => user/ase/dsp/test_32_dsp_r1_cmp_eq_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmp_le_ph.c => user/ase/dsp/test_32_dsp_r1_cmp_le_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmp_lt_ph.c => user/ase/dsp/test_32_dsp_r1_cmp_lt_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpgu_eq_qb.c => user/ase/dsp/test_32_dsp_r1_cmpgu_eq_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpgu_le_qb.c => user/ase/dsp/test_32_dsp_r1_cmpgu_le_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpgu_lt_qb.c => user/ase/dsp/test_32_dsp_r1_cmpgu_lt_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpu_eq_qb.c => user/ase/dsp/test_32_dsp_r1_cmpu_eq_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpu_le_qb.c => user/ase/dsp/test_32_dsp_r1_cmpu_le_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/cmpu_lt_qb.c => user/ase/dsp/test_32_dsp_r1_cmpu_lt_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpaq_s_w_ph.c => user/ase/dsp/test_32_dsp_r1_dpaq_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpaq_sa_l_w.c => user/ase/dsp/test_32_dsp_r1_dpaq_sa_l_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpau_h_qbl.c => user/ase/dsp/test_32_dsp_r1_dpau_h_qbl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpau_h_qbr.c => user/ase/dsp/test_32_dsp_r1_dpau_h_qbr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpsq_s_w_ph.c => user/ase/dsp/test_32_dsp_r1_dpsq_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpsq_sa_l_w.c => user/ase/dsp/test_32_dsp_r1_dpsq_sa_l_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpsu_h_qbl.c => user/ase/dsp/test_32_dsp_r1_dpsu_h_qbl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/dpsu_h_qbr.c => user/ase/dsp/test_32_dsp_r1_dpsu_h_qbr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extp.c => user/ase/dsp/test_32_dsp_r1_extp.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extpdp.c => user/ase/dsp/test_32_dsp_r1_extpdp.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extpdpv.c => user/ase/dsp/test_32_dsp_r1_extpdpv.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extpv.c => user/ase/dsp/test_32_dsp_r1_extpv.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extr_r_w.c => user/ase/dsp/test_32_dsp_r1_extr_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extr_rs_w.c => user/ase/dsp/test_32_dsp_r1_extr_rs_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extr_s_h.c => user/ase/dsp/test_32_dsp_r1_extr_s_h.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extr_w.c => user/ase/dsp/test_32_dsp_r1_extr_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extrv_r_w.c => user/ase/dsp/test_32_dsp_r1_extrv_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extrv_rs_w.c => user/ase/dsp/test_32_dsp_r1_extrv_rs_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extrv_s_h.c => user/ase/dsp/test_32_dsp_r1_extrv_s_h.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/extrv_w.c => user/ase/dsp/test_32_dsp_r1_extrv_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/insv.c => user/ase/dsp/test_32_dsp_r1_insv.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/lbux.c => user/ase/dsp/test_32_dsp_r1_lbux.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/lhx.c => user/ase/dsp/test_32_dsp_r1_lhx.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/lwx.c => user/ase/dsp/test_32_dsp_r1_lwx.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/maddu.c => user/ase/dsp/test_32_dsp_r1_madd.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/madd.c => user/ase/dsp/test_32_dsp_r1_maddu.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/main.c => user/ase/dsp/test_32_dsp_r1_main.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/maq_s_w_phl.c => user/ase/dsp/test_32_dsp_r1_maq_s_w_phl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/maq_s_w_phr.c => user/ase/dsp/test_32_dsp_r1_maq_s_w_phr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/maq_sa_w_phl.c => user/ase/dsp/test_32_dsp_r1_maq_sa_w_phl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/maq_sa_w_phr.c => user/ase/dsp/test_32_dsp_r1_maq_sa_w_phr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mthi.c => user/ase/dsp/test_32_dsp_r1_mfhi.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mtlo.c => user/ase/dsp/test_32_dsp_r1_mflo.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/modsub.c => user/ase/dsp/test_32_dsp_r1_modsub.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/msub.c => user/ase/dsp/test_32_dsp_r1_msub.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/msubu.c => user/ase/dsp/test_32_dsp_r1_msubu.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mfhi.c => user/ase/dsp/test_32_dsp_r1_mthi.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mthlip.c => user/ase/dsp/test_32_dsp_r1_mthlip.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mflo.c => user/ase/dsp/test_32_dsp_r1_mtlo.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/muleq_s_w_phl.c => user/ase/dsp/test_32_dsp_r1_muleq_s_w_phl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/muleq_s_w_phr.c => user/ase/dsp/test_32_dsp_r1_muleq_s_w_phr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/muleu_s_ph_qbl.c => user/ase/dsp/test_32_dsp_r1_muleu_s_ph_qbl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/muleu_s_ph_qbr.c => user/ase/dsp/test_32_dsp_r1_muleu_s_ph_qbr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mulq_rs_ph.c => user/ase/dsp/test_32_dsp_r1_mulq_rs_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/mult.c => user/ase/dsp/test_32_dsp_r1_mult.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/multu.c => user/ase/dsp/test_32_dsp_r1_multu.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/packrl_ph.c => user/ase/dsp/test_32_dsp_r1_packrl_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/pick_ph.c => user/ase/dsp/test_32_dsp_r1_pick_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/pick_qb.c => user/ase/dsp/test_32_dsp_r1_pick_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceq_w_phl.c => user/ase/dsp/test_32_dsp_r1_preceq_w_phl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceq_w_phr.c => user/ase/dsp/test_32_dsp_r1_preceq_w_phr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precequ_ph_qbl.c => user/ase/dsp/test_32_dsp_r1_precequ_ph_qbl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precequ_ph_qbla.c => user/ase/dsp/test_32_dsp_r1_precequ_ph_qbla.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precequ_ph_qbr.c => user/ase/dsp/test_32_dsp_r1_precequ_ph_qbr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precequ_ph_qbra.c => user/ase/dsp/test_32_dsp_r1_precequ_ph_qbra.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceu_ph_qbl.c => user/ase/dsp/test_32_dsp_r1_preceu_ph_qbl.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceu_ph_qbla.c => user/ase/dsp/test_32_dsp_r1_preceu_ph_qbla.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceu_ph_qbr.c => user/ase/dsp/test_32_dsp_r1_preceu_ph_qbr.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/preceu_ph_qbra.c => user/ase/dsp/test_32_dsp_r1_preceu_ph_qbra.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precrq_ph_w.c => user/ase/dsp/test_32_dsp_r1_precrq_ph_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precrq_qb_ph.c => user/ase/dsp/test_32_dsp_r1_precrq_qb_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precrq_rs_ph_w.c => user/ase/dsp/test_32_dsp_r1_precrq_rs_ph_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/precrqu_s_qb_ph.c => user/ase/dsp/test_32_dsp_r1_precrqu_s_qb_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/raddu_w_qb.c => user/ase/dsp/test_32_dsp_r1_raddu_w_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/rddsp.c => user/ase/dsp/test_32_dsp_r1_rddsp.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/repl_ph.c => user/ase/dsp/test_32_dsp_r1_repl_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/repl_qb.c => user/ase/dsp/test_32_dsp_r1_repl_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/replv_ph.c => user/ase/dsp/test_32_dsp_r1_replv_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/replv_qb.c => user/ase/dsp/test_32_dsp_r1_replv_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shilo.c => user/ase/dsp/test_32_dsp_r1_shilo.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shilov.c => user/ase/dsp/test_32_dsp_r1_shilov.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shll_ph.c => user/ase/dsp/test_32_dsp_r1_shll_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shll_qb.c => user/ase/dsp/test_32_dsp_r1_shll_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shll_s_ph.c => user/ase/dsp/test_32_dsp_r1_shll_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shll_s_w.c => user/ase/dsp/test_32_dsp_r1_shll_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shllv_ph.c => user/ase/dsp/test_32_dsp_r1_shllv_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shllv_qb.c => user/ase/dsp/test_32_dsp_r1_shllv_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shllv_s_ph.c => user/ase/dsp/test_32_dsp_r1_shllv_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shllv_s_w.c => user/ase/dsp/test_32_dsp_r1_shllv_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shra_ph.c => user/ase/dsp/test_32_dsp_r1_shra_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shra_r_ph.c => user/ase/dsp/test_32_dsp_r1_shra_r_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shra_r_w.c => user/ase/dsp/test_32_dsp_r1_shra_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shrav_ph.c => user/ase/dsp/test_32_dsp_r1_shrav_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shrav_r_ph.c => user/ase/dsp/test_32_dsp_r1_shrav_r_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shrav_r_w.c => user/ase/dsp/test_32_dsp_r1_shrav_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shrl_qb.c => user/ase/dsp/test_32_dsp_r1_shrl_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/shrlv_qb.c => user/ase/dsp/test_32_dsp_r1_shrlv_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/subq_ph.c => user/ase/dsp/test_32_dsp_r1_subq_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/subq_s_ph.c => user/ase/dsp/test_32_dsp_r1_subq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/subq_s_w.c => user/ase/dsp/test_32_dsp_r1_subq_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/subu_qb.c => user/ase/dsp/test_32_dsp_r1_subu_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/subu_s_qb.c => user/ase/dsp/test_32_dsp_r1_subu_s_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dsp/wrdsp.c => user/ase/dsp/test_32_dsp_r1_wrdsp.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/absq_s_qb.c => user/ase/dsp/test_32_dsp_r2_absq_s_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addqh_ph.c => user/ase/dsp/test_32_dsp_r2_addqh_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addqh_r_ph.c => user/ase/dsp/test_32_dsp_r2_addqh_r_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addqh_r_w.c => user/ase/dsp/test_32_dsp_r2_addqh_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addqh_w.c => user/ase/dsp/test_32_dsp_r2_addqh_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addu_ph.c => user/ase/dsp/test_32_dsp_r2_addu_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/addu_s_ph.c => user/ase/dsp/test_32_dsp_r2_addu_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/adduh_qb.c => user/ase/dsp/test_32_dsp_r2_adduh_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/adduh_r_qb.c => user/ase/dsp/test_32_dsp_r2_adduh_r_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/append.c => user/ase/dsp/test_32_dsp_r2_append.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/balign.c => user/ase/dsp/test_32_dsp_r2_balign.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/cmpgdu_eq_qb.c => user/ase/dsp/test_32_dsp_r2_cmpgdu_eq_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/cmpgdu_le_qb.c => user/ase/dsp/test_32_dsp_r2_cmpgdu_le_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/cmpgdu_lt_qb.c => user/ase/dsp/test_32_dsp_r2_cmpgdu_lt_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpa_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpaqx_s_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpaqx_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpaqx_sa_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpaqx_sa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpax_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpax_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dps_w_ph.c => user/ase/dsp/test_32_dsp_r2_dps_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpsqx_s_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpsqx_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpsqx_sa_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpsqx_sa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/dpsx_w_ph.c => user/ase/dsp/test_32_dsp_r2_dpsx_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mul_ph.c => user/ase/dsp/test_32_dsp_r2_mul_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mul_s_ph.c => user/ase/dsp/test_32_dsp_r2_mul_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mulq_rs_w.c => user/ase/dsp/test_32_dsp_r2_mulq_rs_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mulq_s_ph.c => user/ase/dsp/test_32_dsp_r2_mulq_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mulq_s_w.c => user/ase/dsp/test_32_dsp_r2_mulq_s_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mulsa_w_ph.c => user/ase/dsp/test_32_dsp_r2_mulsa_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/mulsaq_s_w_ph.c => user/ase/dsp/test_32_dsp_r2_mulsaq_s_w_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/precr_qb_ph.c => user/ase/dsp/test_32_dsp_r2_precr_qb_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/precr_sra_ph_w.c => user/ase/dsp/test_32_dsp_r2_precr_sra_ph_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/precr_sra_r_ph_w.c => user/ase/dsp/test_32_dsp_r2_precr_sra_r_ph_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/prepend.c => user/ase/dsp/test_32_dsp_r2_prepend.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shra_qb.c => user/ase/dsp/test_32_dsp_r2_shra_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shra_r_qb.c => user/ase/dsp/test_32_dsp_r2_shra_r_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shrav_qb.c => user/ase/dsp/test_32_dsp_r2_shrav_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shrav_r_qb.c => user/ase/dsp/test_32_dsp_r2_shrav_r_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shrl_ph.c => user/ase/dsp/test_32_dsp_r2_shrl_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/shrlv_ph.c => user/ase/dsp/test_32_dsp_r2_shrlv_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subqh_ph.c => user/ase/dsp/test_32_dsp_r2_subqh_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subqh_r_ph.c => user/ase/dsp/test_32_dsp_r2_subqh_r_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subqh_r_w.c => user/ase/dsp/test_32_dsp_r2_subqh_r_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subqh_w.c => user/ase/dsp/test_32_dsp_r2_subqh_w.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subu_ph.c => user/ase/dsp/test_32_dsp_r2_subu_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subu_s_ph.c => user/ase/dsp/test_32_dsp_r2_subu_s_ph.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subuh_qb.c => user/ase/dsp/test_32_dsp_r2_subuh_qb.c} (100%)
 rename tests/tcg/mips/{mips32-dspr2/subuh_r_qb.c => user/ase/dsp/test_32_dsp_r2_subuh_r_qb.c} (100%)
 rename tests/tcg/mips/{mipsr5900/div1.c => user/isa/r5900/test_r5900_div1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/divu1.c => user/isa/r5900/test_r5900_divu1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/madd.c => user/isa/r5900/test_r5900_madd.c} (100%)
 rename tests/tcg/mips/{mipsr5900/maddu.c => user/isa/r5900/test_r5900_maddu.c} (100%)
 rename tests/tcg/mips/{mipsr5900/mflohi1.c => user/isa/r5900/test_r5900_mflohi1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/mtlohi1.c => user/isa/r5900/test_r5900_mtlohi1.c} (100%)
 rename tests/tcg/mips/{mipsr5900/mult.c => user/isa/r5900/test_r5900_mult.c} (100%)
 rename tests/tcg/mips/{mipsr5900/multu.c => user/isa/r5900/test_r5900_multu.c} (100%)

diff --git a/tests/tcg/mips/mips64-dsp/absq_s_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_absq_s_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/absq_s_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_absq_s_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/absq_s_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_absq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/absq_s_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_absq_s_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/absq_s_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_absq_s_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/absq_s_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_absq_s_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/absq_s_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_absq_s_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/absq_s_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_absq_s_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/absq_s_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_absq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/absq_s_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_absq_s_w.c
diff --git a/tests/tcg/mips/mips64-dsp/addq_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addq_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/addq_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addq_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/addq_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addq_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/addq_s_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addq_s_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_s_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/addq_s_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_s_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addq_s_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_s_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/addq_s_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_s_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addq_s_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_s_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/addq_s_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addq_s_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addq_s_w.c
diff --git a/tests/tcg/mips/mips64-dsp/addsc.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addsc.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addsc.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addsc.c
diff --git a/tests/tcg/mips/mips64-dsp/addu_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addu_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addu_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addu_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/addu_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addu_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addu_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addu_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/addu_s_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addu_s_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addu_s_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addu_s_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/addu_s_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addu_s_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addu_s_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addu_s_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/addwc.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addwc.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/addwc.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_addwc.c
diff --git a/tests/tcg/mips/mips64-dsp/bitrev.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_bitrev.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/bitrev.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_bitrev.c
diff --git a/tests/tcg/mips/mips64-dsp/bposge32.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_bposge32.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/bposge32.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_bposge32.c
diff --git a/tests/tcg/mips/mips64-dsp/bposge64.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_bposge64.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/bposge64.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_bposge64.c
diff --git a/tests/tcg/mips/mips64-dsp/cmp_eq_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_eq_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmp_eq_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_eq_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/cmp_eq_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_eq_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmp_eq_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_eq_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/cmp_eq_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_eq_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmp_eq_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_eq_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/cmp_le_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_le_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmp_le_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_le_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/cmp_le_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_le_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmp_le_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_le_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/cmp_le_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_le_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmp_le_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_le_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/cmp_lt_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_lt_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmp_lt_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_lt_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/cmp_lt_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_lt_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmp_lt_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_lt_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/cmp_lt_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_lt_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmp_lt_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmp_lt_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_eq_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_eq_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpgu_eq_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_eq_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_eq_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpgu_eq_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_eq_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_le_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_le_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpgu_le_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_le_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_le_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpgu_le_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_le_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_lt_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_lt_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpgu_lt_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_lt_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpgu_lt_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpgu_lt_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpgu_lt_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_eq_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_eq_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpu_eq_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_eq_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_eq_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpu_eq_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_eq_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_le_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_le_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpu_le_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_le_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_le_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpu_le_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_le_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_lt_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_lt_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpu_lt_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_lt_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/cmpu_lt_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/cmpu_lt_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_cmpu_lt_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/dappend.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dappend.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dappend.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dappend.c
diff --git a/tests/tcg/mips/mips64-dsp/dextp.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextp.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextp.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextp.c
diff --git a/tests/tcg/mips/mips64-dsp/dextpdp.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextpdp.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextpdp.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextpdp.c
diff --git a/tests/tcg/mips/mips64-dsp/dextpdpv.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextpdpv.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextpdpv.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextpdpv.c
diff --git a/tests/tcg/mips/mips64-dsp/dextpv.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextpv.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextpv.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextpv.c
diff --git a/tests/tcg/mips/mips64-dsp/dextr_l.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_l.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextr_l.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_l.c
diff --git a/tests/tcg/mips/mips64-dsp/dextr_r_l.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_r_l.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextr_r_l.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_r_l.c
diff --git a/tests/tcg/mips/mips64-dsp/dextr_r_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextr_r_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_r_w.c
diff --git a/tests/tcg/mips/mips64-dsp/dextr_rs_l.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_rs_l.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextr_rs_l.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_rs_l.c
diff --git a/tests/tcg/mips/mips64-dsp/dextr_rs_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextr_rs_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_rs_w.c
diff --git a/tests/tcg/mips/mips64-dsp/dextr_s_h.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_s_h.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextr_s_h.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_s_h.c
diff --git a/tests/tcg/mips/mips64-dsp/dextr_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextr_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextr_w.c
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_l.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_l.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextrv_l.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_l.c
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_r_l.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_r_l.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextrv_r_l.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_r_l.c
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_r_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextrv_r_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_r_w.c
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_rs_l.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_rs_l.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextrv_rs_l.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_rs_l.c
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_rs_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextrv_rs_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_rs_w.c
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_s_h.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_s_h.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextrv_s_h.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_s_h.c
diff --git a/tests/tcg/mips/mips64-dsp/dextrv_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dextrv_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dextrv_w.c
diff --git a/tests/tcg/mips/mips64-dsp/dinsv.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dinsv.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dinsv.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dinsv.c
diff --git a/tests/tcg/mips/mips64-dsp/dmadd.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dmadd.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dmadd.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dmadd.c
diff --git a/tests/tcg/mips/mips64-dsp/dmaddu.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dmaddu.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dmaddu.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dmaddu.c
diff --git a/tests/tcg/mips/mips64-dsp/dmsub.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dmsub.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dmsub.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dmsub.c
diff --git a/tests/tcg/mips/mips64-dsp/dmsubu.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dmsubu.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dmsubu.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dmsubu.c
diff --git a/tests/tcg/mips/mips64-dsp/dmthlip.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dmthlip.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dmthlip.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dmthlip.c
diff --git a/tests/tcg/mips/mips64-dsp/dpaq_s_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpaq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpaq_s_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpaq_s_w_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/dpaq_s_w_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpaq_s_w_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpaq_s_w_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpaq_s_w_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/dpaq_sa_l_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpaq_sa_l_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpaq_sa_l_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpaq_sa_l_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/dpaq_sa_l_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpaq_sa_l_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpaq_sa_l_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpaq_sa_l_w.c
diff --git a/tests/tcg/mips/mips64-dsp/dpau_h_obl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpau_h_obl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpau_h_obl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpau_h_obl.c
diff --git a/tests/tcg/mips/mips64-dsp/dpau_h_obr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpau_h_obr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpau_h_obr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpau_h_obr.c
diff --git a/tests/tcg/mips/mips64-dsp/dpau_h_qbl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpau_h_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpau_h_qbl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpau_h_qbl.c
diff --git a/tests/tcg/mips/mips64-dsp/dpau_h_qbr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpau_h_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpau_h_qbr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpau_h_qbr.c
diff --git a/tests/tcg/mips/mips64-dsp/dpsq_s_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpsq_s_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsq_s_w_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/dpsq_s_w_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsq_s_w_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpsq_s_w_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsq_s_w_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/dpsq_sa_l_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsq_sa_l_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpsq_sa_l_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsq_sa_l_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/dpsq_sa_l_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsq_sa_l_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpsq_sa_l_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsq_sa_l_w.c
diff --git a/tests/tcg/mips/mips64-dsp/dpsu_h_obl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsu_h_obl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpsu_h_obl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsu_h_obl.c
diff --git a/tests/tcg/mips/mips64-dsp/dpsu_h_obr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsu_h_obr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpsu_h_obr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsu_h_obr.c
diff --git a/tests/tcg/mips/mips64-dsp/dpsu_h_qbl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsu_h_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpsu_h_qbl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsu_h_qbl.c
diff --git a/tests/tcg/mips/mips64-dsp/dpsu_h_qbr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsu_h_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dpsu_h_qbr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dpsu_h_qbr.c
diff --git a/tests/tcg/mips/mips64-dsp/dshilo.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dshilo.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dshilo.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dshilo.c
diff --git a/tests/tcg/mips/mips64-dsp/dshilov.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dshilov.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/dshilov.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_dshilov.c
diff --git a/tests/tcg/mips/mips64-dsp/extp.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extp.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extp.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extp.c
diff --git a/tests/tcg/mips/mips64-dsp/extpdp.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extpdp.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extpdp.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extpdp.c
diff --git a/tests/tcg/mips/mips64-dsp/extpdpv.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extpdpv.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extpdpv.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extpdpv.c
diff --git a/tests/tcg/mips/mips64-dsp/extpv.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extpv.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extpv.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extpv.c
diff --git a/tests/tcg/mips/mips64-dsp/extr_r_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extr_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extr_r_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extr_r_w.c
diff --git a/tests/tcg/mips/mips64-dsp/extr_rs_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extr_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extr_rs_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extr_rs_w.c
diff --git a/tests/tcg/mips/mips64-dsp/extr_s_h.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extr_s_h.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extr_s_h.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extr_s_h.c
diff --git a/tests/tcg/mips/mips64-dsp/extr_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extr_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extr_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extr_w.c
diff --git a/tests/tcg/mips/mips64-dsp/extrv_r_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extrv_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extrv_r_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extrv_r_w.c
diff --git a/tests/tcg/mips/mips64-dsp/extrv_rs_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extrv_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extrv_rs_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extrv_rs_w.c
diff --git a/tests/tcg/mips/mips64-dsp/extrv_s_h.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extrv_s_h.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extrv_s_h.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extrv_s_h.c
diff --git a/tests/tcg/mips/mips64-dsp/extrv_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extrv_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/extrv_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_extrv_w.c
diff --git a/tests/tcg/mips/mips64-dsp/insv.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_insv.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/insv.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_insv.c
diff --git a/tests/tcg/mips/mips64-dsp/lbux.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_lbux.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/lbux.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_lbux.c
diff --git a/tests/tcg/mips/mips64-dsp/ldx.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_ldx.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/ldx.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_ldx.c
diff --git a/tests/tcg/mips/mips64-dsp/lhx.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_lhx.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/lhx.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_lhx.c
diff --git a/tests/tcg/mips/mips64-dsp/lwx.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_lwx.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/lwx.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_lwx.c
diff --git a/tests/tcg/mips/mips64-dsp/madd.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_madd.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/madd.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_madd.c
diff --git a/tests/tcg/mips/mips64-dsp/maddu.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maddu.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maddu.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maddu.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_l_pwl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_l_pwl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_s_l_pwl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_l_pwl.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_l_pwr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_l_pwr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_s_l_pwr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_l_pwr.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_phl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_s_w_phl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_phl.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_phr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_s_w_phr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_phr.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_qhll.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_qhll.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_s_w_qhll.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_qhll.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_qhlr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_qhlr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_s_w_qhlr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_qhlr.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_qhrl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_qhrl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_s_w_qhrl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_qhrl.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_s_w_qhrr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_qhrr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_s_w_qhrr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_s_w_qhrr.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_phl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_sa_w_phl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_phl.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_phr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_sa_w_phr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_phr.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhll.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhll.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_sa_w_qhll.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhll.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhlr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhlr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_sa_w_qhlr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhlr.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhrl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhrl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_sa_w_qhrl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhrl.c
diff --git a/tests/tcg/mips/mips64-dsp/maq_sa_w_qhrr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhrr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/maq_sa_w_qhrr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_maq_sa_w_qhrr.c
diff --git a/tests/tcg/mips/mips64-dsp/mfhi.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mfhi.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/mfhi.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mfhi.c
diff --git a/tests/tcg/mips/mips64-dsp/mflo.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mflo.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/mflo.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mflo.c
diff --git a/tests/tcg/mips/mips64-dsp/modsub.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_modsub.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/modsub.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_modsub.c
diff --git a/tests/tcg/mips/mips64-dsp/msub.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_msub.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/msub.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_msub.c
diff --git a/tests/tcg/mips/mips64-dsp/msubu.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_msubu.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/msubu.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_msubu.c
diff --git a/tests/tcg/mips/mips64-dsp/mthi.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mthi.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/mthi.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mthi.c
diff --git a/tests/tcg/mips/mips64-dsp/mthlip.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mthlip.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/mthlip.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mthlip.c
diff --git a/tests/tcg/mips/mips64-dsp/mtlo.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mtlo.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/mtlo.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mtlo.c
diff --git a/tests/tcg/mips/mips64-dsp/muleq_s_pw_qhl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleq_s_pw_qhl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/muleq_s_pw_qhl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleq_s_pw_qhl.c
diff --git a/tests/tcg/mips/mips64-dsp/muleq_s_pw_qhr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleq_s_pw_qhr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/muleq_s_pw_qhr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleq_s_pw_qhr.c
diff --git a/tests/tcg/mips/mips64-dsp/muleq_s_w_phl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleq_s_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/muleq_s_w_phl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleq_s_w_phl.c
diff --git a/tests/tcg/mips/mips64-dsp/muleq_s_w_phr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleq_s_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/muleq_s_w_phr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleq_s_w_phr.c
diff --git a/tests/tcg/mips/mips64-dsp/muleu_s_ph_qbl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleu_s_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/muleu_s_ph_qbl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleu_s_ph_qbl.c
diff --git a/tests/tcg/mips/mips64-dsp/muleu_s_ph_qbr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleu_s_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/muleu_s_ph_qbr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleu_s_ph_qbr.c
diff --git a/tests/tcg/mips/mips64-dsp/muleu_s_qh_obl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleu_s_qh_obl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/muleu_s_qh_obl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleu_s_qh_obl.c
diff --git a/tests/tcg/mips/mips64-dsp/muleu_s_qh_obr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleu_s_qh_obr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/muleu_s_qh_obr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_muleu_s_qh_obr.c
diff --git a/tests/tcg/mips/mips64-dsp/mulq_rs_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mulq_rs_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/mulq_rs_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mulq_rs_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/mulq_rs_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mulq_rs_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/mulq_rs_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mulq_rs_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/mulsaq_s_l_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mulsaq_s_l_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/mulsaq_s_l_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mulsaq_s_l_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/mulsaq_s_w_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mulsaq_s_w_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/mulsaq_s_w_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mulsaq_s_w_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/mult.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mult.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/mult.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_mult.c
diff --git a/tests/tcg/mips/mips64-dsp/multu.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_multu.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/multu.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_multu.c
diff --git a/tests/tcg/mips/mips64-dsp/packrl_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_packrl_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/packrl_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_packrl_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/packrl_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_packrl_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/packrl_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_packrl_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/pick_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_pick_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/pick_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_pick_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/pick_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_pick_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/pick_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_pick_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/pick_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_pick_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/pick_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_pick_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/pick_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_pick_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/pick_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_pick_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/pick_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_pick_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/pick_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_pick_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/preceq_l_pwl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_l_pwl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceq_l_pwl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_l_pwl.c
diff --git a/tests/tcg/mips/mips64-dsp/preceq_l_pwr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_l_pwr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceq_l_pwr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_l_pwr.c
diff --git a/tests/tcg/mips/mips64-dsp/preceq_pw_qhl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_pw_qhl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceq_pw_qhl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_pw_qhl.c
diff --git a/tests/tcg/mips/mips64-dsp/preceq_pw_qhla.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_pw_qhla.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceq_pw_qhla.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_pw_qhla.c
diff --git a/tests/tcg/mips/mips64-dsp/preceq_pw_qhr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_pw_qhr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceq_pw_qhr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_pw_qhr.c
diff --git a/tests/tcg/mips/mips64-dsp/preceq_pw_qhra.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_pw_qhra.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceq_pw_qhra.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_pw_qhra.c
diff --git a/tests/tcg/mips/mips64-dsp/preceq_w_phl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceq_w_phl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_w_phl.c
diff --git a/tests/tcg/mips/mips64-dsp/preceq_w_phr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceq_w_phr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceq_w_phr.c
diff --git a/tests/tcg/mips/mips64-dsp/precequ_ph_qbl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precequ_ph_qbl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_ph_qbl.c
diff --git a/tests/tcg/mips/mips64-dsp/precequ_ph_qbla.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_ph_qbla.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precequ_ph_qbla.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_ph_qbla.c
diff --git a/tests/tcg/mips/mips64-dsp/precequ_ph_qbr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precequ_ph_qbr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_ph_qbr.c
diff --git a/tests/tcg/mips/mips64-dsp/precequ_ph_qbra.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_ph_qbra.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precequ_ph_qbra.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_ph_qbra.c
diff --git a/tests/tcg/mips/mips64-dsp/precequ_qh_obl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_qh_obl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precequ_qh_obl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_qh_obl.c
diff --git a/tests/tcg/mips/mips64-dsp/precequ_qh_obla.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_qh_obla.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precequ_qh_obla.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_qh_obla.c
diff --git a/tests/tcg/mips/mips64-dsp/precequ_qh_obr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_qh_obr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precequ_qh_obr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_qh_obr.c
diff --git a/tests/tcg/mips/mips64-dsp/precequ_qh_obra.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_qh_obra.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precequ_qh_obra.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precequ_qh_obra.c
diff --git a/tests/tcg/mips/mips64-dsp/preceu_ph_qbl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceu_ph_qbl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_ph_qbl.c
diff --git a/tests/tcg/mips/mips64-dsp/preceu_ph_qbla.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_ph_qbla.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceu_ph_qbla.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_ph_qbla.c
diff --git a/tests/tcg/mips/mips64-dsp/preceu_ph_qbr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceu_ph_qbr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_ph_qbr.c
diff --git a/tests/tcg/mips/mips64-dsp/preceu_ph_qbra.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_ph_qbra.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceu_ph_qbra.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_ph_qbra.c
diff --git a/tests/tcg/mips/mips64-dsp/preceu_qh_obl.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_qh_obl.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceu_qh_obl.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_qh_obl.c
diff --git a/tests/tcg/mips/mips64-dsp/preceu_qh_obla.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_qh_obla.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceu_qh_obla.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_qh_obla.c
diff --git a/tests/tcg/mips/mips64-dsp/preceu_qh_obr.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_qh_obr.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceu_qh_obr.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_qh_obr.c
diff --git a/tests/tcg/mips/mips64-dsp/preceu_qh_obra.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_qh_obra.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/preceu_qh_obra.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_preceu_qh_obra.c
diff --git a/tests/tcg/mips/mips64-dsp/precr_ob_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precr_ob_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precr_ob_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precr_ob_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/precr_sra_qh_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precr_sra_qh_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precr_sra_qh_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precr_sra_qh_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/precr_sra_r_qh_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precr_sra_r_qh_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precr_sra_r_qh_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precr_sra_r_qh_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/precrq_ob_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_ob_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precrq_ob_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_ob_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/precrq_ph_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precrq_ph_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_ph_w.c
diff --git a/tests/tcg/mips/mips64-dsp/precrq_pw_l.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_pw_l.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precrq_pw_l.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_pw_l.c
diff --git a/tests/tcg/mips/mips64-dsp/precrq_qb_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precrq_qb_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_qb_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/precrq_qh_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_qh_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precrq_qh_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_qh_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/precrq_rs_ph_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_rs_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precrq_rs_ph_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_rs_ph_w.c
diff --git a/tests/tcg/mips/mips64-dsp/precrq_rs_qh_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_rs_qh_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precrq_rs_qh_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrq_rs_qh_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/precrqu_s_ob_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrqu_s_ob_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precrqu_s_ob_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrqu_s_ob_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/precrqu_s_qb_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrqu_s_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/precrqu_s_qb_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_precrqu_s_qb_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/prependd.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_prependd.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/prependd.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_prependd.c
diff --git a/tests/tcg/mips/mips64-dsp/prependw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_prependw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/prependw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_prependw.c
diff --git a/tests/tcg/mips/mips64-dspr2/printf.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_printf.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/printf.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_printf.c
diff --git a/tests/tcg/mips/mips64-dsp/raddu_l_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_raddu_l_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/raddu_l_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_raddu_l_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/raddu_w_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_raddu_w_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/raddu_w_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_raddu_w_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/rddsp.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_rddsp.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/rddsp.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_rddsp.c
diff --git a/tests/tcg/mips/mips64-dsp/repl_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_repl_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/repl_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_repl_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/repl_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_repl_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/repl_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_repl_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/repl_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_repl_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/repl_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_repl_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/repl_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_repl_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/repl_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_repl_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/repl_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_repl_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/repl_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_repl_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/replv_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_replv_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/replv_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_replv_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/replv_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_replv_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/replv_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_replv_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/replv_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_replv_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/replv_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_replv_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/replv_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_replv_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/replv_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_replv_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/shilo.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shilo.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shilo.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shilo.c
diff --git a/tests/tcg/mips/mips64-dsp/shilov.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shilov.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shilov.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shilov.c
diff --git a/tests/tcg/mips/mips64-dsp/shll_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shll_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/shll_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shll_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/shll_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shll_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/shll_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shll_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/shll_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shll_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/shll_s_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shll_s_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_s_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/shll_s_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_s_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shll_s_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_s_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/shll_s_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_s_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shll_s_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_s_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/shll_s_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shll_s_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shll_s_w.c
diff --git a/tests/tcg/mips/mips64-dsp/shllv_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shllv_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/shllv_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shllv_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/shllv_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shllv_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/shllv_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shllv_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/shllv_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shllv_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/shllv_s_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shllv_s_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_s_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/shllv_s_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_s_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shllv_s_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_s_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/shllv_s_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_s_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shllv_s_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_s_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/shllv_s_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shllv_s_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shllv_s_w.c
diff --git a/tests/tcg/mips/mips64-dsp/shra_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shra_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/shra_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shra_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/shra_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shra_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/shra_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shra_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/shra_r_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_r_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shra_r_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_r_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/shra_r_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shra_r_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_r_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/shra_r_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_r_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shra_r_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_r_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/shra_r_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_r_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shra_r_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_r_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/shra_r_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shra_r_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shra_r_w.c
diff --git a/tests/tcg/mips/mips64-dsp/shrav_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrav_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/shrav_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrav_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/shrav_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrav_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/shrav_r_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrav_r_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_r_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/shrav_r_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_r_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrav_r_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_r_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/shrav_r_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_r_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrav_r_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_r_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/shrav_r_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrav_r_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrav_r_w.c
diff --git a/tests/tcg/mips/mips64-dsp/shrl_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrl_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrl_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrl_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/shrl_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrl_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrl_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrl_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/shrl_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrl_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrl_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrl_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/shrlv_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrlv_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrlv_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrlv_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/shrlv_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrlv_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrlv_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrlv_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/shrlv_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrlv_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/shrlv_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_shrlv_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/subq_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subq_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/subq_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subq_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/subq_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subq_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/subq_s_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subq_s_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_s_ph.c
diff --git a/tests/tcg/mips/mips64-dsp/subq_s_pw.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_s_pw.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subq_s_pw.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_s_pw.c
diff --git a/tests/tcg/mips/mips64-dsp/subq_s_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_s_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subq_s_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_s_qh.c
diff --git a/tests/tcg/mips/mips64-dsp/subq_s_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subq_s_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subq_s_w.c
diff --git a/tests/tcg/mips/mips64-dsp/subu_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subu_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subu_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subu_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/subu_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subu_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subu_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subu_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/subu_s_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subu_s_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subu_s_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subu_s_ob.c
diff --git a/tests/tcg/mips/mips64-dsp/subu_s_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subu_s_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/subu_s_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_subu_s_qb.c
diff --git a/tests/tcg/mips/mips64-dsp/wrdsp.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_wrdsp.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/wrdsp.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r1_wrdsp.c
diff --git a/tests/tcg/mips/mips64-dspr2/absq_s_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_absq_s_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/absq_s_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_absq_s_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/addqh_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addqh_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/addqh_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addqh_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/addqh_r_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addqh_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/addqh_r_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addqh_r_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/addqh_r_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addqh_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/addqh_r_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addqh_r_w.c
diff --git a/tests/tcg/mips/mips64-dspr2/addqh_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addqh_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/addqh_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addqh_w.c
diff --git a/tests/tcg/mips/mips64-dspr2/addu_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addu_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/addu_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addu_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/addu_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addu_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/addu_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addu_qh.c
diff --git a/tests/tcg/mips/mips64-dspr2/addu_s_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addu_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/addu_s_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addu_s_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/addu_s_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addu_s_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/addu_s_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_addu_s_qh.c
diff --git a/tests/tcg/mips/mips64-dspr2/adduh_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_adduh_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/adduh_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_adduh_ob.c
diff --git a/tests/tcg/mips/mips64-dspr2/adduh_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_adduh_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/adduh_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_adduh_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/adduh_r_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_adduh_r_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/adduh_r_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_adduh_r_ob.c
diff --git a/tests/tcg/mips/mips64-dspr2/adduh_r_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_adduh_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/adduh_r_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_adduh_r_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/append.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_append.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/append.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_append.c
diff --git a/tests/tcg/mips/mips64-dspr2/balign.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_balign.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/balign.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_balign.c
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_eq_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_eq_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/cmpgdu_eq_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_eq_ob.c
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_eq_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/cmpgdu_eq_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_eq_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_le_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_le_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/cmpgdu_le_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_le_ob.c
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_le_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/cmpgdu_le_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_le_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_lt_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_lt_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/cmpgdu_lt_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_lt_ob.c
diff --git a/tests/tcg/mips/mips64-dspr2/cmpgdu_lt_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/cmpgdu_lt_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_cmpgdu_lt_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/dbalign.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dbalign.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dbalign.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dbalign.c
diff --git a/tests/tcg/mips/mips64-dspr2/dpa_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dpa_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpa_w_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/dpa_w_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpa_w_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dpa_w_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpa_w_qh.c
diff --git a/tests/tcg/mips/mips64-dspr2/dpaqx_s_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpaqx_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dpaqx_s_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpaqx_s_w_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/dpaqx_sa_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpaqx_sa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dpaqx_sa_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpaqx_sa_w_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/dpax_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpax_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dpax_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpax_w_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/dps_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dps_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dps_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dps_w_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/dps_w_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dps_w_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dps_w_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dps_w_qh.c
diff --git a/tests/tcg/mips/mips64-dspr2/dpsqx_s_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpsqx_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dpsqx_s_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpsqx_s_w_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/dpsqx_sa_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpsqx_sa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dpsqx_sa_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpsqx_sa_w_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/dpsx_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpsx_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/dpsx_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_dpsx_w_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/mul_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mul_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/mul_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mul_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/mul_s_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mul_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/mul_s_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mul_s_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/mulq_rs_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mulq_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/mulq_rs_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mulq_rs_w.c
diff --git a/tests/tcg/mips/mips64-dspr2/mulq_s_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mulq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/mulq_s_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mulq_s_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/mulq_s_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mulq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/mulq_s_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mulq_s_w.c
diff --git a/tests/tcg/mips/mips64-dspr2/mulsa_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mulsa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/mulsa_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mulsa_w_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/mulsaq_s_w_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mulsaq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/mulsaq_s_w_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_mulsaq_s_w_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/precr_qb_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_precr_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/precr_qb_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_precr_qb_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/precr_sra_ph_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_precr_sra_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/precr_sra_ph_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_precr_sra_ph_w.c
diff --git a/tests/tcg/mips/mips64-dspr2/precr_sra_r_ph_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_precr_sra_r_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/precr_sra_r_ph_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_precr_sra_r_ph_w.c
diff --git a/tests/tcg/mips/mips64-dspr2/prepend.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_prepend.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/prepend.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_prepend.c
diff --git a/tests/tcg/mips/mips64-dsp/printf.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_printf.c
similarity index 100%
rename from tests/tcg/mips/mips64-dsp/printf.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_printf.c
diff --git a/tests/tcg/mips/mips64-dspr2/shra_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shra_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/shra_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shra_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/shra_r_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shra_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/shra_r_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shra_r_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/shrav_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrav_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/shrav_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrav_ob.c
diff --git a/tests/tcg/mips/mips64-dspr2/shrav_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrav_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/shrav_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrav_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/shrav_r_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrav_r_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/shrav_r_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrav_r_ob.c
diff --git a/tests/tcg/mips/mips64-dspr2/shrav_r_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrav_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/shrav_r_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrav_r_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/shrl_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrl_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/shrl_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrl_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/shrlv_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrlv_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/shrlv_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_shrlv_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/subqh_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subqh_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subqh_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subqh_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/subqh_r_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subqh_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subqh_r_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subqh_r_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/subqh_r_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subqh_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subqh_r_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subqh_r_w.c
diff --git a/tests/tcg/mips/mips64-dspr2/subqh_w.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subqh_w.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subqh_w.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subqh_w.c
diff --git a/tests/tcg/mips/mips64-dspr2/subu_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subu_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subu_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subu_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/subu_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subu_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subu_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subu_qh.c
diff --git a/tests/tcg/mips/mips64-dspr2/subu_s_ph.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subu_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subu_s_ph.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subu_s_ph.c
diff --git a/tests/tcg/mips/mips64-dspr2/subu_s_qh.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subu_s_qh.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subu_s_qh.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subu_s_qh.c
diff --git a/tests/tcg/mips/mips64-dspr2/subuh_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subuh_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subuh_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subuh_ob.c
diff --git a/tests/tcg/mips/mips64-dspr2/subuh_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subuh_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subuh_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subuh_qb.c
diff --git a/tests/tcg/mips/mips64-dspr2/subuh_r_ob.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subuh_r_ob.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subuh_r_ob.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subuh_r_ob.c
diff --git a/tests/tcg/mips/mips64-dspr2/subuh_r_qb.c b/tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subuh_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips64-dspr2/subuh_r_qb.c
rename to tests/tcg/mips/system/ase/dsp/test_64_dsp_r2_subuh_r_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/absq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_absq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/absq_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_absq_s_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/absq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_absq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/absq_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_absq_s_w.c
diff --git a/tests/tcg/mips/mips32-dsp/addq_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addq_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addq_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addq_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/addq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addq_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addq_s_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/addq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addq_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addq_s_w.c
diff --git a/tests/tcg/mips/mips32-dsp/addsc.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addsc.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addsc.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addsc.c
diff --git a/tests/tcg/mips/mips32-dsp/addu_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addu_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addu_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addu_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/addu_s_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addu_s_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addu_s_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addu_s_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/addwc.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addwc.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/addwc.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_addwc.c
diff --git a/tests/tcg/mips/mips32-dsp/bitrev.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_bitrev.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/bitrev.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_bitrev.c
diff --git a/tests/tcg/mips/mips32-dsp/bposge32.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_bposge32.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/bposge32.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_bposge32.c
diff --git a/tests/tcg/mips/mips32-dsp/cmp_eq_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmp_eq_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmp_eq_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmp_eq_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/cmp_le_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmp_le_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmp_le_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmp_le_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/cmp_lt_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmp_lt_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmp_lt_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmp_lt_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpgu_eq_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpgu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpgu_eq_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpgu_eq_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpgu_le_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpgu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpgu_le_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpgu_le_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpgu_lt_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpgu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpgu_lt_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpgu_lt_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpu_eq_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpu_eq_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpu_eq_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpu_le_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpu_le_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpu_le_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/cmpu_lt_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/cmpu_lt_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_cmpu_lt_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/dpaq_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpaq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpaq_s_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpaq_s_w_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/dpaq_sa_l_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpaq_sa_l_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpaq_sa_l_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpaq_sa_l_w.c
diff --git a/tests/tcg/mips/mips32-dsp/dpau_h_qbl.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpau_h_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpau_h_qbl.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpau_h_qbl.c
diff --git a/tests/tcg/mips/mips32-dsp/dpau_h_qbr.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpau_h_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpau_h_qbr.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpau_h_qbr.c
diff --git a/tests/tcg/mips/mips32-dsp/dpsq_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpsq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpsq_s_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpsq_s_w_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/dpsq_sa_l_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpsq_sa_l_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpsq_sa_l_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpsq_sa_l_w.c
diff --git a/tests/tcg/mips/mips32-dsp/dpsu_h_qbl.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpsu_h_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpsu_h_qbl.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpsu_h_qbl.c
diff --git a/tests/tcg/mips/mips32-dsp/dpsu_h_qbr.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpsu_h_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/dpsu_h_qbr.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_dpsu_h_qbr.c
diff --git a/tests/tcg/mips/mips32-dsp/extp.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extp.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extp.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extp.c
diff --git a/tests/tcg/mips/mips32-dsp/extpdp.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extpdp.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extpdp.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extpdp.c
diff --git a/tests/tcg/mips/mips32-dsp/extpdpv.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extpdpv.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extpdpv.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extpdpv.c
diff --git a/tests/tcg/mips/mips32-dsp/extpv.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extpv.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extpv.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extpv.c
diff --git a/tests/tcg/mips/mips32-dsp/extr_r_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extr_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extr_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extr_r_w.c
diff --git a/tests/tcg/mips/mips32-dsp/extr_rs_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extr_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extr_rs_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extr_rs_w.c
diff --git a/tests/tcg/mips/mips32-dsp/extr_s_h.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extr_s_h.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extr_s_h.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extr_s_h.c
diff --git a/tests/tcg/mips/mips32-dsp/extr_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extr_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extr_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extr_w.c
diff --git a/tests/tcg/mips/mips32-dsp/extrv_r_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extrv_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extrv_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extrv_r_w.c
diff --git a/tests/tcg/mips/mips32-dsp/extrv_rs_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extrv_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extrv_rs_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extrv_rs_w.c
diff --git a/tests/tcg/mips/mips32-dsp/extrv_s_h.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extrv_s_h.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extrv_s_h.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extrv_s_h.c
diff --git a/tests/tcg/mips/mips32-dsp/extrv_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extrv_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/extrv_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_extrv_w.c
diff --git a/tests/tcg/mips/mips32-dsp/insv.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_insv.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/insv.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_insv.c
diff --git a/tests/tcg/mips/mips32-dsp/lbux.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_lbux.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/lbux.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_lbux.c
diff --git a/tests/tcg/mips/mips32-dsp/lhx.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_lhx.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/lhx.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_lhx.c
diff --git a/tests/tcg/mips/mips32-dsp/lwx.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_lwx.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/lwx.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_lwx.c
diff --git a/tests/tcg/mips/mips32-dsp/maddu.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_madd.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/maddu.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_madd.c
diff --git a/tests/tcg/mips/mips32-dsp/madd.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_maddu.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/madd.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_maddu.c
diff --git a/tests/tcg/mips/mips32-dsp/main.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_main.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/main.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_main.c
diff --git a/tests/tcg/mips/mips32-dsp/maq_s_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_maq_s_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/maq_s_w_phl.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_maq_s_w_phl.c
diff --git a/tests/tcg/mips/mips32-dsp/maq_s_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_maq_s_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/maq_s_w_phr.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_maq_s_w_phr.c
diff --git a/tests/tcg/mips/mips32-dsp/maq_sa_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_maq_sa_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/maq_sa_w_phl.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_maq_sa_w_phl.c
diff --git a/tests/tcg/mips/mips32-dsp/maq_sa_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_maq_sa_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/maq_sa_w_phr.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_maq_sa_w_phr.c
diff --git a/tests/tcg/mips/mips32-dsp/mthi.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mfhi.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mthi.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mfhi.c
diff --git a/tests/tcg/mips/mips32-dsp/mtlo.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mflo.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mtlo.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mflo.c
diff --git a/tests/tcg/mips/mips32-dsp/modsub.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_modsub.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/modsub.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_modsub.c
diff --git a/tests/tcg/mips/mips32-dsp/msub.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_msub.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/msub.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_msub.c
diff --git a/tests/tcg/mips/mips32-dsp/msubu.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_msubu.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/msubu.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_msubu.c
diff --git a/tests/tcg/mips/mips32-dsp/mfhi.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mthi.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mfhi.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mthi.c
diff --git a/tests/tcg/mips/mips32-dsp/mthlip.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mthlip.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mthlip.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mthlip.c
diff --git a/tests/tcg/mips/mips32-dsp/mflo.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mtlo.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mflo.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mtlo.c
diff --git a/tests/tcg/mips/mips32-dsp/muleq_s_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_muleq_s_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/muleq_s_w_phl.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_muleq_s_w_phl.c
diff --git a/tests/tcg/mips/mips32-dsp/muleq_s_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_muleq_s_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/muleq_s_w_phr.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_muleq_s_w_phr.c
diff --git a/tests/tcg/mips/mips32-dsp/muleu_s_ph_qbl.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_muleu_s_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/muleu_s_ph_qbl.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_muleu_s_ph_qbl.c
diff --git a/tests/tcg/mips/mips32-dsp/muleu_s_ph_qbr.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_muleu_s_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/muleu_s_ph_qbr.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_muleu_s_ph_qbr.c
diff --git a/tests/tcg/mips/mips32-dsp/mulq_rs_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mulq_rs_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mulq_rs_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mulq_rs_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/mult.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mult.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/mult.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_mult.c
diff --git a/tests/tcg/mips/mips32-dsp/multu.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_multu.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/multu.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_multu.c
diff --git a/tests/tcg/mips/mips32-dsp/packrl_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_packrl_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/packrl_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_packrl_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/pick_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_pick_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/pick_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_pick_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/pick_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_pick_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/pick_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_pick_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/preceq_w_phl.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceq_w_phl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceq_w_phl.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceq_w_phl.c
diff --git a/tests/tcg/mips/mips32-dsp/preceq_w_phr.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceq_w_phr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceq_w_phr.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceq_w_phr.c
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbl.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precequ_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precequ_ph_qbl.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precequ_ph_qbl.c
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbla.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precequ_ph_qbla.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precequ_ph_qbla.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precequ_ph_qbla.c
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbr.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precequ_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precequ_ph_qbr.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precequ_ph_qbr.c
diff --git a/tests/tcg/mips/mips32-dsp/precequ_ph_qbra.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precequ_ph_qbra.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precequ_ph_qbra.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precequ_ph_qbra.c
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbl.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceu_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceu_ph_qbl.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceu_ph_qbl.c
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbla.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceu_ph_qbla.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceu_ph_qbla.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceu_ph_qbla.c
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbr.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceu_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceu_ph_qbr.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceu_ph_qbr.c
diff --git a/tests/tcg/mips/mips32-dsp/preceu_ph_qbra.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceu_ph_qbra.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/preceu_ph_qbra.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_preceu_ph_qbra.c
diff --git a/tests/tcg/mips/mips32-dsp/precrq_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precrq_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precrq_ph_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precrq_ph_w.c
diff --git a/tests/tcg/mips/mips32-dsp/precrq_qb_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precrq_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precrq_qb_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precrq_qb_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/precrq_rs_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precrq_rs_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precrq_rs_ph_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precrq_rs_ph_w.c
diff --git a/tests/tcg/mips/mips32-dsp/precrqu_s_qb_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precrqu_s_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/precrqu_s_qb_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_precrqu_s_qb_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/raddu_w_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_raddu_w_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/raddu_w_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_raddu_w_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/rddsp.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_rddsp.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/rddsp.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_rddsp.c
diff --git a/tests/tcg/mips/mips32-dsp/repl_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_repl_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/repl_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_repl_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/repl_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_repl_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/repl_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_repl_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/replv_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_replv_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/replv_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_replv_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/replv_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_replv_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/replv_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_replv_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/shilo.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shilo.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shilo.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shilo.c
diff --git a/tests/tcg/mips/mips32-dsp/shilov.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shilov.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shilov.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shilov.c
diff --git a/tests/tcg/mips/mips32-dsp/shll_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shll_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shll_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shll_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shll_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shll_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shll_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shll_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/shll_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shll_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shll_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shll_s_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shll_s_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shll_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shll_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shll_s_w.c
diff --git a/tests/tcg/mips/mips32-dsp/shllv_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shllv_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shllv_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shllv_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shllv_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shllv_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shllv_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shllv_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/shllv_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shllv_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shllv_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shllv_s_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shllv_s_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shllv_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shllv_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shllv_s_w.c
diff --git a/tests/tcg/mips/mips32-dsp/shra_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shra_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shra_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shra_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shra_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shra_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shra_r_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shra_r_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shra_r_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shra_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shra_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shra_r_w.c
diff --git a/tests/tcg/mips/mips32-dsp/shrav_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shrav_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shrav_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shrav_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shrav_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shrav_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shrav_r_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shrav_r_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/shrav_r_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shrav_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shrav_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shrav_r_w.c
diff --git a/tests/tcg/mips/mips32-dsp/shrl_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shrl_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shrl_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shrl_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/shrlv_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shrlv_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/shrlv_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_shrlv_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/subq_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_subq_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/subq_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_subq_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/subq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_subq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/subq_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_subq_s_ph.c
diff --git a/tests/tcg/mips/mips32-dsp/subq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_subq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/subq_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_subq_s_w.c
diff --git a/tests/tcg/mips/mips32-dsp/subu_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_subu_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/subu_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_subu_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/subu_s_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_subu_s_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/subu_s_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_subu_s_qb.c
diff --git a/tests/tcg/mips/mips32-dsp/wrdsp.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_wrdsp.c
similarity index 100%
rename from tests/tcg/mips/mips32-dsp/wrdsp.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r1_wrdsp.c
diff --git a/tests/tcg/mips/mips32-dspr2/absq_s_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_absq_s_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/absq_s_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_absq_s_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addqh_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addqh_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addqh_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addqh_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addqh_r_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addqh_r_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_r_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addqh_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addqh_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addqh_r_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/addqh_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addqh_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addqh_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addqh_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/addu_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addu_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addu_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addu_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/addu_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addu_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/addu_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_addu_s_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/adduh_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_adduh_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/adduh_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_adduh_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/adduh_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_adduh_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/adduh_r_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_adduh_r_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/append.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_append.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/append.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_append.c
diff --git a/tests/tcg/mips/mips32-dspr2/balign.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_balign.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/balign.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_balign.c
diff --git a/tests/tcg/mips/mips32-dspr2/cmpgdu_eq_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_cmpgdu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/cmpgdu_eq_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_cmpgdu_eq_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/cmpgdu_le_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_cmpgdu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/cmpgdu_le_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_cmpgdu_le_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/cmpgdu_lt_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_cmpgdu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/cmpgdu_lt_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_cmpgdu_lt_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpa_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpa_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpaqx_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpaqx_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpaqx_s_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpaqx_s_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpaqx_sa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpaqx_sa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpaqx_sa_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpaqx_sa_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpax_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpax_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpax_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpax_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dps_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dps_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dps_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dps_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpsqx_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpsqx_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpsqx_s_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpsqx_s_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpsqx_sa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpsqx_sa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpsqx_sa_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpsqx_sa_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/dpsx_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpsx_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/dpsx_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_dpsx_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/mul_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mul_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mul_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mul_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/mul_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mul_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mul_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mul_s_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/mulq_rs_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mulq_rs_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mulq_rs_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mulq_rs_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/mulq_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mulq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mulq_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mulq_s_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/mulq_s_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mulq_s_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mulq_s_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mulq_s_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/mulsa_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mulsa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mulsa_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mulsa_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/mulsaq_s_w_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mulsaq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/mulsaq_s_w_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_mulsaq_s_w_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/precr_qb_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_precr_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/precr_qb_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_precr_qb_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/precr_sra_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_precr_sra_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/precr_sra_ph_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_precr_sra_ph_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/precr_sra_r_ph_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_precr_sra_r_ph_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/precr_sra_r_ph_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_precr_sra_r_ph_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/prepend.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_prepend.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/prepend.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_prepend.c
diff --git a/tests/tcg/mips/mips32-dspr2/shra_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shra_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shra_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shra_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/shra_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shra_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shra_r_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shra_r_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/shrav_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shrav_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shrav_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shrav_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/shrav_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shrav_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shrav_r_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shrav_r_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/shrl_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shrl_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shrl_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shrl_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/shrlv_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shrlv_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/shrlv_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_shrlv_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subqh_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subqh_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subqh_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_r_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subqh_r_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subqh_r_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subqh_r_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_r_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subqh_r_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subqh_r_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subqh_r_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/subqh_w.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subqh_w.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subqh_w.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subqh_w.c
diff --git a/tests/tcg/mips/mips32-dspr2/subu_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subu_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subu_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subu_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/subu_s_ph.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subu_s_ph.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subu_s_ph.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subu_s_ph.c
diff --git a/tests/tcg/mips/mips32-dspr2/subuh_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subuh_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subuh_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subuh_qb.c
diff --git a/tests/tcg/mips/mips32-dspr2/subuh_r_qb.c b/tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subuh_r_qb.c
similarity index 100%
rename from tests/tcg/mips/mips32-dspr2/subuh_r_qb.c
rename to tests/tcg/mips/user/ase/dsp/test_32_dsp_r2_subuh_r_qb.c
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
