Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3D6C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18653206BF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8gqlqku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18653206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53983 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTSq-0002Kk-8h
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:35:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa9-000464-7u
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa7-00053u-V8
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:57 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:32993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSa7-00053D-Mr
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:55 -0400
Received: by mail-pf1-x443.google.com with SMTP id z28so6189204pfk.0
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=OxzuqNW/UFIgrfGQ+3fG4I/RITK819AGJzrnscRZcbA=;
	b=I8gqlqkuGq0N6crXd3nyY2kU5jfyEDab7KvBndm9AouProIG005uLWbKDgldeojNuy
	xV9jwzOtUvS6HgJP+st5Dvs6lVuQIhwY3j75LcCgqtxO+yQPA0srcltvknFkUBw8qml1
	nLXVVQN7NilIZRk2oK+JliyKclsb+s7sODvdDFPl9ycq6N6GwTRC/rUU4kXW3sWsb3gM
	CwHXhkYoJkL3QbAniRCjKs4FBm9GCMuaaA5upIpjeP2rbuetsi9NV3Xr+EhTIhiHZd6a
	G4/i9dZ7sILCyufM1VmrLpjgFth45cQrBEekOLEnRbd5GkScZ5hI1p0gVYvUPYKfXhOW
	ccZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=OxzuqNW/UFIgrfGQ+3fG4I/RITK819AGJzrnscRZcbA=;
	b=nqU0Rdjq8fGELluz3fv7hLujknN6V9sIKc/EeAfftxcl1TVPDI1+BW1GrikEN+XRgZ
	VQPgzBKTRudoU4RPpOKEBUxJ3ECFXnEdhyCMhDSNVO/yXq3lXSuG8h+REai0TygY3Ojs
	MLzz6SFRPl3cgzVs98lXGxyty6nFkZ19KoUcDFXhDQdfQHDkB9hymL6/HaKEcMdBo2hQ
	w/FUIGm3SXG2CEqWdc5nxd02pHJn81B+1l7xWtrjmXdWixeQGhRKhjHQcvG/4yLmo4eK
	Jb6MPAq2yD07f8jsEcYS+jywq/rua0LLEhMOPeQMjoqtzhZaXvuwtHJF2zc+KCtG3Jto
	NP0g==
X-Gm-Message-State: APjAAAXfNSNIMcVUm/4oB/aTVyGtgqQWO+LJiFtkuS7XmOLScvBrf03X
	twnGWr2LlgivRI8X+ParVnpAqmRBZGE=
X-Google-Smtp-Source: APXvYqxHkryZgQ0seLFwW9zU8DsM3NK0C0gwxQm9KC3TN8uM4nVouBzD8F8+pRD0jT/wMHIHb65kAQ==
X-Received: by 2002:a62:4281:: with SMTP id h1mr76217177pfd.162.1558298334457; 
	Sun, 19 May 2019 13:38:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:21 -0700
