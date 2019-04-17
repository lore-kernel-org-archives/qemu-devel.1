Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C847CC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 09:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A65121773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 09:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A65121773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49241 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGgXa-00030J-7p
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 05:07:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGgW5-0002TL-Md
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 05:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGgVn-0008El-9i
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 05:06:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51297 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hGgVl-00072Y-4o
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 05:05:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 17A7B1A221D;
	Wed, 17 Apr 2019 11:04:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw310-lin.domain.local (rtrkw310-lin.domain.local
	[10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 871911A1D5A;
	Wed, 17 Apr 2019 11:04:40 +0200 (CEST)
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 11:04:27 +0200
Message-Id: <1555491867-5922-1-git-send-email-mateja.marjanovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH] target/mips: Amend tests for MSA binary
 integer operations
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417090427.ZaD8Ga8UEhZEwNgs-g7qM744yqtYtW14Ozu80dbASik@z>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Amend tests for certain MSA binary integer instructions
(for example DIV_S.B) by appending two missing test cases
to complete standard battery of 80 test cases for each
such instruction. Expected values were pulled from the
results of the MIPS64r6 machine that executed those
instruction, and QEMU emulation should produce the same
results.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 .../mips/user/ase/msa/int-add/test_msa_add_a_b.c   |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_add_a_d.c   |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_add_a_h.c   |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_add_a_w.c   |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_a_b.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_a_d.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_a_h.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_a_w.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_s_b.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_s_d.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_s_h.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_s_w.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_u_b.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_u_d.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_u_h.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_u_w.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_addv_b.c    |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_addv_d.c    |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_addv_h.c    |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_addv_w.c    |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c  |   4 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c  |   4 +-
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
 .../user/ase/msa/int-modulo/test_msa_mod_s_b.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/int-modulo/test_msa_mod_s_d.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/int-modulo/test_msa_mod_s_h.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/int-modulo/test_msa_mod_s_w.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_b.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_d.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_h.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_w.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mul_q_h.c   |   2 +
 .../user/ase/msa/int-multiply/test_msa_mul_q_w.c   |   2 +
 .../user/ase/msa/int-multiply/test_msa_mulr_q_h.c  |   2 +
 .../user/ase/msa/int-multiply/test_msa_mulr_q_w.c  |   2 +
 .../user/ase/msa/int-multiply/test_msa_mulv_b.c    |   2 +
 .../user/ase/msa/int-multiply/test_msa_mulv_d.c    |   2 +
 .../user/ase/msa/int-multiply/test_msa_mulv_h.c    |   2 +
 .../user/ase/msa/int-multiply/test_msa_mulv_w.c    |   2 +
 .../user/ase/msa/int-subtract/test_msa_asub_s_b.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_asub_s_d.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_asub_s_h.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_asub_s_w.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_b.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_d.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_h.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_w.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_s_d.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_s_h.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_s_w.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_u_d.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_u_h.c  | 153 +++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_hsub_u_w.c  | 153 +++++++++++++++++++++
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
 105 files changed, 3558 insertions(+), 26 deletions(-)
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

diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
index 325c28c..d257ec9 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADD_A.B
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xc4a968a3a56293ceULL, 0x9a37b229ac6d4374ULL, },
         { 0xe8b930818693738eULL, 0xbe76838659bd6e6cULL, },
         { 0x759116b0ab9e5756ULL, 0x8518bd426c817064ULL, },
+        { 0xc4a968a3a56293ceULL, 0x9a37b229ac6d4374ULL, },
+        { 0xe09e2c9abc623c9cULL, 0xe61ef050ae843cc0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
index 7ca73f2..0bff628 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADD_A.D
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xc3f467a2a46256ceULL, 0x99e73e2701e84274ULL, },
         { 0xe7e42f8135cf8d0eULL, 0xbd7582865538cd6cULL, },
         { 0x749115ea109e1b46ULL, 0x850632416bfc705cULL, },
+        { 0xc3f467a2a46256ceULL, 0x99e73e2701e84274ULL, },
+        { 0xe09e2c9abc63c49cULL, 0xe41cee4ead7a3ac0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
index e35483c..4157fc0 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADD_A.H
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xc3f567a3a4629232ULL, 0x99e7b029ab934274ULL, },
         { 0xe7e52f81869372f2ULL, 0xbd76828658436d54ULL, },
         { 0x749116b0abc456aaULL, 0x8506bc0e6bfd705cULL, },
+        { 0xc3f567a3a4629232ULL, 0x99e7b029ab934274ULL, },
+        { 0xe09e2c9abc623b64ULL, 0xe41eee50ad7c3ac0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
index 040cadb..6143ddb 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADD_A.W
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xc3f467a3a46256ceULL, 0x99e73e27ab91f84cULL, },
         { 0xe7e42f818694378eULL, 0xbd75828658416d54ULL, },
         { 0x749115eaabc5a956ULL, 0x850632426bfc705cULL, },
+        { 0xc3f467a3a46256ceULL, 0x99e73e27ab91f84cULL, },
+        { 0xe09e2c9abc63c49cULL, 0xe41cee50ad7a3ac0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
index 7f8a595..bafe1b9 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_A.B
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x7f7f687f7f627f7fULL, 0x7f377f297f6d4374ULL, },
         { 0x7f7f307f7f7f737fULL, 0x7f767f7f597f6e6cULL, },
         { 0x757f167f7f7f5756ULL, 0x7f187f426c7f7064ULL, },
