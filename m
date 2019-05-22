Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE6DC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B44C20879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAmWZDxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B44C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWjh-0001sd-LD
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:17:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOo-00086f-DR
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCN-00089H-SX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:49 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:46556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCN-00087Q-26
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:47 -0400
Received: by mail-yw1-xc43.google.com with SMTP id a130so1226205ywe.13
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=e2SNlmxHFtsdM0b0itsXkBL9sAk67p5UPbLq4CDfjKQ=;
	b=nAmWZDxBw1LBKfn1t5DLJXcQyC1eJezA6t27t6jn6XshhMWmiUp9BUU/7eG8JDku6h
	AUk4ejyCNobPPEgPhuNIALlf8Arf9CS+DLsTB+JlCZEqeFbZu7V2zj6OzvEujqeFsbHU
	5nr5lxRPYIdSSCHEs8wsNEwUn7V2bq/vrTf2SjmDxGubRnsTbBrovjCtBOjcDjtlK0ZP
	HZ/ve94BmBU3Vo+oyOv9bo+IO5gBNh8YsrnZUXyir6qWc58snKQCNseAH+AFBZP64vRI
	wLb9pdGUaisrCP2y8w9z9772GtZHZaUbou2L9Ywc18np6jHXdKg0ebOmTa6SLz6WPz2w
	Ps3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=e2SNlmxHFtsdM0b0itsXkBL9sAk67p5UPbLq4CDfjKQ=;
	b=pmZ7AXyvcm55p9Msyf4SxrsO/TmO812eahAjaC9KON0tXt3iMRygu2Hu7SeWsfXfem
	ZBulJ0nLaaeooKcZs3RZ6nFdVu/XfdWz9xk+QzvdQQeeE/cTfmJ+tGhET20OY1VsuTGo
	EiiGX9f5iCa12/2vaqj3vb7Y1p/+S4gAdqVLs6fRPrXhR8FmDugWkbBUnNsr/ITIMCrZ
	Q/Iqb75evHR7UmhDlvANto8mzYVyGIF+QEc7/ifOtTH9elXChWbh8kyziim6Aaudqp8n
	qQ0OVcMGxuPy86OighrIg7Cl0KFF49rxPxDzztJ4CO7QLWBYJ41SEClfmIM2PPVWyihu
	6J4Q==
X-Gm-Message-State: APjAAAWtWvcNCT8vjj4nGAgplCq5qxh6ObX561lrBbxUwuY2apY2maLb
	oAA4fEccUToaTRxRq1tOP2yw6pxvh1Y=
X-Google-Smtp-Source: APXvYqwjY/ezg2aPRpLYHVFN/38Baxz68lemdBCbv+LuWrDxWP+IL8C+hihHeGWheWNBqpDVh6I1Rg==
X-Received: by 2002:a81:6a03:: with SMTP id f3mr28238704ywc.169.1558550564394; 
	Wed, 22 May 2019 11:42:44 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:16 -0400
Message-Id: <20190522184226.17871-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [PULL 15/25] linux-user/aarch64: Use
 qemu_guest_getrandom for PAUTH keys
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

