Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981DDC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D3920989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D3920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNtJ-0008KT-6Q
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiLlR-0003Ab-1k
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiLlN-0000a8-W0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:36:16 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59853 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hiLlM-0007q3-0k
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:36:13 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C20971A2235;
 Tue,  2 Jul 2019 18:35:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 995B91A212C;
 Tue,  2 Jul 2019 18:35:33 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 18:35:24 +0200
Message-Id: <1562085328-5126-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 08/12] tcg/tests: target/mips: Correct MSA test
 compilation and execution order
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

Correct MSA test compilation and execution order, for the sake of
consistence.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1562068213-11307-4-git-send-email-aleksandar.markovic@rt-rk.com>
---
 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh | 16 ++++++++--------
 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh | 16 ++++++++--------
 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh | 16 ++++++++--------
 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh | 16 ++++++++--------
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh     |  8 ++++----
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh     |  8 ++++----
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh     |  8 ++++----
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh     |  8 ++++----
 8 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
index 537267c..2519213 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
@@ -486,14 +486,6 @@
 -EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_w_32r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c        \
 -EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_d_32r6eb
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
--EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_b_32r6eb
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
--EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_h_32r6eb
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
--EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_w_32r6eb
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
--EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_d_32r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.c      \
 -EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_b_32r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.c      \
@@ -502,6 +494,14 @@
 -EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_w_32r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.c      \
 -EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_d_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_b_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_d_32r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_b.c          \
 -EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subv_b_32r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_h.c          \
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
index 49f8aa0..1e10ff7 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
@@ -486,14 +486,6 @@
 -EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_w_32r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c        \
 -EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subs_u_d_32r6el
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
--EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_b_32r6el
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
--EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_h_32r6el
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
--EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_w_32r6el
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
--EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_d_32r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.c      \
 -EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_b_32r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.c      \
@@ -502,6 +494,14 @@
 -EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_w_32r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.c      \
 -EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsus_u_d_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_b_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subsuu_s_d_32r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_b.c          \
 -EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_subv_b_32r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_h.c          \
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh
index f4346d6..6bc8907 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh
@@ -486,14 +486,6 @@
 -EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_u_w_64r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c        \
 -EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_u_d_64r6eb
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
--EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_b_64r6eb
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
--EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_h_64r6eb
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
--EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_w_64r6eb
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
--EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_d_64r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.c      \
 -EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsus_u_b_64r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.c      \
@@ -502,6 +494,14 @@
 -EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsus_u_w_64r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.c      \
 -EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsus_u_d_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_b_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_h_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_w_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_d_64r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_b.c          \
 -EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subv_b_64r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_h.c          \
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh
index 2912b17..4a92c55 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh
@@ -486,14 +486,6 @@
 -EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_u_w_64r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c        \
 -EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subs_u_d_64r6el
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
--EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_b_64r6el
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
--EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_h_64r6el
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
--EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_w_64r6el
-/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
--EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_d_64r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.c      \
 -EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsus_u_b_64r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.c      \
@@ -502,6 +494,14 @@
 -EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsus_u_w_64r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.c      \
 -EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsus_u_d_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_b_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_h_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_w_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.c      \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subsuu_s_d_64r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_b.c          \
 -EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_subv_b_64r6el
 /opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_h.c          \
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
index e979762..6c95e45 100644
--- a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
@@ -279,14 +279,14 @@ $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_b_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_h_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_w_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_d_32r6eb
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_32r6eb
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_32r6eb
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_32r6eb
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_b_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_h_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_w_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_d_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_b_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_h_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_w_32r6eb
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
index 0e3e0e2..d4945da 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
@@ -279,14 +279,14 @@ $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_b_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_h_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_w_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_d_32r6el
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_32r6el
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_32r6el
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_32r6el
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_b_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_h_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_w_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_d_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_b_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_h_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_w_32r6el
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh b/tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
index e58f177..6de6d7c 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
@@ -279,14 +279,14 @@ $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_b_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_h_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_w_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_d_64r6eb
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_64r6eb
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_64r6eb
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_64r6eb
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_b_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_h_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_w_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_d_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_b_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_h_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_w_64r6eb
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh b/tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh
index 7a89bd6..979057d 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh
@@ -279,14 +279,14 @@ $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_b_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_h_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_w_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_d_64r6el
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_64r6el
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_64r6el
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_64r6el
-$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_b_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_h_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_w_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_d_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_b_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_h_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_w_64r6el
-- 
2.7.4


