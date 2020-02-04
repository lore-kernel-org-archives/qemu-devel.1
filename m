Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7C0C33CAC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B0320732
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isniBAbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B0320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyoO2-0005GR-By
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 21:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60975)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <37tw4XgMKCoMqr6nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--jkz.bounces.google.com>)
 id 1iyoMP-0002gg-AD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <37tw4XgMKCoMqr6nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--jkz.bounces.google.com>)
 id 1iyoMK-0003JM-Pe
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:45 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:36662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <37tw4XgMKCoMqr6nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--jkz.bounces.google.com>)
 id 1iyoMK-0003A2-CL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:40 -0500
Received: by mail-pg1-x54a.google.com with SMTP id i8so10716429pgs.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 18:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=GshZiTz5KokTht5yZSDdDHW0lnlWZ9H6cn8rQOUMLNA=;
 b=isniBAbH4pLTororERkEMwLAE1ncv8A9EiDHzSn89OsJ5K7BTJ0hkxjAF6q8CptMwa
 R208J/Bo1t2syWzNyr1nxLJEt/DFP22BAb4eEUb/0pEYQsVJNLPT/C0xWtp5mLxXWu+x
 MT/w8WJDSiLy/pHPurR4dk0OWUwrW67C1WOHJ21BujvDcpD8CM1b9eP3KheO5v11zscM
 WoSKz5+dhX4R/RQVCWJUjKmGZlGCRmR0ZqPII8hNrjpd5Q+enycNfAf3Y1UZpiAx4pgk
 /7gdv8fiJzHfxkOODUlo5dCJOJhahYfDKWky0cjTJ8stquONiEImc5PYvDacsjmYlqoB
 yaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=GshZiTz5KokTht5yZSDdDHW0lnlWZ9H6cn8rQOUMLNA=;
 b=R8jj2E0wIvGhFpwiHBpIk6DvVYLpI2pfdAyZK67i/dLGwdLDdgvy4uunf1ZvpwDXxt
 KtFe3HQP9jTd4vR4JzQel0n/Me9QHkmSlGG1dsmyeu0K0j1IRgF5CDr7h52tFJAAxR7/
 D9UStryFiuTVeFjVH2K1letCokJEo+uhAVkvMkZ9+e0pL0cNIf4k5WuG2b7WEk2Tm6hU
 wpoH03GK7GED8YlXvJPDwe+KOQ7jQ7AODK6VxhFjsmM9vYGXS0qrqMbWLBJ3hmHo5A0P
 vtqQFethGtZWkVyhOei5ZfrZk78Vhs4W7GSEGyfcA0VC6TX54P3FKF5cIgJnRufdasu8
 ypxg==
X-Gm-Message-State: APjAAAW9Pr9BiNilaani6YahJCqwRwLqf/iKcfRfUJLtn7w2rhaZUn8F
 pFWHzSjueh+vHlan18AUa+y5QC5rmGtYa9rwbSwvLLX2wTmUN5sZ6jXdao0jt2lmh7+Wq1OKMcX
 KIEGFHKLvnnSxtKAw7uz8sW7Mo1mvDkcTNbCUhgyqycQT1byV6JbD
X-Google-Smtp-Source: APXvYqwrwR9vusJXO4YrJ9Z0BrFL+euYl54L9Cjn+PedTVj2p1Z4/zy5tnhuQ+YU3s4iM1zV9Ff6R4M=
X-Received: by 2002:a63:34b:: with SMTP id 72mr7404813pgd.278.1580784878919;
 Mon, 03 Feb 2020 18:54:38 -0800 (PST)
