Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13904C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D293D206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POJtNPv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D293D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIwX-0004zC-2n
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo9-0006Lf-Ah
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo7-00012z-6z
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id y24so2344096wma.4
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=usxqN0chs/+svG7Q89+uOboA+O3BScfxkits4ZbaY44=;
 b=POJtNPv3efthz7dl5Ok8qN9NoLDOYAH5sEvyJa1iHs+ZEaywIM42HrYrK+6dNHrf4R
 xGZghz6KEq33gyAp3xmwjCCfK/aDSj15xcTcJ0fEjvW1MdLT33P3LvQwuZnZA8AUpuFf
 /1iu0o7Z0CPnyEsYqa9UiYEO/++x8ckI1uxf65onWQGih/LSz4fKdqe4giP/mcMcgJM1
 q3EHslFqG17hve4e/cv+4bSp2NsdxMzGK9LstrA174r/gQbGfYiJDdANURKt893/X0lI
 okPmN4bqEZXpMKb2XbnCizS2gu1CxGYRs3SAN/w9K9bsKgxVnViSf+5bcc8c5jsBOZOh
 8lMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=usxqN0chs/+svG7Q89+uOboA+O3BScfxkits4ZbaY44=;
 b=VsBzc4vKXE9GC5jvsC2pyelwGSKH6LSgf5Lilky0qHeuEGIDF50Gu92uLXiaMoi5LE
 dic8JCm3f6h7fxGWomW+TniUdHCq0V61+zofhyRXmb/a4yd7XioD6RUskz9s4Pc2IYrh
 LL0G92Hr8Ubs+M7j6AgbwcLQFZsaPoV2xaCFgq3VXOefT11T28XADhYYPdGU61Y6/civ
 1j2BwwUBXgyoC/oqyv2ujZZXQKSEn3mCh0ZQlkU7fDU4fOvlHebKAo5NGoZmMhVJTbiL
 tvQHP/ExYUYfU8xzbcSB6vz2OmCCOAry/lQBn6qOfcHMMwDusrCL4mPdU2+VldXkFTLI
 0yBg==
X-Gm-Message-State: AGi0PuZaXdCT7gjVvE1EV3E39BVp2VJlhLAHb175i5RJexIfSxgC1q9D
 T1oR2/ySOl8GsJy6ROpg9AZjLg==
X-Google-Smtp-Source: APiQypKuKQ2WvvBAp1PD6GMe3t7G8p+MGB027vrBL635JT2rUcR/4hVBiV9bHko4+8IF256fbSMHqw==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr3946648wmf.119.1588766745661; 
 Wed, 06 May 2020 05:05:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k17sm2683515wmi.10.2020.05.06.05.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ADFEB1FF9A;
 Wed,  6 May 2020 13:05:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 11/14] gdbstub/linux-user: support debugging over a unix socket
Date: Wed,  6 May 2020 13:05:26 +0100
Message-Id: <20200506120529.18974-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While debugging over TCP is fairly straightforward now we have test
cases that want to orchestrate via make and currently a parallel build
fails as two processes can't use the same listening port. While system
emulation offers a wide cornucopia of connection methods thanks to the
chardev abstraction we are a little more limited for linux user.
Thankfully the programming API for a TCP socket and a local UNIX
socket is pretty much the same once it's set up.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200430190122.4592-7-alex.bennee@linaro.org>

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 4a2b8e30893..94d8f83e92d 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -177,11 +177,15 @@ static inline uint8_t * gdb_get_reg_ptr(GByteArray *buf, int len)
 
 #endif
 
-#ifdef CONFIG_USER_ONLY
-int gdbserver_start(int);
-#else
-int gdbserver_start(const char *port);
-#endif
+/**
+ * gdbserver_start: start the gdb server
+ * @port_or_device: connection spec for gdb
+ *
+ * For CONFIG_USER this is either a tcp port or a path to a fifo. For
+ * system emulation you can use a full chardev spec for your gdbserver
+ * port.
+ */
+int gdbserver_start(const char *port_or_device);
 
 void gdbserver_cleanup(void);
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 770c2b267ad..28f122b80e6 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -738,7 +738,7 @@ int main(int argc, char **argv)
     CPUState *cpu;
     int optind;
     const char *r;
-    int gdbstub_port = 0;
+    const char *gdbstub = NULL;
     char **target_environ, **wrk;
     envlist_t *envlist = NULL;
     char *trace_file = NULL;
