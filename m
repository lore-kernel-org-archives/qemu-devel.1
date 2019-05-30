Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903BEC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 14:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6B325B3D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 14:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBI5c59N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6B325B3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55028 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWMG2-0000LG-Jx
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 10:42:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWMDK-0006qp-PW
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWMDJ-0005Hg-EW
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:39:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWMDJ-0005GI-6n
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:39:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id c2so4376675wrm.8
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=gd7q2lASJXtZ62TPJp+YNylW5PUKFPl62DxNRPE7tEM=;
	b=lBI5c59N+5+ZjSIaNBxt3B/w3E5pbPVO3uFxirhSbYvP26TY0v1yh1y8hoOUfVW4bb
	tKatTGEse6/xNZF1vplbp9UwzvjCohzV4wGUy5mJEfIQ9QzqpMzRd63gz8giUg9HV6yi
	XQMY5WjbX76SCnnEZ/p4vB/Y1J7lwS1ToFwtnHFHdLXFddDdxOn0lG6rPeToMeFQtdTB
	b29xwcgk8oVt1gHXxcMgHuBtBPnzcDC7pc+zxlfnPvGXJXnFWegaHBFyuZRvQ1DhLFJR
	E2SYaCfY/BSgQDemZ6etKfmCKpvIdwmFnwZgl4Qqyqrl7QsoQS7uMLTHu7X9JuGWwrX6
	jvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=gd7q2lASJXtZ62TPJp+YNylW5PUKFPl62DxNRPE7tEM=;
	b=T9fHXZ6cu24iVqFdehnuX4OWiGO0T04dBEPvdS4A6B/iogOPTOs16UdKxzScGxl9sr
	Bt5FDgPOwycAd+YswAU3wd3lDh1Sjho/lEXRtGtyCalyn4jn3MzI6Yg/t8ahpd+LkZAg
	OobB3giO6IpCa37Sw0PJl6YYJt4ybK5d6yMkEMTiCEsJ54HsYJk4UMeZMm/wIRjysZIM
	aVKfzCnEk3CPmmDcv35N+ppEkB8a8qjyDZYm9lbjmPpHczXw/hRqpaNs662Pb+Fc9mwA
	jDN1cI/a8BglCfdTGwQVDmH7AbbrQ8biFyxiDDZoaoKo3wAQzun2vZNAxhZ097mcfCc4
	Asjg==
X-Gm-Message-State: APjAAAVx7iSU5GRqrrXQFW9UtBxBujLLXyn/Je1w4eKcWXQ4Gppn6BIt
	kBHsi/9dRjZHhu7Y3tUP6QKSNQ==
X-Google-Smtp-Source: APXvYqxd5zkcxzkO7Al6A61qG1znBUh3836KMWXux+DYTUy8enmh8vvT4FiD9z/k/Ep99gu4WhAPbg==
X-Received: by 2002:a5d:6604:: with SMTP id n4mr1923490wru.124.1559227167371; 
	Thu, 30 May 2019 07:39:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 32sm6830428wra.35.2019.05.30.07.39.26
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 07:39:26 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A03461FF87;
	Thu, 30 May 2019 15:39:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 15:39:16 +0100
Message-Id: <20190530143916.20255-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [RFC PATCH] semihosting: split console_out intro
 string and char versions
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is ostensibly to avoid the weirdness of len looking like it might
come from a guest and sometimes being used. While we are at it fix up
the error checking for the arm-linux-user implementation of the API
which got flagged up by Coverity (CID 1401700).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/semihosting/console.c         | 34 +++++++++++++++++++++++---------
 include/hw/semihosting/console.h | 25 +++++++++++++++++------
 linux-user/arm/semihost.c        | 28 ++++++++++++++++++++++++--
 target/arm/arm-semi.c            |  4 ++--
 4 files changed, 72 insertions(+), 19 deletions(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 466ea6dade7..4a5758972db 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -36,26 +36,24 @@ int qemu_semihosting_log_out(const char *s, int len)
 /*
  * A re-implementation of lock_user_string that we can use locally
  * instead of relying on softmmu-semi. Hopefully we can deprecate that
- * in time. We either copy len bytes if specified or until we find a NULL.
+ * in time. Copy string until we find a 0 or address error.
  */
-static GString *copy_user_string(CPUArchState *env, target_ulong addr, int len)
+static GString *copy_user_string(CPUArchState *env, target_ulong addr)
 {
     CPUState *cpu = ENV_GET_CPU(env);
-    GString *s = g_string_sized_new(len ? len : 128);
+    GString *s = g_string_sized_new(128);
     uint8_t c;
-    bool done;
 
     do {
         if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
             s = g_string_append_c(s, c);
-            done = len ? s->len == len : c == 0;
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: passed inaccessible address " TARGET_FMT_lx,
                           __func__, addr);
-            done = true;
+            break;
         }
-    } while (!done);
+    } while (c!=0);
 
     return s;
 }
