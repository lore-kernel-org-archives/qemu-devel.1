Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37105C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A3F20449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fp+vjFA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A3F20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53753 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTEk-0006kB-3q
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:20:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZe-0003ej-TX
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZd-0004Pc-D0
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZd-0004JI-22
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id d21so5723921plr.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=eI/OxnXRIKB57lBoz21sGaC914M6dhfbjsRtukHRXg0=;
	b=Fp+vjFA70/upaz/6v2na2w+I8bC7wlOghToH3FGqz/d874uotH+AiOsNFA4+tHKtFV
	eoe5hEx4sHdWvma1nP8tbhUYVqb39Biyr/xVPd8NKBRXUb1Tw6EdV+AxPY4EPfTgVNYC
	1mswB1X1rarKbQ9VLXR/0LW00Qfj1zVL95a0taHxPxAdzw3fHQxpIyhRFYPLzLD1cViq
	fp8MT9/W4cCReJbMkM47GB67FNYJemeG2v4Gu3mRehMlReFVqQa/aS2MEGBop/ONpGDl
	PCHhXn8lNClJqPKP7hzoE4/JUEP9dpGZ5/4EZZo+P31q35Hm5JZqyJbpCVj6Q/yXCXmg
	9dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=eI/OxnXRIKB57lBoz21sGaC914M6dhfbjsRtukHRXg0=;
	b=d/Ho9aQNRJDA2RIAw/r/T/Swj0yWslp7FgGh7eIYy+/HfOpXadOvuVJ+2MhU2sStzO
	u37KBERPdW1a5/mFhuso9jFm5Cmok7z7a+2Y11qnP1VAcXel4Of8tKDGG7zrzohexs+s
	toBr07Ld28lGl03uUoRkWzCx/ZRAxBLEoTiUYtA4+24UWvL+Ky3nTXINHvObCgw5WsYL
	T2+ZtnR6Ihbn4c4uQr6haHErJJ0iF3AU8RUyo9zwo5xXcYWlXXxvLIG+QphogE9kMdwb
	LSsoTPxCrZNmIlLsob5J5yVTUJgm3DMA9qRAb/Z2zI9HLFTTbdoAo4mtVYchodhag8nj
	EfIA==
X-Gm-Message-State: APjAAAXMxs8dqnf/hB2vgY5hluW31Twko5RZ3Lw+mTAVu2pwTK7Wjq9b
	YPRhOz81r7MvwQdhvN7ZDW/GUg5bz2s=
X-Google-Smtp-Source: APXvYqyH0Rzkf0arwYbT++2UD+Lh02d7Qh6Q9FA/O4Hx4aS4jyrNWxsTTqXdwOUeTvlSHbKqpKA/0A==
X-Received: by 2002:a17:902:9691:: with SMTP id
	n17mr9590191plp.283.1558298299282; 
	Sun, 19 May 2019 13:38:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:51 -0700
Message-Id: <20190519203726.20729-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v7 39/74] linux-user: Split out kill
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
 linux-user/syscall-defs.h    |  1 +
 linux-user/syscall.h         |  7 +++-
 linux-user/strace.c          | 76 ++++++++++++++++++------------------
 linux-user/syscall-sig.inc.c |  5 +++
 linux-user/syscall.c         |  2 -
 linux-user/strace.list       |  3 --
 6 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 497fbdba66..c672b5ad99 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -58,6 +58,7 @@ SYSCALL_DEF(getxpid);
 #ifdef TARGET_NR_ipc
 SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 #endif
