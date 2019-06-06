Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CD8C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF33D20684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF33D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59829 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYrbU-0005QY-VN
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:34:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYrSW-0006c9-6e
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYrSJ-0006Ql-UI
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:25:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33461 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hYrSA-00063y-1G
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:25:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id A91C61A21CE;
	Thu,  6 Jun 2019 14:25:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 371191A21C8;
	Thu,  6 Jun 2019 14:25:03 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 14:24:38 +0200
Message-Id: <1559823880-29103-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559823880-29103-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559823880-29103-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 08/10] tests/tcg: target/mips: Add utility
 function reset_msa_registers()
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add function reset_msa_registers() and utilize it in each MSA test.
This is needed to ensure independency of test results on the state of
MSA registers before test execution.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h                           | 6 ++++++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c         | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c           | 2 ++
 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c           | 2 ++
 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c   | 2 ++
 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c   | 2 ++
 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c  | 2 ++
 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c  | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c          | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c          | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c          | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c          | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c           | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c           | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c           | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c           | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c         | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c     | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c     | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c     | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c     | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c     | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c     | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c     | 2 ++
 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c     | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c        | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c        | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c        | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c        | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c | 2 ++
 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c | 2 ++
 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c | 2 ++
 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c | 2 ++
 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c | 2 ++
 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c       | 2 ++
 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c    | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c  | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c  | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c  | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c  | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c  | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c  | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c  | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c  | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c      | 2 ++
 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c      | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c       | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c       | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c       | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c       | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c        | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c        | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c        | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c        | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c       | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c       | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c       | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c       | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c        | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c        | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c        | 2 ++
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c        | 2 ++
 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c              | 2 ++
 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c              | 2 ++
 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c               | 2 ++
 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c              | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c             | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c             | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c             | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c             | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c             | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c             | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c             | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c             | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c              | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c              | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c              | 2 ++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c             | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c             | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c             | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c             | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c              | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c             | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c             | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c             | 2 ++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c             | 2 ++
 227 files changed, 458 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 2dc89e4..147dcd0 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -23,6 +23,12 @@
 #define WRAPPERS_MSA_H
 
 
