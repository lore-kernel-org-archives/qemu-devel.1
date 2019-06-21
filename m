Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB7C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0717B2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0717B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIkg-0000Fk-GV
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55298)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1heI7T-0003M5-EB
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1heI7M-0005SS-JR
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:54:14 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41236 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1heI7G-0005JU-1Q
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:54:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id F06021A45D7;
 Fri, 21 Jun 2019 13:53:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 709321A45E3;
 Fri, 21 Jun 2019 13:53:50 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:53:36 +0200
Message-Id: <1561118020-30489-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561118020-30489-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561118020-30489-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v3 1/5] tests/tcg: target/mips: Include isa/ase
 and group name in test output
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

For better appearance and usefullnes, include ISA/ASE name and
instruction group name in the output of tests. For example, all
this data will be displayed for FMAX_A.W test:

| MSA       | Float Max Min       | FMAX_A.W    |
| PASS:  80 | FAIL:   0 | elapsed time: 0.16 ms |

(the data will be displayed in one row; they are presented here in two
rows not to exceed the width of the commit message)

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 tests/tcg/mips/include/test_utils_128.h                 | 17 ++++++++++-------
 tests/tcg/mips/include/test_utils_64.h                  |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c   |  9 ++++++---
 .../mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c |  9 ++++++---
 .../mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c |  9 ++++++---
 .../user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c     |  9 ++++++---
 .../user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c     |  9 ++++++---
 .../mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c |  9 ++++++---
 .../mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c |  9 ++++++---
 .../mips/user/ase/msa/float-max-min/test_msa_fmax_d.c   |  9 ++++++---
 .../mips/user/ase/msa/float-max-min/test_msa_fmax_w.c   |  9 ++++++---
 .../mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c |  9 ++++++---
 .../mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c |  9 ++++++---
 .../mips/user/ase/msa/float-max-min/test_msa_fmin_d.c   |  9 ++++++---
 .../mips/user/ase/msa/float-max-min/test_msa_fmin_w.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c  |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c  |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c  |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c  |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c   |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c |  9 ++++++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_ave_s_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_ave_s_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_ave_s_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_ave_s_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_ave_u_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_ave_u_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_ave_u_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_ave_u_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_aver_s_b.c   |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_aver_s_d.c   |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_aver_s_h.c   |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_aver_s_w.c   |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_aver_u_b.c   |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_aver_u_d.c   |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_aver_u_h.c   |  9 ++++++---
 .../mips/user/ase/msa/int-average/test_msa_aver_u_w.c   |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c  |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c  |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c  |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c  |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_cle_s_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_cle_s_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_cle_s_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_cle_s_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_cle_u_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_cle_u_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_cle_u_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_cle_u_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_clt_s_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_clt_s_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_clt_s_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_clt_s_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_clt_u_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_clt_u_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_clt_u_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-compare/test_msa_clt_u_w.c    |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c |  9 ++++++---
 .../user/ase/msa/int-dot-product/test_msa_dotp_s_d.c    |  9 ++++++---
 .../user/ase/msa/int-dot-product/test_msa_dotp_s_h.c    |  9 ++++++---
 .../user/ase/msa/int-dot-product/test_msa_dotp_s_w.c    |  9 ++++++---
 .../user/ase/msa/int-dot-product/test_msa_dotp_u_d.c    |  9 ++++++---
 .../user/ase/msa/int-dot-product/test_msa_dotp_u_h.c    |  9 ++++++---
 .../user/ase/msa/int-dot-product/test_msa_dotp_u_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_a_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_a_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_a_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_a_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_s_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_s_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_s_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_s_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_u_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_u_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_u_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_a_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_a_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_a_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_a_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_s_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_s_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_s_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_u_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_u_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_u_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c    |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c |  9 ++++++---
 .../mips/user/ase/msa/int-multiply/test_msa_mulv_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-multiply/test_msa_mulv_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-multiply/test_msa_mulv_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-multiply/test_msa_mulv_w.c    |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c  |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c  |  9 ++++++---
 .../user/ase/msa/int-subtract/test_msa_subsus_u_b.c     |  9 ++++++---
 .../user/ase/msa/int-subtract/test_msa_subsus_u_d.c     |  9 ++++++---
 .../user/ase/msa/int-subtract/test_msa_subsus_u_h.c     |  9 ++++++---
 .../user/ase/msa/int-subtract/test_msa_subsus_u_w.c     |  9 ++++++---
 .../user/ase/msa/int-subtract/test_msa_subsuu_s_b.c     |  9 ++++++---
 .../user/ase/msa/int-subtract/test_msa_subsuu_s_d.c     |  9 ++++++---
 .../user/ase/msa/int-subtract/test_msa_subsuu_s_h.c     |  9 ++++++---
 .../user/ase/msa/int-subtract/test_msa_subsuu_s_w.c     |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subv_b.c    |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subv_d.c    |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subv_h.c    |  9 ++++++---
 .../mips/user/ase/msa/int-subtract/test_msa_subv_w.c    |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c  |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c  |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c  |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c  |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c  |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c  |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c  |  9 ++++++---
 .../tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c  |  9 ++++++---
 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c       |  9 ++++++---
 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c      |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c     |  9 ++++++---
 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c     |  9 ++++++---
 .../user/isa/mips64r6/bit-count/test_mips64r6_clo.c     |  4 +++-
 .../user/isa/mips64r6/bit-count/test_mips64r6_clz.c     |  4 +++-
 .../user/isa/mips64r6/bit-count/test_mips64r6_dclo.c    |  4 +++-
 .../user/isa/mips64r6/bit-count/test_mips64r6_dclz.c    |  4 +++-
 .../user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c  |  4 +++-
 .../user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c |  4 +++-
 .../user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c |  4 +++-
 .../isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c     |  4 +++-
 .../user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c |  4 +++-
 .../isa/mips64r6/int-multiply/test_mips64r6_dmulu.c     |  4 +++-
 .../user/isa/mips64r6/int-multiply/test_mips64r6_muh.c  |  4 +++-
 .../user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c |  4 +++-
 .../user/isa/mips64r6/int-multiply/test_mips64r6_mul.c  |  4 +++-
 .../user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c |  4 +++-
 .../mips/user/isa/mips64r6/logic/test_mips64r6_and.c    |  4 +++-
 .../mips/user/isa/mips64r6/logic/test_mips64r6_nor.c    |  4 +++-
 .../tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c |  4 +++-
 .../mips/user/isa/mips64r6/logic/test_mips64r6_xor.c    |  4 +++-
 .../mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c  |  4 +++-
 .../mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c  |  4 +++-
 .../mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c  |  4 +++-
 .../mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c   |  4 +++-
 .../mips/user/isa/mips64r6/shift/test_mips64r6_srav.c   |  4 +++-
 .../mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c   |  4 +++-
 260 files changed, 1492 insertions(+), 736 deletions(-)

