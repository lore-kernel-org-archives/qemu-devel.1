Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00B3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 01:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B6A20739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 01:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIjFPI+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B6A20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsGN5-0005f9-0T
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 21:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsGMQ-00056u-BP
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 21:55:58 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsGMO-0004OY-JX
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 21:55:58 -0400
Received: by mail-pf1-x441.google.com with SMTP id z3so7037159pfn.12
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 18:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D9HKGFFE5mMpIDjSzOUh2IRorOXkNhanAi+4R0V87Nw=;
 b=hIjFPI+tPuVp6vu2GRY/lqO/Rg5EfL87QDhU6ri2fcUhPb8AzzL1vz0rz72CVM0+d1
 lPenz18cRG9nAb6NApLbfNYuXhoHHMsgVK4hMFg5kwsS11aYxewvUxrFioeLYvMSZQ/z
 OoYs0d7GTnkC8OGpxPsQ+YcQpwxp95x2fvbeyXzkTxG5HGvDrTaPlFvNtT/hymHrjASn
 k6ed0psTNlNP66/1pktqCfSwI5wFPNyL+8an3WsRiy3sS5b2led0zLYm4hnSQpN/CWSl
 HGjYPXhwR1GfJTbadaPg86zwNEnxMhcuLLaQcVIb0MwSTx4gndqo6XO5bmDRGFT0zThV
 4tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D9HKGFFE5mMpIDjSzOUh2IRorOXkNhanAi+4R0V87Nw=;
 b=cPXEGS14O4epfZYEl/d5j3SSw153/REEa3MlafsYAM3Goi1U+rYO33PNdRl/pfBUOO
 EgxaK3Fnyn5Yrnar0pxrk3x5ttY2r0PLA+lR9+Q+O3ZJ1FPuhjeF5q00tYRLiWjUFiQr
 K4oIRta+PXBNDlN/GdSHOBqsLM2AXKey0fbUvLjWAPc3iBFgK5lRRWlNfijrcRH/7GuY
 3KBSQSUcaUyVlAAjrTKLO7J5WJ4oUMbzfK+jgB/7+kxTrmAkh63ypbU1kXoZPTzP84Wr
 J2+DV8JBtPF/YhphEmW8q0ECV8Q5GodX2BnJd18FIFKyjiEEaZC9AvHFOw2N43jDWPT7
 n2yw==
X-Gm-Message-State: AOAM533CFGCImMDhFLrVoPuKS4Ijb3XUH7HHBqw9uqepytaxOXIOgQ4r
 +ML9l6eShxvulyDSKEJMd+6pJiW/
X-Google-Smtp-Source: ABdhPJzqOciTjIdkLi0ULedI7bqEdZBDSfh4DupcwUJMbgx3YxqdZsDWiyXe2p3ROuJnmmbj0CtdCg==
X-Received: by 2002:a63:ab4f:: with SMTP id k15mr37064064pgp.247.1594000555009; 
 Sun, 05 Jul 2020 18:55:55 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id fh12sm14850372pjb.5.2020.07.05.18.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 18:55:54 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/xtensa: implement NMI support
Date: Sun,  5 Jul 2020 18:55:39 -0700
Message-Id: <20200706015539.7956-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When NMI is configured it is taken regardless of INTENABLE SR contents,
PS.INTLEVEL or PS.EXCM. It is cleared automatically once it's taken.

