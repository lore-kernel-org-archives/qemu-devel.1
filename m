Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723E4C04AAB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353E72053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hck4bxZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353E72053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhlD-0007AX-GA
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:50:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVO-0001F2-0G
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVK-0001SS-Ho
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:20 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:46569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVI-0001Pg-LI
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id j11so7111844pff.13
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=XGj6206fsdJxol+0Im+/ya3c6hhRI8KMqoTGs4TcX0E=;
	b=Hck4bxZS5lN1BVH0JeCN8+AIj+HAHE6FayH8F6hePk6Qw1lfF8V7mKFyn58QNGu7gy
	EpIQBnLb6TLsUEatCYigkrtbK45Y0EIaCp1alybwgBBCr07U/cfCVq/PvvbARBJIO134
	uHgLRXsRaHWc6g977fBaP3z/8PnYxD/RZNGi/eynnEjHP66cff4GwSdivixRJyeXgYDC
	RABXB28gDF0yjCKhD5X6o4+4KyzI7YlfDXEzBLqIoylhYSAh0JaQFHPf5OHiJtLPAM6t
	GA3ruEeUqEiokd5aQ3A/wW+0wRl4bORI50RyjtM0H1o4la8uxjrN0fHRanwMh9OTC95r
	07rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=XGj6206fsdJxol+0Im+/ya3c6hhRI8KMqoTGs4TcX0E=;
	b=S1R2FzDbgYTRO+plzWO3fvOgdHOIkyCosMXz2JqgJWkcXOmvOVX4+8yk0BuGXrGA8z
	XQpab8gitZU1QfAX3zrHteidMR6c4714SBF5squLHFoHjwRz1vWtr0KksBcJ1qdFmGcX
	tu7Y+LGGNMF1mGWrOQpol6gsphRZxWK5QVfI82W2bArC65EolmLDvjD9h1ZEbuzTT4Rq
	hE3P8pEiFUtfgjgVVuNpyW8lKjBgpErowGpDtXwH+N1bDNCtq/gsFnACyI8bOCxl0AVB
	gM0zrF7h9uB2TXFyG0Qx0cR1HNRAfWv62UTkINsnZebdk9yHcvUNEMb+5KMzN0jVpsNQ
	nkrA==
X-Gm-Message-State: APjAAAXHI+nB3xvgnIgFA4FNfOpxa+TK/P2AY9oH9Pkl0RAdsrjDUmgH
	Hko6pT6WyMSFildxf5H5Rj4cEisz/aQ=
X-Google-Smtp-Source: APXvYqxrkbJWZTmKixPaFwodOjOz48WJuxQ2x7z/1n5yW/3TAWooJE5IRIIrbyWLrjWgMr/fvIZ5tA==
X-Received: by 2002:a63:1d02:: with SMTP id d2mr7013533pgd.26.1557164054000;
	Mon, 06 May 2019 10:34:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:44 -0700
Message-Id: <20190506173353.32206-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42f
Subject: [Qemu-devel] [PATCH v4 15/24] linux-user/aarch64: Use
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a better interface for random numbers than rand() * 3.

Cc: Laurent Vivier <laurent@vivier.eu>
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
index ce377b2fc1..b73d1d9f65 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -111,6 +111,7 @@
 
 #include "qemu.h"
 #include "qemu/guest-random.h"
+#include "qapi/error.h"
 #include "fd-trans.h"
 
 #ifndef CLONE_IO
@@ -9724,25 +9725,45 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


