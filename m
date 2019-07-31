Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913AC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03104206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qxKnLaeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03104206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrQJ-0005Qw-A9
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42438)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG8-0005z5-Bz
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG6-0004Ah-MS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG6-00049j-FV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id g17so70335005wrr.5
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w8IWQyMyO7sgKHvlJ76dzk+gbyQ37XPlBpRgrQD8Bqw=;
 b=qxKnLaeNmmmzxrwId9vmijktIDvFEnv1WhUhxd8kE+x6mKYsqEm++eb6cMpKTy3wNl
 Ka6YHugSJaHQrq9juihNRF5Z6Qhsky3B2nTqau8pWVczgRGJDRx+ba2AFu/o3YiX0VRR
 7ouEF8Us034A0dkx2BrVL4joP9iNzAuTuCrAhqNo3gFqoWMEwfaIU9RX4CX5bVLvxTVT
 iyF1WkZmbJIV9JIuiWDEhpUL5cbIn4+WL/BRYkUNOPs2fe90FfEJQfRQdscOLuSHMxT9
 PEr7MZDjLisJKuLMDihIfrIezoXBPy1+KcW2MEaAiOOF1jOY8Dh71C8HEgoUfbEt6fEI
 HyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w8IWQyMyO7sgKHvlJ76dzk+gbyQ37XPlBpRgrQD8Bqw=;
 b=pk0Jf0yb4nh8lD0yXR0l97Er5Q60Noahnu2bGKYim72RkaDTgst2mfWtIgdTq3vH8I
 PMNPI61BPOB85pklbQC17crblB/vZKyl26w2GDNtMlN2tzRVSVLhUyHanxNIpv0Qt0GF
 Rj+JfNB5Dz4K6OFmS7B662umTK7kwz8i9EVoCO2zpVpeIp9U0yd29eF0edDN7gBa0ZvA
 mv4iURNC9ljx/w0aBCPyXey88iNwHgZ76lqFa5juKv7Tjc2X9c0FA0h3bzi1JwtPVbXT
 5YSbiGG7iM9jsDW48COHQ8GoV5lnsMBbMDI+GJPd/MsVgsOJU4fGbcOIj4kYSZqpz6GA
 6Vug==
X-Gm-Message-State: APjAAAXwXtxB3LIJ9Z6689uOKitA/4ClDGuPPkw/p8mjDHoTA3Vkxgvi
 YLlpdjQeiQyCUiBAfohWHpQZj8oGzO8=
X-Google-Smtp-Source: APXvYqzzl0ejljgPUBz1xLqkU38DNGBW/C8M7s+R4/087dZAFYV4IWR3jdHbM3cf2Z277PBBwq+OWg==
X-Received: by 2002:a5d:4111:: with SMTP id l17mr12277924wrp.59.1564589721290; 
 Wed, 31 Jul 2019 09:15:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j16sm13522465wrp.62.2019.07.31.09.15.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 13F5B1FFAF;
 Wed, 31 Jul 2019 17:07:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:52 +0100
Message-Id: <20190731160719.11396-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH  v4 27/54] *-user: plugin syscalls
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

To avoid too much duplication add a wrapper that the existing trace
and the new plugin calls can live in. We could move the -strace code
here as well but that is left for a future series as the code is
subtly different between the bsd and linux.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[AJB: wrap in syscall-trace.h, expand commit msg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 bsd-user/syscall.c           | 21 +++++++++++++------
 include/user/syscall-trace.h | 40 ++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c         |  7 ++++---
 3 files changed, 59 insertions(+), 9 deletions(-)
 create mode 100644 include/user/syscall-trace.h

diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 84a983a9a12..0d45b654bb3 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -26,6 +26,7 @@
 
 #include "qemu.h"
 #include "qemu-common.h"
+#include "user/syscall-trace.h"
 
 //#define DEBUG
 
@@ -322,7 +323,8 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef DEBUG
     gemu_log("freebsd syscall %d\n", num);
 #endif
-    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
+    record_syscall_start(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
+
     if(do_strace)
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
 
@@ -403,7 +405,8 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
     if (do_strace)
         print_freebsd_syscall_ret(num, ret);
-    trace_guest_user_syscall_ret(cpu, num, ret);
+
+    record_syscall_return(cpu, num, ret);
     return ret;
  efault:
     ret = -TARGET_EFAULT;
@@ -421,7 +424,9 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef DEBUG
     gemu_log("netbsd syscall %d\n", num);
 #endif
-    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
+
+    record_syscall_start(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
+
     if(do_strace)
         print_netbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
 
@@ -479,7 +484,8 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
     if (do_strace)
         print_netbsd_syscall_ret(num, ret);
-    trace_guest_user_syscall_ret(cpu, num, ret);
+
+    record_syscall_return(cpu, num, ret);
     return ret;
  efault:
     ret = -TARGET_EFAULT;
@@ -497,7 +503,9 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef DEBUG
     gemu_log("openbsd syscall %d\n", num);
 #endif
-    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
+
+    record_syscall_start(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
+
     if(do_strace)
         print_openbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
 
@@ -555,7 +563,8 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
     if (do_strace)
         print_openbsd_syscall_ret(num, ret);
-    trace_guest_user_syscall_ret(cpu, num, ret);
+
+    record_syscall_return(cpu, num, ret);
     return ret;
  efault:
     ret = -TARGET_EFAULT;
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
new file mode 100644
index 00000000000..9e604736433
--- /dev/null
+++ b/include/user/syscall-trace.h
@@ -0,0 +1,40 @@
+/*
+ * Common System Call Tracing Wrappers for *-user
+ *
+ * Copyright (c) 2019 Linaro
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _SYSCALL_TRACE_H_
+#define _SYSCALL_TRACE_H_
+
+/*
+ * These helpers just provide a common place for the various
+ * subsystems that want to track syscalls to put their hooks in. We
+ * could potentially unify the -strace code here as well.
+ */
+
+static inline void record_syscall_start(void *cpu, int num,
+                                        abi_long arg1, abi_long arg2,
+                                        abi_long arg3, abi_long arg4,
+                                        abi_long arg5, abi_long arg6,
+                                        abi_long arg7, abi_long arg8)
+{
+    trace_guest_user_syscall(cpu, num,
+                             arg1, arg2, arg3, arg4,
+                             arg5, arg6, arg7, arg8);
+    qemu_plugin_vcpu_syscall(cpu, num,
+                             arg1, arg2, arg3, arg4,
+                             arg5, arg6, arg7, arg8);
+}
+
+static inline void record_syscall_return(void *cpu, int num, abi_long ret)
+{
+    trace_guest_user_syscall_ret(cpu, num, ret);
+    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
+}
+
+
+#endif /* _SYSCALL_TRACE_H_ */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8367cb138df..9132f6d2663 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -109,6 +109,7 @@
 
 #include "qemu.h"
 #include "qemu/guest-random.h"
+#include "user/syscall-trace.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
 
@@ -11968,8 +11969,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 
-    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
-                             arg5, arg6, arg7, arg8);
+    record_syscall_start(cpu, num, arg1,
+                         arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
     if (unlikely(do_strace)) {
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -11981,6 +11982,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                           arg5, arg6, arg7, arg8);
     }
 
-    trace_guest_user_syscall_ret(cpu, num, ret);
+    record_syscall_return(cpu, num, ret);
     return ret;
 }
-- 
2.20.1


