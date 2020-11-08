Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBFDC4741F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B07206DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0b91KMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B07206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbuMe-00044d-HU
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuKl-0002P1-K8
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:42:55 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuKj-0002Ey-QQ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:42:55 -0500
Received: by mail-wr1-x42a.google.com with SMTP id b8so6915390wrn.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MOQKSfuZ3WXnJIf1iQq//Z2ISnKXo6hb+zOBO4CmoII=;
 b=q0b91KMw4QqU381sTuHTrrnPy7NmrXfWGKI2D3P28mJXmYh/J3Gr0tuRHZg0O0/cKO
 wR1Ey90r1MIyf4/31Uj8pXxcWRRMc//XCVkF+mY/9G0MWCsPQ+eErFWpGaLMZmwzPm1J
 48awH8VF+Rk7mc8cWIZMNsSL0tkcFLn8svHHvhOR1FKpP0ORzl3AFEESUYG0sIlA+avA
 NT2NomC9gvJy4kyP4A0Q/R2qP/rG6yDFjFpVK4aYFxsqSyMV6dLxzVlIQolX76I8ljjM
 Gt6WDuYIz73QeLOpkrvv4YAkxNyxhVUE93AQxMOK8f5ADjNVaRR5LIRHSxf+5OsRiWfj
 Vq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MOQKSfuZ3WXnJIf1iQq//Z2ISnKXo6hb+zOBO4CmoII=;
 b=X0aIgQpjqm2SP4o6GFQ2h6Nqs5XxMbDSWCDOyH0hDx2QLFKkl2UtEEsgQclF4t3/oJ
 1qWTOx5NL1AwFrHaUa/JOf60xfk1kSOnnTf25c0d5HIfu0DkT6+Gr9q+C7vEWQcBSgXR
 a8S+c2Ff1PpG0AocK6sIWcs4etGZtxxm3q62LD7JF1+cdUAv2Aqy0gvYiCHw031LHEXf
 qetjaWHMmrz4GVnPQ8LueUha2AK/tTX56/q2hkq8NgFidDNjrkD5Q7IDeXTXURuqX64g
 3crQUEWSBYeJvewY9oa5Ipbp5z+TChIc3V+wu+1ilV6fQdGIBiqCAnklk9TOVnrYTD+G
 Cdzw==
X-Gm-Message-State: AOAM531fHGPHuTIiGZPiffdTMfl9KwezbolA8eO6uv5Ve4E1Te8oYhYz
 zMdonY2kTZqBniPDcoJrs4mpxdlcBj8=
X-Google-Smtp-Source: ABdhPJwzmHuRWarpqHSrSBEOhOltq46x1N6ScvGfqN92q/FNHpKaiS4CDh+/jYo2eMCBzw2NabMwSQ==
X-Received: by 2002:adf:9461:: with SMTP id 88mr14332374wrq.171.1604878972170; 
 Sun, 08 Nov 2020 15:42:52 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v12sm11741425wro.72.2020.11.08.15.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 15:42:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] target/mips: Fix PageMask with variable page size
Date: Mon,  9 Nov 2020 00:42:33 +0100
Message-Id: <20201108234234.2389789-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108234234.2389789-1-f4bug@amsat.org>
References: <20201108234234.2389789-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Paul Burton <paulburton@kernel.org>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
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
Message-Id: <1604636510-8347-2-git-send-email-chenhc@lemote.com>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: Replaced find_first_zero_bit() by cto32()]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.h        |  1 +
 target/mips/cp0_helper.c | 27 +++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index d41579d44ae..23f8c6f96cd 100644
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
diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index 709cc9a7e3d..a1b5140ccaf 100644
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
+    uint32_t mask;
+    int maskbits;
+
+    /* Don't care MASKX as we don't support 1KB page */
+    mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
+    maskbits = cto32(mask);
+
+    /* Ensure no more set bit after first zero */
+    if ((mask >> maskbits) != 0) {
+        goto invalid;
     }
+    /* We don't support VTLB entry smaller than target page */
+    if ((maskbits + 12) < TARGET_PAGE_BITS) {
+        goto invalid;
+    }
+    env->CP0_PageMask = mask << CP0PM_MASK;
+
+    return;
+
+invalid:
+    /* When invalid, set to default target page size. */
+    env->CP0_PageMask = (~TARGET_PAGE_MASK >> 12) << CP0PM_MASK;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
-- 
2.26.2


