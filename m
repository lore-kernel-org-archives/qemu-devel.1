Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50D3C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973C92082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJoMSrBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973C92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhfT-0002JB-QK
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:44:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVU-0001O8-6C
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVS-0001bj-7p
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVQ-0001WQ-9S
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:25 -0400
Received: by mail-pg1-x541.google.com with SMTP id c13so6806405pgt.1
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=G/LPrgJph2n0xWoB68vwNP1sqZ2D7Ndofy8Ou9toiJU=;
	b=YJoMSrBOLQi8prawBoxDvEKjN3YKYVPmoPjPR89Li6b2Y76kuJeYFSrp74rYSEYtcP
	gEe9bdA85TOOEn8okOJ3YOwG7OXTOOwAFrPg+p6EwwmHkCJTvXYTVwPCuiDMLH+ghsjx
	bfZ/r2N8gb6hOntpg7l/20DFJXFlcoz4lseKrkvtDlaLdPalgbjK1sFONV8Pdm9yFHfY
	tALj3qydYFOODDsPHdw7gY2qbs1UeSBsG7un5SP98Mj1kIBAxkT2kU0nJQHYfqXoJ1dS
	KJIRbDmab6zw0fgyPVZkvlHqtXXbr1VhuEnJKRFz0hi1QByQRj/jJrMvBBlLniQmh6sw
	bx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=G/LPrgJph2n0xWoB68vwNP1sqZ2D7Ndofy8Ou9toiJU=;
	b=i1bGrEJIZt+gGyfDqMYGR4l9duPdpS3uw4jV3F+2oGqXPe0kUzjr13of7jJ3XrdnU0
	p3Ti+RydoaFx7tB9BtItIy5iruK7pTVHY7Td4I64aVjEqM8etonx+n8f3KeUJkd2m022
	GzM/cTrBDfb02zoQuxB3AChO7xsx6Tf7vu8Mgp0TvzdUHrA3wpnWBgHA5gtWlY6to/IG
	6UDc2Xb0I09EST2SgrOtUf8L+GBoLjYA3FG9bXeb/9rkNtKZI5YKBbFyxAaPLPf0kqwV
	N74VdOUiKaviwZM4MOaU6KIX5bu6+88qNkKQ4MAyXKkUTvCG+9e1zBisk1HeHDEsbl5X
	JhyA==
X-Gm-Message-State: APjAAAWLRYjGeAU4ZPPtw+bQ8yEn8pBn1ixiJ6pqoziIIzF8G4yBbSkq
	WCW8TP/DEdV6F0M+x4JVkS8iHuPoukE=
X-Google-Smtp-Source: APXvYqxP0Yj19KXWu8jH6mnsC1PzhLSN8wrz+at6ysiKcORFdwAC/DEBJ0E3ft5c4ep0uxAYAaHRhQ==
X-Received: by 2002:a63:c104:: with SMTP id w4mr33151579pgf.409.1557164060772; 
	Mon, 06 May 2019 10:34:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:50 -0700
Message-Id: <20190506173353.32206-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v4 21/24] target/arm: Put all PAC keys into a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows us to use a single syscall to initialize them all.

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
index 22bc6e00ab..9448a76186 100644
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
index b73d1d9f65..3c26f6f9d4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9734,23 +9734,23 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
index 81a92ab491..658a5a9822 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5683,43 +5683,43 @@ static const ARMCPRegInfo pauth_reginfo[] = {
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