Add nmi_level to XtensaConfig, puth there NMI level from the overlay or
XCHAL_NUM_INTLEVELS + 1 when NMI is not configured. Add NMI mask to
INTENABLE SR and limit CINTLEVEL to nmi_level - 1 when determining
pending IRQ level in check_interrupt(). Always take and clear pending
interrupt at nmi_level in the handle_interrupt().

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/pic_cpu.c          |  6 +++++-
 target/xtensa/cpu.h          |  1 +
 target/xtensa/exc_helper.c   | 23 +++++++++++++++--------
 target/xtensa/overlay_tool.h |  6 +++++-
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index edd53c9241c5..1d5982a9e424 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -35,9 +35,13 @@ void check_interrupts(CPUXtensaState *env)
 {
     CPUState *cs = env_cpu(env);
     int minlevel = xtensa_get_cintlevel(env);
-    uint32_t int_set_enabled = env->sregs[INTSET] & env->sregs[INTENABLE];
+    uint32_t int_set_enabled = env->sregs[INTSET] &
+        (env->sregs[INTENABLE] | env->config->inttype_mask[INTTYPE_NMI]);
     int level;
 
+    if (minlevel >= env->config->nmi_level) {
+        minlevel = env->config->nmi_level - 1;
+    }
     for (level = env->config->nlevel; level > minlevel; --level) {
         if (env->config->level_mask[level] & int_set_enabled) {
             env->pending_irq_level = level;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 65f00028501a..0c96181212a5 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -433,6 +433,7 @@ struct XtensaConfig {
     uint32_t exception_vector[EXC_MAX];
     unsigned ninterrupt;
     unsigned nlevel;
+    unsigned nmi_level;
     uint32_t interrupt_vector[MAX_NLEVEL + MAX_NNMI + 1];
     uint32_t level_mask[MAX_NLEVEL + MAX_NNMI + 1];
     uint32_t inttype_mask[INTTYPE_MAX];
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 601341d13aa0..58a64e6d620e 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -132,11 +132,15 @@ void HELPER(intset)(CPUXtensaState *env, uint32_t v)
               v & env->config->inttype_mask[INTTYPE_SOFTWARE]);
 }
 
+static void intclear(CPUXtensaState *env, uint32_t v)
+{
+    atomic_and(&env->sregs[INTSET], ~v);
+}
+
 void HELPER(intclear)(CPUXtensaState *env, uint32_t v)
 {
-    atomic_and(&env->sregs[INTSET],
-               ~(v & (env->config->inttype_mask[INTTYPE_SOFTWARE] |
-                      env->config->inttype_mask[INTTYPE_EDGE])));
+    intclear(env, v & (env->config->inttype_mask[INTTYPE_SOFTWARE] |
+                       env->config->inttype_mask[INTTYPE_EDGE]));
 }
 
 static uint32_t relocated_vector(CPUXtensaState *env, uint32_t vector)
@@ -159,11 +163,11 @@ static void handle_interrupt(CPUXtensaState *env)
 {
     int level = env->pending_irq_level;
 
-    if (level > xtensa_get_cintlevel(env) &&
-        level <= env->config->nlevel &&
-        (env->config->level_mask[level] &
-         env->sregs[INTSET] &
-         env->sregs[INTENABLE])) {
+    if ((level > xtensa_get_cintlevel(env) &&
+         level <= env->config->nlevel &&
+         (env->config->level_mask[level] &
+          env->sregs[INTSET] & env->sregs[INTENABLE])) ||
+        level == env->config->nmi_level) {
         CPUState *cs = env_cpu(env);
 
         if (level > 1) {
@@ -173,6 +177,9 @@ static void handle_interrupt(CPUXtensaState *env)
                 (env->sregs[PS] & ~PS_INTLEVEL) | level | PS_EXCM;
             env->pc = relocated_vector(env,
                                        env->config->interrupt_vector[level]);
+            if (level == env->config->nmi_level) {
+                intclear(env, env->config->inttype_mask[INTTYPE_NMI]);
+            }
         } else {
             env->sregs[EXCCAUSE] = LEVEL1_INTERRUPT_CAUSE;
 
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index a994e69b6e96..eb9f08af0bf6 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -216,6 +216,9 @@
 #define XTHAL_INTTYPE_IDMA_ERR INTTYPE_IDMA_ERR
 #define XTHAL_INTTYPE_GS_ERR INTTYPE_GS_ERR
 
+#ifndef XCHAL_NMILEVEL
+#define XCHAL_NMILEVEL (XCHAL_NUM_INTLEVELS + 1)
+#endif
 
 #define INTERRUPT(i) { \
         .level = XCHAL_INT ## i ## _LEVEL, \
@@ -305,7 +308,8 @@
 
 #define INTERRUPTS_SECTION \
     .ninterrupt = XCHAL_NUM_INTERRUPTS, \
-    .nlevel = XCHAL_NUM_INTLEVELS, \
+    .nlevel = XCHAL_NUM_INTLEVELS + XCHAL_HAVE_NMI, \
+    .nmi_level = XCHAL_NMILEVEL, \
     .interrupt_vector = INTERRUPT_VECTORS, \
     .level_mask = LEVEL_MASKS, \
     .inttype_mask = INTTYPE_MASKS, \
-- 
2.20.1


