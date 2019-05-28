Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB756C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CDD208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFrsBuLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CDD208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYol-0001aX-L6
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:54:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk3-0006Dg-4q
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk1-0008SN-MO
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYk1-0008RL-GW
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id i3so2135472wml.4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xIlsDgqq7H/zbFWeV8b+7PEZPgAhR33EEQ41qN96A+s=;
	b=HFrsBuLh5ShnqDxQN2u3c5ADuaCOPCxk9jIp0zLgPtnOAnGdimBHlFeL67TYoLOgxI
	MfZ61+gRYs5TGGD6BZwsX1npqGgasb/vqK4tlZqaSjNNga+QmA4Y+hA7ScbhprCt4y+u
	B3IQPT+Dufo+HXMiOQgo9jvhj+VjJ0mW4kVtlITkm9ME9h4+DiXbwISKCSncoFJq+KVg
	V2dmCLdmfjyc03DIWQvFIDgxzQZ9gpGDL3LxUfyD0L16gfP8KE4z/H2ZUvqlVBPRIE3X
	D/AHQnyQDMNhONhORGV6IVJWv2LRGsZoCrh99qWt+C26yrzO5nt6UPObQs9LLaNSb50y
	NZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xIlsDgqq7H/zbFWeV8b+7PEZPgAhR33EEQ41qN96A+s=;
	b=OalPXv8VTXWACFGFf9d00OXQC0qPz7QxGxx8zmSwIvv8TFV3O76STRPUY9blffW5mO
	ZqYa6LcYmlT7+I/PuChTLnjRJJQbvOfksOmVDMinmmtwgUthc+PnjNlpmskXM4VZ2yrS
	sDukdActv1UMUwUCAp8om5f8Ba5E47JcThwWFXUn4FLX0gyqFGjcsoDKfNv0BXxfiBal
	OnsDB4E8FpkexkWLrpmDy8m+Mb/xhSotI2tpvYa19CrwDmfkmELNqxW1yK6h7OEeXh4u
	iz2v7cKjnvqN+xiFIODGXTuTyqJxJp8uDcjgmDrFvoNmqJCACk7nhw7QLi0+8SvayEtX
	9fvg==
X-Gm-Message-State: APjAAAWx1yKX1fUuCiTsL1CAdS/pVjCnttfyb1kXgj4sHiKCC2BiznVd
	D8Uk0Ts45Xk/oXuz8gGRQHB9ew==
X-Google-Smtp-Source: APXvYqwu0RJZFM6bJnidA+cDv53itLYFd5ynDKHrOZXnI12QtYAtkKPYxmt1zx0WsclA1OrxuTegYw==
X-Received: by 2002:a1c:8017:: with SMTP id b23mr2480354wmd.117.1559036996289; 
	Tue, 28 May 2019 02:49:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	p16sm27332759wrg.49.2019.05.28.02.49.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:54 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id ACD6B1FF90;
	Tue, 28 May 2019 10:49:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:28 +0100
Message-Id: <20190528094953.14898-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 03/28] semihosting: implement a semihosting
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This provides two functions for handling console output that handle
the common backend behaviour for semihosting.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/semihosting/Makefile.objs b/hw/semihosting/Makefile.objs
index 09c19bf19ed..4ad47c05c06 100644
--- a/hw/semihosting/Makefile.objs
+++ b/hw/semihosting/Makefile.objs
@@ -1 +1,2 @@
 obj-$(CONFIG_SEMIHOSTING) += config.o
+obj-$(CONFIG_SEMIHOSTING) += console.o
diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
new file mode 100644
index 00000000000..01826bd6879
--- /dev/null
+++ b/hw/semihosting/console.c
@@ -0,0 +1,77 @@
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
+static void semihosting_cb(CPUState *cs, target_ulong ret, target_ulong err)
+{
+    if (ret == (target_ulong) -1) {
+        qemu_log("%s: gdb console output failed ("TARGET_FMT_ld")",
+                 __func__, err);
+    }
+}
+
+int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, int len)
+{
+    GString *s = copy_user_string(env, addr, len);
+    int out = s->len;
+
+    if (use_gdb_syscalls()) {
+        gdb_do_syscall(semihosting_cb, "write,2,%x,%x", addr, s->len);
+    } else {
+        out = qemu_semihosting_log_out(s->str, s->len);
+    }
+
+    g_string_free(s, true);
+    return out;
+}
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


