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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08242C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 23:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C870C2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 23:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUM9m7e2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C870C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7p1I-0005jl-3s
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 19:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k7p0V-0004sZ-1U
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 19:57:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:37476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k7p0T-0007xc-Ck
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 19:57:38 -0400
Received: by mail-wr1-x432.google.com with SMTP id y3so16581954wrl.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/gzpVNDN7rw08Y30zaVHDDVEjQK+MKmzOs7NKEAjHFY=;
 b=jUM9m7e2ujjnas6KKGVNpZKJnNu6sIoLUTljzEnbaYZsVWbBzZ1N6p8PXJcqFHP70A
 M1sIpgkv8rWNi8lSiAOjUfUkblg6scl1omjqOkmMon/qUKLUjsmRJqNgr+QgnKlHR3ra
 ekfCHsi/wnZW1VdKoK+YpV3QYGCwk5bDlOtnH9agT5Nu01AYM7tCW1BzJliUw1gbkbPg
 QjL71KJmORjA9Z9SI4VOnGth/BngdRVrtlFVwGC1d7zyKuwCDBGoJbk0elhDYXH72E/q
 5n0FbhUR/zDtO4C3HcsSr4l9XKsuD2NyNvPdE2qpVCGgmQL0g5SLOoh3nn7X85ZscHKV
 v+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/gzpVNDN7rw08Y30zaVHDDVEjQK+MKmzOs7NKEAjHFY=;
 b=ExyyhoIAyXHKNazz2TvGNWYegd9j0JcDHzZYc10F9LS8SxoS7tI6Qf78JAMrz51jwO
 q9Y8StiGBYdut/8f8Ug7FhRAq58TISifATOAPsZXG9Fo3uVT2EfM+sM6s3IrlL27zH2c
 KuaVSJZ7wtZ9PndAwhhPicKE5LIYdENun6EU4fk4hfP8Qq1oUKbT19FiG2i1UfHdV1Y3
 0ys+Q5asdYJ1zdTogV3BGzFDxyZPACj2fVjhjzaQw5y0SfskdDnOtGQrlv7ghvqLd+Jq
 twJp9MZ658F75EQm8q0z7KgIBF8WHP56QKIWn120bz7BQzUkjS9RbTOwGo3hQMp57agD
 itSg==
X-Gm-Message-State: AOAM530RzI9uAPrke62bIoqVMgOVPCHgJFRNYy5+MkopwqEfg+3xNuPH
 LDLSPqLWuurfHqurxrgDIXIdcmIX2pP0Og==
X-Google-Smtp-Source: ABdhPJyd2gq4/nKz3dGrARdCKleewC8j8LXjEGVZYd1tyakPSo9AacrQRWM0/h3mrmNzrDC+Ly0C/A==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr18685666wru.170.1597708655490; 
 Mon, 17 Aug 2020 16:57:35 -0700 (PDT)
Received: from mini.lan (ns331963.ip-37-187-122.eu. [37.187.122.190])
 by smtp.gmail.com with ESMTPSA id z12sm32715495wrp.20.2020.08.17.16.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 16:57:34 -0700 (PDT)
From: Andrew Aladjev <aladjev.andrew@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] linux user: moving is proc functions to separate file
Date: Tue, 18 Aug 2020 02:57:11 +0300
Message-Id: <20200817235712.10957-2-aladjev.andrew@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817235712.10957-1-aladjev.andrew@gmail.com>
References: <20200817235712.10957-1-aladjev.andrew@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=aladjev.andrew@gmail.com; helo=mail-wr1-x432.google.com
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
 linux-user/Makefile.objs  |  5 +++--
 linux-user/syscall.c      | 33 +--------------------------------
 linux-user/syscall_proc.c | 32 ++++++++++++++++++++++++++++++++
 linux-user/syscall_proc.h |  7 +++++++
 4 files changed, 43 insertions(+), 34 deletions(-)
 create mode 100644 linux-user/syscall_proc.c
 create mode 100644 linux-user/syscall_proc.h

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 1940910a73..20f8828b86 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,7 +1,8 @@
 obj-y = main.o syscall.o strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
-	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
+	safe-syscall.o syscall_proc.o \
+	$(TARGET_ABI_DIR)/cpu_loop.o $(TARGET_ABI_DIR)/signal.o \
+        exit.o fd-trans.o
 
 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5741c72733..01edc9b68d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -125,6 +125,7 @@
 #include "qapi/error.h"
 #include "fd-trans.h"
 #include "tcg/tcg.h"
+#include "syscall_proc.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -7482,38 +7483,6 @@ static int open_self_auxv(void *cpu_env, int fd)
     return 0;
 }
 
-static int is_proc_myself(const char *filename, const char *entry)
-{
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
-        }
-    }
-    return 0;
-}
-
-#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
-    defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA)
-static int is_proc(const char *filename, const char *entry)
-{
-    return strcmp(filename, entry) == 0;
-}
-#endif
-
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
 static int open_net_route(void *cpu_env, int fd)
 {
diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c
new file mode 100644
index 0000000000..34051a8e6b
--- /dev/null
+++ b/linux-user/syscall_proc.c
@@ -0,0 +1,32 @@
+#include "qemu/osdep.h"
+
+#include "syscall_proc.h"
+
+int is_proc_myself(const char *filename, const char *entry)
+{
+    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
+        filename += strlen("/proc/");
+        if (!strncmp(filename, "self/", strlen("self/"))) {
+            filename += strlen("self/");
+        } else if (*filename >= '1' && *filename <= '9') {
+            char myself[80];
+            snprintf(myself, sizeof(myself), "%d/", getpid());
+            if (!strncmp(filename, myself, strlen(myself))) {
+                filename += strlen(myself);
+            } else {
+                return 0;
+            }
+        } else {
+            return 0;
+        }
+        if (!strcmp(filename, entry)) {
+            return 1;
+        }
+    }
+    return 0;
+}
+
+int is_proc(const char *filename, const char *entry)
+{
+    return strcmp(filename, entry) == 0;
+}
diff --git a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h
new file mode 100644
index 0000000000..3098af931f
--- /dev/null
+++ b/linux-user/syscall_proc.h
@@ -0,0 +1,7 @@
+#ifndef SYSCALL_PROC_H
+#define SYSCALL_PROC_H
+
+int is_proc(const char *filename, const char *entry);
+int is_proc_myself(const char *filename, const char *entry);
+
+#endif
-- 
2.26.2


