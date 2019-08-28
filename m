Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEDDC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593AB2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCK8FqcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593AB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31UP-0002hC-Gb
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i31C7-0007eN-Gq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i31C2-0000p5-Tl
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i31C2-0000nz-LP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id p13so811719wmh.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+VsIgRrN67nvrM6dUapwHSRZMRTN8JnYHQijkeU8PPk=;
 b=lCK8FqcRx51jauPL29c8h2ZpVZ+o8lpBXnxS3n4EUFkrQXU2X2FXwu6cMwxOrkxl/9
 M+ZVSrgojBpnjbjgNKDYTJ/KUYOE6qYK04ZykcpORYGup5T0oTMJgX3RpoJfPLt0xxj4
 Y8moF3p7wFzxureUrdsr4S4ot5w5uqDt8GL1WVE14W/vqJQxdbMlzlaMHfQ5C9qlJ4P1
 qm+2hdCKaCSfLZS6aiJjdFIEUebEOog6X21fZ8ddyXq5akBxgs2revDAi+AtbY4+NIdz
 sD32x0m/iF5uRs9pwJEVcNCy5GzVG8LZtb82I0Kzmt+IO4GH95bLgP+jnavVB/2Vhvdp
 xkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+VsIgRrN67nvrM6dUapwHSRZMRTN8JnYHQijkeU8PPk=;
 b=MT9rHkyhRv/0BG3mIuAKQy0nJsFjyVddkRuTToD3YJDT1NoLeJAA5OW2/i67CBGau3
 ycSwfJBm/BqFoL4JpsSMwOVy8mi//9KOyGEzW8I9P4MLdmIBLRQaJqKVh6APekD0645C
 gMZPf8xH9v7ppwPLVh0WIQjTh8U6HsAKs2QGNY6gIaACQawgr+1RAp4ROgi+68hmCpyh
 1SPEX5iemFpomYsuO0ktvSZX5j0Ftqp0RCWOaHAUzgVzuhymDFfLvtjH5v6DKHganvS9
 bbdws/Mx63w9eNFGHQ/bF+NlwshyVVn5wGG7D6B+E6xtjUEc+XTAiysGfSXSjEhB3ycI
 ucqw==
X-Gm-Message-State: APjAAAU7bGQ7xs9nIVDEEvmSrr1qG1AWm0U/om5WCmR3keYIZWfh8JI0
 EanWO7seuQOgVjOhsN7JFiDtBA==
X-Google-Smtp-Source: APXvYqyipWgm0wBss3m28G2CJTElV0OMUw8fRpRLgJ+MB6r+1Ug92IIcT0FHiFKpjcdhUGG+sXS10A==
X-Received: by 2002:a1c:1a4b:: with SMTP id a72mr5066400wma.44.1567011189500; 
 Wed, 28 Aug 2019 09:53:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f197sm7699042wme.22.2019.08.28.09.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 09:53:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D8541FF8C;
 Wed, 28 Aug 2019 17:53:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 17:52:59 +0100
Message-Id: <20190828165307.18321-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828165307.18321-1-alex.bennee@linaro.org>
References: <20190828165307.18321-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PATCH v1 1/9] target/arm: handle M-profile
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
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
index cbe19b7a625..259c4669b4c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10889,6 +10889,24 @@ illegal_op:
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
+        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+        return;
+    }
+    gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm8, true));
+}
+
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t val, op, rm, rn, rd, shift, cond;
@@ -11511,7 +11529,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         {
             int imm8 = extract32(insn, 0, 8);
             ARCH(5);
-            gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm8, true));
+            gen_thumb_bkpt(s, imm8);
             break;
         }
 
-- 
2.20.1


