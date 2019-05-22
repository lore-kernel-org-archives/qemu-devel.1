Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06A6C282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5C720879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUzmFOKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5C720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49893 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWgk-0007kv-JU
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:14:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOn-0008Ln-4x
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCU-0008CO-3H
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:55 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:33874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCS-0008BS-3V
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:54 -0400
Received: by mail-yw1-xc41.google.com with SMTP id n76so1254439ywd.1
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=91uu1aUA9Q1duAfeofMBsz4QGLzYWym0CyS3yfCCEtA=;
	b=WUzmFOKaaPmzf3hF3x0DaG9GKdGLaS1So5frVXQSerJUkUZeDx38/vI4FL0MtJ5707
	hOknTDKjRKrJwTLz0IZ5dqWnz+EskpRYtRHa5llCfQcXw1UGMBgATB3BLQeD9onpHhxM
	mQfKs5FdQSdwTB0+X3P5RmPTsMqxw3ZR0Pc7Rhe0z1j+4o9b2Lo5cLy2jNwPOhnWkp4j
	3ch4ux4GWmHZIf2LhGvzMuU8XhpXeJvJC8RPoaMx/EKH1CfryWztHf+aAl4tgjebneSk
	LdC4pIc9FU5RDxm0VatQg6dxoD9I1/6d6plp/bT8lOROsLOA0aAZaaDbK/wB6jwuCyET
	HBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=91uu1aUA9Q1duAfeofMBsz4QGLzYWym0CyS3yfCCEtA=;
	b=KoXBLX28wzq/sSCgTlBj2biLh6zB6MUHa83dop1fOL5UjCvk9KHbAgBGGhJfs9IHKW
	R8hEKS1bDm8bO9+X3KjDG9QN0ry3YisdWX0bFxUbhnsnO+9GhtqD1axtzhcXwg+pqrLl
	ZdOxxqjdqHogSxb7FyueuH1Jy3JlKbkPfDfPE8/Y6swq7kIwae0MHf+3urELM9j8dNSh
	aZjlHul2ExJeZ3d6cJRtbmF64XFgpOSMonkTLS+mAjZcZY+a4kN1gWpAV9gHoLCRCwrs
	t9EB2zcfvcYank/EPDvOYVbERei/8I/F9CpjXgCSYwXw8/3o/ySjAu2iWdf/LfcO+Mbs
	Iyng==
X-Gm-Message-State: APjAAAU9C9vGXP/4FZVFcjBq0W35ImqkZhmqTEBx2+Iv46n765kDKTny
	ZlmYh/5uGjA2w9N/d6vWUtFbZyDZUBw=
X-Google-Smtp-Source: APXvYqw8cXgGxW6iU3K/oTvgYCE8zG2/humI/SoVlIw1AgdHTlJhIsZs92YsUL8T3Z2l0H+JOuBSpg==
X-Received: by 2002:a81:2513:: with SMTP id l19mr35956533ywl.299.1558550570781;
	Wed, 22 May 2019 11:42:50 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:22 -0400
Message-Id: <20190522184226.17871-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [PULL 21/25] target/arm: Put all PAC keys into a
 structure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows us to use a single syscall to initialize them all.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h              | 12 +++++++-----
 linux-user/aarch64/cpu_loop.c |  6 +-----
 linux-user/syscall.c          | 10 +++++-----
 target/arm/helper.c           | 20 ++++++++++----------
 target/arm/pauth_helper.c     | 18 +++++++++---------
 5 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 733b840a71..892f9a4ad2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -636,11 +636,13 @@ typedef struct CPUARMState {
     } iwmmxt;
 
 #ifdef TARGET_AARCH64
