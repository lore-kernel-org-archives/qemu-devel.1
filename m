Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8737C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC1F20644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kmei6DvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC1F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53262 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSkj-0004SB-Nh
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:49:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZ8-000395-AH
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZ6-0003kf-CI
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:54 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZ6-0003jY-42
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:52 -0400
Received: by mail-pl1-x642.google.com with SMTP id c5so5690537pll.11
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mCaCI2Aj5tC2IpfdxPu1UNH/KS+6aMoVb/BQvf6d4j4=;
	b=Kmei6DvMOhI+sXk4Bjs7SeJuH3jJYoD7ED4pYajTKSF/tghvhB/LFLnN1MZNmgGdpW
	tTGnhJvRO37FaGg4tWGT0unzkfueIqkyngEiUQkeE6vbg2TjPh3+rdujhZeluv0KzlFP
	kxD8Pbw3LM6yagoniOknL9d+ZfidIikCyKFk3BJxHT/EDixK/GvFcLXUgykk9q2GwSxC
	UVoYdMtQoDlk3dUCYvbPZKRUXfcfA3mhOBtZWbpIX6aHBgxzBEEQzH1GAgbp6digMePk
	GDFeqfa34hXbV8YaifR8UHw/U6vtn2Twma/dnYxXYsji9jChZ3o3JXnlpZuyhBV3dtLz
	Vg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mCaCI2Aj5tC2IpfdxPu1UNH/KS+6aMoVb/BQvf6d4j4=;
	b=sPrOEMa7SFglPf84Nch8QGqDyfvKmpOXG1a1PU/L3OukWYjrrhZQg/DQ0a4nWUor3m
	76yHqtEiDplu2VeJeJnqiD7IhD/zDP2Ll9wBGSFmG7IZCGoW1nqVzg4sg1CJ0yryaEjx
	5nXsCrIa/HlBtnbx1yIRpK/vmJSdos60hwoDXjW1jNdo0EuflyVuyZ8bxtz/jIqaceMt
	1nPX8p/rmR3huxgBR7sZjkyAYlNtM/qd2TcphFxZPsXBcWurEkwOUbaZBHuN01N5G7dd
	UX7inOieZYXdzvaTEfzq32knUAjIE+v0EcDQng8Ear6oNiXdMUVqQLPCRj5ZhC6yateF
	OKew==
X-Gm-Message-State: APjAAAVVUO/XJaS85ilSEn+rir/h7C7QuUo5VuY9I5/9a6dEF8HzktO4
	Qoj8e0prXgC2XIXqbo3eQy+/wbSa9dA=
X-Google-Smtp-Source: APXvYqziRbqHqaagx1ucYz4rcZFqBUBHu2fMiu2dTNkb/Zy2cQZjvvAObU8FP3QnCcHELMRYWde8HA==
X-Received: by 2002:a17:902:2bc9:: with SMTP id
	l67mr35897710plb.171.1558298270873; 
	Sun, 19 May 2019 13:37:50 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:28 -0700
Message-Id: <20190519203726.20729-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 16/74] linux-user: Split out brk
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
 linux-user/syscall-defs.h    |  3 ++
 linux-user/strace.c          | 35 --------------
 linux-user/syscall-mem.inc.c | 90 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c         | 93 ------------------------------------
 linux-user/strace.list       |  3 --
 5 files changed, 93 insertions(+), 131 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 88aa1a6bfd..c3ed22ff16 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -16,6 +16,9 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+SYSCALL_DEF_FULL(brk, .impl = impl_brk,
+                 .print_ret = print_syscall_ptr_ret,
+                 .arg_type = { ARG_PTR });
 SYSCALL_DEF(close, ARG_DEC);
 SYSCALL_DEF(exit, ARG_DEC);
 #ifdef TARGET_NR_ipc
