Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AE2C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F149B22CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7t/DE89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F149B22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5TNQ-0000MX-3L
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 07:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5TLf-00076E-Pr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5TLd-0007E1-Fx
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5TLd-0007Cl-8D
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id r195so3238684wme.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k8unDVXpqLg5lphwGOo47n1fiubp2aXlLo/SotwPOPg=;
 b=H7t/DE89yjsHHkLoLe7eOvU/ei+v20trln0fY4LNKV62HDVgcVHpCl9AF/cZWjBV23
 6kbK3qBEt9zti5fO7MMqIyHHCBMH4dVEbM/6mD/PwnL0YBX65K18AcMyRLZcfgjHH/RR
 YsI8cz9c84iTUSMjB+H0W7HeG8H7tdNSQtyVjYa8eZF+9h2Rkkrhcct/5rxneVuTjpjm
 exJVpnc9rptHamN/Q9pl7bFcKgN1K5s+K6gQl6Gyt3No+wFLr6Jq2IvWKesCFl4PhPHO
 ao3hu4++24FvHJB6Nx5/xmMcQkdCm2vNG0+J3K51b3W8hcALWygKLRbCAIi1TlrIuGNb
 dpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k8unDVXpqLg5lphwGOo47n1fiubp2aXlLo/SotwPOPg=;
 b=gCMUeH7spdsH4mjBoCDrjjcUsDoWynTmJwQX9GuTmaBbr/thzvXwJzP4Of2HB0Wgq2
 4XLNQRO2f2PxHjqqNdFWEEnM73fk0qF3qooFaXeeGKhimmMBuBP3AKuwdh3wYbZlqvTo
 68CfsAsasPdTZYb6dDSl6cZy9MZnYM6h2ydnXbOa4IFgyhkLrqGXX0bixm8gs+IiaJ48
 0EwxYDIlK3bAJ3DoatryO+81j+dKqjV3ucYlc2zEQrss9D/QjWOmQc4YLNzGpfAMRDRJ
 GR7wntjhoFatkMwHzy55miuoI0dvy+iBSwYwDAvpDHEncn+UCAf5RJp/uK1RoU3BJijQ
 MEXg==
X-Gm-Message-State: APjAAAXPHHSwkC60DGhZqQlZeHflOYgDnMa8zrn45w+PghsbJTX1CFJ/
 NSaL7eKvgbZfuETLwWVjBPJgsA==
X-Google-Smtp-Source: APXvYqyuFhHQiqR0kX2pHqQwIyVV7skqXZgITrH/Rls16fRUbG4UNJvg6viyP2NAYOW7kDpIanGB+w==
X-Received: by 2002:a1c:e709:: with SMTP id e9mr3987262wmh.65.1567596072093;
 Wed, 04 Sep 2019 04:21:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a205sm1678669wmd.44.2019.09.04.04.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 04:21:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 23C091FF8C;
 Wed,  4 Sep 2019 12:21:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:21:04 +0100
Message-Id: <20190904112108.2341-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904112108.2341-1-alex.bennee@linaro.org>
References: <20190904112108.2341-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PATCH v2 1/5] target/arm: handle M-profile
 semihosting at translate time
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do this for other semihosting calls so we might as well do it for
M-profile as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - update for change to gen_exception_internal_insn API
---
 target/arm/m_helper.c  | 18 ++++++------------
 target/arm/translate.c | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 884d35d2b02..27cd2f3f964 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -2114,19 +2114,13 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
             break;
         }
         break;
+    case EXCP_SEMIHOST:
+        qemu_log_mask(CPU_LOG_INT,
+                      "...handling as semihosting call 0x%x\n",
+                      env->regs[0]);
+        env->regs[0] = do_arm_semihosting(env);
+        return;
     case EXCP_BKPT:
-        if (semihosting_enabled()) {
-            int nr;
-            nr = arm_lduw_code(env, env->regs[15], arm_sctlr_b(env)) & 0xff;
-            if (nr == 0xab) {
-                env->regs[15] += 2;
-                qemu_log_mask(CPU_LOG_INT,
-                              "...handling as semihosting call 0x%x\n",
-                              env->regs[0]);
-                env->regs[0] = do_arm_semihosting(env);
-                return;
-            }
-        }
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG, false);
         break;
     case EXCP_IRQ:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 615859e23c5..816d46b2205 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10931,6 +10931,24 @@ illegal_op:
     unallocated_encoding(s);
 }
 
+/*
+ * Thumb BKPT. On M-profile CPUs this may be a semihosting call which
+ * we can process much the same way as gen_hlt() above.
+ */
+static inline void gen_thumb_bkpt(DisasContext *s, int imm8)
+{
+    if (arm_dc_feature(s, ARM_FEATURE_M) &&
+        semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        s->current_el != 0 &&
+#endif
+        (imm8 == 0xab)) {
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+        return;
+    }
+    gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm8, true));
+}
+
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t val, op, rm, rn, rd, shift, cond;
@@ -11553,7 +11571,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         {
             int imm8 = extract32(insn, 0, 8);
             ARCH(5);
-            gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm8, true));
+            gen_thumb_bkpt(s, imm8);
             break;
         }
 
-- 
2.20.1