-    ARMPACKey apia_key;
-    ARMPACKey apib_key;
-    ARMPACKey apda_key;
-    ARMPACKey apdb_key;
-    ARMPACKey apga_key;
+    struct {
+        ARMPACKey apia;
+        ARMPACKey apib;
+        ARMPACKey apda;
+        ARMPACKey apdb;
+        ARMPACKey apga;
+    } keys;
 #endif
 
 #if defined(CONFIG_USER_ONLY)
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index cedad39ca0..2f2f63e3e8 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -175,11 +175,7 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 #endif
 
     if (cpu_isar_feature(aa64_pauth, cpu)) {
-        qemu_guest_getrandom_nofail(&env->apia_key, sizeof(ARMPACKey));
-        qemu_guest_getrandom_nofail(&env->apib_key, sizeof(ARMPACKey));
-        qemu_guest_getrandom_nofail(&env->apda_key, sizeof(ARMPACKey));
-        qemu_guest_getrandom_nofail(&env->apdb_key, sizeof(ARMPACKey));
-        qemu_guest_getrandom_nofail(&env->apga_key, sizeof(ARMPACKey));
+        qemu_guest_getrandom_nofail(&env->keys, sizeof(env->keys));
     }
 
     ts->stack_base = info->start_stack;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 72e43b517a..3de792a04c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9775,23 +9775,23 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                         return -TARGET_EINVAL;
                     }
                     if (arg2 & TARGET_PR_PAC_APIAKEY) {
-                        ret |= qemu_guest_getrandom(&env->apia_key,
+                        ret |= qemu_guest_getrandom(&env->keys.apia,
                                                     sizeof(ARMPACKey), &err);
                     }
                     if (arg2 & TARGET_PR_PAC_APIBKEY) {
-                        ret |= qemu_guest_getrandom(&env->apib_key,
+                        ret |= qemu_guest_getrandom(&env->keys.apib,
                                                     sizeof(ARMPACKey), &err);
                     }
                     if (arg2 & TARGET_PR_PAC_APDAKEY) {
-                        ret |= qemu_guest_getrandom(&env->apda_key,
+                        ret |= qemu_guest_getrandom(&env->keys.apda,
                                                     sizeof(ARMPACKey), &err);
                     }
                     if (arg2 & TARGET_PR_PAC_APDBKEY) {
-                        ret |= qemu_guest_getrandom(&env->apdb_key,
+                        ret |= qemu_guest_getrandom(&env->keys.apdb,
                                                     sizeof(ARMPACKey), &err);
                     }
                     if (arg2 & TARGET_PR_PAC_APGAKEY) {
-                        ret |= qemu_guest_getrandom(&env->apga_key,
+                        ret |= qemu_guest_getrandom(&env->keys.apga,
                                                     sizeof(ARMPACKey), &err);
                     }
                     if (ret != 0) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e2d5c8e34f..6b91082b8b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5707,43 +5707,43 @@ static const ARMCPRegInfo pauth_reginfo[] = {
     { .name = "APDAKEYLO_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_pauth,
-      .fieldoffset = offsetof(CPUARMState, apda_key.lo) },
+      .fieldoffset = offsetof(CPUARMState, keys.apda.lo) },
     { .name = "APDAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_pauth,
-      .fieldoffset = offsetof(CPUARMState, apda_key.hi) },
+      .fieldoffset = offsetof(CPUARMState, keys.apda.hi) },
     { .name = "APDBKEYLO_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_pauth,
-      .fieldoffset = offsetof(CPUARMState, apdb_key.lo) },
+      .fieldoffset = offsetof(CPUARMState, keys.apdb.lo) },
     { .name = "APDBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 3,
       .access = PL1_RW, .accessfn = access_pauth,
-      .fieldoffset = offsetof(CPUARMState, apdb_key.hi) },
+      .fieldoffset = offsetof(CPUARMState, keys.apdb.hi) },
     { .name = "APGAKEYLO_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_pauth,
-      .fieldoffset = offsetof(CPUARMState, apga_key.lo) },
+      .fieldoffset = offsetof(CPUARMState, keys.apga.lo) },
     { .name = "APGAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_pauth,
-      .fieldoffset = offsetof(CPUARMState, apga_key.hi) },
+      .fieldoffset = offsetof(CPUARMState, keys.apga.hi) },
     { .name = "APIAKEYLO_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_pauth,
-      .fieldoffset = offsetof(CPUARMState, apia_key.lo) },
+      .fieldoffset = offsetof(CPUARMState, keys.apia.lo) },
     { .name = "APIAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_pauth,
-      .fieldoffset = offsetof(CPUARMState, apia_key.hi) },
+      .fieldoffset = offsetof(CPUARMState, keys.apia.hi) },
     { .name = "APIBKEYLO_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_pauth,
-      .fieldoffset = offsetof(CPUARMState, apib_key.lo) },
+      .fieldoffset = offsetof(CPUARMState, keys.apib.lo) },
     { .name = "APIBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 3,
       .access = PL1_RW, .accessfn = access_pauth,
-      .fieldoffset = offsetof(CPUARMState, apib_key.hi) },
+      .fieldoffset = offsetof(CPUARMState, keys.apib.hi) },
     REGINFO_SENTINEL
 };
 #endif
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index d750f96edf..7f30ae7395 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -403,7 +403,7 @@ uint64_t HELPER(pacia)(CPUARMState *env, uint64_t x, uint64_t y)
         return x;
     }
     pauth_check_trap(env, el, GETPC());
