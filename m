Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAAAC04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D52B217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dbh3eAN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D52B217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35297 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOucT-0007St-E0
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:46:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHx-0006Sh-9s
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHv-0001On-R2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:29 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHv-0001O5-D3
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:27 -0400
Received: by mail-pl1-x641.google.com with SMTP id w7so2004738plz.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=4yQStDlYusk0tpOPhVM2XauFhXzbtZR092pnkvrSzO8=;
	b=Dbh3eAN4xeUQPYlvZCTaLZhRkDAJJNfY1pJGsYOE0b5Jj3OhqjaneGJi1qpgWOp6ZB
	8pnjQots5dxxOs7mpuE/L/sG5whzxgJjm1s0LKgVd9ccJJPzMIKD8YBTgrXqRdlqBX/U
	NR1siiB1z4FGhl3yd+GJ088bgEBI4wdhz5LjYSzLPyZ0mISAJp9XLY0P9BcwDSttCHh5
	AjTgW9AjZengYf9iRgzChjClL5cBSXaBVF8u31UAmINExzKPK40DhHqYRDy4fV7kEwGb
	yR6EwZ1crYnzc64HX1hMvPmChXqxF7w8A0qcpCQ3o3beSgFoV/YGno6TOrTCxBOMBamO
	XIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4yQStDlYusk0tpOPhVM2XauFhXzbtZR092pnkvrSzO8=;
	b=c8SryC8IZYqEh4fQ5mBRSFFKl+iNmDz+ba0R3bdW6hFzjxlYBHD9H9Fz22EkSYVCg4
	dWalWDhJfAPF4C3mk7NqWxNs6JMgIo1ig5Lkz0OCD/+/J0iTZl9hOYM0DD23m77rg+Eq
	h5laJnVB8p/rDm0Tet5dOzX8Di05F8hbBoEelf5nYgY1kOUFiVn7+vMgfoPubi9lWZAp
	Syrsdk6Emwso2gIMiGz/2/S9e67vethj3qyba7TcQqGHp7497kUl1kzOygZ0dM3+QJ69
	cqrwn8fcUF2GhvtLXFE1TzgXGOx2/DC4EMyi1aubhk+YJeWqPzyIp/qEr2Bknv0oMNDu
	FMpA==
X-Gm-Message-State: APjAAAXZvwdnJYqA7eRWDlGd6Xk/7U+x0r91ln+uVIX0J+bUcyR4N6gr
	84ft70L0k9o/OZ3jrETBDWXTgbT6M9M=
X-Google-Smtp-Source: APXvYqzJ8yurO/uxSAJo7KronRWg0uhuILRftfi+0THYHKWiPUqQAfubqyVKNdr2d30gil8Kmq4XRw==
X-Received: by 2002:a17:902:f20b:: with SMTP id
	gn11mr9423582plb.126.1557451526171; 
	Thu, 09 May 2019 18:25:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.25 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:55 -0700
Message-Id: <20190510012458.22706-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v5 21/24] target/arm: Put all PAC keys into a
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
index 1e6eb0d0f3..7e88b2cadd 100644
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


