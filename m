Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB941ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFA72133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFA72133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFK1A-0002zC-9c
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iFJte-0004gt-IR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iFJtc-0001sX-Mb
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:02 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53433 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iFJtc-0000zG-AK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id B46351A23B4;
 Tue,  1 Oct 2019 17:15:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.55])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 718971A22D9;
 Tue,  1 Oct 2019 17:15:54 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] target/mips: Clean up mips-defs.h
Date: Tue,  1 Oct 2019 17:15:29 +0200
Message-Id: <1569942944-10381-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569942944-10381-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1569942944-10381-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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

Mostly fix errors and warnings reported by 'checkpatch.pl -f'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1569331602-2586-5-git-send-email-aleksandar.markovic@rt-rk.c=
om>
---
 target/mips/mips-defs.h | 58 +++++++++++++++++++++++++++----------------=
------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index bbf056a..a831bb4 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -1,8 +1,11 @@
 #ifndef QEMU_MIPS_DEFS_H
 #define QEMU_MIPS_DEFS_H
=20
-/* If we want to use host float regs... */
-//#define USE_HOST_FLOAT_REGS
+/*
+ * If we want to use host float regs...
+ *
+ * #define USE_HOST_FLOAT_REGS
+ */
=20
 /* Real pages are variable size... */
 #define MIPS_TLB_MAX 128
@@ -57,43 +60,46 @@
 #define ASE_MXU           0x0200000000000000ULL
=20
 /* MIPS CPU defines. */
-#define		CPU_MIPS1	(ISA_MIPS1)
-#define		CPU_MIPS2	(CPU_MIPS1 | ISA_MIPS2)
-#define		CPU_MIPS3	(CPU_MIPS2 | ISA_MIPS3)
-#define		CPU_MIPS4	(CPU_MIPS3 | ISA_MIPS4)
-#define		CPU_VR54XX	(CPU_MIPS4 | INSN_VR54XX)
-#define         CPU_R5900       (CPU_MIPS3 | INSN_R5900)
-#define		CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
-#define		CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
+#define CPU_MIPS1       (ISA_MIPS1)
+#define CPU_MIPS2       (CPU_MIPS1 | ISA_MIPS2)
+#define CPU_MIPS3       (CPU_MIPS2 | ISA_MIPS3)
+#define CPU_MIPS4       (CPU_MIPS3 | ISA_MIPS4)
+#define CPU_VR54XX      (CPU_MIPS4 | INSN_VR54XX)
+#define CPU_R5900       (CPU_MIPS3 | INSN_R5900)
+#define CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
+#define CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
=20
-#define		CPU_MIPS5	(CPU_MIPS4 | ISA_MIPS5)
+#define CPU_MIPS5       (CPU_MIPS4 | ISA_MIPS5)
=20
 /* MIPS Technologies "Release 1" */
-#define		CPU_MIPS32	(CPU_MIPS2 | ISA_MIPS32)
-#define		CPU_MIPS64	(CPU_MIPS5 | CPU_MIPS32 | ISA_MIPS64)
+#define CPU_MIPS32      (CPU_MIPS2 | ISA_MIPS32)
+#define CPU_MIPS64      (CPU_MIPS5 | CPU_MIPS32 | ISA_MIPS64)
=20
 /* MIPS Technologies "Release 2" */
-#define		CPU_MIPS32R2	(CPU_MIPS32 | ISA_MIPS32R2)
-#define		CPU_MIPS64R2	(CPU_MIPS64 | CPU_MIPS32R2 | ISA_MIPS64R2)
+#define CPU_MIPS32R2    (CPU_MIPS32 | ISA_MIPS32R2)
+#define CPU_MIPS64R2    (CPU_MIPS64 | CPU_MIPS32R2 | ISA_MIPS64R2)
=20
 /* MIPS Technologies "Release 3" */
-#define CPU_MIPS32R3 (CPU_MIPS32R2 | ISA_MIPS32R3)
-#define CPU_MIPS64R3 (CPU_MIPS64R2 | CPU_MIPS32R3 | ISA_MIPS64R3)
+#define CPU_MIPS32R3    (CPU_MIPS32R2 | ISA_MIPS32R3)
+#define CPU_MIPS64R3    (CPU_MIPS64R2 | CPU_MIPS32R3 | ISA_MIPS64R3)
=20
 /* MIPS Technologies "Release 5" */
-#define CPU_MIPS32R5 (CPU_MIPS32R3 | ISA_MIPS32R5)
-#define CPU_MIPS64R5 (CPU_MIPS64R3 | CPU_MIPS32R5 | ISA_MIPS64R5)
+#define CPU_MIPS32R5    (CPU_MIPS32R3 | ISA_MIPS32R5)
+#define CPU_MIPS64R5    (CPU_MIPS64R3 | CPU_MIPS32R5 | ISA_MIPS64R5)
=20
 /* MIPS Technologies "Release 6" */
-#define CPU_MIPS32R6 (CPU_MIPS32R5 | ISA_MIPS32R6)
-#define CPU_MIPS64R6 (CPU_MIPS64R5 | CPU_MIPS32R6 | ISA_MIPS64R6)
+#define CPU_MIPS32R6    (CPU_MIPS32R5 | ISA_MIPS32R6)
+#define CPU_MIPS64R6    (CPU_MIPS64R5 | CPU_MIPS32R6 | ISA_MIPS64R6)
=20
 /* Wave Computing: "nanoMIPS" */
-#define CPU_NANOMIPS32 (CPU_MIPS32R6 | ISA_NANOMIPS32)
+#define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
=20
-/* Strictly follow the architecture standard:
-   - Disallow "special" instruction handling for PMON/SPIM.
-   Note that we still maintain Count/Compare to match the host clock. */
-//#define MIPS_STRICT_STANDARD 1
+/*
+ * Strictly follow the architecture standard:
+ * - Disallow "special" instruction handling for PMON/SPIM.
+ * Note that we still maintain Count/Compare to match the host clock.
+ *
+ * #define MIPS_STRICT_STANDARD 1
+ */
=20
 #endif /* QEMU_MIPS_DEFS_H */
--=20
2.7.4


