Return-Path: <SRS0=gcBw=UA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B75C28CC1
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 18:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C754027786
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 18:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C754027786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hX8sU-0006sT-2z
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 14:37:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hX8nV-0002sp-Kh
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 14:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hX8nQ-0005tP-MN
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 14:32:03 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59819 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hX8nQ-0005Po-Ay
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 14:32:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 491551A1D90;
	Sat,  1 Jun 2019 20:30:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 2A66B1A0570;
	Sat,  1 Jun 2019 20:30:55 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sat,  1 Jun 2019 20:30:38 +0200
Message-Id: <1559413846-4402-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 0/8] MIPS queue for June 1st, 2019
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 60905286cb5150de854e08279bca7dfc4b549e91:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190529' into staging (2019-05-30 15:08:00 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-jun-1-2019

for you to fetch changes up to 0df911fd7f482b796c9f10aa8e086fb3fb9f0f18:

  target/mips: Improve performance of certain MSA instructions (2019-06-01 20:20:20 +0200)

----------------------------------------------------------------

MIPS queue for June 1st, 2019

Notes:

  - two "checkpatch" warnings about updating MAINTAINERS on adding
      new files can and should be ignored
  - on my tests system, "make check" test test-util-filemonitor
      fails with message "Unable to add watch - Unable to watch
      '/tmp/test-util-filemonitor-0CZP2Z': No space left on device",
      but this seems to be the test bed issue, present both with and
      without patches from this pull request

Highlights:

  - improvement of performance of some MSA instructions
  - addition of support for some MMI instructions
  - cleanup and improvement of MSA TCG tests
  - cleanup of source code of some MIPS files

----------------------------------------------------------------

Aleksandar Markovic (4):
  target/mips: Amend and cleanup MSA TCG tests
  tests/tcg: target/mips: Add tests for MSA bit set instructions
  target/mips: Clean up dsp_helper.c
  target/mips: Clean up lmi_helper.c

Mateja Marjanovic (4):
  target/mips: Add emulation of MMI instruction PCPYH
  target/mips: Add emulation of MMI instruction PCPYLD
  target/mips: Add emulation of MMI instruction PCPYUD
  target/mips: Improve performance of certain MSA instructions

 target/mips/dsp_helper.c                           |  40 +-
 target/mips/lmi_helper.c                           |   8 +-
 target/mips/msa_helper.c                           | 542 ++++++++++++++++-----
 target/mips/translate.c                            | 152 +++++-
 tests/tcg/mips/include/test_utils_128.h            |   2 +-
 tests/tcg/mips/include/wrappers_msa.h              | 147 +++++-
 .../mips/user/ase/msa/bit-set/test_msa_bclr_b.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bclr_d.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bclr_h.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bclr_w.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_b.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_d.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_h.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_w.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_b.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_d.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_h.c    | 153 ++++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_w.c    | 153 ++++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_b.c   |   4 +
 .../mips/user/ase/msa/int-add/test_msa_add_a_d.c   |   4 +
 .../mips/user/ase/msa/int-add/test_msa_add_a_h.c   |   4 +
 .../mips/user/ase/msa/int-add/test_msa_add_a_w.c   |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_b.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_d.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_h.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_w.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_b.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_d.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_h.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_w.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_b.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_d.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_h.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_w.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_addv_b.c    |   4 +
 .../mips/user/ase/msa/int-add/test_msa_addv_d.c    |   4 +
 .../mips/user/ase/msa/int-add/test_msa_addv_h.c    |   4 +
 .../mips/user/ase/msa/int-add/test_msa_addv_w.c    |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c  |   4 +
 .../user/ase/msa/int-average/test_msa_ave_s_b.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_s_d.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_s_h.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_s_w.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_u_b.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_u_d.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_u_h.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_u_w.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_s_b.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_s_d.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_s_h.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_s_w.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_u_b.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_u_d.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_u_h.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_u_w.c   |  12 +-
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
 .../user/ase/msa/int-divide/test_msa_div_s_b.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_s_d.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_s_h.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_s_w.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_u_b.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_u_d.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_u_h.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_u_w.c     |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_s_d.c    |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_s_h.c    |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_s_w.c    |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_u_d.c    |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_u_h.c    |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_u_w.c    |  12 +-
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
 .../user/ase/msa/int-modulo/test_msa_mod_s_b.c     | 155 ++++++
 .../user/ase/msa/int-modulo/test_msa_mod_s_d.c     | 155 ++++++
 .../user/ase/msa/int-modulo/test_msa_mod_s_h.c     | 155 ++++++
 .../user/ase/msa/int-modulo/test_msa_mod_s_w.c     | 155 ++++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_b.c     | 155 ++++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_d.c     | 155 ++++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_h.c     | 155 ++++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_w.c     | 155 ++++++
 .../user/ase/msa/int-multiply/test_msa_mul_q_h.c   |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mul_q_w.c   |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulr_q_h.c  |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulr_q_w.c  |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulv_b.c    |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulv_d.c    |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulv_h.c    |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulv_w.c    |  12 +-
 .../user/ase/msa/int-subtract/test_msa_asub_s_b.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_asub_s_d.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_asub_s_h.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_asub_s_w.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_b.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_d.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_h.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_w.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_s_d.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_s_h.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_s_w.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_u_d.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_u_h.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_u_w.c  | 155 ++++++
 .../user/ase/msa/int-subtract/test_msa_subs_s_b.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_s_d.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_s_h.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_s_w.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_u_b.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_u_d.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_u_h.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_u_w.c  |  12 +-
 .../ase/msa/int-subtract/test_msa_subsus_u_b.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsus_u_d.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsus_u_h.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsus_u_w.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsuu_s_b.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsuu_s_d.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsuu_s_h.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsuu_s_w.c     |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subv_b.c    |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subv_d.c    |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subv_h.c    |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subv_w.c    |  10 +-
 .../user/ase/msa/interleave/test_msa_ilvev_b.c     |   2 +-
 .../user/ase/msa/interleave/test_msa_ilvev_d.c     |   2 +-
 .../user/ase/msa/interleave/test_msa_ilvev_h.c     |   2 +-
 171 files changed, 6663 insertions(+), 366 deletions(-)
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c

-- 
2.7.4


