Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877F5C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49ED4208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nl6xhjdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49ED4208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59951 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYlx-0007jm-Gz
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:51:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk4-0006EN-PQ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk2-0008UE-W3
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYk2-0008Sp-Pc
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id d18so19473046wrs.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=qqKC0aSbOxnvRt4Ak9385i5tuKqObKaJREy1yTVl17E=;
	b=Nl6xhjdLBBjo4hXQwpFtEexyaLdc65OHvYSdnKssLUGAYLOeJj1FapYcBQcViqvFw1
	W2xCQTjL9T3faRzIwKHYXlU3kRhy8fwx/JUjr1uMuL71o+R9/iickq6npGpbz2iEW2GR
	tU3ipx6/MPw6f7Z0A9yjs3UBCiRW+Cxk28oRYhRP4LPY7rD5xDgU6TPrr5GqbWJPM8kv
	GY9ELYN8B+GCNIwHg7W8L/saE6nUY8UGWTjI9I2ZN8japezxXJrOatQ+tGEbv1rWRuDc
	KfZHjm9d6eksvENNaqrnRA9SMrxMQp5INwl1gDwTsnvoaUSWo7NlU61/TFrw1E5eUn8j
	iqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=qqKC0aSbOxnvRt4Ak9385i5tuKqObKaJREy1yTVl17E=;
	b=UkZkYD7w6V6mpRdNHs8jzWCjlNyx6NvnskBbhbw7kXX72Z9DqjHTgBxiGkYs02+bOL
	xEvpRSDgcbH+4m5H3+jbnnGl7Nm8cCMDB8KhmC2OGgbzSAJLfNPUozIZa030CumCe5Of
	eEUTA1qeRTrHd7v43sFRpjfbcux3AzaLfDZ3MwSYjtaLZFyEm5xaPL4kMz686KDHUrse
	TqWD3TyWeBXj/YproDa5FS8IgDVOfyzm0qYMLJayFN282ocyhGxfwFq/75thQEmK9tqd
	jYNJej7ZhpU9DdlLHw5iCg8JzzOewRlY8m6n+Rb0qMhESoAYbyz24YgJuUYiXt+eWQa4
	X+aQ==
X-Gm-Message-State: APjAAAUaZ90T2eLCliP0ytUixFuDVMsGkkwgCg9i8uIuwdq7eOWrb1jn
	wcvn74YGDdBgvlUe0T5D812VEA==
X-Google-Smtp-Source: APXvYqwqxTORYGZyZTwDRlAGrjvs9kW14y0tYJAzwch9+Pr8A06KkD5q4sCtgl3xSo4ClDG7hpmGQA==
X-Received: by 2002:a5d:4581:: with SMTP id p1mr5980478wrq.228.1559036997603; 
	Tue, 28 May 2019 02:49:57 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s13sm1917474wmh.31.2019.05.28.02.49.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id DDB9C1FF92;
	Tue, 28 May 2019 10:49:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:30 +0100
Message-Id: <20190528094953.14898-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 05/28] target/arm: fixup some of the commentary
 for arm-semi
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	"open list:ARM" <qemu-arm@nongnu.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This cleans up a number of the block comments to fit the proper style.
While we are at it we also reference the official specification and
document what the return register value can be.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index a99049c7d58..d812eef1519 100644
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
@@ -239,6 +244,15 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
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
@@ -509,14 +523,16 @@ target_ulong do_arm_semihosting(CPUARMState *env)
 
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
 
@@ -570,8 +586,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
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
 
@@ -619,7 +637,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         }
     case TARGET_SYS_EXIT:
         if (is_a64(env)) {
-            /* The A64 version of this call takes a parameter block,
+            /*
+             * The A64 version of this call takes a parameter block,
              * so the application-exit type can return a subcode which
              * is the exit status code from the application.
              */
@@ -632,14 +651,17 @@ target_ulong do_arm_semihosting(CPUARMState *env)
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


