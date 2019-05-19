Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12115C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD41320644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9mbQQ3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD41320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53234 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSgo-00018F-Tt
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:45:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZ6-000347-6c
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZ4-0003id-PS
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:52 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZ4-0003hq-JB
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:50 -0400
Received: by mail-pl1-x644.google.com with SMTP id p1so336283plo.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=VSlxea5X8kmlG4BCCYdaO6spDVy0J4IfrRmHvvWJsEo=;
	b=h9mbQQ3SGTfIiYm6DeVYwSPJhUaB8QQBVG94ifShCK+mh+hBW7yDCIxug4QxQNRwtE
	5n4KFaTt2nNUgT6++NfshS0weturRSOcJGQp8c5UHxko9TmrdeEnLbayqooSdX4SPHRi
	sp2xjIfb3WInVj5vUBSOX7G1YZN8GwSAnaiXImnMHlyn1lyZh/sr1tNKIu7c6TM9Xbjc
	8nIRGRtDOLxNoDcfUnaOcCIaEtAwZG7c5SRQBsWkDPFRIR6/EduXcaf8OOdzPP3XPvcc
	yIgjCScjNkpUWUutc88dU4HtEtp1p3JgdSZXdb47hjE7D+G3QyLVFlPVJOYWBoNGzmLp
	5+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=VSlxea5X8kmlG4BCCYdaO6spDVy0J4IfrRmHvvWJsEo=;
	b=ZAh6P6iK1EGuuyYK8ccvnlYLRyAXHcAF615HReNxyLPQTEVsDoXFt7VaGtStiVRpfL
	g2aV86Q+3z3YZKTASBz0yBPHemEYiCQHJqcdTZJx58e5vFUeWXcUPByrL3qy76EEvlGI
	7TYBP7lBbRTrO92WyUEYjs9Y0clCN7wGv/l2JZOMfmRbDFOSFXYKQEH0lfyFxIsGFF1z
	Ao0fjhithkkiN3RMKNQZE9BtodmZl/8yjXAhJPZKZVVkMEX2q/5SOtGgLoWlKU84t7B7
	duHx5kdY7ajKzDp2lH0SMHBtMfBnTi6wUMoJMwwfURDcVW5zPgBB7c3XaJmBGrsf5Zme
	IiuQ==
X-Gm-Message-State: APjAAAVyF6WRKgfPJpZLrJ7tWbBu3SqP+/JHi3xWH8Z62LCXaju/00jL
	nKBXpK+kXHbReqzq+SZHdBjsV5fT+fM=
X-Google-Smtp-Source: APXvYqztCFumxDkQltuLHOaBHvO51Ba8Q32k0VRxSQrFQ+MRgx0CuHlzAG0tD0zkrwESHoU4PFRlYg==
X-Received: by 2002:a17:902:74c6:: with SMTP id
	f6mr13664060plt.335.1558298269373; 
	Sun, 19 May 2019 13:37:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:27 -0700
Message-Id: <20190519203726.20729-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v7 15/74] linux-user: Split out exit
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  1 +
 linux-user/syscall-proc.inc.c | 61 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 38 +---------------------
 3 files changed, 63 insertions(+), 37 deletions(-)
 create mode 100644 linux-user/syscall-proc.inc.c

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 88f433e998..88aa1a6bfd 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -17,6 +17,7 @@
  */
 
 SYSCALL_DEF(close, ARG_DEC);
+SYSCALL_DEF(exit, ARG_DEC);
 #ifdef TARGET_NR_ipc
 SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
new file mode 100644
index 0000000000..96ad363c1a
--- /dev/null
+++ b/linux-user/syscall-proc.inc.c
@@ -0,0 +1,61 @@
+/*
+ *  Linux process related syscalls
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+
+SYSCALL_IMPL(exit)
+{
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    int status = arg1;
+
+    /*
+     * In old applications this may be used to implement _exit(2).
+     * However in threaded applictions it is used for thread termination,
+     * and _exit_group is used for application termination.
+     * Do thread termination if we have more then one thread.
+     */
+    if (block_signals()) {
+        return -TARGET_ERESTARTSYS;
+    }
+
+    cpu_list_lock();
+
+    if (CPU_NEXT(first_cpu)) {
+        TaskState *ts;
+
+        /* Remove the CPU from the list.  */
+        QTAILQ_REMOVE_RCU(&cpus, cpu, node);
+
+        cpu_list_unlock();
+
+        ts = cpu->opaque;
+        if (ts->child_tidptr) {
+            put_user_u32(0, ts->child_tidptr);
+            sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
+                      NULL, NULL, 0);
+        }
+        thread_cpu = NULL;
+        object_unref(OBJECT(cpu));
+        g_free(ts);
+        rcu_unregister_thread();
+        pthread_exit(NULL);
+    }
+
+    cpu_list_unlock();
+    preexit_cleanup(cpu_env, status);
+    _exit(status);
+}
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 876426dd9c..c72d24aa76 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5681,43 +5681,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_exit:
-        /* In old applications this may be used to implement _exit(2).
-           However in threaded applictions it is used for thread termination,
-           and _exit_group is used for application termination.
-           Do thread termination if we have more then one thread.  */
-
-        if (block_signals()) {
-            return -TARGET_ERESTARTSYS;
-        }
-
-        cpu_list_lock();
-
-        if (CPU_NEXT(first_cpu)) {
-            TaskState *ts;
-
-            /* Remove the CPU from the list.  */
-            QTAILQ_REMOVE_RCU(&cpus, cpu, node);
-
-            cpu_list_unlock();
-
-            ts = cpu->opaque;
-            if (ts->child_tidptr) {
-                put_user_u32(0, ts->child_tidptr);
-                sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
-                          NULL, NULL, 0);
-            }
-            thread_cpu = NULL;
-            object_unref(OBJECT(cpu));
-            g_free(ts);
-            rcu_unregister_thread();
-            pthread_exit(NULL);
-        }
-
-        cpu_list_unlock();
-        preexit_cleanup(cpu_env, arg1);
-        _exit(arg1);
-        return 0; /* avoid warning */
     case TARGET_NR_brk:
         return do_brk(arg1);
 #ifdef TARGET_NR_fork
@@ -9975,6 +9938,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #include "syscall-file.inc.c"
 #include "syscall-ipc.inc.c"
 #include "syscall-mem.inc.c"
+#include "syscall-proc.inc.c"
 
 #undef SYSCALL_IMPL
 #undef SYSCALL_ARGS
-- 
2.17.1