@@ -68,9 +66,9 @@ static void semihosting_cb(CPUState *cs, target_ulong ret, target_ulong err)
     }
 }
 
-int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, int len)
+int qemu_semihosting_console_outs(CPUArchState *env, target_ulong addr)
 {
-    GString *s = copy_user_string(env, addr, len);
+    GString *s = copy_user_string(env, addr);
     int out = s->len;
 
     if (use_gdb_syscalls()) {
@@ -82,3 +80,21 @@ int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, int len)
     g_string_free(s, true);
     return out;
 }
+
+void qemu_semihosting_console_outc(CPUArchState *env, target_ulong addr)
+{
+    CPUState *cpu = ENV_GET_CPU(env);
+    uint8_t c;
+
+    if (cpu_memory_rw_debug(cpu, addr, &c, 1, 0) == 0) {
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(semihosting_cb, "write,2,%x,%x", addr, 1);
+        } else {
+            qemu_semihosting_log_out((const char *) &c, 1);
+        }
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: passed inaccessible address " TARGET_FMT_lx,
+                      __func__, addr);
+    }
+}
diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/console.h
index 30e66ae20aa..3a4fba75905 100644
--- a/include/hw/semihosting/console.h
+++ b/include/hw/semihosting/console.h
@@ -10,17 +10,30 @@
 #define _SEMIHOST_CONSOLE_H_
 
 /**
- * qemu_semihosting_console_out:
+ * qemu_semihosting_console_outs:
  * @env: CPUArchState
- * @s: host address of guest string
- * @len: length of string or 0 (string is null terminated)
+ * @s: host address of null terminated guest string
  *
- * Send a guest string to the debug console. This may be the remote
- * gdb session if a softmmu guest is currently being debugged.
+ * Send a null terminated guest string to the debug console. This may
+ * be the remote gdb session if a softmmu guest is currently being
+ * debugged.
  *
  * Returns: number of bytes written.
  */
-int qemu_semihosting_console_out(CPUArchState *env, target_ulong s, int len);
+int qemu_semihosting_console_outs(CPUArchState *env, target_ulong s);
+
+/**
+ * qemu_semihosting_console_outc:
+ * @env: CPUArchState
+ * @s: host address of null terminated guest string
+ *
+ * Send single character from guest memory to the debug console. This
+ * may be the remote gdb session if a softmmu guest is currently being
+ * debugged.
+ *
+ * Returns: nothing
+ */
+void qemu_semihosting_console_outc(CPUArchState *env, target_ulong c);
 
 /**
  * qemu_semihosting_log_out:
diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
index 9554102a855..b7cdc21f832 100644
--- a/linux-user/arm/semihost.c
+++ b/linux-user/arm/semihost.c
@@ -15,10 +15,34 @@
 #include "hw/semihosting/console.h"
 #include "qemu.h"
 
-int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, int len)
+int qemu_semihosting_console_outs(CPUArchState *env, target_ulong addr)
 {
+    int len;
     void *s = lock_user_string(addr);
-    len = write(STDERR_FILENO, s, len ? len : strlen(s));
+    if (!s) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: passed inaccessible address " TARGET_FMT_lx,
+                      __func__, addr);
+        return 0;
+    }
+
+    len = write(STDERR_FILENO, s, strlen(s));
     unlock_user(s, addr, 0);
     return len;
 }
+
+void qemu_semihosting_console_outc(CPUArchState *env, target_ulong addr)
+{
+    char c;
+
+    if (get_user_u8(c, addr)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: passed inaccessible address " TARGET_FMT_lx,
+                      __func__, addr);
+    } else {
+        if (write(STDERR_FILENO, &c, 1) != 1) {
+            qemu_log_mask(LOG_UNIMP, "%s: unexpected write to stdout failure",
+                          __func__);
+        }
+    }
+}
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 53e807ab721..8844da8da38 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -315,10 +315,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(ts, close(arg0));
         }
     case TARGET_SYS_WRITEC:
-        qemu_semihosting_console_out(env, args, 1);
+        qemu_semihosting_console_outc(env, args);
         return 0xdeadbeef;
     case TARGET_SYS_WRITE0:
-        return qemu_semihosting_console_out(env, args, 0);
+        return qemu_semihosting_console_outs(env, args);
     case TARGET_SYS_WRITE:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.20.1


