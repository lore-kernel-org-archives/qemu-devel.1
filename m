Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6745C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 23:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DDFD2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 23:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StglvpNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDFD2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7p26-0006sq-Qn
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 19:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k7p0b-00051j-R6
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 19:57:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k7p0a-0007xv-11
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 19:57:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id k20so15315856wmi.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=chbhkrsVtRz9xxebFWkkV4RfENvuYLHsr0SRq0Zx1m4=;
 b=StglvpNESRGFGuXIDhAwJ6MfBFWkTdiM9D/buYSa1thVNshRaAMWgxUQ9QRpCFSa9+
 vRVegngYpbLbZJeSvP2yNyVZ/3g565LtiEwj/IfUiYvkR8kMiqy+qBAjO9I++G9I/OlM
 q4/fxv73LRkbmziye83XyfRwO8i6N7BuhskS77XhsXnHJndzyz5bZ5WifBGl7DNN15Pm
 Lj5bfEf8YfaQjKvsKgJmqtZPpkk6PHjElfwZzfVFlz2Vug0YUfZ1j8OuQ0pjPVkZZtpe
 i/FJVZpr1dLAHXB4nd3f832SAuEap3r/F05PmiCCwk/ttv9Z7XCh9yq+DTul/AISrazT
 /ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=chbhkrsVtRz9xxebFWkkV4RfENvuYLHsr0SRq0Zx1m4=;
 b=RHUTtjyfMUOLe0qTnvn9/HFQaVBO3QX4a6mXj1TY4amHSZ37tKk6CH3znlR+FMEWEb
 zaUXdhP9SHFtzmg8Nm5g1CpsenjvqaISxyPtVhVtpsS9XvpOKUW3by5VkYy8y5ABDcSE
 XE+kSgD2GMJolk66/hPQelsa1GPbUU7z4NCSOzllTA26zveGam6jKl+cm1BPRaR4Vt9j
 3c4fzIxQbMPJz/LtIKakw8yZdnyE1SlDbzqZqMQAYZLTAGTxN374SysKKYheu+ptQy8m
 CHNG/yjUBOU8yVwbKQO1SvzVYSztneOOrfpv0HGMLKEGWSC7idx8IxjULTRdaK2r9iZS
 UPYw==
X-Gm-Message-State: AOAM531nZ/dTQlZOW4LF9ISALmMlGquKlqkCfbUE4Gfo6MzScLwzqali
 hq6nPzNQDqhr0EKv4+ZtXco6YyCxTNYNdg==
X-Google-Smtp-Source: ABdhPJy3LLjCFWMK2grfbjCguM2EdqNza0s75zVrIV8CUPhVTtFcvUEUm//2EQWTzTA0fyZSFhyaVA==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr16900141wmb.11.1597708662259; 
 Mon, 17 Aug 2020 16:57:42 -0700 (PDT)
Received: from mini.lan (ns331963.ip-37-187-122.eu. [37.187.122.190])
 by smtp.gmail.com with ESMTPSA id z12sm32715495wrp.20.2020.08.17.16.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 16:57:41 -0700 (PDT)
From: Andrew Aladjev <aladjev.andrew@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] linux user: refactored is proc myself,
 added support for fd/<execfd>
Date: Tue, 18 Aug 2020 02:57:12 +0300
Message-Id: <20200817235712.10957-3-aladjev.andrew@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817235712.10957-1-aladjev.andrew@gmail.com>
References: <20200817235712.10957-1-aladjev.andrew@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aladjev.andrew@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Andrew Aladjev <aladjev.andrew@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com>
---
 linux-user/syscall.c      |  12 ++--
 linux-user/syscall_proc.c | 113 +++++++++++++++++++++++++++++++-------
 linux-user/syscall_proc.h |   5 +-
 3 files changed, 101 insertions(+), 29 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 01edc9b68d..7f970ccf35 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7570,18 +7570,18 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
         { "auxv", open_self_auxv, is_proc_myself },
         { "cmdline", open_self_cmdline, is_proc_myself },
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
-        { "/proc/net/route", open_net_route, is_proc },
+        { "net/route", open_net_route, is_proc },
 #endif
 #if defined(TARGET_SPARC) || defined(TARGET_HPPA)
-        { "/proc/cpuinfo", open_cpuinfo, is_proc },
+        { "cpuinfo", open_cpuinfo, is_proc },
 #endif
 #if defined(TARGET_M68K)
-        { "/proc/hardware", open_hardware, is_proc },
+        { "hardware", open_hardware, is_proc },
 #endif
         { NULL, NULL, NULL }
     };
 
