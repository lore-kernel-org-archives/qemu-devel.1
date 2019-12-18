Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07BAC2D0D1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80992218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Af5ZQp5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80992218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdf7-0006cQ-UN
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 13:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdcs-0004sr-9Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdck-0002Xk-UH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:44 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihdck-0002TC-GX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:38 -0500
Received: by mail-wr1-x443.google.com with SMTP id q10so3268434wrm.11
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K2qAxDrW+aua7Zn4Y1Pq7im44DbrmZJggtzu3kQGHxk=;
 b=Af5ZQp5dL+xw61wJ2WOmX8XBMF6+IrVphNieNGwZGrb4Mxb4VcU8G5QGjnRhuDZJ94
 nNZ9u0wxeMF/g2TtuS41Jb25uZF/iLLG5ukDqr4c7yj/W4FxgIws5PvJmD6e6NPJZ949
 f0/6A0Hy0+186IGyLfIG/gX3ZL6B88nkB606nPX2/apdT+Bn8H1VNJwK5OLYdHXtqTcR
 pfjtBgggsBkcmlePDHZNl8JjJsqrXzyKt9H6JK8WS7YPL2o8GnNhcX9Z9pVE5FIhxbYB
 dbCbwcMenzdbhSvVw5C9R1lkWymYHyLf97ZnvVOAtUagoKWfiSbI3jVgy5GRP6hMZMQf
 yiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K2qAxDrW+aua7Zn4Y1Pq7im44DbrmZJggtzu3kQGHxk=;
 b=tsfIui+Vp8TDLCrnyhRsKPU3XiW0EcUE9nO8vxOu40OdWX9TO0iGfM51kNSZ+MPkhJ
 Gv/nVbuFm0qGBRqJrZoH1eDzDHdbfqXXQkmljfEdf6bXPwhe0ofJ8sEVEBR16/pwwWsd
 2WcX9H1iBRTvcMHNv7UFERCL2u4v3ex/4EseEAOKfqObWMz9MGdzOLMGqFXmt2D8inh3
 qpM1ya5doKodrVFBxOHCSeNkGavS/+SbSKcOo5maBNLuVbiIYLt8CXbXVJthBsfq+1sI
 8G6OAWNI9qBqrTCphVPgzG7sl40Ryyabyb/G3RnYiIiPEy4IjvE2FBNph1ayeY/Mxpdq
 +New==
X-Gm-Message-State: APjAAAXnJ6XloJLPxJcDRJdgEO15an4WoR7urotuGcyKPfnXyx4B6cTA
 D+sZ2frVKcp1WunY9ESa+sTq0Q==
X-Google-Smtp-Source: APXvYqy/tikRT44obMDAn/SxkSSCf1W9iwYo2Pt0cK/5NfeF3M7XZQ2KbBC26dw6k2M4x3UiHJtsWA==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr3996523wrv.55.1576692035373; 
 Wed, 18 Dec 2019 10:00:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u24sm3220966wml.10.2019.12.18.10.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 10:00:33 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9B1EE1FF90;
 Wed, 18 Dec 2019 18:00:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/4] semihosting: add qemu_semihosting_console_inc for
 SYS_READC
Date: Wed, 18 Dec 2019 18:00:28 +0000
Message-Id: <20191218180029.6744-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218180029.6744-1-alex.bennee@linaro.org>
References: <20191218180029.6744-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, pbonzini@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Keith Packard <keithp@keithp.com>

Provides a blocking call to read a character from the console using
semihosting.chardev, if specified. This takes some careful command
line options to use stdio successfully as the serial ports, monitor
and semihost all want to use stdio. Here's a sample set of command
line options which share stdio betwen semihost, monitor and serial
ports:

	qemu \
	-chardev stdio,mux=on,id=stdio0 \
	-serial chardev:stdio0 \
	-semihosting-config enable=on,chardev=stdio0 \
	-mon chardev=stdio0,mode=readline

This creates a chardev hooked to stdio and then connects all of the
subsystems to it. A shorter mechanism would be good to hear about.

Signed-off-by: Keith Packard <keithp@keithp.com>
Message-Id: <20191104204230.12249-1-keithp@keithp.com>
[AJB: fixed up deadlock, minor commit title reword]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

