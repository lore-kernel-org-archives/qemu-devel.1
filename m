Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB239C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9047420815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7uCeBfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9047420815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSxR-0005w2-MV
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:50:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmj-0005ah-J3
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmh-00029l-JX
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:49 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmh-000298-DL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:47 -0400
Received: by mail-pg1-x542.google.com with SMTP id h17so2535328pgv.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=yE70JIuqrA6MJdI0/JWiVeD/16stq6LybzVtzKfjj1Q=;
	b=P7uCeBfW4JYTuGB0oJwFoFu31evMKAOTe6sILXvBjGVc+6cSpc+qFcn8rnBrZoPJ6l
	mD+VK+hYqFHuinL++2OnmPmfXWGMcnO8U2i6jnGDl4Kb6Lo+4KktlrDuVMfLi903+apd
	3CpoCqeeXZ/lWgxCvqEAa52HTamETTEGdUQqmFuSIFBnfcYKkAixfcma2+ST85IfAE6w
	+QCMPa47LImR4iahgMnk6urrQBSMUyv1SDHYDUlxHytfxE5CqB3UMX4ij+PBmQsQC+Mq
	I6RIRggnQAxaw3avp6Y9WPxFMqAShKO7qpyw9GHoKCac+aWOSxJF/8G90u0blWWp+je/
	/8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=yE70JIuqrA6MJdI0/JWiVeD/16stq6LybzVtzKfjj1Q=;
	b=FOdtucYt3NJ+4amANZUHQA881EyBKH+mC9OZ0odqNl9WlH7ml8kkGpboKMmACLqB2E
	69xdEBkhBVmm+cOpDa/0EJ9C6BWAtfSuIpmZoNioQRbJ1EKSWthEIlkKZp5K3J3TPnP5
	eQxZ9f1PHLi43UY6w9gQDv+baOBFuQJ3liCBfksIa4eqxio+wm0BO5H2c2ihIH4Kj2cb
	x7hkl4jTp5AW38qV5Q94AG6Y2hi9eUJ5AYphrWKeGwiPzwrPgRJzZMLkWhFtS0f0jsBu
	mByBtaaRDZkZaZV1RvLOMmq9joGtPbkMgyqcSv1JzCG6Nfn5ZaH2JDYjEQrVnA7FuqFu
	cVaQ==
X-Gm-Message-State: APjAAAVdjm72tmT42vjXxYa8kJuicFuAAM9/bEg/tqCM007QmrLO/g+x
	Db9KIOGTXJ7ac0yyrPnL0qROSUbqdXU=
X-Google-Smtp-Source: APXvYqzNe0slqK3gw0CBOZpVfA/NQCoWIJLam6er3rY9Wd97QAgOT/9MvcTF84ce4CCHy5jl6p9B9A==
X-Received: by 2002:a63:2d87:: with SMTP id
	t129mr54073702pgt.451.1558060785557; 
	Thu, 16 May 2019 19:39:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:14 -0700
Message-Id: <20190517023924.1686-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v8 15/25] linux-user/aarch64: Use
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
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