+static inline void reset_msa_registers()
+{
+   ; /* nop for now */
+}
+
+
 #define DO_MSA__WD__WS(suffix, mnemonic)                               \
 static inline void do_msa_##suffix(const void *input,                  \
                                    const void *output)                 \
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
index c73ed24..287054e 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0100010104000201ULL, 0x0200020200000003ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
index b10fb23..171abdf 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0000000000000001ULL, 0x0000000000000002ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
index c1dc075..f260eba 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0001000100040002ULL, 0x0002000200000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
index 4f7a556..cb1981c 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0000000100000004ULL, 0x0000000200000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
index c202ba4..96d05d5 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0001000000010000ULL, 0x0001000001010300ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
index 1edead2..c709d5e 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
index b2724c5..c47e8bf 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000010003ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
index b547c73..a8a471b 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000001ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
index 5918e7f..067a11b 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0404050305040605ULL, 0x0404050504030405ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
index 667ca31..c60635d 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0000000000000024ULL, 0x0000000000000022ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
index 2951f86..8fba20a 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x000800080009000bULL, 0x0008000a00070009ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
index ab43ea9..24c44ae 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
@@ -121,6 +121,8 @@ int32_t main(void)
         { 0x0000001000000014ULL, 0x0000001200000010ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < TEST_COUNT_TOTAL; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
index c5aab14..e27d3b5 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d1e31e20eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
index 11e616e..3b8c384 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d5e31a24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
index dc67b4d..d1db60f 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d5e31a24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
index ab0cce7..54087b7 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d5e31a24eULL, 0x8cf188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
index 1939d10..733bc24 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x71cf566d1e33e60eULL, 0xadf389d9ab46e6a1ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
index 8462bb3..fc09221 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d5e31a24eULL, 0x8df188d9a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
index 172d4c0..d8347a1 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0xf04f364d5e33a24eULL, 0x8df389d8a946e2a1ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
index 23bc033..36ef436 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f364d5e31a24eULL, 0x8cf188d8a942e2a1ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
index f48adbd..f6907cb 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x71cf566d5e33e64eULL, 0xadf389d9ab46e6a1ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
index 787016a..ecd833b 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d9a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
index e1ff972..de63f26 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0xf04f364d5e33e24eULL, 0x8df389d8a946e2a1ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
index 51945b2..b973e67 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f364d5e31e24eULL, 0x8df188d8a942e2a1ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
index 55cf7b4..39a89ac 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x628a03e2455006e3ULL, 0x65a26eec3ac806bdULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
index 4b21d06..07f2dae 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x628a97e4455157d3ULL, 0x65a1c5e13ac736e1ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
index 8351050..e35af2f 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x628a03e3455006e4ULL, 0x65a36eec3ac806beULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
index 9e31ada..3cedf67 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x628a97e4455157d3ULL, 0x65a1c5e23ac736e2ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
index b603dbe..e96e4fd 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc623c9cULL, 0xe61ef050ae843cc0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
index d4130c3..ec025b6 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc63c49cULL, 0xe41cee4ead7a3ac0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
index 00428cf..d04b3a5 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc623b64ULL, 0xe41eee50ad7c3ac0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
index d60b11b..7ae90a3 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc63c49cULL, 0xe41cee50ad7a3ac0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
index 9a7d00b..05712a1 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x7f7f2c7f7f623c7fULL, 0x7f1e7f507f7f3c7fULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
index 481fadf..c222a95 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
index 4c6c2b9..0348f8c 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x7fff2c9a7fff3b64ULL, 0x7fff7fff7fff3ac0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
index f9cb626..9ad9c56 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
index e241b8b..a7f4de9 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x7f7f2c7f7f62c47fULL, 0x80e280b0807fc480ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
index ae35a9a..d1048fc 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x7fffffffffffffffULL, 0x8000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
index 48e3da7..6263616 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x7fff2c9a7fffc49cULL, 0x800080008000c540ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
index 77d49b6..80b69f7 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x7fffffff7fffffffULL, 0x8000000080000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
index dba9c20..d61623f 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc62ff9cULL, 0xffffffffff84ffffULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
index 39aad16..7b60457 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc63c49cULL, 0xffffffffffffffffULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
index 40846b8..c8b2262 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc62ffffULL, 0xffffffffffffffffULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
index 046d109..7880b03 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc63c49cULL, 0xffffffffffffffffULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
index 6107a42..dbfcd38 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc62c49cULL, 0x1ae210b05284c440ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
index 00f3ad7..27b6d65 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc63c49cULL, 0x1be311b15285c540ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
index 2b9ffdc..f7045f6 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc62c49cULL, 0x1be211b05284c540ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
index 93119ed..111e7c8 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xe09e2c9abc63c49cULL, 0x1be311b05285c540ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
index 697847d..e6dffbf 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x00000000ce80f89bULL, 0xffffffff37346b78ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
index 63b95aa..211123a 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x00bf0063008f0030ULL, 0xff7eff60ffebff82ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
index 7ff2bdc..cdab49d 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000869c0000407fULL, 0xffff16c9ffff8be2ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
index 372e205..38c43ce 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x00000000ce80f89bULL, 0x0000000137346b78ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
index 9c96d2b..41863f6 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x00bf0063008f0130ULL, 0x017e016000eb0182ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
index 3417fff..c30c266 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000869c0001407fULL, 0x000116c900018be2ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
index e279a2f..bb73fca 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
index 9969b59..b8c5ab4 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
index 3029232..24aed15 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
index 70e9a5d..c0082d1 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
index 260bad2..8c857c5 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
index 2d9fb07..fd2a4b9 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
index 0b34441..6ab8f47 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
index f1a4a5f..be614bb 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
index cc1528d..bccb6ac 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
index 8070f20..941d889 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
index 40db924..b977aac 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
index bde2850..c41a9b0 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
index 9ef7b7c..ed9aa28 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
index 307a844..04fcea4 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
index 3eef867..4305010 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
index baf3730..47cdc5c 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
index f1f5e6d..3ffb27c 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
index a87f1c9..dc60868 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
index a300ee3..a3073d7 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
index a3bb29a..9e81665 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
index 2b391c9..4235d59 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
index 44c6fe4..796f89a 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
index 331745b..0b63274 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
index acccc25..8fcee89 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
index 7421450..dc50ed3 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
index 402a54d..f6635f9 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
index 51685c7..0d09304 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
index adf744d..4671eee 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
index aa222fd..18d5706 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
index f762c4d..15a3166 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
index c456aef..89fcc2c 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
index 33978d1..c8481df 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
index fc6dc51..ee2b39c 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
index 5394b27..8fef047 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
index 0f813d8..5b236a7 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
index ff11360..918420c 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
index e17bb9a..1b11d93 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0101010101010101ULL, 0x0101010101010101ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
index fcab2cd..289cf6a 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000001ULL, 0x0000000000000001ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
index 83cc02e..af10a04 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0001000100010001ULL, 0x0001000100010001ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
index c3bc831..9d3920b 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000100000001ULL, 0x0000000100000001ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
index 97557d8..8c06235 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0101010101010101ULL, 0x0101010101010101ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
index a775538..2a9bfff 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000001ULL, 0x0000000000000001ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
index 2628eb2..95da85b 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0001000100010001ULL, 0x0001000100010001ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
index 8de2043..a3984b0 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000100000001ULL, 0x0000000100000001ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
index d495361..e6d7209 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x53edf7dbd76122edULL, 0x50347e61c2f51a40ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
index b785065..20a7029 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x4961190d2be51b48ULL, 0x348a3e802e952784ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
index 57cfd79..493fc10 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x33368b8a2619d525ULL, 0x6a47932120c31904ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
index 24f736d..7c9bd57 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x53edf7dbd76122edULL, 0xbe9d5551c2f51a40ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
index 4d30246..5ca7164 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x4961190d2be5df48ULL, 0x308afe8080952b84ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
index ca96d21..271666d 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x33368b8aeab5d525ULL, 0x97d9932138871904ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
index 1b90f23..eabcd2a 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
index aa8dca8..866c683 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
index fb9b63c..7f4c240 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
index 1334d80..7fb278e 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
index 05f8c03..7e35435 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
index 31218c1..f0a341e 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
index 1e4e69b..52de98b 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
index a4fa928..b2d0a22 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
index a245349..6fb023a 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
index 7aac861..35ebf1f 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
index 16c2122..0e7cf1e 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
index ce439a5..9dee997 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
index 1dc8c3c..747f54d 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
index a82c7ee..49ded49 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
index 91f1c23..f78104e 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
index 8030ed2..e0afa01 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
index 92aff1b..248b968 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
index 76e5dce..219029a 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
index 878ca2b..fb059af 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
index 3df7e10..dd47992 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
index fdaab02..7985acf 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
index 68e1a92..45d91af 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
index f9168b9..eb527bb 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
index 749fcef..057f22a 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
index dc1a4ed..a8964ea 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
index 0909793..3346d37 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
index 4d1463f..c28c253 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
index 7e13966..593e516 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
index fbc8699..1b5e57b 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
index 6c3224a..8aef843 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
index c9b40d7..ae5abb8 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
index 9f248b8..da48929 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
index 3cb9ee9..fa9753c 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0061e429846184c4ULL, 0xa9e1404091048400ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
index 8853440..2503467 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x4bb436d5b1e9cfc4ULL, 0x12d1ceb0e31ee400ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
index b014e81..5162678 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x386153290561cfc4ULL, 0x5ce136403504e400ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
index 967151c..7e2ff66 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x25775329b1e9cfc4ULL, 0xdfd63640e31ee400ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
index b67b7cf..f583702 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
index 3db9ca9..a9ae576 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
index fce1343..8c193b6 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
index e087f48..fb8f3c1 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
index 25a859a..506500b 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
index 5506525..ef7ee3f 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
index 513f02b..17dab15 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
index 974db1f..38a6395 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
index 7153bba..dd1dd37 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x00000000121d33ffULL, 0xffffffffe4aea638ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
index 37de5cb..d725d19 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0021ffc9002dff94ULL, 0xff9cffb0ff670042ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
index 6e90e13..af13d99 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x00005a0200007be3ULL, 0x00000519ffffc6a2ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
index 57cf9d2..bd71abf 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x00000000121d33ffULL, 0xffffffffe4aea638ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
index 433ff08..fbf0b6c 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0021ffc9002d0094ULL, 0xff9cffb000670042ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
index 3c77c0f..fb6b91a 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x00005a02ffff7be3ULL, 0x00000519ffffc6a2ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
index 8855153..38a6f40 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
index d1cc4e3..989d27c 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
index e245793..c847a6e 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
index 460de6a..0459a4e 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
index 8039643..3533c0c 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
index 4b5830b..894f984 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
index dd3a0d5..29eea52 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
index 6902875..2bae876 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
index 370952d..9cb798c 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x000000000000ff00ULL, 0xffffffffff00ffffULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
index 4ba3b59..4915d59 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
index 12a28ec..19d8538 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x000000000000ffffULL, 0xffffffffffffffffULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
index fab5452..278488b 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
index 0224509..a0d7616 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
index 8bdfe05..26cf9c5 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
index 420bfc7..cbba316 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
index 321faf9..156d62c 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
index 6fc4f66..dbec046 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
index 32eeff9..8b09789 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
index e30b195..69bf9ec 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
index 09d49cb..365dc0e 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
@@ -125,6 +125,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
index c61091e..00b78f7 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x4f4f4d4d31314e4eULL, 0xf1f1d8d84242a0a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
index f67ed28..a33acfa 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
index e760835..5186633 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x164d164de24ee24eULL, 0x88d888d8e2a0e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
index 30d2e38..0e82f21 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x5e31e24e5e31e24eULL, 0xa942e2a0a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
index c771287..6dc06c5 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0xa9a94242e2e2a0a0ULL, 0x8d8df1f18888d8d8ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
index b7d5fcd..a867972 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
index af72876..22f6ba6 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0xa942a942e2a0e2a0ULL, 0x8df18df188d888d8ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
index e06c9d9..f07689e 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0xa942e2a0a942e2a0ULL, 0x8df188d88df188d8ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
index 8e7f1c4..2316f38 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x707016165e5ee2e2ULL, 0x8d8d8888a9a9e2e2ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
index acbd94a..2feb2eb 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
index 8a82def4..93abfad 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f704f5e315e31ULL, 0x8df18df1a942a942ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
index e19170c..9b2b0d8 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d704f164dULL, 0x8df188d88df188d8ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
index 1e519e6..105a710 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x5e5e3131e2e24e4eULL, 0x70704f4f16164d4dULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
index be76043..22579c4 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
index cbd4685..ca416c0 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x5e315e31e24ee24eULL, 0x704f704f164d164dULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
index 5f4cfd0..6652c7f 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x5e31e24e5e31e24eULL, 0x704f164d704f164dULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
index 534c420..1f864be 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
index f781a8b..0b0f5dd 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x8fb0e9b2a1ce1db1ULL, 0x720e772756bd1d5fULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
index 924f216..90f535a 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
index f0442e6..398443d 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
index 409773d..fdab88d 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0xf1d842a04f4d314eULL, 0xf1d842a04f4d314eULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
index 8e89716..e708385 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
index b389587..bfd401f 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x88d8e2a0164de24eULL, 0x88d8e2a0164de24eULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
index d393ad50..e58372d 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0xa942e2a05e31e24eULL, 0xa942e2a05e31e24eULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
index ab363a0..4cefecd 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x8d88a9e270165ee2ULL, 0x8d88a9e270165ee2ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
index 09a6140..a7ea137 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
index d7a8c5b..bc7edcc 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x8df1a942704f5e31ULL, 0x8df1a942704f5e31ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
index 4b732d0..ca8c4fb 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x8df188d8704f164dULL, 0x8df188d8704f164dULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
index d9ccf57..e01cf4a 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
index 6c555fb..d022e1d 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
index 9dfcb51..1dabb03 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
index 97074c0..dcacf88 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
index f5096ee..6b1aa96 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x708080a080628880ULL, 0xa0e288d8520888a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
index 8be216b..deb3b11 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0xc593578c78938000ULL, 0xa942e2a000000000ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
index 6a7cc6b..edb3b11 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x8000a000bc628000ULL, 0x1be2d800a508e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
index 7348f7f..4cafaab 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0xe2c9a00078938000ULL, 0xd8000000a942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
index e8184e5..b1432c2 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x700000020118f801ULL, 0xfcf888d8d410f8a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
index 32da4c5..cb6c12d 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x0001c13c593578c7ULL, 0xffffffff8df188d8ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
index 372d7ff..2e50508 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x000000002f18ffffULL, 0xc6f8ff88ea50e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
index 0b91aca..f4ba1b5 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x00038278000178c7ULL, 0xffffff8da942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
index 647b6b4..73e6031 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x700100020119f901ULL, 0xfcf988d8d511f9a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
index 1669d42..b784897 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x0001c13c593578c8ULL, 0xffffffff8df188d9ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
index b63a544..476d2e1 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x000100012f190000ULL, 0xc6f9ff89ea51e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
index a1a82a3..87d7173 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x00038279000178c8ULL, 0xffffff8ea942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
index e2785fa..e0d460b 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x7000000201183801ULL, 0x047888d8541038a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
index 7eab568..e4b88a3 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x0001c13c593578c7ULL, 0x000000008df188d8ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
index 99f2564..1eb6440 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x000000002f180003ULL, 0x46f800882a50e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
index 34294f1..794833c 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x00038278000178c7ULL, 0x0000008da942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
index c6961a4..4a90017 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x7001000201193901ULL, 0x047988d8551139a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
index af6206b..69ba01f 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x0001c13c593578c8ULL, 0x000000008df188d9ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
index 885a013..514a143 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x000100012f190004ULL, 0x46f900892a51e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
index 172b5ba..940fd6f 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
@@ -123,6 +123,8 @@ int32_t main(void)
         { 0x00038279000178c8ULL, 0x0000008ea942e2a0ULL, },
     };
 
+    reset_msa_registers();
+
     gettimeofday(&start, NULL);
 
     for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
-- 
2.7.4