@@ -814,7 +814,7 @@ int main(int argc, char **argv)
                 exit(1);
             }
         } else if (!strcmp(r, "g")) {
-            gdbstub_port = atoi(argv[optind++]);
+            gdbstub = g_strdup(argv[optind++]);
         } else if (!strcmp(r, "r")) {
             qemu_uname_release = argv[optind++];
         } else if (!strcmp(r, "cpu")) {
@@ -1124,8 +1124,8 @@ int main(int argc, char **argv)
 #error unsupported target CPU
 #endif
 
-    if (gdbstub_port) {
-        gdbserver_start (gdbstub_port);
+    if (gdbstub) {
+        gdbserver_start(gdbstub);
         gdb_handlesig(cpu, 0);
     }
     cpu_loop(env);
diff --git a/gdbstub.c b/gdbstub.c
index b5381aa5204..6950fd243f3 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -355,6 +355,7 @@ typedef struct GDBState {
     int signal;
 #ifdef CONFIG_USER_ONLY
     int fd;
+    char *socket_path;
     int running_state;
 #else
     CharBackend chr;
@@ -2962,6 +2963,9 @@ void gdb_exit(CPUArchState *env, int code)
       return;
   }
 #ifdef CONFIG_USER_ONLY
+  if (gdbserver_state.socket_path) {
+      unlink(gdbserver_state.socket_path);
+  }
   if (gdbserver_state.fd < 0) {
       return;
   }
@@ -3066,7 +3070,66 @@ void gdb_signalled(CPUArchState *env, int sig)
     put_packet(buf);
 }
 
-static bool gdb_accept(int gdb_fd)
+static void gdb_accept_init(int fd)
+{
+    init_gdbserver_state();
+    create_default_process(&gdbserver_state);
+    gdbserver_state.processes[0].attached = true;
+    gdbserver_state.c_cpu = gdb_first_attached_cpu();
+    gdbserver_state.g_cpu = gdbserver_state.c_cpu;
+    gdbserver_state.fd = fd;
+    gdb_has_xml = false;
+}
+
+static bool gdb_accept_socket(int gdb_fd)
+{
+    int fd;
+
+    for(;;) {
+        fd = accept(gdb_fd, NULL, NULL);
+        if (fd < 0 && errno != EINTR) {
+            perror("accept socket");
+            return false;
+        } else if (fd >= 0) {
+            qemu_set_cloexec(fd);
+            break;
+        }
+    }
+
+    gdb_accept_init(fd);
+    return true;
+}
+
+static int gdbserver_open_socket(const char *path)
+{
+    struct sockaddr_un sockaddr;
+    int fd, ret;
+
+    fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    if (fd < 0) {
+        perror("create socket");
+        return -1;
+    }
+
+    sockaddr.sun_family = AF_UNIX;
+    pstrcpy(sockaddr.sun_path, sizeof(sockaddr.sun_path) - 1, path);
+    ret = bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
+    if (ret < 0) {
+        perror("bind socket");
+        close(fd);
+        return -1;
+    }
+    ret = listen(fd, 1);
+    if (ret < 0) {
+        perror("listen socket");
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
+
+static bool gdb_accept_tcp(int gdb_fd)
 {
     struct sockaddr_in sockaddr;
     socklen_t len;
@@ -3091,17 +3154,11 @@ static bool gdb_accept(int gdb_fd)
         return false;
     }
 
-    init_gdbserver_state();
-    create_default_process(&gdbserver_state);
-    gdbserver_state.processes[0].attached = true;
-    gdbserver_state.c_cpu = gdb_first_attached_cpu();
-    gdbserver_state.g_cpu = gdbserver_state.c_cpu;
-    gdbserver_state.fd = fd;
-    gdb_has_xml = false;
+    gdb_accept_init(fd);
     return true;
 }
 
-static int gdbserver_open(int port)
+static int gdbserver_open_port(int port)
 {
     struct sockaddr_in sockaddr;
     int fd, ret;
@@ -3130,21 +3187,35 @@ static int gdbserver_open(int port)
         close(fd);
         return -1;
     }
+
     return fd;
 }
 
-int gdbserver_start(int port)
+int gdbserver_start(const char *port_or_path)
 {
-    int gdb_fd = gdbserver_open(port);
+    int port = g_ascii_strtoull(port_or_path, NULL, 10);
+    int gdb_fd;
+
+    if (port > 0) {
+        gdb_fd = gdbserver_open_port(port);
+    } else {
+        gdb_fd = gdbserver_open_socket(port_or_path);
+    }
+
     if (gdb_fd < 0) {
         return -1;
     }
-    /* accept connections */
-    if (!gdb_accept(gdb_fd)) {
-        close(gdb_fd);
-        return -1;
+
+    if (port > 0 && gdb_accept_tcp(gdb_fd)) {
+        return 0;
+    } else if (gdb_accept_socket(gdb_fd)) {
+        gdbserver_state.socket_path = g_strdup(port_or_path);
+        return 0;
     }
-    return 0;
+
+    /* gone wrong */
+    close(gdb_fd);
+    return -1;
 }
 
 /* Disable gdb stub for child processes.  */
diff --git a/linux-user/main.c b/linux-user/main.c
index 22578b16336..2cd443237d8 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -51,7 +51,7 @@ char *exec_path;
 
 int singlestep;
 static const char *argv0;
-static int gdbstub_port;
+static const char *gdbstub;
 static envlist_t *envlist;
 static const char *cpu_model;
 static const char *cpu_type;
@@ -310,7 +310,7 @@ static void handle_arg_seed(const char *arg)
 
 static void handle_arg_gdb(const char *arg)
 {
-    gdbstub_port = atoi(arg);
+    gdbstub = g_strdup(arg);
 }
 
 static void handle_arg_uname(const char *arg)
@@ -861,10 +861,10 @@ int main(int argc, char **argv, char **envp)
 
     target_cpu_copy_regs(env, regs);
 
-    if (gdbstub_port) {
-        if (gdbserver_start(gdbstub_port) < 0) {
-            fprintf(stderr, "qemu: could not open gdbserver on port %d\n",
-                    gdbstub_port);
+    if (gdbstub) {
+        if (gdbserver_start(gdbstub) < 0) {
+            fprintf(stderr, "qemu: could not open gdbserver on %s\n",
+                    gdbstub);
             exit(EXIT_FAILURE);
         }
         gdb_handlesig(cpu, 0);
-- 
2.20.1


