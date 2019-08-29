Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFE2C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA652173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA652173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3I1M-0006Ws-Af
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hco-0005Yv-SH
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcn-00065i-2B
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45763 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3Hcm-0005lH-Nl
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C95261A2261;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id ABD5C1A21D6;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:25:13 +0200
Message-Id: <1567074313-22998-32-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 31/31] target/mips: Fix emulation of ST.W in
 system mode
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

Order of arguments in helper_ret_stl_mmu() invocations was wrong,
apparently caused by a misplaced multiline copy-and-paste.

Fixes: 6decc57 ("target/mips: Fix MSA instructions ST.<B|H|W|D> on big endian host")

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1567009239-11273-1-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/op_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index f88a3ab..5b8bb20 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -4692,15 +4692,15 @@ void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
     ensure_writable_pages(env, addr, mmu_idx, GETPC());
 #if !defined(CONFIG_USER_ONLY)
 #if !defined(HOST_WORDS_BIGENDIAN)
-    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GETPC(), pwd->w[0]);
-    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GETPC(), pwd->w[1]);
-    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GETPC(), pwd->w[2]);
-    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GETPC(), pwd->w[3]);
+    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), pwd->w[0], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), pwd->w[1], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), pwd->w[2], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), pwd->w[3], oi, GETPC());
 #else
-    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GETPC(), pwd->w[0]);
-    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GETPC(), pwd->w[1]);
-    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GETPC(), pwd->w[2]);
-    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GETPC(), pwd->w[3]);
+    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), pwd->w[0], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), pwd->w[1], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), pwd->w[2], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), pwd->w[3], oi, GETPC());
 #endif
 #else
 #if !defined(HOST_WORDS_BIGENDIAN)
-- 
2.7.4