diff --git a/linux-user/strace.c b/linux-user/strace.c
index a767227ac1..0a2c6764db 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -604,29 +604,6 @@ print_execve(const struct syscallname *name,
  * Variants for the return value output function
  */
 
-static void
-print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
-{
-    const char *errstr = NULL;
-
-    if (ret < 0) {
-        errstr = target_strerror(-ret);
-    }
-    if (errstr) {
-        gemu_log(" = -1 errno=%d (%s)\n", (int)-ret, errstr);
-    } else {
-        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
-    }
-}
-
-#if 0 /* currently unused */
-static void
-print_syscall_ret_raw(struct syscallname *name, abi_long ret)
-{
-        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
-}
-#endif
-
 #ifdef TARGET_NR__newselect
 static void
 print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
@@ -1168,18 +1145,6 @@ print_access(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_brk
-static void
-print_brk(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_pointer(arg0, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_chdir
 static void
 print_chdir(const struct syscallname *name,
diff --git a/linux-user/syscall-mem.inc.c b/linux-user/syscall-mem.inc.c
index d2ce0cb8cc..17ba8e3d97 100644
--- a/linux-user/syscall-mem.inc.c
+++ b/linux-user/syscall-mem.inc.c
@@ -42,6 +42,96 @@ static bitmask_transtbl const mmap_flags_tbl[] = {
     { 0, 0, 0, 0 }
 };
 
+static abi_ulong target_brk;
+static abi_ulong target_original_brk;
+static abi_ulong brk_page;
+
+void target_set_brk(abi_ulong new_brk)
+{
+    target_original_brk = target_brk = HOST_PAGE_ALIGN(new_brk);
+    brk_page = HOST_PAGE_ALIGN(target_brk);
+}
+
+/* do_brk() must return target values and target errnos. */
+abi_long do_brk(abi_ulong new_brk)
+{
+    abi_long mapped_addr;
+    abi_ulong new_alloc_size;
+
+    if (!new_brk) {
+        return target_brk;
+    }
+    if (new_brk < target_original_brk) {
+        return target_brk;
+    }
+
+    /*
+     * If the new brk is less than the highest page reserved to the
+     * target heap allocation, set it and we're almost done...
+     */
+    if (new_brk <= brk_page) {
+        /*
+         * Heap contents are initialized to zero,
+         * as for anonymous mapped pages.
+         */
+        if (new_brk > target_brk) {
+            memset(g2h(target_brk), 0, new_brk - target_brk);
+        }
+        target_brk = new_brk;
+        return target_brk;
+    }
+
+    /*
+     * We need to allocate more memory after the brk... Note that
+     * we don't use MAP_FIXED because that will map over the top of
+     * any existing mapping (like the one with the host libc or qemu
+     * itself); instead we treat "mapped but at wrong address" as
+     * a failure and unmap again.
+     */
+    new_alloc_size = HOST_PAGE_ALIGN(new_brk - brk_page);
+    mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
+                                        PROT_READ | PROT_WRITE,
+                                        MAP_ANON | MAP_PRIVATE, 0, 0));
+
+    if (mapped_addr == brk_page) {
+        /*
+         * Heap contents are initialized to zero, as for anonymous
+         * mapped pages.  Technically the new pages are already
+         * initialized to zero since they *are* anonymous mapped
+         * pages, however we have to take care with the contents that
+         * come from the remaining part of the previous page: it may
+         * contains garbage data due to a previous heap usage (grown
+         * then shrunken).
+         */
+        memset(g2h(target_brk), 0, brk_page - target_brk);
+
+        target_brk = new_brk;
+        brk_page = HOST_PAGE_ALIGN(target_brk);
+        return target_brk;
+    } else if (mapped_addr != -1) {
+        /*
+         * Mapped but at wrong address, meaning there wasn't actually
+         * enough space for this brk.
+         */
+        target_munmap(mapped_addr, new_alloc_size);
+        mapped_addr = -1;
+    }
+
+#if defined(TARGET_ALPHA)
+    /*
+     * We (partially) emulate OSF/1 on Alpha, which requires we
+     * return a proper errno, not an unchanged brk value.
+     */
+    return -TARGET_ENOMEM;
+#endif
+    /* For everything else, return the previous break. */
+    return target_brk;
+}
+
+SYSCALL_IMPL(brk)
+{
+    return do_brk(arg1);
+}
 
 SYSCALL_IMPL(mlock)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c72d24aa76..4c9953a7ab 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -820,97 +820,6 @@ static inline int host_to_target_sock_type(int host_type)
     return target_type;
 }
 
-static abi_ulong target_brk;
-static abi_ulong target_original_brk;
-static abi_ulong brk_page;
-
-void target_set_brk(abi_ulong new_brk)
-{
-    target_original_brk = target_brk = HOST_PAGE_ALIGN(new_brk);
-    brk_page = HOST_PAGE_ALIGN(target_brk);
-}
-
-//#define DEBUGF_BRK(message, args...) do { fprintf(stderr, (message), ## args); } while (0)
-#define DEBUGF_BRK(message, args...)
-
-/* do_brk() must return target values and target errnos. */
-abi_long do_brk(abi_ulong new_brk)
-{
-    abi_long mapped_addr;
-    abi_ulong new_alloc_size;
-
-    DEBUGF_BRK("do_brk(" TARGET_ABI_FMT_lx ") -> ", new_brk);
-
-    if (!new_brk) {
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (!new_brk)\n", target_brk);
-        return target_brk;
-    }
-    if (new_brk < target_original_brk) {
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (new_brk < target_original_brk)\n",
-                   target_brk);
-        return target_brk;
-    }
-
-    /* If the new brk is less than the highest page reserved to the
-     * target heap allocation, set it and we're almost done...  */
-    if (new_brk <= brk_page) {
-        /* Heap contents are initialized to zero, as for anonymous
-         * mapped pages.  */
-        if (new_brk > target_brk) {
-            memset(g2h(target_brk), 0, new_brk - target_brk);
-        }
-	target_brk = new_brk;
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (new_brk <= brk_page)\n", target_brk);
-	return target_brk;
-    }
-
-    /* We need to allocate more memory after the brk... Note that
-     * we don't use MAP_FIXED because that will map over the top of
-     * any existing mapping (like the one with the host libc or qemu
-     * itself); instead we treat "mapped but at wrong address" as
-     * a failure and unmap again.
-     */
-    new_alloc_size = HOST_PAGE_ALIGN(new_brk - brk_page);
-    mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
-                                        PROT_READ|PROT_WRITE,
-                                        MAP_ANON|MAP_PRIVATE, 0, 0));
-
-    if (mapped_addr == brk_page) {
-        /* Heap contents are initialized to zero, as for anonymous
-         * mapped pages.  Technically the new pages are already
-         * initialized to zero since they *are* anonymous mapped
-         * pages, however we have to take care with the contents that
-         * come from the remaining part of the previous page: it may
-         * contains garbage data due to a previous heap usage (grown
-         * then shrunken).  */
-        memset(g2h(target_brk), 0, brk_page - target_brk);
-
-        target_brk = new_brk;
-        brk_page = HOST_PAGE_ALIGN(target_brk);
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (mapped_addr == brk_page)\n",
-            target_brk);
-        return target_brk;
-    } else if (mapped_addr != -1) {
-        /* Mapped but at wrong address, meaning there wasn't actually
-         * enough space for this brk.
-         */
-        target_munmap(mapped_addr, new_alloc_size);
-        mapped_addr = -1;
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (mapped_addr != -1)\n", target_brk);
-    }
-    else {
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (otherwise)\n", target_brk);
-    }
-
-#if defined(TARGET_ALPHA)
-    /* We (partially) emulate OSF/1 on Alpha, which requires we
-       return a proper errno, not an unchanged brk value.  */
-    return -TARGET_ENOMEM;
-#endif
-    /* For everything else, return the previous break. */
-    return target_brk;
-}
-
 static inline abi_long copy_from_user_fdset(fd_set *fds,
                                             abi_ulong target_fds_addr,
                                             int n)
@@ -5681,8 +5590,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_brk:
-        return do_brk(arg1);
 #ifdef TARGET_NR_fork
     case TARGET_NR_fork:
         return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
diff --git a/linux-user/strace.list b/linux-user/strace.list
index cc0bb10a7a..aff6d1d73d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -49,9 +49,6 @@
 #ifdef TARGET_NR_break
 { TARGET_NR_break, "break" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_brk
-{ TARGET_NR_brk, "brk" , NULL, print_brk, print_syscall_ret_addr },
-#endif
 #ifdef TARGET_NR_cachectl
 { TARGET_NR_cachectl, "cachectl" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


