Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEF1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117FF20679
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiHeOkWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117FF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1katG0-00018e-1S
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 23:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1katF5-0000GK-8o
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:20:51 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:47089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1katF3-0006ye-6Q
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:20:50 -0500
Received: by mail-pf1-x444.google.com with SMTP id v12so115078pfm.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 20:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=n4pz/cutgf1JMEQKcKFhr08W0x4nJaQWv+imXC9dhw8=;
 b=XiHeOkWkKl2XNv9CMAtHVtJzPhWnrQF8oxdHe0ES4dLWeSPDdJOEzRerCxFHzbGCSz
 WtilhsULvWDGB2FeUcAQvdDUXAXcQxZVYdEhvK5ExCr1DGhmUvbmp5sOsrFSric7KEn1
 TuEHVMznfz8n+mDDCAA7EY972L10E+r/5qD+661h4ML71raeTHXHJNrPpsT7tXUG+Eg7
 VTbEfT6LxHlVPQpAK/PWv6MgIOx3f+WDmGqo5eIYwzMNO7xZ1lPn7Y6BOpYvccocb+GE
 g3Lt7+lDm1aKD/yoK06q+WVdyoYg4wrSOIrrgkFNk9YZ/M4LB7VDVWfN3DfbaRrcQWFh
 87Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=n4pz/cutgf1JMEQKcKFhr08W0x4nJaQWv+imXC9dhw8=;
 b=o/Q3PIkalHn1Z9XXOAUSwwTBzeVJQQuf10MPpCy4QhBvpHh9prqhQe0GEj0T83+Hy0
 y56ZgERpTS0ptiKoS5hj+Q0to6U7Wkp9UwnWYBe/4QPFmCavlubz8gB+qobN690pWdHU
 sLTd0mD9DWMpGSry6xOvuGb92gyzYTrtMP6zaVl+4mzcqPM7iIGgau8iQhwSp1+8m5nA
 fQ/EKNG0QZcGWYT4BzwmvFAXtJya94gWF5NENilgwQqiNaZ1dDmpL3RY7flzZY4nEnsj
 EU5WWmlHj54lQ82iIZ3IQ3og4T/VW/ZvtmMJi4llM2Bf+otyOz/EhPUnK5C2Ct1obkTI
 02TQ==
X-Gm-Message-State: AOAM531yaHG9X7epFHad0GS6+oxhqhP6KUBazzG8D+VDQfdOAt7G7hxa
 cmWKlBQ9HXoo8dxJotSpwEc=
X-Google-Smtp-Source: ABdhPJwidDsjh0RdAoOuF8HLWHwFZwLEjSNsUyKPci4elnyc5AkWD3Qjb6Ki932860aUaatunOAwkw==
X-Received: by 2002:a17:90a:8d81:: with SMTP id
 d1mr361690pjo.174.1604636447851; 
 Thu, 05 Nov 2020 20:20:47 -0800 (PST)
Received: from software.domain.org (111-252-196-15.dynamic-ip.hinet.net.
 [111.252.196.15])
 by smtp.gmail.com with ESMTPSA id y1sm262235pjl.12.2020.11.05.20.20.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Nov 2020 20:20:47 -0800 (PST)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH V17 1/6] target/mips: Fix PageMask with variable page size
Date: Fri,  6 Nov 2020 12:21:45 +0800
Message-Id: <1604636510-8347-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
References: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Our current code assumed the target page size is always 4k
when handling PageMask and VPN2, however, variable page size
was just added to mips target and that's no longer true.

Fixes: ee3863b9d414 ("target/mips: Support variable page size")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 target/mips/cp0_helper.c | 27 +++++++++++++++++++++------
 target/mips/cpu.h        |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index 709cc9a..92bf14f 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -892,13 +892,28 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
 
 void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
 {
-    uint64_t mask = arg1 >> (TARGET_PAGE_BITS + 1);
-    if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 == ~0) ||
-        (mask == 0x0000 || mask == 0x0003 || mask == 0x000F ||
-         mask == 0x003F || mask == 0x00FF || mask == 0x03FF ||
-         mask == 0x0FFF || mask == 0x3FFF || mask == 0xFFFF)) {
-        env->CP0_PageMask = arg1 & (0x1FFFFFFF & (TARGET_PAGE_MASK << 1));
+    unsigned long mask;
+    int maskbits;
+
+    /* Don't care MASKX as we don't support 1KB page */
+    mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
+    maskbits = find_first_zero_bit(&mask, 32);
+
+    /* Ensure no more set bit after first zero */
+    if (mask >> maskbits) {
+        goto invalid;
+    }
+    /* We don't support VTLB entry smaller than target page */
+    if ((maskbits + 12) < TARGET_PAGE_BITS) {
+        goto invalid;
     }
+    env->CP0_PageMask = mask << CP0PM_MASK;
+
+    return;
+
+invalid:
+    /* When invalid, set to default target page size. */
+    env->CP0_PageMask = (~TARGET_PAGE_MASK >> 12) << CP0PM_MASK;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index d41579d..23f8c6f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -619,6 +619,7 @@ struct CPUMIPSState {
  * CP0 Register 5
  */
     int32_t CP0_PageMask;
+#define CP0PM_MASK 13
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
 #define CP0PG_RIE 31
-- 
2.7.0


