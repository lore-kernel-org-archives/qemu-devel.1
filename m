Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D0C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D0D20644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLv0hkHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D0D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSkm-0004Ux-8e
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:49:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZ2-0002w0-H5
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZ1-0003eK-0b
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:48 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZ0-0003d3-PM
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:46 -0400
Received: by mail-pf1-x444.google.com with SMTP id t87so6174984pfa.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=7G+hJOBDRTLscZajbGHATg460taQH3Fs6lhNe9/8aV8=;
	b=ZLv0hkHvVmH6uPLmeGbxpepwZtnAVJ+3cY9c+igY4+aqt97tKh2qUSiPiknzzu8V2T
	WWJNvbAzkGexTwZpF50G7d8qX97ibfQOkH5wBXWhWfVCr1gApdDEFiWE01ey4NR3qXuD
	Pfn0ta+knoaKPoEtRuTZMj7gWekCrwGVFXQlKzjErCMEep67iNDve+1PYlzbXi9KIDrd
	cgnVxvmPKJRu/UOMAKEqaNeiNnpMQIceJrccdddKdcrqpjlfa9bGhs4XUgkzaVRMBgbj
	d8tMg1FgaeU1PoRXkokoL11EZjXZVEV90pE800FTCCWnqFejL7hWHrowNXI9QbYt9aK2
	+gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=7G+hJOBDRTLscZajbGHATg460taQH3Fs6lhNe9/8aV8=;
	b=KilZTMJjPCjO+anpKgmeqAD4QOKaV8KCD7gmJ/PHxJubP4wynR8O1sZfTbuMWc09uF
	AF9c6b3xXzbYcUIYcx9aJkfhVFRp8HM1LCLdWNS6RXy3qh4II+STpGs4rUE89UsXIRu6
	L2Pe1Ae/ly2MnVogVqU69Ipi53U89PYBOqt7nu4X+VjQLvVxxmXwt/YJMVk+dqxQTiGn
	EGhn9wVtAuonrLF9Q2bNMRG56XX+cZGqo0uwPUDSZNJfWAalGu+O+IiENYMFjKsppCdc
	n8w+1MnpyAS09pgnIECI4EtHhsUDlugoBTJR20krMJjD1iU52P3Id9wfiZvaiN/kXkeG
	DXMw==
X-Gm-Message-State: APjAAAU02Jgo/xMvVr+E39rBaCDj6o6Ielb+3+FybT1r5dKMu7omS9B7
	DvWfcNczXeox0iCPxjBkJk/MCJHpEQE=
X-Google-Smtp-Source: APXvYqzgWGtl/7+ieQdpxG0oNJdCUxcKF+ljLNxJBfvFF5pPa5a0bFu42wn1Xc7rd/V6vedX3+hKig==
X-Received: by 2002:aa7:99dd:: with SMTP id v29mr77603622pfi.252.1558298264606;
	Sun, 19 May 2019 13:37:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:23 -0700
