Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E627C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50DF206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50DF206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuAV-0006VK-Or
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41132)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hhu8D-0004sy-OI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hhu8C-000762-Kg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:05:57 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48935 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hhu8C-000676-D9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:05:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 3AD181A1FE0;
 Mon,  1 Jul 2019 13:04:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 200501A1E44;
 Mon,  1 Jul 2019 13:04:51 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	arikalo@wavecomp.com
Date: Mon,  1 Jul 2019 13:04:33 +0200
Message-Id: <1561979080-26195-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 0/7] target/mips: Mips improvements for 4.1
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

A collection of misc MIPS improvements that would be nice to be
integrated into 4.1.

Aleksandar Markovic (7):
  tcg/tests: target/mips: Amend MSA fixed point multiply tests
  tcg/tests: target/mips: Amend MSA integer multiply tests
  target/mips: Correct comments in msa_helper.c
  target/mips: Correct comments in translate.c
  tcg/tests: target/mips: Correct MSA test compilation and execution
    order
  target/mips: Unroll loops for MSA float max/min instructions
  target/mips: Correct helper for MSA FCLASS.<W|D> instructions

 target/mips/msa_helper.c                           | 244 ++++++++++-----
 target/mips/translate.c                            | 347 +++++++++++++--------
 tests/tcg/mips/include/wrappers_msa.h              |  16 +
 .../ase/msa/fixed-multiply/test_msa_madd_q_h.c     | 216 +++++++++++++
 .../ase/msa/fixed-multiply/test_msa_madd_q_w.c     | 216 +++++++++++++
 .../ase/msa/fixed-multiply/test_msa_maddr_q_h.c    | 216 +++++++++++++
 .../ase/msa/fixed-multiply/test_msa_maddr_q_w.c    | 216 +++++++++++++
 .../ase/msa/fixed-multiply/test_msa_msub_q_h.c     | 216 +++++++++++++
 .../ase/msa/fixed-multiply/test_msa_msub_q_w.c     | 216 +++++++++++++
 .../ase/msa/fixed-multiply/test_msa_msubr_q_h.c    | 216 +++++++++++++
 .../ase/msa/fixed-multiply/test_msa_msubr_q_w.c    | 216 +++++++++++++
 .../user/ase/msa/int-multiply/test_msa_maddv_b.c   | 224 ++++++-------
 .../user/ase/msa/int-multiply/test_msa_maddv_d.c   | 214 ++++++-------
 .../user/ase/msa/int-multiply/test_msa_maddv_h.c   | 224 ++++++-------
 .../user/ase/msa/int-multiply/test_msa_maddv_w.c   | 224 ++++++-------
 .../user/ase/msa/int-multiply/test_msa_msubv_b.c   | 224 ++++++-------
 .../user/ase/msa/int-multiply/test_msa_msubv_d.c   | 224 ++++++-------
 .../user/ase/msa/int-multiply/test_msa_msubv_h.c   | 224 ++++++-------
 .../user/ase/msa/int-multiply/test_msa_msubv_w.c   | 224 ++++++-------
 .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   |  32 +-
 .../mips/user/ase/msa/test_msa_compile_32r6el.sh   |  32 +-
 .../mips/user/ase/msa/test_msa_compile_64r6eb.sh   |  32 +-
 .../mips/user/ase/msa/test_msa_compile_64r6el.sh   |  32 +-
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh |  16 +-
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh |  16 +-
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh |  16 +-
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh |  16 +-
 27 files changed, 3165 insertions(+), 1144 deletions(-)
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c

-- 
2.7.4


