Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B702C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426AC20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLBYm0oI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426AC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtry-00075H-B3
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRL-0000aw-8n
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRG-000822-PO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRG-0007us-EU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id a25so22273754wrd.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mhAKDLwevRgUwbK/Yj2EAj4vkZTmlFwtudl8wSKqu+o=;
 b=kLBYm0oI9tPnsVU0NUlIQGInfIQpjjcBhrmUmPqkrDdJdozWRkMG+XpGMv6vm9ycUN
 zzV5OaTCuLf33iovWS8PkN0F1Ip5XjaqCyqPNuZdhR32FfbPWe/4+SgPchC9o2iLRVj9
 sjsQjOY8/Nv9tztmr5WZc+c/kTTpzsnLWT1sIGpizKWkAiknpQnEiyspKzDqBH1mNjqV
 vXNKm6n94l1ggzkZyISIBOWV0uqhgAwI+yozgPHM5z6z+dFKuKRLurzy53WcrRknsIXG
 YIeahQonKiSp0J6uu1rDjfb5gWZC5tWbgQd6CgQdTrqiU3+aPfvMYm7fZHUn73Y6x8C6
 KLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mhAKDLwevRgUwbK/Yj2EAj4vkZTmlFwtudl8wSKqu+o=;
 b=fCScTolTvQAkY6QwCETop3RDoAvNWrhowIwSlEGwpA7EBbDFq485ju4lvOiNtVu4wd
 WZ9GlyefNwxMvxlKhVMlZyy0Noe6Df3A4AMeLEhLKo4G43l0R8G6uptA1GHO0LQMYhIz
 D5f1GgEqlX/M2hfB3w3MH0XeINQWge3zHeW0USP0ZptsXj526suQEc404B4p3PjsussW
 2sR6hYNPFbFR2RsJQK2kiIhu39en3t9lBMw2LNpg2ZnnwQZibeN3lRLJTlBTpm+/VV0R
 fkcivWqxQAGp4eHEfFcr5NkyqqQVt1D4KLfsOg7ZyMQLY1zBYphoQJNhN4ZRUhQ/d5BN
 JGJw==
X-Gm-Message-State: ANhLgQ1Yzu9JRg/FfDffEHRirYXChehfPmt5PGRGQz4eLyrvL+iYXmYd
 uR0yUggr8Xufb85pu90NXRBlwA==
X-Google-Smtp-Source: ADFU+vvxrR8H34wp6yQPe/lfc1OEAVKFSEg2ROT9kVTGnXm4hYUZJsiJ/nRlSa9NqqpfKhKmBCFlog==
X-Received: by 2002:a5d:55c7:: with SMTP id i7mr420375wrw.252.1584379325191;
 Mon, 16 Mar 2020 10:22:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k3sm712373wro.59.2020.03.16.10.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A9A611FF92;
 Mon, 16 Mar 2020 17:21:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/28] gdbstub: make GDBState static and have common init
 function
Date: Mon, 16 Mar 2020 17:21:33 +0000
Message-Id: <20200316172155.971-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of allocating make this entirely static. We shall reduce the
size of the structure in later commits and dynamically allocate parts
of it. We introduce an init and reset helper function to keep all the
manipulation in one place.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

---
v2
  - made entirely static, dropped dh/rth r-b tags due to changes
