Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B4EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2E2204EA
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW6pUZJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2E2204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMppy-0007dB-5w
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kMpoK-0006DL-FB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:51:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kMpoI-0006vy-Pn
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:51:08 -0400
Received: by mail-pg1-x541.google.com with SMTP id s31so392099pga.7
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XI3/oWaJG+zKphVr0DS9JO4bnux88sWNKgA4LOVVoN0=;
 b=WW6pUZJfkfDsL8otlBh0+NL8sIot2e2WlzfiHSKdFBcGaHW6/jD1ke4+TgJvLMDvrG
 NO6aymVWTWeg/n6YLVKdRi05EZMGtID9yJq4knuokXob8pl4ZdRVWiXS/9S/Ills915y
 vhM0HtfN7CYqKR9eUzHPAx2m4vV4rBEdd3Y4g5dkTCKcx0DjAu7gCnj9gGI+OOh/HsQ/
 UShScLKJSOehrgA0wAsd/MIjseEaqoMITvShZ95SEJMN+f6WcNcf2Qwytx1+ZAasb5nO
 sYn/csiztEZrOHEjxQhSCJGC91vcKi0rqoFCcpSHlnaqrvHyzlZ5N+d7t04W0lTo42Ku
 5i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XI3/oWaJG+zKphVr0DS9JO4bnux88sWNKgA4LOVVoN0=;
 b=Z0U52jp7uaVeyb07yVE6OgDiw5YfmdXtb09HurdtiFoA3DaS1UVzc857tLGpb6sfxA
 xPXllw+l0nh3tIzXw4n5n474k1J0Sbt7n5UyVPX4PH+saisFiBmKmdqvgsQmXzwbi9mI
 OpPo566nXIa14zNDAacIdey0MUPIwtOpa1lib+jd/FAB3sHGwjZ72r1C0AgpJ4ydNVok
 dHI4Cfn6JC4sx0Kkc714BQVJKgqKjITA6SJ/vjZ1Sh61RdsUUzDJr+HXN2h9LofMM5BS
 OQwzkoHnu51ZcLDWLrab0RAE+hktDgg6isgN4nwnOPqzw09R0W72TOz5RjC6u0WmVhF5
 9E1g==
X-Gm-Message-State: AOAM5312T1/OcX5xdaX4ieqSMh03/U2poPPNm5mHeB5n+g6S9n3hGhSF
 YR9t7wn8OFna0XC6JaB7RJ7vD14CtsQaDA==
X-Google-Smtp-Source: ABdhPJyiIH+vxkpxl6AhRc3/znmic/H68Ksv60Q+Zt38Yv+iZiwP4JpkI1ONgpQy5+aTxH/ddhNJdQ==
X-Received: by 2002:a62:1c96:0:b029:142:4bf7:15f3 with SMTP id
 c144-20020a621c960000b02901424bf715f3mr9378208pfc.75.1601286665559; 
 Mon, 28 Sep 2020 02:51:05 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id j4sm865417pfj.143.2020.09.28.02.51.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 02:51:04 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V12 2/8] target/mips: Fix PageMask with variable page size
Date: Mon, 28 Sep 2020 17:49:40 +0800
Message-Id: <1601286586-1810-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1601286586-1810-1-git-send-email-chenhc@lemote.com>
References: <1601286586-1810-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x541.google.com
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
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Our current code assumed the target page size is always 4k
when handling PageMask and VPN2, however, variable page size
was just added to mips target and that's no longer true.

Fixes: ee3863b9d414 ("target/mips: Support variable page size")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/cp0_helper.c | 36 +++++++++++++++++++++++++++++-------
 target/mips/cpu.h        |  1 +
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index de64add..f3478d8 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -867,13 +867,35 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
 
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
+    if (env->insn_flags & ISA_MIPS32R6) {
+        return;
+    }
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
+    /*
+     * When invalid, ensure the value is bigger than or equal to
+     * the minimal but smaller than or equal to the maxium.
+     */
+    maskbits = MIN(16, MAX(maskbits, TARGET_PAGE_BITS - 12));
+    env->CP0_PageMask = ((1 << (16 + 1)) - 1) << CP0PM_MASK;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
@@ -1104,7 +1126,7 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong old, val, mask;
-    mask = (TARGET_PAGE_MASK << 1) | env->CP0_EntryHi_ASID_mask;
+    mask = ~((1 << 14) - 1) | env->CP0_EntryHi_ASID_mask;
     if (((env->CP0_Config4 >> CP0C4_IE) & 0x3) >= 2) {
         mask |= 1 << CP0EnHi_EHINV;
     }
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7cf7f52..9c8bb23 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -618,6 +618,7 @@ struct CPUMIPSState {
  * CP0 Register 5
  */
     int32_t CP0_PageMask;
+#define CP0PM_MASK 13
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
 #define CP0PG_RIE 31
-- 
2.7.0