---
v7
  - reword commit title
  - remove mutexs, halt CPU until data available
  - document cpu_loop_exit behavior in function API
---
 include/hw/semihosting/console.h  | 16 +++++++
 include/hw/semihosting/semihost.h |  4 ++
 hw/semihosting/console.c          | 78 +++++++++++++++++++++++++++++++
 linux-user/arm/semihost.c         | 23 +++++++++
 stubs/semihost.c                  |  4 ++
 target/arm/arm-semi.c             |  3 +-
 vl.c                              |  3 ++
 7 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/console.h
index 9be9754bcdf..a3bd6ca2419 100644
--- a/include/hw/semihosting/console.h
+++ b/include/hw/semihosting/console.h
@@ -37,6 +37,22 @@ int qemu_semihosting_console_outs(CPUArchState *env, target_ulong s);
  */
 void qemu_semihosting_console_outc(CPUArchState *env, target_ulong c);
 
+/**
+ * qemu_semihosting_console_inc:
+ * @env: CPUArchState
+ *
+ * Receive single character from debug console. This may be the remote
+ * gdb session if a softmmu guest is currently being debugged. As this
+ * call may block if no data is available we suspend the CPU and will
+ * rexecute the instruction when data is there. Therefor two
+ * conditions must be met:
+ *   - CPUState is syncronised before callinging this function
+ *   - pc is only updated once the character is succesfully returned
+ *
+ * Returns: character read OR cpu_loop_exit!
+ */
+target_ulong qemu_semihosting_console_inc(CPUArchState *env);
+
 /**
  * qemu_semihosting_log_out:
  * @s: pointer to string
diff --git a/include/hw/semihosting/semihost.h b/include/hw/semihosting/semihost.h
index 60fc42d851e..b8ce5117ae0 100644
--- a/include/hw/semihosting/semihost.h
+++ b/include/hw/semihosting/semihost.h
@@ -56,6 +56,9 @@ static inline Chardev *semihosting_get_chardev(void)
 {
     return NULL;
 }
+static inline void qemu_semihosting_console_init(void)
+{
+}
 #else /* !CONFIG_USER_ONLY */
 bool semihosting_enabled(void);
 SemihostingTarget semihosting_get_target(void);
@@ -68,6 +71,7 @@ Chardev *semihosting_get_chardev(void);
 void qemu_semihosting_enable(void);
 int qemu_semihosting_config_options(const char *opt);
 void qemu_semihosting_connect_chardevs(void);
+void qemu_semihosting_console_init(void);
 #endif /* CONFIG_USER_ONLY */
 
 #endif /* SEMIHOST_H */
diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index b4b17c8afbc..6180f33ef21 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -20,8 +20,15 @@
 #include "hw/semihosting/semihost.h"
 #include "hw/semihosting/console.h"
 #include "exec/gdbstub.h"
+#include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
+#include <pthread.h>
+#include "chardev/char-fe.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+#include "qapi/error.h"
+#include "qemu/fifo8.h"
 
 int qemu_semihosting_log_out(const char *s, int len)
 {
@@ -98,3 +105,74 @@ void qemu_semihosting_console_outc(CPUArchState *env, target_ulong addr)
                       __func__, addr);
     }
 }
