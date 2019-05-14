Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5305CC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9B92085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUeO4dKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9B92085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZoS-0000Vs-8O
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:57:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjn-0004jK-Ek
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjm-0006A2-2q
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQZjl-00067A-RC
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id f8so1981219wrt.1
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=hbC6Uuy+rCphFJXRN5GPHrqZRqXnqfdaGhA8RUCMKxg=;
	b=WUeO4dKj2jR9cpYA0NSwQvGZT4j8w99LEx03+eu5YZ6ZOELalepy/YcejiRAw5bCnJ
	ZIeHZat79geply6FbqT+jLBkVBy8a9F/FjCSsU7A773wGVsbAxh4MQIPX1KzoBGWDnu3
	ApMtwEigdorhtA7a6LFjhX4dQRsEDHpIkxprVZXMoPYeHIsARWsLW+CHjl0xgCxbGLe+
	HpUFrwSJfr63iMJchi9Pns9OMy6hvwy5JX/ftz8xncgpPEeswo6c7WHUqJZ94h4UhKVe
	jGWC73sJQpH9MshMqsEGUTpG6d75wmAE9dvgk5y+TY0gGCnZR3wlI1PL6OFkqNDplKmC
	vpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hbC6Uuy+rCphFJXRN5GPHrqZRqXnqfdaGhA8RUCMKxg=;
	b=H7tIXpeCwpLODMGBzDCddPRbVH709Of3oICU2uNc2+63XKsj92wC35A0RdGEzhUljd
	HIFSrZD3n6wJQlnSLxROj0CnAGLM7fFkLw3d2BrZ8vgrDKkFZKJZlMJzq8YQ9n0mavl9
	N9SvBbe/56+mJf1YmPxAKfcHrjr4M9qI5iZVHQsmKyHaj5AwMFvlupALnXX+zmtoU6qz
	DJcAkkcwo+9WwprsCPO8Rd5sZ5+1I1ucmW4xDpRIC6kdvUT76NuY6qD5ASWlvW2AnO8D
	IIbUM6/rxYWrKD2XfxR8p1D7LjmGWgFwQnUefjhIIlrTIICLeDzqGT+kT1nh5arDcrzn
	9F1A==
X-Gm-Message-State: APjAAAXwlgOLcCN7V+1ND6OzB/CX2EjgwNzV07wBvdL6r4NliE1rr5nI
	AIYmJZM2Wj8JtnTnjROO+W+44g==
X-Google-Smtp-Source: APXvYqxA6xDQNY4iDqohBNFgZXV2bejql6IKk2l+OLU0IZ5Qa/J8CQfH/OCNldhRJIjnQL7JzxHxnQ==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr22996703wrv.131.1557849184812; 
	Tue, 14 May 2019 08:53:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 22sm3423359wmg.44.2019.05.14.08.53.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 08:53:02 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4A54F1FF90;
	Tue, 14 May 2019 16:53:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 16:52:53 +0100
Message-Id: <20190514155301.16123-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514155301.16123-1-alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [RFC PATCH 03/11] semihosting: implement a semihosting
 console
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
Cc: qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This provides two functions for handling console output that handle
the common backend behaviour for semihosting.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c                        |  5 +++
 hw/semihosting/Makefile.objs     |  1 +
 hw/semihosting/console.c         | 70 ++++++++++++++++++++++++++++++++
 include/exec/gdbstub.h           | 11 +++++
 include/hw/semihosting/console.h | 38 +++++++++++++++++
 5 files changed, 125 insertions(+)
 create mode 100644 hw/semihosting/console.c
 create mode 100644 include/hw/semihosting/console.h

diff --git a/gdbstub.c b/gdbstub.c
index 793218bb43a..b4334014373 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1987,6 +1987,11 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...)
     va_end(va);
 }
 
