Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B17C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C90217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gs56dEN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C90217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9cW-0007ET-1A
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:47:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MW-0007U6-Tb
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MV-00068Y-I6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:12 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:37921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MV-00068B-Bw
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:11 -0400
Received: by mail-pl1-x634.google.com with SMTP id a59so3143650pla.5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=yE70JIuqrA6MJdI0/JWiVeD/16stq6LybzVtzKfjj1Q=;
	b=gs56dEN1jv8sDVDblSRkxhfhLlFzsPjwrd0lLyjjQEYlCjdkhRtK8yaOVHcLlynpZw
	HZQJ9BcGP9o/Gi7kx90hFVDlSdAau+dV+Vb9eqeYUU4mypZ9vBUH7jT6f9XDUMPmzlBE
	DaYOa0WsCxQlZJWCNYEqOMm7z/A9mLVdVSims9NVXrlgJ7tgcpiHBFnZ019e3QMBq7B3
	FC1P8B210AXqPodJcffVWSIGuBBKTnGKE0jHGCSFeeCY8Zz6HsIpVIxTfUbj60nMm9Cd
	5Z6Gm0yY0YGYZEoNOJAWe9+STAuO31t9EEFonH5sBf7tVWU/EN+OZocy6Sit++JAmm+3
	FX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=yE70JIuqrA6MJdI0/JWiVeD/16stq6LybzVtzKfjj1Q=;
	b=pzY/Pbk00f9atCcEy+ZaxpUCHG9gdVguzN/M3eubccG2dEP/oXWyHLJLTxS969eUxl
	cKNiKVVVH2S6CPH5ghx0Cw/ZOXmzO6hZE/d62aE+BPj9xmOb9imS6xTi1KW+eKr9ziJu
	X1xvuX7oBM21O1+23+gnfbD6g5/JWk2QPrIsXvSvC5+71aPJV6FX95AQknHxTxBSjPp8
	IQU/EcHR6bUyyXIF0h6mpQQ5LrUfziXzlC5K+Dd/aSrsnYCv8OxvFDDRjsRSvm1p2abR
	V/SOh3U6uQOS14TRNsx5CltE2WWim6v2uAhmVIXD2gg//rlqQjn+FZaghhfDYEZ6kg7l
	E5yA==
X-Gm-Message-State: APjAAAWxo56ZRg1awXto0s/HoAZT/lzISp1WVsNSX4ji/CPnn6XnEGtH
	4Ig9jUaC5nHkM/tvM9uzg4llPV3QCxs=
X-Google-Smtp-Source: APXvYqzIpacVV1pvqA5102eSOJCNZlYV7ITAtu89IJe7wjawi8/KiQ1AOSW/Dm3Q73L1oKx/6xSU6Q==
X-Received: by 2002:a17:902:aa45:: with SMTP id
	c5mr14515287plr.144.1557509470020; 
	Fri, 10 May 2019 10:31:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.08 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:39 -0700
Message-Id: <20190510173049.28171-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::634
Subject: [Qemu-devel] [PATCH v6 15/25] linux-user/aarch64: Use
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
index 96f20886ce..8c17b14d51 100644
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