-    if (is_proc_myself(pathname, "exe")) {
+    if (is_proc_myself_exe(pathname)) {
         return execfd;
     }
 
@@ -9161,7 +9161,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             } else if (!arg3) {
                 /* Short circuit this for the magic exe check. */
                 ret = -TARGET_EINVAL;
-            } else if (is_proc_myself((const char *)p, "exe")) {
+            } else if (is_proc_myself_exe((const char *)p)) {
                 char real[PATH_MAX], *temp;
                 temp = realpath(exec_path, real);
                 /* Return value is # of bytes that we wrote to the buffer. */
@@ -9190,7 +9190,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
             if (!p || !p2) {
                 ret = -TARGET_EFAULT;
-            } else if (is_proc_myself((const char *)p, "exe")) {
+            } else if (is_proc_myself_exe((const char *)p)) {
                 char real[PATH_MAX], *temp;
                 temp = realpath(exec_path, real);
                 ret = temp == NULL ? get_errno(-1) : strlen(real) ;
diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c
index 34051a8e6b..3cf986b25f 100644
--- a/linux-user/syscall_proc.c
+++ b/linux-user/syscall_proc.c
@@ -1,32 +1,103 @@
 #include "qemu/osdep.h"
+#include "elf.h"
 
 #include "syscall_proc.h"
+#include "qemu.h"
 
-int is_proc_myself(const char *filename, const char *entry)
+#define PROC "/proc/"
+#define SELF "self/"
+#define FD   "fd/"
+
+#define STARTS_WITH(path, CONSTANT) (              \
+    strlen(path) >= strlen(CONSTANT) &&            \
+    strncmp(path, CONSTANT, strlen(CONSTANT)) == 0 \
+)
+
+static inline char *scope_to_proc(const char *path)
 {
-    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
-        filename += strlen("/proc/");
-        if (!strncmp(filename, "self/", strlen("self/"))) {
-            filename += strlen("self/");
-        } else if (*filename >= '1' && *filename <= '9') {
-            char myself[80];
-            snprintf(myself, sizeof(myself), "%d/", getpid());
-            if (!strncmp(filename, myself, strlen(myself))) {
-                filename += strlen(myself);
-            } else {
-                return 0;
-            }
-        } else {
-            return 0;
-        }
-        if (!strcmp(filename, entry)) {
-            return 1;
+    if (STARTS_WITH(path, PROC)) {
+        return (char *)path + strlen(PROC);
+    }
+
+    return NULL;
+}
+
+static inline char *scope_to_proc_myself(const char *path)
+{
+    char *scope_path = scope_to_proc(path);
+    if (scope_path == NULL) {
+        return NULL;
+    }
+
+    if (STARTS_WITH(scope_path, SELF)) {
+        return scope_path + strlen(SELF);
+    }
+
+    if (strlen(scope_path) >= 1 &&
+        *scope_path >= '1' && *scope_path <= '9') {
+        char pid_path[80];
+        snprintf(pid_path, sizeof(pid_path), "%d/", getpid());
+        if (STARTS_WITH(scope_path, pid_path)) {
+            return scope_path + strlen(pid_path);
         }
     }
-    return 0;
+
+    return NULL;
+}
+
+int is_proc(const char *path, const char *entry)
+{
+    char *scope_path = scope_to_proc(path);
+    if (scope_path == NULL) {
+        return 0;
+    }
+
+    return strcmp(scope_path, entry) == 0;
 }
 
-int is_proc(const char *filename, const char *entry)
+int is_proc_myself(const char *path, const char *entry)
 {
-    return strcmp(filename, entry) == 0;
+    char *scope_path = scope_to_proc_myself(path);
+    if (scope_path == NULL) {
+        return 0;
+    }
+
+    return strcmp(scope_path, entry) == 0;
+}
+
+/*
+ * Kernel creates "fd/#{number}" link after opening "exe" link.
+ * Both "exe" and "fd/#{number}" can be used by application.
+ *
+ * Kernel can provide infinite amount of fd numbers.
+ * QEMU is going to always return single global execfd.
+ *
+ * So we need to check "exe" and "fd/#{execfd}" only.
+ */
+
+int is_proc_myself_exe(const char *path)
+{
+    char *scope_path = scope_to_proc_myself(path);
+    if (scope_path == NULL) {
+        return 0;
+    }
+
+    if (strcmp(scope_path, "exe") == 0) {
+        return 1;
+    }
+
+    if (STARTS_WITH(scope_path, FD)) {
+        scope_path += strlen(FD);
+
+        if (strlen(scope_path) >= 1 &&
+            *scope_path >= '1' && *scope_path <= '9') {
+            char execfd_path[80];
+            snprintf(execfd_path, sizeof(execfd_path), "%d", execfd);
+            if (strcmp(scope_path, execfd_path) == 0) {
+                return 1;
+            }
+        }
+    }
+
+    return 0;
 }
diff --git a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h
index 3098af931f..f0e59c0e96 100644
--- a/linux-user/syscall_proc.h
+++ b/linux-user/syscall_proc.h
@@ -1,7 +1,8 @@
 #ifndef SYSCALL_PROC_H
 #define SYSCALL_PROC_H
 
-int is_proc(const char *filename, const char *entry);
-int is_proc_myself(const char *filename, const char *entry);
+int is_proc(const char *path, const char *entry);
+int is_proc_myself(const char *path, const char *entry);
+int is_proc_myself_exe(const char *path);
 
 #endif
-- 
2.26.2