diff --git a/tests/tcg/mips/include/test_utils_128.h b/tests/tcg/mips/include/test_utils_128.h
index a828416..2fea610 100644
--- a/tests/tcg/mips/include/test_utils_128.h
+++ b/tests/tcg/mips/include/test_utils_128.h
@@ -30,11 +30,13 @@
 #define PRINT_RESULTS 0
 
 
-static inline int32_t check_results(const char *instruction_name,
-                                    const uint32_t test_count,
-                                    const double elapsed_time,
-                                    const uint64_t *b128_result,
-                                    const uint64_t *b128_expect)
+static inline int32_t check_results_128(const char *isa_ase_name,
+                                        const char *group_name,
+                                        const char *instruction_name,
+                                        const uint32_t test_count,
+                                        const double elapsed_time,
+                                        const uint64_t *b128_result,
+                                        const uint64_t *b128_expect)
 {
 #if PRINT_RESULTS
     uint32_t ii;
@@ -56,7 +58,8 @@ static inline int32_t check_results(const char *instruction_name,
     uint32_t pass_count = 0;
     uint32_t fail_count = 0;
 
-    printf("%s:   ", instruction_name);
+    printf("| %-10s \t| %-20s\t| %-16s \t|",
+           isa_ase_name, group_name, instruction_name);
     for (i = 0; i < test_count; i++) {
         if ((b128_result[2 * i] == b128_expect[2 * i]) &&
             (b128_result[2 * i + 1] == b128_expect[2 * i + 1])) {
@@ -66,7 +69,7 @@ static inline int32_t check_results(const char *instruction_name,
         }
     }
 
-    printf("\tPASS: %3d \tFAIL: %3d \telapsed time: %5.2f ms\n",
+    printf(" PASS: %3d \t| FAIL: %3d \t| elapsed time: %5.2f ms \t|\n",
            pass_count, fail_count, elapsed_time);
 
     if (fail_count > 0) {
diff --git a/tests/tcg/mips/include/test_utils_64.h b/tests/tcg/mips/include/test_utils_64.h
index ee38284..c9609d8 100644
--- a/tests/tcg/mips/include/test_utils_64.h
+++ b/tests/tcg/mips/include/test_utils_64.h
@@ -30,7 +30,9 @@
 #define PRINT_RESULTS 0
 
 
-static inline int32_t check_results_64(const char *instruction_name,
+static inline int32_t check_results_64(const char *isa_ase_name,
+                                       const char *group_name,
+                                       const char *instruction_name,
                                        const uint32_t test_count,
                                        const double elapsed_time,
                                        const uint64_t *b64_result,
@@ -55,7 +57,8 @@ static inline int32_t check_results_64(const char *instruction_name,
     uint32_t pass_count = 0;
     uint32_t fail_count = 0;
 
-    printf("%s:   ", instruction_name);
+    printf("| %-10s \t| %-20s\t| %-16s \t|",
+           isa_ase_name, group_name, instruction_name);
     for (i = 0; i < test_count; i++) {
         if (b64_result[i] == b64_expect[i]) {
             pass_count++;
@@ -64,7 +67,7 @@ static inline int32_t check_results_64(const char *instruction_name,
         }
     }
 
-    printf("PASS: %3d   FAIL: %3d   elapsed time: %5.2f ms\n",
+    printf(" PASS: %3d \t| FAIL: %3d \t| elapsed time: %5.2f ms \t|\n",
            pass_count, fail_count, elapsed_time);
 
     if (fail_count > 0) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
index 287054e..6ceb5aab 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "NLOC.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "NLOC.B";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
index 171abdf..897e90f 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "NLOC.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "NLOC.D";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
index f260eba..85cf3e6 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "NLOC.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "NLOC.H";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
index cb1981c..7ed97be 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "NLOC.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "NLOC.W";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
index 96d05d5..2103d5f 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "NLZC.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "NLZC.B";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
index c709d5e..b1ca3d4 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "NLZC.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "NLZC.D";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
index c47e8bf..6531c67 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "NLZC.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "NLZC.H";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
index a8a471b..71db53c 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "NLZC.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "NLZC.W";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
index 067a11b..184f7f4 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCNT.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "PCNT.B";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
index c60635d..3cc0d85 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCNT.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "PCNT.D";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
index 8fba20a..f1052b3 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCNT.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "PCNT.H";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
index 24c44ae..625ef29 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCNT.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "PCNT.W";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
@@ -139,8 +141,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
index e27d3b5..56fdee3 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BCLR.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BCLR.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
index 3b8c384..0accccf 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BCLR.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BCLR.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
index d1db60f..474e529 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BCLR.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BCLR.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
index 54087b7..818b12f 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BCLR.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BCLR.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
index 733bc24..78ba32f 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BNEG.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BNEG.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
index fc09221..44cd608 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BNEG.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BNEG.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
index d8347a1..5d17cee 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BNEG.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BNEG.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
index 36ef436..90d21f4 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BNEG.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BNEG.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
index f6907cb..8aabf4b 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BSET.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BSET.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
index ecd833b..e3f9a7e 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BSET.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BSET.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
index de63f26..cf9f608 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BSET.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BSET.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
index b973e67..7747811 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BSET.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Set";
+    char *instruction_name =  "BSET.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
index 39a89ac..cce7e9e 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MUL_Q.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MUL_Q.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
index 07f2dae..81d2635 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MUL_Q.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MUL_Q.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
index e35af2f..d5b00f1 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MULR_Q.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MULR_Q.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
index 3cedf67..78c9e22 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MULR_Q.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MULR_Q.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c
index 1807cab..d9b49ce 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "FMAX_A.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Float Max Min";
+    char *instruction_name =  "FMAX_A.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c
index b999b1f..f64276f 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "FMAX_A.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Float Max Min";
+    char *instruction_name =  "FMAX_A.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c
index b5ce6c7..ba548e4 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "FMAX.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Float Max Min";
+    char *instruction_name =  "FMAX.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c
index 5fafd30..f9aa24d 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "FMAX.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Float Max Min";
+    char *instruction_name =  "FMAX.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c
index c0b4001..555aa13 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "FMIN_A.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Float Max Min";
+    char *instruction_name =  "FMIN_A.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c
index d174fcd..9a81f1c 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "FMIN_A.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Float Max Min";
+    char *instruction_name =  "FMIN_A.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c
index 62c149f..97123c8 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "FMIN.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Float Max Min";
+    char *instruction_name =  "FMIN.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c
index c5815a6..1e91136 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "FMIN.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Float Max Min";
+    char *instruction_name =  "FMIN.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
index e96e4fd..c0a07b5 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADD_A.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADD_A.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
index ec025b6..0771cdb 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADD_A.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADD_A.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
index d04b3a5..7956960 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADD_A.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADD_A.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
index 7ae90a3..590f440 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADD_A.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADD_A.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
index 05712a1..42dd260 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_A.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_A.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
index c222a95..3e4e6f7 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_A.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_A.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
index 0348f8c..2901a81 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_A.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_A.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
index 9ad9c56..9e483e0 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_A.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_A.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
index a7f4de9..955815b 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
index d1048fc..0795f7e 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
index 6263616..793c5af 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
index 80b69f7..1c72c84 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
index d61623f..f203407 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
index 7b60457..30249ed 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
index c8b2262..1bd8aa9 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
index 7880b03..a91c69f 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDS_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDS_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
index dbfcd38..2f11c76 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDV.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDV.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
index 27b6d65..4ed0b97 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDV.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDV.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
index f7045f6..ca6ddd4 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDV.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDV.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
index 111e7c8..dff0f70 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ADDV.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "ADDV.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
index e6dffbf..c50a9dd 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HADD_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "HADD_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
index 211123a..586ef92 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HADD_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "HADD_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
index cdab49d..3589c33 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HADD_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "HADD_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
index 38c43ce..35b2021 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HADD_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "HADD_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
index 41863f6..3b38f9b 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HADD_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "HADD_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
index c30c266..fd420cb 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HADD_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Add";
+    char *instruction_name =  "HADD_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
index bb73fca..14ee4ab 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVE_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVE_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
index b8c5ab4..ae7b3c8 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVE_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVE_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
index 24aed15..d0d327e 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVE_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVE_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
index c0082d1..7701020 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVE_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVE_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
index 8c857c5..c9e834e 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVE_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVE_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
index fd2a4b9..5462ffa 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVE_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVE_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
index 6ab8f47..10d57e5 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVE_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVE_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
index be614bb..53106de 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVE_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVE_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
index bccb6ac..465f54f 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVER_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVER_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
index 941d889..391cb85 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVER_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVER_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
index b977aac..352b57d 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVER_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVER_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
index c41a9b0..cfba37b 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVER_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVER_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
index ed9aa28..91f227b 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVER_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVER_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
index 04fcea4..fde57a2 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVER_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVER_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
index 4305010..b9ec39a 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVER_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVER_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
index 47cdc5c..dc3c2e4 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AVER_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Average";
+    char *instruction_name =  "AVER_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
index 3ffb27c..c9a9ee2 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CEQ.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CEQ.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
index dc60868..542c460 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CEQ.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CEQ.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
index a3073d7..3ebe595 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CEQ.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CEQ.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
index 9e81665..003acf1 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CEQ.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CEQ.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
index 4235d59..ff20f0e 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLE_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLE_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
index 796f89a..3dc18bd 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLE_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLE_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
index 0b63274..00c48d6 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLE_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLE_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
index 8fcee89..16f84a1 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLE_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLE_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
index dc50ed3..24574dc 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLE_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLE_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
index f6635f9..e3f5715 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLE_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLE_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
index 0d09304..8938d31 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLE_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLE_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
index 4671eee..078a0c1 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLE_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLE_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
index 18d5706..02c3dfa 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLT_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLT_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
index 15a3166..40637e2 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLT_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLT_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
index 89fcc2c..ee3cd62 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLT_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLT_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
index c8481df..bde4d95 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLT_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLT_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
index ee2b39c..147bf48 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLT_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLT_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
index 8fef047..5daf716 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLT_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLT_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
index 5b236a7..8d51c2c 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLT_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLT_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
index 918420c..5403af8 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLT_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Compare";
+    char *instruction_name =  "CLT_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
index 1b11d93..f263201 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DIV_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Divide";
+    char *instruction_name =  "DIV_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
index 289cf6a..0458f93 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DIV_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Divide";
+    char *instruction_name =  "DIV_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
index af10a04..fffe7be 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DIV_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Divide";
+    char *instruction_name =  "DIV_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
index 9d3920b..22fa184 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DIV_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Divide";
+    char *instruction_name =  "DIV_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
index 8c06235..8097d6c 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DIV_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Divide";
+    char *instruction_name =  "DIV_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
index 2a9bfff..54d6fda 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DIV_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Divide";
+    char *instruction_name =  "DIV_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
index 95da85b..5a72990 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DIV_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Divide";
+    char *instruction_name =  "DIV_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
index a3984b0..e9e2da4 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DIV_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Divide";
+    char *instruction_name =  "DIV_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
index e6d7209..cb13ff3 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DOTP_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DOTP_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
index 20a7029..19451ee 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DOTP_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DOTP_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
index 493fc10..e635888 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DOTP_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DOTP_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
index 7c9bd57..af4337d 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DOTP_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DOTP_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
index 5ca7164..a87b72b 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DOTP_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DOTP_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
index 271666d..05df4cb 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DOTP_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DOTP_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
index eabcd2a..7e984a7 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_A.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_A.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
index 866c683..3dfdb48 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_A.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_A.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
index 7f4c240..e1d65f9 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_A.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_A.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
index 7fb278e..600f60a 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_A.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_A.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
index 7e35435..ab4161f 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
index f0a341e..54a78ae 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
index 52de98b..79b1e0a 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
index b2d0a22..32e3245 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
index 6fb023a..a63d226 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
index 35ebf1f..815a9ef 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
index 0e7cf1e..b668b39 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
index 9dee997..3329455 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MAX_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MAX_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
index 747f54d..8fdbfc3 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_A.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_A.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
index 49ded49..6a9f6bf 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_A.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_A.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
index f78104e..67a40b9 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_A.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_A.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
index e0afa01..d08cb9c 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_A.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_A.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
index 248b968..048233b 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
index 219029a..04e18eb 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
index fb059af..3bf32d4 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
index dd47992..eeb2ec9 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
index 7985acf..bdebf68 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
index 45d91af..fcd9016 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
index eb527bb..16f54b7 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
index 057f22a..574c169 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MIN_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Max Min";
+    char *instruction_name =  "MIN_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
index a8964ea..1533790 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MOD_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Modulo";
+    char *instruction_name =  "MOD_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
index 3346d37..a8237f4 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MOD_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Modulo";
+    char *instruction_name =  "MOD_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
index c28c253..5d6e4d6 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MOD_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Modulo";
+    char *instruction_name =  "MOD_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
index 593e516..1b068f2 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MOD_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Modulo";
+    char *instruction_name =  "MOD_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
index 1b5e57b..0d9ddf5 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MOD_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Modulo";
+    char *instruction_name =  "MOD_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
index 8aef843..1c3aa2b 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MOD_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Modulo";
+    char *instruction_name =  "MOD_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
index ae5abb8..a17a69f 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MOD_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Modulo";
+    char *instruction_name =  "MOD_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
index da48929..ac0f704 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MOD_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Modulo";
+    char *instruction_name =  "MOD_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
index fa9753c..de10468 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MULV.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Multiply";
+    char *instruction_name =  "MULV.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
index 2503467..ae2ebef 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MULV.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Multiply";
+    char *instruction_name =  "MULV.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
index 5162678..27479a8 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MULV.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Multiply";
+    char *instruction_name =  "MULV.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
index 7e2ff66..adeb1bf 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MULV.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Multiply";
+    char *instruction_name =  "MULV.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
index f583702..a3ab83b 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ASUB_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "ASUB_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
index a9ae576..ee46ffa 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ASUB_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "ASUB_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
index 8c193b6..3262365 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ASUB_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "ASUB_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
index fb8f3c1..51f9a69 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ASUB_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "ASUB_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
index 506500b..e086214 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ASUB_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "ASUB_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
index ef7ee3f..5640b65 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ASUB_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "ASUB_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
index 17dab15..a5bf2d2 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ASUB_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "ASUB_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
index 38a6395..772e90e 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ASUB_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "ASUB_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
index dd1dd37..66137f5 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HSUB_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "HSUB_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
index d725d19..e66261b 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HSUB_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "HSUB_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
index af13d99..6d97abf 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HSUB_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "HSUB_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
index bd71abf..8f39a45 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HSUB_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "HSUB_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
index fbf0b6c..6cc82fc 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HSUB_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "HSUB_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
index fb6b91a..b427e87 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "HSUB_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "HSUB_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
index 38a6f40..5c1f810 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBS_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBS_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
index 989d27c..546c24c 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBS_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBS_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
index c847a6e..24ddc82 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBS_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBS_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
index 0459a4e..f6109a5 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBS_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBS_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
index 3533c0c..f170912 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBS_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBS_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
index 894f984..bf647db 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBS_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBS_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
index 29eea52..c4616be 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBS_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBS_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
index 2bae876..6105267 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBS_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBS_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
index 9cb798c..71ea14f 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBSUS_U.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBSUS_U.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
index 4915d59..070c457 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBSUS_U.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBSUS_U.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
index 19d8538..f98d010 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBSUS_U.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBSUS_U.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
index 278488b..d325c19 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBSUS_U.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBSUS_U.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
index a0d7616..66012b5 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBSUU_S.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBSUU_S.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
index 26cf9c5..344a373 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBSUU_S.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBSUU_S.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
index cbba316..1cacb26 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBSUU_S.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBSUU_S.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
index 156d62c..42f3ee5 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBSUU_S.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBSUU_S.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
index dbec046..b8bd085 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBV.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBV.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
index 8b09789..f532e4a 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBV.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBV.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
index 69bf9ec..ac7f8ee 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBV.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBV.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
index 365dc0e..93eeaec 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
@@ -35,7 +35,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SUBV.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Subtract";
+    char *instruction_name =  "SUBV.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -150,8 +152,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
index 00b78f7..3506202 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVEV.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVEV.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
index a33acfa..896b11d 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVEV.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVEV.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
index 5186633..a68fea6 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVEV.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVEV.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
index 0e82f21..6e168c7 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVEV.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVEV.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
index 6dc06c5..11cfbf3 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVL.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVL.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
index a867972..35581ee 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVL.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVL.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
index 22f6ba6..0d89d95 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVL.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVL.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
index f07689e..ce04488 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVL.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVL.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
index 2316f38..f7dd1d2 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVOD.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVOD.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
index 2feb2eb..bef28d8 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVOD.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVOD.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
index 93abfad..d2355c6 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVOD.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVOD.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
index 9b2b0d8..636a62d 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVOD.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVOD.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
index 105a710..75bc9de 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVR.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVR.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
index 22579c4..a80aa44 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVR.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVR.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
index ca416c0..caa0022 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVR.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVR.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
index 6652c7f..65c89a3 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "ILVR.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Interleave";
+    char *instruction_name =  "ILVR.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
index 1f864be..22d1f9c 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AND.V";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Logic";
+    char *instruction_name =  "AND.V";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
index 0b0f5dd..3b9e481 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "NOR.V";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Logic";
+    char *instruction_name =  "NOR.V";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
index 90f535a..e6e5da4 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "OR.V";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Logic";
+    char *instruction_name =  "OR.V";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
index 398443d..1b699b5 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "XOR.V";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Logic";
+    char *instruction_name =  "XOR.V";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
index fdab88d..70cef5b 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCKEV.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "PCKEV.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
index e708385..8a1d18f 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCKEV.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "PCKEV.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
index bfd401f..c8636ba 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCKEV.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "PCKEV.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
index e58372d..7ceab05 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCKEV.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "PCKEV.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
index 4cefecd..b6f5e08 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCKOD.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "PCKOD.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
index a7ea137..c4b2386 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCKOD.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "PCKOD.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
index bc7edcc..36329e7 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCKOD.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "PCKOD.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
index ca8c4fb..3bc4223 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "PCKOD.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "PCKOD.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
index c088643..16f63c2 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "VSHF.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "VSHF.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
index 06f3604..5033b63 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "VSHF.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "VSHF.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
index f28d949..7de1f36 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "VSHF.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "VSHF.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
index 78e26d4..c19fb72 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "VSHF.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Pack";
+    char *instruction_name =  "VSHF.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
index 6b1aa96..649e67b 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SLL.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SLL.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
index deb3b11..1d6fe54 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SLL.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SLL.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
index edb3b11..1e6c27b 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SLL.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SLL.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
index 4cafaab..8bfbaca 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SLL.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SLL.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
index b1432c2..a5dcee3 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRA.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRA.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
index cb6c12d..95a1362 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRA.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRA.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
index 2e50508..f00003d 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRA.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRA.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
index f4ba1b5..f00da6d 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRA.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRA.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
index 73e6031..dcda9c2 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRAR.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRAR.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
index b784897..478098a 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRAR.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRAR.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
index 476d2e1..a300255 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRAR.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRAR.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
index 87d7173..027d4ce 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRAR.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRAR.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
index e0d460b..0e7c453 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRL.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRL.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
index e4b88a3..f6351f8 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRL.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRL.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
index 1eb6440..93394ef 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRL.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRL.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
index 794833c..c18cd98 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRL.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRL.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
index 4a90017..d173d8f 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRLR.B";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRLR.B";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
index 69ba01f..ecd7bd0 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRLR.D";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRLR.D";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
index 514a143..ca7fd75 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRLR.H";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRLR.H";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
index 940fd6f..ccbe6c0 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
@@ -33,7 +33,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRLR.W";
+    char *isa_ase_name = "MSA";
+    char *group_name = "Shift";
+    char *instruction_name =  "SRLR.W";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
@@ -148,8 +150,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                        &b128_result[0][0], &b128_expect[0][0]);
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
 
     return ret;
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
index ca9a739..e7ecdc5 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLO";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Bit Count";
+    char *instruction_name =   "CLO";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
index 0a7d21d..a77a8e4 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "CLZ";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Bit Count";
+    char *instruction_name =   "CLZ";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
index 72bb473..eb41fbd 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DCLO";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Bit Count";
+    char *instruction_name =   "DCLO";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
index 87df12b..be393ac 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DCLZ";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Bit Count";
+    char *instruction_name =   "DCLZ";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
index 639850d..df3d1b1 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "BITSWAP";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Bit Swap";
+    char *instruction_name =   "BITSWAP";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
index 366fe61..3778359 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DBITSWAP";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Bit Swap";
+    char *instruction_name =   "DBITSWAP";
     int32_t ret;
     uint32_t i;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
index c049378..eb21615 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DMUH";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Int Multiply";
+    char *instruction_name =   "DMUH";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
index dfb4195..7316d79 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DMUHU";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Int Multiply";
+    char *instruction_name =   "DMUHU";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
index 3c337dd..3ac1965 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DMUL";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Int Multiply";
+    char *instruction_name =   "DMUL";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
index b20a1ba..0862780 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DMULU";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Int Multiply";
+    char *instruction_name =   "DMULU";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
index 9134074..ff1ae6f 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MUH";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Int Multiply";
+    char *instruction_name =   "MUH";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
index 2485060..cb27527 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MUHU";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Int Multiply";
+    char *instruction_name =   "MUHU";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
index acf779c..5cdc4d5 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MUL";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Int Multiply";
+    char *instruction_name =   "MUL";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
index 65d5803..ccb3bdc 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "MULU";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Int Multiply";
+    char *instruction_name =   "MULU";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
index 2039dd9..4d6cf2e 100644
--- a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
+++ b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "AND";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Logic";
+    char *instruction_name =   "AND";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
index f22393b..21005dd 100644
--- a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
+++ b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "NOR";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Logic";
+    char *instruction_name =   "NOR";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
index ed8bac1..345b454 100644
--- a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
+++ b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "OR";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Logic";
+    char *instruction_name =   "OR";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
index a8ba2b4..7e36fee 100644
--- a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
+++ b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "XOR";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Logic";
+    char *instruction_name =   "XOR";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
index b3eb86e..4f719ef 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DSLLV";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Shift";
+    char *instruction_name =   "DSLLV";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
index 025e8f8..024d508 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DSRAV";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Shift";
+    char *instruction_name =   "DSRAV";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
index 680f8a1..fd1c398 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "DSRLV";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Shift";
+    char *instruction_name =   "DSRLV";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
index 288d087..a5fa72b 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SLLV";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Shift";
+    char *instruction_name =   "SLLV";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
index f547d9e..79e1a04 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRAV";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Shift";
+    char *instruction_name =   "SRAV";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
index 8b8075c..1f8c45d 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
@@ -31,7 +31,9 @@
 
 int32_t main(void)
 {
-    char *instruction_name = "SRLV";
+    char *isa_ase_name = "mips64r6";
+    char *group_name = "Shift";
+    char *instruction_name =   "SRLV";
     int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
-- 
2.7.4


