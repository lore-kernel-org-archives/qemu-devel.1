Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE29C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B547C206E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B547C206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYrWk-0001bk-Q2
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:29:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYrSA-0006LC-1U
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYrS8-00062I-T3
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:25:09 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33387 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hYrS6-0005oH-S6
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:25:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id E9F4A1A217B;
	Thu,  6 Jun 2019 14:25:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id C77DC1A2199;
	Thu,  6 Jun 2019 14:25:02 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 14:24:33 +0200
Message-Id: <1559823880-29103-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559823880-29103-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559823880-29103-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 03/10] target/mips: Outline places for
 future MSA helpers
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

Outline places for future MSA helpers to follow the same organization
as in MSA tests.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1559745316-1454-7-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/msa_helper.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 851450c..7b73e22 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -42,6 +42,144 @@
 /* Element-by-element access macros */
 #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
 
+
+
+/*
+ * Bit Count
+ * ---------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Bit move
+ * --------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Bit Set
+ * -------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Fixed Multiply
+ * --------------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Int Add
+ * -------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Int Average
+ * -----------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Int Compare
+ * -----------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Int Divide
+ * ----------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Int Dot Product
+ * ---------------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Int Max Min
+ * -----------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Int Modulo
+ * ----------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Int Multiply
+ * ------------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Int Subtract
+ * ------------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Interleave
+ * ----------
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Logic
+ * -----
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Pack
+ * ----
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
+/*
+ * Shift
+ * -----
+ */
+
+/* TODO: insert appropriate helpers here */
+
+
 static inline void msa_move_v(wr_t *pwd, wr_t *pws)
 {
     uint32_t i;
-- 
2.7.4


