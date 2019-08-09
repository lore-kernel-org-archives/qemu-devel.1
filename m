Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D20C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A655920B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A655920B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4R8-0000wy-Um
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 08:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53017)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hw4K3-0002Gf-9m
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hw4K0-0001H2-Oz
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:52665 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hw4K0-0001A8-3z
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:40 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id CD8D01A21D1;
 Fri,  9 Aug 2019 14:48:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id B1B971A21BF;
 Fri,  9 Aug 2019 14:48:25 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 14:46:53 +0200
Message-Id: <1565354819-1495-21-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565354819-1495-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1565354819-1495-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v7 20/26] target/mips: Clean up
 handling of CP0 register 20
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 20.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ea2d4b1..fb62ed8 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7388,7 +7388,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_20:
         switch (sel) {
-        case 0:
+        case CP0_REG20__XCONTEXT:
 #if defined(TARGET_MIPS64)
             check_insn(ctx, ISA_MIPS3);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_XContext));
@@ -8127,7 +8127,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_20:
         switch (sel) {
-        case 0:
+        case CP0_REG20__XCONTEXT:
 #if defined(TARGET_MIPS64)
             check_insn(ctx, ISA_MIPS3);
             gen_helper_mtc0_xcontext(cpu_env, arg);
@@ -8872,7 +8872,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_20:
         switch (sel) {
-        case 0:
+        case CP0_REG20__XCONTEXT:
             check_insn(ctx, ISA_MIPS3);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_XContext));
             register_name = "XContext";
@@ -9593,7 +9593,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_20:
         switch (sel) {
-        case 0:
+        case CP0_REG20__XCONTEXT:
             check_insn(ctx, ISA_MIPS3);
             gen_helper_mtc0_xcontext(cpu_env, arg);
             register_name = "XContext";
-- 
2.7.4


