Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487ADC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD622339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD622339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ldx-0006qg-PO
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i0lPL-00059Z-C2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i0lPI-00085r-Lw
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49970 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i0lPH-0007rB-DL
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:31 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 450FE1A20E9;
 Thu, 22 Aug 2019 13:35:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 12CD61A20BE;
 Thu, 22 Aug 2019 13:35:59 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 13:35:46 +0200
Message-Id: <1566473750-17743-23-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566473750-17743-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566473750-17743-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 22/26] target/mips: Clean up handling of CP0
 register 27
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
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 27.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f7e33f6..936c51c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7513,10 +7513,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_27:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
+        case CP0_REG27__CACHERR:
             tcg_gen_movi_tl(arg, 0); /* unimplemented */
             register_name = "CacheErr";
             break;
@@ -8275,10 +8272,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_27:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
+        case CP0_REG27__CACHERR:
             /* ignored */
             register_name = "CacheErr";
             break;
@@ -9014,10 +9008,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     case CP0_REGISTER_27:
         switch (sel) {
         /* ignored */
-        case 0:
-        case 1:
-        case 2:
-        case 3:
+        case CP0_REG27__CACHERR:
             tcg_gen_movi_tl(arg, 0); /* unimplemented */
             register_name = "CacheErr";
             break;
@@ -9757,10 +9748,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_27:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
+        case CP0_REG27__CACHERR:
             /* ignored */
             register_name = "CacheErr";
             break;
-- 
2.7.4