Use a better interface for random numbers than rand() * 3.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_syscall.h |  2 --
 linux-user/aarch64/cpu_loop.c       | 29 ++++++---------------------
 linux-user/syscall.c                | 31 ++++++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index b595e5da82..995e475c73 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -29,6 +29,4 @@ struct target_pt_regs {
 # define TARGET_PR_PAC_APDBKEY   (1 << 3)
 # define TARGET_PR_PAC_APGAKEY   (1 << 4)
 
-void arm_init_pauth_key(ARMPACKey *key);
-
 #endif /* AARCH64_TARGET_SYSCALL_H */
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index d75fd9d3e2..cedad39ca0 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
+#include "qemu/guest-random.h"
 
 #define get_user_code_u32(x, gaddr, env)                \
     ({ abi_long __r = get_user_u32((x), (gaddr));       \
@@ -147,24 +148,6 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-static uint64_t arm_rand64(void)
-{
-    int shift = 64 - clz64(RAND_MAX);
-    int i, n = 64 / shift + (64 % shift != 0);
-    uint64_t ret = 0;
-
-    for (i = 0; i < n; i++) {
-        ret = (ret << shift) | rand();
-    }
-    return ret;
-}
-
-void arm_init_pauth_key(ARMPACKey *key)
-{
-    key->lo = arm_rand64();
-    key->hi = arm_rand64();
-}
-
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -192,11 +175,11 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 #endif
 
     if (cpu_isar_feature(aa64_pauth, cpu)) {
-        arm_init_pauth_key(&env->apia_key);
-        arm_init_pauth_key(&env->apib_key);
-        arm_init_pauth_key(&env->apda_key);
-        arm_init_pauth_key(&env->apdb_key);
-        arm_init_pauth_key(&env->apga_key);
+        qemu_guest_getrandom_nofail(&env->apia_key, sizeof(ARMPACKey));
+        qemu_guest_getrandom_nofail(&env->apib_key, sizeof(ARMPACKey));
+        qemu_guest_getrandom_nofail(&env->apda_key, sizeof(ARMPACKey));
+        qemu_guest_getrandom_nofail(&env->apdb_key, sizeof(ARMPACKey));
+        qemu_guest_getrandom_nofail(&env->apga_key, sizeof(ARMPACKey));
     }
 
     ts->stack_base = info->start_stack;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f3ea9cac21..72e43b517a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -108,6 +108,7 @@
 
 #include "qemu.h"
 #include "qemu/guest-random.h"
+#include "qapi/error.h"
 #include "fd-trans.h"
 
 #ifndef CLONE_IO
@@ -9765,25 +9766,45 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     int all = (TARGET_PR_PAC_APIAKEY | TARGET_PR_PAC_APIBKEY |
                                TARGET_PR_PAC_APDAKEY | TARGET_PR_PAC_APDBKEY |
                                TARGET_PR_PAC_APGAKEY);
+                    int ret = 0;
+                    Error *err = NULL;
+
                     if (arg2 == 0) {
                         arg2 = all;
                     } else if (arg2 & ~all) {
                         return -TARGET_EINVAL;
                     }
                     if (arg2 & TARGET_PR_PAC_APIAKEY) {
-                        arm_init_pauth_key(&env->apia_key);
+                        ret |= qemu_guest_getrandom(&env->apia_key,
+                                                    sizeof(ARMPACKey), &err);
                     }
                     if (arg2 & TARGET_PR_PAC_APIBKEY) {
-                        arm_init_pauth_key(&env->apib_key);
+                        ret |= qemu_guest_getrandom(&env->apib_key,
+                                                    sizeof(ARMPACKey), &err);
                     }
                     if (arg2 & TARGET_PR_PAC_APDAKEY) {
-                        arm_init_pauth_key(&env->apda_key);
+                        ret |= qemu_guest_getrandom(&env->apda_key,
+                                                    sizeof(ARMPACKey), &err);
                     }
                     if (arg2 & TARGET_PR_PAC_APDBKEY) {
-                        arm_init_pauth_key(&env->apdb_key);
+                        ret |= qemu_guest_getrandom(&env->apdb_key,
+                                                    sizeof(ARMPACKey), &err);
                     }
                     if (arg2 & TARGET_PR_PAC_APGAKEY) {
-                        arm_init_pauth_key(&env->apga_key);
+                        ret |= qemu_guest_getrandom(&env->apga_key,
+                                                    sizeof(ARMPACKey), &err);
+                    }
+                    if (ret != 0) {
+                        /*
+                         * Some unknown failure in the crypto.  The best
+                         * we can do is log it and fail the syscall.
+                         * The real syscall cannot fail this way.
+                         */
+                        qemu_log_mask(LOG_UNIMP,
+                                      "PR_PAC_RESET_KEYS: Crypto failure: %s",
+                                      error_get_pretty(err));
+                        error_free(err);
+                        return -TARGET_EIO;
                     }
                     return 0;
                 }
-- 
2.17.1


