Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061BDCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65702070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0izpLM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65702070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtt2-0003N3-HV
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWY-0003KN-EG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWW-0007do-T2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWW-0007bu-Lq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id r1so951354wrs.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x47k/VxsI+WVM0DfT2oDeIPT5nZyOR1szQ7TpFo9UBw=;
 b=T0izpLM0apia/pOyYCgJ7Db/DMNeS7kKrQvA1yEhusGCcxMn3U9Rw1gV5r7Dd4m6Qh
 oEkzDpXyNyxomqv4o6oBLF3qqpuGV/uaTNE8qVdAn0I3wNtcGt0at6sMSTPqRgAYibhQ
 yDf2TMX3Lygdt5iUeXbWN8Ije0qEf1+W3OUtFHfngzd01fPMCcNli8wZltJozrhc72tm
 WMsTpZ6uuoeNA3hMNTVgQuk2kpeygarjm3Fsn/HchJcBuLV8MHTEk4X8H+8RV44azX/x
 mNMkIE6cPOEI+/15NaBv7GeY+6UtFtcVD+txKkkD4ib8hA/QupE8AWSjTq86/JP8A0Rx
 McDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x47k/VxsI+WVM0DfT2oDeIPT5nZyOR1szQ7TpFo9UBw=;
 b=L+wuIQsNj2nNTAWVrUjY0OsCLH6q1hkBBnik1ImDCefJMfYJJaIVrZ4kW3xqsIdJGR
 WW64syQ9NgQUXcyvWvik7yzFMW9j8QMOuTwXKiO7YkJ4coOXpmtCnyD+PVaCLBWcae2v
 LRfFd919U3Ewjr0qVmT49ZLRfv1U6u3rdVBB9BXWaYyt4S9pUE0l4u/1OvPZ7OVqpCts
 PsBtr9kDZ4t2jIebbuGftiwXUZl6dadpXetuyHN3jsWN6FZn6z2PCBzXOIjgTsu8vDAg
 yR7jepQMtNcDfhsCGAxZxTgRva/8+qdUuq7713Nxs4BMubT4Ekd6gfs8iIWRt2tO/R6Z
 RVTQ==
X-Gm-Message-State: APjAAAU4al9P8WEVG0C5zv6zp0aJhvvFPa3I4Z+XG58kzKNee2ddKVBW
 eC0eE93+ZLZt0f5+8kNAWhkFeg==
X-Google-Smtp-Source: APXvYqwpbbXkVyYXcxG02JsEWsXSTP6uvGMgoUVBk0JzF0sWtLPiMzsajZYJu95e34TB0yy5Q274Tw==
X-Received: by 2002:a5d:544d:: with SMTP id w13mr1363580wrv.19.1571986594761; 
 Thu, 24 Oct 2019 23:56:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r5sm1724815wrs.57.2019.10.24.23.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1DAC71FFBC;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 35/73] *-user: plugin syscalls
Date: Fri, 25 Oct 2019 07:36:35 +0100
Message-Id: <20191025063713.23374-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, "Emilio G. Cota" <cota@braap.org>,
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
index f1ab81b9177..be2a3b93b3a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -112,6 +112,7 @@
 
 #include "qemu.h"
 #include "qemu/guest-random.h"
+#include "user/syscall-trace.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
 
@@ -11983,8 +11984,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 
-    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
-                             arg5, arg6, arg7, arg8);
+    record_syscall_start(cpu, num, arg1,
+                         arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
     if (unlikely(do_strace)) {
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -11996,6 +11997,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                           arg5, arg6, arg7, arg8);
     }
 
-    trace_guest_user_syscall_ret(cpu, num, ret);
+    record_syscall_return(cpu, num, ret);
     return ret;
 }
-- 
2.20.1