Message-Id: <20190519203726.20729-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v7 11/74] linux-user: Split out preadv, pwritev
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
 linux-user/syscall-defs.h     |  6 ++++
 linux-user/syscall-file.inc.c | 64 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 49 ---------------------------
 linux-user/strace.list        |  6 ----
 4 files changed, 70 insertions(+), 55 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 027793d5d0..ae89be0e87 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -27,6 +27,12 @@ SYSCALL_DEF_FULL(pread64, .impl = impl_pread64,
 SYSCALL_DEF_FULL(pwrite64, .impl = impl_pwrite64,
                  .args = args_pread64_pwrite64,
                  .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
+SYSCALL_DEF_FULL(preadv, .impl = impl_preadv,
+                 .args = args_preadv_pwritev,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
+SYSCALL_DEF_FULL(pwritev, .impl = impl_pwritev,
+                 .args = args_preadv_pwritev,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
 SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlink
 SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 43aa6eeeb8..61cfe2acb7 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -385,6 +385,70 @@ SYSCALL_IMPL(pwrite64)
     return ret;
 }
 
+/*
+ * Both preadv and pwritev merge args 4/5 into a 64-bit offset.
+ * Moreover, the parts are *always* in little-endian order.
+ */
+#if TARGET_ABI_BITS == 32
+SYSCALL_ARGS(preadv_pwritev)
+{
+    /* We have already assigned out[0-2].  */
+    abi_ulong lo = in[3], hi = in[4];
+    out[3] = (((uint64_t)hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
+    return def;
+}
+#else
+#define args_preadv_pwritev NULL
+#endif
+
+/* Perform the inverse operation for the host.  */
+static inline void host_offset64_low_high(unsigned long *l, unsigned long *h,
+                                          uint64_t off)
+{
+    *l = off;
+    *h = (off >> (HOST_LONG_BITS - 1)) >> 1;
+}
+
+SYSCALL_IMPL(preadv)
+{
+    int fd = arg1;
+    abi_ulong target_vec = arg2;
+    int count = arg3;
+    uint64_t off = arg4;
+    struct iovec *vec = lock_iovec(VERIFY_WRITE, target_vec, count, 0);
+    unsigned long lo, hi;
+    abi_long ret;
+
+    if (vec == NULL) {
+        return -TARGET_EFAULT;
+    }
+
+    host_offset64_low_high(&lo, &hi, off);
+    ret = get_errno(safe_preadv(fd, vec, count, lo, hi));
+    unlock_iovec(vec, target_vec, count, 1);
+    return ret;
+}
+
+SYSCALL_IMPL(pwritev)
+{
+    int fd = arg1;
+    abi_ulong target_vec = arg2;
+    int count = arg3;
+    uint64_t off = arg4;
+    struct iovec *vec = lock_iovec(VERIFY_READ, target_vec, count, 1);
+    unsigned long lo, hi;
+    abi_long ret;
+
+    if (vec == NULL) {
+        return -TARGET_EFAULT;
+    }
+
+    host_offset64_low_high(&lo, &hi, off);
+    ret = get_errno(safe_pwritev(fd, vec, count, lo, hi));
+    unlock_iovec(vec, target_vec, count, 0);
+    return ret;
+}
+
 SYSCALL_IMPL(read)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f636fb8bb3..817c4a7296 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2437,23 +2437,6 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
     return ret;
 }
 
-/* Convert target low/high pair representing file offset into the host
- * low/high pair. This function doesn't handle offsets bigger than 64 bits
- * as the kernel doesn't handle them either.
- */
-static void target_to_host_low_high(abi_ulong tlow,
-                                    abi_ulong thigh,
-                                    unsigned long *hlow,
-                                    unsigned long *hhigh)
-{
-    uint64_t off = tlow |
-        ((unsigned long long)thigh << TARGET_LONG_BITS / 2) <<
-        TARGET_LONG_BITS / 2;
-
-    *hlow = off;
-    *hhigh = (off >> HOST_LONG_BITS / 2) >> HOST_LONG_BITS / 2;
-}
-
 static struct iovec *lock_iovec(int type, abi_ulong target_addr,
                                 abi_ulong count, int copy)
 {
@@ -9005,38 +8988,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* NOTE: the flock constant seems to be the same for every
            Linux platform */
         return get_errno(safe_flock(arg1, arg2));
-#if defined(TARGET_NR_preadv)
-    case TARGET_NR_preadv:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
-            if (vec != NULL) {
-                unsigned long low, high;
-
-                target_to_host_low_high(arg4, arg5, &low, &high);
-                ret = get_errno(safe_preadv(arg1, vec, arg3, low, high));
-                unlock_iovec(vec, arg2, arg3, 1);
-            } else {
-                ret = -host_to_target_errno(errno);
-           }
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_pwritev)
-    case TARGET_NR_pwritev:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
-            if (vec != NULL) {
-                unsigned long low, high;
-
-                target_to_host_low_high(arg4, arg5, &low, &high);
-                ret = get_errno(safe_pwritev(arg1, vec, arg3, low, high));
-                unlock_iovec(vec, arg2, arg3, 0);
-            } else {
-                ret = -host_to_target_errno(errno);
-           }
-        }
-        return ret;
-#endif
     case TARGET_NR_getsid:
         return get_errno(getsid(arg1));
 #if defined(TARGET_NR_fdatasync) /* Not on alpha (osf_datasync ?) */
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a11ad3c3c7..f326613934 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1025,9 +1025,6 @@
 #ifdef TARGET_NR_prctl
 { TARGET_NR_prctl, "prctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_preadv
-{ TARGET_NR_preadv, "preadv" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_prlimit64
 { TARGET_NR_prlimit64, "prlimit64" , NULL, NULL, NULL },
 #endif
@@ -1052,9 +1049,6 @@
 #ifdef TARGET_NR_putpmsg
 { TARGET_NR_putpmsg, "putpmsg" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pwritev
-{ TARGET_NR_pwritev, "pwritev" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_query_module
 { TARGET_NR_query_module, "query_module" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