+
+#define FIFO_SIZE   1024
+
+typedef struct SemihostingConsole {
+    CharBackend         backend;
+    GSList              *sleeping_cpus;
+    bool                got;
+    Fifo8               fifo;
+} SemihostingConsole;
+
+static SemihostingConsole console;
+
+static int console_can_read(void *opaque)
+{
+    SemihostingConsole *c = opaque;
+    int ret;
+    g_assert(qemu_mutex_iothread_locked());
+    ret = (int) fifo8_num_free(&c->fifo);
+    return ret;
+}
+
+static void console_wake_up(gpointer data, gpointer user_data)
+{
+    CPUState *cs = (CPUState *) data;
+    /* cpu_handle_halt won't know we have work so just unbung here */
+    cs->halted = 0;
+    qemu_cpu_kick(cs);
+}
+
+static void console_read(void *opaque, const uint8_t *buf, int size)
+{
+    SemihostingConsole *c = opaque;
+    g_assert(qemu_mutex_iothread_locked());
+    while (size-- && !fifo8_is_full(&c->fifo)) {
+        fifo8_push(&c->fifo, *buf++);
+    }
+    g_slist_foreach(c->sleeping_cpus, console_wake_up, NULL);
+}
+
+target_ulong qemu_semihosting_console_inc(CPUArchState *env)
+{
+    uint8_t ch;
+    SemihostingConsole *c = &console;
+    g_assert(qemu_mutex_iothread_locked());
+    g_assert(current_cpu);
+    if (fifo8_is_empty(&c->fifo)) {
+        c->sleeping_cpus = g_slist_prepend(c->sleeping_cpus, current_cpu);
+        current_cpu->halted = 1;
+        current_cpu->exception_index = EXCP_HALTED;
+        cpu_loop_exit(current_cpu);
+        /* never returns */
+    }
+    c->sleeping_cpus = g_slist_remove_all(c->sleeping_cpus, current_cpu);
+    ch = fifo8_pop(&c->fifo);
+    return (target_ulong) ch;
+}
+
+void qemu_semihosting_console_init(void)
+{
+    Chardev *chr = semihosting_get_chardev();
+
+    if  (chr) {
+        fifo8_create(&console.fifo, FIFO_SIZE);
+        qemu_chr_fe_init(&console.backend, chr, &error_abort);
+        qemu_chr_fe_set_handlers(&console.backend,
+                                 console_can_read,
+                                 console_read,
+                                 NULL, NULL, &console,
+                                 NULL, true);
+    }
+}
diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
index a16b525eec0..4f998d62201 100644
--- a/linux-user/arm/semihost.c
+++ b/linux-user/arm/semihost.c
@@ -14,6 +14,7 @@
 #include "cpu.h"
 #include "hw/semihosting/console.h"
 #include "qemu.h"
+#include <poll.h>
 
 int qemu_semihosting_console_outs(CPUArchState *env, target_ulong addr)
 {
@@ -47,3 +48,25 @@ void qemu_semihosting_console_outc(CPUArchState *env, target_ulong addr)
         }
     }
 }
+
+target_ulong qemu_semihosting_console_inc(CPUArchState *env)
+{
+    uint8_t c;
+    struct pollfd pollfd = {
+        .fd = STDIN_FILENO,
+        .events = POLLIN
+    };
+
+    if (poll(&pollfd, 1, -1) != 1) {
+        qemu_log_mask(LOG_UNIMP, "%s: unexpected read from stdin failure",
+                      __func__);
+        return (target_ulong) -1;
+    }
+
+    if (read(STDIN_FILENO, &c, 1) != 1) {
+        qemu_log_mask(LOG_UNIMP, "%s: unexpected read from stdin failure",
+                      __func__);
+        return (target_ulong) -1;
+    }
+    return (target_ulong) c;
+}
diff --git a/stubs/semihost.c b/stubs/semihost.c
index f90589259c0..1d8b37f7b2f 100644
--- a/stubs/semihost.c
+++ b/stubs/semihost.c
@@ -69,3 +69,7 @@ void semihosting_arg_fallback(const char *file, const char *cmd)
 void qemu_semihosting_connect_chardevs(void)
 {
 }
+
+void qemu_semihosting_console_init(void)
+{
+}
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 6f7b6d801bf..47d61f6fe1f 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -802,8 +802,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
 
         return guestfd_fns[gf->type].readfn(cpu, gf, arg1, len);
     case TARGET_SYS_READC:
-        qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func__);
-        return 0;
+        return qemu_semihosting_console_inc(env);
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
 
diff --git a/vl.c b/vl.c
index 94508300c3c..1912f87822b 100644
--- a/vl.c
+++ b/vl.c
@@ -4142,6 +4142,9 @@ int main(int argc, char **argv, char **envp)
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
 
+    /* connect semihosting console input if requested */
+    qemu_semihosting_console_init();
+
     if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
         exit(1);
     if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
-- 
2.20.1


