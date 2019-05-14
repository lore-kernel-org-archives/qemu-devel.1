Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D49C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728A22085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8XjDVZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728A22085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZnR-0007sz-KC
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:56:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjp-0004l8-Am
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjo-0006DS-0S
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQZjn-0006C8-PX
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id o189so3432113wmb.1
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8P0Lit3+ogalzWIYoV9bDuQCb6yqzuLD2GL2ck9k72U=;
	b=m8XjDVZfHoOqs814AqYdCoaJljUHvUN91Ybm1Nij/tU9WxajK7mp8Ae6guBr6m6WRt
	zDiGm0Zaeu4suWI8/IE5WsPbTYfyfH58WZMuMhurxZKGV8zY6Gl7cu+4r2P7Bddkd52l
	qeoQDqk+22weMucKa66/pPwK4LLgBoQ6KSSKoAWF0khlILdnEugDDyC24CH93FucPK1s
	qn84AoZA/N3TNGGqByzcFZe7LzME2gYNHai3cm2yckxlVvBpjjspln5LU8pVAxoT5rwr
	fgFRTqPv77KiUo72SKf9TxVli8rh+a3YvDEfT+EE40Jh/i1iEDS3OVcQLE5+30dRXhr/
	Wdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8P0Lit3+ogalzWIYoV9bDuQCb6yqzuLD2GL2ck9k72U=;
	b=ffbMGjW+msTiyKSp+h77AQK3TUIPPP8reuxqpqU9sP9yNjGACgRPcEUfr7zH6JG2K1
	xlA8kPWcFgpdLYxPQmVsTjOtSe0jiYC3vEhBvpwN5tGKwdn4F5QETGD1NNC7FI4lf5f5
	aZt3sJT66NBrUYFDt+9ckuR7iHJnZJntodeLGCzYj1ht3YNORJQrKaebIfkUHS+E8Foc
	fzJJNcfmntVRuZsT/Wio9M0FdfRQFty0POZ+49ylSPcp7mNnjSinaS/LP5psi5LkLrHV
	G/TgJYCEEjloLwJQRpjdWSR59ucvCu3QK57hZD2s9lNTyyP5nUYNIiLuLl6itasK51Dl
	3ACw==
X-Gm-Message-State: APjAAAVjni1nXZOzQAg3yS+RPat2it10pTDaKi75S0gPq+n+nYH/65x6
	opf+gIwd6ECwP109hIlLQliB8Q==
X-Google-Smtp-Source: APXvYqyzUdkINOCv8xk4PIsQUGZlqhkDQ1O2ZHGv7fJVDskDf14yZ5cWtJzMsWxUcVcLRgNlb7whig==
X-Received: by 2002:a05:600c:551:: with SMTP id
	k17mr5368389wmc.119.1557849186612; 
	Tue, 14 May 2019 08:53:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	g6sm14700712wro.29.2019.05.14.08.53.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 08:53:05 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7834B1FF92;
	Tue, 14 May 2019 16:53:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 16:52:55 +0100
Message-Id: <20190514155301.16123-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514155301.16123-1-alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [RFC PATCH 05/11] target/arm: fixup some of the
 commentary for arm-semi
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This cleans up a number of the block comments to fit the proper style.
While we are at it we also reference the official specification and
document what the return register value can be.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/arm-semi.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 3273306c8ea..9e5a414dd89 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -2,6 +2,7 @@
  *  Arm "Angel" semihosting syscalls
  *
  *  Copyright (c) 2005, 2007 CodeSourcery.
+ *  Copyright (c) 2019 Linaro
  *  Written by Paul Brook.
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -16,6 +17,10 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ *  ARM Semihosting is documented in:
+ *     Semihosting for AArch32 and AArch64 Release 2.0
+ *     https://static.docs.arm.com/100863/0200/semihosting.pdf
  */
 
 #include "qemu/osdep.h"
@@ -240,6 +245,15 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
      put_user_u64(val, args + (n) * 8) :                \
      put_user_u32(val, args + (n) * 4))
 
+/*
+ * Do a semihosting call.
+ *
+ * The specification always says that the "return register" either
+ * returns a specific value or is corrupted, so we don't need to
+ * report to our caller whether we are returning a value or trying to
+ * leave the register unchanged. We use 0xdeadbeef as the return value
+ * when there isn't a defined return value for the call.
+ */
 target_ulong do_arm_semihosting(CPUARMState *env)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -510,14 +524,16 @@ target_ulong do_arm_semihosting(CPUARMState *env)
 
             output_size = ts->info->arg_end - ts->info->arg_start;
             if (!output_size) {
-                /* We special-case the "empty command line" case (argc==0).
-                   Just provide the terminating 0. */
+                /*
+                 * We special-case the "empty command line" case (argc==0).
+                 * Just provide the terminating 0.
+                 */
                 output_size = 1;
             }
 #endif
 
             if (output_size > input_size) {
-                 /* Not enough space to store command-line arguments.  */
+                /* Not enough space to store command-line arguments.  */
                 return -1;
             }
 
@@ -571,8 +587,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             GET_ARG(0);
 
 #ifdef CONFIG_USER_ONLY
-            /* Some C libraries assume the heap immediately follows .bss, so
-               allocate it using sbrk.  */
+            /*
+             * Some C libraries assume the heap immediately follows .bss, so
+             * allocate it using sbrk.
+             */
             if (!ts->heap_limit) {
                 abi_ulong ret;
 
@@ -620,7 +638,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         }
     case TARGET_SYS_EXIT:
         if (is_a64(env)) {
-            /* The A64 version of this call takes a parameter block,
+            /*
+             * The A64 version of this call takes a parameter block,
              * so the application-exit type can return a subcode which
              * is the exit status code from the application.
              */
@@ -633,14 +652,17 @@ target_ulong do_arm_semihosting(CPUARMState *env)
                 ret = 1;
             }
         } else {
-            /* ARM specifies only Stopped_ApplicationExit as normal
-             * exit, everything else is considered an error */
+            /*
+             * ARM specifies only Stopped_ApplicationExit as normal
+             * exit, everything else is considered an error
+             */
             ret = (args == ADP_Stopped_ApplicationExit) ? 0 : 1;
         }
         gdb_exit(env, ret);
         exit(ret);
     case TARGET_SYS_SYNCCACHE:
-        /* Clean the D-cache and invalidate the I-cache for the specified
+        /*
+         * Clean the D-cache and invalidate the I-cache for the specified
          * virtual address range. This is a nop for us since we don't
          * implement caches. This is only present on A64.
          */
-- 
2.20.1


