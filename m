Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D529C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B742217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhB1QSmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B742217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47631 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9Ww-0001Gt-G8
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:41:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9Me-0007ZV-63
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9Mc-0006D9-Kb
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:20 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9Mc-0006Cc-D4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:18 -0400
Received: by mail-pl1-x643.google.com with SMTP id b3so3138163plr.7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=O5zIN7a5YhWG7ErE5cL09/UzOmkeLwtbGoogr/y9loY=;
	b=UhB1QSmX9u4LhoRYrHBvYlO4LWx+feNVn6ZlJy8BHnScAKug+1/ZICVqENkz/UzMrX
	rPau/gtTK/umino9lT5aWCpUkpSb3lU01tvUVMjgI3xzSqH0prLSzn116qvsreG/e7A1
	9rFSLpr4kNnjoAhgByRn0zmsXqzsQbpXQeF+UIQCIRmK8AJtzLMSl/93pl+J1OpK89F/
	zmQN/B2gP/1/JmRwTsT1BqyMFeb0Z+4w9ryKcxl0KR4npKuLIMGHfkIINHpyGlOhR7xf
	68Z0KEEgufVy+q7yzYABbSqDT3MNZHXS1v14gZoOdAHzvdKz/BvVs3z7kd0PhVS12QW1
	JOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=O5zIN7a5YhWG7ErE5cL09/UzOmkeLwtbGoogr/y9loY=;
	b=ae6Iv3KZqwEy8a4yWyzvFcV84TGXsuE/Xebwni7GLRg8BOWG93yvrFC4kPoP45NqKq
	iOJrXO8UDSTiPQvnx9DuWdoStQtk7KD1EmAHTHAn4c6M8Vm/XV+ZWGv5y7CMMA4ArK79
	+XhOWFsM+lfbIWhHPMenSwpfGUAAJOKVqFmxALBOiVlW39DW1uf3U/Y6A/rDUU38MY1t
	Bm8cKU80Fzdc1NtKWWoOtZBvHIsll49S6Axe/97mZ1Nmiaswdu0EvovAcdeCMqwzWaBw
	oHdvZniq5ZVGj8jTmzxg6Mex16brA26AJBunB5bJDRVL3AZ3cN1mcn2YCf5D8stQrGMn
	iThQ==
X-Gm-Message-State: APjAAAUk9US29UlYRhJSFi/xXXvqS2REdntlzNAL8TJYO8sIOjF2Gzm/
	tavJpnO5/V81YHD+P1zgj/DORO+HCjk=
X-Google-Smtp-Source: APXvYqzaKXCLsuI9AiE7J0TxFoMdR0UXV4CAYnxSjQo9Gn+WC1Ko55f54MzbZrr2d9/RJndNkeQtYw==
X-Received: by 2002:a17:902:b695:: with SMTP id
	c21mr15042675pls.160.1557509477148; 
	Fri, 10 May 2019 10:31:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.16 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:45 -0700
Message-Id: <20190510173049.28171-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v6 21/25] target/arm: Put all PAC keys into a
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
index 8c17b14d51..394b956b4a 100644
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


