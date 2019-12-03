Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA321C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24A82068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9iXMUtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24A82068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHaN-0005j8-UT
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3e-0002wp-VL
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3Z-0006uv-63
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:11 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH3V-0006aj-9R
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:05 -0500
Received: by mail-pf1-x443.google.com with SMTP id s18so2577878pfm.4
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CW2EPJtOmxl4BSZSTFMUahqoZD/6rAAwVofwfa2CqPY=;
 b=i9iXMUtl7S9kXYrXaO6jMQ2JlSFVx5US+lcZQijuDMQdlT8b5nJs7vbrHyxknWNPEH
 z16qZxgXtKzm9Tcz1TsgM1oFotzJKz6TEhVuQVxcc3RevIjgTxTaxo0HLl9PlCMNeU6g
 EKyVRdvqj+9Iepd94LK/Gyjc2UgQaQ08uzoSbR7Nf41pFK0mArn7XFWY+8fDBejAZhtN
 zLY2kqOgSY586MnxPYED5WuVfoJN2illYRT/DDfIxOeKNCLnCySkEj0Teu92k26/PhIX
 j/fOE3a6b/+IdHHkQjUSFBo40KZwsyFhbz1BxazZVcuDABIW3hZjq3kLUZAuJCIJFcsi
 qY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CW2EPJtOmxl4BSZSTFMUahqoZD/6rAAwVofwfa2CqPY=;
 b=cMd6PYM4jlkTTvw7Uoj7PCj7xg79R5yE0vIt4vhV67R9O0KBthz4sAmzIvI7Y40qQY
 ip/wv//erMx9TFK9roCwT8CDSXiOzVhgMhCPhEMiulcncCV4SJomOqKiwVVPJ8OKD7q7
 eYdqg3SfN1CgKpnE8YQZ+j5DxC+vpGIY6oQCRI0u1aigY9GNH0COt3RoCPn/DIePk8sk
 kLU0kUW59HjHi7M1hYOCwPBqHPo0q8SI5O+IPCiFS1knNPnLmGYVv3y7dvdGixkQJTeC
 FIP0QTtr2z4Wdv2S2E/aTxnMpEAW60l2c74NUtEHvSBGJprOlkg2mHRnj+omGCbUgyhw
 aRQQ==
X-Gm-Message-State: APjAAAWk1BzeOit7ADIlP++1zUpmYfF1wZ4kR3TpA0JhglR7WSRwByJR
 VCqVfRTeHM2VaXyO/s7EQF7mfta3/zY=
X-Google-Smtp-Source: APXvYqzD/XHQ0w/WY8XON6ZVogOAj9QhVcPIzKDnKqtYgyawuVtpwL/w/sNjpmfKHnea3KoHZTdm2Q==
X-Received: by 2002:a63:5962:: with SMTP id j34mr37304pgm.421.1575413626664;
 Tue, 03 Dec 2019 14:53:46 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] target/arm: Set PAN bit as required on exception entry
Date: Tue,  3 Dec 2019 14:53:31 -0800
Message-Id: <20191203225333.17055-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PAN bit is preserved, or set as per SCTLR_ELx.SPAN,
plus several other conditions listed in the ARM ARM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a1dbafb9b2..043e44d73d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8634,8 +8634,12 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
                                    uint32_t mask, uint32_t offset,
                                    uint32_t newpc)
 {
+    int new_el;
+
     /* Change the CPU state so as to actually take the exception. */
     switch_mode(env, new_mode);
+    new_el = arm_current_el(env);
+
     /*
      * For exceptions taken to AArch32 we must clear the SS bit in both
      * PSTATE and in the old-state value we save to SPSR_<mode>, so zero it now.
@@ -8648,7 +8652,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
     /* Set new mode endianness */
     env->uncached_cpsr &= ~CPSR_E;
-    if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
+    if (env->cp15.sctlr_el[new_el] & SCTLR_EE) {
         env->uncached_cpsr |= CPSR_E;
     }
     /* J and IL must always be cleared for exception entry */
@@ -8659,6 +8663,14 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
         env->thumb = (env->cp15.sctlr_el[2] & SCTLR_TE) != 0;
         env->elr_el[2] = env->regs[15];
     } else {
+        /* CPSR.PAN is preserved unless target is EL1 and SCTLR.SPAN == 0. */
+        if (cpu_isar_feature(aa64_pan, env_archcpu(env))) {
+            env->uncached_cpsr |=
+                (new_el == 1 &&
+                 (env->cp15.sctlr_el[1] & SCTLR_SPAN) == 0
+                 ? CPSR_PAN
+                 : env->spsr & CPSR_PAN);
+        }
         /*
          * this is a lie, as there was no c1_sys on V4T/V5, but who cares
          * and we should just guard the thumb mode on V4
@@ -8921,6 +8933,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     unsigned int new_el = env->exception.target_el;
     target_ulong addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
+    unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
 
     /*
@@ -9006,20 +9019,43 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     }
 
     if (is_a64(env)) {
-        env->banked_spsr[aarch64_banked_spsr_index(new_el)] = pstate_read(env);
+        old_mode = pstate_read(env);
         aarch64_save_sp(env, arm_current_el(env));
         env->elr_el[new_el] = env->pc;
     } else {
-        env->banked_spsr[aarch64_banked_spsr_index(new_el)] = cpsr_read(env);
+        old_mode = cpsr_read(env);
         env->elr_el[new_el] = env->regs[15];
 
         aarch64_sync_32_to_64(env);
 
         env->condexec_bits = 0;
     }
+    env->banked_spsr[aarch64_banked_spsr_index(new_el)] = old_mode;
+
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
+    if (cpu_isar_feature(aa64_pan, cpu)) {
+        /* The value of PSTATE.PAN is normally preserved, except when ... */
+        new_mode |= old_mode & PSTATE_PAN;
+        switch (new_el) {
+        case 2:
+            /* ... the target is EL2 with HCR_EL2.{E2H,TGE} == '11' ...  */
+            if ((arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE))
+                != (HCR_E2H | HCR_TGE)) {
+                break;
+            }
+            /* fall through */
+        case 1:
+            /* ... the target is EL1 ... */
+            /* ... and SCTLR_ELx.SPAN == 0, then set to 1.  */
+            if ((env->cp15.sctlr_el[new_el] & SCTLR_SPAN) == 0) {
+                new_mode |= PSTATE_PAN;
+            }
+            break;
+        }
+    }
+
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
     aarch64_restore_sp(env, new_el);
-- 
2.17.1