Message-Id: <20190519203726.20729-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 69/74] linux-user: Split out pselect6
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
 linux-user/syscall-defs.h     |   1 +
 linux-user/syscall-file.inc.c |  96 +++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 103 ----------------------------------
 linux-user/strace.list        |   3 -
 4 files changed, 97 insertions(+), 106 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 01143414c7..c179f69d9f 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -180,6 +180,7 @@ SYSCALL_DEF_FULL(preadv, .impl = impl_preadv,
 SYSCALL_DEF_FULL(pwritev, .impl = impl_pwritev,
                  .args = args_preadv_pwritev,
                  .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
+SYSCALL_DEF(pselect6, ARG_DEC, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlink
 SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 1d66dc3323..0a25d39d28 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -934,6 +934,102 @@ SYSCALL_IMPL(pwritev)
     return ret;
 }
 
+SYSCALL_IMPL(pselect6)
+{
+    abi_long n = arg1;
+    abi_ulong rfd_addr = arg2;
+    abi_ulong wfd_addr = arg3;
+    abi_ulong efd_addr = arg4;
+    abi_ulong ts_addr = arg5;
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    struct timespec ts, *ts_ptr = NULL;
+    abi_long ret;
+
+    /*
+     * The 6th arg is actually two args smashed together, and since
+     * we are using safe_syscall, we must handle this ourselves.
+     */
+    sigset_t set;
+    struct {
+        sigset_t *set;
+        size_t size;
+    } sig, *sig_ptr = NULL;
+
+    abi_ulong arg_sigset, arg_sigsize, *arg7;
+    target_sigset_t *target_sigset;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (ret) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (ret) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (ret) {
+        return ret;
+    }
+
+    if (ts_addr) {
+        if (target_to_host_timespec(&ts, ts_addr)) {
+            return -TARGET_EFAULT;
+        }
+        ts_ptr = &ts;
+    }
+
+    /* Extract the two packed args for the sigset */
+    if (arg6) {
+        sig_ptr = &sig;
+        sig.size = SIGSET_T_SIZE;
+
+        arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
+        if (!arg7) {
+            return -TARGET_EFAULT;
+        }
+        arg_sigset = tswapal(arg7[0]);
+        arg_sigsize = tswapal(arg7[1]);
+        unlock_user(arg7, arg6, 0);
+
+        if (arg_sigset) {
+            sig.set = &set;
+            if (arg_sigsize != sizeof(*target_sigset)) {
+                /* Like the kernel, we enforce correct size sigsets */
+                return -TARGET_EINVAL;
+            }
+            target_sigset = lock_user(VERIFY_READ, arg_sigset,
+                                      sizeof(*target_sigset), 1);
+            if (!target_sigset) {
+                return -TARGET_EFAULT;
+            }
+            target_to_host_sigset(&set, target_sigset);
+            unlock_user(target_sigset, arg_sigset, 0);
+        } else {
+            sig.set = NULL;
+        }
+    }
+
+    ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
+                                  ts_ptr, sig_ptr));
+
+    if (!is_error(ret)) {
+        if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 SYSCALL_IMPL(read)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2c8d74a450..6355fd62d8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4158,109 +4158,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_pselect6
-    case TARGET_NR_pselect6:
-        {
-            abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
-            fd_set rfds, wfds, efds;
-            fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
-            struct timespec ts, *ts_ptr;
-
-            /*
-             * The 6th arg is actually two args smashed together,
-             * so we cannot use the C library.
-             */
-            sigset_t set;
-            struct {
-                sigset_t *set;
-                size_t size;
-            } sig, *sig_ptr;
-
-            abi_ulong arg_sigset, arg_sigsize, *arg7;
-            target_sigset_t *target_sigset;
-
-            n = arg1;
-            rfd_addr = arg2;
-            wfd_addr = arg3;
-            efd_addr = arg4;
-            ts_addr = arg5;
-
-            ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
-            if (ret) {
-                return ret;
-            }
-            ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
-            if (ret) {
-                return ret;
-            }
-            ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
-            if (ret) {
-                return ret;
-            }
-
-            /*
-             * This takes a timespec, and not a timeval, so we cannot
-             * use the do_select() helper ...
-             */
-            if (ts_addr) {
-                if (target_to_host_timespec(&ts, ts_addr)) {
-                    return -TARGET_EFAULT;
-                }
-                ts_ptr = &ts;
-            } else {
-                ts_ptr = NULL;
-            }
-
-            /* Extract the two packed args for the sigset */
-            if (arg6) {
-                sig_ptr = &sig;
-                sig.size = SIGSET_T_SIZE;
-
-                arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
-                if (!arg7) {
-                    return -TARGET_EFAULT;
-                }
-                arg_sigset = tswapal(arg7[0]);
-                arg_sigsize = tswapal(arg7[1]);
-                unlock_user(arg7, arg6, 0);
-
-                if (arg_sigset) {
-                    sig.set = &set;
-                    if (arg_sigsize != sizeof(*target_sigset)) {
-                        /* Like the kernel, we enforce correct size sigsets */
-                        return -TARGET_EINVAL;
-                    }
-                    target_sigset = lock_user(VERIFY_READ, arg_sigset,
-                                              sizeof(*target_sigset), 1);
-                    if (!target_sigset) {
-                        return -TARGET_EFAULT;
-                    }
-                    target_to_host_sigset(&set, target_sigset);
-                    unlock_user(target_sigset, arg_sigset, 0);
-                } else {
-                    sig.set = NULL;
-                }
-            } else {
-                sig_ptr = NULL;
-            }
-
-            ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
-                                          ts_ptr, sig_ptr));
-
-            if (!is_error(ret)) {
-                if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n))
-                    return -TARGET_EFAULT;
-                if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n))
-                    return -TARGET_EFAULT;
-                if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
-                    return -TARGET_EFAULT;
-
-                if (ts_addr && host_to_target_timespec(ts_addr, &ts))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_symlink
     case TARGET_NR_symlink:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 297180d94f..1bb9224b5e 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -848,9 +848,6 @@
 #ifdef TARGET_NR_profil
 { TARGET_NR_profil, "profil" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pselect6
-{ TARGET_NR_pselect6, "pselect6" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_ptrace
 { TARGET_NR_ptrace, "ptrace" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