-    return pauth_addpac(env, x, y, &env->apia_key, false);
+    return pauth_addpac(env, x, y, &env->keys.apia, false);
 }
 
 uint64_t HELPER(pacib)(CPUARMState *env, uint64_t x, uint64_t y)
@@ -413,7 +413,7 @@ uint64_t HELPER(pacib)(CPUARMState *env, uint64_t x, uint64_t y)
         return x;
     }
     pauth_check_trap(env, el, GETPC());
-    return pauth_addpac(env, x, y, &env->apib_key, false);
+    return pauth_addpac(env, x, y, &env->keys.apib, false);
 }
 
 uint64_t HELPER(pacda)(CPUARMState *env, uint64_t x, uint64_t y)
@@ -423,7 +423,7 @@ uint64_t HELPER(pacda)(CPUARMState *env, uint64_t x, uint64_t y)
         return x;
     }
     pauth_check_trap(env, el, GETPC());
-    return pauth_addpac(env, x, y, &env->apda_key, true);
+    return pauth_addpac(env, x, y, &env->keys.apda, true);
 }
 
 uint64_t HELPER(pacdb)(CPUARMState *env, uint64_t x, uint64_t y)
@@ -433,7 +433,7 @@ uint64_t HELPER(pacdb)(CPUARMState *env, uint64_t x, uint64_t y)
         return x;
     }
     pauth_check_trap(env, el, GETPC());
-    return pauth_addpac(env, x, y, &env->apdb_key, true);
+    return pauth_addpac(env, x, y, &env->keys.apdb, true);
 }
 
 uint64_t HELPER(pacga)(CPUARMState *env, uint64_t x, uint64_t y)
@@ -441,7 +441,7 @@ uint64_t HELPER(pacga)(CPUARMState *env, uint64_t x, uint64_t y)
     uint64_t pac;
 
     pauth_check_trap(env, arm_current_el(env), GETPC());
-    pac = pauth_computepac(x, y, env->apga_key);
+    pac = pauth_computepac(x, y, env->keys.apga);
 
     return pac & 0xffffffff00000000ull;
 }
@@ -453,7 +453,7 @@ uint64_t HELPER(autia)(CPUARMState *env, uint64_t x, uint64_t y)
         return x;
     }
     pauth_check_trap(env, el, GETPC());
-    return pauth_auth(env, x, y, &env->apia_key, false, 0);
+    return pauth_auth(env, x, y, &env->keys.apia, false, 0);
 }
 
 uint64_t HELPER(autib)(CPUARMState *env, uint64_t x, uint64_t y)
@@ -463,7 +463,7 @@ uint64_t HELPER(autib)(CPUARMState *env, uint64_t x, uint64_t y)
         return x;
     }
     pauth_check_trap(env, el, GETPC());
-    return pauth_auth(env, x, y, &env->apib_key, false, 1);
+    return pauth_auth(env, x, y, &env->keys.apib, false, 1);
 }
 
 uint64_t HELPER(autda)(CPUARMState *env, uint64_t x, uint64_t y)
@@ -473,7 +473,7 @@ uint64_t HELPER(autda)(CPUARMState *env, uint64_t x, uint64_t y)
         return x;
     }
     pauth_check_trap(env, el, GETPC());
-    return pauth_auth(env, x, y, &env->apda_key, true, 0);
+    return pauth_auth(env, x, y, &env->keys.apda, true, 0);
 }
 
 uint64_t HELPER(autdb)(CPUARMState *env, uint64_t x, uint64_t y)
@@ -483,7 +483,7 @@ uint64_t HELPER(autdb)(CPUARMState *env, uint64_t x, uint64_t y)
         return x;
     }
     pauth_check_trap(env, el, GETPC());
-    return pauth_auth(env, x, y, &env->apdb_key, true, 1);
+    return pauth_auth(env, x, y, &env->keys.apdb, true, 1);
 }
 
 uint64_t HELPER(xpaci)(CPUARMState *env, uint64_t a)
-- 
2.17.1


