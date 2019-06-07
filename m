Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD350C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FA620868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FA620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48902 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDRM-0001t8-J7
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59512)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hZBl6-0003sL-DV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hZBl3-00087X-0k
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50147 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hZBkz-0007ut-MR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:05:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id DFD831A1D23;
 Fri,  7 Jun 2019 12:05:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id BC71B1A0F10;
 Fri,  7 Jun 2019 12:05:49 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 12:05:34 +0200
Message-Id: <1559901944-4578-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 00/10] MIPS Queue for June 7th, 2019
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-06-06 14:09:14 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-jun-7-2019

for you to fetch changes up to 88e34ac062c995df540a4d0ee80b8f8b62353072:

  tests/tcg: target/mips: Add README for MSA tests (2019-06-07 11:53:07 +0200)

----------------------------------------------------------------

MIPS Queue for June 7th, 2019

Notes:

  * Four checkpatch warnings on updating MAINTAINERS can be ignored

Highlights:

  * Various additions to MSA core and test support

----------------------------------------------------------------

Aleksandar Markovic (10):
  target/mips: Fix space-related format issues in msa_helper.c
  target/mips: Fix block-comment-related issues in msa_helper.c
  target/mips: Outline places for future MSA helpers
  target/mips: Unroll loops in helpers for MSA logic instructions
  tests/tcg: target/mips: Amend and rearrange MSA wrappers
  tests/tcg: target/mips: Add tests for MSA shift instructions
  tests/tcg: target/mips: Move four tests to a better location
  tests/tcg: target/mips: Add utility function reset_msa_registers()
  tests/tcg: target/mips: Add tests for MSA FP max/min instructions
  tests/tcg: target/mips: Add README for MSA tests

 target/mips/msa_helper.c                           | 575 +++++++++++++++++++--
 tests/tcg/mips/include/wrappers_msa.h              | 508 ++++++++++++------
 tests/tcg/mips/user/ase/msa/README                 |  20 +
 .../mips/user/ase/msa/bit-count/test_msa_nloc_b.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_nloc_d.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_nloc_h.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_nloc_w.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_nlzc_b.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_nlzc_d.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_nlzc_h.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_nlzc_w.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_pcnt_b.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_pcnt_d.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_pcnt_h.c  |   2 +
 .../mips/user/ase/msa/bit-count/test_msa_pcnt_w.c  |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bclr_b.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bclr_d.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bclr_h.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bclr_w.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bneg_b.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bneg_d.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bneg_h.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bneg_w.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bset_b.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bset_d.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bset_h.c    |   2 +
 .../mips/user/ase/msa/bit-set/test_msa_bset_w.c    |   2 +
 .../test_msa_mul_q_h.c                             |   2 +
 .../test_msa_mul_q_w.c                             |   2 +
 .../test_msa_mulr_q_h.c                            |   2 +
 .../test_msa_mulr_q_w.c                            |   2 +
 .../user/ase/msa/float-max-min/test_msa_fmax_a_d.c | 155 ++++++
 .../user/ase/msa/float-max-min/test_msa_fmax_a_w.c | 155 ++++++
 .../user/ase/msa/float-max-min/test_msa_fmax_d.c   | 155 ++++++
 .../user/ase/msa/float-max-min/test_msa_fmax_w.c   | 155 ++++++
 .../user/ase/msa/float-max-min/test_msa_fmin_a_d.c | 155 ++++++
 .../user/ase/msa/float-max-min/test_msa_fmin_a_w.c | 155 ++++++
 .../user/ase/msa/float-max-min/test_msa_fmin_d.c   | 155 ++++++
 .../user/ase/msa/float-max-min/test_msa_fmin_w.c   | 155 ++++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_b.c   |   2 +
 .../mips/user/ase/msa/int-add/test_msa_add_a_d.c   |   2 +
 .../mips/user/ase/msa/int-add/test_msa_add_a_h.c   |   2 +
 .../mips/user/ase/msa/int-add/test_msa_add_a_w.c   |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_b.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_d.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_h.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_w.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_b.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_d.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_h.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_w.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_b.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_d.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_h.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_w.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_addv_b.c    |   2 +
 .../mips/user/ase/msa/int-add/test_msa_addv_d.c    |   2 +
 .../mips/user/ase/msa/int-add/test_msa_addv_h.c    |   2 +
 .../mips/user/ase/msa/int-add/test_msa_addv_w.c    |   2 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c  |   2 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c  |   2 +
 .../user/ase/msa/int-average/test_msa_ave_s_b.c    |   2 +
 .../user/ase/msa/int-average/test_msa_ave_s_d.c    |   2 +
 .../user/ase/msa/int-average/test_msa_ave_s_h.c    |   2 +
 .../user/ase/msa/int-average/test_msa_ave_s_w.c    |   2 +
 .../user/ase/msa/int-average/test_msa_ave_u_b.c    |   2 +
 .../user/ase/msa/int-average/test_msa_ave_u_d.c    |   2 +
 .../user/ase/msa/int-average/test_msa_ave_u_h.c    |   2 +
 .../user/ase/msa/int-average/test_msa_ave_u_w.c    |   2 +
 .../user/ase/msa/int-average/test_msa_aver_s_b.c   |   2 +
 .../user/ase/msa/int-average/test_msa_aver_s_d.c   |   2 +
 .../user/ase/msa/int-average/test_msa_aver_s_h.c   |   2 +
 .../user/ase/msa/int-average/test_msa_aver_s_w.c   |   2 +
 .../user/ase/msa/int-average/test_msa_aver_u_b.c   |   2 +
 .../user/ase/msa/int-average/test_msa_aver_u_d.c   |   2 +
 .../user/ase/msa/int-average/test_msa_aver_u_h.c   |   2 +
 .../user/ase/msa/int-average/test_msa_aver_u_w.c   |   2 +
 .../mips/user/ase/msa/int-compare/test_msa_ceq_b.c |   2 +
 .../mips/user/ase/msa/int-compare/test_msa_ceq_d.c |   2 +
 .../mips/user/ase/msa/int-compare/test_msa_ceq_h.c |   2 +
 .../mips/user/ase/msa/int-compare/test_msa_ceq_w.c |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_s_b.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_s_d.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_s_h.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_s_w.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_u_b.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_u_d.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_u_h.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_u_w.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_s_b.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_s_d.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_s_h.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_s_w.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_u_b.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_u_d.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_u_h.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_u_w.c    |   2 +
 .../user/ase/msa/int-divide/test_msa_div_s_b.c     |   2 +
 .../user/ase/msa/int-divide/test_msa_div_s_d.c     |   2 +
 .../user/ase/msa/int-divide/test_msa_div_s_h.c     |   2 +
 .../user/ase/msa/int-divide/test_msa_div_s_w.c     |   2 +
 .../user/ase/msa/int-divide/test_msa_div_u_b.c     |   2 +
 .../user/ase/msa/int-divide/test_msa_div_u_d.c     |   2 +
 .../user/ase/msa/int-divide/test_msa_div_u_h.c     |   2 +
 .../user/ase/msa/int-divide/test_msa_div_u_w.c     |   2 +
 .../ase/msa/int-dot-product/test_msa_dotp_s_d.c    |   2 +
 .../ase/msa/int-dot-product/test_msa_dotp_s_h.c    |   2 +
 .../ase/msa/int-dot-product/test_msa_dotp_s_w.c    |   2 +
 .../ase/msa/int-dot-product/test_msa_dotp_u_d.c    |   2 +
 .../ase/msa/int-dot-product/test_msa_dotp_u_h.c    |   2 +
 .../ase/msa/int-dot-product/test_msa_dotp_u_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_a_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_a_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_a_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_a_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_s_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_s_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_s_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_s_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_u_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_u_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_u_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_u_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_a_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_a_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_a_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_a_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_s_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_s_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_s_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_s_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_u_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_u_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_u_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_u_w.c    |   2 +
 .../user/ase/msa/int-modulo/test_msa_mod_s_b.c     |   2 +
 .../user/ase/msa/int-modulo/test_msa_mod_s_d.c     |   2 +
 .../user/ase/msa/int-modulo/test_msa_mod_s_h.c     |   2 +
 .../user/ase/msa/int-modulo/test_msa_mod_s_w.c     |   2 +
 .../user/ase/msa/int-modulo/test_msa_mod_u_b.c     |   2 +
 .../user/ase/msa/int-modulo/test_msa_mod_u_d.c     |   2 +
 .../user/ase/msa/int-modulo/test_msa_mod_u_h.c     |   2 +
 .../user/ase/msa/int-modulo/test_msa_mod_u_w.c     |   2 +
 .../user/ase/msa/int-multiply/test_msa_mulv_b.c    |   2 +
 .../user/ase/msa/int-multiply/test_msa_mulv_d.c    |   2 +
 .../user/ase/msa/int-multiply/test_msa_mulv_h.c    |   2 +
 .../user/ase/msa/int-multiply/test_msa_mulv_w.c    |   2 +
 .../user/ase/msa/int-subtract/test_msa_asub_s_b.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_asub_s_d.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_asub_s_h.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_asub_s_w.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_asub_u_b.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_asub_u_d.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_asub_u_h.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_asub_u_w.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_hsub_s_d.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_hsub_s_h.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_hsub_s_w.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_hsub_u_d.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_hsub_u_h.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_hsub_u_w.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_subs_s_b.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_subs_s_d.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_subs_s_h.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_subs_s_w.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_subs_u_b.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_subs_u_d.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_subs_u_h.c  |   2 +
 .../user/ase/msa/int-subtract/test_msa_subs_u_w.c  |   2 +
 .../ase/msa/int-subtract/test_msa_subsus_u_b.c     |   2 +
 .../ase/msa/int-subtract/test_msa_subsus_u_d.c     |   2 +
 .../ase/msa/int-subtract/test_msa_subsus_u_h.c     |   2 +
 .../ase/msa/int-subtract/test_msa_subsus_u_w.c     |   2 +
 .../ase/msa/int-subtract/test_msa_subsuu_s_b.c     |   2 +
 .../ase/msa/int-subtract/test_msa_subsuu_s_d.c     |   2 +
 .../ase/msa/int-subtract/test_msa_subsuu_s_h.c     |   2 +
 .../ase/msa/int-subtract/test_msa_subsuu_s_w.c     |   2 +
 .../user/ase/msa/int-subtract/test_msa_subv_b.c    |   2 +
 .../user/ase/msa/int-subtract/test_msa_subv_d.c    |   2 +
 .../user/ase/msa/int-subtract/test_msa_subv_h.c    |   2 +
 .../user/ase/msa/int-subtract/test_msa_subv_w.c    |   2 +
 .../user/ase/msa/interleave/test_msa_ilvev_b.c     |   2 +
 .../user/ase/msa/interleave/test_msa_ilvev_d.c     |   2 +
 .../user/ase/msa/interleave/test_msa_ilvev_h.c     |   2 +
 .../user/ase/msa/interleave/test_msa_ilvev_w.c     |   2 +
 .../mips/user/ase/msa/interleave/test_msa_ilvl_b.c |   2 +
 .../mips/user/ase/msa/interleave/test_msa_ilvl_d.c |   2 +
 .../mips/user/ase/msa/interleave/test_msa_ilvl_h.c |   2 +
 .../mips/user/ase/msa/interleave/test_msa_ilvl_w.c |   2 +
 .../user/ase/msa/interleave/test_msa_ilvod_b.c     |   2 +
 .../user/ase/msa/interleave/test_msa_ilvod_d.c     |   2 +
 .../user/ase/msa/interleave/test_msa_ilvod_h.c     |   2 +
 .../user/ase/msa/interleave/test_msa_ilvod_w.c     |   2 +
 .../mips/user/ase/msa/interleave/test_msa_ilvr_b.c |   2 +
 .../mips/user/ase/msa/interleave/test_msa_ilvr_d.c |   2 +
 .../mips/user/ase/msa/interleave/test_msa_ilvr_h.c |   2 +
 .../mips/user/ase/msa/interleave/test_msa_ilvr_w.c |   2 +
 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c |   2 +
 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c |   2 +
 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c  |   2 +
 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c |   2 +
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c  |   2 +
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c  |   2 +
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c  |   2 +
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c  |   2 +
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c  |   2 +
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c  |   2 +
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c  |   2 +
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c  |   2 +
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c |   4 +-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c |   4 +-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c |   4 +-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c |   4 +-
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c | 155 ++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srar_b.c  | 155 ++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srar_d.c  | 155 ++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srar_h.c  | 155 ++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srar_w.c  | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c | 155 ++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c | 155 ++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c  | 155 ++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c  | 155 ++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c  | 155 ++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c  | 155 ++++++
 tests/tcg/mips/user/ase/msa/test_msa_compile.sh    | 558 ++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run.sh        | 326 ++++++++++++
 239 files changed, 6550 insertions(+), 197 deletions(-)
 create mode 100644 tests/tcg/mips/user/ase/msa/README
 rename tests/tcg/mips/user/ase/msa/{int-multiply => fixed-multiply}/test_msa_mul_q_h.c (99%)
 rename tests/tcg/mips/user/ase/msa/{int-multiply => fixed-multiply}/test_msa_mul_q_w.c (99%)
 rename tests/tcg/mips/user/ase/msa/{int-multiply => fixed-multiply}/test_msa_mulr_q_h.c (99%)
 rename tests/tcg/mips/user/ase/msa/{int-multiply => fixed-multiply}/test_msa_mulr_q_w.c (99%)
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run.sh

-- 
2.7.4