+void gdb_do_console_out(target_ulong s, int len)
+{
+    gdb_do_syscall(NULL, "write,2,%x,1", s, len);
+}
+
 static void gdb_read_byte(GDBState *s, int ch)
 {
     uint8_t reply;
diff --git a/hw/semihosting/Makefile.objs b/hw/semihosting/Makefile.objs
index 09c19bf19ed..4ad47c05c06 100644
--- a/hw/semihosting/Makefile.objs
+++ b/hw/semihosting/Makefile.objs
@@ -1 +1,2 @@
 obj-$(CONFIG_SEMIHOSTING) += config.o
+obj-$(CONFIG_SEMIHOSTING) += console.o
diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
new file mode 100644
index 00000000000..ad6f67ecc71
--- /dev/null
+++ b/hw/semihosting/console.c
@@ -0,0 +1,70 @@
+/*
+ * Semihosting Console Support
+ *
+ * Copyright (c) 2015 Imagination Technologies
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * This provides support for outputting to a semihosting console.
+ *
+ * While most semihosting implementations support reading and writing
+ * to arbitrary file descriptors we treat the console as something
+ * specifically for debugging interaction. This means messages can be
+ * re-directed to gdb (if currently being used to debug) or even
+ * re-directed elsewhere.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/semihosting/console.h"
+#include "exec/gdbstub.h"
+#include "qemu/log.h"
+
+int qemu_semihosting_log_out(const char *s, int len)
+{
+    return write(STDERR_FILENO, s, len);
+}
+
+/*
+ * A re-implementation of lock_user_string that we can use locally
+ * instead of relying on softmmu-semi. Hopefully we can deprecate that
+ * in time. We either copy len bytes if specified or until we find a NULL.
+ */
+static GString *copy_user_string(CPUArchState *env, target_ulong addr, int len)
+{
+    CPUState *cpu = ENV_GET_CPU(env);
+    GString *s = g_string_sized_new(len ? len : 128);
+    uint8_t c;
+    bool done;
+
+    do {
+        if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
+            s = g_string_append_c(s, c);
+            done = len ? s->len == len : c == 0;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: passed inaccessible address " TARGET_FMT_lx,
+                          __func__, addr);
+            done = true;
+        }
+    } while (!done);
+
+    return s;
+}
+
+
+int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, int len)
+{
+    GString *s = copy_user_string(env, addr, len);
+    int out = s->len;
+
+    if (use_gdb_syscalls()) {
+        gdb_do_console_out(addr, s->len);
+    } else {
+        out = qemu_semihosting_log_out(s->str, s->len);
+    }
+
+    g_string_free(s, true);
+    return out;
+}
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 08363969c14..b2963547c48 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -44,6 +44,17 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...);
  * argument list.
  */
 void gdb_do_syscallv(gdb_syscall_complete_cb cb, const char *fmt, va_list va);
+/**
+ * gdb_do_console_out:
+ * @gs: guest address of string to send
+ * @len: length of string
+ *
+ * Sends a string to gdb console. Unlike the system call interface
+ * there is no callback and we assume the system call always
+ * succeeds.
+ */
+void gdb_do_console_out(target_ulong s, int len);
+
 int use_gdb_syscalls(void);
 void gdb_set_stop_cpu(CPUState *cpu);
 void gdb_exit(CPUArchState *, int);
diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/console.h
new file mode 100644
index 00000000000..30e66ae20aa
--- /dev/null
+++ b/include/hw/semihosting/console.h
@@ -0,0 +1,38 @@
+/*
+ * Semihosting Console
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _SEMIHOST_CONSOLE_H_
+#define _SEMIHOST_CONSOLE_H_
+
+/**
+ * qemu_semihosting_console_out:
+ * @env: CPUArchState
+ * @s: host address of guest string
+ * @len: length of string or 0 (string is null terminated)
+ *
+ * Send a guest string to the debug console. This may be the remote
+ * gdb session if a softmmu guest is currently being debugged.
+ *
+ * Returns: number of bytes written.
+ */
+int qemu_semihosting_console_out(CPUArchState *env, target_ulong s, int len);
+
+/**
+ * qemu_semihosting_log_out:
+ * @s: pointer to string
+ * @len: length of string
+ *
+ * Send a string to the debug output. Unlike console_out these strings
+ * can't be sent to a remote gdb instance as they don't exist in guest
+ * memory.
+ *
+ * Returns: number of bytes written
+ */
+int qemu_semihosting_log_out(const char *s, int len);
+
+#endif /* _SEMIHOST_CONSOLE_H_ */
-- 
2.20.1