Date: Mon,  3 Feb 2020 18:54:14 -0800
In-Reply-To: <20200204025416.111409-1-jkz@google.com>
Message-Id: <20200204025416.111409-3-jkz@google.com>
Mime-Version: 1.0
References: <20200204025416.111409-1-jkz@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 2/4] linux-user: Use `qemu_log' for strace
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, imp@bsdimp.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::54a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change switches linux-user strace logging to use the newer `qemu_log`
logging subsystem rather than the older `gemu_log` (notice the "g")
logger. `qemu_log` has several advantages, namely that it allows logging
to a file, and provides a more unified interface for configuration
of logging (via the QEMU_LOG environment variable or options).

This change introduces a new log mask: `LOG_STRACE` which is used for
logging of user-mode strace messages.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Josh Kunz <jkz@google.com>
---
 include/qemu/log.h   |   2 +
 linux-user/main.c    |  30 ++-
 linux-user/qemu.h    |   1 -
 linux-user/signal.c  |   2 +-
 linux-user/strace.c  | 479 ++++++++++++++++++++++---------------------
 linux-user/syscall.c |  13 +-
 util/log.c           |   2 +
 7 files changed, 278 insertions(+), 251 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index e0f4e40628..f4724f7330 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -62,6 +62,8 @@ static inline bool qemu_log_separate(void)
 #define CPU_LOG_TB_OP_IND  (1 << 16)
 #define CPU_LOG_TB_FPU     (1 << 17)
 #define CPU_LOG_PLUGIN     (1 << 18)
+/* LOG_STRACE is used for user-mode strace logging. */
+#define LOG_STRACE         (1 << 19)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/linux-user/main.c b/linux-user/main.c
index fba833aac9..8f1d07cdd6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -60,6 +60,19 @@ unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
 
+/*
+ * Used to implement backwards-compatibility for the `-strace`, and
+ * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritten by
+ * -strace, or vice versa.
+ */
+static bool enable_strace;
+
+/*
+ * The last log mask given by the user in an environment variable or argument.
+ * Used to support command line arguments overriding environment variables.
+ */
+static int last_log_mask;
+
 /*
  * When running 32-on-64 we should make sure we can fit all of the possible
  * guest address space into a contiguous chunk of virtual host memory.
@@ -223,15 +236,11 @@ static void handle_arg_help(const char *arg)
 
 static void handle_arg_log(const char *arg)
 {
-    int mask;
-
-    mask = qemu_str_to_log_mask(arg);
-    if (!mask) {
+    last_log_mask = qemu_str_to_log_mask(arg);
+    if (!last_log_mask) {
         qemu_print_log_usage(stdout);
         exit(EXIT_FAILURE);
     }
-    qemu_log_needs_buffers();
-    qemu_set_log(mask);
 }
 
 static void handle_arg_dfilter(const char *arg)
@@ -375,7 +384,7 @@ static void handle_arg_singlestep(const char *arg)
 
 static void handle_arg_strace(const char *arg)
 {
-    do_strace = 1;
+    enable_strace = true;
 }
 
 static void handle_arg_version(const char *arg)
@@ -629,6 +638,7 @@ int main(int argc, char **argv, char **envp)
     int i;
     int ret;
     int execfd;
+    int log_mask;
     unsigned long max_reserved_va;
 
     error_init(argv[0]);
@@ -661,6 +671,12 @@ int main(int argc, char **argv, char **envp)
 
     optind = parse_args(argc, argv);
 
+    log_mask = last_log_mask | (enable_strace ? LOG_STRACE : 0);
+    if (log_mask) {
+        qemu_log_needs_buffers();
+        qemu_set_log(log_mask);
+    }
+
     if (!trace_init_backends()) {
         exit(1);
     }
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 560a68090e..2421dc7afd 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -386,7 +386,6 @@ void print_syscall_ret(int num, abi_long arg1);
  * --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=0} ---
  */
 void print_taken_signal(int target_signum, const target_siginfo_t *tinfo);
-extern int do_strace;
 
 /* signal.c */
 void process_pending_signals(CPUArchState *cpu_env);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5ca6d62b15..818d867b7b 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -864,7 +864,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
         handler = sa->_sa_handler;
     }
 
-    if (do_strace) {
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_taken_signal(sig, &k->info);
     }
 
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3d4d684450..4f7130b2ff 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -12,8 +12,6 @@
 #include <sched.h>
 #include "qemu.h"
 
-int do_strace=0;
-
 struct syscallname {
     int nr;
     const char *name;
@@ -80,7 +78,7 @@ print_ipc_cmd(int cmd)
 {
 #define output_cmd(val) \
 if( cmd == val ) { \
-    gemu_log(#val); \
+    qemu_log(#val); \
     return; \
 }
 
@@ -120,7 +118,7 @@ if( cmd == val ) { \
     output_cmd( IPC_RMID );
 
     /* Some value we don't recognize */
-    gemu_log("%d",cmd);
+    qemu_log("%d", cmd);
 }
 
 static void
@@ -151,7 +149,7 @@ print_signal(abi_ulong arg, int last)
         print_raw_param("%ld", arg, last);
         return;
     }
-    gemu_log("%s%s", signal_name, get_comma(last));
+    qemu_log("%s%s", signal_name, get_comma(last));
 }
 
 static void print_si_code(int arg)
@@ -184,10 +182,10 @@ static void print_si_code(int arg)
         codename = "SI_TKILL";
         break;
     default:
-        gemu_log("%d", arg);
+        qemu_log("%d", arg);
         return;
     }
-    gemu_log("%s", codename);
+    qemu_log("%s", codename);
 }
 
 static void get_target_siginfo(target_siginfo_t *tinfo,
@@ -288,33 +286,33 @@ static void print_siginfo(const target_siginfo_t *tinfo)
     int si_type = extract32(tinfo->si_code, 16, 16);
     int si_code = sextract32(tinfo->si_code, 0, 16);
 
-    gemu_log("{si_signo=");
+    qemu_log("{si_signo=");
     print_signal(tinfo->si_signo, 1);
-    gemu_log(", si_code=");
+    qemu_log(", si_code=");
     print_si_code(si_code);
 
     switch (si_type) {
     case QEMU_SI_KILL:
-        gemu_log(", si_pid=%u, si_uid=%u",
+        qemu_log(", si_pid=%u, si_uid=%u",
                  (unsigned int)tinfo->_sifields._kill._pid,
                  (unsigned int)tinfo->_sifields._kill._uid);
         break;
     case QEMU_SI_TIMER:
-        gemu_log(", si_timer1=%u, si_timer2=%u",
+        qemu_log(", si_timer1=%u, si_timer2=%u",
                  tinfo->_sifields._timer._timer1,
                  tinfo->_sifields._timer._timer2);
         break;
     case QEMU_SI_POLL:
-        gemu_log(", si_band=%d, si_fd=%d",
+        qemu_log(", si_band=%d, si_fd=%d",
                  tinfo->_sifields._sigpoll._band,
                  tinfo->_sifields._sigpoll._fd);
         break;
     case QEMU_SI_FAULT:
-        gemu_log(", si_addr=");
+        qemu_log(", si_addr=");
         print_pointer(tinfo->_sifields._sigfault._addr, 1);
         break;
     case QEMU_SI_CHLD:
-        gemu_log(", si_pid=%u, si_uid=%u, si_status=%d"
+        qemu_log(", si_pid=%u, si_uid=%u, si_status=%d"
                  ", si_utime=" TARGET_ABI_FMT_ld
                  ", si_stime=" TARGET_ABI_FMT_ld,
                  (unsigned int)(tinfo->_sifields._sigchld._pid),
@@ -324,7 +322,7 @@ static void print_siginfo(const target_siginfo_t *tinfo)
                  tinfo->_sifields._sigchld._stime);
         break;
     case QEMU_SI_RT:
-        gemu_log(", si_pid=%u, si_uid=%u, si_sigval=" TARGET_ABI_FMT_ld,
+        qemu_log(", si_pid=%u, si_uid=%u, si_sigval=" TARGET_ABI_FMT_ld,
                  (unsigned int)tinfo->_sifields._rt._pid,
                  (unsigned int)tinfo->_sifields._rt._uid,
                  tinfo->_sifields._rt._sigval.sival_ptr);
@@ -332,7 +330,7 @@ static void print_siginfo(const target_siginfo_t *tinfo)
     default:
         g_assert_not_reached();
     }
-    gemu_log("}");
+    qemu_log("}");
 }
 
 static void
@@ -349,76 +347,76 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
         case AF_UNIX: {
             struct target_sockaddr_un *un = (struct target_sockaddr_un *)sa;
             int i;
-            gemu_log("{sun_family=AF_UNIX,sun_path=\"");
+            qemu_log("{sun_family=AF_UNIX,sun_path=\"");
             for (i = 0; i < addrlen -
                             offsetof(struct target_sockaddr_un, sun_path) &&
                  un->sun_path[i]; i++) {
-                gemu_log("%c", un->sun_path[i]);
+                qemu_log("%c", un->sun_path[i]);
             }
-            gemu_log("\"}");
+            qemu_log("\"}");
             break;
         }
         case AF_INET: {
             struct target_sockaddr_in *in = (struct target_sockaddr_in *)sa;
             uint8_t *c = (uint8_t *)&in->sin_addr.s_addr;
-            gemu_log("{sin_family=AF_INET,sin_port=htons(%d),",
+            qemu_log("{sin_family=AF_INET,sin_port=htons(%d),",
                      ntohs(in->sin_port));
-            gemu_log("sin_addr=inet_addr(\"%d.%d.%d.%d\")",
+            qemu_log("sin_addr=inet_addr(\"%d.%d.%d.%d\")",
                      c[0], c[1], c[2], c[3]);
-            gemu_log("}");
+            qemu_log("}");
             break;
         }
         case AF_PACKET: {
             struct target_sockaddr_ll *ll = (struct target_sockaddr_ll *)sa;
             uint8_t *c = (uint8_t *)&ll->sll_addr;
-            gemu_log("{sll_family=AF_PACKET,"
+            qemu_log("{sll_family=AF_PACKET,"
                      "sll_protocol=htons(0x%04x),if%d,pkttype=",
                      ntohs(ll->sll_protocol), ll->sll_ifindex);
             switch (ll->sll_pkttype) {
             case PACKET_HOST:
-                gemu_log("PACKET_HOST");
+                qemu_log("PACKET_HOST");
                 break;
             case PACKET_BROADCAST:
-                gemu_log("PACKET_BROADCAST");
+                qemu_log("PACKET_BROADCAST");
                 break;
             case PACKET_MULTICAST:
-                gemu_log("PACKET_MULTICAST");
+                qemu_log("PACKET_MULTICAST");
                 break;
             case PACKET_OTHERHOST:
-                gemu_log("PACKET_OTHERHOST");
+                qemu_log("PACKET_OTHERHOST");
                 break;
             case PACKET_OUTGOING:
-                gemu_log("PACKET_OUTGOING");
+                qemu_log("PACKET_OUTGOING");
                 break;
             default:
-                gemu_log("%d", ll->sll_pkttype);
+                qemu_log("%d", ll->sll_pkttype);
                 break;
             }
-            gemu_log(",sll_addr=%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
+            qemu_log(",sll_addr=%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
                      c[0], c[1], c[2], c[3], c[4], c[5], c[6], c[7]);
-            gemu_log("}");
+            qemu_log("}");
             break;
         }
         case AF_NETLINK: {
             struct target_sockaddr_nl *nl = (struct target_sockaddr_nl *)sa;
-            gemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
+            qemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
                      tswap32(nl->nl_pid), tswap32(nl->nl_groups));
             break;
         }
         default:
-            gemu_log("{sa_family=%d, sa_data={", sa->sa_family);
+            qemu_log("{sa_family=%d, sa_data={", sa->sa_family);
             for (i = 0; i < 13; i++) {
-                gemu_log("%02x, ", sa->sa_data[i]);
+                qemu_log("%02x, ", sa->sa_data[i]);
             }
-            gemu_log("%02x}", sa->sa_data[i]);
-            gemu_log("}");
+            qemu_log("%02x}", sa->sa_data[i]);
+            qemu_log("}");
             break;
         }
         unlock_user(sa, addr, 0);
     } else {
         print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
     }
-    gemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
+    qemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
 }
 
 static void
@@ -426,19 +424,19 @@ print_socket_domain(int domain)
 {
     switch (domain) {
     case PF_UNIX:
-        gemu_log("PF_UNIX");
+        qemu_log("PF_UNIX");
         break;
     case PF_INET:
-        gemu_log("PF_INET");
+        qemu_log("PF_INET");
         break;
     case PF_NETLINK:
-        gemu_log("PF_NETLINK");
+        qemu_log("PF_NETLINK");
         break;
     case PF_PACKET:
-        gemu_log("PF_PACKET");
+        qemu_log("PF_PACKET");
         break;
     default:
-        gemu_log("%d", domain);
+        qemu_log("%d", domain);
         break;
     }
 }
@@ -448,22 +446,22 @@ print_socket_type(int type)
 {
     switch (type) {
     case TARGET_SOCK_DGRAM:
-        gemu_log("SOCK_DGRAM");
+        qemu_log("SOCK_DGRAM");
         break;
     case TARGET_SOCK_STREAM:
-        gemu_log("SOCK_STREAM");
+        qemu_log("SOCK_STREAM");
         break;
     case TARGET_SOCK_RAW:
-        gemu_log("SOCK_RAW");
+        qemu_log("SOCK_RAW");
         break;
     case TARGET_SOCK_RDM:
-        gemu_log("SOCK_RDM");
+        qemu_log("SOCK_RDM");
         break;
     case TARGET_SOCK_SEQPACKET:
-        gemu_log("SOCK_SEQPACKET");
+        qemu_log("SOCK_SEQPACKET");
         break;
     case TARGET_SOCK_PACKET:
-        gemu_log("SOCK_PACKET");
+        qemu_log("SOCK_PACKET");
         break;
     }
 }
@@ -475,10 +473,10 @@ print_socket_protocol(int domain, int type, int protocol)
         (domain == AF_INET && type == TARGET_SOCK_PACKET)) {
         switch (protocol) {
         case 0x0003:
-            gemu_log("ETH_P_ALL");
+            qemu_log("ETH_P_ALL");
             break;
         default:
-            gemu_log("%d", protocol);
+            qemu_log("%d", protocol);
         }
         return;
     }
@@ -486,25 +484,25 @@ print_socket_protocol(int domain, int type, int protocol)
     if (domain == PF_NETLINK) {
         switch (protocol) {
         case NETLINK_ROUTE:
-            gemu_log("NETLINK_ROUTE");
+            qemu_log("NETLINK_ROUTE");
             break;
         case NETLINK_AUDIT:
-            gemu_log("NETLINK_AUDIT");
+            qemu_log("NETLINK_AUDIT");
             break;
         case NETLINK_NETFILTER:
-            gemu_log("NETLINK_NETFILTER");
+            qemu_log("NETLINK_NETFILTER");
             break;
         case NETLINK_KOBJECT_UEVENT:
-            gemu_log("NETLINK_KOBJECT_UEVENT");
+            qemu_log("NETLINK_KOBJECT_UEVENT");
             break;
         case NETLINK_RDMA:
-            gemu_log("NETLINK_RDMA");
+            qemu_log("NETLINK_RDMA");
             break;
         case NETLINK_CRYPTO:
-            gemu_log("NETLINK_CRYPTO");
+            qemu_log("NETLINK_CRYPTO");
             break;
         default:
-            gemu_log("%d", protocol);
+            qemu_log("%d", protocol);
             break;
         }
         return;
@@ -512,19 +510,19 @@ print_socket_protocol(int domain, int type, int protocol)
 
     switch (protocol) {
     case IPPROTO_IP:
-        gemu_log("IPPROTO_IP");
+        qemu_log("IPPROTO_IP");
         break;
     case IPPROTO_TCP:
-        gemu_log("IPPROTO_TCP");
+        qemu_log("IPPROTO_TCP");
         break;
     case IPPROTO_UDP:
-        gemu_log("IPPROTO_UDP");
+        qemu_log("IPPROTO_UDP");
         break;
     case IPPROTO_RAW:
-        gemu_log("IPPROTO_RAW");
+        qemu_log("IPPROTO_RAW");
         break;
     default:
-        gemu_log("%d", protocol);
+        qemu_log("%d", protocol);
         break;
     }
 }
@@ -536,7 +534,7 @@ print_fdset(int n, abi_ulong target_fds_addr)
 {
     int i;
 
-    gemu_log("[");
+    qemu_log("[");
     if( target_fds_addr ) {
         abi_long *target_fds;
 
@@ -550,11 +548,11 @@ print_fdset(int n, abi_ulong target_fds_addr)
 
         for (i=n; i>=0; i--) {
             if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >> (i & (TARGET_ABI_BITS - 1))) & 1)
-                gemu_log("%d,", i );
+                qemu_log("%d,", i);
             }
         unlock_user(target_fds, target_fds_addr, 0);
     }
-    gemu_log("]");
+    qemu_log("]");
 }
 #endif
 
@@ -578,46 +576,46 @@ print_clockid(int clockid, int last)
 {
     switch (clockid) {
     case TARGET_CLOCK_REALTIME:
-        gemu_log("CLOCK_REALTIME");
+        qemu_log("CLOCK_REALTIME");
         break;
     case TARGET_CLOCK_MONOTONIC:
-        gemu_log("CLOCK_MONOTONIC");
+        qemu_log("CLOCK_MONOTONIC");
         break;
     case TARGET_CLOCK_PROCESS_CPUTIME_ID:
-        gemu_log("CLOCK_PROCESS_CPUTIME_ID");
+        qemu_log("CLOCK_PROCESS_CPUTIME_ID");
         break;
     case TARGET_CLOCK_THREAD_CPUTIME_ID:
-        gemu_log("CLOCK_THREAD_CPUTIME_ID");
+        qemu_log("CLOCK_THREAD_CPUTIME_ID");
         break;
     case TARGET_CLOCK_MONOTONIC_RAW:
-        gemu_log("CLOCK_MONOTONIC_RAW");
+        qemu_log("CLOCK_MONOTONIC_RAW");
         break;
     case TARGET_CLOCK_REALTIME_COARSE:
-        gemu_log("CLOCK_REALTIME_COARSE");
+        qemu_log("CLOCK_REALTIME_COARSE");
         break;
     case TARGET_CLOCK_MONOTONIC_COARSE:
-        gemu_log("CLOCK_MONOTONIC_COARSE");
+        qemu_log("CLOCK_MONOTONIC_COARSE");
         break;
     case TARGET_CLOCK_BOOTTIME:
-        gemu_log("CLOCK_BOOTTIME");
+        qemu_log("CLOCK_BOOTTIME");
         break;
     case TARGET_CLOCK_REALTIME_ALARM:
-        gemu_log("CLOCK_REALTIME_ALARM");
+        qemu_log("CLOCK_REALTIME_ALARM");
         break;
     case TARGET_CLOCK_BOOTTIME_ALARM:
-        gemu_log("CLOCK_BOOTTIME_ALARM");
+        qemu_log("CLOCK_BOOTTIME_ALARM");
         break;
     case TARGET_CLOCK_SGI_CYCLE:
-        gemu_log("CLOCK_SGI_CYCLE");
+        qemu_log("CLOCK_SGI_CYCLE");
         break;
     case TARGET_CLOCK_TAI:
-        gemu_log("CLOCK_TAI");
+        qemu_log("CLOCK_TAI");
         break;
     default:
-        gemu_log("%d", clockid);
+        qemu_log("%d", clockid);
         break;
     }
-    gemu_log("%s", get_comma(last));
+    qemu_log("%s", get_comma(last));
 }
 #endif
 
@@ -638,15 +636,15 @@ print_newselect(const struct syscallname *name,
                 abi_long arg1, abi_long arg2, abi_long arg3,
                 abi_long arg4, abi_long arg5, abi_long arg6)
 {
-    gemu_log("%s(" TARGET_ABI_FMT_ld ",", name->name, arg1);
+    qemu_log("%s(" TARGET_ABI_FMT_ld ",", name->name, arg1);
     print_fdset(arg1, arg2);
-    gemu_log(",");
+    qemu_log(",");
     print_fdset(arg1, arg3);
-    gemu_log(",");
+    qemu_log(",");
     print_fdset(arg1, arg4);
-    gemu_log(",");
+    qemu_log(",");
     print_timeval(arg5, 1);
-    gemu_log(")");
+    qemu_log(")");
 
     /* save for use in the return output function below */
     newselect_arg1=arg1;
@@ -663,9 +661,10 @@ print_semctl(const struct syscallname *name,
              abi_long arg1, abi_long arg2, abi_long arg3,
              abi_long arg4, abi_long arg5, abi_long arg6)
 {
-    gemu_log("%s(" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ",", name->name, arg1, arg2);
+    qemu_log("%s(" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ",",
+             name->name, arg1, arg2);
     print_ipc_cmd(arg3);
-    gemu_log(",0x" TARGET_ABI_FMT_lx ")", arg4);
+    qemu_log(",0x" TARGET_ABI_FMT_lx ")", arg4);
 }
 #endif
 
@@ -679,7 +678,7 @@ print_execve(const struct syscallname *name,
 
     if (!(s = lock_user_string(arg1)))
         return;
-    gemu_log("%s(\"%s\",{", name->name, s);
+    qemu_log("%s(\"%s\",{", name->name, s);
     unlock_user(s, arg1, 0);
 
     for (arg_ptr_addr = arg2; ; arg_ptr_addr += sizeof(abi_ulong)) {
@@ -693,12 +692,12 @@ print_execve(const struct syscallname *name,
         if (!arg_addr)
             break;
         if ((s = lock_user_string(arg_addr))) {
-            gemu_log("\"%s\",", s);
+            qemu_log("\"%s\",", s);
             unlock_user(s, arg_addr, 0);
         }
     }
 
-    gemu_log("NULL})");
+    qemu_log("NULL})");
 }
 
 #ifdef TARGET_NR_ipc
@@ -709,12 +708,18 @@ print_ipc(const struct syscallname *name,
 {
     switch(arg1) {
     case IPCOP_semctl:
-        gemu_log("semctl(" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ",", arg1, arg2);
+        qemu_log("semctl(" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ",",
+                 arg1, arg2);
         print_ipc_cmd(arg3);
-        gemu_log(",0x" TARGET_ABI_FMT_lx ")", arg4);
+        qemu_log(",0x" TARGET_ABI_FMT_lx ")", arg4);
         break;
     default:
-        gemu_log("%s(" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ")",
+        qemu_log(("%s("
+                  TARGET_ABI_FMT_ld ","
+                  TARGET_ABI_FMT_ld ","
+                  TARGET_ABI_FMT_ld ","
+                  TARGET_ABI_FMT_ld
+                  ")"),
                  name->name, arg1, arg2, arg3, arg4);
     }
 }
@@ -733,9 +738,9 @@ print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
         errstr = target_strerror(-ret);
     }
     if (errstr) {
-        gemu_log(" = -1 errno=%d (%s)\n", (int)-ret, errstr);
+        qemu_log(" = -1 errno=%d (%s)\n", (int)-ret, errstr);
     } else {
-        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
+        qemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
     }
 }
 
@@ -743,7 +748,7 @@ print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
 static void
 print_syscall_ret_raw(struct syscallname *name, abi_long ret)
 {
-        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
+        qemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
 }
 #endif
 
@@ -751,15 +756,15 @@ print_syscall_ret_raw(struct syscallname *name, abi_long ret)
 static void
 print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
 {
-    gemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
+    qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
     print_fdset(newselect_arg1,newselect_arg2);
-    gemu_log(",");
+    qemu_log(",");
     print_fdset(newselect_arg1,newselect_arg3);
-    gemu_log(",");
+    qemu_log(",");
     print_fdset(newselect_arg1,newselect_arg4);
-    gemu_log(",");
+    qemu_log(",");
     print_timeval(newselect_arg5, 1);
-    gemu_log(")\n");
+    qemu_log(")\n");
 }
 #endif
 
@@ -775,38 +780,38 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
 {
     const char *errstr = NULL;
 
-    gemu_log(" = ");
+    qemu_log(" = ");
     if (ret < 0) {
-        gemu_log("-1 errno=%d", errno);
+        qemu_log("-1 errno=%d", errno);
         errstr = target_strerror(-ret);
         if (errstr) {
-            gemu_log(" (%s)", errstr);
+            qemu_log(" (%s)", errstr);
         }
     } else {
-        gemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(TARGET_ABI_FMT_ld, ret);
         switch (ret) {
         case TARGET_TIME_OK:
-            gemu_log(" TIME_OK (clock synchronized, no leap second)");
+            qemu_log(" TIME_OK (clock synchronized, no leap second)");
             break;
         case TARGET_TIME_INS:
-            gemu_log(" TIME_INS (insert leap second)");
+            qemu_log(" TIME_INS (insert leap second)");
             break;
         case TARGET_TIME_DEL:
-            gemu_log(" TIME_DEL (delete leap second)");
+            qemu_log(" TIME_DEL (delete leap second)");
             break;
         case TARGET_TIME_OOP:
-            gemu_log(" TIME_OOP (leap second in progress)");
+            qemu_log(" TIME_OOP (leap second in progress)");
             break;
         case TARGET_TIME_WAIT:
-            gemu_log(" TIME_WAIT (leap second has occurred)");
+            qemu_log(" TIME_WAIT (leap second has occurred)");
             break;
         case TARGET_TIME_ERROR:
-            gemu_log(" TIME_ERROR (clock not synchronized)");
+            qemu_log(" TIME_ERROR (clock not synchronized)");
             break;
         }
     }
 
-    gemu_log("\n");
+    qemu_log("\n");
 }
 
 UNUSED static struct flags access_flags[] = {
@@ -1104,12 +1109,12 @@ print_flags(const struct flags *f, abi_long flags, int last)
     int n;
 
     if ((flags == 0) && (f->f_value == 0)) {
-        gemu_log("%s%s", f->f_string, get_comma(last));
+        qemu_log("%s%s", f->f_string, get_comma(last));
         return;
     }
     for (n = 0; f->f_string != NULL; f++) {
         if ((f->f_value != 0) && ((flags & f->f_value) == f->f_value)) {
-            gemu_log("%s%s", sep, f->f_string);
+            qemu_log("%s%s", sep, f->f_string);
             flags &= ~f->f_value;
             sep = "|";
             n++;
@@ -1119,13 +1124,13 @@ print_flags(const struct flags *f, abi_long flags, int last)
     if (n > 0) {
         /* print rest of the flags as numeric */
         if (flags != 0) {
-            gemu_log("%s%#x%s", sep, (unsigned int)flags, get_comma(last));
+            qemu_log("%s%#x%s", sep, (unsigned int)flags, get_comma(last));
         } else {
-            gemu_log("%s", get_comma(last));
+            qemu_log("%s", get_comma(last));
         }
     } else {
         /* no string version of flags found, print them in hex then */
-        gemu_log("%#x%s", (unsigned int)flags, get_comma(last));
+        qemu_log("%#x%s", (unsigned int)flags, get_comma(last));
     }
 }
 
@@ -1134,11 +1139,11 @@ print_at_dirfd(abi_long dirfd, int last)
 {
 #ifdef AT_FDCWD
     if (dirfd == AT_FDCWD) {
-        gemu_log("AT_FDCWD%s", get_comma(last));
+        qemu_log("AT_FDCWD%s", get_comma(last));
         return;
     }
 #endif
-    gemu_log("%d%s", (int)dirfd, get_comma(last));
+    qemu_log("%d%s", (int)dirfd, get_comma(last));
 }
 
 static void
@@ -1149,7 +1154,7 @@ print_file_mode(abi_long mode, int last)
 
     for (m = &mode_flags[0]; m->f_string != NULL; m++) {
         if ((m->f_value & mode) == m->f_value) {
-            gemu_log("%s%s", m->f_string, sep);
+            qemu_log("%s%s", m->f_string, sep);
             sep = "|";
             mode &= ~m->f_value;
             break;
@@ -1159,9 +1164,9 @@ print_file_mode(abi_long mode, int last)
     mode &= ~S_IFMT;
     /* print rest of the mode as octal */
     if (mode != 0)
-        gemu_log("%s%#o", sep, (unsigned int)mode);
+        qemu_log("%s%#o", sep, (unsigned int)mode);
 
-    gemu_log("%s", get_comma(last));
+    qemu_log("%s", get_comma(last));
 }
 
 static void
@@ -1170,17 +1175,17 @@ print_open_flags(abi_long flags, int last)
     print_flags(open_access_flags, flags & TARGET_O_ACCMODE, 1);
     flags &= ~TARGET_O_ACCMODE;
     if (flags == 0) {
-        gemu_log("%s", get_comma(last));
+        qemu_log("%s", get_comma(last));
         return;
     }
-    gemu_log("|");
+    qemu_log("|");
     print_flags(open_flags, flags, last);
 }
 
 static void
 print_syscall_prologue(const struct syscallname *sc)
 {
-    gemu_log("%s(", sc->name);
+    qemu_log("%s(", sc->name);
 }
 
 /*ARGSUSED*/
@@ -1188,7 +1193,7 @@ static void
 print_syscall_epilogue(const struct syscallname *sc)
 {
     (void)sc;
-    gemu_log(")");
+    qemu_log(")");
 }
 
 static void
@@ -1197,7 +1202,7 @@ print_string(abi_long addr, int last)
     char *s;
 
     if ((s = lock_user_string(addr)) != NULL) {
-        gemu_log("\"%s\"%s", s, get_comma(last));
+        qemu_log("\"%s\"%s", s, get_comma(last));
         unlock_user(s, addr, 0);
     } else {
         /* can't get string out of it, so print it as pointer */
@@ -1214,20 +1219,20 @@ print_buf(abi_long addr, abi_long len, int last)
 
     s = lock_user(VERIFY_READ, addr, len, 1);
     if (s) {
-        gemu_log("\"");
+        qemu_log("\"");
         for (i = 0; i < MAX_PRINT_BUF && i < len; i++) {
             if (isprint(s[i])) {
-                gemu_log("%c", s[i]);
+                qemu_log("%c", s[i]);
             } else {
-                gemu_log("\\%o", s[i]);
+                qemu_log("\\%o", s[i]);
             }
         }
-        gemu_log("\"");
+        qemu_log("\"");
         if (i != len) {
-            gemu_log("...");
+            qemu_log("...");
         }
         if (!last) {
-            gemu_log(",");
+            qemu_log(",");
         }
         unlock_user(s, addr, 0);
     } else {
@@ -1245,16 +1250,16 @@ print_raw_param(const char *fmt, abi_long param, int last)
     char format[64];
 
     (void) snprintf(format, sizeof (format), "%s%s", fmt, get_comma(last));
-    gemu_log(format, param);
+    qemu_log(format, param);
 }
 
 static void
 print_pointer(abi_long p, int last)
 {
     if (p == 0)
-        gemu_log("NULL%s", get_comma(last));
+        qemu_log("NULL%s", get_comma(last));
     else
-        gemu_log("0x" TARGET_ABI_FMT_lx "%s", p, get_comma(last));
+        qemu_log("0x" TARGET_ABI_FMT_lx "%s", p, get_comma(last));
 }
 
 /*
@@ -1265,12 +1270,12 @@ static void
 print_number(abi_long addr, int last)
 {
     if (addr == 0) {
-        gemu_log("NULL%s", get_comma(last));
+        qemu_log("NULL%s", get_comma(last));
     } else {
         int num;
 
         get_user_s32(num, addr);
-        gemu_log("[%d]%s", num, get_comma(last));
+        qemu_log("[%d]%s", num, get_comma(last));
     }
 }
 
@@ -1285,11 +1290,11 @@ print_timeval(abi_ulong tv_addr, int last)
             print_pointer(tv_addr, last);
             return;
         }
-        gemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
+        qemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
             tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
         unlock_user(tv, tv_addr, 0);
     } else
-        gemu_log("NULL%s", get_comma(last));
+        qemu_log("NULL%s", get_comma(last));
 }
 
 static void
@@ -1303,11 +1308,11 @@ print_timezone(abi_ulong tz_addr, int last)
             print_pointer(tz_addr, last);
             return;
         }
-        gemu_log("{%d,%d}%s", tswap32(tz->tz_minuteswest),
+        qemu_log("{%d,%d}%s", tswap32(tz->tz_minuteswest),
                  tswap32(tz->tz_dsttime), get_comma(last));
         unlock_user(tz, tz_addr, 0);
     } else {
-        gemu_log("NULL%s", get_comma(last));
+        qemu_log("NULL%s", get_comma(last));
     }
 }
 
@@ -1515,83 +1520,83 @@ print_fcntl(const struct syscallname *name,
     print_raw_param("%d", arg0, 0);
     switch(arg1) {
     case TARGET_F_DUPFD:
-        gemu_log("F_DUPFD,");
+        qemu_log("F_DUPFD,");
         print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
         break;
     case TARGET_F_GETFD:
-        gemu_log("F_GETFD");
+        qemu_log("F_GETFD");
         break;
     case TARGET_F_SETFD:
-        gemu_log("F_SETFD,");
+        qemu_log("F_SETFD,");
         print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
         break;
     case TARGET_F_GETFL:
-        gemu_log("F_GETFL");
+        qemu_log("F_GETFL");
         break;
     case TARGET_F_SETFL:
-        gemu_log("F_SETFL,");
+        qemu_log("F_SETFL,");
         print_open_flags(arg2, 1);
         break;
     case TARGET_F_GETLK:
-        gemu_log("F_GETLK,");
+        qemu_log("F_GETLK,");
         print_pointer(arg2, 1);
         break;
     case TARGET_F_SETLK:
-        gemu_log("F_SETLK,");
+        qemu_log("F_SETLK,");
         print_pointer(arg2, 1);
         break;
     case TARGET_F_SETLKW:
-        gemu_log("F_SETLKW,");
+        qemu_log("F_SETLKW,");
         print_pointer(arg2, 1);
         break;
     case TARGET_F_GETOWN:
-        gemu_log("F_GETOWN");
+        qemu_log("F_GETOWN");
         break;
     case TARGET_F_SETOWN:
-        gemu_log("F_SETOWN,");
+        qemu_log("F_SETOWN,");
         print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
         break;
     case TARGET_F_GETSIG:
-        gemu_log("F_GETSIG");
+        qemu_log("F_GETSIG");
         break;
     case TARGET_F_SETSIG:
-        gemu_log("F_SETSIG,");
+        qemu_log("F_SETSIG,");
         print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
         break;
 #if TARGET_ABI_BITS == 32
     case TARGET_F_GETLK64:
-        gemu_log("F_GETLK64,");
+        qemu_log("F_GETLK64,");
         print_pointer(arg2, 1);
         break;
     case TARGET_F_SETLK64:
-        gemu_log("F_SETLK64,");
+        qemu_log("F_SETLK64,");
         print_pointer(arg2, 1);
         break;
     case TARGET_F_SETLKW64:
-        gemu_log("F_SETLKW64,");
+        qemu_log("F_SETLKW64,");
         print_pointer(arg2, 1);
         break;
 #endif
     case TARGET_F_SETLEASE:
-        gemu_log("F_SETLEASE,");
+        qemu_log("F_SETLEASE,");
         print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
         break;
     case TARGET_F_GETLEASE:
-        gemu_log("F_GETLEASE");
+        qemu_log("F_GETLEASE");
         break;
     case TARGET_F_SETPIPE_SZ:
-        gemu_log("F_SETPIPE_SZ,");
+        qemu_log("F_SETPIPE_SZ,");
         print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
         break;
     case TARGET_F_GETPIPE_SZ:
-        gemu_log("F_GETPIPE_SZ");
+        qemu_log("F_GETPIPE_SZ");
         break;
     case TARGET_F_DUPFD_CLOEXEC:
-        gemu_log("F_DUPFD_CLOEXEC,");
+        qemu_log("F_DUPFD_CLOEXEC,");
         print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
         break;
     case TARGET_F_NOTIFY:
-        gemu_log("F_NOTIFY,");
+        qemu_log("F_NOTIFY,");
         print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
         break;
     default:
@@ -1679,7 +1684,7 @@ print__llseek(const struct syscallname *name,
     case SEEK_CUR: whence = "SEEK_CUR"; break;
     case SEEK_END: whence = "SEEK_END"; break;
     }
-    gemu_log("%s",whence);
+    qemu_log("%s", whence);
     print_syscall_epilogue(name);
 }
 #endif
@@ -1694,9 +1699,9 @@ print_socket(const struct syscallname *name,
 
     print_syscall_prologue(name);
     print_socket_domain(domain);
-    gemu_log(",");
+    qemu_log(",");
     print_socket_type(type);
-    gemu_log(",");
+    qemu_log(",");
     if (domain == AF_PACKET ||
         (domain == AF_INET && type == TARGET_SOCK_PACKET)) {
         protocol = tswap16(protocol);
@@ -1728,17 +1733,17 @@ static void do_print_socket(const char *name, abi_long arg1)
     get_user_ualx(domain, arg1, 0);
     get_user_ualx(type, arg1, 1);
     get_user_ualx(protocol, arg1, 2);
-    gemu_log("%s(", name);
+    qemu_log("%s(", name);
     print_socket_domain(domain);
-    gemu_log(",");
+    qemu_log(",");
     print_socket_type(type);
-    gemu_log(",");
+    qemu_log(",");
     if (domain == AF_PACKET ||
         (domain == AF_INET && type == TARGET_SOCK_PACKET)) {
         protocol = tswap16(protocol);
     }
     print_socket_protocol(domain, type, protocol);
-    gemu_log(")");
+    qemu_log(")");
 }
 
 static void do_print_sockaddr(const char *name, abi_long arg1)
@@ -1749,10 +1754,10 @@ static void do_print_sockaddr(const char *name, abi_long arg1)
     get_user_ualx(addr, arg1, 1);
     get_user_ualx(addrlen, arg1, 2);
 
-    gemu_log("%s(", name);
+    qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
     print_sockaddr(addr, addrlen, 0);
-    gemu_log(")");
+    qemu_log(")");
 }
 
 static void do_print_listen(const char *name, abi_long arg1)
@@ -1762,10 +1767,10 @@ static void do_print_listen(const char *name, abi_long arg1)
     get_user_ualx(sockfd, arg1, 0);
     get_user_ualx(backlog, arg1, 1);
 
-    gemu_log("%s(", name);
+    qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
     print_raw_param(TARGET_ABI_FMT_ld, backlog, 1);
-    gemu_log(")");
+    qemu_log(")");
 }
 
 static void do_print_socketpair(const char *name, abi_long arg1)
@@ -1777,15 +1782,15 @@ static void do_print_socketpair(const char *name, abi_long arg1)
     get_user_ualx(protocol, arg1, 2);
     get_user_ualx(tab, arg1, 3);
 
-    gemu_log("%s(", name);
+    qemu_log("%s(", name);
     print_socket_domain(domain);
-    gemu_log(",");
+    qemu_log(",");
     print_socket_type(type);
-    gemu_log(",");
+    qemu_log(",");
     print_socket_protocol(domain, type, protocol);
-    gemu_log(",");
+    qemu_log(",");
     print_raw_param(TARGET_ABI_FMT_lx, tab, 1);
-    gemu_log(")");
+    qemu_log(")");
 }
 
 static void do_print_sendrecv(const char *name, abi_long arg1)
@@ -1797,12 +1802,12 @@ static void do_print_sendrecv(const char *name, abi_long arg1)
     get_user_ualx(len, arg1, 2);
     get_user_ualx(flags, arg1, 3);
 
-    gemu_log("%s(", name);
+    qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 1);
-    gemu_log(")");
+    qemu_log(")");
 }
 
 static void do_print_msgaddr(const char *name, abi_long arg1)
@@ -1816,13 +1821,13 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
     get_user_ualx(addr, arg1, 4);
     get_user_ualx(addrlen, arg1, 5);
 
-    gemu_log("%s(", name);
+    qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 0);
     print_sockaddr(addr, addrlen, 0);
-    gemu_log(")");
+    qemu_log(")");
 }
 
 static void do_print_shutdown(const char *name, abi_long arg1)
@@ -1832,23 +1837,23 @@ static void do_print_shutdown(const char *name, abi_long arg1)
     get_user_ualx(sockfd, arg1, 0);
     get_user_ualx(how, arg1, 1);
 
-    gemu_log("shutdown(");
+    qemu_log("shutdown(");
     print_sockfd(sockfd, 0);
     switch (how) {
     case SHUT_RD:
-        gemu_log("SHUT_RD");
+        qemu_log("SHUT_RD");
         break;
     case SHUT_WR:
-        gemu_log("SHUT_WR");
+        qemu_log("SHUT_WR");
         break;
     case SHUT_RDWR:
-        gemu_log("SHUT_RDWR");
+        qemu_log("SHUT_RDWR");
         break;
     default:
         print_raw_param(TARGET_ABI_FMT_ld, how, 1);
         break;
     }
-    gemu_log(")");
+    qemu_log(")");
 }
 
 static void do_print_msg(const char *name, abi_long arg1)
@@ -1859,11 +1864,11 @@ static void do_print_msg(const char *name, abi_long arg1)
     get_user_ualx(msg, arg1, 1);
     get_user_ualx(flags, arg1, 2);
 
-    gemu_log("%s(", name);
+    qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
     print_pointer(msg, 0);
     print_flags(msg_flags, flags, 1);
-    gemu_log(")");
+    qemu_log(")");
 }
 
 static void do_print_sockopt(const char *name, abi_long arg1)
@@ -1876,113 +1881,113 @@ static void do_print_sockopt(const char *name, abi_long arg1)
     get_user_ualx(optval, arg1, 3);
     get_user_ualx(optlen, arg1, 4);
 
-    gemu_log("%s(", name);
+    qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
     switch (level) {
     case SOL_TCP:
-        gemu_log("SOL_TCP,");
+        qemu_log("SOL_TCP,");
         print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
         print_pointer(optval, 0);
         break;
     case SOL_IP:
-        gemu_log("SOL_IP,");
+        qemu_log("SOL_IP,");
         print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
         print_pointer(optval, 0);
         break;
     case SOL_RAW:
-        gemu_log("SOL_RAW,");
+        qemu_log("SOL_RAW,");
         print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
         print_pointer(optval, 0);
         break;
     case TARGET_SOL_SOCKET:
-        gemu_log("SOL_SOCKET,");
+        qemu_log("SOL_SOCKET,");
         switch (optname) {
         case TARGET_SO_DEBUG:
-            gemu_log("SO_DEBUG,");
+            qemu_log("SO_DEBUG,");
 print_optint:
             print_number(optval, 0);
             break;
         case TARGET_SO_REUSEADDR:
-            gemu_log("SO_REUSEADDR,");
+            qemu_log("SO_REUSEADDR,");
             goto print_optint;
         case TARGET_SO_REUSEPORT:
-            gemu_log("SO_REUSEPORT,");
+            qemu_log("SO_REUSEPORT,");
             goto print_optint;
         case TARGET_SO_TYPE:
-            gemu_log("SO_TYPE,");
+            qemu_log("SO_TYPE,");
             goto print_optint;
         case TARGET_SO_ERROR:
-            gemu_log("SO_ERROR,");
+            qemu_log("SO_ERROR,");
             goto print_optint;
         case TARGET_SO_DONTROUTE:
-            gemu_log("SO_DONTROUTE,");
+            qemu_log("SO_DONTROUTE,");
             goto print_optint;
         case TARGET_SO_BROADCAST:
-            gemu_log("SO_BROADCAST,");
+            qemu_log("SO_BROADCAST,");
             goto print_optint;
         case TARGET_SO_SNDBUF:
-            gemu_log("SO_SNDBUF,");
+            qemu_log("SO_SNDBUF,");
             goto print_optint;
         case TARGET_SO_RCVBUF:
-            gemu_log("SO_RCVBUF,");
+            qemu_log("SO_RCVBUF,");
             goto print_optint;
         case TARGET_SO_KEEPALIVE:
-            gemu_log("SO_KEEPALIVE,");
+            qemu_log("SO_KEEPALIVE,");
             goto print_optint;
         case TARGET_SO_OOBINLINE:
-            gemu_log("SO_OOBINLINE,");
+            qemu_log("SO_OOBINLINE,");
             goto print_optint;
         case TARGET_SO_NO_CHECK:
-            gemu_log("SO_NO_CHECK,");
+            qemu_log("SO_NO_CHECK,");
             goto print_optint;
         case TARGET_SO_PRIORITY:
-            gemu_log("SO_PRIORITY,");
+            qemu_log("SO_PRIORITY,");
             goto print_optint;
         case TARGET_SO_BSDCOMPAT:
-            gemu_log("SO_BSDCOMPAT,");
+            qemu_log("SO_BSDCOMPAT,");
             goto print_optint;
         case TARGET_SO_PASSCRED:
-            gemu_log("SO_PASSCRED,");
+            qemu_log("SO_PASSCRED,");
             goto print_optint;
         case TARGET_SO_TIMESTAMP:
-            gemu_log("SO_TIMESTAMP,");
+            qemu_log("SO_TIMESTAMP,");
             goto print_optint;
         case TARGET_SO_RCVLOWAT:
-            gemu_log("SO_RCVLOWAT,");
+            qemu_log("SO_RCVLOWAT,");
             goto print_optint;
         case TARGET_SO_RCVTIMEO:
-            gemu_log("SO_RCVTIMEO,");
+            qemu_log("SO_RCVTIMEO,");
             print_timeval(optval, 0);
             break;
         case TARGET_SO_SNDTIMEO:
-            gemu_log("SO_SNDTIMEO,");
+            qemu_log("SO_SNDTIMEO,");
             print_timeval(optval, 0);
             break;
         case TARGET_SO_ATTACH_FILTER: {
             struct target_sock_fprog *fprog;
 
-            gemu_log("SO_ATTACH_FILTER,");
+            qemu_log("SO_ATTACH_FILTER,");
 
             if (lock_user_struct(VERIFY_READ, fprog, optval,  0)) {
                 struct target_sock_filter *filter;
-                gemu_log("{");
+                qemu_log("{");
                 if (lock_user_struct(VERIFY_READ, filter,
                                      tswapal(fprog->filter),  0)) {
                     int i;
                     for (i = 0; i < tswap16(fprog->len) - 1; i++) {
-                        gemu_log("[%d]{0x%x,%d,%d,0x%x},",
+                        qemu_log("[%d]{0x%x,%d,%d,0x%x},",
                                  i, tswap16(filter[i].code),
                                  filter[i].jt, filter[i].jf,
                                  tswap32(filter[i].k));
                     }
-                    gemu_log("[%d]{0x%x,%d,%d,0x%x}",
+                    qemu_log("[%d]{0x%x,%d,%d,0x%x}",
                              i, tswap16(filter[i].code),
                              filter[i].jt, filter[i].jf,
                              tswap32(filter[i].k));
                 } else {
-                    gemu_log(TARGET_ABI_FMT_lx, tswapal(fprog->filter));
+                    qemu_log(TARGET_ABI_FMT_lx, tswapal(fprog->filter));
                 }
-                gemu_log(",%d},", tswap16(fprog->len));
+                qemu_log(",%d},", tswap16(fprog->len));
                 unlock_user(fprog, optval, 0);
             } else {
                 print_pointer(optval, 0);
@@ -2002,7 +2007,7 @@ print_optint:
         break;
     }
     print_raw_param(TARGET_ABI_FMT_ld, optlen, 1);
-    gemu_log(")");
+    qemu_log(")");
 }
 
 #define PRINT_SOCKOP(name, func) \
@@ -2164,7 +2169,7 @@ print_rt_sigprocmask(const struct syscallname *name,
     case TARGET_SIG_UNBLOCK: how = "SIG_UNBLOCK"; break;
     case TARGET_SIG_SETMASK: how = "SIG_SETMASK"; break;
     }
-    gemu_log("%s,",how);
+    qemu_log("%s,", how);
     print_pointer(arg1, 0);
     print_pointer(arg2, 1);
     print_syscall_epilogue(name);
@@ -2278,7 +2283,7 @@ print_syslog_action(abi_ulong arg, int last)
             return;
         }
     }
-    gemu_log("%s%s", type, get_comma(last));
+    qemu_log("%s%s", type, get_comma(last));
 }
 
 static void
@@ -2683,20 +2688,20 @@ static void print_futex_op(abi_long tflag, int last)
 {
 #define print_op(val) \
 if( cmd == val ) { \
-    gemu_log(#val); \
+    qemu_log(#val); \
     return; \
 }
 
     int cmd = (int)tflag;
 #ifdef FUTEX_PRIVATE_FLAG
     if (cmd & FUTEX_PRIVATE_FLAG) {
-        gemu_log("FUTEX_PRIVATE_FLAG|");
+        qemu_log("FUTEX_PRIVATE_FLAG|");
         cmd &= ~FUTEX_PRIVATE_FLAG;
     }
 #endif
 #ifdef FUTEX_CLOCK_REALTIME
     if (cmd & FUTEX_CLOCK_REALTIME) {
-        gemu_log("FUTEX_CLOCK_REALTIME|");
+        qemu_log("FUTEX_CLOCK_REALTIME|");
         cmd &= ~FUTEX_CLOCK_REALTIME;
     }
 #endif
@@ -2716,7 +2721,7 @@ if( cmd == val ) { \
     print_op(FUTEX_WAKE_BITSET)
 #endif
     /* unknown values */
-    gemu_log("%d",cmd);
+    qemu_log("%d", cmd);
 }
 
 static void
@@ -2812,22 +2817,24 @@ print_syscall(int num,
     int i;
     const char *format="%s(" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ")";
 
-    gemu_log("%d ", getpid() );
+    qemu_log("%d ", getpid());
 
     for(i=0;i<nsyscalls;i++)
         if( scnames[i].nr == num ) {
             if( scnames[i].call != NULL ) {
-                scnames[i].call(&scnames[i],arg1,arg2,arg3,arg4,arg5,arg6);
+                scnames[i].call(
+                    &scnames[i], arg1, arg2, arg3, arg4, arg5, arg6);
             } else {
                 /* XXX: this format system is broken because it uses
                    host types and host pointers for strings */
                 if( scnames[i].format != NULL )
                     format = scnames[i].format;
-                gemu_log(format,scnames[i].name, arg1,arg2,arg3,arg4,arg5,arg6);
+                qemu_log(format,
+                         scnames[i].name, arg1, arg2, arg3, arg4, arg5, arg6);
             }
             return;
         }
-    gemu_log("Unknown syscall %d\n", num);
+    qemu_log("Unknown syscall %d\n", num);
 }
 
 
@@ -2840,16 +2847,16 @@ print_syscall_ret(int num, abi_long ret)
     for(i=0;i<nsyscalls;i++)
         if( scnames[i].nr == num ) {
             if( scnames[i].result != NULL ) {
-                scnames[i].result(&scnames[i],ret);
+                scnames[i].result(&scnames[i], ret);
             } else {
                 if (ret < 0) {
                     errstr = target_strerror(-ret);
                 }
                 if (errstr) {
-                    gemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n",
+                    qemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n",
                              -ret, errstr);
                 } else {
-                    gemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
+                    qemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
                 }
             }
             break;
@@ -2861,9 +2868,9 @@ void print_taken_signal(int target_signum, const target_siginfo_t *tinfo)
     /* Print the strace output for a signal being taken:
      * --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=0} ---
      */
-    gemu_log("--- ");
+    qemu_log("--- ");
     print_signal(target_signum, 1);
-    gemu_log(" ");
+    qemu_log(" ");
     print_siginfo(tinfo);
-    gemu_log(" ---\n");
+    qemu_log(" ---\n");
 }
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c48c2a9a55..c78322bf83 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12110,14 +12110,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
-    if (unlikely(do_strace)) {
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
-        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                          arg5, arg6, arg7, arg8);
+    }
+
+    ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
+                      arg5, arg6, arg7, arg8);
+
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_syscall_ret(num, ret);
-    } else {
-        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                          arg5, arg6, arg7, arg8);
     }
 
     record_syscall_return(cpu, num, ret);
diff --git a/util/log.c b/util/log.c
index 47f2827397..2da6cb31dc 100644
--- a/util/log.c
+++ b/util/log.c
@@ -332,6 +332,8 @@ const QEMULogItem qemu_log_items[] = {
 #ifdef CONFIG_PLUGIN
     { CPU_LOG_PLUGIN, "plugin", "output from TCG plugins\n"},
 #endif
+    { LOG_STRACE, "strace",
+      "log every user-mode syscall, its input, and its result" },
     { 0, NULL, NULL },
 };
 
-- 
2.25.0.341.g760bfbb309-goog