+SYSCALL_DEF(kill, ARG_DEC, ARG_SIGNAL);
 #ifdef TARGET_NR_link
 SYSCALL_DEF(link, ARG_STR, ARG_STR);
 #endif
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 84a52b2d9a..642fb6dccb 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -55,8 +55,12 @@ typedef enum {
     ARG_HEX,
     ARG_OCT,
 
-    /* These print as sets of flags.  */
+    /* These numbers are interpreted.  */
     ARG_ATDIRFD,
+    ARG_SIGNAL,
+    ARG_LSEEKWHENCE,
+
+    /* These print as sets of flags.  */
     ARG_ACCESSFLAG,
     ARG_ATFLAG,
     ARG_CLONEFLAG,
@@ -67,7 +71,6 @@ typedef enum {
     ARG_OPENFLAG,
     ARG_UMOUNTFLAG,
     ARG_UNLINKATFLAG,
-    ARG_LSEEKWHENCE,
 
     /* These are interpreted as pointers.  */
     ARG_PTR,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index c42abc2f08..01a5c210fa 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -70,35 +70,43 @@ UNUSED static void print_socket_protocol(int domain, int type, int protocol);
 /*
  * Utility functions
  */
+static int
+add_signal(char *buf, int size, int sig)
+{
+    static const char * const signals[] = {
+        [TARGET_SIGHUP]  = "SIGHUP",
+        [TARGET_SIGINT]  = "SIGINT",
+        [TARGET_SIGQUIT] = "SIGQUIT",
+        [TARGET_SIGILL]  = "SIGILL",
+        [TARGET_SIGABRT] = "SIGABRT",
+        [TARGET_SIGFPE]  = "SIGFPE",
+        [TARGET_SIGKILL] = "SIGKILL",
+        [TARGET_SIGSEGV] = "SIGSEGV",
+        [TARGET_SIGPIPE] = "SIGPIPE",
+        [TARGET_SIGALRM] = "SIGALRM",
+        [TARGET_SIGTERM] = "SIGTERM",
+        [TARGET_SIGUSR1] = "SIGUSR1",
+        [TARGET_SIGUSR2] = "SIGUSR2",
+        [TARGET_SIGCHLD] = "SIGCHLD",
+        [TARGET_SIGCONT] = "SIGCONT",
+        [TARGET_SIGSTOP] = "SIGSTOP",
+        [TARGET_SIGTTIN] = "SIGTTIN",
+        [TARGET_SIGTTOU] = "SIGTTOU",
+    };
+
+    if (sig >= 0 && sig < ARRAY_SIZE(signals) && signals[sig]) {
+        return snprintf(buf, size, "%s", signals[sig]);
+    } else {
+        return snprintf(buf, size, "%d", sig);
+    }
+}
+
 static void
 print_signal(abi_ulong arg, int last)
 {
-    const char *signal_name = NULL;
-    switch(arg) {
-    case TARGET_SIGHUP: signal_name = "SIGHUP"; break;
-    case TARGET_SIGINT: signal_name = "SIGINT"; break;
-    case TARGET_SIGQUIT: signal_name = "SIGQUIT"; break;
-    case TARGET_SIGILL: signal_name = "SIGILL"; break;
-    case TARGET_SIGABRT: signal_name = "SIGABRT"; break;
-    case TARGET_SIGFPE: signal_name = "SIGFPE"; break;
-    case TARGET_SIGKILL: signal_name = "SIGKILL"; break;
-    case TARGET_SIGSEGV: signal_name = "SIGSEGV"; break;
-    case TARGET_SIGPIPE: signal_name = "SIGPIPE"; break;
-    case TARGET_SIGALRM: signal_name = "SIGALRM"; break;
-    case TARGET_SIGTERM: signal_name = "SIGTERM"; break;
-    case TARGET_SIGUSR1: signal_name = "SIGUSR1"; break;
-    case TARGET_SIGUSR2: signal_name = "SIGUSR2"; break;
-    case TARGET_SIGCHLD: signal_name = "SIGCHLD"; break;
-    case TARGET_SIGCONT: signal_name = "SIGCONT"; break;
-    case TARGET_SIGSTOP: signal_name = "SIGSTOP"; break;
-    case TARGET_SIGTTIN: signal_name = "SIGTTIN"; break;
-    case TARGET_SIGTTOU: signal_name = "SIGTTOU"; break;
-    }
-    if (signal_name == NULL) {
-        print_raw_param("%ld", arg, last);
-        return;
-    }
-    gemu_log("%s%s", signal_name, get_comma(last));
+    char buf[16];
+    add_signal(buf, sizeof(buf), arg);
+    gemu_log("%s%s", buf, get_comma(last));
 }
 
 static void print_si_code(int arg)
@@ -2044,19 +2052,6 @@ print_futex(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_kill
-static void
-print_kill(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_raw_param("%d", arg0, 0);
-    print_signal(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_tkill
 static void
 print_tkill(const struct syscallname *name,
@@ -2190,6 +2185,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_ATDIRFD:
             len = add_atdirfd(b, rest, arg);
             break;
+        case ARG_SIGNAL:
+            len = add_signal(b, rest, arg);
+            break;
         case ARG_ACCESSFLAG:
             len = add_flags(b, rest, access_flags, arg, false);
             break;
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
index f4e43eb00e..a4fbcc567d 100644
--- a/linux-user/syscall-sig.inc.c
+++ b/linux-user/syscall-sig.inc.c
@@ -23,6 +23,11 @@ SYSCALL_IMPL(alarm)
 }
 #endif
 
+SYSCALL_IMPL(kill)
+{
+    return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
+}
+
 #ifdef TARGET_NR_pause
 SYSCALL_IMPL(pause)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d612dade23..3fe770890c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5391,8 +5391,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_kill:
-        return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
 #ifdef TARGET_NR_rename
     case TARGET_NR_rename:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 749bdce638..07e5f7c518 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -410,9 +410,6 @@
 #ifdef TARGET_NR_keyctl
 { TARGET_NR_keyctl, "keyctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_kill
-{ TARGET_NR_kill, "kill", NULL, print_kill, NULL },
-#endif
 #ifdef TARGET_NR_lchown
 { TARGET_NR_lchown, "lchown" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


