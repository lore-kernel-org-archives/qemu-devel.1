Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50070C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207CC21874
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHYpspJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207CC21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa34-0005WV-SO
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54936)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa2f-0004D5-Sx
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa2a-00059n-Mq
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:46 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa2T-00056i-0R
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:39 -0400
Received: by mail-pf1-x443.google.com with SMTP id i189so14681887pfg.10
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nZO9a9G7poP5q7QtQAMHuH2LEKdKZAUGfJYJRNmcsyc=;
 b=hHYpspJplVd0JkXAIgRW60Gau36EXQSETX/w2u6+SeJJIZ5OakTIj3WK/cXtnDVi4m
 x/sHKibKk1ydWnvm06RDouvOvjOrBEMfX3Em93+nBQAk//YEhiMGLN5RNFDzt76dptgJ
 6Ekgtwnba0L0MxrnGuf0MTpNM9sC7olS+F333ETK7KPPTGAbv9WHESkYAZF0MvgCMu7S
 JJFw/wk3AAbbsYfs61SLOSDXfB2zzacsu6mfzDc7993MOc2CZgRCQ9vAsefMofFIVbu7
 Zxptg0mQhjO/fo/iWxO0Yspzv9/pvX0scEXJIfabiVPdNIpTYqXsTOx+Z944E5/alR37
 AxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nZO9a9G7poP5q7QtQAMHuH2LEKdKZAUGfJYJRNmcsyc=;
 b=rVIWAX9hS3DGcer+D4GNLbUVAN4NPf3oH3ospqKempLcNkpH7glgYjpYqC0QZn5lei
 YBv5HszwWhdeAqIpdMt5wO5+FUtBIuuBLKjPGQ1w5+oVtj1bMTMjiXIaNkKILHerpIAy
 9a6QUxCImePVXTmkcoOnl9i/zhURb1mBuYMFY20GkF9H14wIRJ7vqyDG87JeWaacFr/H
 ILUbauc8ZKXI2Ipei4Ob3zc3Oc66eltgd02X1xKsgnyy5YJVR5+le1AW+1MAQcADK09L
 nlbW/HrG8ZOxT5Dx212JGjot9FLfGd/45kNVxP+74g48oyIJ1HKtIOGvZcljBDRV043o
 z/cg==
X-Gm-Message-State: APjAAAWtkA5Ni8LPm7bB0UWyBbVQsaHBudmL1BGHNiCzoiqMk/+MTlqy
 90D5JCrjyqhb+KBn7q50j/0jgJVe0lU=
X-Google-Smtp-Source: APXvYqxoUXgFxMfQ2MoAL07V74ZodD+EHOvuXBrsVEWNYRxK4KYM6jLtFC8ycJtPQizEIK00CEtuDA==
X-Received: by 2002:a63:fa4e:: with SMTP id g14mr55915460pgk.237.1563570213368; 
 Fri, 19 Jul 2019 14:03:33 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:06 -0700
Message-Id: <20190719210326.15466-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH for-4.2 04/24] target/arm: Install ASIDs for
 short-form from EL1
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is less complex than the LPAE case, but still we now avoid the
flush in case it is only the PROCID field that is changing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0f21a077de..1ed7c06313 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -551,17 +551,31 @@ static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-
-    if (raw_read(env, ri) != value && !arm_feature(env, ARM_FEATURE_PMSA)
-        && !extended_addresses_enabled(env)) {
-        /* For VMSA (when not using the LPAE long descriptor page table
-         * format) this register includes the ASID, so do a TLB flush.
-         * For PMSA it is purely a process ID and no action is needed.
-         */
-        tlb_flush(CPU(cpu));
-    }
     raw_write(env, ri, value);
+
+    /*
+     * For VMSA (when not using the LPAE long descriptor page table format)
+     * this register includes the ASID.  For PMSA it is purely a process ID
+     * and no action is needed.
+     */
+    if (!arm_feature(env, ARM_FEATURE_PMSA) &&
+        !extended_addresses_enabled(env)) {
+        CPUState *cs = env_cpu(env);
+        int asid = extract32(value, 0, 8);
+        int idxmask;
+
+        switch (ri->secure) {
+        case ARM_CP_SECSTATE_S:
+            idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+            break;
+        case ARM_CP_SECSTATE_NS:
+            idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
+    }
 }
 
 /* IS variants of TLB operations must affect all cores */
-- 
2.17.1


