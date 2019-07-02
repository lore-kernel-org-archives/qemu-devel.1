Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6103DC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A3B21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A3B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHNf-0002vk-2d
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiHKC-000156-QK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiHKB-0006oO-Qo
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:51:52 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41111 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hiHKB-0005Lf-8D
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:51:51 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 9E3381A2036;
 Tue,  2 Jul 2019 13:50:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 16A4F1A243F;
 Tue,  2 Jul 2019 13:50:34 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	arikalo@wavecomp.com
Date: Tue,  2 Jul 2019 13:50:13 +0200
Message-Id: <1562068213-11307-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562068213-11307-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1562068213-11307-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 7/7] target/mips: Correct helper for MSA
 FCLASS.<W|D> instructions
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

Correct helper for MSA FCLASS.<W|D> instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 target/mips/msa_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 97f840b..a383c40 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -4058,9 +4058,11 @@ void helper_msa_fclass_df(CPUMIPSState *env, uint32_t df,
         pwd->w[1] = float_class_s(pws->w[1], status);
         pwd->w[2] = float_class_s(pws->w[2], status);
         pwd->w[3] = float_class_s(pws->w[3], status);
-    } else {
+    } else if (df == DF_DOUBLE) {
         pwd->d[0] = float_class_d(pws->d[0], status);
         pwd->d[1] = float_class_d(pws->d[1], status);
+    } else {
+        assert(0);
     }
 }
 
-- 
2.7.4