---
 gdbstub.c | 168 ++++++++++++++++++++++++++----------------------------
 1 file changed, 81 insertions(+), 87 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 22a2d630cdc..57d6e50ddfc 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -342,6 +342,7 @@ enum RSState {
     RS_CHKSUM2,
 };
 typedef struct GDBState {
+    bool init;       /* have we been initialised? */
     CPUState *c_cpu; /* current CPU for step/continue ops */
     CPUState *g_cpu; /* current CPU for other ops */
     CPUState *query_cpu; /* for q{f|s}ThreadInfo */
@@ -372,7 +373,23 @@ typedef struct GDBState {
  */
 static int sstep_flags = SSTEP_ENABLE|SSTEP_NOIRQ|SSTEP_NOTIMER;
 
-static GDBState *gdbserver_state;
+static GDBState gdbserver_state;
+
+static void init_gdbserver_state(void)
+{
+    g_assert(!gdbserver_state.init);
+    memset(&gdbserver_state, 0, sizeof(GDBState));
+    gdbserver_state.init = true;
+}
+
+#ifndef CONFIG_USER_ONLY
+static void reset_gdbserver_state(void)
+{
+    g_free(gdbserver_state.processes);
+    gdbserver_state.processes = NULL;
+    gdbserver_state.process_num = 0;
+}
+#endif
 
 bool gdb_has_xml;
 
@@ -425,8 +442,8 @@ int use_gdb_syscalls(void)
     /* -semihosting-config target=auto */
     /* On the first call check if gdb is connected and remember. */
     if (gdb_syscall_mode == GDB_SYS_UNKNOWN) {
-        gdb_syscall_mode = (gdbserver_state ? GDB_SYS_ENABLED
-                                            : GDB_SYS_DISABLED);
+        gdb_syscall_mode = gdbserver_state.init ?
+            GDB_SYS_ENABLED : GDB_SYS_DISABLED;
     }
     return gdb_syscall_mode == GDB_SYS_ENABLED;
 }
@@ -984,7 +1001,7 @@ static int gdb_breakpoint_insert(int type, target_ulong addr, target_ulong len)
     int err = 0;
 
     if (kvm_enabled()) {
-        return kvm_insert_breakpoint(gdbserver_state->c_cpu, addr, len, type);
+        return kvm_insert_breakpoint(gdbserver_state.c_cpu, addr, len, type);
     }
 
     switch (type) {
@@ -1021,7 +1038,7 @@ static int gdb_breakpoint_remove(int type, target_ulong addr, target_ulong len)
     int err = 0;
 
     if (kvm_enabled()) {
-        return kvm_remove_breakpoint(gdbserver_state->c_cpu, addr, len, type);
+        return kvm_remove_breakpoint(gdbserver_state.c_cpu, addr, len, type);
     }
 
     switch (type) {
@@ -1074,7 +1091,7 @@ static void gdb_breakpoint_remove_all(void)
     CPUState *cpu;
 
     if (kvm_enabled()) {
-        kvm_remove_all_breakpoints(gdbserver_state->c_cpu);
+        kvm_remove_all_breakpoints(gdbserver_state.c_cpu);
         return;
     }
 
@@ -2601,7 +2618,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
 
 void gdb_set_stop_cpu(CPUState *cpu)
 {
-    GDBProcess *p = gdb_get_cpu_process(gdbserver_state, cpu);
+    GDBProcess *p = gdb_get_cpu_process(&gdbserver_state, cpu);
 
     if (!p->attached) {
         /*
@@ -2611,14 +2628,14 @@ void gdb_set_stop_cpu(CPUState *cpu)
         return;
     }
 
-    gdbserver_state->c_cpu = cpu;
-    gdbserver_state->g_cpu = cpu;
+    gdbserver_state.c_cpu = cpu;
+    gdbserver_state.g_cpu = cpu;
 }
 
 #ifndef CONFIG_USER_ONLY
 static void gdb_vm_state_change(void *opaque, int running, RunState state)
 {
-    GDBState *s = gdbserver_state;
+    GDBState *s = &gdbserver_state;
     CPUState *cpu = s->c_cpu;
     char buf[256];
     char thread_id[16];
@@ -2722,17 +2739,16 @@ void gdb_do_syscallv(gdb_syscall_complete_cb cb, const char *fmt, va_list va)
     char *p_end;
     target_ulong addr;
     uint64_t i64;
-    GDBState *s;
 
-    s = gdbserver_state;
-    if (!s)
+    if (!gdbserver_state.init)
         return;
-    s->current_syscall_cb = cb;
+
+    gdbserver_state.current_syscall_cb = cb;
 #ifndef CONFIG_USER_ONLY
     vm_stop(RUN_STATE_DEBUG);
 #endif
-    p = s->syscall_buf;
-    p_end = &s->syscall_buf[sizeof(s->syscall_buf)];
+    p = &gdbserver_state.syscall_buf[0];
+    p_end = &gdbserver_state.syscall_buf[sizeof(gdbserver_state.syscall_buf)];
     *(p++) = 'F';
     while (*fmt) {
         if (*fmt == '%') {
@@ -2765,14 +2781,14 @@ void gdb_do_syscallv(gdb_syscall_complete_cb cb, const char *fmt, va_list va)
     }
     *p = 0;
 #ifdef CONFIG_USER_ONLY
-    put_packet(s, s->syscall_buf);
+    put_packet(&gdbserver_state, gdbserver_state.syscall_buf);
     /* Return control to gdb for it to process the syscall request.
      * Since the protocol requires that gdb hands control back to us
      * using a "here are the results" F packet, we don't need to check
      * gdb_handlesig's return value (which is the signal to deliver if
      * execution was resumed via a continue packet).
      */
-    gdb_handlesig(s->c_cpu, 0);
+    gdb_handlesig(gdbserver_state.c_cpu, 0);
 #else
     /* In this case wait to send the syscall packet until notification that
        the CPU has stopped.  This must be done because if the packet is sent
@@ -2780,7 +2796,7 @@ void gdb_do_syscallv(gdb_syscall_complete_cb cb, const char *fmt, va_list va)
        is still in the running state, which can cause packets to be dropped
        and state transition 'T' packets to be sent while the syscall is still
        being processed.  */
-    qemu_cpu_kick(s->c_cpu);
+    qemu_cpu_kick(gdbserver_state.c_cpu);
 #endif
 }
 
@@ -2941,15 +2957,13 @@ static void gdb_read_byte(GDBState *s, uint8_t ch)
 /* Tell the remote gdb that the process has exited.  */
 void gdb_exit(CPUArchState *env, int code)
 {
-  GDBState *s;
   char buf[4];
 
-  s = gdbserver_state;
-  if (!s) {
+  if (!gdbserver_state.init) {
       return;
   }
 #ifdef CONFIG_USER_ONLY
-  if (gdbserver_fd < 0 || s->fd < 0) {
+  if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
       return;
   }
 #endif
@@ -2957,10 +2971,10 @@ void gdb_exit(CPUArchState *env, int code)
   trace_gdbstub_op_exiting((uint8_t)code);
 
   snprintf(buf, sizeof(buf), "W%02x", (uint8_t)code);
-  put_packet(s, buf);
+  put_packet(&gdbserver_state, buf);
 
 #ifndef CONFIG_USER_ONLY
-  qemu_chr_fe_deinit(&s->chr, true);
+  qemu_chr_fe_deinit(&gdbserver_state.chr, true);
 #endif
 }
 
@@ -2993,12 +3007,10 @@ static void create_default_process(GDBState *s)
 int
 gdb_handlesig(CPUState *cpu, int sig)
 {
-    GDBState *s;
     char buf[256];
     int n;
 
-    s = gdbserver_state;
-    if (gdbserver_fd < 0 || s->fd < 0) {
+    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
         return sig;
     }
 
@@ -3008,58 +3020,55 @@ gdb_handlesig(CPUState *cpu, int sig)
 
     if (sig != 0) {
         snprintf(buf, sizeof(buf), "S%02x", target_signal_to_gdb(sig));
-        put_packet(s, buf);
+        put_packet(&gdbserver_state, buf);
     }
     /* put_packet() might have detected that the peer terminated the
        connection.  */
-    if (s->fd < 0) {
+    if (gdbserver_state.fd < 0) {
         return sig;
     }
 
     sig = 0;
-    s->state = RS_IDLE;
-    s->running_state = 0;
-    while (s->running_state == 0) {
-        n = read(s->fd, buf, 256);
+    gdbserver_state.state = RS_IDLE;
+    gdbserver_state.running_state = 0;
+    while (gdbserver_state.running_state == 0) {
+        n = read(gdbserver_state.fd, buf, 256);
         if (n > 0) {
             int i;
 
             for (i = 0; i < n; i++) {
-                gdb_read_byte(s, buf[i]);
+                gdb_read_byte(&gdbserver_state, buf[i]);
             }
         } else {
             /* XXX: Connection closed.  Should probably wait for another
                connection before continuing.  */
             if (n == 0) {
-                close(s->fd);
+                close(gdbserver_state.fd);
             }
-            s->fd = -1;
+            gdbserver_state.fd = -1;
             return sig;
         }
     }
-    sig = s->signal;
-    s->signal = 0;
+    sig = gdbserver_state.signal;
+    gdbserver_state.signal = 0;
     return sig;
 }
 
 /* Tell the remote gdb that the process has exited due to SIG.  */
 void gdb_signalled(CPUArchState *env, int sig)
 {
-    GDBState *s;
     char buf[4];
 
-    s = gdbserver_state;
-    if (gdbserver_fd < 0 || s->fd < 0) {
+    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
         return;
     }
 
     snprintf(buf, sizeof(buf), "X%02x", target_signal_to_gdb(sig));
-    put_packet(s, buf);
+    put_packet(&gdbserver_state, buf);
 }
 
 static bool gdb_accept(void)
 {
-    GDBState *s;
     struct sockaddr_in sockaddr;
     socklen_t len;
     int fd;
@@ -3083,15 +3092,13 @@ static bool gdb_accept(void)
         return false;
     }
 
-    s = g_malloc0(sizeof(GDBState));
-    create_default_process(s);
-    s->processes[0].attached = true;
-    s->c_cpu = gdb_first_attached_cpu(s);
-    s->g_cpu = s->c_cpu;
-    s->fd = fd;
+    init_gdbserver_state();
+    create_default_process(&gdbserver_state);
+    gdbserver_state.processes[0].attached = true;
+    gdbserver_state.c_cpu = gdb_first_attached_cpu(&gdbserver_state);
+    gdbserver_state.g_cpu = gdbserver_state.c_cpu;
+    gdbserver_state.fd = fd;
     gdb_has_xml = false;
-
-    gdbserver_state = s;
     return true;
 }
 
@@ -3144,13 +3151,11 @@ int gdbserver_start(int port)
 /* Disable gdb stub for child processes.  */
 void gdbserver_fork(CPUState *cpu)
 {
-    GDBState *s = gdbserver_state;
-
-    if (gdbserver_fd < 0 || s->fd < 0) {
+    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
         return;
     }
-    close(s->fd);
-    s->fd = -1;
+    close(gdbserver_state.fd);
+    gdbserver_state.fd = -1;
     cpu_breakpoint_remove_all(cpu, BP_GDB);
     cpu_watchpoint_remove_all(cpu, BP_GDB);
 }
@@ -3167,7 +3172,7 @@ static void gdb_chr_receive(void *opaque, const uint8_t *buf, int size)
     int i;
 
     for (i = 0; i < size; i++) {
-        gdb_read_byte(gdbserver_state, buf[i]);
+        gdb_read_byte(&gdbserver_state, buf[i]);
     }
 }
 
@@ -3210,13 +3215,13 @@ static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
     const char *p = (const char *)buf;
     int max_sz;
 
-    max_sz = (sizeof(gdbserver_state->last_packet) - 2) / 2;
+    max_sz = (sizeof(gdbserver_state.last_packet) - 2) / 2;
     for (;;) {
         if (len <= max_sz) {
-            gdb_monitor_output(gdbserver_state, p, len);
+            gdb_monitor_output(&gdbserver_state, p, len);
             break;
         }
-        gdb_monitor_output(gdbserver_state, p, max_sz);
+        gdb_monitor_output(&gdbserver_state, p, max_sz);
         p += max_sz;
         len -= max_sz;
     }
@@ -3308,18 +3313,10 @@ static void create_processes(GDBState *s)
     create_default_process(s);
 }
 
-static void cleanup_processes(GDBState *s)
-{
-    g_free(s->processes);
-    s->process_num = 0;
-    s->processes = NULL;
-}
-
 int gdbserver_start(const char *device)
 {
     trace_gdbstub_op_start(device);
 
-    GDBState *s;
     char gdbstub_device_name[128];
     Chardev *chr = NULL;
     Chardev *mon_chr;
@@ -3357,10 +3354,8 @@ int gdbserver_start(const char *device)
             return -1;
     }
 
-    s = gdbserver_state;
-    if (!s) {
-        s = g_malloc0(sizeof(GDBState));
-        gdbserver_state = s;
+    if (!gdbserver_state.init) {
+        init_gdbserver_state();
 
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
 
@@ -3369,31 +3364,30 @@ int gdbserver_start(const char *device)
                                    NULL, NULL, &error_abort);
         monitor_init_hmp(mon_chr, false, &error_abort);
     } else {
-        qemu_chr_fe_deinit(&s->chr, true);
-        mon_chr = s->mon_chr;
-        cleanup_processes(s);
-        memset(s, 0, sizeof(GDBState));
-        s->mon_chr = mon_chr;
+        qemu_chr_fe_deinit(&gdbserver_state.chr, true);
+        mon_chr = gdbserver_state.mon_chr;
+        reset_gdbserver_state();
     }
 
-    create_processes(s);
+    create_processes(&gdbserver_state);
 
     if (chr) {
-        qemu_chr_fe_init(&s->chr, chr, &error_abort);
-        qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive, gdb_chr_receive,
-                                 gdb_chr_event, NULL, s, NULL, true);
+        qemu_chr_fe_init(&gdbserver_state.chr, chr, &error_abort);
+        qemu_chr_fe_set_handlers(&gdbserver_state.chr, gdb_chr_can_receive,
+                                 gdb_chr_receive, gdb_chr_event,
+                                 NULL, &gdbserver_state, NULL, true);
     }
-    s->state = chr ? RS_IDLE : RS_INACTIVE;
-    s->mon_chr = mon_chr;
-    s->current_syscall_cb = NULL;
+    gdbserver_state.state = chr ? RS_IDLE : RS_INACTIVE;
+    gdbserver_state.mon_chr = mon_chr;
+    gdbserver_state.current_syscall_cb = NULL;
 
     return 0;
 }
 
 void gdbserver_cleanup(void)
 {
-    if (gdbserver_state) {
-        put_packet(gdbserver_state, "W00");
+    if (gdbserver_state.init) {
+        put_packet(&gdbserver_state, "W00");
     }
 }
 
-- 
2.20.1


