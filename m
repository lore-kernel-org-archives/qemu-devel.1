Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D50FA3735
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CF62089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSi9RR/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CF62089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5xy-0007Nn-7H
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dm-00089i-PD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dl-0005Ux-AL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5dk-0005UM-MC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id r3so2319449wrj.6
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=etDCqYHg2LYQtZa+T5XCKHLqmFEuamg260f6vcRF/Qs=;
 b=dSi9RR/FAGfahfUx6d4zyjw8bGdRDSXq3te/ysoRb208aIloKC9qhn98xhhuTPVYgi
 RGedQoImgYAVvdFeTtGCE/tKLCHQCkTmZuAV0RMxg3Bcu0Qff4aUSBmePb2EC2F9HR9E
 1Ei5VLvKMifhV3xzkjU6Kx5hAcXl4i+cnp0eOAAfsCAMu2Z2UwsUgpp6KfDBcrQr6Lf2
 QCJeQBUk1BRKo22B0IdFY4otpsCY9tuQAj3E3A3z2C03M81S8OsyzCitZNdvZqOfZzvj
 Q0V88vkrv5zNKELfrGYBn0lIapNCmx0IisKMeRJ7cag3Q0mfiPqndRB2OAxksLCRFpxB
 zerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=etDCqYHg2LYQtZa+T5XCKHLqmFEuamg260f6vcRF/Qs=;
 b=rsVcXhrEjsFnrTJGL7QxlBxXRh/IiUuz/yAokWNGy5jIE7JSnewu3/eqz9iv03vagu
 k6x94Ksb5zFdNAkRIbuhrNiw5HTRSoz8uL3ZlcrfilZzHIYjIGtM3rKwQym+tDzoL1VV
 +GTMBO6Q/JBPmBsXyZxI4XjlCXiCwQltWk5IRI7XpuCokXXNJg4gsBIAI9Ya1JZg9hNa
 ihco3c+WfIgqNp3Ha9hN7d9jZB/LxRQM3ruxid+/T9QuTpW/mYplbfDTg/iHtdraLR2b
 h1nE30tJVxP09ORIfYmPO58nqE3z9wdM6g4i+JRrawrs43rdYiUlAJpuGFBK5cA25R9/
 RiMA==
X-Gm-Message-State: APjAAAWhsyu64r1eN52/hjXA1otVUF5DfYNOx2Zar9DF/YkbWmfLrHg5
 GXIz05cvuXDY240fkTtPwhSJtw==
X-Google-Smtp-Source: APXvYqzGNWXeHk5xFNGpY3Ug4R7A1ikQ6mt0fRZsauicPjaJQmAifqmPZnjpJKJmFSsV8H09iNcbPQ==
X-Received: by 2002:a05:6000:11c5:: with SMTP id
 i5mr2956100wrx.303.1571318187541; 
 Thu, 17 Oct 2019 06:16:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v11sm1984454wml.30.2019.10.17.06.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB24B1FFA5;
 Thu, 17 Oct 2019 14:16:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 19/54] *-user: plugin syscalls
Date: Thu, 17 Oct 2019 14:15:40 +0100
Message-Id: <20191017131615.19660-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: robert.foley@futurewei.com, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
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
index 84a983a9a1..0d45b654bb 100644
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
index 0000000000..9e60473643
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
index e2af3c1494..77e87a959f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -112,6 +112,7 @@
 
 #include "qemu.h"
 #include "qemu/guest-random.h"
+#include "user/syscall-trace.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
 
@@ -11981,8 +11982,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 
-    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
-                             arg5, arg6, arg7, arg8);
+    record_syscall_start(cpu, num, arg1,
+                         arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
     if (unlikely(do_strace)) {
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -11994,6 +11995,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                           arg5, arg6, arg7, arg8);
     }
 
-    trace_guest_user_syscall_ret(cpu, num, ret);
+    record_syscall_return(cpu, num, ret);
     return ret;
 }
-- 
2.20.1