+        { 0x7f7f687f7f627f7fULL, 0x7f377f297f6d4374ULL, },
+        { 0x7f7f2c7f7f623c7fULL, 0x7f1e7f507f7f3c7fULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
index 2b38b0d..b7084d2 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_A.D
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
         { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
         { 0x749115ea109e1b46ULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
index 424f7d3..6bfd1e3 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_A.H
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x7fff67a37fff7fffULL, 0x7fff7fff7fff4274ULL, },
         { 0x7fff2f817fff72f2ULL, 0x7fff7fff58436d54ULL, },
         { 0x749116b07fff56aaULL, 0x7fff7fff6bfd705cULL, },
+        { 0x7fff67a37fff7fffULL, 0x7fff7fff7fff4274ULL, },
+        { 0x7fff2c9a7fff3b64ULL, 0x7fff7fff7fff3ac0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
index c389e46..552526c 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_A.W
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
         { 0x7fffffff7fffffffULL, 0x7fffffff58416d54ULL, },
         { 0x749115ea7fffffffULL, 0x7fffffff6bfc705cULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
index 5b1d9e0..6c7d65c 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_S.B
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x1c7fc4f7170080ceULL, 0xb4c980d7806d07b4ULL, },
         { 0xf87ffc197f7f377fULL, 0xd8589336a77f92acULL, },
         { 0x6b0d167f7fc4a956ULL, 0x9fe880f2be7f349cULL, },
+        { 0x1c7fc4f7170080ceULL, 0xb4c980d7806d07b4ULL, },
+        { 0x7f7f2c7f7f62c47fULL, 0x80e280b0807fc480ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
index d37773e..d8a19eb 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_S.D
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x1ca9c4f818016dceULL, 0xb5ca4fd8546e07b4ULL, },
         { 0xf8b9fd198694378eULL, 0xd9589437a7be92acULL, },
         { 0x6c0d16b0abc5a956ULL, 0xa0e943f2be82359cULL, },
+        { 0x1ca9c4f818016dceULL, 0xb5ca4fd8546e07b4ULL, },
+        { 0x7fffffffffffffffULL, 0x8000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
index eb5afe1..d372215 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_S.H
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x1ca9c4f718008000ULL, 0xb5c98000800007b4ULL, },
         { 0xf8b9fd197fff378eULL, 0xd9589436a7bd92acULL, },
         { 0x6c0d16b07fffa956ULL, 0xa0e88000be81359cULL, },
+        { 0x1ca9c4f718008000ULL, 0xb5c98000800007b4ULL, },
+        { 0x7fff2c9a7fffc49cULL, 0x800080008000c540ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
index 3e1aa30..4e6d016 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_S.W
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x1ca9c4f718016dceULL, 0xb5ca4fd780000000ULL, },
         { 0xf8b9fd197fffffffULL, 0xd9589436a7be92acULL, },
         { 0x6c0d16b07fffffffULL, 0xa0e943f2be82359cULL, },
+        { 0x1ca9c4f718016dceULL, 0xb5ca4fd780000000ULL, },
+        { 0x7fffffff7fffffffULL, 0x8000000080000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
index 995da29..dc2ee74 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_U.B
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xffa9c4f7ffffffceULL, 0xb4ffffffff6dffb4ULL, },
         { 0xf8b9fcff8693ff8eULL, 0xd8ff93ffffbdffacULL, },
         { 0xffff16b0abc4ff56ULL, 0x9ffffff2be81ffffULL, },
+        { 0xffa9c4f7ffffffceULL, 0xb4ffffffff6dffb4ULL, },
+        { 0xe09e2c9abc62ff9cULL, 0xffffffffff84ffffULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
index 2e32380..712e536 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_U.D
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xb5ca4fd8546e07b4ULL, },
         { 0xf8b9fd198694378eULL, 0xd9589437a7be92acULL, },
         { 0xffffffffffffffffULL, 0xa0e943f2be82359cULL, },
+        { 0xffffffffffffffffULL, 0xb5ca4fd8546e07b4ULL, },
+        { 0xe09e2c9abc63c49cULL, 0xffffffffffffffffULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
index 4c2e982..abfde40 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_U.H
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xffffc4f7ffffffffULL, 0xb5c9ffffffffffffULL, },
         { 0xf8b9fd198693ffffULL, 0xd9589436ffffffffULL, },
         { 0xffff16b0abc4ffffULL, 0xa0e8ffffbe81ffffULL, },
+        { 0xffffc4f7ffffffffULL, 0xb5c9ffffffffffffULL, },
+        { 0xe09e2c9abc62ffffULL, 0xffffffffffffffffULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
index 8cf0741..13d8b53 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDS_U.W
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xffffffffffffffffULL, 0xb5ca4fd7ffffffffULL, },
         { 0xf8b9fd198694378eULL, 0xd9589436ffffffffULL, },
         { 0xffffffffabc5a956ULL, 0xa0e943f2be82359cULL, },
+        { 0xffffffffffffffffULL, 0xb5ca4fd7ffffffffULL, },
+        { 0xe09e2c9abc63c49cULL, 0xffffffffffffffffULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
index 44d8921..f21622e 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDV.B
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x1ca9c4f717006dceULL, 0xb4c94ed7546d07b4ULL, },
         { 0xf8b9fc198693378eULL, 0xd8589336a7bd92acULL, },
         { 0x6b0d16b0abc4a956ULL, 0x9fe843f2be81349cULL, },
+        { 0x1ca9c4f717006dceULL, 0xb4c94ed7546d07b4ULL, },
+        { 0xe09e2c9abc62c49cULL, 0x1ae210b05284c440ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
index 858258b..31e49d5 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDV.D
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x1ca9c4f818016dceULL, 0xb5ca4fd8546e07b4ULL, },
         { 0xf8b9fd198694378eULL, 0xd9589437a7be92acULL, },
         { 0x6c0d16b0abc5a956ULL, 0xa0e943f2be82359cULL, },
+        { 0x1ca9c4f818016dceULL, 0xb5ca4fd8546e07b4ULL, },
+        { 0xe09e2c9abc63c49cULL, 0x1be311b15285c540ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
index 5daf7fc..7d20587 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDV.H
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x1ca9c4f718006dceULL, 0xb5c94fd7546d07b4ULL, },
         { 0xf8b9fd198693378eULL, 0xd9589436a7bd92acULL, },
         { 0x6c0d16b0abc4a956ULL, 0xa0e843f2be81359cULL, },
+        { 0x1ca9c4f718006dceULL, 0xb5c94fd7546d07b4ULL, },
+        { 0xe09e2c9abc62c49cULL, 0x1be211b05284c540ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
index b1e42ec..4a4a9d5 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction ADDV.W
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x1ca9c4f718016dceULL, 0xb5ca4fd7546e07b4ULL, },
         { 0xf8b9fd198694378eULL, 0xd9589436a7be92acULL, },
         { 0x6c0d16b0abc5a956ULL, 0xa0e943f2be82359cULL, },
+        { 0x1ca9c4f718016dceULL, 0xb5ca4fd7546e07b4ULL, },
+        { 0xe09e2c9abc63c49cULL, 0x1be311b05285c540ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
index 5a923d6..98f8ad0 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction HADD_S.D
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x000000000a8c90f8ULL, 0xffffffffd11ba99fULL, },
         { 0x0000000098b16b8dULL, 0xffffffff8c6d38e4ULL, },
         { 0x00000000bde2dd55ULL, 0xffffffffa330dbd4ULL, },
+        { 0x000000002a1ea1cdULL, 0xffffffff391cadecULL, },
+        { 0x00000000ce80f89bULL, 0xffffffff37346b78ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
index 4b14853..51840bf 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction HADD_S.H
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xfffbfffbffeaffd9ULL, 0x0018ff9effedffc5ULL, },
         { 0x00daffe200c00022ULL, 0xfff4ffe60024ffeeULL, },
         { 0x002e0079fff1ffeaULL, 0xff84ffa2ffe8ffdeULL, },
+        { 0x00caffc0002dff62ULL, 0xff65ff87ffd4fff6ULL, },
+        { 0x00bf0063008f0030ULL, 0xff7eff60ffebff82ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
index 26508ea..7f87f92 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction HADD_S.W
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xffffc2a7ffff9c1dULL, 0xffffb0b0ffff8dcbULL, },
         { 0x0000571b0000b371ULL, 0xffff994fffff594eULL, },
         { 0x000070b200002539ULL, 0xffff490bfffffc3eULL, },
+        { 0x00001ef9ffffe9b1ULL, 0xffff54f0ffffce56ULL, },
+        { 0x0000869c0000407fULL, 0xffff16c9ffff8be2ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
index 76f36a7..951464d 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction HADD_U.D
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x000000010a8c90f8ULL, 0x00000000d11ba99fULL, },
         { 0x0000000098b16b8dULL, 0x000000018c6d38e4ULL, },
         { 0x00000000bde2dd55ULL, 0x00000000a330dbd4ULL, },
+        { 0x000000012a1ea1cdULL, 0x00000001391cadecULL, },
+        { 0x00000000ce80f89bULL, 0x0000000137346b78ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
index a377c10..a39eddd 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction HADD_U.H
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x00fb00fb00ea00d9ULL, 0x0118019e00ed00c5ULL, },
         { 0x00da00e200c00122ULL, 0x00f400e6012400eeULL, },
         { 0x012e007900f100eaULL, 0x018400a200e801deULL, },
+        { 0x00ca00c0012d0162ULL, 0x0165018700d400f6ULL, },
+        { 0x00bf0063008f0130ULL, 0x017e016000eb0182ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
index 4f4c54a..e0aaee3 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
@@ -2,7 +2,7 @@
  *  Test program for MSA instruction HADD_U.W
  *
  *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0000c2a700019c1dULL, 0x0000b0b000018dcbULL, },
         { 0x0001571b0000b371ULL, 0x0000994f0001594eULL, },
         { 0x000070b200012539ULL, 0x0001490b0000fc3eULL, },
+        { 0x00011ef90000e9b1ULL, 0x000154f00000ce56ULL, },
+        { 0x0000869c0001407fULL, 0x000116c900018be2ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
index 675fb90..d4d7157 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0e54e2fb0b00b6e7ULL, 0xdae4a7ebaa3603daULL, },
         { 0xfc5cfe0c43491b47ULL, 0xec2cc91bd35ec9d6ULL, },
         { 0x35060b5855e2d42bULL, 0xcff4a1f9df401aceULL, },
+        { 0x0e54e2fb0b00b6e7ULL, 0xdae4a7ebaa3603daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
index e87d414..dbb26b8 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0e54e27c0c00b6e7ULL, 0xdae527ec2a3703daULL, },
         { 0xfc5cfe8cc34a1bc7ULL, 0xecac4a1bd3df4956ULL, },
         { 0x36068b5855e2d4abULL, 0xd074a1f95f411aceULL, },
+        { 0x0e54e27c0c00b6e7ULL, 0xdae527ec2a3703daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
index c850543..40e64ab 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0e54e27b0c00b6e7ULL, 0xdae4a7ebaa3603daULL, },
         { 0xfc5cfe8c43491bc7ULL, 0xecacca1bd3dec956ULL, },
         { 0x36060b5855e2d4abULL, 0xd074a1f9df401aceULL, },
+        { 0x0e54e27b0c00b6e7ULL, 0xdae4a7ebaa3603daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
index 3220574..93f5156 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0e54e27b0c00b6e7ULL, 0xdae527ebaa3703daULL, },
         { 0xfc5cfe8c434a1bc7ULL, 0xecac4a1bd3df4956ULL, },
         { 0x36068b5855e2d4abULL, 0xd074a1f9df411aceULL, },
+        { 0x0e54e27b0c00b6e7ULL, 0xdae527ebaa3703daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
index c3f96a6..2d94114 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8e54627b8b80b667ULL, 0x5ae4a7ebaa36835aULL, },
         { 0x7c5c7e8c43499b47ULL, 0x6cac499bd35ec956ULL, },
         { 0xb5860b585562d42bULL, 0x4ff4a1795f409aceULL, },
+        { 0x8e54627b8b80b667ULL, 0x5ae4a7ebaa36835aULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
index 3a78629..a8dbc20 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8e54e27c0c00b6e7ULL, 0x5ae527ec2a3703daULL, },
         { 0x7c5cfe8cc34a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
         { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+        { 0x8e54e27c0c00b6e7ULL, 0x5ae527ec2a3703daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
index b7db518..d73ddd1 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8e54627b8c00b6e7ULL, 0x5ae4a7ebaa3683daULL, },
         { 0x7c5c7e8c43499bc7ULL, 0x6cac4a1bd3dec956ULL, },
         { 0xb6060b5855e2d4abULL, 0x5074a1f95f409aceULL, },
+        { 0x8e54627b8c00b6e7ULL, 0x5ae4a7ebaa3683daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
index 75e2409..3955c4f 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8e54e27b8c00b6e7ULL, 0x5ae527ebaa3703daULL, },
         { 0x7c5cfe8c434a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
         { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+        { 0x8e54e27b8c00b6e7ULL, 0x5ae527ebaa3703daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
index 59bba28..64c4f5d 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0e55e2fc0c00b7e7ULL, 0xdae5a7ecaa3704daULL, },
         { 0xfc5dfe0d434a1c47ULL, 0xec2cca1bd45fc9d6ULL, },
         { 0x36070b5856e2d52bULL, 0xd0f4a2f9df411aceULL, },
+        { 0x0e55e2fc0c00b7e7ULL, 0xdae5a7ecaa3704daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
index 435c09f..e36bdde 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0e54e27c0c00b6e7ULL, 0xdae527ec2a3703daULL, },
         { 0xfc5cfe8cc34a1bc7ULL, 0xecac4a1bd3df4956ULL, },
         { 0x36068b5855e2d4abULL, 0xd074a1f95f411aceULL, },
+        { 0x0e54e27c0c00b6e7ULL, 0xdae527ec2a3703daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
index 0902e50..9c44821 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0e55e27c0c00b6e7ULL, 0xdae5a7ecaa3703daULL, },
         { 0xfc5dfe8d434a1bc7ULL, 0xecacca1bd3dfc956ULL, },
         { 0x36070b5855e2d4abULL, 0xd074a1f9df411aceULL, },
+        { 0x0e55e27c0c00b6e7ULL, 0xdae5a7ecaa3703daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
index 31f4553..f898c2e 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0e54e27c0c00b6e7ULL, 0xdae527ecaa3703daULL, },
         { 0xfc5cfe8d434a1bc7ULL, 0xecac4a1bd3df4956ULL, },
         { 0x36068b5855e2d4abULL, 0xd074a1f9df411aceULL, },
+        { 0x0e54e27c0c00b6e7ULL, 0xdae527ecaa3703daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
index 8aa7ec6..5c48e75 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8e55627c8c80b767ULL, 0x5ae5a7ecaa37845aULL, },
         { 0x7c5d7e8d434a9c47ULL, 0x6cac4a9bd45fc956ULL, },
         { 0xb6870b585662d52bULL, 0x50f4a2795f419aceULL, },
+        { 0x8e55627c8c80b767ULL, 0x5ae5a7ecaa37845aULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
index 9b16e12..ee18f69 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8e54e27c0c00b6e7ULL, 0x5ae527ec2a3703daULL, },
         { 0x7c5cfe8cc34a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
         { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+        { 0x8e54e27c0c00b6e7ULL, 0x5ae527ec2a3703daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
index 191e4ac..cf10751 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8e55627c8c00b6e7ULL, 0x5ae5a7ecaa3783daULL, },
         { 0x7c5d7e8d434a9bc7ULL, 0x6cac4a1bd3dfc956ULL, },
         { 0xb6070b5855e2d4abULL, 0x5074a1f95f419aceULL, },
+        { 0x8e55627c8c00b6e7ULL, 0x5ae5a7ecaa3783daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
index e0d6b17..963fd77 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8e54e27c8c00b6e7ULL, 0x5ae527ecaa3703daULL, },
         { 0x7c5cfe8d434a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
         { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+        { 0x8e54e27c8c00b6e7ULL, 0x5ae527ecaa3703daULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
index 38e3670..840fc79 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0001fdff00ff03ffULL, 0x000200000000ff00ULL, },
         { 0x000000ff02000001ULL, 0xff00f6002b0000f8ULL, },
         { 0xeaffff0001000009ULL, 0xfa0101fffc010018ULL, },
+        { 0xff000000ffff0000ULL, 0xfe000228010100fcULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
index d92b695..6e5e74e 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
         { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
         { 0xffffffffffffffe6ULL, 0xfffffffffffffffaULL, },
+        { 0xffffffffffffffffULL, 0xfffffffffffffffeULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
index f191b98..4a3a30d 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0000fffd00000003ULL, 0x000000000000ffffULL, },
         { 0x0000000000020000ULL, 0xfffffff600390000ULL, },
         { 0xffe6003900010000ULL, 0xfffa0001fffc0000ULL, },
+        { 0xffff0000ffff0000ULL, 0xfffe000200010000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
index 0baaff1..78f8582 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
         { 0x0000000000000002ULL, 0xffffffff00000039ULL, },
         { 0xffffffe600000001ULL, 0xfffffffafffffffcULL, },
+        { 0xffffffffffffffffULL, 0xfffffffe00000001ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
index 770544a..5d12a38 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0101070201040001ULL, 0x0000010101000000ULL, },
         { 0x0000000002000201ULL, 0x01020c020000010dULL, },
         { 0x0000ff0001000109ULL, 0x0700000808010200ULL, },
+        { 0x0000000000000100ULL, 0x0301000000010608ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
index 9653e7d..3ff266f 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0000000000000001ULL, 0x0000000000000000ULL, },
         { 0x0000000000000000ULL, 0x0000000000000001ULL, },
         { 0x0000000000000000ULL, 0x0000000000000007ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
index 3dcd30b..e8d9c67 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0001000700010000ULL, 0x0000000100010000ULL, },
         { 0x0000000000020002ULL, 0x0001000c00000001ULL, },
         { 0x0000003900010001ULL, 0x0007000000070002ULL, },
+        { 0x0000000000000001ULL, 0x0003000000000006ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
index fd395ef..61f832c 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x0000000100000001ULL, 0x0000000000000001ULL, },
         { 0x0000000000000002ULL, 0x0000000100000000ULL, },
         { 0x0000000000000001ULL, 0x0000000700000007ULL, },
+        { 0x0000000000000000ULL, 0x0000000300000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
index af8d609..2ce500e 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xc17a5d0372a2a622ULL, 0x0afd6368668933a8ULL, },
         { 0xda65cd5e9f696cdcULL, 0xdeeb6bec644a26d0ULL, },
         { 0x1aad30609bff5437ULL, 0xf059a43d01b40370ULL, },
+        { 0xc17a5d0372a2a622ULL, 0x0afd6368668933a8ULL, },
+        { 0x53edf7dbd76122edULL, 0x50347e61c2f51a40ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
index 40de72a..a5f1804 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xf706df16dc8de6b6ULL, 0xf0d31b5827f9f42aULL, },
         { 0xec36ee202172098aULL, 0xd846ec28206404e0ULL, },
         { 0xe9721dc70769091eULL, 0xf8711c48091bf7e4ULL, },
+        { 0xf706df16dc8de6b6ULL, 0xf0d31b5827f9f42aULL, },
+        { 0x4961190d2be51b48ULL, 0x348a3e802e952784ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
index 2f1d23b..7ba15ef 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xd437b4e8f3b0139fULL, 0x08c7d980187d5896ULL, },
         { 0xc9576c1204f83042ULL, 0xd91d3e4709b06e36ULL, },
         { 0xfe2a6f6923268793ULL, 0x179e9377ef4766beULL, },
+        { 0xd437b4e8f3b0139fULL, 0x08c7d980187d5896ULL, },
+        { 0x33368b8a2619d525ULL, 0x6a47932120c31904ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
index e998e00..7ae4f0f 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8ffb559e72a2a622ULL, 0x8744321b668933a8ULL, },
         { 0x4ab4e3ab9f696cdcULL, 0xd21109f6644a26d0ULL, },
         { 0x8afc46ad9bff5437ULL, 0x1890b25301b40370ULL, },
+        { 0x8ffb559e72a2a622ULL, 0x8744321b668933a8ULL, },
+        { 0x53edf7dbd76122edULL, 0xbe9d5551c2f51a40ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
index e8db601..b18421a 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x670642166b8da1b6ULL, 0xe0d340587bf92d2aULL, },
         { 0x5c36512021725e8aULL, 0x8a465528c764a2e0ULL, },
         { 0xa8721dc73869b21eULL, 0xf27179481e1be5e4ULL, },
+        { 0x670642166b8da1b6ULL, 0xe0d340587bf92d2aULL, },
+        { 0x4961190d2be5df48ULL, 0x308afe8080952b84ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
index cf5bd13..5cdc7d2 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x5ad3b4e8bfaf139fULL, 0x8076d98091fe5896ULL, },
         { 0x4ff36c125a383042ULL, 0x2fe23e4744196e36ULL, },
         { 0x6e796f69cc7c8793ULL, 0x6e879377578266beULL, },
+        { 0x5ad3b4e8bfaf139fULL, 0x8076d98091fe5896ULL, },
+        { 0x33368b8aeab5d525ULL, 0x97d9932138871904ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
new file mode 100644
index 0000000..b58cc58
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MOD_S.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "MOD_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xdedededededededeULL, 0xdedededededededeULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0xe4aae2e4aae2e4aaULL, 0xe2e4aae2e4aae2e4ULL, },
+        { 0xfeaae3feaae3feaaULL, 0xe3feaae3feaae3feULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2121212121212121ULL, 0x2121212121212121ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x1b551d1b551d1b55ULL, 0x1d1b551d1b551d1bULL, },
+        { 0x01551c01551c0155ULL, 0x1c01551c01551c01ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe9cccce9cccce9ccULL, 0xcce9cccce9cccce9ULL, },
+        { 0xe8cccce8cccce8ccULL, 0xcce8cccce8cccce8ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1633331633331633ULL, 0x3316333316333316ULL, },
+        { 0x1733331733331733ULL, 0x3317333317333317ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe3e438e3e438e3e4ULL, 0x38e3e438e3e438e3ULL, },
+        { 0xe3e338e3e338e3e3ULL, 0x38e3e338e3e338e3ULL, },
+        { 0xe3f604e3f604e3f6ULL, 0x04e3f604e3f604e3ULL, },
+        { 0xe3f405e3f405e3f4ULL, 0x05e3f405e3f405e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff38ffff38ffffULL, 0x38ffff38ffff38ffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c1bc71c1bc71c1bULL, 0xc71c1bc71c1bc71cULL, },
+        { 0x1c1cc71c1cc71c1cULL, 0xc71c1cc71c1cc71cULL, },
+        { 0x1c09fb1c09fb1c09ULL, 0xfb1c09fb1c09fb1cULL, },
+        { 0x1c0bfa1c0bfa1c0bULL, 0xfa1c0bfa1c0bfa1cULL, },
+        { 0x1c71ff1c71ff1c71ULL, 0xff1c71ff1c71ff1cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x0028e6cc28621c00ULL, 0x03040b10fe3cb000ULL, },
+        { 0xdc10e6cc28005540ULL, 0x24170b00fe25fa0cULL, },
+        { 0xf81bfccc28001940ULL, 0x4b0d0b0efe39ec0cULL, },
+        { 0xfbbe002f25f5c708ULL, 0x12f7fd1a013f02fcULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xfbbe000d06f5c708ULL, 0x12f7f500151408fcULL, },
+        { 0xfbbe00164df5e508ULL, 0x12f7bb1a153f16fcULL, },
+        { 0xac5afcdee1cfe000ULL, 0x27d8fdffff2b2508ULL, },    /*  72  */
+        { 0xfc18aeaab9cffd00ULL, 0x03fcc6ffff2b2500ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac0bf0f7b900e5ceULL, 0x27f6c6ffab2b0714ULL, },
+        { 0x704f16190e31e20eULL, 0xd8f1f6d8ff42e200ULL, },
+        { 0x020d164d1131e206ULL, 0xf9facdf2fd03e200ULL, },
+        { 0x1c4f164d1700e24eULL, 0xdbf1fc00fe17e2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_S_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_S_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
new file mode 100644
index 0000000..9c7c877
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MOD_S.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "MOD_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xdddddddddddddddeULL, 0xdddddddddddddddeULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x0000000000000000ULL, 0xe38e38e38e38e38dULL, },
+        { 0xfffffffffffffffdULL, 0xe38e38e38e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222222222222221ULL, 0x2222222222222221ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x0000000000000002ULL, 0x1c71c71c71c71c71ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe93e93e93e93e93eULL, 0xccccccccccccccccULL, },
+        { 0xe93e93e93e93e93dULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x16c16c16c16c16c1ULL, 0x3333333333333333ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x05b05b05b05b05afULL, },
+        { 0xe38e38e38e38e38eULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xfa4fa4fa4fa4fa50ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0x1c71c71c71c71c71ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xffa2dbefac389060ULL, 0x127fda10bebdb718ULL, },
+        { 0xdc1038216e92c9c0ULL, 0x238e445f53508af8ULL, },
+        { 0xf8b9fd198694378eULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xfd40a74bf7d7c5e8ULL, 0x01e950cb80ac7f1cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0xd9589437a7be92acULL, },
+        { 0x019b20633f34191eULL, 0xffbfeb7528bed488ULL, },
+        { 0x1ca9c4f818016dceULL, 0xdda316d7ff992cc8ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_S_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
new file mode 100644
index 0000000..8e2913d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MOD_S.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "MOD_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x0000e38daaaa0000ULL, 0xe38daaaa0000e38dULL, },
+        { 0xfffde38eaaaafffdULL, 0xe38eaaaafffde38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2221222122212221ULL, 0x2221222122212221ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x1c711c7255551c71ULL, 0x1c7255551c711c72ULL, },
+        { 0x00021c7155550002ULL, 0x1c71555500021c71ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe93ecccccccce93eULL, 0xcccccccce93eccccULL, },
+        { 0xe93dcccccccce93dULL, 0xcccccccce93dccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x16c13333333316c1ULL, 0x3333333316c13333ULL, },
+        { 0x16c23333333316c2ULL, 0x3333333316c23333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e3e38ee38eULL, 0x38e3e38ee38e38e3ULL, },
+        { 0xe38e38e3e38de38eULL, 0x38e3e38de38e38e3ULL, },
+        { 0xe38e05aff4a0e38eULL, 0x05aff4a0e38e05afULL, },
+        { 0xe38e05b0f49ee38eULL, 0x05b0f49ee38e05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff38e3ffffffffULL, 0x38e3ffffffff38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c1c711c71ULL, 0xc71c1c711c71c71cULL, },
+        { 0x1c71c71c1c721c71ULL, 0xc71c1c721c71c71cULL, },
+        { 0x1c71fa500b5f1c71ULL, 0xfa500b5f1c71fa50ULL, },
+        { 0x1c71fa4f0b611c71ULL, 0xfa4f0b611c71fa4fULL, },
+        { 0x1c71ffff71c71c71ULL, 0xffff71c71c71ffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xffa2ffef28621c48ULL, 0x12820b5efe7bb00cULL, },
+        { 0xdc10e6cc28625540ULL, 0x238f0b5efe7bfa34ULL, },
+        { 0xf8b9fd19286219dcULL, 0x4b670b5efe7beaccULL, },
+        { 0xfbbe00632531c708ULL, 0x12f7ff4e017e0308ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xfbbe00630762c708ULL, 0x12f7f41b153f08d4ULL, },
+        { 0xfbbe00634d93e4baULL, 0x12f7bb1a153f183cULL, },
+        { 0xac5afa46e231e0c0ULL, 0x27d8ffd5febe2514ULL, },    /*  72  */
+        { 0xfd40ffe0b9cffd70ULL, 0x01eac6ffeae82514ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5af191b9cfe496ULL, 0x27d8c6ffab2b07b4ULL, },
+        { 0x704f164d0d6de24eULL, 0xd958fa84ffdfe2a0ULL, },
+        { 0x019b0042109ee24eULL, 0xffbbcdbefe3ee2a0ULL, },
+        { 0x1ca9164d1800e24eULL, 0xdda1fadafe17e2a0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_S_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
new file mode 100644
index 0000000..216a088
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MOD_S.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "MOD_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0xe38e38e4aaaaaaaaULL, 0xe38e38e2e38e38e4ULL, },
+        { 0xfffffffeaaaaaaaaULL, 0xe38e38e3fffffffeULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222222122222221ULL, 0x2222222122222221ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x1c71c71b55555555ULL, 0x1c71c71d1c71c71bULL, },
+        { 0x0000000155555555ULL, 0x1c71c71c00000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe93e93e9ccccccccULL, 0xcccccccce93e93e9ULL, },
+        { 0xe93e93e8ccccccccULL, 0xcccccccce93e93e8ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x16c16c1633333333ULL, 0x3333333316c16c16ULL, },
+        { 0x16c16c1733333333ULL, 0x3333333316c16c17ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e3e38e38e4ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e3e38e38e3ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e3f49f49f6ULL, 0x05b05b04e38e38e3ULL, },
+        { 0xe38e38e3f49f49f4ULL, 0x05b05b05e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x38e38e38ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c1c71c71bULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c1c71c71cULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c0b60b609ULL, 0xfa4fa4fb1c71c71cULL, },
+        { 0x1c71c71c0b60b60bULL, 0xfa4fa4fa1c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xffffffff1c71c71cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xffa2dbf828625540ULL, 0x127fda10fe7bb00cULL, },
+        { 0xdc10382228625540ULL, 0x238e445ffe7bb00cULL, },
+        { 0xf8b9fd1928625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe0063253171c8ULL, 0x12f7bb1a0002f3a4ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xfbbe006307635288ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaae231e0c0ULL, 0x27d8c6fffe985280ULL, },    /*  72  */
+        { 0xfd40a751b9cf8b80ULL, 0x01e950cbeae91e08ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d0d6d37ceULL, 0xd9589436ffb8aff4ULL, },
+        { 0x019b205b109e1b46ULL, 0xffbfeb74fe402e90ULL, },
+        { 0x1ca9c4f718016dceULL, 0xdda316d6fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_S_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
new file mode 100644
index 0000000..8fa878b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MOD_U.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "MOD_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c711f1c711f1c71ULL, 0x1f1c711f1c711f1cULL, },
+        { 0x031d38031d38031dULL, 0x38031d38031d3803ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0xaa1c02aa1c02aa1cULL, 0x02aa1c02aa1c02aaULL, },
+        { 0x0239aa0239aa0239ULL, 0xaa0239aa0239aa02ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x55551d55551d5555ULL, 0x1d55551d55551d55ULL, },
+        { 0x0155550155550155ULL, 0x5501555501555501ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xcc3e24cc3e24cc3eULL, 0x24cc3e24cc3e24ccULL, },
+        { 0x085b05085b05085bULL, 0x05085b05085b0508ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1733331733331733ULL, 0x3317333317333317ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x398e38398e38398eULL, 0x38398e38398e3839ULL, },
+        { 0x3939383939383939ULL, 0x3839393839393839ULL, },
+        { 0x178e38178e38178eULL, 0x38178e38178e3817ULL, },
+        { 0x1728051728051728ULL, 0x0517280517280517ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x031d38031d38031dULL, 0x38031d38031d3803ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c711d1c711d1c71ULL, 0x1d1c711d1c711d1cULL, },
+        { 0x1c1c1d1c1c1d1c1cULL, 0x1d1c1c1d1c1c1d1cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c0b2e1c0b2e1c0bULL, 0x2e1c0b2e1c0b2e1cULL, },
+        { 0x1c711f1c711f1c71ULL, 0x1f1c711f1c711f1cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x886ae60628625500ULL, 0x03670b10023c0c0cULL, },
+        { 0x8810382228625540ULL, 0x24670b5e53251c0cULL, },
+        { 0x181b0a3228005540ULL, 0x4b670b5e5539b00cULL, },
+        { 0x7354006325311d08ULL, 0x1229001a153f5200ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f0a00634d933c08ULL, 0x121fbb1a1514080cULL, },
+        { 0x1b2000164d00c708ULL, 0x1206331a153f525cULL, },
+        { 0x245aaeaa190b3600ULL, 0x270a0043ab2b2508ULL, },    /*  72  */
+        { 0xac5aae471f3c8b00ULL, 0x03d80b15032b2514ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b14105b0b8b32ULL, 0x27d83e27022b2514ULL, },
+        { 0x704f164d0e31380eULL, 0x4223041ca9423204ULL, },
+        { 0x704f164d11311b06ULL, 0x0ff1880801033ea0ULL, },
+        { 0x704f164d5e31574eULL, 0x181988d8a9170400ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_U_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_U_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
new file mode 100644
index 0000000..d5053d7
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MOD_U.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "MOD_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x1c71c71c71c71c73ULL, },
+        { 0x0000000000000006ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x0000000000000001ULL, },
+        { 0x0000000000000004ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x5555555555555555ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x0000000000000002ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0x2222222222222223ULL, },
+        { 0x05b05b05b05b05b5ULL, 0x05b05b05b05b05b0ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000006ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0x2d82d82d82d82d83ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x1c71c71c71c71c73ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x127fda10bebdb718ULL, },
+        { 0x886ae6cc28625540ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07eca3072f2ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x73531997253171c8ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b893c43b88ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x1b1fd3c89130026cULL, 0x12f7bb1a153f52fcULL, },
+        { 0x23efc7de916d3640ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x01e950cb80ac7f1cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x428a7d79aac73294ULL, },
+        { 0x704f164d5e31e24eULL, 0x092b6b2214879dbcULL, },
+        { 0x704f164d5e31e24eULL, 0x166733d9a7c17364ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_U_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
new file mode 100644
index 0000000..9604ee1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MOD_U.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "MOD_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c711c7371c71c71ULL, 0x1c7371c71c711c73ULL, },
+        { 0x000638e31c710006ULL, 0x38e31c71000638e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0xaaaa00011c72aaaaULL, 0x00011c72aaaa0001ULL, },
+        { 0x0004aaaa38e30004ULL, 0xaaaa38e30004aaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x55551c7255555555ULL, 0x1c72555555551c72ULL, },
+        { 0x0002555555550002ULL, 0x5555555500025555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xcccc22233e94ccccULL, 0x22233e94cccc2223ULL, },
+        { 0x05b505b05b0505b5ULL, 0x05b05b0505b505b0ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x16c23333333316c2ULL, 0x3333333316c23333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e438e38e3838e4ULL, 0x38e38e3838e438e3ULL, },
+        { 0x38e438e338e338e4ULL, 0x38e338e338e438e3ULL, },
+        { 0x16c238e38e3816c2ULL, 0x38e38e3816c238e3ULL, },
+        { 0x16c205b027d216c2ULL, 0x05b027d216c205b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000638e31c710006ULL, 0x38e31c71000638e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c711c7271c71c71ULL, 0x1c7271c71c711c72ULL, },
+        { 0x1c711c721c721c71ULL, 0x1c721c721c711c72ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c712d830b611c71ULL, 0x2d830b611c712d83ULL, },
+        { 0x1c711c7371c71c71ULL, 0x1c7371c71c711c73ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x886a005028625540ULL, 0x12820b5e14c60a14ULL, },
+        { 0x886a382228625540ULL, 0x238f0b5e53501bbcULL, },
+        { 0x181b07ca28625540ULL, 0x4b670b5e5539b00cULL, },
+        { 0x7354006325311c88ULL, 0x12f7053a153f52fcULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6400634d933b88ULL, 0x12f7bb1a153f08d4ULL, },
+        { 0x1b2000634d93c708ULL, 0x12f73242153f52fcULL, },
+        { 0x23f0aeaa18473640ULL, 0x27d805c1ab2b2514ULL, },    /*  72  */
+        { 0xac5a00411ea98b80ULL, 0x01ea0be501332514ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b128f5b9e8b80ULL, 0x27d83e2701e92514ULL, },
+        { 0x704f164d0d6d37ceULL, 0x428a0070a9423294ULL, },
+        { 0x704f0042109e1b46ULL, 0x093088d814893ca8ULL, },
+        { 0x704f164d5e3156ceULL, 0x166988d8a9420428ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_U_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
new file mode 100644
index 0000000..0313e48
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MOD_U.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "MOD_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x1c71c71f1c71c71cULL, },
+        { 0x000000031c71c71dULL, 0x38e38e3800000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0xaaaaaaaa1c71c71cULL, 0x00000002aaaaaaaaULL, },
+        { 0x0000000238e38e39ULL, 0xaaaaaaaa00000002ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x5555555555555555ULL, 0x1c71c71d55555555ULL, },
+        { 0x0000000155555555ULL, 0x5555555500000001ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xcccccccc3e93e93eULL, 0x22222224ccccccccULL, },
+        { 0x05b05b085b05b05bULL, 0x05b05b0505b05b08ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x16c16c1733333333ULL, 0x3333333316c16c17ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e398e38e38eULL, 0x38e38e3838e38e39ULL, },
+        { 0x38e38e3938e38e39ULL, 0x38e38e3838e38e39ULL, },
+        { 0x16c16c178e38e38eULL, 0x38e38e3816c16c17ULL, },
+        { 0x16c16c1727d27d28ULL, 0x05b05b0516c16c17ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000031c71c71dULL, 0x38e38e3800000003ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0x1c71c71d1c71c71cULL, },
+        { 0x1c71c71c1c71c71cULL, 0x1c71c71d1c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c0b60b60bULL, 0x2d82d82e1c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0x1c71c71f1c71c71cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x127fda1014c31f38ULL, },
+        { 0x886ae6cc28625540ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07f28625540ULL, 0x4b670b5e5538cd6cULL, },
+        { 0x73531997253171c8ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b94d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x1b1fd3c94d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x23efc7de18463680ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaa1ea7fd70ULL, 0x01e950cb01308d34ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x27d8c6ff01e84274ULL, },
+        { 0x704f164d0d6d37ceULL, 0x428a7d7aa942e2a0ULL, },
+        { 0x704f164d109e1b46ULL, 0x092b6b2214879dbcULL, },
+        { 0x704f164d5e31e24eULL, 0x166733dba942e2a0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MOD_U_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c
index f152608..f747485 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xb69bf1d4cc591b07ULL, 0xdc7e3510397df77dULL, },
         { 0x9712fb9b1db7ec38ULL, 0xbccff56b01071259ULL, },
         { 0xfc43001139150d37ULL, 0xef194023f19aecf4ULL, },
+        { 0xb69bf1d4cc591b07ULL, 0xdc7e3510397df77dULL, },
+        { 0x628a03e2455006e3ULL, 0x65a26eec3ac806bdULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c
index df815ee..1552715 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xb69baa39cc590fcdULL, 0xdc7e6df7397c58d9ULL, },
         { 0x9713a7171db7f3a5ULL, 0xbccfb4690107236fULL, },
         { 0xfc439edc3916c1e4ULL, 0xef19389cf19a0fddULL, },
+        { 0xb69baa39cc590fcdULL, 0xdc7e6df7397c58d9ULL, },
+        { 0x628a97e4455157d3ULL, 0x65a1c5e13ac736e1ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c
index fd0a5fa..f32b269 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xb69bf1d4cc591b07ULL, 0xdc7f3511397df77eULL, },
         { 0x9713fb9c1db7ec39ULL, 0xbccff56b01081259ULL, },
         { 0xfc44001139160d37ULL, 0xef1a4023f19aecf5ULL, },
+        { 0xb69bf1d4cc591b07ULL, 0xdc7f3511397df77eULL, },
+        { 0x628a03e3455006e4ULL, 0x65a36eec3ac806beULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c
index f28b0d0..8eba62e 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xb69baa3acc590fcdULL, 0xdc7e6df7397c58daULL, },
         { 0x9713a7171db7f3a6ULL, 0xbccfb46a0107236fULL, },
         { 0xfc439edd3916c1e4ULL, 0xef19389cf19a0fdeULL, },
+        { 0xb69baa3acc590fcdULL, 0xdc7e6df7397c58daULL, },
+        { 0x628a97e4455157d3ULL, 0x65a1c5e23ac736e2ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
index 6beeda9..788fb71 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x40c6f422ee9fb600ULL, 0x7b583028e316aa80ULL, },
         { 0x80b6c45cb0c20a80ULL, 0x4ff7d850aeb66080ULL, },
         { 0xd0a200c74623ae70ULL, 0xea8758f0dd3e6480ULL, },
+        { 0x40c6f422ee9fb600ULL, 0x7b583028e316aa80ULL, },
+        { 0x0061e429846184c4ULL, 0xa9e1404091048400ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
index 3205d4b..40d1348 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x76a5ab8089e38100ULL, 0xa1019a60d4dad480ULL, },
         { 0xfbe1883aee787980ULL, 0x821d25438dd09f80ULL, },
         { 0xedbf72842143b470ULL, 0x7f8223caefce5580ULL, },
+        { 0x76a5ab8089e38100ULL, 0xa1019a60d4dad480ULL, },
+        { 0x4bb436d5b1e9cfc4ULL, 0x12d1ceb0e31ee400ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
index e7bd985..089d08f 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8fc62522929f8100ULL, 0x7a585f288416d480ULL, },
         { 0x78b6f35cb6c27980ULL, 0xb6f78750ceb69f80ULL, },
         { 0xcfa29fc7d323b470ULL, 0xe587adf0113e5580ULL, },
+        { 0x8fc62522929f8100ULL, 0x7a585f288416d480ULL, },
+        { 0x386153290561cfc4ULL, 0x5ce136403504e400ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
index 9c318b3..21b194c 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0xe8bf252289e38100ULL, 0x91ae5f28d4dad480ULL, },
         { 0xb0f0f35cee787980ULL, 0xd67987508dd09f80ULL, },
         { 0x7abb9fc72143b470ULL, 0x11e5adf0efce5580ULL, },
+        { 0xe8bf252289e38100ULL, 0x91ae5f28d4dad480ULL, },
+        { 0x25775329b1e9cfc4ULL, 0xdfd63640e31ee400ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
new file mode 100644
index 0000000..715d2a2
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ASUB_S.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ASUB_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0x1c71391c71391c71ULL, 0x391c71391c71391cULL, },
+        { 0x1d72381d72381d72ULL, 0x381d72381d72381dULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1d72381d72381d72ULL, 0x381d72381d72381dULL, },
+        { 0x1c71391c71391c71ULL, 0x391c71391c71391cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  16  */
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x391c8e391c8e391cULL, 0x8e391c8e391c8e39ULL, },
+        { 0x72c71d72c71d72c7ULL, 0x1d72c71d72c71d72ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x72c71d72c71d72c7ULL, 0x1d72c71d72c71d72ULL, },
+        { 0x391c8e391c8e391cULL, 0x8e391c8e391c8e39ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  32  */
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x6767676767676767ULL, 0x6767676767676767ULL, },
+        { 0x173e6c173e6c173eULL, 0x6c173e6c173e6c17ULL, },
+        { 0x50a50550a50550a5ULL, 0x0550a50550a50550ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x6767676767676767ULL, 0x6767676767676767ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x50a50550a50550a5ULL, 0x0550a50550a50550ULL, },
+        { 0x173e6c173e6c173eULL, 0x6c173e6c173e6c17ULL, },
+        { 0x1c71391c71391c71ULL, 0x391c71391c71391cULL, },    /*  48  */
+        { 0x1d72381d72381d72ULL, 0x381d72381d72381dULL, },
+        { 0x391c8e391c8e391cULL, 0x8e391c8e391c8e39ULL, },
+        { 0x72c71d72c71d72c7ULL, 0x1d72c71d72c71d72ULL, },
+        { 0x173e6c173e6c173eULL, 0x6c173e6c173e6c17ULL, },
+        { 0x50a50550a50550a5ULL, 0x0550a50550a50550ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x39e37139e37139e3ULL, 0x7139e37139e37139ULL, },
+        { 0x1d72381d72381d72ULL, 0x381d72381d72381dULL, },    /*  56  */
+        { 0x1c71391c71391c71ULL, 0x391c71391c71391cULL, },
+        { 0x72c71d72c71d72c7ULL, 0x1d72c71d72c71d72ULL, },
+        { 0x391c8e391c8e391cULL, 0x8e391c8e391c8e39ULL, },
+        { 0x50a50550a50550a5ULL, 0x0550a50550a50550ULL, },
+        { 0x173e6c173e6c173eULL, 0x6c173e6c173e6c17ULL, },
+        { 0x39e37139e37139e3ULL, 0x7139e37139e37139ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x73ac1a9725cf8e38ULL, 0x39705044173ca210ULL, },
+        { 0x241038226f93cac0ULL, 0x248f455f53507508ULL, },
+        { 0xe81b30813631730eULL, 0xbe7683865539326cULL, },
+        { 0x73ac1a9725cf8e38ULL, 0x39705044173ca210ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f9c52b9943c3c88ULL, 0x151f0b1b6a142d18ULL, },
+        { 0x75911616119e1b46ULL, 0x850633426c03705cULL, },
+        { 0x241038226f93cac0ULL, 0x248f455f53507508ULL, },    /*  72  */
+        { 0x4f9c52b9943c3c88ULL, 0x151f0b1b6a142d18ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc40b68a3a56257ceULL, 0x9a193e2702174374ULL, },
+        { 0xe81b30813631730eULL, 0xbe7683865539326cULL, },
+        { 0x75911616119e1b46ULL, 0x850633426c03705cULL, },
+        { 0xc40b68a3a56257ceULL, 0x9a193e2702174374ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_S_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_S_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
new file mode 100644
index 0000000..36e35bd
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ASUB_S.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ASUB_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  16  */
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  32  */
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x6666666666666667ULL, 0x6666666666666667ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x05b05b05b05b05b0ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x6666666666666667ULL, 0x6666666666666667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x05b05b05b05b05b0ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e4ULL, },    /*  48  */
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e3ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x05b05b05b05b05b0ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x73531997253171c8ULL, 0x386f5044e93c5d10ULL, },
+        { 0x23efc7de916d3640ULL, 0x238e445f53508af8ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0xbd7582865538cd6cULL, },
+        { 0x73531997253171c8ULL, 0x386f5044e93c5d10ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b893c43b88ULL, 0x14e10be595ebd218ULL, },
+        { 0x749115ea109e1b46ULL, 0x850632416bfc705cULL, },
+        { 0x23efc7de916d3640ULL, 0x238e445f53508af8ULL, },    /*  72  */
+        { 0x4f6351b893c43b88ULL, 0x14e10be595ebd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc3f467a2a46256ceULL, 0x99e73e2701e84274ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0xbd7582865538cd6cULL, },
+        { 0x749115ea109e1b46ULL, 0x850632416bfc705cULL, },
+        { 0xc3f467a2a46256ceULL, 0x99e73e2701e84274ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_S_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
new file mode 100644
index 0000000..b1e0043
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ASUB_S.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ASUB_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0x1c7138e471c71c71ULL, 0x38e471c71c7138e4ULL, },
+        { 0x1c7238e371c81c72ULL, 0x38e371c81c7238e3ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c7238e371c81c72ULL, 0x38e371c81c7238e3ULL, },
+        { 0x1c7138e471c71c71ULL, 0x38e471c71c7138e4ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  16  */
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x38e48e391c7238e4ULL, 0x8e391c7238e48e39ULL, },
+        { 0x71c71c72c71d71c7ULL, 0x1c72c71d71c71c72ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c72c71d71c7ULL, 0x1c72c71d71c71c72ULL, },
+        { 0x38e48e391c7238e4ULL, 0x8e391c7238e48e39ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  32  */
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x6667666766676667ULL, 0x6667666766676667ULL, },
+        { 0x16c26c173e9416c2ULL, 0x6c173e9416c26c17ULL, },
+        { 0x4fa505b0a4fb4fa5ULL, 0x05b0a4fb4fa505b0ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x6667666766676667ULL, 0x6667666766676667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa505b0a4fb4fa5ULL, 0x05b0a4fb4fa505b0ULL, },
+        { 0x16c26c173e9416c2ULL, 0x6c173e9416c26c17ULL, },
+        { 0x1c7138e471c71c71ULL, 0x38e471c71c7138e4ULL, },    /*  48  */
+        { 0x1c7238e371c81c72ULL, 0x38e371c81c7238e3ULL, },
+        { 0x38e48e391c7238e4ULL, 0x8e391c7238e48e39ULL, },
+        { 0x71c71c72c71d71c7ULL, 0x1c72c71d71c71c72ULL, },
+        { 0x16c26c173e9416c2ULL, 0x6c173e9416c26c17ULL, },
+        { 0x4fa505b0a4fb4fa5ULL, 0x05b0a4fb4fa505b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e371c7e38f38e3ULL, 0x71c7e38f38e371c7ULL, },
+        { 0x1c7238e371c81c72ULL, 0x38e371c81c7238e3ULL, },    /*  56  */
+        { 0x1c7138e471c71c71ULL, 0x38e471c71c7138e4ULL, },
+        { 0x71c71c72c71d71c7ULL, 0x1c72c71d71c71c72ULL, },
+        { 0x38e48e391c7238e4ULL, 0x8e391c7238e48e39ULL, },
+        { 0x4fa505b0a4fb4fa5ULL, 0x05b0a4fb4fa505b0ULL, },
+        { 0x16c26c173e9416c2ULL, 0x6c173e9416c26c17ULL, },
+        { 0x38e371c7e38f38e3ULL, 0x71c7e38f38e371c7ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x7354199725318e38ULL, 0x3870504416c4a2f0ULL, },
+        { 0x23f038226e93c9c0ULL, 0x238f445f53507508ULL, },
+        { 0xe7e52f8135cf72f2ULL, 0xbd76828655393294ULL, },
+        { 0x7354199725318e38ULL, 0x3870504416c4a2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6451b993c43b88ULL, 0x14e10be56a142de8ULL, },
+        { 0x749115ea109e1b46ULL, 0x850632426bfd705cULL, },
+        { 0x23f038226e93c9c0ULL, 0x238f445f53507508ULL, },    /*  72  */
+        { 0x4f6451b993c43b88ULL, 0x14e10be56a142de8ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc3f567a3a46256ceULL, 0x99e73e2701e94274ULL, },
+        { 0xe7e52f8135cf72f2ULL, 0xbd76828655393294ULL, },
+        { 0x749115ea109e1b46ULL, 0x850632426bfd705cULL, },
+        { 0xc3f567a3a46256ceULL, 0x99e73e2701e94274ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_S_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
new file mode 100644
index 0000000..f873853
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ASUB_S.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ASUB_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e391c71c71cULL, },
+        { 0x1c71c71d71c71c72ULL, 0x38e38e381c71c71dULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71d71c71c72ULL, 0x38e38e381c71c71dULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e391c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  16  */
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x38e38e391c71c71cULL, 0x8e38e38e38e38e39ULL, },
+        { 0x71c71c72c71c71c7ULL, 0x1c71c71d71c71c72ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c72c71c71c7ULL, 0x1c71c71d71c71c72ULL, },
+        { 0x38e38e391c71c71cULL, 0x8e38e38e38e38e39ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  32  */
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x6666666766666667ULL, 0x6666666766666667ULL, },
+        { 0x16c16c173e93e93eULL, 0x6c16c16c16c16c17ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0x05b05b054fa4fa50ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x6666666766666667ULL, 0x6666666766666667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0x05b05b054fa4fa50ULL, },
+        { 0x16c16c173e93e93eULL, 0x6c16c16c16c16c17ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e391c71c71cULL, },    /*  48  */
+        { 0x1c71c71d71c71c72ULL, 0x38e38e381c71c71dULL, },
+        { 0x38e38e391c71c71cULL, 0x8e38e38e38e38e39ULL, },
+        { 0x71c71c72c71c71c7ULL, 0x1c71c71d71c71c72ULL, },
+        { 0x16c16c173e93e93eULL, 0x6c16c16c16c16c17ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0x05b05b054fa4fa50ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e38e39e38e38e3ULL, 0x71c71c7138e38e39ULL, },
+        { 0x1c71c71d71c71c72ULL, 0x38e38e381c71c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x38e38e391c71c71cULL, },
+        { 0x71c71c72c71c71c7ULL, 0x1c71c71d71c71c72ULL, },
+        { 0x38e38e391c71c71cULL, 0x8e38e38e38e38e39ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0x05b05b054fa4fa50ULL, },
+        { 0x16c16c173e93e93eULL, 0x6c16c16c16c16c17ULL, },
+        { 0x38e38e39e38e38e3ULL, 0x71c71c7138e38e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x73531997253171c8ULL, 0x386f504416c3a2f0ULL, },
+        { 0x23efc7de6e92c9c0ULL, 0x238e445f53508af8ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0xbd7582865538cd6cULL, },
+        { 0x73531997253171c8ULL, 0x386f504416c3a2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b993c43b88ULL, 0x14e10be56a142de8ULL, },
+        { 0x749115ea109e1b46ULL, 0x850632426bfc705cULL, },
+        { 0x23efc7de6e92c9c0ULL, 0x238e445f53508af8ULL, },    /*  72  */
+        { 0x4f6351b993c43b88ULL, 0x14e10be56a142de8ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc3f467a3a46256ceULL, 0x99e73e2701e84274ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0xbd7582865538cd6cULL, },
+        { 0x749115ea109e1b46ULL, 0x850632426bfc705cULL, },
+        { 0xc3f467a3a46256ceULL, 0x99e73e2701e84274ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_S_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
new file mode 100644
index 0000000..4b541c4
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ASUB_U.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ASUB_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x391c72391c72391cULL, 0x72391c72391c7239ULL, },
+        { 0x8e391d8e391d8e39ULL, 0x1d8e391d8e391d8eULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8e391d8e391d8e39ULL, 0x1d8e391d8e391d8eULL, },
+        { 0x391c72391c72391cULL, 0x72391c72391c7239ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x173e94173e94173eULL, 0x94173e94173e9417ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x173e94173e94173eULL, 0x94173e94173e9417ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x391c72391c72391cULL, 0x72391c72391c7239ULL, },
+        { 0x8e391d8e391d8e39ULL, 0x1d8e391d8e391d8eULL, },
+        { 0x173e94173e94173eULL, 0x94173e94173e9417ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71d8fc71d8fc71dULL, 0x8fc71d8fc71d8fc7ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x8e391d8e391d8e39ULL, 0x1d8e391d8e391d8eULL, },
+        { 0x391c72391c72391cULL, 0x72391c72391c7239ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x173e94173e94173eULL, 0x94173e94173e9417ULL, },
+        { 0xc71d8fc71d8fc71dULL, 0x8fc71d8fc71d8fc7ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x7354e66925317238ULL, 0x3990b044e93c5ef0ULL, },
+        { 0x24103822916d3640ULL, 0x2471bba153508b08ULL, },
+        { 0x181bd07f36318d0eULL, 0x428a7d7a55393294ULL, },
+        { 0x7354e66925317238ULL, 0x3990b044e93c5ef0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f64ae476c3c3c78ULL, 0x151f0be596142de8ULL, },
+        { 0x8b6f161611621b46ULL, 0x7b0633be9403905cULL, },
+        { 0x24103822916d3640ULL, 0x2471bba153508b08ULL, },    /*  72  */
+        { 0x4f64ae476c3c3c78ULL, 0x151f0be596142de8ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9e5732ULL, 0x66193e270217bd8cULL, },
+        { 0x181bd07f36318d0eULL, 0x428a7d7a55393294ULL, },
+        { 0x8b6f161611621b46ULL, 0x7b0633be9403905cULL, },
+        { 0x3c0b985d5b9e5732ULL, 0x66193e270217bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_U_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_U_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
new file mode 100644
index 0000000..c937e53
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ASUB_U.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ASUB_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x1c71c71c71c71c72ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x93e93e93e93e93e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x93e93e93e93e93e9ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x93e93e93e93e93e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c71c71c71dULL, 0x8e38e38e38e38e39ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x8e38e38e38e38e39ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x71c71c71c71c71c7ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x93e93e93e93e93e9ULL, },
+        { 0xc71c71c71c71c71dULL, 0x8e38e38e38e38e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x73531997253171c8ULL, 0x386f5044e93c5d10ULL, },
+        { 0x23efc7de916d3640ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07eca3072f2ULL, 0x428a7d79aac73294ULL, },
+        { 0x73531997253171c8ULL, 0x386f5044e93c5d10ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b893c43b88ULL, 0x14e10be595ebd218ULL, },
+        { 0x8b6eea15ef61e4baULL, 0x7af9cdbe94038fa4ULL, },
+        { 0x23efc7de916d3640ULL, 0x238e445f53508af8ULL, },    /*  72  */
+        { 0x4f6351b893c43b88ULL, 0x14e10be595ebd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x6618c1d8fe17bd8cULL, },
+        { 0x181bd07eca3072f2ULL, 0x428a7d79aac73294ULL, },
+        { 0x8b6eea15ef61e4baULL, 0x7af9cdbe94038fa4ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x6618c1d8fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_U_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
new file mode 100644
index 0000000..0989dcf
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ASUB_U.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ASUB_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x38e471c71c7238e4ULL, 0x71c71c7238e471c7ULL, },
+        { 0x8e391c7238e38e39ULL, 0x1c7238e38e391c72ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8e391c7238e38e39ULL, 0x1c7238e38e391c72ULL, },
+        { 0x38e471c71c7238e4ULL, 0x71c71c7238e471c7ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x16c293e93e9416c2ULL, 0x93e93e9416c293e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x16c293e93e9416c2ULL, 0x93e93e9416c293e9ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e471c71c7238e4ULL, 0x71c71c7238e471c7ULL, },
+        { 0x8e391c7238e38e39ULL, 0x1c7238e38e391c72ULL, },
+        { 0x16c293e93e9416c2ULL, 0x93e93e9416c293e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71d8e391c71c71dULL, 0x8e391c71c71d8e39ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x8e391c7238e38e39ULL, 0x1c7238e38e391c72ULL, },
+        { 0x38e471c71c7238e4ULL, 0x71c71c7238e471c7ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x16c293e93e9416c2ULL, 0x93e93e9416c293e9ULL, },
+        { 0xc71d8e391c71c71dULL, 0x8e391c71c71d8e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x7354e669253171c8ULL, 0x3870afbce93c5d10ULL, },
+        { 0x23f03822916d3640ULL, 0x238fbba153508af8ULL, },
+        { 0x181bd07f35cf8d0eULL, 0x428a7d7a55393294ULL, },
+        { 0x7354e669253171c8ULL, 0x3870afbce93c5d10ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f64ae476c3c3b88ULL, 0x14e10be595ec2de8ULL, },
+        { 0x8b6f15ea109e1b46ULL, 0x7afa324294038fa4ULL, },
+        { 0x23f03822916d3640ULL, 0x238fbba153508af8ULL, },    /*  72  */
+        { 0x4f64ae476c3c3b88ULL, 0x14e10be595ec2de8ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9e56ceULL, 0x66193e2701e9bd8cULL, },
+        { 0x181bd07f35cf8d0eULL, 0x428a7d7a55393294ULL, },
+        { 0x8b6f15ea109e1b46ULL, 0x7afa324294038fa4ULL, },
+        { 0x3c0b985d5b9e56ceULL, 0x66193e2701e9bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_U_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
new file mode 100644
index 0000000..4ab5a3c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ASUB_U.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ASUB_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x38e38e391c71c71cULL, 0x71c71c7238e38e39ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x1c71c71d8e38e38eULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x1c71c71d8e38e38eULL, },
+        { 0x38e38e391c71c71cULL, 0x71c71c7238e38e39ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x16c16c173e93e93eULL, 0x93e93e9416c16c17ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x16c16c173e93e93eULL, 0x93e93e9416c16c17ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e391c71c71cULL, 0x71c71c7238e38e39ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x1c71c71d8e38e38eULL, },
+        { 0x16c16c173e93e93eULL, 0x93e93e9416c16c17ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c71c71c71dULL, 0x8e38e38fc71c71c7ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x8e38e38e38e38e39ULL, 0x1c71c71d8e38e38eULL, },
+        { 0x38e38e391c71c71cULL, 0x71c71c7238e38e39ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x16c16c173e93e93eULL, 0x93e93e9416c16c17ULL, },
+        { 0xc71c71c71c71c71dULL, 0x8e38e38fc71c71c7ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x73531997253171c8ULL, 0x386f5044e93c5d10ULL, },
+        { 0x23efc7de916d3640ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07f35cf8d0eULL, 0x428a7d7a5538cd6cULL, },
+        { 0x73531997253171c8ULL, 0x386f5044e93c5d10ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b96c3bc478ULL, 0x14e10be595ebd218ULL, },
+        { 0x8b6eea16109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+        { 0x23efc7de916d3640ULL, 0x238e445f53508af8ULL, },    /*  72  */
+        { 0x4f6351b96c3bc478ULL, 0x14e10be595ebd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x6618c1d901e84274ULL, },
+        { 0x181bd07f35cf8d0eULL, 0x428a7d7a5538cd6cULL, },
+        { 0x8b6eea16109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x6618c1d901e84274ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ASUB_U_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
new file mode 100644
index 0000000..0d2cca7
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction HSUB_S.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "HSUB_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0xffffffffaaaaaaaaULL, 0xffffffffaaaaaaaaULL, },
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0xffffffffccccccccULL, 0xffffffffccccccccULL, },
+        { 0x0000000071c71c71ULL, 0x000000001c71c71cULL, },
+        { 0xffffffff8e38e38eULL, 0xffffffffe38e38e3ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000055555556ULL, 0x0000000055555556ULL, },
+        { 0xffffffffaaaaaaabULL, 0xffffffffaaaaaaabULL, },
+        { 0x0000000033333334ULL, 0x0000000033333334ULL, },
+        { 0xffffffffcccccccdULL, 0xffffffffcccccccdULL, },
+        { 0x0000000071c71c72ULL, 0x000000001c71c71dULL, },
+        { 0xffffffff8e38e38fULL, 0xffffffffe38e38e4ULL, },
+        { 0xffffffffaaaaaaabULL, 0xffffffffaaaaaaabULL, },    /*  16  */
+        { 0xffffffffaaaaaaaaULL, 0xffffffffaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff55555555ULL, 0xffffffff55555555ULL, },
+        { 0xffffffffdddddddeULL, 0xffffffffdddddddeULL, },
+        { 0xffffffff77777777ULL, 0xffffffff77777777ULL, },
+        { 0x000000001c71c71cULL, 0xffffffffc71c71c7ULL, },
+        { 0xffffffff38e38e39ULL, 0xffffffff8e38e38eULL, },
+        { 0x0000000055555556ULL, 0x0000000055555556ULL, },    /*  24  */
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0x00000000aaaaaaabULL, 0x00000000aaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000088888889ULL, 0x0000000088888889ULL, },
+        { 0x0000000022222222ULL, 0x0000000022222222ULL, },
+        { 0x00000000c71c71c7ULL, 0x0000000071c71c72ULL, },
+        { 0xffffffffe38e38e4ULL, 0x0000000038e38e39ULL, },
+        { 0xffffffffcccccccdULL, 0xffffffffcccccccdULL, },    /*  32  */
+        { 0xffffffffccccccccULL, 0xffffffffccccccccULL, },
+        { 0x0000000022222222ULL, 0x0000000022222222ULL, },
+        { 0xffffffff77777777ULL, 0xffffffff77777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff99999999ULL, 0xffffffff99999999ULL, },
+        { 0x000000003e93e93eULL, 0xffffffffe93e93e9ULL, },
+        { 0xffffffff5b05b05bULL, 0xffffffffb05b05b0ULL, },
+        { 0x0000000033333334ULL, 0x0000000033333334ULL, },    /*  40  */
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0x0000000088888889ULL, 0x0000000088888889ULL, },
+        { 0xffffffffdddddddeULL, 0xffffffffdddddddeULL, },
+        { 0x0000000066666667ULL, 0x0000000066666667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000a4fa4fa5ULL, 0x000000004fa4fa50ULL, },
+        { 0xffffffffc16c16c2ULL, 0x0000000016c16c17ULL, },
+        { 0xffffffffe38e38e4ULL, 0x0000000038e38e39ULL, },    /*  48  */
+        { 0xffffffffe38e38e3ULL, 0x0000000038e38e38ULL, },
+        { 0x0000000038e38e39ULL, 0x000000008e38e38eULL, },
+        { 0xffffffff8e38e38eULL, 0xffffffffe38e38e3ULL, },
+        { 0x0000000016c16c17ULL, 0x000000006c16c16cULL, },
+        { 0xffffffffb05b05b0ULL, 0x0000000005b05b05ULL, },
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0xffffffff71c71c72ULL, 0x000000001c71c71cULL, },
+        { 0x000000001c71c71dULL, 0xffffffffc71c71c8ULL, },    /*  56  */
+        { 0x000000001c71c71cULL, 0xffffffffc71c71c7ULL, },
+        { 0x0000000071c71c72ULL, 0x000000001c71c71dULL, },
+        { 0xffffffffc71c71c7ULL, 0xffffffff71c71c72ULL, },
+        { 0x000000004fa4fa50ULL, 0xfffffffffa4fa4fbULL, },
+        { 0xffffffffe93e93e9ULL, 0xffffffff93e93e94ULL, },
+        { 0x000000008e38e38eULL, 0xffffffffe38e38e4ULL, },
+        { 0xffffffffaaaaaaabULL, 0xffffffffaaaaaaabULL, },
+        { 0xffffffff6008918cULL, 0x000000004ceb5b52ULL, },    /*  64  */
+        { 0xffffffff3ad71fc4ULL, 0x000000003627b862ULL, },
+        { 0xffffffffce9b5b4cULL, 0x00000000a03be64aULL, },
+        { 0xffffffff2a39047eULL, 0x00000000a22428beULL, },
+        { 0xffffffffd35bab23ULL, 0x00000000147c0b0eULL, },
+        { 0xffffffffae2a395bULL, 0xfffffffffdb8681eULL, },
+        { 0x0000000041ee74e3ULL, 0x0000000067cc9606ULL, },
+        { 0xffffffff9d8c1e15ULL, 0x0000000069b4d87aULL, },
+        { 0xffffffff83f8596aULL, 0x00000000295d16f3ULL, },    /*  72  */
+        { 0xffffffff5ec6e7a2ULL, 0x0000000012997403ULL, },
+        { 0xfffffffff28b232aULL, 0x000000007cada1ebULL, },
+        { 0xffffffff4e28cc5cULL, 0x000000007e95e45fULL, },
+        { 0x0000000047ecc10dULL, 0xffffffff8f75d8ccULL, },
+        { 0x0000000022bb4f45ULL, 0xffffffff78b235dcULL, },
+        { 0x00000000b67f8acdULL, 0xffffffffe2c663c4ULL, },
+        { 0x00000000121d33ffULL, 0xffffffffe4aea638ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_S_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
new file mode 100644
index 0000000..334bb3c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction HSUB_S.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "HSUB_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0xffaaffaaffaaffaaULL, 0xffaaffaaffaaffaaULL, },
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0xffccffccffccffccULL, 0xffccffccffccffccULL, },
+        { 0x0071001cffc70071ULL, 0x001cffc70071001cULL, },
+        { 0xff8effe30038ff8eULL, 0xffe30038ff8effe3ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0056005600560056ULL, 0x0056005600560056ULL, },
+        { 0xffabffabffabffabULL, 0xffabffabffabffabULL, },
+        { 0x0034003400340034ULL, 0x0034003400340034ULL, },
+        { 0xffcdffcdffcdffcdULL, 0xffcdffcdffcdffcdULL, },
+        { 0x0072001dffc80072ULL, 0x001dffc80072001dULL, },
+        { 0xff8fffe40039ff8fULL, 0xffe40039ff8fffe4ULL, },
+        { 0xffabffabffabffabULL, 0xffabffabffabffabULL, },    /*  16  */
+        { 0xffaaffaaffaaffaaULL, 0xffaaffaaffaaffaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff55ff55ff55ff55ULL, 0xff55ff55ff55ff55ULL, },
+        { 0xffdeffdeffdeffdeULL, 0xffdeffdeffdeffdeULL, },
+        { 0xff77ff77ff77ff77ULL, 0xff77ff77ff77ff77ULL, },
+        { 0x001cffc7ff72001cULL, 0xffc7ff72001cffc7ULL, },
+        { 0xff39ff8effe3ff39ULL, 0xff8effe3ff39ff8eULL, },
+        { 0x0056005600560056ULL, 0x0056005600560056ULL, },    /*  24  */
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0x00ab00ab00ab00abULL, 0x00ab00ab00ab00abULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0089008900890089ULL, 0x0089008900890089ULL, },
+        { 0x0022002200220022ULL, 0x0022002200220022ULL, },
+        { 0x00c70072001d00c7ULL, 0x0072001d00c70072ULL, },
+        { 0xffe40039008effe4ULL, 0x0039008effe40039ULL, },
+        { 0xffcdffcdffcdffcdULL, 0xffcdffcdffcdffcdULL, },    /*  32  */
+        { 0xffccffccffccffccULL, 0xffccffccffccffccULL, },
+        { 0x0022002200220022ULL, 0x0022002200220022ULL, },
+        { 0xff77ff77ff77ff77ULL, 0xff77ff77ff77ff77ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff99ff99ff99ff99ULL, 0xff99ff99ff99ff99ULL, },
+        { 0x003effe9ff94003eULL, 0xffe9ff94003effe9ULL, },
+        { 0xff5bffb00005ff5bULL, 0xffb00005ff5bffb0ULL, },
+        { 0x0034003400340034ULL, 0x0034003400340034ULL, },    /*  40  */
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0x0089008900890089ULL, 0x0089008900890089ULL, },
+        { 0xffdeffdeffdeffdeULL, 0xffdeffdeffdeffdeULL, },
+        { 0x0067006700670067ULL, 0x0067006700670067ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00a50050fffb00a5ULL, 0x0050fffb00a50050ULL, },
+        { 0xffc20017006cffc2ULL, 0x0017006cffc20017ULL, },
+        { 0xffe40039ff8fffe4ULL, 0x0039ff8fffe40039ULL, },    /*  48  */
+        { 0xffe30038ff8effe3ULL, 0x0038ff8effe30038ULL, },
+        { 0x0039008effe40039ULL, 0x008effe40039008eULL, },
+        { 0xff8effe3ff39ff8eULL, 0xffe3ff39ff8effe3ULL, },
+        { 0x0017006cffc20017ULL, 0x006cffc20017006cULL, },
+        { 0xffb00005ff5bffb0ULL, 0x0005ff5bffb00005ULL, },
+        { 0x00550055ff560055ULL, 0x0055ff5600550055ULL, },
+        { 0xff72001cffc7ff72ULL, 0x001cffc7ff72001cULL, },
+        { 0x001dffc80072001dULL, 0xffc80072001dffc8ULL, },    /*  56  */
+        { 0x001cffc70071001cULL, 0xffc70071001cffc7ULL, },
+        { 0x0072001d00c70072ULL, 0x001d00c70072001dULL, },
+        { 0xffc7ff72001cffc7ULL, 0xff72001cffc7ff72ULL, },
+        { 0x0050fffb00a50050ULL, 0xfffb00a50050fffbULL, },
+        { 0xffe9ff94003effe9ULL, 0xff94003effe9ff94ULL, },
+        { 0x008effe40039008eULL, 0xffe40039008effe4ULL, },
+        { 0xffabffab00aaffabULL, 0xffab00aaffabffabULL, },
+        { 0xff1e001affc60015ULL, 0xffe4ffadff83ffa4ULL, },    /*  64  */
+        { 0xffcaff830095004dULL, 0x0054fff1ffbfffb4ULL, },
+        { 0xff2e003c005900d5ULL, 0x0073000cffd3ff9cULL, },
+        { 0xff39ff99fff70007ULL, 0x005a0033ffbc0010ULL, },
+        { 0xff910034ffebff87ULL, 0xffabff5dff9a0046ULL, },
+        { 0x003dff9d00baffbfULL, 0x001bffa1ffd60056ULL, },
+        { 0xffa10056007e0047ULL, 0x003affbcffea003eULL, },
+        { 0xffacffb3001cff79ULL, 0x0021ffe3ffd300b2ULL, },
+        { 0xff42ffe2ff57ff4bULL, 0xffc0ff68ff300019ULL, },    /*  72  */
+        { 0xffeeff4b0026ff83ULL, 0x0030ffacff6c0029ULL, },
+        { 0xff520004ffea000bULL, 0x004fffc7ff800011ULL, },
+        { 0xff5dff61ff88ff3dULL, 0x0036ffeeff690085ULL, },
+        { 0x0006004afffcffa2ULL, 0xff26ff2aff2effd6ULL, },
+        { 0x00b2ffb300cbffdaULL, 0xff96ff6eff6affe6ULL, },
+        { 0x0016006c008f0062ULL, 0xffb5ff89ff7effceULL, },
+        { 0x0021ffc9002dff94ULL, 0xff9cffb0ff670042ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_S_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
new file mode 100644
index 0000000..2f288b2
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction HSUB_S.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "HSUB_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0xffffaaaaffffaaaaULL, 0xffffaaaaffffaaaaULL, },
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0xffffccccffffccccULL, 0xffffccccffffccccULL, },
+        { 0xffffc71c00001c71ULL, 0x000071c7ffffc71cULL, },
+        { 0x000038e3ffffe38eULL, 0xffff8e38000038e3ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000555600005556ULL, 0x0000555600005556ULL, },
+        { 0xffffaaabffffaaabULL, 0xffffaaabffffaaabULL, },
+        { 0x0000333400003334ULL, 0x0000333400003334ULL, },
+        { 0xffffcccdffffcccdULL, 0xffffcccdffffcccdULL, },
+        { 0xffffc71d00001c72ULL, 0x000071c8ffffc71dULL, },
+        { 0x000038e4ffffe38fULL, 0xffff8e39000038e4ULL, },
+        { 0xffffaaabffffaaabULL, 0xffffaaabffffaaabULL, },    /*  16  */
+        { 0xffffaaaaffffaaaaULL, 0xffffaaaaffffaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff5555ffff5555ULL, 0xffff5555ffff5555ULL, },
+        { 0xffffdddeffffdddeULL, 0xffffdddeffffdddeULL, },
+        { 0xffff7777ffff7777ULL, 0xffff7777ffff7777ULL, },
+        { 0xffff71c7ffffc71cULL, 0x00001c72ffff71c7ULL, },
+        { 0xffffe38effff8e39ULL, 0xffff38e3ffffe38eULL, },
+        { 0x0000555600005556ULL, 0x0000555600005556ULL, },    /*  24  */
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0x0000aaab0000aaabULL, 0x0000aaab0000aaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000888900008889ULL, 0x0000888900008889ULL, },
+        { 0x0000222200002222ULL, 0x0000222200002222ULL, },
+        { 0x00001c72000071c7ULL, 0x0000c71d00001c72ULL, },
+        { 0x00008e39000038e4ULL, 0xffffe38e00008e39ULL, },
+        { 0xffffcccdffffcccdULL, 0xffffcccdffffcccdULL, },    /*  32  */
+        { 0xffffccccffffccccULL, 0xffffccccffffccccULL, },
+        { 0x0000222200002222ULL, 0x0000222200002222ULL, },
+        { 0xffff7777ffff7777ULL, 0xffff7777ffff7777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff9999ffff9999ULL, 0xffff9999ffff9999ULL, },
+        { 0xffff93e9ffffe93eULL, 0x00003e94ffff93e9ULL, },
+        { 0x000005b0ffffb05bULL, 0xffff5b05000005b0ULL, },
+        { 0x0000333400003334ULL, 0x0000333400003334ULL, },    /*  40  */
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0x0000888900008889ULL, 0x0000888900008889ULL, },
+        { 0xffffdddeffffdddeULL, 0xffffdddeffffdddeULL, },
+        { 0x0000666700006667ULL, 0x0000666700006667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xfffffa5000004fa5ULL, 0x0000a4fbfffffa50ULL, },
+        { 0x00006c17000016c2ULL, 0xffffc16c00006c17ULL, },
+        { 0xffffe38fffff8e39ULL, 0x000038e4ffffe38fULL, },    /*  48  */
+        { 0xffffe38effff8e38ULL, 0x000038e3ffffe38eULL, },
+        { 0x000038e4ffffe38eULL, 0x00008e39000038e4ULL, },
+        { 0xffff8e39ffff38e3ULL, 0xffffe38effff8e39ULL, },
+        { 0x000016c2ffffc16cULL, 0x00006c17000016c2ULL, },
+        { 0xffffb05bffff5b05ULL, 0x000005b0ffffb05bULL, },
+        { 0xffffaaabffffaaaaULL, 0x0000aaabffffaaabULL, },
+        { 0x00001c72ffff71c7ULL, 0xffffc71c00001c72ULL, },
+        { 0x00001c72000071c8ULL, 0xffffc71d00001c72ULL, },    /*  56  */
+        { 0x00001c71000071c7ULL, 0xffffc71c00001c71ULL, },
+        { 0x000071c70000c71dULL, 0x00001c72000071c7ULL, },
+        { 0xffffc71c00001c72ULL, 0xffff71c7ffffc71cULL, },
+        { 0x00004fa50000a4fbULL, 0xfffffa5000004fa5ULL, },
+        { 0xffffe93e00003e94ULL, 0xffff93e9ffffe93eULL, },
+        { 0xffffe38e00008e39ULL, 0x000038e4ffffe38eULL, },
+        { 0x0000555500005556ULL, 0xffff555500005555ULL, },
+        { 0xffffa19effffd322ULL, 0x0000400900004e6fULL, },    /*  64  */
+        { 0xffff88070000615aULL, 0x0000904dffffab7fULL, },
+        { 0xffffd9c000009ce2ULL, 0x00008468ffffd967ULL, },
+        { 0xffff721d00004614ULL, 0x0000c28f00001bdbULL, },
+        { 0x000014f2fffff853ULL, 0x0000079900006533ULL, },
+        { 0xfffffb5b0000868bULL, 0x000057ddffffc243ULL, },
+        { 0x00004d140000c213ULL, 0x00004bf8fffff02bULL, },
+        { 0xffffe57100006b45ULL, 0x00008a1f0000329fULL, },
+        { 0xffffc58effff648fULL, 0x00001c7afffffb1fULL, },    /*  72  */
+        { 0xffffabf7fffff2c7ULL, 0x00006cbeffff582fULL, },
+        { 0xfffffdb000002e4fULL, 0x000060d9ffff8617ULL, },
+        { 0xffff960dffffd781ULL, 0x00009f00ffffc88bULL, },
+        { 0x00008983000008f1ULL, 0xffff8293fffff936ULL, },
+        { 0x00006fec00009729ULL, 0xffffd2d7ffff5646ULL, },
+        { 0x0000c1a50000d2b1ULL, 0xffffc6f2ffff842eULL, },
+        { 0x00005a0200007be3ULL, 0x00000519ffffc6a2ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_S_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
new file mode 100644
index 0000000..677adfa
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction HSUB_U.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "HSUB_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0x00000000aaaaaaaaULL, 0x00000000aaaaaaaaULL, },
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0x00000000ccccccccULL, 0x00000000ccccccccULL, },
+        { 0x0000000071c71c71ULL, 0x000000001c71c71cULL, },
+        { 0x000000008e38e38eULL, 0x00000000e38e38e3ULL, },
+        { 0xffffffff00000001ULL, 0xffffffff00000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff55555556ULL, 0xffffffff55555556ULL, },
+        { 0xffffffffaaaaaaabULL, 0xffffffffaaaaaaabULL, },
+        { 0xffffffff33333334ULL, 0xffffffff33333334ULL, },
+        { 0xffffffffcccccccdULL, 0xffffffffcccccccdULL, },
+        { 0xffffffff71c71c72ULL, 0xffffffff1c71c71dULL, },
+        { 0xffffffff8e38e38fULL, 0xffffffffe38e38e4ULL, },
+        { 0xffffffffaaaaaaabULL, 0xffffffffaaaaaaabULL, },    /*  16  */
+        { 0x00000000aaaaaaaaULL, 0x00000000aaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0xffffffffdddddddeULL, 0xffffffffdddddddeULL, },
+        { 0x0000000077777777ULL, 0x0000000077777777ULL, },
+        { 0x000000001c71c71cULL, 0xffffffffc71c71c7ULL, },
+        { 0x0000000038e38e39ULL, 0x000000008e38e38eULL, },
+        { 0xffffffff55555556ULL, 0xffffffff55555556ULL, },    /*  24  */
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0xffffffffaaaaaaabULL, 0xffffffffaaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff88888889ULL, 0xffffffff88888889ULL, },
+        { 0x0000000022222222ULL, 0x0000000022222222ULL, },
+        { 0xffffffffc71c71c7ULL, 0xffffffff71c71c72ULL, },
+        { 0xffffffffe38e38e4ULL, 0x0000000038e38e39ULL, },
+        { 0xffffffffcccccccdULL, 0xffffffffcccccccdULL, },    /*  32  */
+        { 0x00000000ccccccccULL, 0x00000000ccccccccULL, },
+        { 0x0000000022222222ULL, 0x0000000022222222ULL, },
+        { 0x0000000077777777ULL, 0x0000000077777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000099999999ULL, 0x0000000099999999ULL, },
+        { 0x000000003e93e93eULL, 0xffffffffe93e93e9ULL, },
+        { 0x000000005b05b05bULL, 0x00000000b05b05b0ULL, },
+        { 0xffffffff33333334ULL, 0xffffffff33333334ULL, },    /*  40  */
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0xffffffff88888889ULL, 0xffffffff88888889ULL, },
+        { 0xffffffffdddddddeULL, 0xffffffffdddddddeULL, },
+        { 0xffffffff66666667ULL, 0xffffffff66666667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffa4fa4fa5ULL, 0xffffffff4fa4fa50ULL, },
+        { 0xffffffffc16c16c2ULL, 0x0000000016c16c17ULL, },
+        { 0xffffffffe38e38e4ULL, 0xffffffff38e38e39ULL, },    /*  48  */
+        { 0x00000000e38e38e3ULL, 0x0000000038e38e38ULL, },
+        { 0x0000000038e38e39ULL, 0xffffffff8e38e38eULL, },
+        { 0x000000008e38e38eULL, 0xffffffffe38e38e3ULL, },
+        { 0x0000000016c16c17ULL, 0xffffffff6c16c16cULL, },
+        { 0x00000000b05b05b0ULL, 0x0000000005b05b05ULL, },
+        { 0x0000000055555555ULL, 0xffffffff55555555ULL, },
+        { 0x0000000071c71c72ULL, 0x000000001c71c71cULL, },
+        { 0xffffffff1c71c71dULL, 0xffffffffc71c71c8ULL, },    /*  56  */
+        { 0x000000001c71c71cULL, 0x00000000c71c71c7ULL, },
+        { 0xffffffff71c71c72ULL, 0x000000001c71c71dULL, },
+        { 0xffffffffc71c71c7ULL, 0x0000000071c71c72ULL, },
+        { 0xffffffff4fa4fa50ULL, 0xfffffffffa4fa4fbULL, },
+        { 0xffffffffe93e93e9ULL, 0x0000000093e93e94ULL, },
+        { 0xffffffff8e38e38eULL, 0xffffffffe38e38e4ULL, },
+        { 0xffffffffaaaaaaabULL, 0x00000000aaaaaaabULL, },
+        { 0x000000006008918cULL, 0xffffffff4ceb5b52ULL, },    /*  64  */
+        { 0x000000003ad71fc4ULL, 0x000000003627b862ULL, },
+        { 0xffffffffce9b5b4cULL, 0xffffffffa03be64aULL, },
+        { 0x000000002a39047eULL, 0xffffffffa22428beULL, },
+        { 0x00000000d35bab23ULL, 0xffffffff147c0b0eULL, },
+        { 0x00000000ae2a395bULL, 0xfffffffffdb8681eULL, },
+        { 0x0000000041ee74e3ULL, 0xffffffff67cc9606ULL, },
+        { 0x000000009d8c1e15ULL, 0xffffffff69b4d87aULL, },
+        { 0x0000000083f8596aULL, 0xffffffff295d16f3ULL, },    /*  72  */
+        { 0x000000005ec6e7a2ULL, 0x0000000012997403ULL, },
+        { 0xfffffffff28b232aULL, 0xffffffff7cada1ebULL, },
+        { 0x000000004e28cc5cULL, 0xffffffff7e95e45fULL, },
+        { 0x0000000047ecc10dULL, 0xffffffff8f75d8ccULL, },
+        { 0x0000000022bb4f45ULL, 0x0000000078b235dcULL, },
+        { 0xffffffffb67f8acdULL, 0xffffffffe2c663c4ULL, },
+        { 0x00000000121d33ffULL, 0xffffffffe4aea638ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_U_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
new file mode 100644
index 0000000..35177eb
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction HSUB_U.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "HSUB_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0x00aa00aa00aa00aaULL, 0x00aa00aa00aa00aaULL, },
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0x00cc00cc00cc00ccULL, 0x00cc00cc00cc00ccULL, },
+        { 0x0071001c00c70071ULL, 0x001c00c70071001cULL, },
+        { 0x008e00e30038008eULL, 0x00e30038008e00e3ULL, },
+        { 0xff01ff01ff01ff01ULL, 0xff01ff01ff01ff01ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff56ff56ff56ff56ULL, 0xff56ff56ff56ff56ULL, },
+        { 0xffabffabffabffabULL, 0xffabffabffabffabULL, },
+        { 0xff34ff34ff34ff34ULL, 0xff34ff34ff34ff34ULL, },
+        { 0xffcdffcdffcdffcdULL, 0xffcdffcdffcdffcdULL, },
+        { 0xff72ff1dffc8ff72ULL, 0xff1dffc8ff72ff1dULL, },
+        { 0xff8fffe4ff39ff8fULL, 0xffe4ff39ff8fffe4ULL, },
+        { 0xffabffabffabffabULL, 0xffabffabffabffabULL, },    /*  16  */
+        { 0x00aa00aa00aa00aaULL, 0x00aa00aa00aa00aaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0xffdeffdeffdeffdeULL, 0xffdeffdeffdeffdeULL, },
+        { 0x0077007700770077ULL, 0x0077007700770077ULL, },
+        { 0x001cffc70072001cULL, 0xffc70072001cffc7ULL, },
+        { 0x0039008effe30039ULL, 0x008effe30039008eULL, },
+        { 0xff56ff56ff56ff56ULL, 0xff56ff56ff56ff56ULL, },    /*  24  */
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0xffabffabffabffabULL, 0xffabffabffabffabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff89ff89ff89ff89ULL, 0xff89ff89ff89ff89ULL, },
+        { 0x0022002200220022ULL, 0x0022002200220022ULL, },
+        { 0xffc7ff72001dffc7ULL, 0xff72001dffc7ff72ULL, },
+        { 0xffe40039ff8effe4ULL, 0x0039ff8effe40039ULL, },
+        { 0xffcdffcdffcdffcdULL, 0xffcdffcdffcdffcdULL, },    /*  32  */
+        { 0x00cc00cc00cc00ccULL, 0x00cc00cc00cc00ccULL, },
+        { 0x0022002200220022ULL, 0x0022002200220022ULL, },
+        { 0x0077007700770077ULL, 0x0077007700770077ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0099009900990099ULL, 0x0099009900990099ULL, },
+        { 0x003effe90094003eULL, 0xffe90094003effe9ULL, },
+        { 0x005b00b00005005bULL, 0x00b00005005b00b0ULL, },
+        { 0xff34ff34ff34ff34ULL, 0xff34ff34ff34ff34ULL, },    /*  40  */
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0xff89ff89ff89ff89ULL, 0xff89ff89ff89ff89ULL, },
+        { 0xffdeffdeffdeffdeULL, 0xffdeffdeffdeffdeULL, },
+        { 0xff67ff67ff67ff67ULL, 0xff67ff67ff67ff67ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffa5ff50fffbffa5ULL, 0xff50fffbffa5ff50ULL, },
+        { 0xffc20017ff6cffc2ULL, 0x0017ff6cffc20017ULL, },
+        { 0xffe4ff39ff8fffe4ULL, 0xff39ff8fffe4ff39ULL, },    /*  48  */
+        { 0x00e30038008e00e3ULL, 0x0038008e00e30038ULL, },
+        { 0x0039ff8effe40039ULL, 0xff8effe40039ff8eULL, },
+        { 0x008effe30039008eULL, 0xffe30039008effe3ULL, },
+        { 0x0017ff6cffc20017ULL, 0xff6cffc20017ff6cULL, },
+        { 0x00b00005005b00b0ULL, 0x0005005b00b00005ULL, },
+        { 0x0055ff5500560055ULL, 0xff5500560055ff55ULL, },
+        { 0x0072001cffc70072ULL, 0x001cffc70072001cULL, },
+        { 0xff1dffc8ff72ff1dULL, 0xffc8ff72ff1dffc8ULL, },    /*  56  */
+        { 0x001c00c70071001cULL, 0x00c70071001c00c7ULL, },
+        { 0xff72001dffc7ff72ULL, 0x001dffc7ff72001dULL, },
+        { 0xffc70072001cffc7ULL, 0x0072001cffc70072ULL, },
+        { 0xff50fffbffa5ff50ULL, 0xfffbffa5ff50fffbULL, },
+        { 0xffe90094003effe9ULL, 0x0094003effe90094ULL, },
+        { 0xff8effe40039ff8eULL, 0xffe40039ff8effe4ULL, },
+        { 0xffab00abffaaffabULL, 0x00abffaaffab00abULL, },
+        { 0x001e001affc60015ULL, 0xffe4ffad008300a4ULL, },    /*  64  */
+        { 0xffca0083ff95004dULL, 0xff54fff100bfffb4ULL, },
+        { 0x002e003cff59ffd5ULL, 0xff73ff0c00d3009cULL, },
+        { 0x00390099fff70007ULL, 0xff5aff3300bc0010ULL, },
+        { 0x0091ff34ffeb0087ULL, 0xffab005dff9a0046ULL, },
+        { 0x003dff9dffba00bfULL, 0xff1b00a1ffd6ff56ULL, },
+        { 0x00a1ff56ff7e0047ULL, 0xff3affbcffea003eULL, },
+        { 0x00acffb3001c0079ULL, 0xff21ffe3ffd3ffb2ULL, },
+        { 0x0042ffe20057004bULL, 0xffc0006800300019ULL, },    /*  72  */
+        { 0xffee004b00260083ULL, 0xff3000ac006cff29ULL, },
+        { 0x00520004ffea000bULL, 0xff4fffc700800011ULL, },
+        { 0x005d00610088003dULL, 0xff36ffee0069ff85ULL, },
+        { 0x0006ff4afffc00a2ULL, 0x0026002a002e00d6ULL, },
+        { 0xffb2ffb3ffcb00daULL, 0xff96006e006affe6ULL, },
+        { 0x0016ff6cff8f0062ULL, 0xffb5ff89007e00ceULL, },
+        { 0x0021ffc9002d0094ULL, 0xff9cffb000670042ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_U_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
new file mode 100644
index 0000000..2bc61fd
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction HSUB_U.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "HSUB_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0x0000aaaa0000aaaaULL, 0x0000aaaa0000aaaaULL, },
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0x0000cccc0000ccccULL, 0x0000cccc0000ccccULL, },
+        { 0x0000c71c00001c71ULL, 0x000071c70000c71cULL, },
+        { 0x000038e30000e38eULL, 0x00008e38000038e3ULL, },
+        { 0xffff0001ffff0001ULL, 0xffff0001ffff0001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff5556ffff5556ULL, 0xffff5556ffff5556ULL, },
+        { 0xffffaaabffffaaabULL, 0xffffaaabffffaaabULL, },
+        { 0xffff3334ffff3334ULL, 0xffff3334ffff3334ULL, },
+        { 0xffffcccdffffcccdULL, 0xffffcccdffffcccdULL, },
+        { 0xffffc71dffff1c72ULL, 0xffff71c8ffffc71dULL, },
+        { 0xffff38e4ffffe38fULL, 0xffff8e39ffff38e4ULL, },
+        { 0xffffaaabffffaaabULL, 0xffffaaabffffaaabULL, },    /*  16  */
+        { 0x0000aaaa0000aaaaULL, 0x0000aaaa0000aaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0xffffdddeffffdddeULL, 0xffffdddeffffdddeULL, },
+        { 0x0000777700007777ULL, 0x0000777700007777ULL, },
+        { 0x000071c7ffffc71cULL, 0x00001c72000071c7ULL, },
+        { 0xffffe38e00008e39ULL, 0x000038e3ffffe38eULL, },
+        { 0xffff5556ffff5556ULL, 0xffff5556ffff5556ULL, },    /*  24  */
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0xffffaaabffffaaabULL, 0xffffaaabffffaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff8889ffff8889ULL, 0xffff8889ffff8889ULL, },
+        { 0x0000222200002222ULL, 0x0000222200002222ULL, },
+        { 0x00001c72ffff71c7ULL, 0xffffc71d00001c72ULL, },
+        { 0xffff8e39000038e4ULL, 0xffffe38effff8e39ULL, },
+        { 0xffffcccdffffcccdULL, 0xffffcccdffffcccdULL, },    /*  32  */
+        { 0x0000cccc0000ccccULL, 0x0000cccc0000ccccULL, },
+        { 0x0000222200002222ULL, 0x0000222200002222ULL, },
+        { 0x0000777700007777ULL, 0x0000777700007777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000999900009999ULL, 0x0000999900009999ULL, },
+        { 0x000093e9ffffe93eULL, 0x00003e94000093e9ULL, },
+        { 0x000005b00000b05bULL, 0x00005b05000005b0ULL, },
+        { 0xffff3334ffff3334ULL, 0xffff3334ffff3334ULL, },    /*  40  */
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0xffff8889ffff8889ULL, 0xffff8889ffff8889ULL, },
+        { 0xffffdddeffffdddeULL, 0xffffdddeffffdddeULL, },
+        { 0xffff6667ffff6667ULL, 0xffff6667ffff6667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xfffffa50ffff4fa5ULL, 0xffffa4fbfffffa50ULL, },
+        { 0xffff6c17000016c2ULL, 0xffffc16cffff6c17ULL, },
+        { 0xffffe38fffff8e39ULL, 0xffff38e4ffffe38fULL, },    /*  48  */
+        { 0x0000e38e00008e38ULL, 0x000038e30000e38eULL, },
+        { 0x000038e4ffffe38eULL, 0xffff8e39000038e4ULL, },
+        { 0x00008e39000038e3ULL, 0xffffe38e00008e39ULL, },
+        { 0x000016c2ffffc16cULL, 0xffff6c17000016c2ULL, },
+        { 0x0000b05b00005b05ULL, 0x000005b00000b05bULL, },
+        { 0x0000aaabffffaaaaULL, 0xffffaaab0000aaabULL, },
+        { 0x00001c72000071c7ULL, 0xffffc71c00001c72ULL, },
+        { 0xffff1c72ffff71c8ULL, 0xffffc71dffff1c72ULL, },    /*  56  */
+        { 0x00001c71000071c7ULL, 0x0000c71c00001c71ULL, },
+        { 0xffff71c7ffffc71dULL, 0x00001c72ffff71c7ULL, },
+        { 0xffffc71c00001c72ULL, 0x000071c7ffffc71cULL, },
+        { 0xffff4fa5ffffa4fbULL, 0xfffffa50ffff4fa5ULL, },
+        { 0xffffe93e00003e94ULL, 0x000093e9ffffe93eULL, },
+        { 0xffffe38effff8e39ULL, 0x000038e4ffffe38eULL, },
+        { 0xffff555500005556ULL, 0x00005555ffff5555ULL, },
+        { 0xffffa19effffd322ULL, 0x0000400900004e6fULL, },    /*  64  */
+        { 0x00008807ffff615aULL, 0xffff904d0000ab7fULL, },
+        { 0xffffd9c0ffff9ce2ULL, 0xffff84680000d967ULL, },
+        { 0x0000721dffff4614ULL, 0xffffc28f00001bdbULL, },
+        { 0x000014f2fffff853ULL, 0x00000799ffff6533ULL, },
+        { 0x0000fb5bffff868bULL, 0xffff57ddffffc243ULL, },
+        { 0x00004d14ffffc213ULL, 0xffff4bf8fffff02bULL, },
+        { 0x0000e571ffff6b45ULL, 0xffff8a1fffff329fULL, },
+        { 0xffffc58e0000648fULL, 0x00001c7afffffb1fULL, },    /*  72  */
+        { 0x0000abf7fffff2c7ULL, 0xffff6cbe0000582fULL, },
+        { 0xfffffdb000002e4fULL, 0xffff60d900008617ULL, },
+        { 0x0000960dffffd781ULL, 0xffff9f00ffffc88bULL, },
+        { 0xffff8983000008f1ULL, 0x00008293fffff936ULL, },
+        { 0x00006fecffff9729ULL, 0xffffd2d700005646ULL, },
+        { 0xffffc1a5ffffd2b1ULL, 0xffffc6f20000842eULL, },
+        { 0x00005a02ffff7be3ULL, 0x00000519ffffc6a2ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HSUB_U_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
index 04e6159..5faed13 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x800b9880809ea980ULL, 0x7fe73e2702e94374ULL, },
         { 0x7fe5307f36cf8d0eULL, 0x808a8080abc73294ULL, },
         { 0x757f16ea117f1b46ULL, 0x80facdbe940390a4ULL, },
+        { 0x7ff5687f7f62577fULL, 0x8019c2d9fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
index 195137f..f4ad331 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8000000000000000ULL, 0x7fffffffffffffffULL, },
         { 0x7fffffffffffffffULL, 0x8000000000000000ULL, },
         { 0x749115ea109e1b46ULL, 0x8000000000000000ULL, },
+        { 0x7fffffffffffffffULL, 0x8000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
index c57238d..c906138 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8000985d8000a932ULL, 0x7fff3e2701e94274ULL, },
         { 0x7fff2f8135cf8d0eULL, 0x80008000aac73294ULL, },
         { 0x749115ea109e1b46ULL, 0x8000cdbe94038fa4ULL, },
+        { 0x7fff67a37fff56ceULL, 0x8000c1d9fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
index 1cded65..27651e5 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x8000000080000000ULL, 0x7fffffff01e84274ULL, },
         { 0x7fffffff35cf8d0eULL, 0x80000000aac73294ULL, },
         { 0x749115ea109e1b46ULL, 0x8000000094038fa4ULL, },
+        { 0x7fffffff7fffffffULL, 0x80000000fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
index cb38f03..d7dbfcd 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9e0032ULL, 0x00003e2702000000ULL, },
         { 0x0000000036008d0eULL, 0x428a7d7a00003294ULL, },
         { 0x0000160011001b46ULL, 0x7b0000be94039000ULL, },
+        { 0x0000000000005700ULL, 0x661900000017bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
index 2685b2f..96d05a3 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9da932ULL, 0x0000000000000000ULL, },
         { 0x0000000000000000ULL, 0x428a7d79aac73294ULL, },
         { 0x0000000000000000ULL, 0x7af9cdbe94038fa4ULL, },
+        { 0x0000000000000000ULL, 0x6618c1d8fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
index ca6dd38..f112686 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9e0000ULL, 0x00003e2701e90000ULL, },
         { 0x0000000035cf8d0eULL, 0x428a7d7a00003294ULL, },
         { 0x000015ea109e1b46ULL, 0x7afa000094038fa4ULL, },
+        { 0x00000000000056ceULL, 0x661900000000bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
index 42ebddb..2fb992d 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9da932ULL, 0x0000000001e84274ULL, },
         { 0x0000000035cf8d0eULL, 0x428a7d7a00000000ULL, },
         { 0x00000000109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+        { 0x0000000000000000ULL, 0x6618c1d900000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
index dac20cc..2214c3b 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9ea932ULL, 0x9ae7ffffff004374ULL, },
         { 0xe800308136008d0eULL, 0x428a7d7aab00ff94ULL, },
         { 0x75911600119eff46ULL, 0x7bfacdbe940390a4ULL, },
+        { 0xc40068a3a562ffceULL, 0x66ffc2d9fe17bd8cULL, },
+        { 0x000000000000ff00ULL, 0xffffffffff00ffffULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
index 4485502..3f56c02 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9da932ULL, 0x99e73e2701e84274ULL, },
         { 0xe7e42f8135cf8d0eULL, 0x428a7d79aac73294ULL, },
         { 0x749115ea109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+        { 0xc3f467a2a46256ceULL, 0x6618c1d8fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
index 9e99aee..a0b3fe9 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9ea932ULL, 0x99e7ffffffff4274ULL, },
         { 0xe7e52f8135cf8d0eULL, 0x428a7d7aaac7ffffULL, },
         { 0x749115ea109effffULL, 0x7afacdbe94038fa4ULL, },
+        { 0xc3f567a3a462ffffULL, 0x6619c1d9fe17bd8cULL, },
+        { 0x000000000000ffffULL, 0xffffffffffffffffULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
index 53a9aca..b7e4795 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9da932ULL, 0x99e73e27ffffffffULL, },
         { 0xe7e42f8135cf8d0eULL, 0x428a7d7aaac73294ULL, },
         { 0x749115ea109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+        { 0xc3f467a3a46256ceULL, 0x6618c1d9fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
index 86fb4f3..db36e6b 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b7f5d5b7fa932ULL, 0x9ae73e2702e98080ULL, },
         { 0xe8e5808136cf7f0eULL, 0x427f7d7aabc7327fULL, },
         { 0x809116ea119e1b46ULL, 0x7bfacd7f7f037fa4ULL, },
+        { 0xc4f580a3a58057ceULL, 0x6619c2d9fe177f7fULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
index 45a1eb3..9d1a064 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9da932ULL, 0x99e73e2701e84274ULL, },
         { 0xe7e42f8135cf8d0eULL, 0x428a7d79aac73294ULL, },
         { 0x8000000000000000ULL, 0x7af9cdbe94038fa4ULL, },
+        { 0xc3f467a2a46256ceULL, 0x6618c1d8fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
index 14ac7de..91e98b5 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b7fff5b9ea932ULL, 0x99e73e2701e98000ULL, },
         { 0xe7e5800035cf7fffULL, 0x428a7d7aaac73294ULL, },
         { 0x800015ea109e1b46ULL, 0x7afacdbe7fff7fffULL, },
+        { 0xc3f58000a46256ceULL, 0x6619c1d9fe177fffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
index 688f469..1fa9c0b 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9da932ULL, 0x99e73e2701e84274ULL, },
         { 0xe7e42f8135cf8d0eULL, 0x428a7d7aaac73294ULL, },
         { 0x80000000109e1b46ULL, 0x7af9cdbe7fffffffULL, },
+        { 0xc3f467a3a46256ceULL, 0x6618c1d9fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
index d0964dc..5b13837 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9ea932ULL, 0x9ae73e2702e94374ULL, },
         { 0xe8e5308136cf8d0eULL, 0x428a7d7aabc73294ULL, },
         { 0x759116ea119e1b46ULL, 0x7bfacdbe940390a4ULL, },
+        { 0xc4f568a3a56257ceULL, 0x6619c2d9fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
index ec26a8e..b52573e 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9da932ULL, 0x99e73e2701e84274ULL, },
         { 0xe7e42f8135cf8d0eULL, 0x428a7d79aac73294ULL, },
         { 0x749115ea109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+        { 0xc3f467a2a46256ceULL, 0x6618c1d8fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
index 420422e..90cd08a 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
@@ -119,6 +119,8 @@ int32_t main(void)
         { 0x3c0b985d5b9ea932ULL, 0x99e73e2701e94274ULL, },
         { 0xe7e52f8135cf8d0eULL, 0x428a7d7aaac73294ULL, },
         { 0x749115ea109e1b46ULL, 0x7afacdbe94038fa4ULL, },
+        { 0xc3f567a3a46256ceULL, 0x6619c1d9fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
 };
 
     gettimeofday(&start, NULL);
-- 
2.7.4



