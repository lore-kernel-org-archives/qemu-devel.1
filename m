Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2AAC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A0D2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A0D2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfl6X-0007tD-0c
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49404)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hfl3e-0006Ah-Ph
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hfl3a-0003Uq-Jn
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:00:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58804 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hfl3Y-0003Rf-AC
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:00:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7413C1A477F;
 Tue, 25 Jun 2019 15:00:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 2D1111A4741;
 Tue, 25 Jun 2019 15:00:12 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 14:59:59 +0200
Message-Id: <1561467605-31065-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v5 0/6] target/mips: Improve MSA TCG tests
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

This series contains various improvements and additions of MSA ASE
TCG tests.

v4->v5:

  - added patch on MIPS32R6 support
  - amended other patches

v3->v4:

  - patches 1 and 2 from v3 got reviewed and integrated into upstream,
    so they are now removed in v4
  - added tests for MSA int multiply instructions
  - added support for MSA big-endian target testings
  - amend4ed remainign patches
  - rebased to the latest code

v2->v3:

  - added some tests from move group
  - added some tests from int dot product group
  - completed tests from bit move group

v1->v2:

  - added some tests from bit move group
  - improved and updated commit messages



Aleksandar Markovic (6):
  tests/tcg: target/mips: Add tests for MSA bit move instructions
  tests/tcg: target/mips: Add tests for MSA move instructions
  tests/tcg: target/mips: Amend tests for MSA int dot product
    instructions
  tests/tcg: target/mips: Amend tests for MSA int multiply instructions
  tests/tcg: target/mips: Add support for MSA big-endian target testings
  tests/tcg: target/mips: Add support for MSA MIPS32R6 testings

 tests/tcg/mips/include/wrappers_msa.h              |  96 +++-
 .../mips/user/ase/msa/bit-move/test_msa_binsl_b.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsl_d.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsl_h.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsl_w.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_b.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_d.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_h.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_w.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_bmnz_v.c   | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_bmz_v.c    | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_bsel_v.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_s_d.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_s_h.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_s_w.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_u_d.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_u_h.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_u_w.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_s_d.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_s_h.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_s_w.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_u_d.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_u_h.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_u_w.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_maddv_b.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_maddv_d.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_maddv_h.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_maddv_w.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_msubv_b.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_msubv_d.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_msubv_h.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_msubv_w.c   | 214 +++++++
 tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c | 149 +++++
 .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   | 627 +++++++++++++++++++++
 .../mips/user/ase/msa/test_msa_compile_32r6el.sh   | 627 +++++++++++++++++++++
 .../mips/user/ase/msa/test_msa_compile_64r6eb.sh   | 627 +++++++++++++++++++++
 ...t_msa_compile.sh => test_msa_compile_64r6el.sh} | 561 ++++++++++--------
 tests/tcg/mips/user/ase/msa/test_msa_run.sh        | 326 -----------
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh | 363 ++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh | 363 ++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh | 363 ++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh | 363 ++++++++++++
 42 files changed, 10523 insertions(+), 576 deletions(-)
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh
 rename tests/tcg/mips/user/ase/msa/{test_msa_compile.sh => test_msa_compile_64r6el.sh} (77%)
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run.sh
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh

-- 
2.7.4


