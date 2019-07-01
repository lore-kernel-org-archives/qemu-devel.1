Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8E1C06511
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3E9206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3E9206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuAW-0006Ws-On
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41134)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hhu8D-0004sz-TB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hhu8C-00076A-OQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:05:57 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48943 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hhu8C-00067R-DT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:05:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7B1DB1A2005;
 Mon,  1 Jul 2019 13:04:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 53AA01A1FE3;
 Mon,  1 Jul 2019 13:04:51 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	arikalo@wavecomp.com
Date: Mon,  1 Jul 2019 13:04:36 +0200
Message-Id: <1561979080-26195-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561979080-26195-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561979080-26195-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 3/7] target/mips: Correct comments in
 msa_helper.c
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

Fix some errors in comments for MSA helpers.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/msa_helper.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 8bad636..880fc52 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -72,9 +72,6 @@
  * --------
  *
  * +---------------+----------------------------------------------------------+
- * | BMNZ.V        | Vector Bit Move If Not Zero                              |
- * | BMZ.V         | Vector Bit Move If Zero                                  |
- * | BSEL.V        | Vector Bit Select                                        |
  * | BINSL.B       | Vector Bit Insert Left (byte)                            |
  * | BINSL.H       | Vector Bit Insert Left (halfword)                        |
  * | BINSL.W       | Vector Bit Insert Left (word)                            |
@@ -83,6 +80,9 @@
  * | BINSR.H       | Vector Bit Insert Right (halfword)                       |
  * | BINSR.W       | Vector Bit Insert Right (word)                           |
  * | BINSR.D       | Vector Bit Insert Right (doubleword)                     |
+ * | BMNZ.V        | Vector Bit Move If Not Zero                              |
+ * | BMZ.V         | Vector Bit Move If Zero                                  |
+ * | BSEL.V        | Vector Bit Select                                        |
  * +---------------+----------------------------------------------------------+
  */
 
@@ -179,12 +179,12 @@
  * | ADDV.H        | Vector Add (halfword)                                    |
  * | ADDV.W        | Vector Add (word)                                        |
  * | ADDV.D        | Vector Add (doubleword)                                  |
- * | HSUB_S.H      | Vector Signed Horizontal Add (halfword)                  |
- * | HSUB_S.W      | Vector Signed Horizontal Add (word)                      |
- * | HSUB_S.D      | Vector Signed Horizontal Add (doubleword)                |
- * | HSUB_U.H      | Vector Unigned Horizontal Add (halfword)                 |
- * | HSUB_U.W      | Vector Unigned Horizontal Add (word)                     |
- * | HSUB_U.D      | Vector Unigned Horizontal Add (doubleword)               |
+ * | HADD_S.H      | Vector Signed Horizontal Add (halfword)                  |
+ * | HADD_S.W      | Vector Signed Horizontal Add (word)                      |
+ * | HADD_S.D      | Vector Signed Horizontal Add (doubleword)                |
+ * | HADD_U.H      | Vector Unigned Horizontal Add (halfword)                 |
+ * | HADD_U.W      | Vector Unigned Horizontal Add (word)                     |
+ * | HADD_U.D      | Vector Unigned Horizontal Add (doubleword)               |
  * +---------------+----------------------------------------------------------+
  */
 
@@ -279,6 +279,18 @@
  * | DOTP_U.H      | Vector Unsigned Dot Product (halfword)                   |
  * | DOTP_U.W      | Vector Unsigned Dot Product (word)                       |
  * | DOTP_U.D      | Vector Unsigned Dot Product (doubleword)                 |
+ * | DPADD_S.H     | Vector Signed Dot Product (halfword)                     |
+ * | DPADD_S.W     | Vector Signed Dot Product (word)                         |
+ * | DPADD_S.D     | Vector Signed Dot Product (doubleword)                   |
+ * | DPADD_U.H     | Vector Unsigned Dot Product (halfword)                   |
+ * | DPADD_U.W     | Vector Unsigned Dot Product (word)                       |
+ * | DPADD_U.D     | Vector Unsigned Dot Product (doubleword)                 |
+ * | DPSUB_S.H     | Vector Signed Dot Product (halfword)                     |
+ * | DPSUB_S.W     | Vector Signed Dot Product (word)                         |
+ * | DPSUB_S.D     | Vector Signed Dot Product (doubleword)                   |
+ * | DPSUB_U.H     | Vector Unsigned Dot Product (halfword)                   |
+ * | DPSUB_U.W     | Vector Unsigned Dot Product (word)                       |
+ * | DPSUB_U.D     | Vector Unsigned Dot Product (doubleword)                 |
  * +---------------+----------------------------------------------------------+
  */
 
@@ -446,7 +458,19 @@
  * +---------------+----------------------------------------------------------+
  */
 
-/* TODO: insert Logic group helpers here */
+/* TODO: insert Interleave group helpers here */
+
+
+/*
+ * Move
+ * ----
+ *
+ * +---------------+----------------------------------------------------------+
+ * | MOVE.V        | Vector Move                                              |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Move group helpers here */
 
 
 /*
-- 
2.7.4


